#include <ESP8266WiFi.h>

#include <ArduinoOTA.h>
#include <ESP8266httpUpdate.h>
// Required for LIGHT_SLEEP_T delay mode
extern "C" {
#include "user_interface.h"
}

#define BUTTON      D0
#define nOLED       D1
#define RLED        D2
#define nISENSOR    D8
#define BUILTINLED  D4


#include <WiFiUdp.h>

// look at finding gateway address automagically - perhaps find it by name with mDNS
// how do we make the wifi autodiscover SSID and WPA key? maybe use unencrypted? does that help?

const char* ssid = "Mornington";
const char* password = "Mornington";

WiFiUDP Udp;
//IPAddress ip(192, 168, 1, 145);
unsigned int localUdpPort = 4210;  // local port to listen on
char incomingPacket[255];  // buffer for incoming packets
char  periodicPacket[80];  // a reply string to send back

byte mac[6];
char macstr[20];


unsigned int counter=0;


void setup()
{
  pinMode(BUTTON, INPUT_PULLUP);
  pinMode(BUILTINLED, OUTPUT);

  digitalWrite(BUTTON, HIGH);
  digitalWrite(BUILTINLED,HIGH);
  Serial.begin(115200);
  Serial.println();
  //Serial.printf("UPGRADED!!!");
  Serial.printf("Connecting to %s ", ssid);
  WiFi.mode(WIFI_STA);
  //wifi_set_sleep_type(LIGHT_SLEEP_T);
  WiFi.begin(ssid, password);
  
  WiFi.macAddress(mac);
  
  sprintf(macstr, "%x:%x:%x:%x:%x:%x", mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
  
  while (WiFi.status() != WL_CONNECTED)
  {
    digitalWrite(BUILTINLED,!digitalRead(BUILTINLED));
    delay(500);
    Serial.print(".");
  }
  Serial.println(" connected");

  Udp.begin(localUdpPort);
  Serial.printf("Now listening at IP %s, UDP port %d\n", WiFi.localIP().toString().c_str(), localUdpPort);

  // at boot time, each device should do a http get to read its operating paramters. eg. update rate, upd ports, maybe others
}


void loop()
{
  int packetSize = Udp.parsePacket();
  if (packetSize)
  {
    // receive incoming UDP packets
    Serial.printf("Received %d bytes from %s, port %d\n", packetSize, Udp.remoteIP().toString().c_str(), Udp.remotePort());
    int len = Udp.read(incomingPacket, 255);
    if (len > 0)
       incomingPacket[len] = 0;
    Serial.printf("UDP packet contents: %s\n", incomingPacket);

    switch(incomingPacket[0])
      {
        case 'U':
          ESPhttpUpdate.update(WiFi.gatewayIP().toString(), 8080, "/arduino.bin");
          // maybe parameters of the upgrade command could specify server and filename to update from
          break;

        case 'S':
          // synchronise ADC sampling
          break;

        case 'F':
          for(int i=0; i<10; i++) {
              digitalWrite(BUILTINLED,!digitalRead(BUILTINLED));
              delay(100);
              }
          // flash LED
          break;
        
      }
    // send back a reply, to the IP address and port we got the packet from
    //Udp.beginPacket(Udp.remoteIP(), Udp.remotePort());
    //Udp.write(replyPacket);
    //Udp.endPacket();

  }
  
    Udp.beginPacket(WiFi.gatewayIP(), 4120);
    counter++;
    for(int i=0; i<9; i++)
        {
        delay(100);
        if(0)//!digitalRead(BUTTON)) 
          {
          Serial.printf("press\n"); 
          sprintf(periodicPacket, "%s BUTTONPRESS\n",macstr);
          Udp.write(periodicPacket);
          Udp.endPacket();
          }
        }
   
    //Serial.printf("talking to : %s\n", Udp.remoteIP().toString().c_str());
    digitalWrite(BUILTINLED,LOW);
    delay(100);
    digitalWrite(BUILTINLED,HIGH);
    
    long rssi = WiFi.RSSI();
    sprintf(periodicPacket, "%s, %d, %d, %d, %d, %d, %d\n",macstr, rssi, counter, (int) (analogRead(A0)), digitalRead(D1), digitalRead(D2), digitalRead(D8));
    Udp.write(periodicPacket);
    Udp.endPacket();
    yield();
  
}
