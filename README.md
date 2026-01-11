# Aperol_Mixer
The Instagram Famous Aperol Mixer

![The mixer](https://github.com/Ti576/Aperol_Mixer/blob/main/images/IMG_4396.jpeg)


You're probably here from following the link on kate_ivy_peace's instagram showing the Aperol dispenser I made her https://www.instagram.com/kate_ivy_peace/reel/DRjfJR4iDU8/

The following are some fairly rubbish instructions on how to make yourself a version of this wonderful device.

# BoM:

* 3 diaphragm pumps.  This is the basis of the whole thing.  The diameter of the pumps you use will drive the size of everything elseI used these but others are available - https://www.aliexpress.com/item/1005008389360033.html?algo_exp_id=38f3a638-18dc-47c7-ad9f-794de28863fa-1&pdp_ext_f=%7B%22order%22%3A%2255%22%2C%22eval%22%3A%221%22%2C%22fromPage%22%3A%22search%22%7D&utparam-url=scene%3Asearch%7Cquery_from%3A%7Cx_object_id%3A1005008389360033%7C_p_origin_prod%3A

* Arduino nano

* Solderless Breadboad small enough to fit in the footprint that you use.  I had to dremel the corners off mine

* 16x2 i2C LCD display

* Rotary encoder.  Mine was out of a BMW M5, funnily enough.

* Load cell to detect if there is a glass in place to catch the aperol.  I used a 750g one, you might need to change this if you are using huge glasses and delivering pints of cocktail.  The code assumes you are using an HX711 based loadcell.

* A reasonable amount of 3d printer filament

* Inserts and screws for the 3d prints

* Random wires, flyback diodes for the motors and resistors

* 3 MOSFETS to drive the motors.  I used IRF3205s

* 12v Power supply and matching plug socket

* A suitable block of wood for the base

* A glitter ball!  Bear in mind that you'll be using it upside down so you don't want a vase or anything with a flat base as it'll look wierd.  I ended up using one intended as a hanging basket.

* A bicycle spoke or similar stiff wire

* Food safe silicone hose, mine was 6mm id but it needs to suit your pumps

# Stream of conciousness 'instructions':

## CAD Files

The CAD files are in the 'OpenSCAD' folder.  You will need to open them in OpenSCAD, make any changes (hopefully the files are reasonably self documenting) then export them as stls at which point you con import them into your favourite slicing program.

The files can be divided into 3 main areas:

1. The glass stand:
![The glass stand](https://github.com/Ti576/Aperol_Mixer/blob/main/images/IMG_4397.jpeg)

This is made up of one each of DrinkDispenserGlassStand.scad and DrinkDispenserGlassStand2.scad.  The GlassStand2 file has a second circle to stop small glasses toppling over.  The strain gauge can then be attached between the two.

I routed out the circular recess on the base for the glass stand to fit into, the file RouterTemplate.scad allows you to print a template to guide the router, you may need to do some maths to allow for your chosen glass stand diameter, router bush diameter and router cutter diameter.  That is left as an excercise for the reader.  Alternatively I suppose you could use two thicknesses of ply and use a hole saw to cut an appropriate size hole in the top one before glueing them togther.


2. The base and motor holder:

BaseStand.scad - This screws to the base and the cylinderical base fits over it.  If I get round to a version 2, I'd notch it to allow the USB to be plugged to in the arduino more easily.  If you look on the pictures I've done this with a dremel on the orginal.  You might need to play with tolerances to get it to fit tightly but not too tightly inside the base.
![The mixer](https://github.com/Ti576/Aperol_Mixer/blob/main/images/IMG_4399.jpeg)

DrinkDispenserBase.scad - This is the main cylinderical base.  The diameter will need to be adjusted to match the glitter ball you're using.  There is a ridge of the outside to support the glitter ball and one on the inside to support the motor mount
![The mixer](https://github.com/Ti576/Aperol_Mixer/blob/main/images/IMG_4398.jpeg)

DrinkDispenserMotorMount.scad - The motors sit in this, there are labels to identify each motor.  Again, you'll need to alter the dimensions as appropriate.  I printed this in TPU to get a bit of grip on the motors, not sure if it was needed.


3. The fittings for the glitter ball.  You will need to drill/cut holes in the glitter ball to let pipes and wires in and out:

DisplayHolder V2.scad - The holder for the display and rotary encoder.  Again, you'll need to adjust dimensions and the curvature of the cutout for the glitterball.  There are fittings for threaded inserts to retain the display and to screw the display holder onto the glitterball.  The file 'DisplayHolder Jig.scad' can be used as a jig to dril the mounting holes in the glitterball as you can't drill from the inside of the glitterball (or I couldn't!)
 
PipeInlet.scad and PipeOutlet.scad -  Do what they say on the tin, these can be glued on to the glitter ball after you've cut suitable holes for the pipes.  The Pipeinlet has letters to identify what tube goes into what drink

PipeHolder.scad - This can be supported by a bicycle spoke or other stiff wire to hold the end of the outlet pipes over the glass.

## Wiring

The wiring for the arduino is obviously in the arduino code so this should be altered if you want to change pin assignments.

Arduino Power:  
12v input to VIn  
Ground to Gnd  

LCD Display:  
I2C LCD SDA to A5  
I2C LCD SCL to A4  
I2C LCD Ground to Gnd  
I2C LCD VCC to 5v  

Rotary Encoder:  
Pin 1 (Ground) to Gnd  
Pin 2 (Button 1) to Gnd  
Pin 3 (Button 2) to D1  
Pin 4 (rotary 1) to D2  
Pin 5 (rotary 2) to D3  
Pin 6 (VCC) to 5v  
My rotary encoder needed a number of pull down resistors, look at the data sheet for the one you are using.

Strain Gauge:  
Glass detection strain gauge DT to D12  
Glass detection strain gauge SCK to D13  
VCC to 5v  
Gnd to Gnd  

Motor Control Pins connect to MOSFET gate pins:  
Aperol Pump Control to D4  
Prosecco Pump Control to D5  
Lemonade Pump Control to D6  

The motor +ves should be wired to 12v and the ground via the MOSFET drain pin along the lines of:
![MOSFET Wiring](https://europe1.discourse-cdn.com/arduino/optimized/4X/4/e/6/4e6ed00a48e51eaa05c1c7201d19b298c6631c0d_2_1024x560.png)
