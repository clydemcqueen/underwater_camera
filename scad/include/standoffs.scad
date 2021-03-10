// Standoffs
module standoffs(holes, column_height, wall, hole_radius) {
  linear_extrude(column_height)
    columns_with_holes_2d(holes, wall, hole_radius);
}

// Box with standoffs in the corners
module box_with_standoffs(holes, box_height, column_height, wall, hole_radius) {
  linear_extrude(column_height)
    columns_with_holes_2d(holes, wall, hole_radius);
  linear_extrude(box_height)
    box_2d(holes, wall, hole_radius);
}

// 2d pattern for standoffs
module columns_with_holes_2d(holes, wall, hole_radius) {
  for (hole = holes) {
    translate(hole)
      difference() {
        circle(hole_radius + wall);
        circle(hole_radius);
      }
  }
}

// 2d pattern for hollow box
module box_2d(holes, wall, hole_radius) {
  difference() {
    hull() {
      for (hole = holes) {
        translate(hole)
          circle(hole_radius + wall);
      }
    }
    hull() {
      for (hole = holes) {
        translate(hole)
          circle(hole_radius);
      }
    }
  }
}

// 2d pattern for solid box
module solid_box_2d(holes, radius) {
  difference() {
    hull() {
      for (hole = holes) {
        translate(hole)
          circle(radius);
      }
    }
  }
}

module test_standoffs() {
  $fn = 60;

  // Just standoffs
  standoffs([[0, 0], [10, 0], [0, 15], [10, 15]], 5, 1, 1.5);

  // Columns higher than box walls:
  translate([20, 20, 0])
    box_with_standoffs([[0, 0], [10, 0], [0, 15], [10, 15]], 5, 10, 1, 1.5);

  // Columns lower than box walls:
  translate([- 20, 20, 0])
    box_with_standoffs([[0, 0], [10, 0], [0, 15], [10, 15]], 10, 8, 1.5, 1);

  // Supports an arbitrary number of holes:
  translate([20, - 20, 0])
    box_with_standoffs([[0, 0], [10, 2], [1, 15]], 8, 11, 1.5, 1);

  // But the holes should make up a convex hull:
  translate([- 20, - 20, 0])
    box_with_standoffs([[0, 0], [10, 2], [1, 15], [9, 15], [5, 8]], 8, 11, 1.5, 2);
}

//test_standoffs();