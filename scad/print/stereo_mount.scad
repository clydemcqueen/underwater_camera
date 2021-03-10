include <../part/stereo_mount.scad>

// Hi-def render
$fn = 60;

// TODO move to library
module cut(knife_size, knife_pos) {
  intersection() {
    translate(knife_pos)
      cube(knife_size, center = true);
    children();
  }
}

// cut([15, 10, 50], [0, 45, 30])
stereo_mount();
