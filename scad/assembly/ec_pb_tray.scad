// External camera: PowerBoost mounted on a tray

include <flags.scad>

include <../vitamin/adafruit.scad>

include <../part/pb_tray.scad>

module pb_tray_assembly() {
  // Move and rotate assembly into the final position
  translate([pb_slot_position, 0, tray_center_z])
    rotate([0, - 90, 180]) {

      if (render_parts)
        color("#9898f8", 0.6)
          rotate([180, 0, 0])
            pb_tray();

      if (render_electronics)
        translate([pb_mount.x, pb_mount.y, - pb_tray_size.z - mount_standoff])
          rotate([180, 0, 0])
            power_boost();
    }
}

//$fn = 60;
//pb_tray_assembly();
