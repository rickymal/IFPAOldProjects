
_Pisca_LED:

;led.h,1 :: 		void Pisca_LED(unsigned char *info){
;led.h,2 :: 		delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_Pisca_LED0:
	DECFSZ      R13, 1, 1
	BRA         L_Pisca_LED0
	DECFSZ      R12, 1, 1
	BRA         L_Pisca_LED0
	NOP
;led.h,3 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;led.h,4 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;led.h,5 :: 		while(*info == 1){
L_Pisca_LED1:
	MOVFF       FARG_Pisca_LED_info+0, FSR0
	MOVFF       FARG_Pisca_LED_info+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Pisca_LED2
;led.h,6 :: 		PORTD =0x55;
	MOVLW       85
	MOVWF       PORTD+0 
;led.h,7 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_Pisca_LED3:
	DECFSZ      R13, 1, 1
	BRA         L_Pisca_LED3
	DECFSZ      R12, 1, 1
	BRA         L_Pisca_LED3
	DECFSZ      R11, 1, 1
	BRA         L_Pisca_LED3
	NOP
	NOP
;led.h,8 :: 		PORTD =0xAA;
	MOVLW       170
	MOVWF       PORTD+0 
;led.h,9 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_Pisca_LED4:
	DECFSZ      R13, 1, 1
	BRA         L_Pisca_LED4
	DECFSZ      R12, 1, 1
	BRA         L_Pisca_LED4
	DECFSZ      R11, 1, 1
	BRA         L_Pisca_LED4
	NOP
	NOP
;led.h,10 :: 		}
	GOTO        L_Pisca_LED1
L_Pisca_LED2:
;led.h,11 :: 		}
L_end_Pisca_LED:
	RETURN      0
; end of _Pisca_LED

_Temperatura_LCD:

;temperatura.h,23 :: 		void Temperatura_LCD(unsigned char *info){  //-Função principal
;temperatura.h,24 :: 		ADCON0 = 0x0D;      // Seleciona a Porta AN3 // ADON_bit = 1
	MOVLW       13
	MOVWF       ADCON0+0 
;temperatura.h,25 :: 		ADCON1 = 0x0B;      // Configura AN0, AN1, AN2, AN3 como portas ANALÓGICAS
	MOVLW       11
	MOVWF       ADCON1+0 
;temperatura.h,26 :: 		TRISA.RA3 = 1;      // PINO RA3[AN2] = entrada
	BSF         TRISA+0, 3 
;temperatura.h,28 :: 		TRISB.RB0 = 1;
	BSF         TRISB+0, 0 
;temperatura.h,29 :: 		PORTB.RB0 = 1;
	BSF         PORTB+0, 0 
;temperatura.h,31 :: 		TRISB.RB1 = 1;
	BSF         TRISB+0, 1 
;temperatura.h,32 :: 		PORTB.RB1 = 1;
	BSF         PORTB+0, 1 
;temperatura.h,34 :: 		Lcd_Init();                         //Inicializa o display
	CALL        _Lcd_Init+0, 0
;temperatura.h,35 :: 		Lcd_Cmd(_Lcd_Cursor_Off);           //Apaga o cursor
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;temperatura.h,36 :: 		Lcd_Cmd(_LCD_CLEAR);                //Limpa o display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;temperatura.h,38 :: 		text=("TEMPERATURA");               //Armazena o texto na variável text
	MOVLW       ?lstr1_Bluetooth_PIC18F4550+0
	MOVWF       _text+0 
	MOVLW       hi_addr(?lstr1_Bluetooth_PIC18F4550+0)
	MOVWF       _text+1 
;temperatura.h,39 :: 		lcd_out(1,3,text);                  //Escreve o texto uma vez no display, linha 1, coluna 3
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _text+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _text+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;temperatura.h,41 :: 		while(*info == 3){                         //Início do loop infinito
L_Temperatura_LCD5:
	MOVFF       FARG_Temperatura_LCD_info+0, FSR0
	MOVFF       FARG_Temperatura_LCD_info+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Temperatura_LCD6
;temperatura.h,42 :: 		Celsius();
	CALL        _Celsius+0, 0
;temperatura.h,43 :: 		} //end while
	GOTO        L_Temperatura_LCD5
L_Temperatura_LCD6:
;temperatura.h,45 :: 		} //end main
L_end_Temperatura_LCD:
	RETURN      0
; end of _Temperatura_LCD

_Celsius:

;temperatura.h,47 :: 		void Celsius(){
;temperatura.h,48 :: 		store = media_temp();         //atribui a média de 100 medidas à variável store
	CALL        _media_temp+0, 0
	MOVF        R0, 0 
	MOVWF       _store+0 
	MOVF        R1, 0 
	MOVWF       _store+1 
	MOVF        R2, 0 
	MOVWF       _store+2 
	MOVF        R3, 0 
	MOVWF       _store+3 
;temperatura.h,49 :: 		t_Celsius = (store*5*100)/1023; //converte o valor para escala Celsius
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       255
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       _t_Celsius+0 
	MOVF        R1, 0 
	MOVWF       _t_Celsius+1 
	MOVF        R2, 0 
	MOVWF       _t_Celsius+2 
	MOVF        R3, 0 
	MOVWF       _t_Celsius+3 
;temperatura.h,56 :: 		dezena = t_Celsius/10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       _dezena+0 
;temperatura.h,57 :: 		unidade = t_Celsius % 10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        _t_Celsius+0, 0 
	MOVWF       R0 
	MOVF        _t_Celsius+1, 0 
	MOVWF       R1 
	MOVF        _t_Celsius+2, 0 
	MOVWF       R2 
	MOVF        _t_Celsius+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _unidade+0 
;temperatura.h,58 :: 		dec1 = (((store*5*100)%1023)*10)/1023;
	MOVF        _store+0, 0 
	MOVWF       R0 
	MOVF        _store+1, 0 
	MOVWF       R1 
	MOVF        _store+2, 0 
	MOVWF       R2 
	MOVF        _store+3, 0 
	MOVWF       R3 
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       255
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Div_32x32_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Celsius+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Celsius+1 
	MOVF        R2, 0 
	MOVWF       FLOC__Celsius+2 
	MOVF        R3, 0 
	MOVWF       FLOC__Celsius+3 
	MOVLW       255
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	MOVF        FLOC__Celsius+0, 0 
	MOVWF       R0 
	MOVF        FLOC__Celsius+1, 0 
	MOVWF       R1 
	MOVF        FLOC__Celsius+2, 0 
	MOVWF       R2 
	MOVF        FLOC__Celsius+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       _dec1+0 
;temperatura.h,59 :: 		dec2 = (((((store*5*100)%1023)*10)%1023)*10)/1023;
	MOVLW       255
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	MOVF        FLOC__Celsius+0, 0 
	MOVWF       R0 
	MOVF        FLOC__Celsius+1, 0 
	MOVWF       R1 
	MOVF        FLOC__Celsius+2, 0 
	MOVWF       R2 
	MOVF        FLOC__Celsius+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       255
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       _dec2+0 
;temperatura.h,60 :: 		Lcd_Out(2,5," ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Bluetooth_PIC18F4550+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Bluetooth_PIC18F4550+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;temperatura.h,61 :: 		disp_t;              //chama a macro
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       _dezena+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
	MOVLW       48
	ADDWF       _unidade+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
	MOVLW       48
	ADDWF       _dec1+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
	MOVLW       48
	ADDWF       _dec2+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
	MOVLW       2
	MOVWF       FARG_CustomChar_pos_row+0 
	MOVLW       11
	MOVWF       FARG_CustomChar_pos_char+0 
	CALL        _CustomChar+0, 0
;temperatura.h,63 :: 		Lcd_Out(2,12,"C");   //escreve "C" de Celsius no display
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_Bluetooth_PIC18F4550+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_Bluetooth_PIC18F4550+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;temperatura.h,67 :: 		delay_ms(250);       //taxa de atualização do display e das medidas
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_Celsius7:
	DECFSZ      R13, 1, 1
	BRA         L_Celsius7
	DECFSZ      R12, 1, 1
	BRA         L_Celsius7
	DECFSZ      R11, 1, 1
	BRA         L_Celsius7
	NOP
	NOP
;temperatura.h,68 :: 		} // End void Celsius
L_end_Celsius:
	RETURN      0
; end of _Celsius

_media_temp:

;temperatura.h,71 :: 		long media_temp(){     // Calcula a média de 100 medidas
;temperatura.h,73 :: 		unsigned long temp_store = 0;
	CLRF        media_temp_temp_store_L0+0 
	CLRF        media_temp_temp_store_L0+1 
	CLRF        media_temp_temp_store_L0+2 
	CLRF        media_temp_temp_store_L0+3 
;temperatura.h,74 :: 		for(i=0; i<100; i++)
	CLRF        media_temp_i_L0+0 
L_media_temp8:
	MOVLW       100
	SUBWF       media_temp_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_media_temp9
;temperatura.h,76 :: 		temp_store += ADC_Read(3); //temp_store = temp_store + ADC_Read(0) (faz o somatório das 100 iterações
	MOVLW       3
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	ADDWF       media_temp_temp_store_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      media_temp_temp_store_L0+1, 1 
	MOVLW       0
	ADDWFC      media_temp_temp_store_L0+2, 1 
	ADDWFC      media_temp_temp_store_L0+3, 1 
;temperatura.h,74 :: 		for(i=0; i<100; i++)
	INCF        media_temp_i_L0+0, 1 
;temperatura.h,77 :: 		}
	GOTO        L_media_temp8
L_media_temp9:
;temperatura.h,78 :: 		return(temp_store/100); //retorna a média das iterações
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        media_temp_temp_store_L0+0, 0 
	MOVWF       R0 
	MOVF        media_temp_temp_store_L0+1, 0 
	MOVWF       R1 
	MOVF        media_temp_temp_store_L0+2, 0 
	MOVWF       R2 
	MOVF        media_temp_temp_store_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
;temperatura.h,79 :: 		}//end media temp
L_end_media_temp:
	RETURN      0
; end of _media_temp

_CustomChar:

;temperatura.h,82 :: 		void CustomChar(char pos_row, char pos_char){  //função gerada pelo mikroC para imprimir caracteres especiais
;temperatura.h,84 :: 		Lcd_Cmd(64);
	MOVLW       64
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;temperatura.h,85 :: 		for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
	CLRF        CustomChar_i_L0+0 
L_CustomChar11:
	MOVF        CustomChar_i_L0+0, 0 
	SUBLW       7
	BTFSS       STATUS+0, 0 
	GOTO        L_CustomChar12
	MOVLW       _character+0
	ADDWF       CustomChar_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_character+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_character+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_Lcd_Chr_CP_out_char+0
	CALL        _Lcd_Chr_CP+0, 0
	INCF        CustomChar_i_L0+0, 1 
	GOTO        L_CustomChar11
L_CustomChar12:
;temperatura.h,86 :: 		Lcd_Cmd(_LCD_RETURN_HOME);
	MOVLW       2
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;temperatura.h,87 :: 		Lcd_Chr(pos_row, pos_char, 0);
	MOVF        FARG_CustomChar_pos_row+0, 0 
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        FARG_CustomChar_pos_char+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	CLRF        FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;temperatura.h,88 :: 		}//end CustomChar
L_end_CustomChar:
	RETURN      0
; end of _CustomChar

_LigaVentoinha:

;temperatura.h,90 :: 		void LigaVentoinha(unsigned char *info){
;temperatura.h,91 :: 		TRISC.RC2 = 0;      // Declara o pino RC2 do registrador PORT'C como saída
	BCF         TRISC+0, 2 
;temperatura.h,92 :: 		PORTC.RC2 = 0;       // inicia em low
	BCF         PORTC+0, 2 
;temperatura.h,93 :: 		TRISC.RC1 = 0;
	BCF         TRISC+0, 1 
;temperatura.h,94 :: 		PORTC.RC1 = 0;
	BCF         PORTC+0, 1 
;temperatura.h,96 :: 		while(*info == 4)            // Loop Infinito
L_LigaVentoinha14:
	MOVFF       FARG_LigaVentoinha_info+0, FSR0
	MOVFF       FARG_LigaVentoinha_info+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_LigaVentoinha15
;temperatura.h,98 :: 		RC2_bit = 1;           // Ativa ventoinha
	BSF         RC2_bit+0, 2 
;temperatura.h,101 :: 		} // and while
	GOTO        L_LigaVentoinha14
L_LigaVentoinha15:
;temperatura.h,102 :: 		} // end void main
L_end_LigaVentoinha:
	RETURN      0
; end of _LigaVentoinha

_AtivaAquecedor:

;temperatura.h,104 :: 		void AtivaAquecedor(unsigned char *info){
;temperatura.h,105 :: 		TRISC.RC1 = 0;
	BCF         TRISC+0, 1 
;temperatura.h,106 :: 		PORTC.RC1 = 0;
	BCF         PORTC+0, 1 
;temperatura.h,107 :: 		TRISC.RC2 = 0;      // Declara o pino RC2 do registrador PORT'C como saída
	BCF         TRISC+0, 2 
;temperatura.h,108 :: 		PORTC.RC2 = 0;       // Coloca todo o PORT'C em low
	BCF         PORTC+0, 2 
;temperatura.h,110 :: 		while(*info == 5){
L_AtivaAquecedor16:
	MOVFF       FARG_AtivaAquecedor_info+0, FSR0
	MOVFF       FARG_AtivaAquecedor_info+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_AtivaAquecedor17
;temperatura.h,111 :: 		RC1_bit = 1;   // Ativa aquecedor
	BSF         RC1_bit+0, 1 
;temperatura.h,113 :: 		}
	GOTO        L_AtivaAquecedor16
L_AtivaAquecedor17:
;temperatura.h,115 :: 		}
L_end_AtivaAquecedor:
	RETURN      0
; end of _AtivaAquecedor

_Cnt_Display_7seg:

;display_7seg.h,1 :: 		void Cnt_Display_7seg(unsigned char *info){
;display_7seg.h,11 :: 		0x67};          // 9
	MOVLW       63
	MOVWF       Cnt_Display_7seg_digito_L0+0 
	MOVLW       6
	MOVWF       Cnt_Display_7seg_digito_L0+1 
	MOVLW       91
	MOVWF       Cnt_Display_7seg_digito_L0+2 
	MOVLW       79
	MOVWF       Cnt_Display_7seg_digito_L0+3 
	MOVLW       102
	MOVWF       Cnt_Display_7seg_digito_L0+4 
	MOVLW       109
	MOVWF       Cnt_Display_7seg_digito_L0+5 
	MOVLW       125
	MOVWF       Cnt_Display_7seg_digito_L0+6 
	MOVLW       7
	MOVWF       Cnt_Display_7seg_digito_L0+7 
	MOVLW       127
	MOVWF       Cnt_Display_7seg_digito_L0+8 
	MOVLW       103
	MOVWF       Cnt_Display_7seg_digito_L0+9 
	CLRF        Cnt_Display_7seg_Cnt_L0+0 
	CLRF        Cnt_Display_7seg_Cnt_L0+1 
	CLRF        Cnt_Display_7seg_Uni_L0+0 
	CLRF        Cnt_Display_7seg_Uni_L0+1 
;display_7seg.h,17 :: 		TRISD = 0x80;     //Declara RD7 como entrada e os demais pinos como saídas
	MOVLW       128
	MOVWF       TRISD+0 
;display_7seg.h,18 :: 		PORTD = 0x00;     //Inicia todos os pinos de PORTD em low
	CLRF        PORTD+0 
;display_7seg.h,19 :: 		TRISE = 0x00;     //Declara todos os pinos do registrador PORT'E como saídas
	CLRF        TRISE+0 
;display_7seg.h,20 :: 		PORTE = 0x00;     //Inicia todos os pinos de PORT'E em low
	CLRF        PORTE+0 
;display_7seg.h,21 :: 		TRISA.RA5 = 0x00;    //Declara o pino RA5 como saída
	BCF         TRISA+0, 5 
;display_7seg.h,22 :: 		PORTA.RA5 = 0x00;    //Inicia o pino RA5 em low
	BCF         PORTA+0, 5 
;display_7seg.h,23 :: 		while(*info == 2)
L_Cnt_Display_7seg18:
	MOVFF       FARG_Cnt_Display_7seg_info+0, FSR0
	MOVFF       FARG_Cnt_Display_7seg_info+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Cnt_Display_7seg19
;display_7seg.h,27 :: 		é mostrado no display (aprox= 40ms) */
	CLRF        Cnt_Display_7seg_i_L0+0 
L_Cnt_Display_7seg20:
	MOVF        Cnt_Display_7seg_i_L0+0, 0 
	SUBLW       1
	BTFSS       STATUS+0, 0 
	GOTO        L_Cnt_Display_7seg21
;display_7seg.h,29 :: 		Uni = (Cnt%10);                              // Calcula a unidade
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        Cnt_Display_7seg_Cnt_L0+0, 0 
	MOVWF       R0 
	MOVF        Cnt_Display_7seg_Cnt_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       Cnt_Display_7seg_Uni_L0+0 
	MOVF        R1, 0 
	MOVWF       Cnt_Display_7seg_Uni_L0+1 
;display_7seg.h,32 :: 		Dez = (Cnt%100);                             // Calcula a dezena
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        Cnt_Display_7seg_Cnt_L0+0, 0 
	MOVWF       R0 
	MOVF        Cnt_Display_7seg_Cnt_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       Cnt_Display_7seg_Dez_L0+0 
	MOVF        R1, 0 
	MOVWF       Cnt_Display_7seg_Dez_L0+1 
;display_7seg.h,34 :: 		Dez = (Dez/10) - ((Dez%10)/10);              // Calcula a dezena
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Cnt_Display_7seg+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Cnt_Display_7seg+1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        Cnt_Display_7seg_Dez_L0+0, 0 
	MOVWF       R0 
	MOVF        Cnt_Display_7seg_Dez_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	SUBWF       FLOC__Cnt_Display_7seg+0, 0 
	MOVWF       Cnt_Display_7seg_Dez_L0+0 
	MOVF        R1, 0 
	SUBWFB      FLOC__Cnt_Display_7seg+1, 0 
	MOVWF       Cnt_Display_7seg_Dez_L0+1 
;display_7seg.h,37 :: 		Cen = (Cnt%1000);                            // Calcula a centena
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        Cnt_Display_7seg_Cnt_L0+0, 0 
	MOVWF       R0 
	MOVF        Cnt_Display_7seg_Cnt_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       Cnt_Display_7seg_Cen_L0+0 
	MOVF        R1, 0 
	MOVWF       Cnt_Display_7seg_Cen_L0+1 
;display_7seg.h,39 :: 		Cen = (Cen/100)-((Cen%100)/100);             // Calcula a centena
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Cnt_Display_7seg+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Cnt_Display_7seg+1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        Cnt_Display_7seg_Cen_L0+0, 0 
	MOVWF       R0 
	MOVF        Cnt_Display_7seg_Cen_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	SUBWF       FLOC__Cnt_Display_7seg+0, 0 
	MOVWF       Cnt_Display_7seg_Cen_L0+0 
	MOVF        R1, 0 
	SUBWFB      FLOC__Cnt_Display_7seg+1, 0 
	MOVWF       Cnt_Display_7seg_Cen_L0+1 
;display_7seg.h,42 :: 		Mil = (Cnt/1000) - ((Mil%1000)/1000);        // calcula o milênio
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        Cnt_Display_7seg_Cnt_L0+0, 0 
	MOVWF       R0 
	MOVF        Cnt_Display_7seg_Cnt_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Cnt_Display_7seg+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Cnt_Display_7seg+1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        Cnt_Display_7seg_Mil_L0+0, 0 
	MOVWF       R0 
	MOVF        Cnt_Display_7seg_Mil_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	SUBWF       FLOC__Cnt_Display_7seg+0, 0 
	MOVWF       Cnt_Display_7seg_Mil_L0+0 
	MOVF        R1, 0 
	SUBWFB      FLOC__Cnt_Display_7seg+1, 0 
	MOVWF       Cnt_Display_7seg_Mil_L0+1 
;display_7seg.h,45 :: 		PORTD = (digito[Uni]);       // Apresenta Digito[Unidade_do_contador]
	MOVLW       Cnt_Display_7seg_digito_L0+0
	ADDWF       Cnt_Display_7seg_Uni_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(Cnt_Display_7seg_digito_L0+0)
	ADDWFC      Cnt_Display_7seg_Uni_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTD+0 
;display_7seg.h,46 :: 		RA5_bit = 1;                                   // Habilita RA5
	BSF         RA5_bit+0, 5 
;display_7seg.h,47 :: 		delay_ms(5);                                   // Aguarda 5ms
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_Cnt_Display_7seg23:
	DECFSZ      R13, 1, 1
	BRA         L_Cnt_Display_7seg23
	DECFSZ      R12, 1, 1
	BRA         L_Cnt_Display_7seg23
	NOP
	NOP
;display_7seg.h,48 :: 		RA5_bit = 0;                                   // Desabilita
	BCF         RA5_bit+0, 5 
;display_7seg.h,50 :: 		PORTD = (digito[Dez]);       // Apresenta Digito[Dezena_do_contador]
	MOVLW       Cnt_Display_7seg_digito_L0+0
	ADDWF       Cnt_Display_7seg_Dez_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(Cnt_Display_7seg_digito_L0+0)
	ADDWFC      Cnt_Display_7seg_Dez_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTD+0 
;display_7seg.h,51 :: 		RE2_bit = 1;                                   // Habilita RE2
	BSF         RE2_bit+0, 2 
;display_7seg.h,52 :: 		delay_ms(5);                                   // Aguarda 5ms
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_Cnt_Display_7seg24:
	DECFSZ      R13, 1, 1
	BRA         L_Cnt_Display_7seg24
	DECFSZ      R12, 1, 1
	BRA         L_Cnt_Display_7seg24
	NOP
	NOP
;display_7seg.h,53 :: 		RE2_bit = 0;                                   // Desabilita
	BCF         RE2_bit+0, 2 
;display_7seg.h,55 :: 		PORTD = (digito[Cen]);       // Apresenta Digito[Centena_do_contador]
	MOVLW       Cnt_Display_7seg_digito_L0+0
	ADDWF       Cnt_Display_7seg_Cen_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(Cnt_Display_7seg_digito_L0+0)
	ADDWFC      Cnt_Display_7seg_Cen_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTD+0 
;display_7seg.h,56 :: 		RE1_bit = 1;                                   // Habilita RE1
	BSF         RE1_bit+0, 1 
;display_7seg.h,57 :: 		delay_ms(5);                                   // Aguarda 5ms
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_Cnt_Display_7seg25:
	DECFSZ      R13, 1, 1
	BRA         L_Cnt_Display_7seg25
	DECFSZ      R12, 1, 1
	BRA         L_Cnt_Display_7seg25
	NOP
	NOP
;display_7seg.h,58 :: 		RE1_bit = 0;                                   // Desabilita
	BCF         RE1_bit+0, 1 
;display_7seg.h,60 :: 		PORTD = (digito[Mil]);       // Apresenta Digito[Milenar_do_contador]
	MOVLW       Cnt_Display_7seg_digito_L0+0
	ADDWF       Cnt_Display_7seg_Mil_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(Cnt_Display_7seg_digito_L0+0)
	ADDWFC      Cnt_Display_7seg_Mil_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTD+0 
;display_7seg.h,61 :: 		RE0_bit = 1;                                   // Habilita RE0
	BSF         RE0_bit+0, 0 
;display_7seg.h,62 :: 		delay_ms(5);                                   // Aguarda 5ms
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_Cnt_Display_7seg26:
	DECFSZ      R13, 1, 1
	BRA         L_Cnt_Display_7seg26
	DECFSZ      R12, 1, 1
	BRA         L_Cnt_Display_7seg26
	NOP
	NOP
;display_7seg.h,63 :: 		RE0_bit = 0;                                   // Desabilita
	BCF         RE0_bit+0, 0 
;display_7seg.h,27 :: 		é mostrado no display (aprox= 40ms) */
	INCF        Cnt_Display_7seg_i_L0+0, 1 
;display_7seg.h,64 :: 		}// end for
	GOTO        L_Cnt_Display_7seg20
L_Cnt_Display_7seg21:
;display_7seg.h,65 :: 		if(Cnt == 10000){ // Se Cnt for igual á 10000...
	MOVF        Cnt_Display_7seg_Cnt_L0+1, 0 
	XORLW       39
	BTFSS       STATUS+0, 2 
	GOTO        L__Cnt_Display_7seg194
	MOVLW       16
	XORWF       Cnt_Display_7seg_Cnt_L0+0, 0 
L__Cnt_Display_7seg194:
	BTFSS       STATUS+0, 2 
	GOTO        L_Cnt_Display_7seg27
;display_7seg.h,66 :: 		Cnt = 0;                        // Zera a variável de contagem, recomeça
	CLRF        Cnt_Display_7seg_Cnt_L0+0 
	CLRF        Cnt_Display_7seg_Cnt_L0+1 
;display_7seg.h,67 :: 		delay_ms(1000);                 // Delay de 1 segundo
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_Cnt_Display_7seg28:
	DECFSZ      R13, 1, 1
	BRA         L_Cnt_Display_7seg28
	DECFSZ      R12, 1, 1
	BRA         L_Cnt_Display_7seg28
	DECFSZ      R11, 1, 1
	BRA         L_Cnt_Display_7seg28
	NOP
	NOP
;display_7seg.h,68 :: 		PORTD = 0x00;                   // Zera PORTD
	CLRF        PORTD+0 
;display_7seg.h,69 :: 		}//end if
L_Cnt_Display_7seg27:
;display_7seg.h,70 :: 		Cnt++;                          // Incrementa a variável de contagem em 1
	INFSNZ      Cnt_Display_7seg_Cnt_L0+0, 1 
	INCF        Cnt_Display_7seg_Cnt_L0+1, 1 
;display_7seg.h,71 :: 		}//end while
	GOTO        L_Cnt_Display_7seg18
L_Cnt_Display_7seg19:
;display_7seg.h,72 :: 		}//end void
L_end_Cnt_Display_7seg:
	RETURN      0
; end of _Cnt_Display_7seg

_IFPA_Disp_7seg:

;display_7seg.h,75 :: 		void IFPA_Disp_7seg(unsigned char *info){
;display_7seg.h,77 :: 		unsigned char letra_I = 0x06;
	MOVLW       6
	MOVWF       IFPA_Disp_7seg_letra_I_L0+0 
	MOVLW       113
	MOVWF       IFPA_Disp_7seg_letra_F_L0+0 
	MOVLW       115
	MOVWF       IFPA_Disp_7seg_letra_P_L0+0 
	MOVLW       119
	MOVWF       IFPA_Disp_7seg_letra_A_L0+0 
;display_7seg.h,84 :: 		TRISD = 0x80;      //Declara RD7 como entrada e os demais pinos como saídas
	MOVLW       128
	MOVWF       TRISD+0 
;display_7seg.h,85 :: 		PORTD = 0x00;      //Coloca todos os pinos de PORTD em low
	CLRF        PORTD+0 
;display_7seg.h,86 :: 		TRISE = 0x00;      //Declara todos os pinos do registrador PORT'E como saídas
	CLRF        TRISE+0 
;display_7seg.h,87 :: 		PORTE = 0x00;      //Coloca todos os pinos de PORT'E em low
	CLRF        PORTE+0 
;display_7seg.h,88 :: 		TRISA.RA5 = 0x00;  //Declara o pino RA5 como saída
	BCF         TRISA+0, 5 
;display_7seg.h,89 :: 		PORTA.RA5 = 0x00;  //Coloca o pino RA5 em low
	BCF         PORTA+0, 5 
;display_7seg.h,91 :: 		while (*info == 8){         //Loop infinito
L_IFPA_Disp_7seg29:
	MOVFF       FARG_IFPA_Disp_7seg_info+0, FSR0
	MOVFF       FARG_IFPA_Disp_7seg_info+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_IFPA_Disp_7seg30
;display_7seg.h,92 :: 		for(i=0;i<=199;i++){              //Executa esse laço por aprox. 4s
	CLRF        R1 
L_IFPA_Disp_7seg31:
	MOVF        R1, 0 
	SUBLW       199
	BTFSS       STATUS+0, 0 
	GOTO        L_IFPA_Disp_7seg32
;display_7seg.h,94 :: 		PORTD = letra_A;        // Apresenta a LETRA A
	MOVF        IFPA_Disp_7seg_letra_A_L0+0, 0 
	MOVWF       PORTD+0 
;display_7seg.h,95 :: 		RA5_bit = 1;                                    // Habilita RA5
	BSF         RA5_bit+0, 5 
;display_7seg.h,96 :: 		delay_ms(5);                                    // Aguarda 5ms
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_IFPA_Disp_7seg34:
	DECFSZ      R13, 1, 1
	BRA         L_IFPA_Disp_7seg34
	DECFSZ      R12, 1, 1
	BRA         L_IFPA_Disp_7seg34
	NOP
	NOP
;display_7seg.h,97 :: 		RA5_bit = 0;                                    // Desabilita
	BCF         RA5_bit+0, 5 
;display_7seg.h,99 :: 		PORTD = letra_P;        // Apresenta a LETRA P
	MOVF        IFPA_Disp_7seg_letra_P_L0+0, 0 
	MOVWF       PORTD+0 
;display_7seg.h,100 :: 		RE2_bit = 1;                                    // Habilita RE2
	BSF         RE2_bit+0, 2 
;display_7seg.h,101 :: 		delay_ms (5);                                   // Aguarda 5ms
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_IFPA_Disp_7seg35:
	DECFSZ      R13, 1, 1
	BRA         L_IFPA_Disp_7seg35
	DECFSZ      R12, 1, 1
	BRA         L_IFPA_Disp_7seg35
	NOP
	NOP
;display_7seg.h,102 :: 		RE2_bit = 0;                                    // Desabilita
	BCF         RE2_bit+0, 2 
;display_7seg.h,104 :: 		PORTD = letra_F;        // Apresenta a LETRA F
	MOVF        IFPA_Disp_7seg_letra_F_L0+0, 0 
	MOVWF       PORTD+0 
;display_7seg.h,105 :: 		RE1_bit = 1;                                    // Habilita RE1
	BSF         RE1_bit+0, 1 
;display_7seg.h,106 :: 		delay_ms (5);                                   // Aguarda 5ms
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_IFPA_Disp_7seg36:
	DECFSZ      R13, 1, 1
	BRA         L_IFPA_Disp_7seg36
	DECFSZ      R12, 1, 1
	BRA         L_IFPA_Disp_7seg36
	NOP
	NOP
;display_7seg.h,107 :: 		RE1_bit = 0;                                    // Desabilita
	BCF         RE1_bit+0, 1 
;display_7seg.h,109 :: 		PORTD = letra_I;        // Apresenta a LETRA I
	MOVF        IFPA_Disp_7seg_letra_I_L0+0, 0 
	MOVWF       PORTD+0 
;display_7seg.h,110 :: 		RE0_bit = 1;                                    // Habilita RE0
	BSF         RE0_bit+0, 0 
;display_7seg.h,111 :: 		delay_ms (5);                                   // Aguarda 5ms
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_IFPA_Disp_7seg37:
	DECFSZ      R13, 1, 1
	BRA         L_IFPA_Disp_7seg37
	DECFSZ      R12, 1, 1
	BRA         L_IFPA_Disp_7seg37
	NOP
	NOP
;display_7seg.h,112 :: 		RE0_bit = 0;                                    // Desabilita
	BCF         RE0_bit+0, 0 
;display_7seg.h,92 :: 		for(i=0;i<=199;i++){              //Executa esse laço por aprox. 4s
	INCF        R1, 1 
;display_7seg.h,113 :: 		}   //end for1
	GOTO        L_IFPA_Disp_7seg31
L_IFPA_Disp_7seg32:
;display_7seg.h,115 :: 		for(i=0;i<=3;i++){              //Executa esse laço por aprox. 8s
	CLRF        R1 
L_IFPA_Disp_7seg38:
	MOVF        R1, 0 
	SUBLW       3
	BTFSS       STATUS+0, 0 
	GOTO        L_IFPA_Disp_7seg39
;display_7seg.h,117 :: 		PORTD = letra_I;        // Apresenta a LETRA I
	MOVF        IFPA_Disp_7seg_letra_I_L0+0, 0 
	MOVWF       PORTD+0 
;display_7seg.h,118 :: 		RE0_bit = 1;                                    // Habilita RE0
	BSF         RE0_bit+0, 0 
;display_7seg.h,119 :: 		delay_ms (500);                                 // Aguarda 500ms
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_IFPA_Disp_7seg41:
	DECFSZ      R13, 1, 1
	BRA         L_IFPA_Disp_7seg41
	DECFSZ      R12, 1, 1
	BRA         L_IFPA_Disp_7seg41
	DECFSZ      R11, 1, 1
	BRA         L_IFPA_Disp_7seg41
	NOP
	NOP
;display_7seg.h,120 :: 		RE0_bit = 0;                                    // Desabilita
	BCF         RE0_bit+0, 0 
;display_7seg.h,122 :: 		PORTD = letra_F;        // Apresenta a LETRA F
	MOVF        IFPA_Disp_7seg_letra_F_L0+0, 0 
	MOVWF       PORTD+0 
;display_7seg.h,123 :: 		RE1_bit = 1;                                    // Habilita RE1
	BSF         RE1_bit+0, 1 
;display_7seg.h,124 :: 		delay_ms (500);                                 // Aguarda 5000ms
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_IFPA_Disp_7seg42:
	DECFSZ      R13, 1, 1
	BRA         L_IFPA_Disp_7seg42
	DECFSZ      R12, 1, 1
	BRA         L_IFPA_Disp_7seg42
	DECFSZ      R11, 1, 1
	BRA         L_IFPA_Disp_7seg42
	NOP
	NOP
;display_7seg.h,125 :: 		RE1_bit = 0;                                    // Desabilita
	BCF         RE1_bit+0, 1 
;display_7seg.h,127 :: 		PORTD = letra_P;        // Apresenta a LETRA P
	MOVF        IFPA_Disp_7seg_letra_P_L0+0, 0 
	MOVWF       PORTD+0 
;display_7seg.h,128 :: 		RE2_bit = 1;                                    // Habilita RE2
	BSF         RE2_bit+0, 2 
;display_7seg.h,129 :: 		delay_ms (500);                                 // Aguarda 500ms
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_IFPA_Disp_7seg43:
	DECFSZ      R13, 1, 1
	BRA         L_IFPA_Disp_7seg43
	DECFSZ      R12, 1, 1
	BRA         L_IFPA_Disp_7seg43
	DECFSZ      R11, 1, 1
	BRA         L_IFPA_Disp_7seg43
	NOP
	NOP
;display_7seg.h,130 :: 		RE2_bit = 0;                                    // Desabilita
	BCF         RE2_bit+0, 2 
;display_7seg.h,132 :: 		PORTD = letra_A;        // Apresenta a LETRA A
	MOVF        IFPA_Disp_7seg_letra_A_L0+0, 0 
	MOVWF       PORTD+0 
;display_7seg.h,133 :: 		RA5_bit = 1;                                    // Habilita RA5
	BSF         RA5_bit+0, 5 
;display_7seg.h,134 :: 		delay_ms(500);                                  // Aguarda 500ms
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_IFPA_Disp_7seg44:
	DECFSZ      R13, 1, 1
	BRA         L_IFPA_Disp_7seg44
	DECFSZ      R12, 1, 1
	BRA         L_IFPA_Disp_7seg44
	DECFSZ      R11, 1, 1
	BRA         L_IFPA_Disp_7seg44
	NOP
	NOP
;display_7seg.h,135 :: 		RA5_bit = 0;                                    // Desabilita
	BCF         RA5_bit+0, 5 
;display_7seg.h,115 :: 		for(i=0;i<=3;i++){              //Executa esse laço por aprox. 8s
	INCF        R1, 1 
;display_7seg.h,136 :: 		}  //end for2
	GOTO        L_IFPA_Disp_7seg38
L_IFPA_Disp_7seg39:
;display_7seg.h,137 :: 		}  //end while
	GOTO        L_IFPA_Disp_7seg29
L_IFPA_Disp_7seg30:
;display_7seg.h,138 :: 		}
L_end_IFPA_Disp_7seg:
	RETURN      0
; end of _IFPA_Disp_7seg

_Toca_Buzzer:

;buzzer.h,113 :: 		void Toca_Buzzer() {
;buzzer.h,114 :: 		ADCON1 = 0x0F;                  // Configura as PORTAS como digitais I/O's
	MOVLW       15
	MOVWF       ADCON1+0 
;buzzer.h,117 :: 		Sound_Init(&PORTC, 2);
	MOVLW       PORTC+0
	MOVWF       FARG_Sound_Init_snd_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Sound_Init_snd_port+1 
	MOVLW       2
	MOVWF       FARG_Sound_Init_snd_pin+0 
	CALL        _Sound_Init+0, 0
;buzzer.h,118 :: 		melodia(); //Chama a Função 'melodia'
	CALL        _melodia+0, 0
;buzzer.h,119 :: 		}//end void
L_end_Toca_Buzzer:
	RETURN      0
; end of _Toca_Buzzer

_melodia:

;buzzer.h,121 :: 		void melodia() {
;buzzer.h,126 :: 		Sound_Play(A3,Q);
	MOVLW       220
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       144
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,127 :: 		delay_ms(1+Q);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       18
	MOVWF       R12, 0
	MOVLW       137
	MOVWF       R13, 0
L_melodia45:
	DECFSZ      R13, 1, 1
	BRA         L_melodia45
	DECFSZ      R12, 1, 1
	BRA         L_melodia45
	DECFSZ      R11, 1, 1
	BRA         L_melodia45
	NOP
	NOP
;buzzer.h,128 :: 		Sound_Play(A3,Q);
	MOVLW       220
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       144
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,129 :: 		delay_ms(1+Q);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       18
	MOVWF       R12, 0
	MOVLW       137
	MOVWF       R13, 0
L_melodia46:
	DECFSZ      R13, 1, 1
	BRA         L_melodia46
	DECFSZ      R12, 1, 1
	BRA         L_melodia46
	DECFSZ      R11, 1, 1
	BRA         L_melodia46
	NOP
	NOP
;buzzer.h,130 :: 		Sound_Play(A3,Q);
	MOVLW       220
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       144
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,131 :: 		delay_ms(1+Q);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       18
	MOVWF       R12, 0
	MOVLW       137
	MOVWF       R13, 0
L_melodia47:
	DECFSZ      R13, 1, 1
	BRA         L_melodia47
	DECFSZ      R12, 1, 1
	BRA         L_melodia47
	DECFSZ      R11, 1, 1
	BRA         L_melodia47
	NOP
	NOP
;buzzer.h,132 :: 		Sound_Play(F3,E+S);
	MOVLW       174
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       44
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,133 :: 		delay_ms(1+E+S);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       14
	MOVWF       R12, 0
	MOVLW       205
	MOVWF       R13, 0
L_melodia48:
	DECFSZ      R13, 1, 1
	BRA         L_melodia48
	DECFSZ      R12, 1, 1
	BRA         L_melodia48
	DECFSZ      R11, 1, 1
	BRA         L_melodia48
;buzzer.h,134 :: 		Sound_Play(C4,S);
	MOVLW       5
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,135 :: 		delay_ms(1+S);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       83
	MOVWF       R13, 0
L_melodia49:
	DECFSZ      R13, 1, 1
	BRA         L_melodia49
	DECFSZ      R12, 1, 1
	BRA         L_melodia49
	DECFSZ      R11, 1, 1
	BRA         L_melodia49
;buzzer.h,137 :: 		Sound_Play(A3,Q);
	MOVLW       220
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       144
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,138 :: 		delay_ms(1+Q);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       18
	MOVWF       R12, 0
	MOVLW       137
	MOVWF       R13, 0
L_melodia50:
	DECFSZ      R13, 1, 1
	BRA         L_melodia50
	DECFSZ      R12, 1, 1
	BRA         L_melodia50
	DECFSZ      R11, 1, 1
	BRA         L_melodia50
	NOP
	NOP
;buzzer.h,139 :: 		Sound_Play(F3,E+S);
	MOVLW       174
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       44
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,140 :: 		delay_ms(1+E+S);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       14
	MOVWF       R12, 0
	MOVLW       205
	MOVWF       R13, 0
L_melodia51:
	DECFSZ      R13, 1, 1
	BRA         L_melodia51
	DECFSZ      R12, 1, 1
	BRA         L_melodia51
	DECFSZ      R11, 1, 1
	BRA         L_melodia51
;buzzer.h,141 :: 		Sound_Play(C4,S);
	MOVLW       5
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,142 :: 		delay_ms(1+S);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       83
	MOVWF       R13, 0
L_melodia52:
	DECFSZ      R13, 1, 1
	BRA         L_melodia52
	DECFSZ      R12, 1, 1
	BRA         L_melodia52
	DECFSZ      R11, 1, 1
	BRA         L_melodia52
;buzzer.h,143 :: 		Sound_Play(A3,H);
	MOVLW       220
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       32
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       3
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,144 :: 		delay_ms(1+H);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       33
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_melodia53:
	DECFSZ      R13, 1, 1
	BRA         L_melodia53
	DECFSZ      R12, 1, 1
	BRA         L_melodia53
	DECFSZ      R11, 1, 1
	BRA         L_melodia53
;buzzer.h,146 :: 		Sound_Play(E4,Q);
	MOVLW       73
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       144
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,147 :: 		delay_ms(1+Q);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       18
	MOVWF       R12, 0
	MOVLW       137
	MOVWF       R13, 0
L_melodia54:
	DECFSZ      R13, 1, 1
	BRA         L_melodia54
	DECFSZ      R12, 1, 1
	BRA         L_melodia54
	DECFSZ      R11, 1, 1
	BRA         L_melodia54
	NOP
	NOP
;buzzer.h,148 :: 		Sound_Play(E4,Q);
	MOVLW       73
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       144
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,149 :: 		delay_ms(1+Q);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       18
	MOVWF       R12, 0
	MOVLW       137
	MOVWF       R13, 0
L_melodia55:
	DECFSZ      R13, 1, 1
	BRA         L_melodia55
	DECFSZ      R12, 1, 1
	BRA         L_melodia55
	DECFSZ      R11, 1, 1
	BRA         L_melodia55
	NOP
	NOP
;buzzer.h,150 :: 		Sound_Play(E4,Q);
	MOVLW       73
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       144
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,151 :: 		delay_ms(1+Q);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       18
	MOVWF       R12, 0
	MOVLW       137
	MOVWF       R13, 0
L_melodia56:
	DECFSZ      R13, 1, 1
	BRA         L_melodia56
	DECFSZ      R12, 1, 1
	BRA         L_melodia56
	DECFSZ      R11, 1, 1
	BRA         L_melodia56
	NOP
	NOP
;buzzer.h,152 :: 		Sound_Play(F4,E+S);
	MOVLW       93
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       44
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,153 :: 		delay_ms(1+E+S);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       14
	MOVWF       R12, 0
	MOVLW       205
	MOVWF       R13, 0
L_melodia57:
	DECFSZ      R13, 1, 1
	BRA         L_melodia57
	DECFSZ      R12, 1, 1
	BRA         L_melodia57
	DECFSZ      R11, 1, 1
	BRA         L_melodia57
;buzzer.h,154 :: 		Sound_Play(C4,S);
	MOVLW       5
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,155 :: 		delay_ms(1+S);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       83
	MOVWF       R13, 0
L_melodia58:
	DECFSZ      R13, 1, 1
	BRA         L_melodia58
	DECFSZ      R12, 1, 1
	BRA         L_melodia58
	DECFSZ      R11, 1, 1
	BRA         L_melodia58
;buzzer.h,157 :: 		Sound_Play(Ab3,Q);
	MOVLW       207
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       144
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,158 :: 		delay_ms(1+Q);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       18
	MOVWF       R12, 0
	MOVLW       137
	MOVWF       R13, 0
L_melodia59:
	DECFSZ      R13, 1, 1
	BRA         L_melodia59
	DECFSZ      R12, 1, 1
	BRA         L_melodia59
	DECFSZ      R11, 1, 1
	BRA         L_melodia59
	NOP
	NOP
;buzzer.h,159 :: 		Sound_Play(F3,E+S);
	MOVLW       174
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       44
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,160 :: 		delay_ms(1+E+S);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       14
	MOVWF       R12, 0
	MOVLW       205
	MOVWF       R13, 0
L_melodia60:
	DECFSZ      R13, 1, 1
	BRA         L_melodia60
	DECFSZ      R12, 1, 1
	BRA         L_melodia60
	DECFSZ      R11, 1, 1
	BRA         L_melodia60
;buzzer.h,161 :: 		Sound_Play(C4,S);
	MOVLW       5
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,162 :: 		delay_ms(1+S);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       83
	MOVWF       R13, 0
L_melodia61:
	DECFSZ      R13, 1, 1
	BRA         L_melodia61
	DECFSZ      R12, 1, 1
	BRA         L_melodia61
	DECFSZ      R11, 1, 1
	BRA         L_melodia61
;buzzer.h,163 :: 		Sound_Play(A3,H);
	MOVLW       220
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       32
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       3
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,164 :: 		delay_ms(1+H);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       33
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_melodia62:
	DECFSZ      R13, 1, 1
	BRA         L_melodia62
	DECFSZ      R12, 1, 1
	BRA         L_melodia62
	DECFSZ      R11, 1, 1
	BRA         L_melodia62
;buzzer.h,166 :: 		Sound_Play(A4,Q);
	MOVLW       184
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       144
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,167 :: 		delay_ms(1+Q);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       18
	MOVWF       R12, 0
	MOVLW       137
	MOVWF       R13, 0
L_melodia63:
	DECFSZ      R13, 1, 1
	BRA         L_melodia63
	DECFSZ      R12, 1, 1
	BRA         L_melodia63
	DECFSZ      R11, 1, 1
	BRA         L_melodia63
	NOP
	NOP
;buzzer.h,168 :: 		Sound_Play(A3,E+S);
	MOVLW       220
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       44
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,169 :: 		delay_ms(1+E+S);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       14
	MOVWF       R12, 0
	MOVLW       205
	MOVWF       R13, 0
L_melodia64:
	DECFSZ      R13, 1, 1
	BRA         L_melodia64
	DECFSZ      R12, 1, 1
	BRA         L_melodia64
	DECFSZ      R11, 1, 1
	BRA         L_melodia64
;buzzer.h,170 :: 		Sound_Play(A3,S);
	MOVLW       220
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,171 :: 		delay_ms(1+S);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       83
	MOVWF       R13, 0
L_melodia65:
	DECFSZ      R13, 1, 1
	BRA         L_melodia65
	DECFSZ      R12, 1, 1
	BRA         L_melodia65
	DECFSZ      R11, 1, 1
	BRA         L_melodia65
;buzzer.h,172 :: 		Sound_Play(A4,Q);
	MOVLW       184
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       144
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,173 :: 		delay_ms(1+Q);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       18
	MOVWF       R12, 0
	MOVLW       137
	MOVWF       R13, 0
L_melodia66:
	DECFSZ      R13, 1, 1
	BRA         L_melodia66
	DECFSZ      R12, 1, 1
	BRA         L_melodia66
	DECFSZ      R11, 1, 1
	BRA         L_melodia66
	NOP
	NOP
;buzzer.h,174 :: 		Sound_Play(Ab4,E+S);
	MOVLW       159
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       44
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,175 :: 		delay_ms(1+E+S);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       14
	MOVWF       R12, 0
	MOVLW       205
	MOVWF       R13, 0
L_melodia67:
	DECFSZ      R13, 1, 1
	BRA         L_melodia67
	DECFSZ      R12, 1, 1
	BRA         L_melodia67
	DECFSZ      R11, 1, 1
	BRA         L_melodia67
;buzzer.h,176 :: 		Sound_Play(G4,S);
	MOVLW       136
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,177 :: 		delay_ms(1+S);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       83
	MOVWF       R13, 0
L_melodia68:
	DECFSZ      R13, 1, 1
	BRA         L_melodia68
	DECFSZ      R12, 1, 1
	BRA         L_melodia68
	DECFSZ      R11, 1, 1
	BRA         L_melodia68
;buzzer.h,179 :: 		Sound_Play(Gb4,S);
	MOVLW       113
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,180 :: 		delay_ms(1+S);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       83
	MOVWF       R13, 0
L_melodia69:
	DECFSZ      R13, 1, 1
	BRA         L_melodia69
	DECFSZ      R12, 1, 1
	BRA         L_melodia69
	DECFSZ      R11, 1, 1
	BRA         L_melodia69
;buzzer.h,181 :: 		Sound_Play(E4,S);
	MOVLW       73
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,182 :: 		delay_ms(1+S);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       83
	MOVWF       R13, 0
L_melodia70:
	DECFSZ      R13, 1, 1
	BRA         L_melodia70
	DECFSZ      R12, 1, 1
	BRA         L_melodia70
	DECFSZ      R11, 1, 1
	BRA         L_melodia70
;buzzer.h,183 :: 		Sound_Play(F4,E);
	MOVLW       93
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       200
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,184 :: 		delay_ms(1+E);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       11
	MOVWF       R12, 0
	MOVLW       15
	MOVWF       R13, 0
L_melodia71:
	DECFSZ      R13, 1, 1
	BRA         L_melodia71
	DECFSZ      R12, 1, 1
	BRA         L_melodia71
	DECFSZ      R11, 1, 1
	BRA         L_melodia71
	NOP
	NOP
;buzzer.h,185 :: 		delay_ms(1+E);//PAUSE
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       11
	MOVWF       R12, 0
	MOVLW       15
	MOVWF       R13, 0
L_melodia72:
	DECFSZ      R13, 1, 1
	BRA         L_melodia72
	DECFSZ      R12, 1, 1
	BRA         L_melodia72
	DECFSZ      R11, 1, 1
	BRA         L_melodia72
	NOP
	NOP
;buzzer.h,186 :: 		Sound_Play(Bb3,E);
	MOVLW       233
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       200
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,187 :: 		delay_ms(1+E);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       11
	MOVWF       R12, 0
	MOVLW       15
	MOVWF       R13, 0
L_melodia73:
	DECFSZ      R13, 1, 1
	BRA         L_melodia73
	DECFSZ      R12, 1, 1
	BRA         L_melodia73
	DECFSZ      R11, 1, 1
	BRA         L_melodia73
	NOP
	NOP
;buzzer.h,188 :: 		Sound_Play(Eb4,Q);
	MOVLW       55
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       144
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,189 :: 		delay_ms(1+Q);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       18
	MOVWF       R12, 0
	MOVLW       137
	MOVWF       R13, 0
L_melodia74:
	DECFSZ      R13, 1, 1
	BRA         L_melodia74
	DECFSZ      R12, 1, 1
	BRA         L_melodia74
	DECFSZ      R11, 1, 1
	BRA         L_melodia74
	NOP
	NOP
;buzzer.h,190 :: 		Sound_Play(D4,E+S);
	MOVLW       37
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       44
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,191 :: 		delay_ms(1+E+S);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       14
	MOVWF       R12, 0
	MOVLW       205
	MOVWF       R13, 0
L_melodia75:
	DECFSZ      R13, 1, 1
	BRA         L_melodia75
	DECFSZ      R12, 1, 1
	BRA         L_melodia75
	DECFSZ      R11, 1, 1
	BRA         L_melodia75
;buzzer.h,192 :: 		Sound_Play(Db4,S);
	MOVLW       21
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,193 :: 		delay_ms(1+S);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       83
	MOVWF       R13, 0
L_melodia76:
	DECFSZ      R13, 1, 1
	BRA         L_melodia76
	DECFSZ      R12, 1, 1
	BRA         L_melodia76
	DECFSZ      R11, 1, 1
	BRA         L_melodia76
;buzzer.h,195 :: 		Sound_Play(C4,S);
	MOVLW       5
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,196 :: 		delay_ms(1+S);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       83
	MOVWF       R13, 0
L_melodia77:
	DECFSZ      R13, 1, 1
	BRA         L_melodia77
	DECFSZ      R12, 1, 1
	BRA         L_melodia77
	DECFSZ      R11, 1, 1
	BRA         L_melodia77
;buzzer.h,197 :: 		Sound_Play(B3,S);
	MOVLW       246
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,198 :: 		delay_ms(1+S);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       83
	MOVWF       R13, 0
L_melodia78:
	DECFSZ      R13, 1, 1
	BRA         L_melodia78
	DECFSZ      R12, 1, 1
	BRA         L_melodia78
	DECFSZ      R11, 1, 1
	BRA         L_melodia78
;buzzer.h,199 :: 		Sound_Play(C4,E);
	MOVLW       5
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       200
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,200 :: 		delay_ms(1+E);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       11
	MOVWF       R12, 0
	MOVLW       15
	MOVWF       R13, 0
L_melodia79:
	DECFSZ      R13, 1, 1
	BRA         L_melodia79
	DECFSZ      R12, 1, 1
	BRA         L_melodia79
	DECFSZ      R11, 1, 1
	BRA         L_melodia79
	NOP
	NOP
;buzzer.h,201 :: 		delay_ms(1+E);//PAUSE
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       11
	MOVWF       R12, 0
	MOVLW       15
	MOVWF       R13, 0
L_melodia80:
	DECFSZ      R13, 1, 1
	BRA         L_melodia80
	DECFSZ      R12, 1, 1
	BRA         L_melodia80
	DECFSZ      R11, 1, 1
	BRA         L_melodia80
	NOP
	NOP
;buzzer.h,202 :: 		Sound_Play(F3,E);
	MOVLW       174
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       200
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,203 :: 		delay_ms(1+E);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       11
	MOVWF       R12, 0
	MOVLW       15
	MOVWF       R13, 0
L_melodia81:
	DECFSZ      R13, 1, 1
	BRA         L_melodia81
	DECFSZ      R12, 1, 1
	BRA         L_melodia81
	DECFSZ      R11, 1, 1
	BRA         L_melodia81
	NOP
	NOP
;buzzer.h,204 :: 		Sound_Play(Ab3,Q);
	MOVLW       207
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       144
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,205 :: 		delay_ms(1+Q);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       18
	MOVWF       R12, 0
	MOVLW       137
	MOVWF       R13, 0
L_melodia82:
	DECFSZ      R13, 1, 1
	BRA         L_melodia82
	DECFSZ      R12, 1, 1
	BRA         L_melodia82
	DECFSZ      R11, 1, 1
	BRA         L_melodia82
	NOP
	NOP
;buzzer.h,206 :: 		Sound_Play(F3,E+S);
	MOVLW       174
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       44
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,207 :: 		delay_ms(1+E+S);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       14
	MOVWF       R12, 0
	MOVLW       205
	MOVWF       R13, 0
L_melodia83:
	DECFSZ      R13, 1, 1
	BRA         L_melodia83
	DECFSZ      R12, 1, 1
	BRA         L_melodia83
	DECFSZ      R11, 1, 1
	BRA         L_melodia83
;buzzer.h,208 :: 		Sound_Play(A3,S);
	MOVLW       220
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,209 :: 		delay_ms(1+S);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       83
	MOVWF       R13, 0
L_melodia84:
	DECFSZ      R13, 1, 1
	BRA         L_melodia84
	DECFSZ      R12, 1, 1
	BRA         L_melodia84
	DECFSZ      R11, 1, 1
	BRA         L_melodia84
;buzzer.h,211 :: 		Sound_Play(C4,Q);
	MOVLW       5
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       144
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,212 :: 		delay_ms(1+Q);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       18
	MOVWF       R12, 0
	MOVLW       137
	MOVWF       R13, 0
L_melodia85:
	DECFSZ      R13, 1, 1
	BRA         L_melodia85
	DECFSZ      R12, 1, 1
	BRA         L_melodia85
	DECFSZ      R11, 1, 1
	BRA         L_melodia85
	NOP
	NOP
;buzzer.h,213 :: 		Sound_Play(A3,E+S);
	MOVLW       220
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       44
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,214 :: 		delay_ms(1+E+S);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       14
	MOVWF       R12, 0
	MOVLW       205
	MOVWF       R13, 0
L_melodia86:
	DECFSZ      R13, 1, 1
	BRA         L_melodia86
	DECFSZ      R12, 1, 1
	BRA         L_melodia86
	DECFSZ      R11, 1, 1
	BRA         L_melodia86
;buzzer.h,215 :: 		Sound_Play(C4,S);
	MOVLW       5
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,216 :: 		delay_ms(1+S);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       83
	MOVWF       R13, 0
L_melodia87:
	DECFSZ      R13, 1, 1
	BRA         L_melodia87
	DECFSZ      R12, 1, 1
	BRA         L_melodia87
	DECFSZ      R11, 1, 1
	BRA         L_melodia87
;buzzer.h,217 :: 		Sound_Play(E4,H);
	MOVLW       73
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       32
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       3
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,218 :: 		delay_ms(1+H);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       33
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_melodia88:
	DECFSZ      R13, 1, 1
	BRA         L_melodia88
	DECFSZ      R12, 1, 1
	BRA         L_melodia88
	DECFSZ      R11, 1, 1
	BRA         L_melodia88
;buzzer.h,220 :: 		Sound_Play(A4,Q);
	MOVLW       184
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       144
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,221 :: 		delay_ms(1+Q);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       18
	MOVWF       R12, 0
	MOVLW       137
	MOVWF       R13, 0
L_melodia89:
	DECFSZ      R13, 1, 1
	BRA         L_melodia89
	DECFSZ      R12, 1, 1
	BRA         L_melodia89
	DECFSZ      R11, 1, 1
	BRA         L_melodia89
	NOP
	NOP
;buzzer.h,222 :: 		Sound_Play(A3,E+S);
	MOVLW       220
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       44
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,223 :: 		delay_ms(1+E+S);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       14
	MOVWF       R12, 0
	MOVLW       205
	MOVWF       R13, 0
L_melodia90:
	DECFSZ      R13, 1, 1
	BRA         L_melodia90
	DECFSZ      R12, 1, 1
	BRA         L_melodia90
	DECFSZ      R11, 1, 1
	BRA         L_melodia90
;buzzer.h,224 :: 		Sound_Play(A3,S);
	MOVLW       220
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,225 :: 		delay_ms(1+S);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       83
	MOVWF       R13, 0
L_melodia91:
	DECFSZ      R13, 1, 1
	BRA         L_melodia91
	DECFSZ      R12, 1, 1
	BRA         L_melodia91
	DECFSZ      R11, 1, 1
	BRA         L_melodia91
;buzzer.h,226 :: 		Sound_Play(A4,Q);
	MOVLW       184
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       144
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,227 :: 		delay_ms(1+Q);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       18
	MOVWF       R12, 0
	MOVLW       137
	MOVWF       R13, 0
L_melodia92:
	DECFSZ      R13, 1, 1
	BRA         L_melodia92
	DECFSZ      R12, 1, 1
	BRA         L_melodia92
	DECFSZ      R11, 1, 1
	BRA         L_melodia92
	NOP
	NOP
;buzzer.h,228 :: 		Sound_Play(Ab4,E+S);
	MOVLW       159
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       44
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,229 :: 		delay_ms(1+E+S);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       14
	MOVWF       R12, 0
	MOVLW       205
	MOVWF       R13, 0
L_melodia93:
	DECFSZ      R13, 1, 1
	BRA         L_melodia93
	DECFSZ      R12, 1, 1
	BRA         L_melodia93
	DECFSZ      R11, 1, 1
	BRA         L_melodia93
;buzzer.h,230 :: 		Sound_Play(G4,S);
	MOVLW       136
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,231 :: 		delay_ms(1+S);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       83
	MOVWF       R13, 0
L_melodia94:
	DECFSZ      R13, 1, 1
	BRA         L_melodia94
	DECFSZ      R12, 1, 1
	BRA         L_melodia94
	DECFSZ      R11, 1, 1
	BRA         L_melodia94
;buzzer.h,233 :: 		Sound_Play(Gb4,S);
	MOVLW       113
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,234 :: 		delay_ms(1+S);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       83
	MOVWF       R13, 0
L_melodia95:
	DECFSZ      R13, 1, 1
	BRA         L_melodia95
	DECFSZ      R12, 1, 1
	BRA         L_melodia95
	DECFSZ      R11, 1, 1
	BRA         L_melodia95
;buzzer.h,235 :: 		Sound_Play(E4,S);
	MOVLW       73
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,236 :: 		delay_ms(1+S);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       83
	MOVWF       R13, 0
L_melodia96:
	DECFSZ      R13, 1, 1
	BRA         L_melodia96
	DECFSZ      R12, 1, 1
	BRA         L_melodia96
	DECFSZ      R11, 1, 1
	BRA         L_melodia96
;buzzer.h,237 :: 		Sound_Play(F4,E);
	MOVLW       93
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       200
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,238 :: 		delay_ms(1+E);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       11
	MOVWF       R12, 0
	MOVLW       15
	MOVWF       R13, 0
L_melodia97:
	DECFSZ      R13, 1, 1
	BRA         L_melodia97
	DECFSZ      R12, 1, 1
	BRA         L_melodia97
	DECFSZ      R11, 1, 1
	BRA         L_melodia97
	NOP
	NOP
;buzzer.h,239 :: 		delay_ms(1+E);//PAUSE
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       11
	MOVWF       R12, 0
	MOVLW       15
	MOVWF       R13, 0
L_melodia98:
	DECFSZ      R13, 1, 1
	BRA         L_melodia98
	DECFSZ      R12, 1, 1
	BRA         L_melodia98
	DECFSZ      R11, 1, 1
	BRA         L_melodia98
	NOP
	NOP
;buzzer.h,240 :: 		Sound_Play(Bb3,E);
	MOVLW       233
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       200
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,241 :: 		delay_ms(1+E);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       11
	MOVWF       R12, 0
	MOVLW       15
	MOVWF       R13, 0
L_melodia99:
	DECFSZ      R13, 1, 1
	BRA         L_melodia99
	DECFSZ      R12, 1, 1
	BRA         L_melodia99
	DECFSZ      R11, 1, 1
	BRA         L_melodia99
	NOP
	NOP
;buzzer.h,242 :: 		Sound_Play(Eb4,Q);
	MOVLW       55
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       144
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,243 :: 		delay_ms(1+Q);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       18
	MOVWF       R12, 0
	MOVLW       137
	MOVWF       R13, 0
L_melodia100:
	DECFSZ      R13, 1, 1
	BRA         L_melodia100
	DECFSZ      R12, 1, 1
	BRA         L_melodia100
	DECFSZ      R11, 1, 1
	BRA         L_melodia100
	NOP
	NOP
;buzzer.h,244 :: 		Sound_Play(D4,E+S);
	MOVLW       37
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       44
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,245 :: 		delay_ms(1+E+S);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       14
	MOVWF       R12, 0
	MOVLW       205
	MOVWF       R13, 0
L_melodia101:
	DECFSZ      R13, 1, 1
	BRA         L_melodia101
	DECFSZ      R12, 1, 1
	BRA         L_melodia101
	DECFSZ      R11, 1, 1
	BRA         L_melodia101
;buzzer.h,246 :: 		Sound_Play(Db4,S);
	MOVLW       21
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,247 :: 		delay_ms(1+S);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       83
	MOVWF       R13, 0
L_melodia102:
	DECFSZ      R13, 1, 1
	BRA         L_melodia102
	DECFSZ      R12, 1, 1
	BRA         L_melodia102
	DECFSZ      R11, 1, 1
	BRA         L_melodia102
;buzzer.h,249 :: 		Sound_Play(C4,S);
	MOVLW       5
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,250 :: 		delay_ms(1+S);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       83
	MOVWF       R13, 0
L_melodia103:
	DECFSZ      R13, 1, 1
	BRA         L_melodia103
	DECFSZ      R12, 1, 1
	BRA         L_melodia103
	DECFSZ      R11, 1, 1
	BRA         L_melodia103
;buzzer.h,251 :: 		Sound_Play(B3,S);
	MOVLW       246
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,252 :: 		delay_ms(1+S);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       83
	MOVWF       R13, 0
L_melodia104:
	DECFSZ      R13, 1, 1
	BRA         L_melodia104
	DECFSZ      R12, 1, 1
	BRA         L_melodia104
	DECFSZ      R11, 1, 1
	BRA         L_melodia104
;buzzer.h,253 :: 		Sound_Play(C4,E);
	MOVLW       5
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       200
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,254 :: 		delay_ms(1+E);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       11
	MOVWF       R12, 0
	MOVLW       15
	MOVWF       R13, 0
L_melodia105:
	DECFSZ      R13, 1, 1
	BRA         L_melodia105
	DECFSZ      R12, 1, 1
	BRA         L_melodia105
	DECFSZ      R11, 1, 1
	BRA         L_melodia105
	NOP
	NOP
;buzzer.h,255 :: 		delay_ms(1+E);//PAUSE QUASI FINE RIGA
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       11
	MOVWF       R12, 0
	MOVLW       15
	MOVWF       R13, 0
L_melodia106:
	DECFSZ      R13, 1, 1
	BRA         L_melodia106
	DECFSZ      R12, 1, 1
	BRA         L_melodia106
	DECFSZ      R11, 1, 1
	BRA         L_melodia106
	NOP
	NOP
;buzzer.h,256 :: 		Sound_Play(F3,E);
	MOVLW       174
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       200
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,257 :: 		delay_ms(1+E);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       11
	MOVWF       R12, 0
	MOVLW       15
	MOVWF       R13, 0
L_melodia107:
	DECFSZ      R13, 1, 1
	BRA         L_melodia107
	DECFSZ      R12, 1, 1
	BRA         L_melodia107
	DECFSZ      R11, 1, 1
	BRA         L_melodia107
	NOP
	NOP
;buzzer.h,258 :: 		Sound_Play(Ab3,Q);
	MOVLW       207
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       144
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,259 :: 		delay_ms(1+Q);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       18
	MOVWF       R12, 0
	MOVLW       137
	MOVWF       R13, 0
L_melodia108:
	DECFSZ      R13, 1, 1
	BRA         L_melodia108
	DECFSZ      R12, 1, 1
	BRA         L_melodia108
	DECFSZ      R11, 1, 1
	BRA         L_melodia108
	NOP
	NOP
;buzzer.h,260 :: 		Sound_Play(F3,E+S);
	MOVLW       174
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       44
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,261 :: 		delay_ms(1+E+S);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       14
	MOVWF       R12, 0
	MOVLW       205
	MOVWF       R13, 0
L_melodia109:
	DECFSZ      R13, 1, 1
	BRA         L_melodia109
	DECFSZ      R12, 1, 1
	BRA         L_melodia109
	DECFSZ      R11, 1, 1
	BRA         L_melodia109
;buzzer.h,262 :: 		Sound_Play(C4,S);
	MOVLW       5
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,263 :: 		delay_ms(1+S);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       83
	MOVWF       R13, 0
L_melodia110:
	DECFSZ      R13, 1, 1
	BRA         L_melodia110
	DECFSZ      R12, 1, 1
	BRA         L_melodia110
	DECFSZ      R11, 1, 1
	BRA         L_melodia110
;buzzer.h,265 :: 		Sound_Play(A3,Q);
	MOVLW       220
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       144
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,266 :: 		delay_ms(1+Q);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       18
	MOVWF       R12, 0
	MOVLW       137
	MOVWF       R13, 0
L_melodia111:
	DECFSZ      R13, 1, 1
	BRA         L_melodia111
	DECFSZ      R12, 1, 1
	BRA         L_melodia111
	DECFSZ      R11, 1, 1
	BRA         L_melodia111
	NOP
	NOP
;buzzer.h,267 :: 		Sound_Play(F3,E+S);
	MOVLW       174
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       44
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,268 :: 		delay_ms(1+E+S);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       14
	MOVWF       R12, 0
	MOVLW       205
	MOVWF       R13, 0
L_melodia112:
	DECFSZ      R13, 1, 1
	BRA         L_melodia112
	DECFSZ      R12, 1, 1
	BRA         L_melodia112
	DECFSZ      R11, 1, 1
	BRA         L_melodia112
;buzzer.h,269 :: 		Sound_Play(C4,S);
	MOVLW       5
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,270 :: 		delay_ms(1+S);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       83
	MOVWF       R13, 0
L_melodia113:
	DECFSZ      R13, 1, 1
	BRA         L_melodia113
	DECFSZ      R12, 1, 1
	BRA         L_melodia113
	DECFSZ      R11, 1, 1
	BRA         L_melodia113
;buzzer.h,271 :: 		Sound_Play(A3,H);
	MOVLW       220
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       32
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       3
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;buzzer.h,272 :: 		delay_ms(1+H);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       33
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_melodia114:
	DECFSZ      R13, 1, 1
	BRA         L_melodia114
	DECFSZ      R12, 1, 1
	BRA         L_melodia114
	DECFSZ      R11, 1, 1
	BRA         L_melodia114
;buzzer.h,274 :: 		delay_ms(2*H);
	MOVLW       17
	MOVWF       R11, 0
	MOVLW       60
	MOVWF       R12, 0
	MOVLW       203
	MOVWF       R13, 0
L_melodia115:
	DECFSZ      R13, 1, 1
	BRA         L_melodia115
	DECFSZ      R12, 1, 1
	BRA         L_melodia115
	DECFSZ      R11, 1, 1
	BRA         L_melodia115
;buzzer.h,275 :: 		}//end melodia
L_end_melodia:
	RETURN      0
; end of _melodia

_Botao_PWM:

;pwm_botao.h,2 :: 		void Botao_PWM(unsigned char *info) {               //-- Função Principal
;pwm_botao.h,3 :: 		ADCON1   = 0x0F;            // Configura todos os pinos AN's como DIGITAIS I/O's
	MOVLW       15
	MOVWF       ADCON1+0 
;pwm_botao.h,4 :: 		TRISC.RC2 = 0x00;           // Configura o Pino RC2 como Saída (LED PWM)
	BCF         TRISC+0, 2 
;pwm_botao.h,5 :: 		TRISB.RB0 = 0x01;           // Configura o Pino RB0 como Entrada (BOTÃO+)
	BSF         TRISB+0, 0 
;pwm_botao.h,6 :: 		TRISB.RB1 = 0x01;           // Configura o Pino RB1 como Entrada (BOTÃO-)
	BSF         TRISB+0, 1 
;pwm_botao.h,7 :: 		PWM1_Init(1000);            // Inicializa o PWM a 1KHz
	BSF         T2CON+0, 0, 0
	BSF         T2CON+0, 1, 0
	MOVLW       124
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;pwm_botao.h,9 :: 		CCP1M2_bit = 1;
	BSF         CCP1M2_bit+0, 2 
;pwm_botao.h,10 :: 		CCP1M3_bit = 1;
	BSF         CCP1M3_bit+0, 3 
;pwm_botao.h,11 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;pwm_botao.h,12 :: 		CCPR1L = 0x00;              // Inicia com o Duty Cicle em zero
	CLRF        CCPR1L+0 
;pwm_botao.h,14 :: 		while(*info==7){
L_Botao_PWM116:
	MOVFF       FARG_Botao_PWM_info+0, FSR0
	MOVFF       FARG_Botao_PWM_info+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Botao_PWM117
;pwm_botao.h,15 :: 		if(!RB0_bit)
	BTFSC       RB0_bit+0, 0 
	GOTO        L_Botao_PWM118
;pwm_botao.h,17 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_Botao_PWM119:
	DECFSZ      R13, 1, 1
	BRA         L_Botao_PWM119
	DECFSZ      R12, 1, 1
	BRA         L_Botao_PWM119
	DECFSZ      R11, 1, 1
	BRA         L_Botao_PWM119
;pwm_botao.h,18 :: 		CCPR1L++;      // Incrementa o Duty Cicle
	MOVF        CCPR1L+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       CCPR1L+0 
;pwm_botao.h,19 :: 		}
L_Botao_PWM118:
;pwm_botao.h,21 :: 		if(!RB1_bit)
	BTFSC       RB1_bit+0, 1 
	GOTO        L_Botao_PWM120
;pwm_botao.h,23 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_Botao_PWM121:
	DECFSZ      R13, 1, 1
	BRA         L_Botao_PWM121
	DECFSZ      R12, 1, 1
	BRA         L_Botao_PWM121
	DECFSZ      R11, 1, 1
	BRA         L_Botao_PWM121
;pwm_botao.h,24 :: 		CCPR1L--;      // Incrementa o Duty Cicle
	DECF        CCPR1L+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       CCPR1L+0 
;pwm_botao.h,25 :: 		}//end if
L_Botao_PWM120:
;pwm_botao.h,26 :: 		}// end while
	GOTO        L_Botao_PWM116
L_Botao_PWM117:
;pwm_botao.h,27 :: 		}//end void main
L_end_Botao_PWM:
	RETURN      0
; end of _Botao_PWM

_write_LCD:

;display_lcd.h,1 :: 		void write_LCD(unsigned char *txt1, unsigned char *txt2) {            // Função que escreve no LCD
;display_lcd.h,4 :: 		Lcd_Out(1,3,txt1);            //Escreve na linha 1, coluna 3 o conteúdo de txt1
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_write_LCD_txt1+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        FARG_write_LCD_txt1+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display_lcd.h,5 :: 		Lcd_Out(2,7,txt2);            //Escreve na linha 2, coluna 7: txt2
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_write_LCD_txt2+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        FARG_write_LCD_txt2+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;display_lcd.h,6 :: 		delay_ms(1000);               //Aguarda 2s
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_write_LCD122:
	DECFSZ      R13, 1, 1
	BRA         L_write_LCD122
	DECFSZ      R12, 1, 1
	BRA         L_write_LCD122
	DECFSZ      R11, 1, 1
	BRA         L_write_LCD122
	NOP
	NOP
;display_lcd.h,8 :: 		for(i=0; i<3; i++) {                // Repete o laço 3 vezes
	CLRF        write_LCD_i_L0+0 
L_write_LCD123:
	MOVLW       3
	SUBWF       write_LCD_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_write_LCD124
;display_lcd.h,9 :: 		Lcd_Cmd(_LCD_SHIFT_RIGHT);    // Move o conteúdo da tela para a esquerda
	MOVLW       28
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;display_lcd.h,10 :: 		delay_ms(500);                // aguarda 0,5s
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_write_LCD126:
	DECFSZ      R13, 1, 1
	BRA         L_write_LCD126
	DECFSZ      R12, 1, 1
	BRA         L_write_LCD126
	DECFSZ      R11, 1, 1
	BRA         L_write_LCD126
	NOP
	NOP
;display_lcd.h,8 :: 		for(i=0; i<3; i++) {                // Repete o laço 3 vezes
	INCF        write_LCD_i_L0+0, 1 
;display_lcd.h,11 :: 		}                             // end for
	GOTO        L_write_LCD123
L_write_LCD124:
;display_lcd.h,12 :: 		}                             // end void write LCD
L_end_write_LCD:
	RETURN      0
; end of _write_LCD

_LCD_Hello:

;display_lcd.h,14 :: 		void LCD_Hello(unsigned char *info){
;display_lcd.h,17 :: 		ADCON1 = 0x0F;        //Configura todos as saídas analogicas como Digitais I/O's
	MOVLW       15
	MOVWF       ADCON1+0 
;display_lcd.h,18 :: 		Lcd_Init();                         // Inicializa LCD
	CALL        _Lcd_Init+0, 0
;display_lcd.h,19 :: 		Lcd_Cmd(_LCD_CLEAR);                // Limpa display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;display_lcd.h,20 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);           // Desliga o Cursor
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;display_lcd.h,21 :: 		write_LCD("Ola Mundo","^__^" );                        // Chama a Função de escrita no LCD
	MOVLW       ?lstr4_Bluetooth_PIC18F4550+0
	MOVWF       FARG_write_LCD_txt1+0 
	MOVLW       hi_addr(?lstr4_Bluetooth_PIC18F4550+0)
	MOVWF       FARG_write_LCD_txt1+1 
	MOVLW       ?lstr5_Bluetooth_PIC18F4550+0
	MOVWF       FARG_write_LCD_txt2+0 
	MOVLW       hi_addr(?lstr5_Bluetooth_PIC18F4550+0)
	MOVWF       FARG_write_LCD_txt2+1 
	CALL        _write_LCD+0, 0
;display_lcd.h,23 :: 		while(*info == 9) {                        // Loop infinito
L_LCD_Hello127:
	MOVFF       FARG_LCD_Hello_info+0, FSR0
	MOVFF       FARG_LCD_Hello_info+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_Hello128
;display_lcd.h,24 :: 		for(i=0; i<6; i++) {            // Move o texto pra esquerda 6x
	CLRF        LCD_Hello_i_L0+0 
L_LCD_Hello129:
	MOVLW       6
	SUBWF       LCD_Hello_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_Hello130
;display_lcd.h,25 :: 		Lcd_Cmd(_LCD_SHIFT_LEFT);     // comando para mover p/ esquerda
	MOVLW       24
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;display_lcd.h,26 :: 		delay_ms(500);                // aguarda 0,5s
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_LCD_Hello132:
	DECFSZ      R13, 1, 1
	BRA         L_LCD_Hello132
	DECFSZ      R12, 1, 1
	BRA         L_LCD_Hello132
	DECFSZ      R11, 1, 1
	BRA         L_LCD_Hello132
	NOP
	NOP
;display_lcd.h,24 :: 		for(i=0; i<6; i++) {            // Move o texto pra esquerda 6x
	INCF        LCD_Hello_i_L0+0, 1 
;display_lcd.h,27 :: 		}                             // end for
	GOTO        L_LCD_Hello129
L_LCD_Hello130:
;display_lcd.h,29 :: 		for(i=0; i<6; i++) {            // Move o texto pra direita 6x
	CLRF        LCD_Hello_i_L0+0 
L_LCD_Hello133:
	MOVLW       6
	SUBWF       LCD_Hello_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_Hello134
;display_lcd.h,30 :: 		Lcd_Cmd(_LCD_SHIFT_RIGHT);    // comando para mover p/ direita
	MOVLW       28
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;display_lcd.h,31 :: 		delay_ms(500);                // delay (500ms)
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_LCD_Hello136:
	DECFSZ      R13, 1, 1
	BRA         L_LCD_Hello136
	DECFSZ      R12, 1, 1
	BRA         L_LCD_Hello136
	DECFSZ      R11, 1, 1
	BRA         L_LCD_Hello136
	NOP
	NOP
;display_lcd.h,29 :: 		for(i=0; i<6; i++) {            // Move o texto pra direita 6x
	INCF        LCD_Hello_i_L0+0, 1 
;display_lcd.h,32 :: 		}                             // end for
	GOTO        L_LCD_Hello133
L_LCD_Hello134:
;display_lcd.h,33 :: 		}                             // end while
	GOTO        L_LCD_Hello127
L_LCD_Hello128:
;display_lcd.h,34 :: 		}
L_end_LCD_Hello:
	RETURN      0
; end of _LCD_Hello

_LCD_Bye:

;display_lcd.h,39 :: 		void LCD_Bye(unsigned char *info){
;display_lcd.h,43 :: 		ADCON1 = 0x0F;        //Configura todos as saídas analogicas como Digitais I/O's
	MOVLW       15
	MOVWF       ADCON1+0 
;display_lcd.h,44 :: 		Lcd_Init();                         // Inicializa LCD
	CALL        _Lcd_Init+0, 0
;display_lcd.h,45 :: 		Lcd_Cmd(_LCD_CLEAR);                // Limpa display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;display_lcd.h,46 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);           // Desliga o Cursor
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;display_lcd.h,47 :: 		write_LCD("Tchau Mundo","-__-" );                        // Chama a Função de escrita no LCD
	MOVLW       ?lstr6_Bluetooth_PIC18F4550+0
	MOVWF       FARG_write_LCD_txt1+0 
	MOVLW       hi_addr(?lstr6_Bluetooth_PIC18F4550+0)
	MOVWF       FARG_write_LCD_txt1+1 
	MOVLW       ?lstr7_Bluetooth_PIC18F4550+0
	MOVWF       FARG_write_LCD_txt2+0 
	MOVLW       hi_addr(?lstr7_Bluetooth_PIC18F4550+0)
	MOVWF       FARG_write_LCD_txt2+1 
	CALL        _write_LCD+0, 0
;display_lcd.h,49 :: 		while(*info == 10){                        // Loop infinito
L_LCD_Bye137:
	MOVFF       FARG_LCD_Bye_info+0, FSR0
	MOVFF       FARG_LCD_Bye_info+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_Bye138
;display_lcd.h,50 :: 		for(i=0; i<6; i++) {            // Move o texto pra esquerda 6x
	CLRF        LCD_Bye_i_L0+0 
L_LCD_Bye139:
	MOVLW       6
	SUBWF       LCD_Bye_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_Bye140
;display_lcd.h,51 :: 		Lcd_Cmd(_LCD_SHIFT_LEFT);     // comando para mover p/ esquerda
	MOVLW       24
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;display_lcd.h,52 :: 		delay_ms(500);                // aguarda 0,5s
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_LCD_Bye142:
	DECFSZ      R13, 1, 1
	BRA         L_LCD_Bye142
	DECFSZ      R12, 1, 1
	BRA         L_LCD_Bye142
	DECFSZ      R11, 1, 1
	BRA         L_LCD_Bye142
	NOP
	NOP
;display_lcd.h,50 :: 		for(i=0; i<6; i++) {            // Move o texto pra esquerda 6x
	INCF        LCD_Bye_i_L0+0, 1 
;display_lcd.h,53 :: 		}                             // end for
	GOTO        L_LCD_Bye139
L_LCD_Bye140:
;display_lcd.h,55 :: 		for(i=0; i<6; i++){            // Move o texto pra direita 6x
	CLRF        LCD_Bye_i_L0+0 
L_LCD_Bye143:
	MOVLW       6
	SUBWF       LCD_Bye_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_Bye144
;display_lcd.h,56 :: 		Lcd_Cmd(_LCD_SHIFT_RIGHT);    // comando para mover p/ direita
	MOVLW       28
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;display_lcd.h,57 :: 		delay_ms(500);                // delay (500ms)
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_LCD_Bye146:
	DECFSZ      R13, 1, 1
	BRA         L_LCD_Bye146
	DECFSZ      R12, 1, 1
	BRA         L_LCD_Bye146
	DECFSZ      R11, 1, 1
	BRA         L_LCD_Bye146
	NOP
	NOP
;display_lcd.h,55 :: 		for(i=0; i<6; i++){            // Move o texto pra direita 6x
	INCF        LCD_Bye_i_L0+0, 1 
;display_lcd.h,58 :: 		}                             // end for
	GOTO        L_LCD_Bye143
L_LCD_Bye144:
;display_lcd.h,59 :: 		}                             // end while
	GOTO        L_LCD_Bye137
L_LCD_Bye138:
;display_lcd.h,60 :: 		}
L_end_LCD_Bye:
	RETURN      0
; end of _LCD_Bye

_interrupt:

;Bluetooth_PIC18F4550.c,30 :: 		void interrupt(){   // Função de Interrupção
;Bluetooth_PIC18F4550.c,31 :: 		if(RCIF_bit){       // Se houver dados na serial...
	BTFSS       RCIF_bit+0, 5 
	GOTO        L_interrupt147
;Bluetooth_PIC18F4550.c,32 :: 		byte = RCREG;       // atribui o dado à 'byte'
	MOVF        RCREG+0, 0 
	MOVWF       _byte+0 
;Bluetooth_PIC18F4550.c,33 :: 		RCIF_bit = 0;       // reseta a flag da interrupção
	BCF         RCIF_bit+0, 5 
;Bluetooth_PIC18F4550.c,38 :: 		recebido */
	GOTO        L_interrupt148
;Bluetooth_PIC18F4550.c,39 :: 		case 's':
L_interrupt150:
;Bluetooth_PIC18F4550.c,40 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_interrupt151:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt151
	DECFSZ      R12, 1, 1
	BRA         L_interrupt151
	DECFSZ      R11, 1, 1
	BRA         L_interrupt151
;Bluetooth_PIC18F4550.c,41 :: 		SPEN_bit  = 0x00;                 // habilita a porta serial
	BCF         SPEN_bit+0, 7 
;Bluetooth_PIC18F4550.c,42 :: 		CREN_bit  = 0x00;                 // habilita o receptor no modo assincrono
	BCF         CREN_bit+0, 4 
;Bluetooth_PIC18F4550.c,43 :: 		SPEN_bit  = 0x01;                 // habilita a porta serial
	BSF         SPEN_bit+0, 7 
;Bluetooth_PIC18F4550.c,44 :: 		CREN_bit  = 0x01;                 // habilita o receptor no modo assincrono
	BSF         CREN_bit+0, 4 
;Bluetooth_PIC18F4550.c,45 :: 		break;
	GOTO        L_interrupt149
;Bluetooth_PIC18F4550.c,47 :: 		case ' ':
L_interrupt152:
;Bluetooth_PIC18F4550.c,48 :: 		SPEN_bit  = 0x00;                 // habilita a porta serial
	BCF         SPEN_bit+0, 7 
;Bluetooth_PIC18F4550.c,49 :: 		CREN_bit  = 0x00;                 // habilita o receptor no modo assincrono
	BCF         CREN_bit+0, 4 
;Bluetooth_PIC18F4550.c,50 :: 		SPEN_bit  = 0x01;                 // habilita a porta serial
	BSF         SPEN_bit+0, 7 
;Bluetooth_PIC18F4550.c,51 :: 		CREN_bit  = 0x01;                 // habilita o receptor no modo assincrono
	BSF         CREN_bit+0, 4 
;Bluetooth_PIC18F4550.c,53 :: 		break;
	GOTO        L_interrupt149
;Bluetooth_PIC18F4550.c,54 :: 		case '1':                         //OK  (TEM QUE APERTAR DUAS VEZES PARA FUNCIONAR )
L_interrupt153:
;Bluetooth_PIC18F4550.c,55 :: 		UniFlag = 0x01;
	MOVLW       1
	MOVWF       _UniFlag+0 
;Bluetooth_PIC18F4550.c,56 :: 		cnt1++;
	INCF        _cnt1+0, 1 
;Bluetooth_PIC18F4550.c,57 :: 		break;
	GOTO        L_interrupt149
;Bluetooth_PIC18F4550.c,61 :: 		case '2':                         //OK
L_interrupt154:
;Bluetooth_PIC18F4550.c,62 :: 		UniFlag = 0x02;
	MOVLW       2
	MOVWF       _UniFlag+0 
;Bluetooth_PIC18F4550.c,63 :: 		break;
	GOTO        L_interrupt149
;Bluetooth_PIC18F4550.c,65 :: 		case '3':                         //OK
L_interrupt155:
;Bluetooth_PIC18F4550.c,66 :: 		UniFlag = 0x03;
	MOVLW       3
	MOVWF       _UniFlag+0 
;Bluetooth_PIC18F4550.c,67 :: 		break;
	GOTO        L_interrupt149
;Bluetooth_PIC18F4550.c,69 :: 		case '4':                         //OK
L_interrupt156:
;Bluetooth_PIC18F4550.c,70 :: 		UniFlag = 0x04;
	MOVLW       4
	MOVWF       _UniFlag+0 
;Bluetooth_PIC18F4550.c,71 :: 		break;
	GOTO        L_interrupt149
;Bluetooth_PIC18F4550.c,73 :: 		case '5':                         //OK
L_interrupt157:
;Bluetooth_PIC18F4550.c,74 :: 		UniFlag = 0x05;
	MOVLW       5
	MOVWF       _UniFlag+0 
;Bluetooth_PIC18F4550.c,75 :: 		break;
	GOTO        L_interrupt149
;Bluetooth_PIC18F4550.c,77 :: 		case '6':
L_interrupt158:
;Bluetooth_PIC18F4550.c,78 :: 		UniFlag = 0x06;
	MOVLW       6
	MOVWF       _UniFlag+0 
;Bluetooth_PIC18F4550.c,79 :: 		break;
	GOTO        L_interrupt149
;Bluetooth_PIC18F4550.c,81 :: 		case '7':
L_interrupt159:
;Bluetooth_PIC18F4550.c,82 :: 		UniFlag = 0x07;                   //APENAS INCREMENTA
	MOVLW       7
	MOVWF       _UniFlag+0 
;Bluetooth_PIC18F4550.c,83 :: 		break;
	GOTO        L_interrupt149
;Bluetooth_PIC18F4550.c,85 :: 		case '8':
L_interrupt160:
;Bluetooth_PIC18F4550.c,86 :: 		UniFlag = 0x08;
	MOVLW       8
	MOVWF       _UniFlag+0 
;Bluetooth_PIC18F4550.c,87 :: 		break;
	GOTO        L_interrupt149
;Bluetooth_PIC18F4550.c,89 :: 		case 'O':
L_interrupt161:
;Bluetooth_PIC18F4550.c,90 :: 		UniFlag = 0x09;
	MOVLW       9
	MOVWF       _UniFlag+0 
;Bluetooth_PIC18F4550.c,91 :: 		SPEN_bit  = 0x00;                 // habilita a porta serial
	BCF         SPEN_bit+0, 7 
;Bluetooth_PIC18F4550.c,92 :: 		CREN_bit  = 0x00;                 // habilita o receptor no modo assincrono
	BCF         CREN_bit+0, 4 
;Bluetooth_PIC18F4550.c,93 :: 		SPEN_bit  = 0x01;                 // habilita a porta serial
	BSF         SPEN_bit+0, 7 
;Bluetooth_PIC18F4550.c,94 :: 		CREN_bit  = 0x01;                 // habilita o receptor no modo assincrono
	BSF         CREN_bit+0, 4 
;Bluetooth_PIC18F4550.c,95 :: 		break;
	GOTO        L_interrupt149
;Bluetooth_PIC18F4550.c,97 :: 		case 'T':
L_interrupt162:
;Bluetooth_PIC18F4550.c,98 :: 		UniFlag = 0x0A;
	MOVLW       10
	MOVWF       _UniFlag+0 
;Bluetooth_PIC18F4550.c,99 :: 		SPEN_bit  = 0x00;                 // habilita a porta serial
	BCF         SPEN_bit+0, 7 
;Bluetooth_PIC18F4550.c,100 :: 		CREN_bit  = 0x00;                 // habilita o receptor no modo assincrono
	BCF         CREN_bit+0, 4 
;Bluetooth_PIC18F4550.c,101 :: 		SPEN_bit  = 0x01;                 // habilita a porta serial
	BSF         SPEN_bit+0, 7 
;Bluetooth_PIC18F4550.c,102 :: 		CREN_bit  = 0x01;                 // habilita o receptor no modo assincrono
	BSF         CREN_bit+0, 4 
;Bluetooth_PIC18F4550.c,103 :: 		break;
	GOTO        L_interrupt149
;Bluetooth_PIC18F4550.c,107 :: 		default:
L_interrupt163:
;Bluetooth_PIC18F4550.c,108 :: 		break;
	GOTO        L_interrupt149
;Bluetooth_PIC18F4550.c,109 :: 		}//end switch
L_interrupt148:
	MOVF        _byte+0, 0 
	XORLW       115
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt150
	MOVF        _byte+0, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt152
	MOVF        _byte+0, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt153
	MOVF        _byte+0, 0 
	XORLW       50
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt154
	MOVF        _byte+0, 0 
	XORLW       51
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt155
	MOVF        _byte+0, 0 
	XORLW       52
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt156
	MOVF        _byte+0, 0 
	XORLW       53
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt157
	MOVF        _byte+0, 0 
	XORLW       54
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt158
	MOVF        _byte+0, 0 
	XORLW       55
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt159
	MOVF        _byte+0, 0 
	XORLW       56
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt160
	MOVF        _byte+0, 0 
	XORLW       79
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt161
	MOVF        _byte+0, 0 
	XORLW       84
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt162
	GOTO        L_interrupt163
L_interrupt149:
;Bluetooth_PIC18F4550.c,110 :: 		}//end if
L_interrupt147:
;Bluetooth_PIC18F4550.c,111 :: 		}//end interrupt
L_end_interrupt:
L__interrupt203:
	RETFIE      1
; end of _interrupt

_main:

;Bluetooth_PIC18F4550.c,114 :: 		void main(){     //--Função principal
;Bluetooth_PIC18F4550.c,115 :: 		ADCON1   = 0X0F;                  // configura todos os pinos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;Bluetooth_PIC18F4550.c,117 :: 		GIE_bit  = 0x01;                  // habilita a interrupção global
	BSF         GIE_bit+0, 7 
;Bluetooth_PIC18F4550.c,118 :: 		PEIE_bit = 0x01;                  // habilita interrupção por periféricos
	BSF         PEIE_bit+0, 6 
;Bluetooth_PIC18F4550.c,121 :: 		TXEN_bit  = 0x01;                 // habilita o transmissor
	BSF         TXEN_bit+0, 5 
;Bluetooth_PIC18F4550.c,122 :: 		TX9_bit   = 0x00;                 // envio de 8 bits
	BCF         TX9_bit+0, 6 
;Bluetooth_PIC18F4550.c,123 :: 		SYNC_bit  = 0x00;                 // seleciona o modo assincrono
	BCF         SYNC_bit+0, 4 
;Bluetooth_PIC18F4550.c,124 :: 		TRMT_bit  = 0x01;                 // buffer vazio
	BSF         TRMT_bit+0, 1 
;Bluetooth_PIC18F4550.c,125 :: 		BRGH_bit  = 0x01;                 // alta taxa de dados
	BSF         BRGH_bit+0, 2 
;Bluetooth_PIC18F4550.c,128 :: 		BRG16_bit = 0X01;                 // segundo registrador de 8 bits acionado
	BSF         BRG16_bit+0, 3 
;Bluetooth_PIC18F4550.c,129 :: 		SPBRG     = 0x10;                 // baudrate de 9600bps
	MOVLW       16
	MOVWF       SPBRG+0 
;Bluetooth_PIC18F4550.c,130 :: 		SPBRGH    = 0x00;
	CLRF        SPBRGH+0 
;Bluetooth_PIC18F4550.c,133 :: 		SPEN_bit  = 0x01;                 // habilita a porta serial
	BSF         SPEN_bit+0, 7 
;Bluetooth_PIC18F4550.c,134 :: 		CREN_bit  = 0x01;                 // habilita o receptor no modo assincrono
	BSF         CREN_bit+0, 4 
;Bluetooth_PIC18F4550.c,135 :: 		RX9_bit= 0x00;
	BCF         RX9_bit+0, 6 
;Bluetooth_PIC18F4550.c,138 :: 		RCIF_bit  = 0x00;                 // zera a flag de interrupção do receptor
	BCF         RCIF_bit+0, 5 
;Bluetooth_PIC18F4550.c,139 :: 		RCIE_bit  = 0x01;                 // habilita a interrupção pelo receptor
	BSF         RCIE_bit+0, 5 
;Bluetooth_PIC18F4550.c,140 :: 		UART1_INIT(115200);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       16
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Bluetooth_PIC18F4550.c,141 :: 		UART1_WRITE_TEXT("1 -PISCA LED \r \n");
	MOVLW       ?lstr8_Bluetooth_PIC18F4550+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr8_Bluetooth_PIC18F4550+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Bluetooth_PIC18F4550.c,142 :: 		UART1_WRITE_TEXT("2-DISPLAY 7 SEG \r \n");
	MOVLW       ?lstr9_Bluetooth_PIC18F4550+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr9_Bluetooth_PIC18F4550+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Bluetooth_PIC18F4550.c,143 :: 		UART1_WRITE_TEXT("3-TEMPERATURA \r \n");
	MOVLW       ?lstr10_Bluetooth_PIC18F4550+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr10_Bluetooth_PIC18F4550+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Bluetooth_PIC18F4550.c,144 :: 		UART1_WRITE_TEXT("4-VENTOINHA \r \n");
	MOVLW       ?lstr11_Bluetooth_PIC18F4550+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr11_Bluetooth_PIC18F4550+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Bluetooth_PIC18F4550.c,145 :: 		UART1_WRITE_TEXT("5-AQUECEDOR \r \n");
	MOVLW       ?lstr12_Bluetooth_PIC18F4550+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr12_Bluetooth_PIC18F4550+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Bluetooth_PIC18F4550.c,146 :: 		UART1_WRITE_TEXT("6-BUZZER \r \n");
	MOVLW       ?lstr13_Bluetooth_PIC18F4550+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr13_Bluetooth_PIC18F4550+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Bluetooth_PIC18F4550.c,147 :: 		UART1_WRITE_TEXT("7-BOTAO PWM \r \n");
	MOVLW       ?lstr14_Bluetooth_PIC18F4550+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr14_Bluetooth_PIC18F4550+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Bluetooth_PIC18F4550.c,148 :: 		UART1_WRITE_TEXT("8-IFPA \r \n");
	MOVLW       ?lstr15_Bluetooth_PIC18F4550+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr15_Bluetooth_PIC18F4550+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Bluetooth_PIC18F4550.c,149 :: 		cnt1=0;
	CLRF        _cnt1+0 
;Bluetooth_PIC18F4550.c,150 :: 		function = 0;
	BCF         _function+0, BitPos(_function+0) 
;Bluetooth_PIC18F4550.c,151 :: 		while(1){                        //Loop infinito
L_main164:
;Bluetooth_PIC18F4550.c,153 :: 		if(UniFlag == 1) {               // Se UniFlag = 1
	MOVF        _UniFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main166
;Bluetooth_PIC18F4550.c,154 :: 		cnt1++;                      // incremento
	INCF        _cnt1+0, 1 
;Bluetooth_PIC18F4550.c,155 :: 		if(cnt1%2!=0) Pisca_LED(&UniFlag);
	MOVLW       1
	ANDWF       _cnt1+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main167
	MOVLW       _UniFlag+0
	MOVWF       FARG_Pisca_LED_info+0 
	MOVLW       hi_addr(_UniFlag+0)
	MOVWF       FARG_Pisca_LED_info+1 
	CALL        _Pisca_LED+0, 0
L_main167:
;Bluetooth_PIC18F4550.c,158 :: 		}//
L_main166:
;Bluetooth_PIC18F4550.c,161 :: 		if(UniFlag == 2) {               // Se UniFlag = 2
	MOVF        _UniFlag+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main168
;Bluetooth_PIC18F4550.c,162 :: 		cnt2++;                          // incremento
	INCF        _cnt2+0, 1 
;Bluetooth_PIC18F4550.c,163 :: 		if(cnt2%2!=0) Cnt_Display_7seg(&UniFlag); // Execução de Programa
	MOVLW       1
	ANDWF       _cnt2+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main169
	MOVLW       _UniFlag+0
	MOVWF       FARG_Cnt_Display_7seg_info+0 
	MOVLW       hi_addr(_UniFlag+0)
	MOVWF       FARG_Cnt_Display_7seg_info+1 
	CALL        _Cnt_Display_7seg+0, 0
L_main169:
;Bluetooth_PIC18F4550.c,164 :: 		}//end if
L_main168:
;Bluetooth_PIC18F4550.c,167 :: 		if(UniFlag == 3) {               // Se UniFlag = 3
	MOVF        _UniFlag+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main170
;Bluetooth_PIC18F4550.c,168 :: 		cnt3++;                          // incremento
	INCF        _cnt3+0, 1 
;Bluetooth_PIC18F4550.c,169 :: 		if(cnt3%2!=0) Temperatura_LCD(&UniFlag);   // Execução de Programa
	MOVLW       1
	ANDWF       _cnt3+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main171
	MOVLW       _UniFlag+0
	MOVWF       FARG_Temperatura_LCD_info+0 
	MOVLW       hi_addr(_UniFlag+0)
	MOVWF       FARG_Temperatura_LCD_info+1 
	CALL        _Temperatura_LCD+0, 0
L_main171:
;Bluetooth_PIC18F4550.c,170 :: 		}//end if
L_main170:
;Bluetooth_PIC18F4550.c,173 :: 		if(UniFlag == 4) {               // Se UniFlag = 4
	MOVF        _UniFlag+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_main172
;Bluetooth_PIC18F4550.c,174 :: 		cnt4++;                          // incremento
	INCF        _cnt4+0, 1 
;Bluetooth_PIC18F4550.c,175 :: 		if(cnt4%2!=0) LigaVentoinha(&UniFlag);         // LIGA
	MOVLW       1
	ANDWF       _cnt4+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main173
	MOVLW       _UniFlag+0
	MOVWF       FARG_LigaVentoinha_info+0 
	MOVLW       hi_addr(_UniFlag+0)
	MOVWF       FARG_LigaVentoinha_info+1 
	CALL        _LigaVentoinha+0, 0
L_main173:
;Bluetooth_PIC18F4550.c,177 :: 		}//end if
L_main172:
;Bluetooth_PIC18F4550.c,180 :: 		if(UniFlag == 5) {               // Se UniFlag = 5
	MOVF        _UniFlag+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_main174
;Bluetooth_PIC18F4550.c,181 :: 		cnt5++;                          // incremento
	INCF        _cnt5+0, 1 
;Bluetooth_PIC18F4550.c,182 :: 		if(cnt5%2!=0) AtivaAquecedor(&UniFlag);            // se for par..
	MOVLW       1
	ANDWF       _cnt5+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main175
	MOVLW       _UniFlag+0
	MOVWF       FARG_AtivaAquecedor_info+0 
	MOVLW       hi_addr(_UniFlag+0)
	MOVWF       FARG_AtivaAquecedor_info+1 
	CALL        _AtivaAquecedor+0, 0
L_main175:
;Bluetooth_PIC18F4550.c,184 :: 		}//end if
L_main174:
;Bluetooth_PIC18F4550.c,187 :: 		if(UniFlag == 6) {               // Se UniFlag = 6
	MOVF        _UniFlag+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_main176
;Bluetooth_PIC18F4550.c,188 :: 		cnt6++;                          // incremento
	INCF        _cnt6+0, 1 
;Bluetooth_PIC18F4550.c,189 :: 		if(cnt6%2!=0) Toca_Buzzer();            // Execução de Programa
	MOVLW       1
	ANDWF       _cnt6+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main177
	CALL        _Toca_Buzzer+0, 0
L_main177:
;Bluetooth_PIC18F4550.c,190 :: 		}//end if
L_main176:
;Bluetooth_PIC18F4550.c,193 :: 		if(UniFlag == 7) {               // Se UniFlag = 7
	MOVF        _UniFlag+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_main178
;Bluetooth_PIC18F4550.c,194 :: 		cnt7++;                          // incremento
	INCF        _cnt7+0, 1 
;Bluetooth_PIC18F4550.c,195 :: 		if(cnt7%2!=0)Botao_PWM(&UniFlag);            // Execução de Programa
	MOVLW       1
	ANDWF       _cnt7+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main179
	MOVLW       _UniFlag+0
	MOVWF       FARG_Botao_PWM_info+0 
	MOVLW       hi_addr(_UniFlag+0)
	MOVWF       FARG_Botao_PWM_info+1 
	CALL        _Botao_PWM+0, 0
L_main179:
;Bluetooth_PIC18F4550.c,196 :: 		}//end if
L_main178:
;Bluetooth_PIC18F4550.c,199 :: 		if(UniFlag == 8) {               // Se UniFlag = 7
	MOVF        _UniFlag+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_main180
;Bluetooth_PIC18F4550.c,200 :: 		cnt8++;                          // incremento
	INCF        _cnt8+0, 1 
;Bluetooth_PIC18F4550.c,201 :: 		if(cnt8%2!=0) IFPA_Disp_7seg(&Uniflag);          // Execução de Programa
	MOVLW       1
	ANDWF       _cnt8+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main181
	MOVLW       _UniFlag+0
	MOVWF       FARG_IFPA_Disp_7seg_info+0 
	MOVLW       hi_addr(_UniFlag+0)
	MOVWF       FARG_IFPA_Disp_7seg_info+1 
	CALL        _IFPA_Disp_7seg+0, 0
L_main181:
;Bluetooth_PIC18F4550.c,202 :: 		}//end if
L_main180:
;Bluetooth_PIC18F4550.c,204 :: 		if(UniFlag == 9) {               // Se UniFlag = 7
	MOVF        _UniFlag+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_main182
;Bluetooth_PIC18F4550.c,205 :: 		cnt9++;                          // incremento
	INCF        _cnt9+0, 1 
;Bluetooth_PIC18F4550.c,206 :: 		if(cnt9%2!=0) LCD_Hello(&Uniflag);            // Execução de Programa
	MOVLW       1
	ANDWF       _cnt9+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main183
	MOVLW       _UniFlag+0
	MOVWF       FARG_LCD_Hello_info+0 
	MOVLW       hi_addr(_UniFlag+0)
	MOVWF       FARG_LCD_Hello_info+1 
	CALL        _LCD_Hello+0, 0
L_main183:
;Bluetooth_PIC18F4550.c,207 :: 		}//end if
L_main182:
;Bluetooth_PIC18F4550.c,209 :: 		if(UniFlag == 10) {               // Se UniFlag = 7
	MOVF        _UniFlag+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_main184
;Bluetooth_PIC18F4550.c,210 :: 		cnt10++;                          // incremento
	INCF        _cnt10+0, 1 
;Bluetooth_PIC18F4550.c,211 :: 		if(cnt10%2!=0) LCD_Bye(&Uniflag);            // Execução de Programa
	MOVLW       1
	ANDWF       _cnt10+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main185
	MOVLW       _UniFlag+0
	MOVWF       FARG_LCD_Bye_info+0 
	MOVLW       hi_addr(_UniFlag+0)
	MOVWF       FARG_LCD_Bye_info+1 
	CALL        _LCD_Bye+0, 0
L_main185:
;Bluetooth_PIC18F4550.c,212 :: 		}//end if
L_main184:
;Bluetooth_PIC18F4550.c,216 :: 		}//end while
	GOTO        L_main164
;Bluetooth_PIC18F4550.c,217 :: 		}//end void
L_end_main:
	GOTO        $+0
; end of _main
