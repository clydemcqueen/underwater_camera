// Wired camera v2 common settings

include <xc_common.scad>
include <../vitamin/pi_zero.scad>

w2_bracket_placement = [0, 0, flange_h + bracket_ring_h];
w2_bracket_rotation = [0, 0, 0];

// Adafruit M2.5 nylon standoff
w2_standoff = 11.9;

// Proto board is the same size as the pi zero pcb, and sits across from the pi zero
proto_adj = 8;
proto_placement = [pi_placement.x - pi_z - w2_standoff, 0,
        flange_h + bracket_ring_h + support_h / 2 + pi_adj];
proto_rotation = [0, 90, 180];
