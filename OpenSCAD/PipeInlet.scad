$fa = 1;
$fs = 0.4;
include <BOSL2/std.scad>

SphereDiameter=150;
SphereDistance=90;

PipeDiameter=9;
WallThickness=3;

Width =(PipeDiameter * 3) + (WallThickness * 2);
Height = PipeDiameter + (WallThickness * 2)+2;
Depth = 5;


difference(){
translate([0,25,2])
cuboid([Width,50,Height], rounding=1);
  
    //Glitter ball cutout
    translate([0,(SphereDiameter/2)+Depth,0])
    sphere(SphereDiameter/2);  


translate([0,25,0])
rotate([90,0,0])
cylinder(h=50, r=PipeDiameter/2);

translate([PipeDiameter,25,0])
rotate([90,0,0])
cylinder(h=50, r=PipeDiameter/2);

translate([-PipeDiameter,25,0])
rotate([90,0,0])
cylinder(h=50, r=PipeDiameter/2);

translate([0,1,1+PipeDiameter/2])
rotate([90,0,0])
linear_extrude(1.5)
  text(str("P"),size=3,halign="center");

translate([PipeDiameter,1,1+PipeDiameter/2])
rotate([90,0,0])
linear_extrude(1.5)
  text(str("L"),size=3,halign="center");
    
translate([-PipeDiameter,1,1+PipeDiameter/2])
rotate([90,0,0])
linear_extrude(1.5)
  text(str("A"),size=3,halign="center");
}