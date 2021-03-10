// Simple tube
// r is the outer radius
// w is the width of the tube wall
module tube(h, r, w) {
  difference() {
    cylinder(h = h, r = r);
    translate([0, 0, - 1])
      cylinder(h = h + 2, r = r - w);
  }
}
