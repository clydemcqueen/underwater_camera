// Mono camera mount

include <flags.scad>

include <../part/mono_clamp.scad>
include <../part/mono_mount.scad>
include <NopSCADlib/core.scad>

module mono_camera_assembly() {
  if (render_parts) {
    color("#57819a", 0.4)
      translate([- clamp_pos_x, 0, 0])
        rotate([90, 0, 90])
          mono_clamp();

    color("#57819a", 0.4)
      translate([clamp_pos_x, 0, 0])
        rotate([- 90, 0, 90])
          mono_clamp();

    color("#4ea54c", 0.5)
      rotate([0, 0, 90])
        mono_mount();
  }

  if (render_tube)
    color("gray", 0.6)
      rotate([0, 90, 0])
        translate([0, baseline / 2, - tube_h / 2])
          two_inch_tube();

  if (render_screws)
    for (hole = sub_mount_holes) {
      translate([hole.x, 3, hole.y])
        rotate([- 90, 0, 0])
          screw(M3_cap_screw, 20);
    }
}

$fn = 60;
mono_camera_assembly();
