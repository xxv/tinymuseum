// thickness of the outer wall
wall_thickness=1.5;
// size of male connector
male_x=7;
male_y=10;
male_z=4.3;
// size of female housing
female_y=20;
// extra height above male connector for electronics
female_z_extra=2;
male_z_extra=1;
// the amount of offset to make differences work right
diff_offset=.01;

// contact channel width
contact_channel_x=1.5;
contact_channel_y=40;
contact_channel_z=1.5;
// how much of a lip to give the contact channel
contact_channel_recess=1;
contact_channel_separation=3;

// How much extra to add to account for extrusion inaccuracies
extrusion_offset=0.25;

module female(){
	difference(){
		cube([male_x+wall_thickness*2+extrusion_offset*2,
				female_y,
				male_z+wall_thickness*2 + female_z_extra+extrusion_offset*2]);
		translate([wall_thickness,-diff_offset,wall_thickness]){
			cube([male_x + extrusion_offset*2,male_y+diff_offset,male_z + extrusion_offset*2]);
		}
	contact_channel(male_x +extrusion_offset*2,male_y,male_z+ extrusion_offset*2);
	}
}

module contact_channel(x,y,z){
		// one contact left
		translate([(wall_thickness + x/2)-contact_channel_separation/2-contact_channel_x/2,contact_channel_recess,z+wall_thickness]){
			cube([contact_channel_x,contact_channel_y,contact_channel_z]);
		}
		// right contact
		translate([(wall_thickness + x/2)+contact_channel_separation/2-contact_channel_x/2,contact_channel_recess,z+wall_thickness]){
			cube([contact_channel_x,contact_channel_y,contact_channel_z]);
		}
}

module male(){
	difference(){
		union(){
			translate([wall_thickness,0,0]){
				cube([male_x - extrusion_offset*2, male_y, male_z - extrusion_offset*2]);
			}
			translate([-extrusion_offset*2,male_y,-extrusion_offset*2]){
				cube([male_x+wall_thickness*2 + extrusion_offset*2, male_y, male_z+wall_thickness+male_z_extra+extrusion_offset*2]);
			}
		}
	contact_channel(male_x-extrusion_offset*2,male_y,male_z-contact_channel_z-wall_thickness+diff_offset-extrusion_offset*2);
	}
}

rotate([-90,0,0]){
	male();
}
