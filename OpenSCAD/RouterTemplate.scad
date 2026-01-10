
//Drink Dispenser Base Stand//

MainDiameter=104;
MainHeight=10;
WallThickness=2;

MountTabWidth=8;
InsertDiameter=5;

module MountTab() {
 translate([-MountTabWidth/2,-MountTabWidth/2,-0])   
difference(){
cube([MountTabWidth,MountTabWidth,10]);
translate([MountTabWidth/2,MountTabWidth/2,-0.1])
cylinder(h=15, r=InsertDiameter/2);    
}  
}

//Create base

difference(){
 union(){
        //Main Cylinder
        cylinder(h=MainHeight, r=MainDiameter/2); 
     
        //base
        translate([-80,-80,0])
        cube([160,160,2]);
 }     
        translate([0,0,-0.1])
        cylinder(h=MainHeight+5, r=(MainDiameter/2)-WallThickness);
}



$fa = 1;
$fs = 0.4;