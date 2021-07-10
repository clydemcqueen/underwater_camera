// External camera, just the camera-side bits: domed flange, bracket, camera

include <flags.scad>

include <../part/cam_bracket.scad>

module cam_assembly() {
  if (render_electronics)
    translate(camera_placement)
      rotate(camera_rotation)
        pi_camera();

  if (render_parts)
    color("#9898f8", 0.6)
      translate(cam_bracket_placement)
        rotate(cam_bracket_rotation)
          cam_bracket();

  if (render_flanges)
    color("#5252b4", 0.5)
      translate(cam_flange_placement)
        rotate(cam_flange_rotation)
          cam_flange();
}

//$fn = 60;
//cam_assembly();
