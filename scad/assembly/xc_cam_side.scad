// Wired or battery-powered camera-side bits: domed flange, bracket, camera

include <flags.scad>

include <../part/xc_cam_bracket.scad>

module cam_assembly(lens_adapter) {
  if (render_electronics)
    translate(camera_placement)
      rotate(camera_rotation)
        pi_camera();

  if (render_parts)
    color("#9898f8", 0.6)
      translate(cam_bracket_placement)
        rotate(cam_bracket_rotation)
          cam_bracket(lens_adapter);

  if (render_flanges)
    color("#5252b4", 0.5)
      translate(cam_flange_placement)
        rotate(cam_flange_rotation)
          cam_flange();
}

//$fn = 60;
//cam_assembly(lens_adapter = false);
