// Wired camera common settings

include <xc_common.scad>

// First structure bracket is built right-side up
wc_bracket1_placement = [0, 0, flange_h + bracket_ring_h];
wc_bracket1_rotation = [0, 0, 0];

// There are 4 long supports between the 2 brackets
support_r = 3.2 - bracket_r;
support_angle = 28;
support_size = [support_h, 9, 5];
function support_placement(angle) = [support_r * cos(angle), - support_r * sin(angle),
      flange_h + support_h / 2 + 2 * bracket_ring_h];

support1_angle = 180 - support_angle;
support1_placement = support_placement(support1_angle);
support1_rotation = [support1_angle, 90, 0];

support2_angle = 180 + support_angle;
support2_placement = support_placement(support2_angle);
support2_rotation = [support2_angle, 90, 0];

support3_angle = 0 - support_angle;
support3_placement = support_placement(support3_angle);
support3_rotation = [support3_angle, 90, 180];

support4_angle = 0 + support_angle;
support4_placement = support_placement(support4_angle);
support4_rotation = [support4_angle, 90, 180];

function support_y_offset(angle) = - sign(sin(angle)) * 1.5;
function support_dir(angle) = - sign(tan(angle));

// Second bracket is also built upside down
wc_bracket2_placement = [0, 0, flange_h + support_h + 3 * bracket_ring_h];
wc_bracket2_rotation = [180, 0, 0];

// Holes to connect the 2 brackets
support_hole_r = (bracket_r + interior_r) / 2;
connect_holes = [for (a = [support1_angle, support2_angle, support3_angle, support4_angle])
  [- cos(a) * support_hole_r, - sin(a) * support_hole_r]];

// Proto board is the same size as the pi zero pcb, and sits across from the pi zero
proto_adj = 8;
proto_placement = [- 17, 0, flange_h + bracket_ring_h + support_h / 2 + pi_adj];
proto_rotation = [0, 90, 0];
