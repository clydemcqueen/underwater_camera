// Modules and constants for mocking up printed circuit boards

// Conventions:
// -- the long side is x, narrow side is y
// -- the bottom of the board is at z=0

// Header base
hdr_base_x = 2.5;
hdr_base_y = 2.5;
hdr_base_z = 2.5;

// Header pin
hdr_pin_x = 0.7;
hdr_pin_y = 0.7;
hdr_pin_z = 11.75;

// Common components, spec: [x size, y size, z size, color]
micro_usb = [5.0, 7.5, 2.5, "silver"];
jst2 = [6.0, 8.0, 5.6, "black"];
hdmi = [7.25, 11.25, 3.3, "Silver"];
sd_card_holder = [12.0, 11.5, 1.3, "Silver"];

// Printed circuit board with rounded corners
module pcb(x, y, board_h = 1.5, r = 2.5) {
  x_pos = x / 2 - r;
  y_pos = y / 2 - r;

  hull() for (i = [- x_pos, x_pos], j = [- y_pos, y_pos]) {
    translate([i, j, 0]) cylinder(r = r, h = board_h);
  }
}

// Hole in the pcb
module pcb_hole(x, y, r, board_h = 1.5) {
  translate([x, y, - 0.1]) cylinder(h = board_h + 0.2, r = r);
}

// Component that sits on top of the pcb
// Future: support bottom mounted components
module pcb_component(spec, x, y, yaw = 0.0, board_h = 1.5) {
  color(spec[3])
    translate([x, y, board_h + spec[2] / 2])
      rotate([0, 0, yaw])
        cube([spec.x, spec.y, spec.z], center = true);
}

// Header (base + pin)
module pcb_header(x, y, base_z, pin_z) {
  color("Black")
    translate([x, y, base_z])
      cube([hdr_base_x, hdr_base_y, hdr_base_z], center = true);
  color("Silver")
    translate([x, y, pin_z])
      cube([hdr_pin_x, hdr_pin_y, hdr_pin_z], center = true);
}

