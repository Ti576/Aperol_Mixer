//Aperol Spritz Mixer With LCD screen controlled by rotary encoder, strain gauge for glass sensing and 3 diaphragm pumps for dispensing

//Arduino Uno Pin assignments
//A5 = I2C LCD SDA(grey)
//A4 = I2C LCD SCL (purple)
//I2C LCD Ground (black)
//I2C LCD VCC (White)


//Rotary Encoder pin 1 ground (Brown)
//pin 2 to ground (switch feed)
//1 = Rotary Encoder 3 (Button)
//2 = Rotary Encoder 4 (rotary 2)
//3 = Rotary Encoder 5 (rotary 2)
// Rotary encoder 6 +5v

//4 = Aperol Pump Control
//5 = Prosecco Pump Control
//6 = Lemonade Pump Control

//12 = Glass detection strain gauge DT
//13 = Glass detection strain gauge SCK

//General Setup Options

//Drink Proportions, set timings based on glass size
const int Aperol = 2;
const int Prosecco = 6;
const int Lemonade = 2;

//Calibration for pump performance.  1 pump pumps 400ml in 15 seconds -> 25ml/s ish
unsigned int PumpRate = 38; //ml/s
unsigned long Time_Factor = 1000/((Aperol + Lemonade + Prosecco) * PumpRate);

//Glass size in ml
int Glass_Size = 150;  //default glass size
int Min_Glass_Size = 50;
int Max_Glass_Size = 550;
int Size_Increment = 25;
char Glass_Output[16]  = "";

//Declarations for LCD Screen, encoder and strain gauge
// include the library code:

#include <LCD-I2C.h>
#include <Wire.h>
#include <Encoder.h>
#include "HX711.h"

// HX711 circuit setup
const int LOADCELL_DOUT_PIN = 11;
const int LOADCELL_SCK_PIN = 12;
HX711 scale;

// initialize the LCD Screen
LCD_I2C lcd(0x27, 16, 2); // Default address of most PCF8574 modules, change according

//Declarations for rotary encoder
// Change these two numbers to the pins connected to your encoder.
//   Best Performance: both pins have interrupt capability
//   Good Performance: only the first pin has interrupt capability
//   Low Performance:  neither pin has interrupt capability
Encoder myEnc(2, 3);
//   avoid using pins with LEDs attached

//Timers
unsigned long Pump_Timer = 0;


const int ButtonPin = 1;
long oldPosition = 0;
bool ButtonPosition = 1;
bool OldButtonPosition = 1;

//Declarations for motor output
const int Aperol_Pump = 4;
const int Prosecco_Pump = 5;
const int Lemonade_Pump = 6;

//Glass Sensor Inputs
const int Glass_Sensor = 7;
long Strain_Gauge_Reading;
bool Glass_Present = false;


void setup() {

  Serial.begin(57600);

  //Pin for rotary encoder switch
  pinMode(ButtonPin, INPUT_PULLUP);
  myEnc.write(0);

  //Setup LCD
  Wire.begin();
  lcd.begin(&Wire);
  lcd.display();
  lcd.backlight();

  //Set up motor pins
  pinMode(Aperol_Pump, OUTPUT);
  pinMode(Prosecco_Pump, OUTPUT);
  pinMode(Lemonade_Pump, OUTPUT);
 
  //Glass sensor pin
  pinMode(Glass_Sensor, INPUT);

  //loadcell for glass detection
  scale.begin(LOADCELL_DOUT_PIN, LOADCELL_SCK_PIN);
}

void Check_Pump_Time(int Pin_Number, unsigned long Run_Time){
//if pump has been running for run_time then turn it off
  if (millis() - Pump_Timer >= Run_Time) {

    digitalWrite(Pin_Number, LOW);
  }

}

bool Check_Glass_Present(){
  Strain_Gauge_Reading = scale.read();
  //Serial.println(Strain_Gauge_Reading);
  if (Strain_Gauge_Reading < -100000) {
    return true;
  }
  else{
    return false;
  }
}

void loop() {

  //Serial.print("Loop");

  Glass_Present = Check_Glass_Present();  
  if (Glass_Present == false) {
    //Set display and stop pumps if they're running

    lcd.setCursor(0, 0);
    lcd.print("No Glass Present");
    lcd.setCursor(0,1);
    lcd.print("                ");
    digitalWrite(Prosecco_Pump, LOW);
    digitalWrite(Lemonade_Pump, LOW);
    digitalWrite(Aperol_Pump, LOW);

  }
  else{
 
    lcd.setCursor(0, 0);
    lcd.print("Set Glass Size  ");    
    lcd.setCursor(0,1);
    snprintf(Glass_Output, sizeof(Glass_Output),"%d ml %-16s", Glass_Size,"");
    lcd.print(Glass_Output);

    //Has button been pressed (actually fires on release)
    // ***********   needs some debounce! ***************
    ButtonPosition = (digitalRead(ButtonPin));
    if ((ButtonPosition == 1 && OldButtonPosition == 0) && !(digitalRead(Prosecco_Pump) || digitalRead(Lemonade_Pump) || digitalRead(Aperol_Pump))) {
      //Button Pressed and no pumps already running
      //Start the pumps and the pumnp timer
      digitalWrite(Aperol_Pump, HIGH);
      digitalWrite(Lemonade_Pump, HIGH); 
      digitalWrite(Prosecco_Pump, HIGH);  
      Pump_Timer = millis();
    }
    OldButtonPosition = ButtonPosition;

  //See if we need to stop any pumps
    Check_Pump_Time(Aperol_Pump, Aperol * Time_Factor * Glass_Size); 
    Check_Pump_Time(Lemonade_Pump, Lemonade * Time_Factor * Glass_Size);
    Check_Pump_Time(Prosecco_Pump, Prosecco * Time_Factor * Glass_Size);


  //Set drink sixe if encoder is changed
    long newPosition = myEnc.read();
    if (newPosition > oldPosition && Glass_Size < Max_Glass_Size) {
        Glass_Size = Glass_Size + Size_Increment;
    }
    if (newPosition < oldPosition  && Glass_Size > Min_Glass_Size) {
        Glass_Size = Glass_Size - Size_Increment;
    }
    oldPosition = newPosition;
  }


}

