// External camera, just the interior bits: interior printed parts, pi, powerboost, battery

include <flags.scad>

include <../part/ec_bracket.scad>

module interior_assembly() {
    if (render_parts)
    color("#9898f8", 0.6)
      translate(ec_bracket1_placement)
        rotate(ec_bracket1_rotation)
          ec_bracket1();

  if (render_parts)
    color("#9898f8", 0.6)
      translate(ec_bracket2_placement)
        rotate(ec_bracket2_rotation)
          ec_bracket2();

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
}

//$fn = 60;
//interior_assembly();
