
//Drink Dispenser Base//

FlangeDiameter=105;
FlangeThickness=5;
FlangeHeight= 90;
ChamferDistance=5;

InnerFlangeDiameter=85;
InnerFlangeThickness=5;
InnerFlangeHeight=FlangeHeight-20;
InnerChamferDistance=5;

MainDiameter=97.5;
MainHeight=FlangeHeight+FlangeThickness+10;
WallThickness=2;

//Create base

union(){
difference(){
union() {
    //create flange
        translate([0,0,FlangeHeight - FlangeThickness])
        cylinder(FlangeThickness, r=FlangeDiameter/2);
        translate([0,0,FlangeHeight-2*ChamferDistance])
        cylinder(ChamferDistance,MainDiameter/2,FlangeDiameter/2);
    //Main Cylinder
        cylinder(h=MainHeight, r=MainDiameter/2); 
        }   
        translate([0,0,-0.1])
        cylinder(h=MainHeight+5, r=(MainDiameter/2)-WallThickness);
}
       //inner flange
        difference(){
        translate([0,0,InnerFlangeHeight - InnerFlangeThickness-InnerChamferDistance])
        cylinder(InnerFlangeThickness+InnerChamferDistance, r=-0.1+MainDiameter/2);
        
        union(){    
        translate([0,0,InnerFlangeHeight-InnerFlangeThickness-InnerChamferDistance-0.1])
        cylinder(InnerChamferDistance,MainDiameter/2-WallThickness/2,InnerFlangeDiameter/2);
            
        translate([0,0,InnerFlangeHeight-InnerFlangeThickness-10])
        cylinder(500,InnerFlangeDiameter/2);
}
}
}

$fa = 1;
$fs = 0.4;