#include <avr/sleep.h>

byte WAKEUP_PIN = 2;

/*
 * La interrupcion de sleep debe ser por:
 * WIFI ESP => tiene que tener su propia alimentacion => antes de comunicarse por Tx y Rx debera mandar un alto para el pin 2
 * Teclado => conectar SDA el cual varia de 0 a 1 sucesivamente, por lo que habra que tener cuidado con que interrumpa mas de una vez
 * 
 * Para interrumpir se apaga el transistor, se pone index a 0 y luego se pone a dormir
 */

void setup() {
  Serial.begin(115200);
  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(WAKEUP_PIN, INPUT);
  digitalWrite(LED_BUILTIN, HIGH);
}

void wakeUp() {
  Serial.println("Interrupt Fire");
  sleep_disable();
  detachInterrupt(0);
}

void Going_to_Sleep() {
  sleep_enable();
  attachInterrupt(0, wakeUp, HIGH);
  set_sleep_mode(SLEEP_MODE_PWR_DOWN);
  digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
  sleep_cpu();
  Serial.println("just woke up!");
  digitalWrite(LED_BUILTIN, HIGH);
}

void loop() {
  delay(5000);
  Going_to_Sleep();
}
