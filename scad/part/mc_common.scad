include <../vitamin/blue_robotics.scad>
include <NopSCADlib/core.scad>

// Center of camera relative to the clamp screw holes
camera_center = 35;

// Length of mono mount
mono_mount_size_y = 70;
mono_mount_half_size_y = mono_mount_size_y / 2;

clamp_thickness = 4;
clamp_cut_a = 1;
clamp_height = 6;

clamp_tab = [clamp_height, 6];
clamp_int_r = tube_r_outside;
clamp_ext_r = tube_r_outside + clamp_thickness;
clamp_pos_x = mono_mount_half_size_y + clamp_height / 2;

// y is height of the joiner + mount parts between the 2 tubes -- this drives key calcs!
// x must be large enough to hit the tube
base_size = [22, 32];

// The base is bigger on the sub side than it needs to be, trim off a bit
base_offset = 4;

// Clamp screws
clamp_screw_r = 2 / 2;
clamp_nut_r = nut_radius(M2_nut) - 0.1;

// Attach the clamps to the center mount part using M3*20 screws and square M3 nuts
M3_screw_r = 3 / 2;
M3_head_r = 6 / 2;
M3_nut_flat_r = nut_flat_radius(M3_nut);
//echo(2 * M3_nut_flat_r);
//echo(2 * nut_radius(M3_nut));
M3_nut_depth = 2.3;

// 2d positions of holes in base_2d
mount_holes = [[0, - 10], [0, 10]];

// Use M3 screws to mount the mono_mount to the sub
sub_mount_holes = [[- mono_mount_half_size_y / 2, 0], [mono_mount_half_size_y / 2, 0]];
sub_screw_inset = 3.5;

// Clamps have ridges, mount parts have slots at +/- ridge_offset
ridge_offset = 4;

// Ridge width and height, also the depth of the slot in the mount parts
ridge_width = 2.3;
ridge_height = 4;

// Slots are slightly larger than ridges
slot_tolerance = 0.15;

module base_2d(draw_holes = true) {
  difference() {
    translate([base_offset, 0])
      square(base_size, center = true);
    translate([camera_center, 0])
      circle(r = clamp_int_r);

    if (draw_holes)
      for (mount_hole = mount_holes) {
        translate(mount_hole)
          circle(r = M3_screw_r);
      }
  }
}
