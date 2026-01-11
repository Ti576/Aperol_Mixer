
//Drink Dispenser Motor Holder//

BaseID=90;
HolderThickness=4;
StrainGaugeLength=45;
StrainGaugeWidth=9;
StrainGaugeHolePosition=4;
StandoffLength=15;
StandoffHeight=2.5;
StandoffPadding=2;
HoleSpacing = 7.5;
HoleDiameter = 3; //clearance for M2.5 screws
CounterSinkDiameter=10;
CounterSinkDepth=3;
OuterCircleThickness=5;
SecondBeamThickness=5;
SecondCircleThickness=5;



//Create base
difference(){
    union(){
        difference() {
            union(){
                //Basic Holder Circle
                cylinder(HolderThickness, r=BaseID/2);
                //Stand for strain gauge
                translate([(StrainGaugeLength/2-StandoffLength),-StrainGaugeWidth/2-StandoffPadding/2,HolderThickness])
                   cube([StandoffLength, StrainGaugeWidth+StandoffPadding,StandoffHeight]);     
}

        //Cutout To Save Plastic
        translate([0,0,-0.1])
        cylinder(HolderThickness+0.2,r=(BaseID/2)-OuterCircleThickness);
}
    //Central Beams
    rotate([0,0,90])
    translate([-StrainGaugeWidth/2-StandoffPadding/2,-BaseID/2+2,0])
    cube([StrainGaugeWidth+StandoffPadding,BaseID-4,HolderThickness]);
        
    rotate([0,0,0])
    translate([-SecondBeamThickness/2,-BaseID/2+2,0])
    cube([SecondBeamThickness,BaseID-4,HolderThickness]);


}
//ScrewHoles and countersinks
translate([StrainGaugeLength/2-StrainGaugeHolePosition,0,-0.1])
cylinder(StandoffHeight+HolderThickness+1,r=HoleDiameter/2);

translate([StrainGaugeLength/2-StrainGaugeHolePosition,0,-0.1])
cylinder(CounterSinkDepth, CounterSinkDiameter/2,HoleDiameter/2);

translate([StrainGaugeLength/2-StrainGaugeHolePosition-HoleSpacing,0,-0.1])
cylinder(StandoffHeight+HolderThickness+1,r=HoleDiameter/2);
       
translate([StrainGaugeLength/2-StrainGaugeHolePosition-HoleSpacing,0,-0.1])
cylinder(CounterSinkDepth, CounterSinkDiameter/2,HoleDiameter/2);
}

$fa = 1;
$fs = 0.4;