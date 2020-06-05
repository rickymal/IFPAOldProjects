#line 1 "C:/Users/professor/Desktop/Bluetooth + PIC18F4550 (Controle Total do Kit)/Bluetooth_PIC18F4550.c"
#line 1 "i:/bluetooth + pic18f4550 (controle total do kit)/headers/led.h"
void Pisca_LED(unsigned char *info){
delay_ms(10);
TRISD = 0x00;
PORTD = 0x00;
while(*info == 1){
PORTD =0x55;
delay_ms(500);
PORTD =0xAA;
delay_ms(500);
}
}
#line 1 "i:/bluetooth + pic18f4550 (controle total do kit)/headers/temperatura.h"



void Celsius();
void CustomChar(char pos_row, char pos_char);
long media_temp();
#line 15 "i:/bluetooth + pic18f4550 (controle total do kit)/headers/temperatura.h"
unsigned long store, t_Celsius;
unsigned char centena, dezena, unidade, dec1, dec2;
unsigned char *text;
unsigned char opt =0x00;
const char character[] = {6,9,6,0,0,0,0,0};



void Temperatura_LCD(unsigned char *info){
 ADCON0 = 0x0D;
 ADCON1 = 0x0B;
 TRISA.RA3 = 1;

 TRISB.RB0 = 1;
 PORTB.RB0 = 1;

 TRISB.RB1 = 1;
 PORTB.RB1 = 1;

 Lcd_Init();
 Lcd_Cmd(_Lcd_Cursor_Off);
 Lcd_Cmd(_LCD_CLEAR);

 text=("TEMPERATURA");
 lcd_out(1,3,text);

 while(*info == 3){
 Celsius();
 }

}

void Celsius(){
 store = media_temp();
 t_Celsius = (store*5*100)/1023;






 dezena = t_Celsius/10;
 unidade = t_Celsius % 10;
 dec1 = (((store*5*100)%1023)*10)/1023;
 dec2 = (((((store*5*100)%1023)*10)%1023)*10)/1023;
Lcd_Out(2,5," ");
  lcd_chr(2,6,dezena+48); lcd_chr_cp(unidade+48); lcd_chr_cp('.'); lcd_chr_cp(dec1+48); lcd_chr_cp(dec2+48); CustomChar(2,11); ;

Lcd_Out(2,12,"C");



 delay_ms(250);
}


long media_temp(){
 unsigned char i;
 unsigned long temp_store = 0;
 for(i=0; i<100; i++)
 {
 temp_store += ADC_Read(3);
 }
 return(temp_store/100);
}


void CustomChar(char pos_row, char pos_char){
 char i;
 Lcd_Cmd(64);
 for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
 Lcd_Cmd(_LCD_RETURN_HOME);
 Lcd_Chr(pos_row, pos_char, 0);
}

void LigaVentoinha(unsigned char *info){
TRISC.RC2 = 0;
PORTC.RC2 = 0;
TRISC.RC1 = 0;
PORTC.RC1 = 0;

while(*info == 4)
{
RC2_bit = 1;


}
}

void AtivaAquecedor(unsigned char *info){
TRISC.RC1 = 0;
PORTC.RC1 = 0;
TRISC.RC2 = 0;
PORTC.RC2 = 0;

while(*info == 5){
RC1_bit = 1;

}

}
#line 1 "i:/bluetooth + pic18f4550 (controle total do kit)/headers/display_7seg.h"
void Cnt_Display_7seg(unsigned char *info){
unsigned char digito[]= { 0x3F,
 0x06,
 0x5B,
 0x4F,
 0x66,
 0x6D,
 0x7D,
 0x07,
 0x7F,
 0x67};

char i;
int Cnt = 0;
int Mil, Cen, Dez, Uni = 0;

 TRISD = 0x80;
 PORTD = 0x00;
 TRISE = 0x00;
 PORTE = 0x00;
 TRISA.RA5 = 0x00;
 PORTA.RA5 = 0x00;
while(*info == 2)
{
#line 27 "i:/bluetooth + pic18f4550 (controle total do kit)/headers/display_7seg.h"
 for (i = 0; i<=1; i++){

 Uni = (Cnt%10);


 Dez = (Cnt%100);

 Dez = (Dez/10) - ((Dez%10)/10);


 Cen = (Cnt%1000);

 Cen = (Cen/100)-((Cen%100)/100);


 Mil = (Cnt/1000) - ((Mil%1000)/1000);


 PORTD = (digito[Uni]);
 RA5_bit = 1;
 delay_ms(5);
 RA5_bit = 0;

 PORTD = (digito[Dez]);
 RE2_bit = 1;
 delay_ms(5);
 RE2_bit = 0;

 PORTD = (digito[Cen]);
 RE1_bit = 1;
 delay_ms(5);
 RE1_bit = 0;

 PORTD = (digito[Mil]);
 RE0_bit = 1;
 delay_ms(5);
 RE0_bit = 0;
 }
 if(Cnt == 10000){
 Cnt = 0;
 delay_ms(1000);
 PORTD = 0x00;
 }
 Cnt++;
}
}


void IFPA_Disp_7seg(unsigned char *info){

unsigned char letra_I = 0x06;
unsigned char letra_F = 0x71;
unsigned char letra_P = 0x73;
unsigned char letra_A = 0x77;

char i;

 TRISD = 0x80;
 PORTD = 0x00;
 TRISE = 0x00;
 PORTE = 0x00;
 TRISA.RA5 = 0x00;
 PORTA.RA5 = 0x00;

 while (*info == 8){
 for(i=0;i<=199;i++){

 PORTD = letra_A;
 RA5_bit = 1;
 delay_ms(5);
 RA5_bit = 0;

 PORTD = letra_P;
 RE2_bit = 1;
 delay_ms (5);
 RE2_bit = 0;

 PORTD = letra_F;
 RE1_bit = 1;
 delay_ms (5);
 RE1_bit = 0;

 PORTD = letra_I;
 RE0_bit = 1;
 delay_ms (5);
 RE0_bit = 0;
 }

 for(i=0;i<=3;i++){

 PORTD = letra_I;
 RE0_bit = 1;
 delay_ms (500);
 RE0_bit = 0;

 PORTD = letra_F;
 RE1_bit = 1;
 delay_ms (500);
 RE1_bit = 0;

 PORTD = letra_P;
 RE2_bit = 1;
 delay_ms (500);
 RE2_bit = 0;

 PORTD = letra_A;
 RA5_bit = 1;
 delay_ms(500);
 RA5_bit = 0;
 }
 }
}
#line 1 "i:/bluetooth + pic18f4550 (controle total do kit)/headers/buzzer.h"
#line 111 "i:/bluetooth + pic18f4550 (controle total do kit)/headers/buzzer.h"
void melodia();

void Toca_Buzzer() {
 ADCON1 = 0x0F;


 Sound_Init(&PORTC, 2);
 melodia();
}

void melodia() {




 Sound_Play( 220.00 , 60000/ 150 );
 delay_ms(1+ 60000/ 150 );
 Sound_Play( 220.00 , 60000/ 150 );
 delay_ms(1+ 60000/ 150 );
 Sound_Play( 220.00 , 60000/ 150 );
 delay_ms(1+ 60000/ 150 );
 Sound_Play( 174.61 , 60000/ 150 /2 + 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /2 + 60000/ 150 /4 );
 Sound_Play( 261.63 , 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /4 );

 Sound_Play( 220.00 , 60000/ 150 );
 delay_ms(1+ 60000/ 150 );
 Sound_Play( 174.61 , 60000/ 150 /2 + 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /2 + 60000/ 150 /4 );
 Sound_Play( 261.63 , 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /4 );
 Sound_Play( 220.00 , 2* 60000/ 150 );
 delay_ms(1+ 2* 60000/ 150 );

 Sound_Play( 329.63 , 60000/ 150 );
 delay_ms(1+ 60000/ 150 );
 Sound_Play( 329.63 , 60000/ 150 );
 delay_ms(1+ 60000/ 150 );
 Sound_Play( 329.63 , 60000/ 150 );
 delay_ms(1+ 60000/ 150 );
 Sound_Play( 349.23 , 60000/ 150 /2 + 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /2 + 60000/ 150 /4 );
 Sound_Play( 261.63 , 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /4 );

 Sound_Play( 207.65 , 60000/ 150 );
 delay_ms(1+ 60000/ 150 );
 Sound_Play( 174.61 , 60000/ 150 /2 + 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /2 + 60000/ 150 /4 );
 Sound_Play( 261.63 , 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /4 );
 Sound_Play( 220.00 , 2* 60000/ 150 );
 delay_ms(1+ 2* 60000/ 150 );

 Sound_Play( 440.00 , 60000/ 150 );
 delay_ms(1+ 60000/ 150 );
 Sound_Play( 220.00 , 60000/ 150 /2 + 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /2 + 60000/ 150 /4 );
 Sound_Play( 220.00 , 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /4 );
 Sound_Play( 440.00 , 60000/ 150 );
 delay_ms(1+ 60000/ 150 );
 Sound_Play( 415.30 , 60000/ 150 /2 + 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /2 + 60000/ 150 /4 );
 Sound_Play( 392.00 , 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /4 );

 Sound_Play( 369.99 , 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /4 );
 Sound_Play( 329.63 , 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /4 );
 Sound_Play( 349.23 , 60000/ 150 /2 );
 delay_ms(1+ 60000/ 150 /2 );
 delay_ms(1+ 60000/ 150 /2 );
 Sound_Play( 233.08 , 60000/ 150 /2 );
 delay_ms(1+ 60000/ 150 /2 );
 Sound_Play( 311.13 , 60000/ 150 );
 delay_ms(1+ 60000/ 150 );
 Sound_Play( 293.66 , 60000/ 150 /2 + 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /2 + 60000/ 150 /4 );
 Sound_Play( 277.18 , 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /4 );

 Sound_Play( 261.63 , 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /4 );
 Sound_Play( 246.94 , 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /4 );
 Sound_Play( 261.63 , 60000/ 150 /2 );
 delay_ms(1+ 60000/ 150 /2 );
 delay_ms(1+ 60000/ 150 /2 );
 Sound_Play( 174.61 , 60000/ 150 /2 );
 delay_ms(1+ 60000/ 150 /2 );
 Sound_Play( 207.65 , 60000/ 150 );
 delay_ms(1+ 60000/ 150 );
 Sound_Play( 174.61 , 60000/ 150 /2 + 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /2 + 60000/ 150 /4 );
 Sound_Play( 220.00 , 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /4 );

 Sound_Play( 261.63 , 60000/ 150 );
 delay_ms(1+ 60000/ 150 );
 Sound_Play( 220.00 , 60000/ 150 /2 + 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /2 + 60000/ 150 /4 );
 Sound_Play( 261.63 , 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /4 );
 Sound_Play( 329.63 , 2* 60000/ 150 );
 delay_ms(1+ 2* 60000/ 150 );

 Sound_Play( 440.00 , 60000/ 150 );
 delay_ms(1+ 60000/ 150 );
 Sound_Play( 220.00 , 60000/ 150 /2 + 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /2 + 60000/ 150 /4 );
 Sound_Play( 220.00 , 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /4 );
 Sound_Play( 440.00 , 60000/ 150 );
 delay_ms(1+ 60000/ 150 );
 Sound_Play( 415.30 , 60000/ 150 /2 + 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /2 + 60000/ 150 /4 );
 Sound_Play( 392.00 , 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /4 );

 Sound_Play( 369.99 , 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /4 );
 Sound_Play( 329.63 , 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /4 );
 Sound_Play( 349.23 , 60000/ 150 /2 );
 delay_ms(1+ 60000/ 150 /2 );
 delay_ms(1+ 60000/ 150 /2 );
 Sound_Play( 233.08 , 60000/ 150 /2 );
 delay_ms(1+ 60000/ 150 /2 );
 Sound_Play( 311.13 , 60000/ 150 );
 delay_ms(1+ 60000/ 150 );
 Sound_Play( 293.66 , 60000/ 150 /2 + 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /2 + 60000/ 150 /4 );
 Sound_Play( 277.18 , 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /4 );

 Sound_Play( 261.63 , 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /4 );
 Sound_Play( 246.94 , 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /4 );
 Sound_Play( 261.63 , 60000/ 150 /2 );
 delay_ms(1+ 60000/ 150 /2 );
 delay_ms(1+ 60000/ 150 /2 );
 Sound_Play( 174.61 , 60000/ 150 /2 );
 delay_ms(1+ 60000/ 150 /2 );
 Sound_Play( 207.65 , 60000/ 150 );
 delay_ms(1+ 60000/ 150 );
 Sound_Play( 174.61 , 60000/ 150 /2 + 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /2 + 60000/ 150 /4 );
 Sound_Play( 261.63 , 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /4 );

 Sound_Play( 220.00 , 60000/ 150 );
 delay_ms(1+ 60000/ 150 );
 Sound_Play( 174.61 , 60000/ 150 /2 + 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /2 + 60000/ 150 /4 );
 Sound_Play( 261.63 , 60000/ 150 /4 );
 delay_ms(1+ 60000/ 150 /4 );
 Sound_Play( 220.00 , 2* 60000/ 150 );
 delay_ms(1+ 2* 60000/ 150 );

 delay_ms(2* 2* 60000/ 150 );
}
#line 1 "i:/bluetooth + pic18f4550 (controle total do kit)/headers/pwm_botao.h"

void Botao_PWM(unsigned char *info) {
ADCON1 = 0x0F;
TRISC.RC2 = 0x00;
TRISB.RB0 = 0x01;
TRISB.RB1 = 0x01;
PWM1_Init(1000);

CCP1M2_bit = 1;
CCP1M3_bit = 1;
PWM1_Start();
CCPR1L = 0x00;

while(*info==7){
if(!RB0_bit)
{
delay_ms(200);
CCPR1L++;
}

if(!RB1_bit)
{
delay_ms(200);
CCPR1L--;
}
}
}
#line 1 "i:/bluetooth + pic18f4550 (controle total do kit)/headers/display_lcd.h"
void write_LCD(unsigned char *txt1, unsigned char *txt2) {
char i;

Lcd_Out(1,3,txt1);
Lcd_Out(2,7,txt2);
delay_ms(1000);

for(i=0; i<3; i++) {
 Lcd_Cmd(_LCD_SHIFT_RIGHT);
 delay_ms(500);
 }
 }

void LCD_Hello(unsigned char *info){
char i;

ADCON1 = 0x0F;
Lcd_Init();
Lcd_Cmd(_LCD_CLEAR);
Lcd_Cmd(_LCD_CURSOR_OFF);
write_LCD("Ola Mundo","^__^" );

 while(*info == 9) {
 for(i=0; i<6; i++) {
 Lcd_Cmd(_LCD_SHIFT_LEFT);
 delay_ms(500);
 }

 for(i=0; i<6; i++) {
 Lcd_Cmd(_LCD_SHIFT_RIGHT);
 delay_ms(500);
 }
 }
 }




void LCD_Bye(unsigned char *info){
char i;


ADCON1 = 0x0F;
Lcd_Init();
Lcd_Cmd(_LCD_CLEAR);
Lcd_Cmd(_LCD_CURSOR_OFF);
write_LCD("Tchau Mundo","-__-" );

 while(*info == 10){
 for(i=0; i<6; i++) {
 Lcd_Cmd(_LCD_SHIFT_LEFT);
 delay_ms(500);
 }

 for(i=0; i<6; i++){
 Lcd_Cmd(_LCD_SHIFT_RIGHT);
 delay_ms(500);
 }
 }
 }
#line 9 "C:/Users/professor/Desktop/Bluetooth + PIC18F4550 (Controle Total do Kit)/Bluetooth_PIC18F4550.c"
sbit LCD_RS at RE0_bit;
sbit LCD_EN at RE1_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_RS_Direction at TRISE0_bit;
sbit LCD_EN_Direction at TRISE1_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;


unsigned char UniFlag = 0;

unsigned char cnt1,cnt2,cnt3,cnt4,cnt5,cnt6,cnt7,cnt8,cnt9,cnt10 = 0;
bit function;
char byte;

void interrupt(){
 if(RCIF_bit){
 byte = RCREG;
 RCIF_bit = 0;
#line 38 "C:/Users/professor/Desktop/Bluetooth + PIC18F4550 (Controle Total do Kit)/Bluetooth_PIC18F4550.c"
 switch(byte){
 case 's':
 delay_ms(200);
 SPEN_bit = 0x00;
 CREN_bit = 0x00;
 SPEN_bit = 0x01;
 CREN_bit = 0x01;
 break;

 case ' ':
 SPEN_bit = 0x00;
 CREN_bit = 0x00;
 SPEN_bit = 0x01;
 CREN_bit = 0x01;

 break;
 case '1':
 UniFlag = 0x01;
 cnt1++;
 break;



 case '2':
 UniFlag = 0x02;
 break;

 case '3':
 UniFlag = 0x03;
 break;

 case '4':
 UniFlag = 0x04;
 break;

 case '5':
 UniFlag = 0x05;
 break;

 case '6':
 UniFlag = 0x06;
 break;

 case '7':
 UniFlag = 0x07;
 break;

 case '8':
 UniFlag = 0x08;
 break;

 case 'O':
 UniFlag = 0x09;
 SPEN_bit = 0x00;
 CREN_bit = 0x00;
 SPEN_bit = 0x01;
 CREN_bit = 0x01;
 break;

 case 'T':
 UniFlag = 0x0A;
 SPEN_bit = 0x00;
 CREN_bit = 0x00;
 SPEN_bit = 0x01;
 CREN_bit = 0x01;
 break;



 default:
 break;
 }
 }
}


void main(){
 ADCON1 = 0X0F;

 GIE_bit = 0x01;
 PEIE_bit = 0x01;


 TXEN_bit = 0x01;
 TX9_bit = 0x00;
 SYNC_bit = 0x00;
 TRMT_bit = 0x01;
 BRGH_bit = 0x01;


 BRG16_bit = 0X01;
 SPBRG = 0x10;
 SPBRGH = 0x00;


 SPEN_bit = 0x01;
 CREN_bit = 0x01;
 RX9_bit= 0x00;


 RCIF_bit = 0x00;
 RCIE_bit = 0x01;
 UART1_INIT(115200);
 UART1_WRITE_TEXT("1 -PISCA LED \r \n");
 UART1_WRITE_TEXT("2-DISPLAY 7 SEG \r \n");
 UART1_WRITE_TEXT("3-TEMPERATURA \r \n");
 UART1_WRITE_TEXT("4-VENTOINHA \r \n");
 UART1_WRITE_TEXT("5-AQUECEDOR \r \n");
 UART1_WRITE_TEXT("6-BUZZER \r \n");
 UART1_WRITE_TEXT("7-BOTAO PWM \r \n");
 UART1_WRITE_TEXT("8-IFPA \r \n");
 cnt1=0;
 function = 0;
 while(1){

 if(UniFlag == 1) {
 cnt1++;
 if(cnt1%2!=0) Pisca_LED(&UniFlag);


 }


 if(UniFlag == 2) {
 cnt2++;
 if(cnt2%2!=0) Cnt_Display_7seg(&UniFlag);
 }


 if(UniFlag == 3) {
 cnt3++;
 if(cnt3%2!=0) Temperatura_LCD(&UniFlag);
 }


 if(UniFlag == 4) {
 cnt4++;
 if(cnt4%2!=0) LigaVentoinha(&UniFlag);

 }


 if(UniFlag == 5) {
 cnt5++;
 if(cnt5%2!=0) AtivaAquecedor(&UniFlag);

 }


 if(UniFlag == 6) {
 cnt6++;
 if(cnt6%2!=0) Toca_Buzzer();
 }


 if(UniFlag == 7) {
 cnt7++;
 if(cnt7%2!=0)Botao_PWM(&UniFlag);
 }


 if(UniFlag == 8) {
 cnt8++;
 if(cnt8%2!=0) IFPA_Disp_7seg(&Uniflag);
 }

 if(UniFlag == 9) {
 cnt9++;
 if(cnt9%2!=0) LCD_Hello(&Uniflag);
 }

 if(UniFlag == 10) {
 cnt10++;
 if(cnt10%2!=0) LCD_Bye(&Uniflag);
 }



 }
}
