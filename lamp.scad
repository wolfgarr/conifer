include<leaf.scad>;

materialThickness = 3.8;
baseJointDepth = 5;
cutWidth = .12;
jointDepth = 20;

lampDiam = 40;
bottomHoleDiam = 100;

baseDiam = 120;
diam = 250;
ribCount = 10;
ribDepth = 30;
leafCount = 5;
leafX = 80;
leafY = 95;

baseOffset = 95;

leaf();
translate([half(baseDiam), 0]) rib();
translate([baseDiam, 0]) rib2();
translate([-baseDiam, 0]) bottomBase();
translate([double(-baseDiam) - jointDepth, 0]) topBase();

module leaf() {
    difference(){
        resize([leafX,leafY]){ leafImport(); }
        translate([0,half(leafY)]) square([materialThickness - cutWidth, jointDepth], center = true);
    }
}
    
module rib() {
    translate([-half(baseDiam), 0, 0]) {
        difference() {
            ribShape();
            
            for(i = [0 : leafCount - 1]) {
                rotate([0,0,i*22 -45])
                    translate([half(diam), 0, 0])
                        rotate([0,0,-60])
                            square([jointDepth, materialThickness + cutWidth], center = true);
            }
        }
    }
}

module rib2() {
    translate([-half(baseDiam), 0, 0]) {
        difference() {
            ribShape();
            
            for(i = [1 : leafCount - 1]) {
                rotate([0,0,(i-half(1))*22 -45])
                    translate([half(diam), 0, 0])
                        rotate([0,0,-60])
                            square([jointDepth, materialThickness + cutWidth], center = true);
            }
        }
    }
}

module ribShape(){
    difference() {
        union() {
            circle(d = diam);
        }
        
        circle(d = diam - double(ribDepth));
        
        a_lot = 500;
        translate([-a_lot+half(baseDiam), 0, 0]) {
            square([double(a_lot), double(a_lot)], center = true);
        }
        
        translate([half(baseDiam), 0, 0]) {
            translate([0, baseOffset, 0]) square([baseJointDepth, materialThickness + cutWidth]);
            translate([0, -baseOffset, 0]) square([baseJointDepth, materialThickness + cutWidth]);
        }
    }
}

module bottomBase() {
    base(bottomHoleDiam);
}

module topBase() {
    base(lampDiam);
}

module base(holeDiam) {
    difference(){
        union(){
            circle(d = baseDiam);
        }
        
        circle(d = holeDiam);
    
        for(i = [0: ribCount]) {
            rotate([0, 0, i * 360 / ribCount]) {
                translate([half(baseDiam), 0, 0]) {
                    square([double(baseJointDepth), materialThickness - cutWidth], center = true);
                }
            }
        }
    }
}

function half(x) = x / 2;
function double(x) = x * 2;