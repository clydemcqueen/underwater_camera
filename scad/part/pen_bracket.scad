include <ec_common.scad>

include <../vitamin/adafruit.scad>

// Bracket for the penetration flange
module pen_bracket() {
  linear_extrude(height = bracket_ring_h)
    difference() {
      circle(r = bracket_r);

      // Slot for the pi tray
      translate(pi_pen_slot_pos)
        square(pi_pen_slot, center = true);

      // Knockout for the pi pcb
      translate(pi_pcb_pen_kn_pos)
        square(pi_pcb_kn, center = true);

      // Knockout for the pi components
      translate(pi_comp_pen_kn_pos)
        square(pi_comp_kn, center = true);

      // Slot for the pb tray
      translate(pb_pen_slot_pos)
        square(pb_pen_slot, center = true);

      // Knockout for the pb pcb
      translate(pb_pcb_pen_kn_pos)
        square(pb_pcb_kn, center = true);

      // Knockout for the pb components
      translate(pb_comp_pen_kn_pos)
        square(pb_comp_kn, center = true);

      // Knockout for the switch and wires
      translate([- 10, 0])
        circle(r = 8);
    }

  // Tray attachment points
  for (x = [4.2, 10], y = [- attach_pen_pos_y, attach_pen_pos_y]) {
    translate([x, y, bracket_ring_h + attach.z / 2])
      attachment();
  }
}

// Attachment point
module attachment() {
  difference() {
    cube(attach, center = true);

    // Hole fits an M2 screw
    rotate([0, 90, 0])
      cylinder(r = attach_hole_side_print_r, h = attach.x + 1, center = true);
  }
}