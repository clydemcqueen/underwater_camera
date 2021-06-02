// Copied from MCAD, fixed len() bug, simplified

module donutSlice(outerSize, innerSize, start_angle, end_angle)
{
  difference() {
    pieSlice(outerSize, start_angle, end_angle);
    circle(innerSize);
  }
}

module pieSlice(size, start_angle, end_angle) //size in radius
{
  tr = size * sqrt(2) + 1;
  a0 = (4 * start_angle + 0 * end_angle) / 4;
  a1 = (3 * start_angle + 1 * end_angle) / 4;
  a2 = (2 * start_angle + 2 * end_angle) / 4;
  a3 = (1 * start_angle + 3 * end_angle) / 4;
  a4 = (0 * start_angle + 4 * end_angle) / 4;
  if (end_angle > start_angle)
    intersection() {
      circle(size);
      polygon([
          [0, 0],
          [tr * cos(a0), tr * sin(a0)],
          [tr * cos(a1), tr * sin(a1)],
          [tr * cos(a2), tr * sin(a2)],
          [tr * cos(a3), tr * sin(a3)],
          [tr * cos(a4), tr * sin(a4)],
          [0, 0]
        ]);
    }
}
