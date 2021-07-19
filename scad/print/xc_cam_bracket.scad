include <../part/xc_cam_bracket.scad>

// Hi-def render
$fn = 60;

// lens_adapter == true: print 2 standoffs
// lens_adapter == true: print all 4 standoffs
cam_bracket(lens_adapter = false);