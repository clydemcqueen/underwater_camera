// Raspberry Pi camera v2.1. Mechanical drawing:
// https://www.raspberrypi.org/documentation/hardware/camera/mechanical/rpi_MECH_Camera2_2p1.pdf

include <pcb.scad>

// PCB
cam_x = 23.862;
cam_y = 25;
cam_z = 0.95;
cam_corner_r = 2;

// Mounting holes are tricky because they are not on the 4 corners of the board
cam_hole_d = 2.2;
cam_hole_r = cam_hole_d / 2;
cam_hole_edge = 2;  // Distance from edge to center of mount hole
cam_hole_x = cam_x / 2 - cam_hole_edge;
cam_hole_y = cam_y / 2 - cam_hole_edge;
cam_hold_mid_x = 14.5 - cam_x / 2;

// TODO handle flip better (works for now because cam_origin.y == 0)
cam_holes = [
    [- cam_hole_x, - cam_hole_y],
    [- cam_hole_x, cam_hole_y],
    [cam_hold_mid_x, - cam_hole_y],
    [cam_hold_mid_x, cam_hole_y]];

//echo(cam_holes);
//echo("x sep is ", cam_holes[2].x - cam_holes[0].x);
//echo("y sep is ", cam_holes[1].y - cam_holes[0].y);

// Camera component sits UNDERNEATH the board at [cam_origin.x, cam_origin.y]
cam_origin = [cam_x / 2 - 9.462, 0];

// Center point, useful for placement, assumes board is flipped
// TODO handle flip better (works for now because cam_origin.y == 0)
cam_center_point = [- cam_origin.x, - cam_origin.y, 3];

// Components, see pcb.scad::pcb_component()
csi_socket = [4, 20, 1.8, "Ivory"];
csi_clip = [1, 20, 1.8, "DimGray"];
camera = [8.5, 8.5, 4.5, "Gray"];

module pi_camera() {
  pcb_component(csi_socket, 9, 0, board_h = cam_z);
  pcb_component(csi_clip, 11.5, 0, , board_h = cam_z);

  // Camera is on the underside, facing down
  pcb_component(camera, cam_origin.x, cam_origin.y, board_h = - 4.5);

  // Board goes last because alpha < 1.0
  color("#038f3f", 0.5) difference() {
    pcb(cam_x, cam_y, cam_z, cam_corner_r);

    for (cam_hole = cam_holes) {
      pcb_hole(cam_hole.x, cam_hole.y, cam_hole_r, cam_z);
    }
  }
}

// Preview:
//$fn = 60;
//pi_camera();
