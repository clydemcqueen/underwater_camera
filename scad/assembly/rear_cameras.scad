// Show 2 cameras hanging off the back of the ROV

include <../vitamin/blue_robotics.scad>
include <../part/rear_cam_mount.scad>

// Inside width of the ROV frame
rov_inside_w = 319;

// Side panel fairing inset (distance from rear of ROV to fairing supports)
fairing_inset = 24;

// Mount placements (left and right)
lmount_placement = [fairing_inset - rcm_size.y / 2, rov_inside_w / 2 - rcm_size.x / 2, 100];
lmount_rotation = [0, 180, 90];
rmount_placement = [lmount_placement.x, - lmount_placement.y, lmount_placement.z];
rmount_rotation = [0, 0, 90];

// Rear of the BlueROV2 (original BR STL cut with Prusa slicer to save space & time)
// Rotated and translated into the ROS robot coordinate frame for convenience
module rov_assembly() {
  translate([0, - 125, 0])
    rotate([90, 0, 90])
      import("../vitamin/small_br.stl", convexity = 10);
}

// Fake camera to keep things simple
module fake_camera() {
  cylinder(r = tube_r_outside, h = fake_camera_h, center = true);
}

// Left and right camera and mount
module stereo_assembly() {
  translate(lmount_placement) {
    rotate(lmount_rotation) {
      color("gray")
        rear_cam_mount();
      color("blue", 0.4)
        translate(rcm_cam_pos)
          fake_camera();
    }
  }

  translate(rmount_placement) {
    rotate(rmount_rotation) {
      color("gray")
        rear_cam_mount();
      color("blue", 0.4)
        translate(rcm_cam_pos)
          fake_camera();
    }
  }
}


$fn = 60;
rov_assembly();
stereo_assembly();
