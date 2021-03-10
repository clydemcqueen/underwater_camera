// External camera: domed flange, bracket, camera, battery

include <flags.scad>

include <../vitamin/adafruit.scad>
include <../vitamin/blue_robotics.scad>
include <../vitamin/pi_camera.scad>
include <NopSCADlib/core.scad>

include <../part/cam_bracket.scad>

module cam_assembly() {
  if (render_screws)
    for (pos = nut_pb_cam_posns) {
      translate([pos.x - 2, pos.y, 17.5])
        rotate([0, 90, 0])
          nut(M2_nut);

      translate([pos.x + 6, pos.y, 17.5])
        rotate([0, 90, 0])
          screw(M2_cap_screw, 8);
    }

  if (render_electronics)
    translate(cam_center_point)
      pi_camera();

  if (render_electronics)
    translate(battery_pos)
      battery();

  if (render_parts)
    color("#9898f8", 0.6)
      translate([0, 0, flange_h + bracket_ring_h])
        rotate([180, 0, 0])
          cam_bracket();

  if (render_flanges)
    color("#5252b4", 0.5)
      cam_flange();
}

//$fn = 60;
//cam_assembly();
