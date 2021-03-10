// External camera: Pi Zero mounted on a tray

include <flags.scad>

include <../vitamin/pi_zero.scad>

include <../part/pi_tray.scad>

module pi_tray_assembly() {
  // Move and rotate assembly into the final position
  translate([pi_slot_position, 0, tray_center_z])
    rotate([0, - 90, 0]) {

      if (render_parts)
        color("#9898f8", 0.6)
          pi_tray();

      if (render_electronics)
        translate([pi_mount.x, pi_mount.y, pi_tray_size.z + mount_standoff])
          rotate([0, 0, 180]) // Rotate so that the USB is facing up
            pi_zero();
    }
}

//$fn = 60;
//pi_tray_assembly();
