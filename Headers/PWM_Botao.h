
void Botao_PWM(unsigned char *info) {               //-- Função Principal
ADCON1   = 0x0F;            // Configura todos os pinos AN's como DIGITAIS I/O's
TRISC.RC2 = 0x00;           // Configura o Pino RC2 como Saída (LED PWM)
TRISB.RB0 = 0x01;           // Configura o Pino RB0 como Entrada (BOTÃO+)
TRISB.RB1 = 0x01;           // Configura o Pino RB1 como Entrada (BOTÃO-)
PWM1_Init(1000);            // Inicializa o PWM a 1KHz
// Ativa o modo PWM
CCP1M2_bit = 1;
CCP1M3_bit = 1;
PWM1_Start();
CCPR1L = 0x00;              // Inicia com o Duty Cicle em zero

while(*info==7){
if(!RB0_bit) 
{
delay_ms(200);
CCPR1L++;      // Incrementa o Duty Cicle
}

if(!RB1_bit)
{
delay_ms(200);
CCPR1L--;      // Incrementa o Duty Cicle
}//end if
}// end while
}//end void main