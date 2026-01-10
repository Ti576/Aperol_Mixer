
//Drink Dispenser Motor Holder//

BaseID=93.5;
HolderThickness=5;
MotorDiameter=27.5;
MotorClearance=5;
MotorMountRadius=(BaseID/2)-MotorClearance-(MotorDiameter/2);
NotchSize=15;

//Create base
difference(){
union() {
    //Basic Holder Circle
        
        cylinder(HolderThickness, r=BaseID/2);
        
}  
//and then put in the motor holes
//No 1
translate([MotorMountRadius*cos(0),MotorMountRadius*sin(0),-0.1])
cylinder(HolderThickness+0.5,r=MotorDiameter/2);

//Add label 
        translate([-15,5,HolderThickness-1])
            linear_extrude(1.5)
            text(str("Aperol"),size=4,halign="center");


//No 2
translate([MotorMountRadius*cos(120),MotorMountRadius*sin(120),-0.1])
cylinder(HolderThickness+0.5,r=MotorDiameter/2);

//Add label 
        translate([30,15,HolderThickness-1])
            linear_extrude(1.5)
            text(str("Lemonade"),size=4,halign="center");

//No 3
translate([MotorMountRadius*cos(240),MotorMountRadius*sin(240),-0.1])
cylinder(HolderThickness+0.5,r=MotorDiameter/2);

//Add label 
        translate([-15,-8,HolderThickness-1])
            linear_extrude(1.5)
            text(str("Prosecco"),size=4,halign="center");

//And a notch for wiring
translate([(-BaseID/2),-NotchSize/2,-0.1])
cube([NotchSize,NotchSize,HolderThickness+0.5]);

    
}


$fa = 1;
$fs = 0.4;