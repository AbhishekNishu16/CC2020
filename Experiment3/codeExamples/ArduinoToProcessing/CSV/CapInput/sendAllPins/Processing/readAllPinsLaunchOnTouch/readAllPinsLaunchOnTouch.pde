/*
DIGF 6037 Creation & Computation
   Kate Hartman & Nick Puckett

   Arduino to Processing - sending 12 capacitive pin values. 
   values are saved into an array
   simulated version of "onPress" and "onRelease"

 Based on based on this Lab on the ITP Physical Computing site: 
 https://itp.nyu.edu/physcomp/labs/labs-serial-communication/two-way-duplex-serial-communication-using-an-arduino/
 */

import processing.serial.*; // import the Processing serial library
Serial myPort;              // The serial port

int totalPins =12;
int pinValues[] = new int[totalPins];
int pinValuesPrev[] = new int[totalPins];

int margin = 50;

void setup() {
  size(800,400);
  // List all the available serial ports in the console
  printArray(Serial.list());

  // Change the 0 to the appropriate number of the serial port
  // that your microcontroller is attached to.
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  // read incoming bytes to a buffer
  // until you get a linefeed (ASCII 10):
  myPort.bufferUntil('\n');
}


void draw() 
{
  background(255);
  stroke(100);
  
  for(int i = 0;i<pinValues.length;i++)
  {
     if(pinValues[i]==1)
     {
      fill(0);       
     } 
     else
     {
      noFill(); 
     }
     
   ellipse(margin+(i*(width-(margin*2))/pinValues.length),height/2,30,30);
   
   ///this triggers only once at the first frame of the touch
   //similar to onMousePress
   if((pinValues[i]==1)&&(pinValuesPrev[i]==0))
   {
     fill(255,0,0);
     ellipse(margin+(i*(width-(margin*2))/pinValues.length),height/2,300,300);
   }
   
   //this triggers once onlyat that first frame of release
   //similar to onMouseRelease
   if((pinValues[i]==0)&&(pinValuesPrev[i]==1))
   {
     fill(0,255,0);
     rectMode(CENTER);
     square(margin+(i*(width-(margin*2))/pinValues.length),height/2,300);
   }
   
   
  //save the previous value   
  pinValuesPrev[i] = pinValues[i];   
  }
  
  

 
}


void serialEvent(Serial myPort) {
  // read the serial buffer:
  String myString = myPort.readStringUntil('\n');
  if (myString != null) {
    // println(myString);
    myString = trim(myString);
    pinValues = int(split(myString,','));

    
  }
  //printArray(pinValues);
}
