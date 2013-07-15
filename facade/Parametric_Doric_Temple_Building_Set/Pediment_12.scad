coldiameter = 17;
mod = coldiameter;					//this is the diameter of a column
cpo = mod/10; 						// capitol offset, to determine depth
depth = (mod + (cpo*2))* 1.0;  	//allows over or under hang if desired

//height = mod * 6;					//height of a column if you use this comment out the one below
ch = mod*5* 1.24;					//height of a column
//length = 90;
//width = (length * 7/6) * .618;  					//golden rectangle
//length = ch * .618;  								// for golden rectangle

n_o_c = 6;											//number of columns across front of temple
length = ((ch*1.618)*1.618)/(n_o_c-1); 		//comment either this or the other def out before compiling
echo ("Length",length);							//if used, front of temple is golden rectangle
p_overhang = mod;
p_width = (length * (n_o_c-1)) + + mod + p_overhang;	//overall width of pediment
echo("p_width=", p_width);
p_length = p_width/4;
echo("p_length=", p_length);

height = ch/15;

f_height = height*2;		  //frieze height
c_height = height *2/3;		  //cornice height
p_height = (ch * .618) - f_height - c_height;
echo("p_height", p_height);
angle = atan(p_height/(p_width/2));
top_angle = 180 - (angle*2);
echo("angle=",top_angle);
hl = p_length/cos(angle)*1.02;

pediment_end();
//pediment_middle();
//join_plates();

module pediment_end() {
	cube([p_length,depth,p_length/50]);												//base
	translate([p_length/5,0,0]) cube([p_length*.8,p_length/40,p_length/15]);	//back flange
	difference() {
		union() {
			rotate([0,-angle,0]) translate([0,0,-p_length/30])
				cube([hl,depth*.9,p_length/25]);										//lower top
			rotate([0,-angle,0])	translate([0,0,0]) 
				cube([p_length*1.05,depth,p_length/40]);							//upper top
						//top flange
			rotate([0,-angle,0])	translate([p_length/5,0,-p_length/12.5]) 
				cube([hl*.8,p_length/40,p_length/15]);								//top flange
		}
	translate([p_length,0,0]) cube([p_length/25,depth,p_length/2]);			//make far end vertical
	translate([0,0,-p_length/25]) cube([p_length,depth,p_length/25]);			//smooth bottom
	rotate([0,-angle,0])	translate([p_length*.7,0,-depth/12.5]) 					//slot 
		cube([p_length/2.5,depth*.75,p_length/30]);
	}
}


module pediment_middle() {
	cube([p_length,depth,p_length/50]);											//base
	cube([p_length,p_length/40,p_length/15]);										//back flange
	difference() {
		union() {
			rotate([0,-angle],0) translate([0,0,p_length/8])
				cube([hl*1.05,depth*.9,p_length/25]);								//lower top
			rotate([0,-angle,0])	translate([0,0,p_length/8+p_length/25]) 
				cube([hl*1.05,depth,p_length/40]);									//upper top
			rotate([0,-angle,0])	translate([0,0,p_length/15]) 
				cube([hl*1.05,p_length/40,p_length/15]);							//top flange
		}
	translate([p_length,0,0]) cube([p_length/12,depth,p_length/1.5]);			//make far end vertical
	translate([-p_length/12,0,0]) cube([p_length/12,depth,p_length/2]);		//make near end vertical
	//translate([0,0,-p_length/25]) cube([p_length,depth,p_length/25]);		//smooth bottom
	rotate([0,-angle,0])	translate([p_length*.0,0,depth/10+p_length/8.75])	//lower slot 
		cube([p_length/3,depth*.75,p_length/30]);
	rotate([0,-angle,0])	translate([hl*.7,0,depth/10+p_length/8.75])			//upper slot 
		cube([p_length/2.75,depth*.75,p_length/30]);
	}
}

module join_plates() {
	translate([-p_length/120,-p_length/40,0]) 
		cube([p_length/4,depth*.7,p_length/40]);							//center angle joiner right
	rotate([90,0,0]) translate([-p_length/100,-depth*.25,0])
		cube([p_length/4,depth*.25,p_length/40]);							//center angle joiner flange right
	
	rotate([0,top_angle,0]) translate([-p_length/120,-p_length/40,-p_length/40])	//center angle joiner left 
		cube([p_length/4,depth*.70,p_length/40]);
	rotate([90,top_angle,0]) translate([-p_length/100,0,0]) 					//center angle joiner flange left
		cube([p_length/4,depth*.25,p_length/40]);

	translate([0,-p_length/40,10]) 
		cube([p_length/4,depth*.25,p_length/40]);
	rotate([90,0,0]) translate([0,10,0]) 											//base plate
		cube([p_length/4,depth*.7,p_length/40]);

	translate([0,-p_length/40,depth*1.5]) 
		cube([p_length/4,depth*.25,p_length/40]);
	rotate([90,0,0]) translate([0,depth*1.5,0])  								//base plate #2
		cube([p_length/4,depth*.7,p_length/40]);
}


