
include <constants.scad>;

module cover_shape(w, l) {
  resize([w, l]) {
    square([1, 1], center=true);
    *circle(d=1, center=true, $fn=$FN);
  }
}

module cover_base(w, l, t, iw, il, it) {
  translate([0, 0, t/2]) linear_extrude(t, center=true) difference() {
    square([w, l], center=true);
    cover_shape(iw-2*it, il-2*it, t);
  }
}

module cover_slot(w, l, h) {
  rotate(a=90, v=[1, 0, 0]) linear_extrude(h, center=true) translate([-w/2, 0, 0]) hull() {
    square([w, l/2]);
    translate([w/2, (l-w/2), 0]) circle(d=w, $fn=$FN);
  }
}

module cover_mid(ow, ol, wt, h, scale) {
  linear_extrude(h, scale=scale) {
    difference() {
      cover_shape(ow, ol);
      offset(r=-wt) cover_shape(ow, ol);
    }
  }
}

module cover_top(iw, il, ot, ih, is) {
  translate([0, 0, ih]) linear_extrude(ot) cover_shape(iw*is, il*is);
}

/*
Generates the `cover` part of the esc enclosure assembly.

@param    decimal   ow    the outer width (bounding box) of cover
@param    decimal   ol    the outer length (bounding box) of cover
@param    decimal   ihp   the inner horizontal padding of cover
@param    decimal   ivp   the inner vertical padding of cover
@param    decimal   oh    the outer height of the entire cover
@param    decimal   ts    the scale of the top part
*/
module cover(ow, ol, ot, ihp, ivp, oh, ts) {
  iw = ow - ihp;
  il = ol - ivp;
  ih = oh - ot;
  union() {
    // build base
    cover_base(ow, ol, ot, iw, il, ot);
    
    // build top
    translate([0, 0, ot]) {
      difference() {
        // build sloped middle
        cover_mid(iw, il, ot, ih, ts);
        
        translate([0, il/2, 0])   cover_slot(0.5 * UNIT, 0.75 * UNIT, 20);
        translate([0, -il/2, 0])  cover_slot(0.5 * UNIT, 0.75 * UNIT, 20);
      }
      
      // build top cover
      cover_top(iw, il, ot, ih, ts);
    }
  }
}


cover(
  ow=COVER_BASE_WIDTH,
  ol=COVER_BASE_LENGTH,
  ot=COVER_BASE_THICKNESS,
  ihp=COVER_HORIZONTAL_PADDING,
  ivp=COVER_VERTICAL_PADDING,
  oh=COVER_HEIGHT,
  ts=COVER_TOP_SCALE
);
