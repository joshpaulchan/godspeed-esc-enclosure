
echo(version());

UNIT = 25.4;
$fn = 100;

module mount_hole(depth, sz=3) {
  if (sz==3) { r = 0.3 * UNIT; }
  else if (sz==4) { r = 0.4 * UNIT; }
  else { r = 0.3 * UNIT; }
  
  linear_extrude(2*depth, center=true) circle(1.25 * r, $fn=$fn);
}

/*
Generates a nut boss that seats a captive nut in the piece.
*/
module m4_nut_boss(l, p=3.17, vp=3.17) {
  m = 4; // (mm) diameter of m4 bolt
  g = 7.66; // (mm) major diameter of m4 hex nut
  h = 3.2; //(mm) max height of m4 hex nut
  
  p = 3.17; // (mm) horizontal padding
  vp = 3.17 / 2; // (mm) vertical padding
  
  L = g + p;
  H = l+h+vp;
  
  eps = 1.05; //corrective multiplier
  
  difference() {
    translate(v=[-L/2, -L/2, 0]) cube([L, L, H], $fn=$fn);
    translate([0, 0, vp+l]) cylinder(h=h, d=eps*g, $fn=$fn);
    cylinder(h=H, d=eps*m, $fn=$fn); // 1.1d to account for print shrinkage
  }
}

/*
Generates a nut boss that seats a captive nut in the piece.
*/
module mx_nut_boss(l, p=3.17, vp=3.17) {
  m = 4.62 * 1.1; // (mm) diameter of m4 bolt
  g = 10.82 * .97; // (mm) major diameter of m4 hex nut
  h = 3.2; //(mm) max height of m4 hex nut
  
  p = 3.17; // (mm) horizontal padding
  vp = 3.17 / 2; // (mm) vertical padding
  
  L = g + p;
  H = l+h+vp;
  
  eps = 1.05; //corrective multiplier
  
  difference() {
    translate(v=[-L/2, -L/2, 0]) cube([L, L, H], $fn=$fn); // outer shape
    translate([0, 0, vp+l]) cylinder(h=h, d=eps*g, $fn=$fn); // nut seat
    cylinder(h=H, d=eps*m, $fn=$fn); // bolt hole
  }
}

mx_nut_boss(10, vp=6.34);
