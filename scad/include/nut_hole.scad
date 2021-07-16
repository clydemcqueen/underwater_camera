// Create a hole for a screw and nut
// Screw hole and nut hole meet at [0, 0, 0] and run along the z axis
module nut_hole(nut_r, screw_r, length = 10) {
  linear_extrude(length)
    circle(nut_r, $fn = 6);

  translate([0, 0, - length])
    linear_extrude(length + 0.1)
      circle(screw_r);
}

