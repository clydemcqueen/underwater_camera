// Stereo camera: show just the bracket and 2 tubes

include <flags.scad>

include <../part/stereo_clamp.scad>
include <../part/stereo_mount.scad>

module stereo_camera_assembly() {
  if (render_parts) {
    color("#57819a", 0.4)
      translate([- clamp_pos_x, 0, 0])
        rotate([90, 0, 90])
          stereo_clamp();

    color("#57819a", 0.4)
      translate([clamp_pos_x, 0, 0])
        rotate([90, 0, - 90])
          stereo_clamp();

    color("#4ea54c", 0.5)
      rotate([0, 0, 90])
        stereo_mount();
  }

  if (render_tube)
    color("gray", 0.6)
      rotate([0, 90, 0])
        for (pos_y = [- baseline / 2, baseline / 2]) {
          translate([0, pos_y, - tube_h / 2])
            two_inch_tube();
        }
}

$fn = 60;
stereo_camera_assembly();
