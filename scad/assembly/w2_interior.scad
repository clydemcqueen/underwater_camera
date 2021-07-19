// Wired camera v2, just the interior bits: interior printed parts, pi, secondary board

include <flags.scad>

include <../part/w2_bracket.scad>

module w2_interior_assembly() {
  if (render_parts)
    color("#9898f8", 0.6)
      translate(w2_bracket_placement)
        rotate(w2_bracket_rotation)
          w2_bracket();

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
//w2_interior_assembly();
