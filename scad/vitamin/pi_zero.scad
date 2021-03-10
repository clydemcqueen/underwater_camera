include <pcb.scad>

// Options
show_pi = true;
show_gpio_header = 0;  // 0 = no headers, 1 = above, -1 = below
show_extra_header = false;  // 2x2 header for reset switch and RCA composite video

// PCB
pi_x = 65;
pi_y = 30;
pi_z = 1.6;
pi_half_z = pi_z / 2;
pi_corner_r = 3.0;

// Mount holes
pi_hole_edge = 3.5;  // Distance from edge to center of mount hole
pi_hole_d = 2.75;
pi_hole_r = pi_hole_d / 2;
pi_hole_x = pi_x / 2 - pi_hole_edge;
pi_hole_y = pi_y / 2 - pi_hole_edge;
pi_holes = [for (i = [- pi_hole_x, pi_hole_x], j = [- pi_hole_y, pi_hole_y]) [i, j]];

// Header holes
pi_header_pitch = 2.54; // 0.1in
pi_header_size = [20 * pi_header_pitch, 2 * pi_header_pitch];
pi_header_pos = [0, pi_y / 2 - pi_hole_edge]; // center=true

// Components, see pcb.scad::pcb_component()
csi_socket = [3, 17, 1.3, "Ivory"];
csi_clip = [1, 17, 1.3, "DimGray"];
activity_led = [2.3, 1, 1, "GreenYellow"];
cpu = [12, 12, 1.2, "Black"];

// Antenna
antenna_poly = [[- 6.5, - 11.4], [1.5, - 11.4], [- 1.5, - 13.5], [- 4, - 13.5], [- 6.5, - 11.4]];

// Header pin position calculators, return the center of the hole, pitch is 0.1"
function pin_pos_x(i) = - (19 * pi_header_pitch / 2) + i * pi_header_pitch;
function pin_pos_y(j) = pi_hole_y - pi_header_pitch / 2 + j * pi_header_pitch;

// Pi body and headers
module pi_zero() {
  if (show_pi) pi_zero_body();
  if (show_gpio_header) pi_headers(show_gpio_header);
}

// Just Pi body
module pi_zero_body() {
  color("#038f3f") difference() {
    pcb(pi_x, pi_y, pi_z, pi_corner_r);

    // Corner screw holes
    for (pi_hole = pi_holes) {
      pcb_hole(pi_hole.x, pi_hole.y, pi_hole_r, pi_z);
    }

    // GPIO header holes
    for (i = [0:19], j = [0, 1]) {
      pcb_hole(pin_pos_x(i), pin_pos_y(j), 0.5, pi_z);
    }

    // Extra header holes
    for (i = [18, 19], j = [- 1, - 2]) {
      pcb_hole(pin_pos_x(i), pin_pos_y(j), 0.5, pi_z);
    }
  }

  // Components
  pcb_component(cpu, - 7.1, - 2);
  pcb_component(sd_card_holder, - 24.5, 1.9, yaw = 90);
  pcb_component(hdmi, - 20.1, - 11.4, yaw = 90);  // TODO check height!
  pcb_component(micro_usb, 8.9, - 13, yaw = 90);  // Data
  pcb_component(micro_usb, 21.5, - 13, yaw = 90);  // Power
  pcb_component(activity_led, 26.5, - 8);
  pcb_component(csi_socket, 30, 0);
  pcb_component(csi_clip, 32, 0);

  // Antenna
  color("DarkGreen") translate([0, 0, 0.1]) linear_extrude(height = pi_z) polygon(antenna_poly);
}

// Pi headers
module pi_headers(direction = 1) {
  base_z = pi_half_z + direction * (pi_half_z + hdr_base_z / 2);
  pin_z = pi_half_z + direction * (pi_half_z + hdr_pin_z / 2 - 3);

  for (i = [0:19], j = [0, 1]) {
    pcb_header(pin_pos_x(i), pin_pos_y(j), base_z, pin_z);
  }

  if (show_extra_header) {
    for (i = [18, 19], j = [- 1, - 2]) {
      pcb_header(pin_pos_x(i), pin_pos_y(j), base_z, pin_z);
    }
  }
}

// Preview:
//$fn = 60;
//pi_zero();
