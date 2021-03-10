include <pcb.scad>

pb_size = [36.2, 22.86];
pb_z = 1.6;
pb_hole_r = 1.25; // Measured
pb_hole_x = 36.2 / 2 - 2.5;
pb_hole_y = 17.65 / 2;
pb_holes = [for (j = [- pb_hole_y, pb_hole_y]) [pb_hole_x, j]];
pb_header_pitch = 2.54; // 0.1in
pb_header_size = [pb_header_pitch, 8 * pb_header_pitch];
pb_header_pos = [pb_size.x / 2 - 21.72, pb_size.y / 2 - 1]; // center=true

battery_d = 18.5; // Measured
battery_r = battery_d / 2;
battery_h = 69;

// Adafruit Powerboost 1000 Charger
// https://www.adafruit.com/product/2465
module power_boost() {
  color("#065daa") difference() {
    pcb(pb_size.x, pb_size.y);

    for (hole = pb_holes) {
      pcb_hole(hole.x, hole.y, pb_hole_r, pb_z);
    }

    pb_header_hole_r = 0.5;
    pb_header_hole_x_start = pb_header_pos.x - 3.5 * pb_header_pitch;
    pb_header_hole_y_end = pb_header_pos.x + 3.5 * pb_header_pitch;
    pb_header_holes = [for (j = [pb_header_hole_x_start:pb_header_pitch:pb_header_hole_y_end]) [j, pb_header_pos.y]];
    for (hole = pb_header_holes) {
      pcb_hole(hole.x, hole.y, pb_header_hole_r, pb_z);
    }
  }

  pcb_component(micro_usb, 36.2 / 2 - 2, 0);
  pcb_component(jst2, 7.5, - 8, 90);
  pcb_component([5, 5, 3.9, "black"], - 3, - 4);
}

// Adafruit Lithium Ion Cylindrical Battery - 3.7v 2200mAh
// https://www.adafruit.com/product/1781
module battery() {
  color("#02a5fe") cylinder(h = battery_h, r = battery_r);
}

// Preview:
//$fn = 60;
//power_boost();
//battery();