

//Funções auxiliares:
void Celsius();                              //temperatura na escala Celsius
void CustomChar(char pos_row, char pos_char);//função que escreve o caractere especial de "graus" no display
long media_temp();                           //função auxiliar retorna a média das tempeturas de 100 iterações


//Macro (concatena cada dígito referente à temperatura lida, precisão de duas casas decimais)
#define disp_t      lcd_chr(2,6,dezena+48);  lcd_chr_cp(unidade+48); \
                lcd_chr_cp('.');           lcd_chr_cp(dec1+48);    \
                lcd_chr_cp(dec2+48);       CustomChar(2,11);

//Variáveis Globais
unsigned long store, t_Celsius; //variáveis armazenam as grandezas de temperatura
unsigned char centena, dezena, unidade, dec1, dec2;    //dígitos para utilizar na macro e exibir no display
unsigned char *text;                          //Variável que armazena textos para escrever no display
unsigned char opt =0x00;
const char character[] = {6,9,6,0,0,0,0,0};   //caractere especial de "graus"



void Temperatura_LCD(unsigned char *info){  //-Função principal
   ADCON0 = 0x0D;      // Seleciona a Porta AN3 // ADON_bit = 1
   ADCON1 = 0x0B;      // Configura AN0, AN1, AN2, AN3 como portas ANALÓGICAS
   TRISA.RA3 = 1;      // PINO RA3[AN2] = entrada

   TRISB.RB0 = 1;
   PORTB.RB0 = 1;

   TRISB.RB1 = 1;
   PORTB.RB1 = 1;

   Lcd_Init();                         //Inicializa o display
   Lcd_Cmd(_Lcd_Cursor_Off);           //Apaga o cursor
   Lcd_Cmd(_LCD_CLEAR);                //Limpa o display

   text=("TEMPERATURA");               //Armazena o texto na variável text
   lcd_out(1,3,text);                  //Escreve o texto uma vez no display, linha 1, coluna 3

      while(*info == 3){                         //Início do loop infinito
      Celsius();
      } //end while

} //end main

void Celsius(){
 store = media_temp();         //atribui a média de 100 medidas à variável store
 t_Celsius = (store*5*100)/1023; //converte o valor para escala Celsius
 //1023 Resolução PICF877A
 // 5   Alimentação TTL
 //100  Fator de correção do sensor LM35


 //as 4 linhas seguintes separam os dígitos do valor em dezena, unidade e mais duas casas decimais
 dezena = t_Celsius/10;
 unidade = t_Celsius % 10;
 dec1 = (((store*5*100)%1023)*10)/1023;
 dec2 = (((((store*5*100)%1023)*10)%1023)*10)/1023;
Lcd_Out(2,5," ");
 disp_t;              //chama a macro

Lcd_Out(2,12,"C");   //escreve "C" de Celsius no display
                //RB0_bit = 0x00;      //aciona o LED para indicar Celsius
               //RD1_bit = 0x00;      //apaga o LED de indicação Fahrenheit

               delay_ms(250);       //taxa de atualização do display e das medidas
} // End void Celsius


long media_temp(){     // Calcula a média de 100 medidas
     unsigned char i;
     unsigned long temp_store = 0;
     for(i=0; i<100; i++)
     {
              temp_store += ADC_Read(3); //temp_store = temp_store + ADC_Read(0) (faz o somatório das 100 iterações
     }
     return(temp_store/100); //retorna a média das iterações
}//end media temp


void CustomChar(char pos_row, char pos_char){  //função gerada pelo mikroC para imprimir caracteres especiais
    char i;
    Lcd_Cmd(64);
    for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
    Lcd_Cmd(_LCD_RETURN_HOME);
    Lcd_Chr(pos_row, pos_char, 0);
}//end CustomChar

void LigaVentoinha(unsigned char *info){
TRISC.RC2 = 0;      // Declara o pino RC2 do registrador PORT'C como saída
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
TRISC.RC2 = 0;      // Declara o pino RC2 do registrador PORT'C como saída
PORTC.RC2 = 0;       // Coloca todo o PORT'C em low

while(*info == 5){
RC1_bit = 1;   // Ativa aquecedor

}

}