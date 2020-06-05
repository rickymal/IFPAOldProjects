

//Fun��es auxiliares:
void Celsius();                              //temperatura na escala Celsius
void CustomChar(char pos_row, char pos_char);//fun��o que escreve o caractere especial de "graus" no display
long media_temp();                           //fun��o auxiliar retorna a m�dia das tempeturas de 100 itera��es


//Macro (concatena cada d�gito referente � temperatura lida, precis�o de duas casas decimais)
#define disp_t      lcd_chr(2,6,dezena+48);  lcd_chr_cp(unidade+48); \
                lcd_chr_cp('.');           lcd_chr_cp(dec1+48);    \
                lcd_chr_cp(dec2+48);       CustomChar(2,11);

//Vari�veis Globais
unsigned long store, t_Celsius; //vari�veis armazenam as grandezas de temperatura
unsigned char centena, dezena, unidade, dec1, dec2;    //d�gitos para utilizar na macro e exibir no display
unsigned char *text;                          //Vari�vel que armazena textos para escrever no display
unsigned char opt =0x00;
const char character[] = {6,9,6,0,0,0,0,0};   //caractere especial de "graus"



void Temperatura_LCD(unsigned char *info){  //-Fun��o principal
   ADCON0 = 0x0D;      // Seleciona a Porta AN3 // ADON_bit = 1
   ADCON1 = 0x0B;      // Configura AN0, AN1, AN2, AN3 como portas ANAL�GICAS
   TRISA.RA3 = 1;      // PINO RA3[AN2] = entrada

   TRISB.RB0 = 1;
   PORTB.RB0 = 1;

   TRISB.RB1 = 1;
   PORTB.RB1 = 1;

   Lcd_Init();                         //Inicializa o display
   Lcd_Cmd(_Lcd_Cursor_Off);           //Apaga o cursor
   Lcd_Cmd(_LCD_CLEAR);                //Limpa o display

   text=("TEMPERATURA");               //Armazena o texto na vari�vel text
   lcd_out(1,3,text);                  //Escreve o texto uma vez no display, linha 1, coluna 3

      while(*info == 3){                         //In�cio do loop infinito
      Celsius();
      } //end while

} //end main

void Celsius(){
 store = media_temp();         //atribui a m�dia de 100 medidas � vari�vel store
 t_Celsius = (store*5*100)/1023; //converte o valor para escala Celsius
 //1023 Resolu��o PICF877A
 // 5   Alimenta��o TTL
 //100  Fator de corre��o do sensor LM35


 //as 4 linhas seguintes separam os d�gitos do valor em dezena, unidade e mais duas casas decimais
 dezena = t_Celsius/10;
 unidade = t_Celsius % 10;
 dec1 = (((store*5*100)%1023)*10)/1023;
 dec2 = (((((store*5*100)%1023)*10)%1023)*10)/1023;
Lcd_Out(2,5," ");
 disp_t;              //chama a macro

Lcd_Out(2,12,"C");   //escreve "C" de Celsius no display
                //RB0_bit = 0x00;      //aciona o LED para indicar Celsius
               //RD1_bit = 0x00;      //apaga o LED de indica��o Fahrenheit

               delay_ms(250);       //taxa de atualiza��o do display e das medidas
} // End void Celsius


long media_temp(){     // Calcula a m�dia de 100 medidas
     unsigned char i;
     unsigned long temp_store = 0;
     for(i=0; i<100; i++)
     {
              temp_store += ADC_Read(3); //temp_store = temp_store + ADC_Read(0) (faz o somat�rio das 100 itera��es
     }
     return(temp_store/100); //retorna a m�dia das itera��es
}//end media temp


void CustomChar(char pos_row, char pos_char){  //fun��o gerada pelo mikroC para imprimir caracteres especiais
    char i;
    Lcd_Cmd(64);
    for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
    Lcd_Cmd(_LCD_RETURN_HOME);
    Lcd_Chr(pos_row, pos_char, 0);
}//end CustomChar

void LigaVentoinha(unsigned char *info){
TRISC.RC2 = 0;      // Declara o pino RC2 do registrador PORT'C como sa�da
PORTC.RC2 = 0;       // inicia em low
TRISC.RC1 = 0;
PORTC.RC1 = 0;

while(*info == 4)            // Loop Infinito
{
RC2_bit = 1;           // Ativa ventoinha


} // and while
} // end void main

void AtivaAquecedor(unsigned char *info){
TRISC.RC1 = 0;
PORTC.RC1 = 0;
TRISC.RC2 = 0;      // Declara o pino RC2 do registrador PORT'C como sa�da
PORTC.RC2 = 0;       // Coloca todo o PORT'C em low

while(*info == 5){
RC1_bit = 1;   // Ativa aquecedor

}

}