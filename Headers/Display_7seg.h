void Cnt_Display_7seg(unsigned char *info){
unsigned char digito[]= { 0x3F,           // 0        Define cada segmento
                          0x06,           // 1        dos valores mostrados
                          0x5B,           // 2        no display de LEDs
                          0x4F,           // 3        em Hexadecimal para ficar
                          0x66,           // 4        mais fácil de codificar
                          0x6D,           // 5        cada dígito dos valores
                          0x7D,           // 6        mostrados no display.
                          0x07,           // 7
                          0x7F,           // 8
                          0x67};          // 9

char i;                                         // variavel auxiliar
int Cnt = 0;                                    // variável de contagem
int Mil, Cen, Dez, Uni = 0;                     //variáveis do display

   TRISD = 0x80;     //Declara RD7 como entrada e os demais pinos como saídas
   PORTD = 0x00;     //Inicia todos os pinos de PORTD em low
   TRISE = 0x00;     //Declara todos os pinos do registrador PORT'E como saídas
   PORTE = 0x00;     //Inicia todos os pinos de PORT'E em low
   TRISA.RA5 = 0x00;    //Declara o pino RA5 como saída
   PORTA.RA5 = 0x00;    //Inicia o pino RA5 em low
while(*info == 2)
{

      for (i = 0; i<=1; i++){     /* controla o tempo que cada numero
                                  é mostrado no display (aprox= 40ms) */

           Uni = (Cnt%10);                              // Calcula a unidade
           //    1234/10 = 123,4 | Resto = 4.           | Uni = 4 |

           Dez = (Cnt%100);                             // Calcula a dezena
           //   1234/100 = 12,34 | Resto 34 -> Dez=34
           Dez = (Dez/10) - ((Dez%10)/10);              // Calcula a dezena
           //     34/10 = 3,4 - (0,4)                   | Dez = 3 |

           Cen = (Cnt%1000);                            // Calcula a centena
           // 1234/1000 = 1,234 | Resto 234 -> Cen=234
           Cen = (Cen/100)-((Cen%100)/100);             // Calcula a centena
           //   234/100 = 2,34 - (0,34)                 | Cen = 2 |

           Mil = (Cnt/1000) - ((Mil%1000)/1000);        // calcula o milênio
           // 1234/1000 = 1,234 - (0,234)               | Mil = 1 |

         PORTD = (digito[Uni]);       // Apresenta Digito[Unidade_do_contador]
         RA5_bit = 1;                                   // Habilita RA5
         delay_ms(5);                                   // Aguarda 5ms
         RA5_bit = 0;                                   // Desabilita

         PORTD = (digito[Dez]);       // Apresenta Digito[Dezena_do_contador]
         RE2_bit = 1;                                   // Habilita RE2
         delay_ms(5);                                   // Aguarda 5ms
         RE2_bit = 0;                                   // Desabilita

         PORTD = (digito[Cen]);       // Apresenta Digito[Centena_do_contador]
         RE1_bit = 1;                                   // Habilita RE1
         delay_ms(5);                                   // Aguarda 5ms
         RE1_bit = 0;                                   // Desabilita

         PORTD = (digito[Mil]);       // Apresenta Digito[Milenar_do_contador]
         RE0_bit = 1;                                   // Habilita RE0
         delay_ms(5);                                   // Aguarda 5ms
         RE0_bit = 0;                                   // Desabilita
      }// end for
      if(Cnt == 10000){ // Se Cnt for igual á 10000...
      Cnt = 0;                        // Zera a variável de contagem, recomeça
      delay_ms(1000);                 // Delay de 1 segundo
      PORTD = 0x00;                   // Zera PORTD
      }//end if
      Cnt++;                          // Incrementa a variável de contagem em 1
}//end while
}//end void


void IFPA_Disp_7seg(unsigned char *info){
// valor do display de 7 segmentos correspondente às letras:
unsigned char letra_I = 0x06;
unsigned char letra_F = 0x71;
unsigned char letra_P = 0x73;
unsigned char letra_A = 0x77;

char i;               // variável auxiliar de tempo

   TRISD = 0x80;      //Declara RD7 como entrada e os demais pinos como saídas
   PORTD = 0x00;      //Coloca todos os pinos de PORTD em low
   TRISE = 0x00;      //Declara todos os pinos do registrador PORT'E como saídas
   PORTE = 0x00;      //Coloca todos os pinos de PORT'E em low
   TRISA.RA5 = 0x00;  //Declara o pino RA5 como saída
   PORTA.RA5 = 0x00;  //Coloca o pino RA5 em low

   while (*info == 1){         //Loop infinito
         for(i=0;i<=199;i++){              //Executa esse laço por aprox. 4s
         // Apresenta a IFPA nos displays
         PORTD = letra_A;        // Apresenta a LETRA A
         RA5_bit = 1;                                    // Habilita RA5
         delay_ms(5);                                    // Aguarda 5ms
         RA5_bit = 0;                                    // Desabilita

         PORTD = letra_P;        // Apresenta a LETRA P
         RE2_bit = 1;                                    // Habilita RE2
         delay_ms (5);                                   // Aguarda 5ms
         RE2_bit = 0;                                    // Desabilita

         PORTD = letra_F;        // Apresenta a LETRA F
         RE1_bit = 1;                                    // Habilita RE1
         delay_ms (5);                                   // Aguarda 5ms
         RE1_bit = 0;                                    // Desabilita

         PORTD = letra_I;        // Apresenta a LETRA I
         RE0_bit = 1;                                    // Habilita RE0
         delay_ms (5);                                   // Aguarda 5ms
         RE0_bit = 0;                                    // Desabilita
         }   //end for1

         for(i=0;i<=3;i++){              //Executa esse laço por aprox. 8s
         // Mostra IFPA no display letra por letra de for sequencial
         PORTD = letra_I;        // Apresenta a LETRA I
         RE0_bit = 1;                                    // Habilita RE0
         delay_ms (500);                                 // Aguarda 500ms
         RE0_bit = 0;                                    // Desabilita

         PORTD = letra_F;        // Apresenta a LETRA F
         RE1_bit = 1;                                    // Habilita RE1
         delay_ms (500);                                 // Aguarda 5000ms
         RE1_bit = 0;                                    // Desabilita

         PORTD = letra_P;        // Apresenta a LETRA P
         RE2_bit = 1;                                    // Habilita RE2
         delay_ms (500);                                 // Aguarda 500ms
         RE2_bit = 0;                                    // Desabilita

         PORTD = letra_A;        // Apresenta a LETRA A
         RA5_bit = 1;                                    // Habilita RA5
         delay_ms(500);                                  // Aguarda 500ms
         RA5_bit = 0;                                    // Desabilita
      }  //end for2
      }  //end while
}