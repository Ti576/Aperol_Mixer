
//Drink Dispenser Base Stand//

MainDiameter=92;
MainHeight=25;
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
union(){
difference(){
    //Main Cylinder
        cylinder(h=MainHeight, r=MainDiameter/2); 
        
        translate([0,0,-0.1])
        cylinder(h=MainHeight+5, r=(MainDiameter/2)-WallThickness);
}
translate([MainDiameter/2-MountTabWidth/2-WallThickness,0,0])
MountTab();

translate([-MainDiameter/2+MountTabWidth/2+WallThickness,0,0])
MountTab();

translate([0,-MainDiameter/2+MountTabWidth/2+WallThickness,0])
MountTab();

translate([0,+MainDiameter/2-MountTabWidth/2-WallThickness,0])
MountTab();

}

$fa = 1;
$fs = 0.4;