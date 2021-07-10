// Wired camera, just the interior bits: interior printed parts, pi, secondary board

include <flags.scad>

include <../part/wc_bracket.scad>

module wired_interior_assembly() {
    if (render_parts)
    color("#9898f8", 0.6)
      translate(wc_bracket1_placement)
        rotate(wc_bracket1_rotation)
          wc_bracket1();

  if (render_parts)
    color("#9898f8", 0.6)
      translate(wc_bracket2_placement)
        rotate(wc_bracket2_rotation)
          wc_bracket2();

  if (render_electronics)
    translate(pi_placement)
      rotate(pi_rotation)
        pi_zero();

  // The proto board is the same size as the pi zero pcb
  if (render_electronics)
    translate(proto_placement)
      rotate(proto_rotation)
        pi_zero_pcb();
}

//$fn = 60;
//wired_interior_assembly();
