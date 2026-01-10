$fa = 1;
$fs = 0.4;
include <BOSL2/std.scad>

SphereDiameter=150;
SphereDistance=90;

PipeDiameter=9;
WallThickness=8;

Width =(PipeDiameter * 3) + (WallThickness * 2);
Height = PipeDiameter + (WallThickness * 2);
Depth = 5;


difference(){
translate([8,0,-4])
cuboid([Width,10,Height], rounding=1);
  
translate([0,25,0])
rotate([90,0,0])
cylinder(h=50, r=PipeDiameter/2);

translate([PipeDiameter-3,25,-8])
rotate([90,0,0])
cylinder(h=50, r=PipeDiameter/2);

translate([-PipeDiameter+3,25,-8])
rotate([90,0,0])
cylinder(h=50, r=PipeDiameter/2);

translate([5,0,-4])
    rotate([0,90,0])
    cylinder(h=50,r=1.25);

}