#include <FirebaseArduino.h>
#include <ESP8266WiFi.h>
#include <NTPClient.h>
#include <WiFiUDP.h>
#include <stdio.h>
#include <string.h>

WiFiUDP udp;
NTPClient ntp(udp, "a.st1.ntp.br", -3 * 3600, 60000);
String horas;
int i;

#define FIREBASE_HOST "socialwolfchat.firebaseio.com"
#define FIREBASE_AUTH "ahMTpmcKLpWerKgW3vxsnsNxupON5x5rSUURCL0G"
#define WIFI_SSID "Jessica"
#define WIFI_PASSWORD "25081122"


void setup() {
  Serial.begin(9600);

  WiFi.begin(WIFI_SSID,WIFI_PASSWORD);
  Serial.print("connecting");
  while (WiFi.status() != WL_CONNECTED){
    Serial.print(".");
    delay(500);
  }

  Firebase.begin(FIREBASE_HOST,FIREBASE_AUTH);
  pinMode(4,OUTPUT);
  digitalWrite(4,LOW);
  ntp.begin();
  ntp.forceUpdate();
}

void loop() {
 horas = ntp.getFormattedTime();
 char hora[4];
 memcpy(hora, &horas[0], 5);
 String h = hora;
String horario[9];
Serial.println(h);
horario[0] = Firebase.getString("horarios/0/0");
horario[1] = Firebase.getString("horarios/1/1");
horario[2] = Firebase.getString("horarios/2/2");
horario[3] = Firebase.getString("horarios/3/3");
horario[4] = Firebase.getString("horarios/4/4");
horario[5] = Firebase.getString("horarios/5/5");
horario[6] = Firebase.getString("horarios/6/6");
horario[7] = Firebase.getString("horarios/7/7");
horario[8] = Firebase.getString("horarios/8/8");
horario[9] = Firebase.getString("horarios/9/9");
horario[10] = Firebase.getString("horarios/10/10");

for(i=0;i<10;i++){
  if(h == horario[i]){
    digitalWrite(4,HIGH);
    }
  }
}
