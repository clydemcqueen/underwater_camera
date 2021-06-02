include <../include/tube.scad>

// 2" flange dimensions
flange_h = 21.5;
flange_w = 6;

// Flange exterior portion
flange_ext_h = 6;
flange_ext_r = 25;
flange_ext_hole_offset = 23;  // Approximate
flange_ext_holes = [for (angle = [30, 90, 150, 210, 270, 330])
  [cos(angle) * flange_ext_hole_offset, sin(angle) * flange_ext_hole_offset]];

// Flange interior portion
flange_int_h = flange_h - flange_ext_h;
flange_int_r = flange_ext_r - flange_w;
flange_int_hole_offset = 21.5;
flange_int_holes = [for (angle = [30, 120, 210, 300])
  [cos(angle) * flange_int_hole_offset, sin(angle) * flange_int_hole_offset]];

// 2" tube dimensions
tube_h = 120;
tube_wall = 3.2;
tube_r_inside = 25.4;
tube_r_outside = tube_r_inside + tube_wall;

// Flange exterior 2d pattern
module flange_ext_2d() {
  difference() {
    circle(r = 28.5);
    circle(r = 28.5 - 9.5);

    // Six exterior holes
    for (ext_hole = flange_ext_holes) {
      translate([ext_hole.x, ext_hole.y]) circle(r = 1);
    }
  }
}

// Flange interior 2d pattern
module flange_int_2d() {
  difference() {
    circle(r = flange_ext_r);
    circle(r = flange_ext_r - flange_w);

    // Four interior holes
    for (int_hole = flange_int_holes) {
      translate([int_hole.x, int_hole.y]) circle(r = 1);
    }
  }
}

// BlueRobotics 2" flange
// Aligned so that the 2 penetrations run along the x axis
module flange() {
  // Exterior tube
  linear_extrude(height = flange_ext_h)
    flange_ext_2d();

  // Interior tube
  translate([0, 0, flange_ext_h]) linear_extrude(height = flange_int_h)
    flange_int_2d();
}

// BlueRobotics 2" tube
module two_inch_tube() {
  tube(h = tube_h, r = tube_r_outside, w = tube_wall);
}

// Switch and wires -- just the bits that stick into the tube
module switch_and_wires() {
  cylinder(h = 10, r = 4);
}

// Camera flange
module cam_flange() {
  flange();
}

// Penetration flange with the switch and wires
module pen_flange() {
  flange();

  // One of the two penetrations has a switch and wires sticking into the interior
  //translate([-cos(0) * 9, sin(0) * 9, flange_h]) switch_and_wires();
  translate([- cos(180) * 9, sin(180) * 9, flange_h]) switch_and_wires();
}

// Preview:
//$fn = 60;
//two_inch_tube();
//cam_flange();
//pen_flange();