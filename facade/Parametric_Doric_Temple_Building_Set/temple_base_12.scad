coldiameter = 17;
mod = coldiameter;
ch = mod*5* 1.24;
echo("ch=",ch);
bo = mod/8; 							// base offset
btr = bo*.625;  							//base torus radius
cbdiameter = mod+(bo*2);			//diameter of column base (for inset)
//b_length = ch/1.618;					//make length a golden rectangle
n_o_c = 6;								//number of columns across front of temple
b_length = ((ch*1.618)*1.618)/(n_o_c-1); 	//comment either this or the other def out before compiiing
echo ("Length",b_length);							//if used, front of temple is golden rectangle
b_width = 2.5*((mod/2)+bo+btr);
echo("Width",b_width);
b_diff = b_length-b_width;
echo("Diff",b_length-b_width);
b_height = cbdiameter/7;
step_width = b_height * 2;
$fs = 1;


//straight_base();
//translate([0,b_width+15,0]) straight_base();
//steps(2);
//corner_base();
//rotate([0,0,90]) translate([-b_width/2.35,-b_width/3.5+5,0])
//corner_steps(2);
step_unit(2);
//corner_unit(2);

//echo((mod/2)-(bo*1.67));		//post diameter

module corner_unit(flights) {
	corner_base();
	rotate([0,0,180]) translate([-b_width-b_diff/2,-b_width-b_diff/2,0]) 
		corner_steps(flights);
}

module step_unit(flights) {
	rotate([0,0,180]) translate([-b_length*2+b_width/2,-b_width,0]) 
	 	union() { straight_base(); steps(flights);}
}

module large_corner_unit(flights) {
	rotate([0,0,180]) translate([-b_length*2+b_width/2,-b_width,0]) 
	 	union() { straight_base(); steps(flights);}
	translate([b_width,b_length-b_width/2,0]) rotate([0,0,90]) 
		union() { straight_base(); steps(flights);}
	corner_base();
	rotate([0,0,180]) translate([-b_length+b_width/2,-b_length+b_width/2,0]) 
		corner_steps(flights);
}

module corner_steps(flights) {
for ( i = [1 : flights] ) {
	translate([0,0,-b_height*i])
	difference() {
		union() {
			cube([b_length/2+b_width/2+(step_width*i),b_length/2+b_width/2+(step_width*i),b_height]);
			translate([b_width/1.074,-b_width/4.2,0]) cube([b_width/6,b_width/4.15,b_height]);  			//key
		}
		translate([0,b_width-b_width/(12*.92),0]) cube([b_width/4,b_width/(6*.94),b_height]);   //notch
		translate([b_width/3,b_width/3,0]) 
		cube([b_length/2+(step_width*(i-1)),
			b_length-b_length/2+(step_width*(i-1)),b_height+b_height/10]);   //hollow
	}
}
}

module corner_base() {
difference() {
	union() {
	cube([b_length/2+b_width/2,b_width,b_height]);			//base leg
	cube([b_width, b_length/2+b_width/2, b_height]);		//base leg
	translate([b_width/2,b_width/2,b_height*.75])
		cylinder(h=b_height*3,r1=(mod/2)-(bo*1.67),r2=(mod/2)-(bo*1.85));	//post
	}
	translate([b_width/8,b_width/8,0])
		cube([b_length/2.2,b_length/2.2,b_height/2]);				//hollow
	}
}

module steps(flights) {
for ( i = [1 : flights] ) {
	translate([0,0,-b_height*i])
	difference() {
		union() {
			cube([b_length,(step_width*i)+b_width,b_height]);							  //main block
			translate([b_length,b_width/2,0]) cube([b_width/4.15,b_width/6,b_height]);  //key
		}
		translate([0,b_width/2,0]) cube([b_width/4,b_width/(6*.95),b_height]);   //notch
		translate([b_length/5,b_width/20,0]) cube([b_length-b_length/3.25,
				b_width-b_width/10+(step_width*(i-1)),b_height+b_height/10]);	//hollow
	}
		translate([0,-b_width/3,-b_height*i])  cube([b_length,b_width/3,b_height]);	//back shelf
	}
}

module straight_base() {
difference() {
	union() {
	cube([b_length,b_width,b_height]);
	translate([b_length/2,b_width/2,b_height*.75])
		cylinder(h=b_height*3,r1=(mod/2)-(bo*1.67),r2=(mod/2)-(bo*1.85));   //fudge factor
		}
	translate([b_length/20,b_width/5,0])
		cube([b_length/2-(b_length/10),b_width-(2*b_width/5),b_height/2]);
	translate([b_length/20+b_length/2,b_width/5,0])
		cube([b_length/2-(b_length/10),b_width-(2*b_width/5),b_height/2]);}
}

