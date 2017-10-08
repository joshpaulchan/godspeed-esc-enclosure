
include <constants.scad>;

/*
Generates the U-shaped base of the `level` part

@param    decimal   w   width of the inner cover
@param    decimal   l   length of the inner cover
@param    decimal   t   thickness of the plate
@param    decimal   wp  width-wise padding on each side
@param    decimal   lp  length-wise padding at bottom-most side  
*/
module level_base(w, l, t, hp, vp) {
  difference() {
    cube([w + 2*hp, l + vp, t], $fn=$FN);
    translate([hp, vp, 0]) cube([w, l+vp, t], $fn=$FN);
  }
};

module level_mount(t) {
  cylinder(h=t, d=8, $fn=$FN);
};

/*
Generates the `level` part of the ESC enclosure assembly

@param    decimal   w   width of the inner cover
@param    decimal   l   length of the inner cover
@param    decimal   t   thickness of the plate
@param    decimal   wp  width-wise padding on each side
@param    decimal   lp  length-wise padding at bottom-most side
*/
module level(w, l, t, hp, vp) {
  mid_wp = hp / 2;
  mid_vp = vp / 2;
  
  difference() {
    // base
    level_base(w, l, t, hp, vp);
    
    // 4 mount points
    translate([mid_wp, mid_vp, 0]) {
      translate([0, 0, 0])  level_mount(t);
      translate([w+hp, 0, 0])  level_mount(t);
      translate([0, l, 0])  level_mount(t);
      translate([w+hp, l, 0])  level_mount(t);  
    }
    
  }
}

level(
  w=COVER_BASE_WIDTH,
  l=COVER_BASE_LENGTH,
  t=COVER_BASE_THICKNESS,
  hp=LEVEL_HORIZONTAL_PADDING,
  vp=LEVEl_VERTICAL_PADDING
);
