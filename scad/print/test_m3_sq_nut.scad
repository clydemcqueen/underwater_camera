include <NopSCADlib/core.scad>

M3_screw_r = 3 / 2;
echo("M3_screw_r", M3_screw_r);

M3_nut_flat_r = nut_flat_radius(M3_nut);
echo("M3_nut_flat_r", M3_nut_flat_r);

M3_nut_depth = 2.3;
echo("M3_nut_depth", M3_nut_depth);

block_size = [8, 16, 8];

module test_block(z_stop) {
  translate([0, 0, block_size.z / 2])
    difference() {
      cube(block_size, center = true);

      // Hole for M3 screw
      translate([0, 0, 0])
        rotate([90, 0, 0])
          cylinder(r = M3_screw_r, h = block_size.y + 2, center = true);

      // Slot for M3 square nut
      // "Stop" provides support for the nut on 3 sides
      translate([0, block_size.y / 2 - 8, z_stop])
        cube([2 * M3_nut_flat_r, M3_nut_depth, block_size.z], center = true);
    }
}

module test_m3_sq_nut() {
  M3_sq_nut_width = 5.5;

  translate([0, 0, 0])
    test_block(block_size.z / 2 - M3_sq_nut_width / 2);

  translate([block_size.x, 0, 0])
    test_block(block_size.z / 2 - M3_sq_nut_width / 2 - 0.5);

  translate([block_size.x * 2, 0, 0])
    test_block(block_size.z / 2 - M3_sq_nut_width / 2 - 1);
}

// Hi-def render
$fn = 60;

test_m3_sq_nut();
