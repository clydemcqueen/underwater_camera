include <NopSCADlib/core.scad>
include <../include/pie_slice.scad>
include <../include/nut_hole.scad>
include <../vitamin/blue_robotics.scad>

// Camera height includes tube, flanges, port, screws -- everything
fake_camera_h = 150;
fake_camera_r = tube_r_outside;

// Mount is taller than the camera so that it can hold the camera in place
rcm_holder_h = 5;
rcm_holder_r = tube_r_outside - 6;

// Minimum thickness after knockout
rcm_thickness = [2.5, 2.5];

// Mount size before camera knockout
rcm_size = [fake_camera_r + rcm_thickness.x,
    fake_camera_r + rcm_thickness.y,
    fake_camera_h + 2 * rcm_holder_h];

// Position of the camera (and knockout) relative to the mount (center=true)
rcm_cam_pos = [fake_camera_r - rcm_size.x / 2 + rcm_thickness.x,
      fake_camera_r - rcm_size.y / 2 + rcm_thickness.y, 0];

// Channel height == height of zip tie plus some room
ztc_h = 3;

// Channel width == width of zip tie plus some room
ztc_w = 6;

// Zip tie channel radius
ztc_inner_r = 15;
ztc_center_r = ztc_inner_r + ztc_h / 2;
ztc_outer_r = ztc_inner_r + ztc_h;

// Force channel to surface
ztc_nudge = 0.2;

// Zip tie placements
ztc_placement_x = rcm_thickness.x - rcm_size.x / 2 - ztc_h / 2 + ztc_nudge;
ztc_placement_y = rcm_thickness.y - rcm_size.y / 2 - ztc_h / 2 + ztc_nudge;
ztc_placement_zs = [- 45, 0, 45];

// M4 screws and nuts
rcm_screw_r = 4 / 2;
rcm_nut_r = nut_radius(M4_nut) - 0.1;

module zip_tie_channel_2d() {
  big_distance = 40;

  translate([ztc_center_r, ztc_center_r])
    donutSlice(ztc_outer_r, ztc_inner_r, 180, 270);
  translate([0, big_distance / 2 + ztc_center_r])
    square([ztc_h, big_distance], center = true);
  translate([big_distance / 2 + ztc_center_r, 0])
    square([big_distance, ztc_h], center = true);
}

module zip_tie_channel() {
  linear_extrude(ztc_w, center = true)
    zip_tie_channel_2d();
}

module rear_cam_mount() {
  difference() {
    cube(rcm_size, center = true);
    translate(rcm_cam_pos) {
      cylinder(r = fake_camera_r, h = fake_camera_h + 0.1, center = true);
      cylinder(r = rcm_holder_r, h = rcm_size.z + 0.1, center = true);
    }

    // Zip tie channels
    for (ztc_placement_z = ztc_placement_zs) {
      translate([ztc_placement_x, ztc_placement_y, ztc_placement_z])
        zip_tie_channel();
    }

    // Screw holes
    for (pos_z = [- 27, 27]) {
      translate([- 11, - 5, pos_z])
        rotate([0, 90, 0])
          nut_hole(rcm_nut_r, rcm_screw_r, 20);
    }
  }
}
