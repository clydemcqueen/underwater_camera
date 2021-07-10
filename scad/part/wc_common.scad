// Wired camera common settings

include <common.scad>

// First structure bracket is built right-side up
wc_bracket1_placement = [0, 0, flange_h + bracket_ring_h];
wc_bracket1_rotation = [0, 0, 0];

// There are 4 long supports between the 2 brackets
support_r = 3.2 - bracket_r;
support_size = [support_h, 8, 5];
function support_placement(angle) = [support_r * cos(angle), - support_r * sin(angle),
      flange_h + support_h / 2 + 2 * bracket_ring_h];

support1_angle = 180 - 28;
support1_y_offset = - 1.5;
support1_placement = support_placement(support1_angle);
support1_rotation = [support1_angle, 90, 0];

support2_angle = 180 + 28;
support2_y_offset = 1.5;
support2_placement = support_placement(support2_angle);
support2_rotation = [support2_angle, 90, 0];

support3_angle = 0 - 28;
support3_y_offset = 1.5;
support3_placement = support_placement(support3_angle);
support3_rotation = [support3_angle, 90, 180];

support4_angle = 0 + 28;
support4_y_offset = - 1.5;
support4_placement = support_placement(support4_angle);
support4_rotation = [support4_angle, 90, 180];

// Second structure bracket is also built upside down
wc_bracket2_placement = [0, 0, flange_h + support_h + 3 * bracket_ring_h];
wc_bracket2_rotation = [180, 0, 0];

// Holes to connect the 2 brackets
support_hole_r = (bracket_r + interior_r) / 2;
connect_holes = [for (a = [support1_angle, support2_angle, support3_angle, support4_angle])
  [- cos(a) * support_hole_r, - sin(a) * support_hole_r]];

// Place the parts into the structure, starting with the camera
// The camera has a wide-angle lens, so it sits pretty deep in the flange
camera_placement = [cam_center_point.x, cam_center_point.y, cam_center_point.z + 6];
camera_rotation = [0, 0, 0];

// The pi zero is placed so that a short ribbon cable will reach the camera
pi_adj = 8;
pi_placement = [17, 0, flange_h + bracket_ring_h + support_h / 2 + pi_adj];
pi_rotation = [0, 90, 180];

// Proto board is the same size as the pi zero pcb, and sits across from the pi zero
proto_adj = 8;
proto_placement = [- 17, 0, flange_h + bracket_ring_h + support_h / 2 + pi_adj];
proto_rotation = [0, 90, 0];
