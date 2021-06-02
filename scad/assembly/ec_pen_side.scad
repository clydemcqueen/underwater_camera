// External camera: penetration flange, bracket, pi, powerboost, battery

include <flags.scad>

include <../part/pen_bracket.scad>

module pen_assembly() {
  if (render_parts)
    color("#9898f8", 0.6)
      translate(pen_bracket_placement)
        rotate(pen_bracket_rotation)
          pen_bracket();

  if (render_electronics)
    translate(battery_placement)
      rotate(battery_rotation)
        battery();

  if (render_electronics)
    translate(pi_placement)
      rotate(pi_rotation)
        pi_zero();

  if (render_electronics)
    translate(pb_placement)
      rotate(pb_rotation)
        power_boost();

  if (render_flanges)
    color("#5252b4", 0.5)
      translate(pen_flange_placement)
        rotate(pen_flange_rotation)
          pen_flange();
}

//$fn = 60;
//pen_assembly();
