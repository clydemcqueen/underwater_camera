include <../vitamin/blue_robotics.scad>
include <NopSCADlib/core.scad>

// Distance between 2 camera centers
baseline = 70;

// Length of stereo mount
// Divide into middle bit + 2 endcaps
stereo_mount_size_y = 70;
stereo_mount_endcap_size_y = 15;
stereo_mount_middle_size_y = stereo_mount_size_y - 2 * stereo_mount_endcap_size_y;

clamp_thickness = 4;
clamp_cut_a = 1;
clamp_height = 6;

clamp_tab = [clamp_height, 6];

clamp_int_r = tube_r_outside;
clamp_ext_r = tube_r_outside + clamp_thickness;

clamp_pos_x = stereo_mount_size_y / 2 + clamp_height / 2;

// y is height of the joiner + mount parts between the 2 tubes -- this drives key calcs!
// x can be anything large enough to hit both tubes
joiner_size = [stereo_mount_middle_size_y, 32];

// Width of the stereo mount at its narrowest
stereo_mount_narrow_width = baseline - 2 * clamp_int_r;

// Width of the stereo mount at its widest
stereo_mount_wide_width = stereo_mount_narrow_width + 2 * (tube_r_outside -
  sqrt(tube_r_outside * tube_r_outside - joiner_size.y * joiner_size.y / 4));

// Tighten the clamp on the aluminnum bit of the flange
clamp_screw_r = 2 / 2;
clamp_nut_r = nut_radius(M2_nut) - 0.1;

// Attach the clamps to the center mount part using M3*20 screws and square M3 nuts
M3_screw_r = 3 / 2;
M3_nut_flat_r = nut_flat_radius(M3_nut);
//echo(2 * M3_nut_flat_r);
//echo(2 * nut_radius(M3_nut));
M3_nut_depth = 2.3;

// 2d positions of holes in joiner_2d
mount_holes = [[0, - 10], [0, 10]];

// Also use M3*20 screws and square M3 nuts to mount the tripod_mount on the stereo_mount
tripod_mount_holes = [[-15, 0], [15, 0]];
tripod_screw_inset = 3.5;

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
          circle(r = M3_screw_r);
      }
  }
}
