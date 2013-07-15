/*
 * An LED spotlight shade.
 *
 * To prevent the can from glowing, cut a piece of flexible
 * opaque reflective material (aluminum foil, shiny anti-static bag)
 * to fit between the LED and the can wall. This should be 11x24mm (this
 * gives you 2mm overlap).
 */

led_diameter = 6.5;
interior_clearance = 1;
wall_thickness = .75;
resolution = 40;
shade_height = 12;
// Diameter of the top holes
top_hole = 1.25;
// Distance between the top holes
top_hole_separation=2;

base_radius = interior_clearance + led_diameter/2;

module shade(){
difference(){
    cylinder(h = shade_height+wall_thickness, r = base_radius+wall_thickness, $fn = resolution);
    cylinder(h = shade_height, r = base_radius, $fn = resolution);
	// Top holes
	translate([0, 0, 10]){
	    translate([(top_hole_separation+top_hole)/2,0,0])
	    cylinder(h = shade_height, r = top_hole/2, $fn = resolution);
	    translate([-(top_hole_separation+top_hole)/2,0,0])
	    cylinder(h = shade_height, r = top_hole/2, $fn = resolution);
	}
    }
}

rotate([180, 0, 0]){
    translate([0, 0, -shade_height-wall_thickness]){
	shade();
    }
}
