magnet_size=4.1;
center_offset=3;
center_hole=2;
height_above_magnets=2;
magnet_to_wall=2;

resistor_x=6;
resistor_y=2.5;
resistor_z=4;

resistor_hole=1;

top_h=height_above_magnets;

rotate([-180,0,0]){
	difference(){
		// The main body of the holder.
		cylinder(h=magnet_size+top_h,r=magnet_size + center_offset + magnet_to_wall,$fn=50);

		// Left magnet.
		translate([-magnet_size/2-center_offset,0,magnet_size/2]){
			magnet();
		}
		// Hole in the center for thick wire.
		cylinder(h=magnet_size+top_h,r=center_hole/2,$fn=20);

		// Hole bridging center to magnet.
		translate([0,0,magnet_size]){
			rotate([0,-90,0]){
				cylinder(h=center_offset+magnet_size,r=center_hole/2,$fn=20);
			}
		}

		// Channel to pass wire to center hole.
		translate([-4,-center_hole/2,0])
			cube([4,center_hole,magnet_size]);

		// Right magnet.
		translate([magnet_size/2+center_offset,0,magnet_size/2]){
			magnet();
		}

		// Hole for resistor.
		translate([center_offset+resistor_y/2,magnet_size/2-resistor_y/2,0])
		rotate([0,0,-45]){
		translate([-resistor_x,-resistor_y/2,0]){
				cube([resistor_x,resistor_y,resistor_z]);

			// Hole for wire on other side of resistor.
			translate([0,resistor_y/2,0])
				cylinder(h=magnet_size+top_h,r=resistor_hole/2,$fn=20);
			}
		}
	}
}

module magnet(){
	cube([magnet_size,magnet_size,magnet_size],center=true);
}
