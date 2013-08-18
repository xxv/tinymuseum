// Inner height
i_height=30;

// Thickness of the walls
wall_thickness=3;

// Inner diameter
i_diameter=81;

// Wall-mount thickness
wm_thickness=2;

// The size of the tooth
tooth_x=2;
tooth_y=4;
tooth_z=2;
tooth_z_offset=2;

// How much wider the channel is (cross-section) than the tooth
tooth_channel_mult = sqrt(2)*2;

// The slot for the lock hasp, x
slot_x=8;
// The slot for the lock hasp, y
slot_y=33;

// Height above the channel to allow for screwing
screw_height=10;
// How steep an angle the screw is
screw_angle=45;
// How much to rotate the whole screw mechanism
screw_angle_offset=90;

// The length of the notch to lock the screw in place.
screw_lock=5;

// Thickness behind the channel
behind_channel = 1;

// Clearance between 3D printed parts that need to touch
clearance=0.50;

// Separation between the wall side and the cover
part_separation=5;

// LQ
//$fa=1;
//$fs=1;

// HQ
$fa=.5;
$fs=.1;

tooth_x_offset=i_diameter/2-tooth_x;

cover();

// Separate the two parts
translate([i_diameter + wall_thickness + part_separation,0,0]){
  wall_mount();
}

module tooth(){
  translate([tooth_x_offset,-tooth_y/2,i_height-tooth_z_offset-tooth_z+ wall_thickness-tooth_z]){
    difference(){
      cube([tooth_x+clearance, tooth_y, tooth_z*2]);
    translate([-tooth_y * sqrt(2)/2, -clearance/2, -tooth_y * sqrt(2)/2+tooth_y/2])
    rotate([0, 45, 0])
      cube([tooth_y,tooth_y+clearance,tooth_z*2]);
    }
  }
}

module cover(){
  // Outer cover
  union(){
    difference(){
      cylinder(h=i_height+wall_thickness,r=i_diameter/2+wall_thickness);
      translate([0,0,wall_thickness])
      cylinder(h=i_height+clearance,r=i_diameter/2);
    }
    rotate([0,0,180])
      tooth();
    tooth();
  }
}

module wall_mount(){
  // Inner holder
  union(){
    difference(){
      cylinder(h=screw_height+ tooth_z_offset + tooth_z+wm_thickness,r=i_diameter/2 - clearance);

      // Screw mechanism
      rotate([0,0,screw_angle_offset]){
	translate([0,0,wm_thickness])
	  cylinder(h=screw_height+ tooth_z_offset+tooth_z+wm_thickness, r=i_diameter/2-wall_thickness-behind_channel - clearance);
	tooth_channel();
	rotate([0,0,180])
	  tooth_channel();
	// Remove unnecessary walls.
	translate([-i_diameter/2,-i_diameter/4,wm_thickness])
	  cube([i_diameter,i_diameter/2,i_height]);
	rotate([0,0,-screw_angle])
	  translate([-i_diameter/2,-i_diameter/4,wm_thickness])
	    cube([i_diameter,i_diameter/2,i_height]);
      }

      // Slot for lock hasp
      translate([-slot_x/2,i_diameter/2-slot_y-wall_thickness,0])
	cube([slot_x,slot_y,wm_thickness+clearance]);
    }
  }
}

module tooth_channel(){
  channel_size=tooth_y * tooth_channel_mult;
  union(){
    translate([0,0,tooth_z_offset]){
      linear_extrude(height=wm_thickness + tooth_z+screw_height, convexity=10, twist = screw_angle){
      translate([-channel_size/2,tooth_x_offset - clearance,0]){
	square([channel_size, tooth_x + wall_thickness]);
      }
    }
  }

  intersection(){
    difference(){
      translate([0,0,wm_thickness])
	cylinder(h=tooth_z, r=i_diameter/2+clearance);
      translate([0,0,-2.5])
	cylinder(h=tooth_z*5, r=i_diameter/2-wall_thickness+clearance);
    }
    rotate([0,0,-screw_angle_offset+screw_lock])
      translate([-i_diameter/2,-screw_lock/2,wm_thickness])
	cube([i_diameter,screw_lock,i_height]);
    }
  }
}

