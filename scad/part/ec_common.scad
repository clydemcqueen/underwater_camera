// Battery-powered camera common settings

include <xc_common.scad>

include <../vitamin/adafruit.scad>
include <../vitamin/blue_robotics.scad>
include <../vitamin/pi_camera.scad>

// First structure bracket is built right-side up
ec_bracket1_placement = [0, 0, flange_h + bracket_ring_h];
ec_bracket1_rotation = [0, 0, 0];

// There are 3 long supports between the 2 structure brackets
support_r = 3.2 - bracket_r;
support1_size = [support_h, 8, 5];
support1_angle = 180 - 28;
support1_y_offset = - 1.5;
support1_placement = [support_r * cos(support1_angle), - support_r * sin(support1_angle),
      flange_h + support_h / 2 + 2 * bracket_ring_h];
support1_rotation = [support1_angle, 90, 0];

support2_size = [support_h, 8, 5];
support2_angle = 180 + 28;
support2_y_offset = 1.5;
support2_placement = [support_r * cos(support2_angle), - support_r * sin(support2_angle),
      flange_h + support_h / 2 + 2 * bracket_ring_h];
support2_rotation = [support2_angle, 90, 0];

support3_size = [support_h, 7, 5];
support3_angle = 20;
support3_placement = [support_r * cos(support3_angle), - support_r * sin(support3_angle),
      flange_h + support_h / 2 + 2 * bracket_ring_h];
support3_rotation = [support3_angle, 90, 0];

// Second structure bracket is also built upside down
ec_bracket2_placement = [0, 0, flange_h + support_h + 3 * bracket_ring_h];
ec_bracket2_rotation = [180, 0, 0];

// Holes to connect the 2 structure brackets
support_hole_r = (bracket_r + interior_r) / 2;
connect_holes = [for (a = [support1_angle, support2_angle, support3_angle])
  [- cos(a) * support_hole_r, - sin(a) * support_hole_r]];

// Place the parts into the structure, starting with the camera
// The camera has a wide-angle lens, so it sits pretty deep in the flange
camera_placement = [cam_center_point.x, cam_center_point.y, cam_center_point.z + 6];
camera_rotation = [0, 0, 0];

// The pi is placed so that a short ribbon cable will reach the camera
pi_adj = 8;
pi_placement = [17, 0, flange_h + bracket_ring_h + support_h / 2 + pi_adj];
pi_rotation = [0, 90, 180];

// Place the battery
battery_placement = [0, 16, 32];
battery_rotation = [0, 0, 0];
battery_well_angle = 55;
battery_well_clip = 1.85;

// The powerboost is placed so that the micro USB is accessible when the penetration flange is removed
// Powerboost is rotated around the center of the pen bracket ring to get out of the way of the other parts
pb_angle = 60;
pb_placement_r = 5.5 - bracket_r;
pb_placement = [pb_placement_r * cos(pb_angle), pb_placement_r * sin(pb_angle),
        flange_h + 3 * bracket_ring_h / 2 + support_h - pb_size.y / 2];
pb_rotation = [0, - 90, 180 + pb_angle];
