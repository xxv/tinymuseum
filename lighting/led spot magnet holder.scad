magnet_size=4.1;
center_offset=3;
center_hole=4;

rotate([-180,0,0]){
	difference(){
		// The main body of the holder.
		cylinder(h=magnet_size+1,r=magnet_size*2.2,$fn=50);

		// Left magnet.
		translate([-magnet_size/2-center_offset,0,magnet_size/2]){
			magnet();
		}
		// Right magnet.
		translate([magnet_size/2+center_offset,0,magnet_size/2]){
			magnet();
		}
		// Hole in the center for wires.
		cylinder(h=magnet_size+2,r=center_hole/2,$fn=20);

		translate([0,0,magnet_size-.5]){
			rotate([0,90,0]){
				cylinder(h=center_offset+magnet_size,r=1,$fn=20);
			}
		}

		// Hole bridging center to magnet.
		translate([0,0,magnet_size-.5]){
			rotate([0,-90,0]){
				cylinder(h=center_offset+magnet_size,r=1,$fn=20);
			}
		}
	}
}

module magnet(){
	cube([magnet_size,magnet_size,magnet_size],center=true);
}
