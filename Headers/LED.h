void Pisca_LED(unsigned char *info){
TRISD = 0x00;
PORTD = 0x00;
while(*info == 1){
PORTD =0x55;
delay_ms(500);
PORTD =0xAA;
delay_ms(500);
}
}
