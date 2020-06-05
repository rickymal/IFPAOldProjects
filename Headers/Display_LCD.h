void write_LCD(unsigned char *txt1, unsigned char *txt2) {            // Função que escreve no LCD
char i;                       // Variavel auxiliar de 'contagem'

Lcd_Out(1,3,txt1);            //Escreve na linha 1, coluna 3 o conteúdo de txt1
Lcd_Out(2,7,txt2);            //Escreve na linha 2, coluna 7: txt2
delay_ms(1000);               //Aguarda 2s

for(i=0; i<3; i++) {                // Repete o laço 3 vezes
      Lcd_Cmd(_LCD_SHIFT_RIGHT);    // Move o conteúdo da tela para a esquerda
      delay_ms(500);                // aguarda 0,5s
      }                             // end for
      }                             // end void write LCD

void LCD_Hello(unsigned char *info){
char i;

ADCON1 = 0x0F;        //Configura todos as saídas analogicas como Digitais I/O's
Lcd_Init();                         // Inicializa LCD
Lcd_Cmd(_LCD_CLEAR);                // Limpa display
Lcd_Cmd(_LCD_CURSOR_OFF);           // Desliga o Cursor
write_LCD("Ola Mundo","^__^" );                        // Chama a Função de escrita no LCD

  while(*info == 9) {                        // Loop infinito
    for(i=0; i<6; i++) {            // Move o texto pra esquerda 6x
      Lcd_Cmd(_LCD_SHIFT_LEFT);     // comando para mover p/ esquerda
      delay_ms(500);                // aguarda 0,5s
      }                             // end for

    for(i=0; i<6; i++) {            // Move o texto pra direita 6x
      Lcd_Cmd(_LCD_SHIFT_RIGHT);    // comando para mover p/ direita
      delay_ms(500);                // delay (500ms)
      }                             // end for
      }                             // end while
      }
      


void LCD_Bye(unsigned char *info){
char i;

ADCON1 = 0x0F;        //Configura todos as saídas analogicas como Digitais I/O's
Lcd_Init();                         // Inicializa LCD
Lcd_Cmd(_LCD_CLEAR);                // Limpa display
Lcd_Cmd(_LCD_CURSOR_OFF);           // Desliga o Cursor
write_LCD("Tchau Mundo","-__-" );                        // Chama a Função de escrita no LCD

  while(*info == 10){                        // Loop infinito
    for(i=0; i<6; i++) {            // Move o texto pra esquerda 6x
      Lcd_Cmd(_LCD_SHIFT_LEFT);     // comando para mover p/ esquerda
      delay_ms(500);                // aguarda 0,5s
      }                             // end for

    for(i=0; i<6; i++){            // Move o texto pra direita 6x
      Lcd_Cmd(_LCD_SHIFT_RIGHT);    // comando para mover p/ direita
      delay_ms(500);                // delay (500ms)
      }                             // end for
      }                             // end while
      }