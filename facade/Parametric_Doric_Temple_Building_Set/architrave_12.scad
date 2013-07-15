coldiameter = 17;
mod = coldiameter;
cpo = mod/10; // capitol offset
ch = mod*5* 1.24;
colid = 10.25;  			   		 //inner (open) diameter of column
colih = mod/3;				  	 // height of boss for column
//length = ch * .618;  			// for golden rectangle
n_o_c = 6;										//number of columns across front of temple
length = ((ch*1.618)*1.618)/(n_o_c-1); 	//comment either this or the other def out before compiiing
echo ("Length",length);									//if used, front of temple is golden rectangle
height = ch/15;
width = (mod + (cpo*2))* 1.0;  		//allows over or under hang if desired
angle = 1;

echo("Width=",width);

f_overhang = 2;			  //frieze overhang
f_height = height*2;		  //frieze height
f_d = .03; 					// amount of triglyph inset

c_overhang = mod/6;			  //cornice overhang
c_height = height *2/3;		  //cornice height
c_length = length;


//beam();
//corner();

//frieze_beam(2); 		  // parmeter is number of trigliphs
//frieze_corner();

//rotate([180,0,0]) translate([0,-18,-f_height-c_height]) {cornice_beam();}

cornice_beam(2);			//parameter is type, short or long
//cornice_beam(0);
//cornice_corner();

//qr(20,-1);					//makes a quarter round beam, if second parameter is 1, rounds one end, -1 other end
//tri();
//peg();

//abacus();
//multi_abacus();


module cornice_corner() {

}

module cornice_beam(type) {
	difference() {
		union() {
			if ( type == 0 ) {
				cube([length,width+c_overhang,c_height]);										//full sized
				translate([length*.065,width/6.5,c_height])										//full inset
					cube([length/2-(length*.125),width-(width*.25),c_height/1.5]);
				}
			if ( type == 1 ) {
				cube([length+mod/4+c_overhang,width+c_overhang,c_height]);				//for long corner
				translate([length*.065,width/6.5+c_overhang/2,c_height])						//full inset
					cube([length/2-(length*.125),width-(width*.25),c_height/1.5]);
				//echo(length+mod/4+c_overhang);	
				}	
			if ( type == 2 ) {
				cube([length-mod/2.16,width+c_overhang,c_height]);							//for short corner
				translate([length*.065,width/6.5,c_height])										//full inset
					cube([length/2-(length*.125),width-(width*.25),c_height/1.5]);
				echo("len",length-mod/2.16);	
				}	

				if (type == 0 ) {
				translate([length/2 + (length*.065),width/6.5,c_height])							//full inset
					cube([length/2-(length*.125),width-(width*.25),c_height/1.5]);
				}
				if (type == 1 ){
				translate([length/2 + (length*.055),width/6.5+c_overhang/2,c_height])		//long inset middle
					cube([length/2-(length*.354),width-(width*.25),c_height/1.5]);
				translate([length-mod/1.35,width/6.5+c_overhang/2,c_height])				//long inset end
					cube([length/4,width-(width*.25),c_height/1.5]);
				}
				if (type == 2 ){
				translate([length/2 + (length*.055),width/6.5,c_height])		//short inset middle
					cube([length/2-(length*.197),width-(width*.25),c_height/1.5]);
				}
			}
	
	translate([length/4,width/2+c_overhang/2,0]) cylinder(h=c_height,r=width/5);
	
	if (type == 0 ) {
		translate([(length*.095),width/4,c_height/8]) cube([length/3.25,width/1.8,c_height*2]);
		translate([length/2+(length*.095),width/4,c_height/8]) cube([length/3.25,width/1.8,c_height*2]);
		translate([length*.75,width/2+c_overhang/2,0]) cylinder(h=c_height,r=width/5);
		}
	if (type == 1 ) {
		translate([(length*.095),width/4+c_overhang/2,c_height/8]) cube([length/3.25,width/1.8,c_height*2]);
		translate([length/2+(length*.095),width/4+c_overhang/2,c_height/8]) cube([length/14,width/1.8,c_height*2]);
		translate([length-mod/1.65,width/4+c_overhang/2,c_height/8])									//long inset end
			cube([length/6,width/1.8,c_height*2]);
		//echo((length+mod/4+c_overhang));
		//echo(length-mod/1.75);
		//echo(length/6);
		//echo((length+mod/4+c_overhang)-(length-mod/1.75)-(length/6));
		//translate([length*.75,width/2+c_overhang/2,0]) cylinder(h=c_height,r=width/5);
		}
	if (type == 2 ) {
		translate([(length*.095),width/4,c_height/8]) 
			cube([length/3.25,width/1.8,c_height*2]);												//full inset
		translate([length/2+(length*.095),width/4,c_height/8]) 
			cube([length/4.4,width/1.8,c_height*2]);													//short inset end
		}
	}
}


module frieze_corner() {
	union() {	
		difference() {
			cube([length/2+mod/4,width,f_height]);							//first, shorter, leg of basic solid
			translate([length/25,width/10,height/10])
			cube([length/2+mod/4-length/12,width-width/5,f_height]);		//hollow
			translate([width/2,width/2,0])
			cylinder(h = height/2, r = width/4, $fs = angle);					//peg hole
			}
		//translate([width-length/20,0,0])  cube([length/25,width,f_height]);
		translate([0,0,0]) rotate([0,90,0]) {
			qr(length/2+mod/4,0);													//bottom quarter round
			}
		translate([0,-f_height/15,f_height*.7]) cube([length/2+mod/4,f_height/15,f_height/6]);	//top rect. bar
		translate([0,0,f_height]) rotate([90.001,0,90])  {
			qr(length/2+mod/4,0);									//top quarter round
			}
		translate([mod/4,-f_height/10,0])										//triglyph, only one on this side
			tri();
		//translate([(length/4)*2+(length/10),-f_height/15,0])
		//	tri();
		}																						//closes first part union
	union() {
		difference() {
		cube([width,(length/2)+(mod*.75),f_height]);									//longer leg of basic solid
		translate([width/10,length/30,height/10])
			cube([width-width/5,(length/2)+(mod*.75)-length/15,f_height]);		//hollow
		translate([width/2,width/2,0])
			cylinder(h = height/2, r = width/4, $fs = angle);							//peg hole in same location 
			//	translate([width/2,3*length/4,0])
			//		cylinder(h = height/2, r = width/8, $fs = angle);	
			}
		//translate([0,width-length/20,0])  cube([length/20,width,f_height]);
		translate([0,length/1.37,0]) rotate([90,90,0]) {
			qr(((length/2)+mod*.75),1);													//bottom quarter round
			}
		translate([0,0,f_height]) rotate([180.001,270,90])  {							//note fudge factor for manifold
			qr(((length/2)+mod*.75),-1);													//top quarter round
			}
		translate([-f_height/15,-f_height/12,f_height*.7]) 
			cube([f_height/15,length/2+coldiameter*.75+f_height/12,f_height/6]);
		translate([-f_height/10,mod*.76,0]) rotate([0,0,270.001])					//triglyph near corner
			tri();
		translate([-f_height/10,length-(mod*.875),0]) rotate([0,0,270.001])		//triglyph away from corner
			tri();
		}																						//closes second part union
}


module frieze_beam(number) {
union() {
	difference() {
	cube([length,width,f_height]);												//basic solid
	translate([length/20,width/10,height/10])
		cube([length-length/10,width-width/5,f_height]);						//hollow
	translate([length/4+mod/4,width/2,0])
			cylinder(h = height/2, r = width/4, $fs = angle);					//peg hole
	translate([(3*length/4)+mod/4,width/2,0])
			cylinder(h = height/2, r = width/4, $fs = angle);					//peg hole
	}
	translate([length/2-length/20,0,0])  cube([length/10,width,f_height]);  //center beam

	rotate([0,90,0]) qr(length,0);													 //bottom quarter round
	translate([0,0,f_height]) rotate([90.001,0,90]) qr(length,0);				 //top quarter round, note fudge for manifold

	translate([0,-f_height/12,f_height*.7]) cube([length,f_height/12,f_height/6]);
	if ( number == 3 ) {
		translate([0,-f_height/15,0])
			tri();
		translate([(length/5)*2,-f_height/15,0])
			tri();
		translate([(length/5)*4,-f_height/15,0])
			tri();
		}
	else if ( number == 2 ){
		translate([(length/4)*0,-f_height/10,0])
			tri();
		translate([(length/4)*2,-f_height/10,0])
			tri();
	}
	else if ( number == 1 ){
		translate([(length/4)*0,-f_height/10,0])
			tri();
	}
}
}


module qr(len,corner) {

	difference() {
		union() {
			cylinder(h = len, r = f_height/6, $fs = angle);
			if (corner == 1) translate([0,0,len]) sphere(f_height/6, $fs = angle);
			if (corner == -1) sphere(f_height/6, $fs = angle);
			}		
		translate([-f_height/3,0,-f_height/3])
			cube([f_height/2.5,f_height/4,len*1.5]);
		translate([0,-f_height/4,-f_height/3])
			cube([f_height/4,f_height/2,len*1.5]);
		}
}

module tri() {
	difference() {

		translate([0,0,f_height/7])
			cube([mod/2,f_height/10,f_height-f_height/3]);					//basic plate shape
		translate([0,-f_height*f_d,0])
			scale([1,1.5,1]) cylinder(r = mod*.05, h = f_height-f_height/6, $fs = .05);	//left half groove
		translate([mod*.167,-f_height*f_d,0])
			scale([1,1.5,1]) cylinder(r = mod*.05, h = f_height-f_height/6, $fs = .05);	//left full groove
		translate([mod*.333,-f_height*f_d,0])
			scale([1,1.5,1]) cylinder(r = mod*.05, h = f_height-f_height/6, $fs = .05);	//right full groove
		translate([mod/2,-f_height*f_d,0])
			scale([1,1.5,1]) cylinder(r = mod*.05, h = f_height-f_height/6, $fs = .05);	//right half groove
		}
	translate([0,-f_height/20,f_height*.7])
		cube([mod/2,f_height/7,f_height/7]);
}

module beam() {
	difference() {
		cube([length, width, height]);								//basic solid
		translate([length/4,width/2,0])
			cylinder(h = height/2, r = width/4, $fs = angle);	//inset for frieze peg
		translate([3*length/4,width/2,0])
			cylinder(h = height/2, r = width/4, $fs = angle);	//inset for frieze peg
		}
	difference() {
		translate([0,width/2,0])
			cylinder(h = (height + colih), r1 = colid/2, r2 = colid/2.25, $fs = angle);
		translate([-colid/2,0,0])
			cube([colid/2,width,height*2]);					//make half cylinder
		}
	difference() {
		translate([length,width/2,0])
			cylinder(h = (height + colih), r1 = colid/2, r2 = colid/2.25, $fs = angle);
		translate([length,0,0])
			cube([colid/2,width,height*2]);					//make half cylinder
		}
}

module corner() {
	difference() {
		cube([length+width/2, width, height]);				//basic solid 
		translate([width/2,width/2,0])
			cylinder(h = height/2, r = width/4, $fs = angle);	//inset for frieze peg
		translate([(3*length/4)+width/2,width/2,0])
			cylinder(h = height/2, r = width/4, $fs = angle);	//inset for frieze peg	
			//echo("d=",(length+width/2)-((3*length/4)+width/2));
		}
	difference() {
		translate([0,width,0])
			cube([width, length-width/2, height]);											//makes l-shaped solid 
		translate([width/2,(3*length/4)+width/2,0])
			cylinder(h = height/2, r1 = colid/2, r2 = colid/2.25, $fs = angle);			//inset for frieze peg	
		}
	translate([width/2,width/2,height/2])
		cylinder(h = (height/2 + colih), r = colid/2, r2 = colid/2.25, $fs = angle);		//center column peg
	difference() {
		translate([length+width/2,width/2,0])
			cylinder(h = (height + colih), r1 = colid/2, r2 = colid/2.25, $fs = angle); //half column peg
		translate([length+width/2,0,0])
			cube([colid/2,width,height*2]);
		}
	difference() {
		translate([width/2,length+width/2,0])
			cylinder(h = (height + colih), r1 = colid/2, r2 = colid/2.25,  $fs = angle); //half column peg
		translate([0,length+width/2,0])
			cube([width,colid/2,height*2]);
		}
}

module peg() {
	echo("r1=",width/4.55);
	translate([0,0,height/10]) cylinder(h = height*.6, r1= width/4.55, r2 = width/4.76, $fs = angle);
	translate([width/15,0,0]) cube([width/1.5,width/2,height/5], center= true);
}

module abacus() {
	translate([(width*1.1)/2,(width*1.1)/2,height/2])
		cylinder(h = height/2, r = colid/2, $fs = angle);
	difference() {
		cube([width*1.1,width*1.1,height/2]);
		translate([(width*1.1)/2,(width*1.1)/2,0])
			cylinder(h = (height/2)-.65, r =colid/1.75, $fs = angle);
		}
}

module multi_abacus() {
abacus();
translate([width*1.5,0,0])
	abacus();
translate([0,width*1.5,0])
	abacus();
translate([width*1.5,width*1.5,0])
	abacus();
}

