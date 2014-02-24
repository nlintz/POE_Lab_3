#include <Wire.h>
#include <Adafruit_MotorShield.h>
#include "utility/Adafruit_PWMServoDriver.h"

Adafruit_MotorShield AFMS = Adafruit_MotorShield(); 
Adafruit_DCMotor *myMotor = AFMS.getMotor(1);
const int potPin = A0;

const int maxPotAngle = 270;
const int angleConversionFactor = 1.9;
const int Kp = 6.6;
const int Ki = .01;
const int Kd = .02;

float currentError;
float previousError;
float totalError;
float previousTime;
float currentTime;
float dTime;
float set;

void setup() {
  Serial.begin(9600);
  pinMode(potPin, INPUT);
  
  AFMS.begin();
  
  currentError = 0;
  previousError = 0;
  previousTime = millis();
  currentTime = millis();
  dTime = 0;
  set = PIDControl(10, Kp, Ki, Kd);
  delay(1000);
}

void loop()
{
  float angle = sin(millis()/1000.0)*135+145;
  set = PIDControl(angle, Kp, Ki, Kd);
  runMotor(set);
  potAngleSerialOut();
  desiredAngleOut(angle);
}

// Serial Functions
void potAngleSerialOut()
{
  Serial.println("Potentiometer Angle: " + String(potAngle()));
}

void desiredAngleOut(int desiredAngle)
{
  Serial.println("Potentiometer Angle: " + String(potAngle()) + " Desired Angle: " + String(desiredAngle));
}


// Error Function
// Computes the error of the potentiometer
int angleError(int desiredAngle)
{
  return desiredAngle - potAngle();
}

// Potentiometer Reading Angles
// Computes the angle of the potentiometer
int potAngle()
{
  int potReading = analogRead(potPin);
  return 1.933*potReadToAngle(&potReading);
  
}

void runMotor(float set)
{
  myMotor -> setSpeed(abs(set));
  if (set<0) {
    myMotor->run(BACKWARD); 
  } else {
    myMotor -> run(FORWARD);
  }
}

int potReadToAngle(int *potReading)
{
  return map(*potReading, 0, 1023, 0, maxPotAngle);
}

// Control Functions
float PIDControl(float desiredAngle, float Kp, float Ki, float Kd)
{
  currentError = angleError(desiredAngle);
  dTime = deltaTime();
  return proportionalTerm(&currentError, Kp) + integralTerm(&currentError, Ki, dTime) + derivativeTerm(&currentError, Kd, dTime);
}

float derivativeTerm(float *error, float Kd, float deltaTime)
{
  // TODO - Finish Implementation
  float derivative = (*error - previousError)/deltaTime;
  previousError = *error;
  return Kd*derivative;
}

float integralTerm(float *error, float Ki, float deltaTime)
{
  totalError += *error * deltaTime ;
  return Ki*totalError;
}

float proportionalTerm(float *error, float Kp)
{
  return (*error)*Kp;
}

float deltaTime() {
   currentTime = millis();
   float delta = currentTime-previousTime;
   previousTime = currentTime;
  return delta; 
}
