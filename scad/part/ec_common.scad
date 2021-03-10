include <../vitamin/adafruit.scad>
include <../vitamin/blue_robotics.scad>
include <../vitamin/pi_zero.scad>

// All tolerances measured for my Prusa MK3S + PLA + 0.15mm layers

// Good M2 hole radius
M2_hole_r = 1.1;

// When printed sideways it needs to be a bit smaller
M2_hole_side_print_r = 1;

// Build a structure with 2 circular ("ring") brackets connected by 2 flat trays
// The trays have tabs that slot into the cam_bracket and the pen_bracket

// Overall structure size:
structure_h = 76;
bracket_ring_h = 4;
tray_length = structure_h - 2 * bracket_ring_h;

// Bracket radius, slightly smaller than the inside of the tube
bracket_r = tube_r_inside - 0.2;

// Interior radius, slightly smaller than the inside of the flange
interior_r = flange_int_r - 0.2;

// Tray sizes
pi_tray_size = [tray_length, 34, 1.8];
pb_tray_size = [tray_length, 40, 1.8];

// How the trays are positioned in the brackets
pi_slot_position = 18;
pb_slot_position = 8;

// Adjust boards to be center=true
pi_center_offset = pi_slot_position - pi_tray_size.z / 2;
pb_center_offset = pb_slot_position - pb_tray_size.z / 2;

// Slots are slightly larger than tabs
tab_slot_tolerance = 0.15;

// The pi and pb boards also fit snugly into the brackets
board_slot_tolerance = 0.2;

// The pb_tray is attached to the pen_bracket and the cam_bracket at 2 points with M2 screws
attach = [4, 5, 5];
attach_hole_r = M2_hole_r;
attach_hole_side_print_r = M2_hole_side_print_r;
attach_cam_pos_y = 6;
attach_pen_pos_y = 15;

// Holes in pb_tray
attach_cam_holes = [[- 42, - attach_cam_pos_y], [- 42, attach_cam_pos_y]];
attach_pen_holes = [[40.5, - attach_pen_pos_y], [40.5, attach_pen_pos_y]];

// Nut positions in cam_bracket
nut_pb_cam_posns = [[2, - attach_cam_pos_y], [2, attach_cam_pos_y]];

// Tab widths
pi_cam_tab_width = 14;
pi_pen_tab_width = 28;
pb_cam_tab_width = 25;
pb_pen_tab_width = 35;

// Tab sizes
pi_cam_tab = [bracket_ring_h, pi_cam_tab_width];
pi_pen_tab = [bracket_ring_h, pi_pen_tab_width];
pb_cam_tab = [bracket_ring_h + 8, pb_cam_tab_width];
pb_pen_tab = [bracket_ring_h, pb_pen_tab_width];

// Slot sizes
pi_cam_slot = [pi_tray_size.z + tab_slot_tolerance, pi_cam_tab_width + tab_slot_tolerance];
pi_pen_slot = [pi_tray_size.z + tab_slot_tolerance, pi_pen_tab_width + tab_slot_tolerance];
pb_cam_slot = [pb_tray_size.z + tab_slot_tolerance, pb_cam_tab_width + tab_slot_tolerance];
pb_pen_slot = [pb_tray_size.z + tab_slot_tolerance, pb_pen_tab_width + tab_slot_tolerance];

// Slot positions
pi_cam_slot_pos = [pi_center_offset, 0];
pi_pen_slot_pos = [pi_center_offset, 0];
pb_cam_slot_pos = [pb_center_offset, 0];
pb_pen_slot_pos = [pb_center_offset, 0];

// PCB knockout sizes
pi_pcb_kn = [pi_z + board_slot_tolerance, 31];
pb_pcb_kn = [pb_z + board_slot_tolerance, 25.2];  // Same width as tray tab

// PCB knockout positions
pi_pcb_cam_kn_pos = [pi_cam_slot_pos.x - pi_cam_slot.x / 2 - pi_pcb_kn.x / 2, 0];
pi_pcb_pen_kn_pos = [pi_pen_slot_pos.x - pi_pen_slot.x / 2 - pi_pcb_kn.x / 2, 0];
pb_pcb_pen_kn_pos = [pb_pen_slot_pos.x - pb_pen_slot.x / 2 - pb_pcb_kn.x / 2, 0];

// Board component knockout sizes
pi_comp_kn = [3, 18];
pb_comp_kn = [3, 10];

// Board component knockout positions
pi_comp_cam_kn_pos = [pi_pcb_cam_kn_pos.x - pi_pcb_kn.x / 2 - pi_comp_kn.x / 2, 0];
pi_comp_pen_kn_pos = [pi_pcb_pen_kn_pos.x - pi_pcb_kn.x / 2 - pi_comp_kn.x / 2, 0];
pb_comp_pen_kn_pos = [pb_pcb_pen_kn_pos.x - pb_pcb_kn.x / 2 - pb_comp_kn.x / 2, 0];

// Mount the boards on the trays
pi_mount = [5.5, 0];
pb_mount = [20, 0];

// Boards sit slightly off the tray
mount_standoff = 0.3;

// The trays have nibs to hold the boards in place
pi_nib_h = pi_z + board_slot_tolerance / 2;
pb_nib_h = pb_z + board_slot_tolerance / 2;

// All assemblies are built with the camera facing down, where z=0 at the camera center point.
// The 2 trays share a common z, so that appears here.
tray_center_z = tray_length / 2 + flange_h + bracket_ring_h;

// Battery position
battery_pos = [- 9.5, 0, 9];