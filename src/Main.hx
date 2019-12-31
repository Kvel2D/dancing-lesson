
import haxegon.*;
import haxe.ds.Vector;

using haxegon.MathExtensions;
using Lambda;

@:publicFields
class Main {
// force unindent

static inline var SCREEN_SIZE = 200;
static inline var SCALE = 4;
static inline var GRAPH_MAX_SIZE = 1000;

var group_ids: Array<Int>;
var group_colors: Array<Int>;
var group_edges: Array<Int>;
var weights: Array<Array<Float>>;
var tethered: Array<Array<Bool>>;
var positions: Array<Vec2f>;
var active: Array<Bool>;
var colors: Array<Int>;
var edge_length = 40;
var choice_colors: Array<Int>;
var paused: Bool;
var groups: Array<Array<Int>>;
var selected: Int;
var menu = true;
var trace_mode = false;

function new() {
    Gfx.resizescreen(SCREEN_SIZE * SCALE, SCREEN_SIZE * SCALE);
    Gfx.createimage('canvas', SCREEN_SIZE, SCREEN_SIZE);
    Gfx.line_thickness = 5;

    reset();
}

function reset() {
    choice_colors = [Col.GRAY, Col.WHITE, Col.RED, Col.PINK, Col.DARKBROWN, Col.BROWN, Col.ORANGE, Col.YELLOW, Col.DARKGREEN, Col.GREEN, Col.LIGHTGREEN, Col.NIGHTBLUE, Col.DARKBLUE, Col.BLUE, Col.LIGHTBLUE];
    Random.shuffle(choice_colors);

    paused = false;

    colors = [for (i in 0...GRAPH_MAX_SIZE) Col.MAGENTA];
    active = [for (i in 0...GRAPH_MAX_SIZE) false];
    group_ids = [for (i in 0...GRAPH_MAX_SIZE) 0];
    positions = [for (i in 0...GRAPH_MAX_SIZE) {x: 100.0, y: 100.0} ];
    weights = Data.create2darray(GRAPH_MAX_SIZE, GRAPH_MAX_SIZE, 0.0);
    groups = new Array<Array<Int>>();
    group_colors = new Array<Int>();
    group_edges = new Array<Int>();
    selected = 0;
}

function resize_group(group: Int, new_size: Int) {
    var current_indices = groups[group];

    var center = {x: 0.0, y: 0.0};

    var indices = groups[group];
    for (i in indices) {
        active[i] = false;
        group_ids[i] = 0;

        center.x += positions[i].x;
        center.y += positions[i].y;
    }

    center.x /= indices.length;
    center.y /= indices.length;

    activate_section(new_size, group_colors[group], center.x, center.y, group);
}

function activate_section(count: Int, color: Int, x: Float, y: Float, existing_group = -1) {
    var indices = new Array<Int>();
    for (i in 0...GRAPH_MAX_SIZE) {
        if (!active[i]) {
            indices.push(i);
            count--;

            if (count < 0) {
                break;
            }
        }
    }

    for (i in indices) {
        active[i] = true;
        colors[i] = color;
        positions[i] = {
            x: x + Random.float(-10, 10),
            y: y + Random.float(-10, 10)
        };
    }
    interconnect(indices);

    var group_id: Int;

    if (existing_group == -1) {
        groups.push(indices);
        group_colors.push(color);
        group_edges.push(40);

        group_id = groups.length - 1;
    } else {
        groups[existing_group] = indices;

        group_id = existing_group;
    }

    for (i in indices) {
        group_ids[i] = group_id;
    }
}

// TODO: limit possible mouse input to be padded a bit from border
function interconnect(indices: Array<Int>) {
    var indices_copy = [for (i in 0...indices.length) indices[i]];

    // Reset weights
    for (i in indices) {
        for (j in indices) {
            weights[i][j] = 0.0;
            weights[j][i] = 0.0;
        }
    }

    for (i in indices) {
        var friendliness = 2.0;
        var weak_count = Random.int(1, Math.round(indices.length * 0.16 * friendliness));
        var mid_count = Random.int(1, Math.round(indices.length * 0.08 * friendliness));
        var strong_count = Random.int(1, Math.round(indices.length * 0.04 * friendliness));

        Random.shuffle(indices_copy);
        for (j in 0...weak_count) {
            if (j == i) {
                continue;
            }
            weights[i][indices_copy[j]] = Math.pow(Random.float(0.0, 0.1), 20);
        }

        Random.shuffle(indices_copy);
        for (j in 0...mid_count) {
            if (j == i) {
                continue;
            }
            weights[i][indices_copy[j]] = Math.pow(Random.float(0.1, 0.4), 10);
        }

        Random.shuffle(indices_copy);
        for (j in 0...strong_count) {
            if (j == i) {
                continue;
            }
            weights[i][indices_copy[j]] = Math.pow(Random.float(0.4, 1.0), 5);
        }
    }

    // Make weights equal in both directions
    for (i in indices) {
        for (j in indices) {
            weights[i][j] = weights[j][i];
        }
    }
}

function update_graph() {
    for (i in 0...GRAPH_MAX_SIZE) {
        if (!active[i]) {
            continue;
        }
        
        var p = {x: positions[i].x, y: positions[i].y};

        for (j in 0...GRAPH_MAX_SIZE) {
            if (i == j || !active[j]) {
                continue;
            }

            // Attract/repulse to reach target distance
            // Distance is closer if connection is stronger
            var w = weights[i][j];
            var other = positions[j];
            var my_group = group_ids[i];
            var other_group = group_ids[j];
            var same_group = (my_group == other_group);

            var edge = if (same_group) {
                group_edges[my_group];
            } else {
                edge_length;
            }
            var dst = Math.dst(p.x, p.y, other.x, other.y);

            var target_dst = Math.pow(1.0 - w, 2) * edge;

            

            if (dst < target_dst || same_group) {
                var angle = Math.atan2(p.y - other.y, p.x - other.x);

                p.x += Math.cos(angle) * (target_dst - dst) / 10;
                p.y += Math.sin(angle) * (target_dst - dst) / 10;
            }
        }

        // Limit to within screen
        if (p.x < 0) {
            p.x = 0;
        }
        if (p.x > SCREEN_SIZE - 1) {
            p.x = SCREEN_SIZE - 1;
        }
        if (p.y < 0) {
            p.y = 0;
        }
        if (p.y > SCREEN_SIZE - 1) {
            p.y = SCREEN_SIZE - 1;
        }

        positions[i] = p;
    }
}

function render_graph() {
    Gfx.drawtoimage('canvas');
    if (!trace_mode) {
        Gfx.fillbox(0, 0, SCREEN_SIZE, SCREEN_SIZE, Col.BLACK);
    }
    for (i in 0...GRAPH_MAX_SIZE) {
        if (!active[i]) {
            continue;
        }

        var p = positions[i];
        Gfx.set_pixel(p.x, p.y, colors[i]);
    }
    Gfx.drawtoscreen();
    Gfx.drawimage(0, 0, 'canvas');
}

function update() {
    if (Input.justpressed(Key.SPACE)) {
        paused = !paused;
    }

    if (Input.justpressed(Key.M)) {
        menu = !menu;
    }

    if (Input.justpressed(Key.T)) {
        trace_mode = !trace_mode;
    }

    if (Mouse.rightclick()) {
        // Spawn new group on click
        var spawn_x = Math.round(Mouse.x / SCALE);
        var spawn_y = Math.round(Mouse.y / SCALE);
        if (spawn_x < 10) {
            spawn_x = 10;
        }
        if (spawn_x > SCREEN_SIZE - 10) {
            spawn_x = SCREEN_SIZE - 10;
        }
        if (spawn_y < 10) {
            spawn_y = 10;
        }
        if (spawn_y > SCREEN_SIZE - 10) {
            spawn_y = SCREEN_SIZE - 10;
        }

        activate_section(30, choice_colors.pop(), spawn_x, spawn_y);
    }

    if (Input.delaypressed(Key.LEFT, 5)) {
        if (selected <= 0) {
            selected = group_colors.length - 1;
        } else {
            selected--;
        }
    }
    if (Input.delaypressed(Key.RIGHT, 5)) {
        if (selected >= group_colors.length - 1) {
            selected = 0;
        } else {
            selected++;
        }
    }

    Gfx.scale(4, 4);
    if (!paused) {
        update_graph();
    }
    render_graph();

    var x = 0;
    var y = 0;
    var box_size = 40;
    for (i in 0...group_colors.length) {
        Gfx.fillbox(x, y, box_size, box_size, group_colors[i]);
        if (selected == i) {
            Gfx.drawbox(x, y, box_size, box_size, Col.MAGENTA);
        }
        x += box_size;
    }

    if (menu) {
        GUI.x = 0;
        GUI.y = 50;
        GUI.auto_slider('personal space', function(x) {edge_length = Std.int(x);}, edge_length, 0, 100, 20, 200);

        if (groups.length > 0) {
            GUI.auto_slider('group space', function(x) {group_edges[selected] = Std.int(x);}, group_edges[selected], 0, 300, 20, 200);
            GUI.auto_slider('group size', function(x) {resize_group(selected, Math.floor(x));}, groups[selected].length, 0, 100, 20, 200);
        }
    }
}

}
