coldiameter = 17;
mod = coldiameter;
ch = mod*5;		//column height
cr = mod/2;		//column radius
nf = 20;		//number of flutes
fr = 1.5;		//flute radius
fvo = 2; //flute vertical offset 
fho = .65; //flute horizontal offset (outwards)

bh = mod/2;  //base height
bo = mod/8; 	// base offset
btr = bo*.625;  //base torus radius
base_plate = 1;		//1 for a square plate, 0 for no plate

cph = mod/2;  //capitol height
cpo = mod/10; // capitol offset
ctr = cpo*.8;   //capitol torus radius
has_abacus = 1; //1 for abacus 0 for no abacus

$fs = 1;
aa = 6;

//base();
//column();
capitol();

echo(ch);

module column() {
translate([0,0,bh])
difference(){
	ring(ch,cr,cr-(bo*1.5),aa);
	for ( i = [0 : 360/nf : 360] ) {
		rotate(i)
		flute();
		}
	}
}

module flute() {
	translate([cr+fho+.01,0,fvo])     //small offset needed to make manifold
		cylinder(h=ch-(2*fvo),r=fr);
	translate([cr+fho,0,fvo])
		sphere(r=fr);
	translate([cr+fho,0,ch-fvo])
		sphere(r=fr);
}

module ring(h,r1,r2,aa) { 
difference() {
cylinder(h=h,r=r1,$fa=aa);
cylinder(h=h,r=r2,$fa=aa);
}
}

module torus(w,r) {
rotate_extrude(convexity = 20)
translate([w, 0, 0])
circle(r = r, $fn = 50);
}

module base() {
	difference() {
		union() {
		ring(bh*.5,cr+bo,cr-(bo*1.5),10);
		translate([0,0,bh*.5]) ring(bh*.5,cr+btr,cr-(bo*1.5),10);
		}
	translate([0,0,bh*.5]) torus(cr+bo,btr);
	}
	translate([0,0,btr*1.1]) torus(cr+bo,btr*1.1);
	translate([0,0,bh*.8]) torus(cr+bo*.5,btr*.9);
	echo(bh*.75+(2*btr*.95));
	if ( base_plate == 1 )
		difference() {
		translate([0,0,-bh*.15]) cube([2*(cr+bo+btr),2*(cr+bo+btr),bh*.33],center=true);
		translate([0,0,-bh*.35]) cylinder(h=bh*.5,r = cr-(bo*1.5));
		}
}

module capitol() {
translate([0,0,ch+cph]) {
	difference() {
		ring(cph,cr+cpo,cr-(bo*1.5),aa);									//basic shape
		translate([0,0,cph/2]) torus(cr+cpo+.75,ctr*1.5);				//curved inset
		}
	translate([0,0,ctr]) torus((cr+cpo)*.95,ctr);									//lower ring
	translate([0,0,-ctr/16]) ring(cph/4,cr-(bo*1.5),cr-(bo*2.5),aa);			//upper mating ring to column
	translate([0,0,-ctr*1.5]) ring(cph/4,cr-(bo*1.60),cr-(bo*2.5),aa);		//middle upper mating ring to column
	translate([0,0,-ctr*3]) ring(cph/4,cr-(bo*1.65),cr-(bo*2.5),aa);			//middle lower mating ring to column
	translate([0,0,-ctr*4.5]) ring(cph/4,cr-(bo*1.70),cr-(bo*2.5),aa);		//middle lower mating ring to column

	if ( has_abacus == 1 )	{
		difference() {
			union() {
				translate([0,0,ctr+cph*.67]) torus((cr+cpo)*1.05,ctr*1.1);
				translate([0,0,cph]) cube([(cr+cpo+ctr*1.6)*2,(cr+cpo+ctr*1.4)*2,cph/3], center= true);
			}
			translate([0,0,cph/2]) cylinder(h=cph,r = cr-(bo*1.5));
		}
	}
	if ( has_abacus == 0 ) {
		difference() {
			translate([0,0,ctr+cph*.67]) torus((cr+cpo)*1.05,ctr*1.1);
			%translate([0,0,cph]) cube([(cr+cpo+ctr*1.4)*2,(cr+cpo+ctr*1.4)*2,cph/3], center= true);
		}
	}			//no abacus end
}				//translate end
}				//module end
