// Clip a circle, x1 and x2 are from the center, so must be < r
// Future: might be nice to make this a real library function with x1, x2, y1, y2
module clip_circle(r, x1, x2) {
  d = 2 * r;
  intersection() {
    circle(r = r);

    translate([x1, 0])
      square([d, d], center = true);

    translate([x2, 0])
      square([d, d], center = true);
  }
}

//$fn = 60;
//clip_circle(10, 3, -2);
