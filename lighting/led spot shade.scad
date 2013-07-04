led_diameter = 6.5;
interior_clearance = 1;
wall_thickness = .75;
resolution = 40;
shade_height = 12;
top_hole = 2;

base_radius = interior_clearance + led_diameter/2;

module shade(){
difference(){
    cylinder(h = shade_height+wall_thickness, r = base_radius+wall_thickness, $fn = resolution);
    cylinder(h = shade_height, r = base_radius, $fn = resolution);
	translate([0, 0, 10]){
	    cylinder(h = shade_height, r = top_hole, $fn = resolution);
	}
    }
}

rotate([180, 0, 0]){
    translate([0, 0, -shade_height-wall_thickness]){
	shade();
    }
}
