include <../vitamin/blue_robotics.scad>
include <NopSCADlib/core.scad>

baseline = 70;

total_stereo_mount_length = 60;

clamp_thickness = 4;
clamp_cut_a = 1;
clamp_height = 6;

clamp_tab = [clamp_height, 6];

clamp_int_r = tube_r_outside;
clamp_ext_r = tube_r_outside + clamp_thickness;

clamp_pos_x = total_stereo_mount_length / 2 + clamp_height / 2;

// y is height of the joiner + mount parts between the 2 tubes
// x can be anything large enough to hit both tubes
joiner_size = [30, 30];

// Tighten the clamp on the aluminnum bit of the flange
clamp_screw_r = 2 / 2;
clamp_nut_r = nut_radius(M2_nut) - 0.1;

// Attach the clamps to the center mount part
mount_screw_r = 3 / 2;
mount_nut_flat_r = nut_flat_radius(M3_nut);
//echo(2 * mount_nut_flat_r);
//echo(2 * nut_radius(M3_nut));
mount_nut_depth = 2.3;

// 2d positions of holes in stereo clamp joiner
mount_holes = [[0, - 10], [0, 10]];

// Clamps have ridges, mount parts have slots at +/- ridge_offset
ridge_offset = 4;

// Ridge width and height, also the depth of the slot in the mount parts
ridge_width = 2.3;
ridge_height = 4;

// Slots are slightly larger than ridges
slot_tolerance = 0.15;

module joiner_2d(draw_holes = true) {
  difference() {
    square(joiner_size, center = true);
    for (x = [- baseline / 2, baseline / 2]) {
      translate([x, 0])
        circle(r = clamp_int_r);
    }

    if (draw_holes)
      for (mount_hole = mount_holes) {
        translate(mount_hole)
          circle(r = mount_screw_r);
      }
  }
}
