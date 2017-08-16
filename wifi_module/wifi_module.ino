#include <ESP8266WiFi.h>

#include <ArduinoOTA.h>
#include <ESP8266httpUpdate.h>
// Required for LIGHT_SLEEP_T delay mode
extern "C" {
#include "user_interface.h"
}

#include <WiFiUdp.h>

const char* ssid = "Mornington";
const char* password = "Mornington";

WiFiUDP Udp;
IPAddress ip(192, 168, 1, 145);
unsigned int localUdpPort = 4210;  // local port to listen on
char incomingPacket[255];  // buffer for incoming packets
char  replyPacekt[] = "Hi there! Got the message :-)";  // a reply string to send back
char  periodicPacekt[80];  // a reply string to send back

byte mac[6];
char macstr[20];


unsigned int counter=0;


void setup()
{
  Serial.begin(115200);
  Serial.println();
  //Serial.printf("UPGRADED!!!");
  Serial.printf("integer size %d ", sizeof(counter));

  Serial.printf("Connecting to %s ", ssid);
  WiFi.mode(WIFI_STA);
  //wifi_set_sleep_type(LIGHT_SLEEP_T);
  WiFi.begin(ssid, password);
  
  WiFi.macAddress(mac);
  sprintf(macstr, "%x:%x:%x:%x:%x:%x", mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
  
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }
  Serial.println(" connected");

  Udp.begin(localUdpPort);
  Serial.printf("Now listening at IP %s, UDP port %d\n", WiFi.localIP().toString().c_str(), localUdpPort);
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
    {
      incomingPacket[len] = 0;
    }
    Serial.printf("UDP packet contents: %s\n", incomingPacket);
    ESPhttpUpdate.update("192.168.1.145", 8080, "/arduino.bin");
    Serial.printf("Wonder if we can upgrade\n"); 
    // send back a reply, to the IP address and port we got the packet from
    //Udp.beginPacket(Udp.remoteIP(), Udp.remotePort());
    //Udp.write(replyPacekt);
    //Udp.endPacket();

  }
  
    Udp.beginPacket(ip, 4120);
    counter++;
    for(int i=0; i<20; i++)
        {
        delay(500);
        if(!digitalRead(D0)) 
          {
          Serial.printf("press\n"); 
          sprintf(periodicPacekt, "%s BUTTONPRESS\n",macstr);
          Udp.write(periodicPacekt);
          Udp.endPacket();
          }
        }
   
    //Serial.printf("talking to : %s\n", Udp.remoteIP().toString().c_str());
    sprintf(periodicPacekt, "%s %d ADC %d %d %d %d\n",macstr, counter, (int) (analogRead(A0)), digitalRead(D1), digitalRead(D2), digitalRead(D8));
    Udp.write(periodicPacekt);
    Udp.endPacket();
    yield();
  
}
