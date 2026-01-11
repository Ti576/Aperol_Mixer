//LCD and rotary encoder holder for drink dispenser
$fa = 1;
$fs = 0.4;

OverallWidth=105;
OverallHeight=43;
OverallDepth=50;
WallThickness=2;

EncoderHoleDiameter=10;
LCDScreenWidth=66;
LCDScreenHeight=16;
LCDWallSpacing=8;

EncoderWallSpacing=10;

SphereDiameter=150;
SphereDistance=90;

LCDStandoff=7; //Remember to take off wall thickness!
LCDStandoffWidth=76;
LCDStandoffHeight=31;

SmallInsertOD=6;
SmallInsertID=3.2;
InsertID=4.5;
InsertOD=7;

module prism(l, w, h) {
    polyhedron(// pt      0        1        2        3        4        5
               points=[[0,0,0], [0,w,h], [l,w,h], [l,0,0], [0,w,0], [l,w,0]],
               // top sloping face (A)
               faces=[[0,1,2,3],
               // vertical rectangular face (B)
               [2,1,4,5],
               // bottom face (C)
               [0,3,5,4],
               // rear triangular face (D)
               [0,4,1],
               // front triangular face (E)
               [3,2,5]]
               );}

module MainBody(){
    union(){
    difference(){
    cube([OverallWidth,OverallDepth,OverallHeight]);
    
     //Hollow out cube to wall thickness
    translate([WallThickness,WallThickness,WallThickness])
    cube([OverallWidth-WallThickness*2,(OverallDepth-WallThickness*2)+5,OverallHeight-WallThickness*2]);
    } 
    
    //Mounts to glitterball, prism on base for printability
    //LCD Side - 1 off central
    difference(){
    union(){
    translate([WallThickness,OverallDepth-25,OverallHeight/2-InsertOD/2])
    cube([InsertOD,20,InsertOD]);
    translate([WallThickness,OverallDepth-25-InsertOD,OverallHeight/2+InsertOD/2])
    rotate([0,90,0])
    prism(InsertOD,InsertOD,InsertOD);
    }
    rotate([-90,0,0])
    translate([WallThickness+InsertOD/2,-OverallHeight/2,WallThickness+0.1])
    cylinder(OverallDepth,r=InsertID/2);
    }

    //Mounts to glitterball, prism on base for printability
    //Encoder Side - one top and one bottom
    difference(){
    union(){
        translate([OverallWidth-WallThickness-InsertOD,OverallDepth-25,WallThickness])
    cube([InsertOD,20,InsertOD]);
    translate([OverallWidth-WallThickness,OverallDepth-25-InsertOD,WallThickness])
    rotate([0,270,0])
    prism(InsertOD,InsertOD,InsertOD);   
    }
    rotate([-90,0,0])
    translate([OverallWidth-WallThickness-InsertOD/2,-WallThickness-InsertOD/2,WallThickness+0.1])
    cylinder(OverallDepth,r=InsertID/2);
    }

    difference(){
    union(){
    translate([OverallWidth-WallThickness-InsertOD,OverallDepth-25,OverallHeight-WallThickness-InsertOD])
    cube([InsertOD,20,InsertOD]);
    translate([OverallWidth-WallThickness,OverallDepth-25-InsertOD,OverallHeight-WallThickness-InsertOD])
    rotate([0,270,0])
    prism(InsertOD,InsertOD,InsertOD);  
    }
    rotate([-90,0,0])
    translate([OverallWidth-WallThickness-InsertOD/2,WallThickness+InsertOD/2-OverallHeight,WallThickness+0.1])
    cylinder(OverallDepth,r=InsertID/2);    
    }
}
 }       
    
union(){
difference(){

   MainBody();

    //To Make a jig
    translate([-100,-20,-10])
    cube([500,30,100]);

    //Glitter ball cutout
    translate([OverallWidth/2,SphereDistance,OverallHeight/2])
    sphere(SphereDiameter/2);
    
    
    //LCD Screen Cutout
    //x position 8mm from edge to wall
    translate([LCDWallSpacing+WallThickness,-0.1,OverallHeight/2-LCDScreenHeight/2])
    cube([LCDScreenWidth,WallThickness+0.5,LCDScreenHeight]);
  
    //Rotary Encoder Hole.  X position calcs needed paper working out!
    translate([OverallWidth-WallThickness-EncoderWallSpacing,-0.1,OverallHeight/2])
    rotate([-90,0,0])
    cylinder(WallThickness+1,r=EncoderHoleDiameter/2);
    
    

}
    
    //Antirotation tab for encoder?
    //Encoder Standoff
    
    
    
}



