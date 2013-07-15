/*
 * A holder to make miniature spotlights out of LEDs.
 *
 * This uses square magnets to make contact with a power supply.
 * All units here are in mm.
 */

// Size of the magnets.
magnet_size=4.1;

// Distance from the center to the edge of the magnets.
center_offset=3;

// Diameter of the center hole.
center_hole=2;

// Height of the housing above the magnet.
height_above_magnets=2;

// Distance from the edge of the magnet to the edge of the housing.
magnet_to_wall=2;

// Size of the polarity keying.
key_size=1.25;

// Length of the resistor channel.
resistor_x=7;
// Width of the resistor channel.
resistor_y=2;

// Size of the hole for the resistor.
resistor_hole=2;


resistor_z=magnet_size;

top_h=height_above_magnets;

body_radius = magnet_size + center_offset + magnet_to_wall;
body_height=magnet_size+top_h;


rotate([-180,0,0]){
	difference(){
		// The main body of the holder.
		cylinder(h=body_height,r=body_radius,$fn=50);

		// Polarity key.
		translate([-body_radius,-body_radius,0])
			cube([key_size, body_radius*2, body_height]);

		// Left magnet (positive).
		translate([-magnet_size/2-center_offset,0,magnet_size/2]){
			magnet();
		}
		// Hole in the center for thick wire.
		cylinder(h=magnet_size+top_h,r=center_hole/2,$fn=20);

		// Channel bridging center to magnet.
		/*
		translate([0,0,magnet_size]){
			rotate([0,-90,0]){
				cylinder(h=center_offset+magnet_size,r=center_hole/2,$fn=20);
			}
		}
		*/

		// Channel to pass wire to center hole.
		translate([-4,-center_hole/2,0])
			cube([4,center_hole,magnet_size]);

		// Right magnet (negative).
		translate([magnet_size/2+center_offset,0,magnet_size/2]){
			magnet();
		}

		// Hole for resistor.
		translate([center_offset+resistor_y/2,magnet_size/2-resistor_y/2,0]){
			rotate([0,0,-45]){
				translate([-resistor_x,-resistor_y/2,0]){
						cube([resistor_x,resistor_y,resistor_z]);

					// Hole for wire on other side of resistor.
					translate([0,resistor_y/2,0]){
						cylinder(h=magnet_size+top_h,r=resistor_hole/2,$fn=20);
					}
				}
			}
		}
	}
}

module magnet(){
	cube([magnet_size,magnet_size,magnet_size],center=true);
}
