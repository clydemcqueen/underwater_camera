// Simple loop that attaches to the stereo_mount, useful for tying a safety line :-)

include <sc_common.scad>

loop_bracket_size = [joiner_size.x, 12, 5];

module loop_bracket() {
  difference() {
    translate([- loop_bracket_size.x / 2, - loop_bracket_size.y / 2, 0])
      cube(loop_bracket_size, center = false);

    // Holes for M3 screws
    for (hole = tripod_mount_holes) {
      translate([hole.x, hole.y, - 0.05])
        cylinder(r = M3_screw_r, h = loop_bracket_size.z + 0.1);
    }
  }

  // Loop
  loop_outer_r = 6;
  loop_inner_r = 2;
  loop_width = loop_bracket_size.y;
  translate([0, 0, loop_bracket_size.z + loop_inner_r])
    rotate([90, 0, 0])
      difference() {
        cylinder(r = loop_outer_r, h = loop_width, center = true);
        translate([0, 0.05, 0])
          cylinder(r = loop_inner_r, h = loop_width + 0.1, center = true);
      }
}

// Preview:
//$fn = 60;
//loop_bracket();
