plexi_height=5.1;
total_height=30;
wall_thickness=2;

xy=10;

rotate([0,-90,0]){
	union(){
		translate([0,0,plexi_height + wall_thickness])
			cube([xy,xy,wall_thickness]);
		difference(){
			cube([xy,xy,total_height]);
			translate([wall_thickness,wall_thickness,wall_thickness])
			cube([xy,xy,total_height - wall_thickness * 2]);
		}
	}
}
