#include <LED.h>
#include <Temperatura.h>
#include <Display_7seg.h>
#include <Buzzer.h>
#include <PWM_Botao.h>
#include <Display_LCD.h>

//Comunicação entre o PIC e o LCD
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


unsigned char UniFlag = 0;          // Flag universal
// Variaveis utilizadas no shields condicionais
unsigned char cnt1,cnt2,cnt3,cnt4,cnt5,cnt6,cnt7,cnt8,cnt9,cnt10 = 0;
bit function;
char byte;    // armazena o byte recebido

void interrupt(){   // Função de Interrupção
  if(RCIF_bit){       // Se houver dados na serial...
  byte = RCREG;       // atribui o dado à 'byte'
  RCIF_bit = 0;       // reseta a flag da interrupção
  

    switch(byte){       /* Laço que muda o valor da flag de acordo com o dado
                 
                                                                  recebido */
     case 's':
     delay_ms(200);
     SPEN_bit  = 0x00;                 // habilita a porta serial
     CREN_bit  = 0x00;                 // habilita o receptor no modo assincrono
     SPEN_bit  = 0x01;                 // habilita a porta serial
     CREN_bit  = 0x01;                 // habilita o receptor no modo assincrono
     break;
     
     case ' ':
     SPEN_bit  = 0x00;                 // habilita a porta serial
     CREN_bit  = 0x00;                 // habilita o receptor no modo assincrono
     SPEN_bit  = 0x01;                 // habilita a porta serial
     CREN_bit  = 0x01;                 // habilita o receptor no modo assincrono
     
     break;
     case '1':                         //OK  (TEM QUE APERTAR DUAS VEZES PARA FUNCIONAR )
     UniFlag = 0x01;
     cnt1++;
     break;
     


     case '2':                         //OK
     UniFlag = 0x02;
     break;

     case '3':                         //OK
     UniFlag = 0x03;
     break;

     case '4':                         //OK
     UniFlag = 0x04;
     break;

     case '5':                         //OK
     UniFlag = 0x05;
     break;

     case '6':
     UniFlag = 0x06;
     break;

     case '7':
     UniFlag = 0x07;                   //APENAS INCREMENTA
     break;

     case '8':
     UniFlag = 0x08;
     break;

     case 'O':
     UniFlag = 0x09;
     SPEN_bit  = 0x00;                 // habilita a porta serial
     CREN_bit  = 0x00;                 // habilita o receptor no modo assincrono
     SPEN_bit  = 0x01;                 // habilita a porta serial
     CREN_bit  = 0x01;                 // habilita o receptor no modo assincrono
     break;
     
     case 'T':
     UniFlag = 0x0A;
     SPEN_bit  = 0x00;                 // habilita a porta serial
     CREN_bit  = 0x00;                 // habilita o receptor no modo assincrono
     SPEN_bit  = 0x01;                 // habilita a porta serial
     CREN_bit  = 0x01;                 // habilita o receptor no modo assincrono
     break;


     
     default:
     break;
    }//end switch
  }//end if
}//end interrupt


void main(){     //--Função principal
    ADCON1   = 0X0F;                  // configura todos os pinos como digitais

    GIE_bit  = 0x01;                  // habilita a interrupção global
    PEIE_bit = 0x01;                  // habilita interrupção por periféricos

   /*configurar TXSTA*/
    TXEN_bit  = 0x01;                 // habilita o transmissor
    TX9_bit   = 0x00;                 // envio de 8 bits
    SYNC_bit  = 0x00;                 // seleciona o modo assincrono
    TRMT_bit  = 0x01;                 // buffer vazio
    BRGH_bit  = 0x01;                 // alta taxa de dados


    BRG16_bit = 0X01;                 // segundo registrador de 8 bits acionado
    SPBRG     = 0x10;                 // baudrate de 9600bps
    SPBRGH    = 0x00;

    /*configurar RCSTA*/
    SPEN_bit  = 0x01;                 // habilita a porta serial
    CREN_bit  = 0x01;                 // habilita o receptor no modo assincrono
    RX9_bit= 0x00;

    /*flag de interrupção*/
    RCIF_bit  = 0x00;                 // zera a flag de interrupção do receptor
    RCIE_bit  = 0x01;                 // habilita a interrupção pelo receptor
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
    while(1){                        //Loop infinito

    if(UniFlag == 1) {               // Se UniFlag = 1
        cnt1++;                      // incremento
        if(cnt1%2!=0) Pisca_LED(&UniFlag);


    }//


    if(UniFlag == 2) {               // Se UniFlag = 2
    cnt2++;                          // incremento
        if(cnt2%2!=0) Cnt_Display_7seg(&UniFlag); // Execução de Programa
    }//end if


    if(UniFlag == 3) {               // Se UniFlag = 3
    cnt3++;                          // incremento
        if(cnt3%2!=0) Temperatura_LCD(&UniFlag);   // Execução de Programa
    }//end if


    if(UniFlag == 4) {               // Se UniFlag = 4
    cnt4++;                          // incremento
        if(cnt4%2!=0) LigaVentoinha(&UniFlag);         // LIGA
                                       // DESLIGA
    }//end if


    if(UniFlag == 5) {               // Se UniFlag = 5
    cnt5++;                          // incremento
        if(cnt5%2!=0) AtivaAquecedor(&UniFlag);            // se for par..

    }//end if


    if(UniFlag == 6) {               // Se UniFlag = 6
    cnt6++;                          // incremento
        if(cnt6%2!=0) Toca_Buzzer();            // Execução de Programa
    }//end if


    if(UniFlag == 7) {               // Se UniFlag = 7
    cnt7++;                          // incremento
        if(cnt7%2!=0)Botao_PWM(&UniFlag);            // Execução de Programa
    }//end if


    if(UniFlag == 8) {               // Se UniFlag = 7
    cnt8++;                          // incremento
        if(cnt8%2!=0) IFPA_Disp_7seg(&Uniflag);          // Execução de Programa
    }//end if

    if(UniFlag == 9) {               // Se UniFlag = 7
    cnt9++;                          // incremento
        if(cnt9%2!=0) LCD_Hello(&Uniflag);            // Execução de Programa
    }//end if

    if(UniFlag == 10) {               // Se UniFlag = 7
    cnt10++;                          // incremento
        if(cnt10%2!=0) LCD_Bye(&Uniflag);            // Execução de Programa
    }//end if

    

    }//end while
}//end void