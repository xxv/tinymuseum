// Tiny Museum gallery

gallery = [408, 210, 257];
gallery_lip = [2, 2, 16];
gallery_extra_room = [0, 20, 80];


ply_thickness = 10.5; // 1|2in (2x 1/4" ply as measured with calipers)
//ply_thickness = 15.875; // 5|8in
//plywood_sheet=[12 * 4 * 25.4, 12 * 8 * 25.4,ply_thickness];
plywood_sheet=[12 * 4 * 25.4, 12 * 4 * 25.4,ply_thickness];

overhang = [100, 100, 0];
dado = [5, 10, 0];
peak_z = 149.26;
roof_overhang=30;
column_offset=3;

engrave_depth=2;

rear_access_hole=[30,20,0];

show_preview=1;
show_columns=1;

// preview only
trim_above_columns=[10,10,5];

//////////////////////////////////////////////////////////////////////

gallery_bound = gallery + gallery_lip * 2 - [0, 0, gallery_lip[2] * 2];
interior = gallery_bound + gallery_extra_room;

if (show_preview) {
  preview();
} else {
  projection(cut=true)
    lay_out(interior, ply_thickness, gallery, gallery_lip);
}

include <../facade/Parametric_Doric_Temple_Building_Set/fluted_column_12_steve.scad>;

module preview() {
  enclosure(interior, ply_thickness, gallery, gallery_lip);
% color([0.5,0.5,0.5,0.5])
  gallery(gallery, gallery_lip);

% color([0.5,0,0,0.3])
  cube(interior);

  if (show_columns) {
    column_lf();
    column_lm();
    column_lr();
  }


  trim = interior + trim_above_columns * 2 + [ply_thickness, 0,0] * 2 + [0, ply_thickness *2+ dado[1], 0];

  difference() {
    translate(-trim_above_columns -
              [ply_thickness, ply_thickness, -gallery[1] - gallery_lip[2]- trim_above_columns[2]])
      cube([trim[0], trim[1], trim_above_columns[2]]);

    translate([-trim_above_columns[0] -ply_thickness - 1,
                interior[1] + dado[1] + ply_thickness,
                0])
       cube(trim + [2,2,2]);
  }
}

//////////////////////////////////////////////////////////////////////

module lay_out(interior, ply_thickness_, window, window_offset) {
translate ([0,0,-ply_thickness])
% color("red")
  cube(plywood_sheet);

  spacing = 10;
  enc_bottom(interior, ply_thickness_, overhang);
  translate([0, interior[2] + spacing, 0]) {


      enc_side_r(interior, ply_thickness_, dado);
  translate([0,interior[1] + dado[1] + ply_thickness_ + spacing,0]) {

      rear(interior, ply_thickness_, peak_z, dado[0]);
  translate([0,interior[2] + peak_z + spacing,0]) {

   }}};

  translate([25.4 * 12 * 2,0,0]) {
    translate([0,interior[1] + ply_thickness_ * 5, ply_thickness_-0.01])
    rotate([180,0,0]){
    roof(interior, ply_thickness_, peak_z, roof_overhang);
    translate([interior[1]  + 50 + spacing,0,0])
      roof(interior, ply_thickness_, peak_z, roof_overhang);
      }
    translate([0, interior[1] + ply_thickness_ * 5 + spacing,0]){

    translate([0, interior[1] + dado[1] + ply_thickness_, ply_thickness_-0.01])
      rotate([180, 0, 0])
        enc_side_l(interior, ply_thickness_, dado);
    translate([0,interior[1] + spacing + dado[1] + ply_thickness_,0]) {

    front(interior, ply_thickness_, peak_z, window, window_offset);
    }}};
}

module enclosure(interior, ply_thickness_, window, window_offset) {

  translate(-(overhang/2) + [0,0,-ply_thickness_])
    enc_bottom(interior, ply_thickness_, overhang);

  rotate([0,-90,0])
    enc_side_l(interior, ply_thickness_, dado);

  translate([interior[0]+ply_thickness_, 0, 0])
      rotate([0,-90,0])
        enc_side_r(interior, ply_thickness_, dado);

  translate([-ply_thickness_, interior[1] + ply_thickness_, 0])
    rotate([90,0,0])
      rear(interior, ply_thickness_, peak_z, dado[0]);

  translate([-ply_thickness_, 0,0])
  rotate([90,0,0])
    front(interior, ply_thickness_, peak_z, window, window_offset);

  angle = atan(peak_z / (interior[0]/2 + ply_thickness_));
  translate([-ply_thickness_, -ply_thickness_ - roof_overhang, interior[2]])
    rotate([0,-angle,0])
      roof(interior, ply_thickness_, peak_z, roof_overhang);

  translate([interior[0]+ply_thickness_, -ply_thickness_ - roof_overhang, interior[2]])
  mirror([1,0,0])
    rotate([0,-angle,0])
      roof(interior, ply_thickness_, peak_z, roof_overhang);
}

module column_lm() {
  difference() {
    translate([-column_offset,(interior[1]+dado[1])/2,5])
      full_column();

  translate([-ply_thickness,50,-5])
    cube(interior);
    translate([-50,interior[1]+dado[1]+ply_thickness,-5])
      cube(interior);
  }
}
module column_lr() {
  difference() {
    translate([-column_offset,interior[1]+dado[1],5])
      full_column();

  translate([-ply_thickness,50,-5])
    cube(interior);
    translate([-50,interior[1]+dado[1]+ply_thickness,-5])
      cube(interior);
  }
}

module column_lf() {
  difference() {
    translate([-column_offset,-column_offset,5])
      full_column();

    translate([-ply_thickness,0,-5])
    cube(interior);
    translate([0,0,-0.1])
    enclosure(interior, ply_thickness, gallery, gallery_lip);
  }
}

module front(interior, ply_thickness_, peak_z, window, window_offset) {
  eng = "museum_engraving.dxf";
  eng_w = dxf_dim(file=eng, name="TotalWidth", layer="dimensions", scale=1);
  eng_h = dxf_dim(file=eng, name="TotalHeight", layer="dimensions", scale=1);

  peaked_dim = interior + [ply_thickness_ * 2, 0, 0];

  difference() {
    peaked(peaked_dim, ply_thickness_, peak_z);
    translate([window_offset[0] + ply_thickness_, window_offset[2], -ply_thickness_])
      cube(window + [0, 0, ply_thickness_ * 2]);
     translate([peaked_dim[0]/2 - eng_w/2,
                 window[1] + window_offset[2] + 18,
                 ply_thickness_-engrave_depth])
        linear_extrude(height=(ply_thickness_+engrave_depth+1))
          import(eng);
  }
}

module rear(interior, ply_thickness_, peak_z, dado) {
  difference() {
    peaked(interior + [ply_thickness_*2,0,0], ply_thickness_, peak_z);
    cube([ply_thickness_ - dado, interior[2] * 2, ply_thickness_]);
    translate([interior[0] + ply_thickness_ + dado, 0,0])
      cube([ply_thickness_ - dado, interior[2] * 2, ply_thickness_]);
    // wire access hole
    translate([ply_thickness_+interior[0]/2 - rear_access_hole[0]/2,0,-ply_thickness_/2])
      cube(rear_access_hole + [0,0,ply_thickness_*2]);
  }
}

module peaked(interior, ply_thickness_, peak_z) {
  linear_extrude(height=ply_thickness_)
  polygon(points = [ [0,0], [interior[0], 0], [interior[0], interior[2]],
                     [interior[0]/2, interior[2] + peak_z],
                     [0, interior[2]] ] );
}

module enc_side_r(interior, ply_thickness_, dado) {
    translate([0,0,ply_thickness_])
    mirror([0,0,1])
      enc_side_l(interior, ply_thickness_, dado);
}

module enc_side_l(interior, ply_thickness_, dado) {
  e = [interior[2], interior[1] + dado[1] + ply_thickness_, ply_thickness_];

  difference(){
    cube(e);
    translate([0, interior[1], 0])
      cube([interior[2], ply_thickness_, dado[0]]);
  }

}

module enc_bottom(interior, ply_thickness_, overhang) {
  e = interior + overhang;

  cube([e[0], e[1], ply_thickness_]);
}

module roof(interior, ply_thickness_, peak_z, front_overhang) {
  angle = atan(peak_z / (interior[0]/2 + ply_thickness_));
  e = [sqrt(pow(interior[0]/2,2) + pow(peak_z,2)) +  tan(90-angle) * ply_thickness_,
       interior[1] + ply_thickness_ * 3 + front_overhang,
       ply_thickness_];
   difference() {
    cube(e);
    translate([e[0], 0, ply_thickness_])
     rotate([0,angle,0])
     translate([0,0,-ply_thickness_*3])
     cube([ply_thickness_ * 2, e[1], ply_thickness_ * 3]);
  }
}

module gallery(gallery_, gallery_lip_) {
  translate([gallery_lip_[0], gallery_lip[1],0])
  cube (gallery_);

  cube([gallery_[0] + gallery_lip_[0]*2,
        gallery_[1] + gallery_lip_[1]*2,
        gallery_lip_[2]]);

  translate([0,
             0,
             gallery_[2]-gallery_lip_[2]])
  cube([gallery_[0] + gallery_lip_[0]*2,
        gallery_[1] + gallery_lip_[1]*2,
        gallery_lip_[2]]);
}
