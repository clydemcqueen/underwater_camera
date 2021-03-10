// External camera: penetration flange and bracket

include <flags.scad>

include <../vitamin/adafruit.scad>
include <../vitamin/blue_robotics.scad>
include <NopSCADlib/core.scad>

include <../part/pen_bracket.scad>

module pen_assembly() {
  bracket_z_pos = flange_h + bracket_ring_h + pb_tray_size.x;
  screw_z_pos = bracket_z_pos + bracket_ring_h / 2;

  // Experiment: attach boards with screws (and increase bracket thickness to 5mm)
  if (false /* render_screws */)
    for (y_pos = [- pb_hole_y, pb_hole_y]) {
      translate([2, y_pos, screw_z_pos])
        rotate([0, -90, 0])
          screw(M2p5_cap_screw, 8);
    }

  if (false /* render_screws */)
    for (y_pos = [- pi_hole_y, pi_hole_y]) {
      translate([18, y_pos, screw_z_pos])
        rotate([0, 90, 0])
          screw(M2p5_cap_screw, 6);
    }

  if (render_parts)
    color("#9898f8", 0.6)
      translate([0, 0, bracket_z_pos])
        rotate([0, 0, 0])
          pen_bracket();

  if (render_flanges)
    color("#5252b4", 0.5)
      translate([0, 0, 132])
        rotate([0, 180, 0])
          pen_flange();
}

//$fn = 60;
//pen_assembly();
