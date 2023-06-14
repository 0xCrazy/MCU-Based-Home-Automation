
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;home_automation.c,35 :: 		void interrupt()
;home_automation.c,39 :: 		short k=0, j;
	CLRF       interrupt_k_L0+0
;home_automation.c,40 :: 		do {
L_interrupt0:
;home_automation.c,41 :: 		while(!UART1_Data_Ready());
L_interrupt3:
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt4
	GOTO       L_interrupt3
L_interrupt4:
;home_automation.c,42 :: 		delimiter_[1]=delimiter_[0];
	MOVF       interrupt_delimiter__L0+0, 0
	MOVWF      interrupt_delimiter__L0+1
;home_automation.c,43 :: 		delimiter_[0]=UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      interrupt_delimiter__L0+0
;home_automation.c,44 :: 		txt[k]=delimiter_[0];
	MOVF       interrupt_k_L0+0, 0
	ADDLW      interrupt_txt_L0+0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;home_automation.c,45 :: 		k++;
	INCF       interrupt_k_L0+0, 1
;home_automation.c,46 :: 		if((delimiter_[0]== 0x4E && delimiter_[1]==0x4F) || (delimiter_[0]==0x46  && delimiter_[1]==0x46) || k>5)
	MOVF       interrupt_delimiter__L0+0, 0
	XORLW      78
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt45
	MOVF       interrupt_delimiter__L0+1, 0
	XORLW      79
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt45
	GOTO       L__interrupt43
L__interrupt45:
	MOVF       interrupt_delimiter__L0+0, 0
	XORLW      70
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt44
	MOVF       interrupt_delimiter__L0+1, 0
	XORLW      70
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt44
	GOTO       L__interrupt43
L__interrupt44:
	MOVLW      128
	XORLW      5
	MOVWF      R0+0
	MOVLW      128
	XORWF      interrupt_k_L0+0, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__interrupt43
	GOTO       L_interrupt11
L__interrupt43:
;home_automation.c,47 :: 		break;
	GOTO       L_interrupt1
L_interrupt11:
;home_automation.c,48 :: 		} while(1);
	GOTO       L_interrupt0
L_interrupt1:
;home_automation.c,49 :: 		RCIF_bit=0;
	BCF        RCIF_bit+0, 5
;home_automation.c,50 :: 		delay_ms(20);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_interrupt12:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt12
	DECFSZ     R12+0, 1
	GOTO       L_interrupt12
	NOP
	NOP
;home_automation.c,52 :: 		j=i;
	MOVF       _i+0, 0
	MOVWF      interrupt_j_L0+0
;home_automation.c,53 :: 		i=10;
	MOVLW      10
	MOVWF      _i+0
;home_automation.c,54 :: 		if(strncmp("FAON",txt,4)== 0){
	MOVLW      ?lstr1_home_automation+0
	MOVWF      FARG_strncmp_s1+0
	MOVLW      interrupt_txt_L0+0
	MOVWF      FARG_strncmp_s2+0
	MOVLW      4
	MOVWF      FARG_strncmp_len+0
	CALL       _strncmp+0
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt48
	MOVLW      0
	XORWF      R0+0, 0
L__interrupt48:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt13
;home_automation.c,55 :: 		kifaa_status=1;
	MOVLW      1
	MOVWF      _kifaa_status+0
;home_automation.c,56 :: 		}
	GOTO       L_interrupt14
L_interrupt13:
;home_automation.c,57 :: 		else if(strncmp("TAAON",txt,5)== 0){
	MOVLW      ?lstr2_home_automation+0
	MOVWF      FARG_strncmp_s1+0
	MOVLW      interrupt_txt_L0+0
	MOVWF      FARG_strncmp_s2+0
	MOVLW      5
	MOVWF      FARG_strncmp_len+0
	CALL       _strncmp+0
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt49
	MOVLW      0
	XORWF      R0+0, 0
L__interrupt49:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt15
;home_automation.c,58 :: 		kifaa_status=2;
	MOVLW      2
	MOVWF      _kifaa_status+0
;home_automation.c,59 :: 		}
	GOTO       L_interrupt16
L_interrupt15:
;home_automation.c,60 :: 		else if(strncmp("TFON",txt,4)== 0){
	MOVLW      ?lstr3_home_automation+0
	MOVWF      FARG_strncmp_s1+0
	MOVLW      interrupt_txt_L0+0
	MOVWF      FARG_strncmp_s2+0
	MOVLW      4
	MOVWF      FARG_strncmp_len+0
	CALL       _strncmp+0
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt50
	MOVLW      0
	XORWF      R0+0, 0
L__interrupt50:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt17
;home_automation.c,61 :: 		kifaa_status=3;
	MOVLW      3
	MOVWF      _kifaa_status+0
;home_automation.c,62 :: 		}
	GOTO       L_interrupt18
L_interrupt17:
;home_automation.c,63 :: 		else if(strncmp("FAOFF",txt,5)== 0){
	MOVLW      ?lstr4_home_automation+0
	MOVWF      FARG_strncmp_s1+0
	MOVLW      interrupt_txt_L0+0
	MOVWF      FARG_strncmp_s2+0
	MOVLW      5
	MOVWF      FARG_strncmp_len+0
	CALL       _strncmp+0
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt51
	MOVLW      0
	XORWF      R0+0, 0
L__interrupt51:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt19
;home_automation.c,64 :: 		kifaa_status=4;
	MOVLW      4
	MOVWF      _kifaa_status+0
;home_automation.c,65 :: 		}
	GOTO       L_interrupt20
L_interrupt19:
;home_automation.c,66 :: 		else if(strncmp("TAAOFF",txt,6)== 0){
	MOVLW      ?lstr5_home_automation+0
	MOVWF      FARG_strncmp_s1+0
	MOVLW      interrupt_txt_L0+0
	MOVWF      FARG_strncmp_s2+0
	MOVLW      6
	MOVWF      FARG_strncmp_len+0
	CALL       _strncmp+0
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt52
	MOVLW      0
	XORWF      R0+0, 0
L__interrupt52:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt21
;home_automation.c,67 :: 		kifaa_status=5;
	MOVLW      5
	MOVWF      _kifaa_status+0
;home_automation.c,68 :: 		}
	GOTO       L_interrupt22
L_interrupt21:
;home_automation.c,69 :: 		else if(strncmp("TFOFF",txt,5)== 0){
	MOVLW      ?lstr6_home_automation+0
	MOVWF      FARG_strncmp_s1+0
	MOVLW      interrupt_txt_L0+0
	MOVWF      FARG_strncmp_s2+0
	MOVLW      5
	MOVWF      FARG_strncmp_len+0
	CALL       _strncmp+0
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt53
	MOVLW      0
	XORWF      R0+0, 0
L__interrupt53:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt23
;home_automation.c,70 :: 		kifaa_status=6;
	MOVLW      6
	MOVWF      _kifaa_status+0
;home_automation.c,71 :: 		}
	GOTO       L_interrupt24
L_interrupt23:
;home_automation.c,74 :: 		i=j;
	MOVF       interrupt_j_L0+0, 0
	MOVWF      _i+0
L_interrupt24:
L_interrupt22:
L_interrupt20:
L_interrupt18:
L_interrupt16:
L_interrupt14:
;home_automation.c,75 :: 		}//void interrupt
L_end_interrupt:
L__interrupt47:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;home_automation.c,78 :: 		void main() {
;home_automation.c,79 :: 		TrisD = 0x00;
	CLRF       TRISD+0
;home_automation.c,80 :: 		PortD = 0x00;
	CLRF       PORTD+0
;home_automation.c,81 :: 		TRISA=1;
	MOVLW      1
	MOVWF      TRISA+0
;home_automation.c,82 :: 		PORTA=0;
	CLRF       PORTA+0
;home_automation.c,83 :: 		INTCON = 0xC0;
	MOVLW      192
	MOVWF      INTCON+0
;home_automation.c,84 :: 		RCIE_bit=1;
	BSF        RCIE_bit+0, 5
;home_automation.c,85 :: 		CMCON=7;
	MOVLW      7
	MOVWF      CMCON+0
;home_automation.c,86 :: 		ADCON1=7;
	MOVLW      7
	MOVWF      ADCON1+0
;home_automation.c,87 :: 		Lcd_Init();                        // Initialize LCD
	CALL       _Lcd_Init+0
;home_automation.c,89 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;home_automation.c,90 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;home_automation.c,94 :: 		uart1_init(9600);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;home_automation.c,95 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main25:
	DECFSZ     R13+0, 1
	GOTO       L_main25
	DECFSZ     R12+0, 1
	GOTO       L_main25
	DECFSZ     R11+0, 1
	GOTO       L_main25
	NOP
	NOP
;home_automation.c,97 :: 		main:
___main_main:
;home_automation.c,98 :: 		LCD_OUT(1,2,"HOME AUTOMATION") ;
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_home_automation+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;home_automation.c,100 :: 		do{
L_main26:
;home_automation.c,102 :: 		if (sensa==1) {
	BTFSS      RA0_bit+0, 0
	GOTO       L_main29
;home_automation.c,103 :: 		baza=1;
	BSF        RD3_bit+0, 3
;home_automation.c,105 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;home_automation.c,106 :: 		LCD_OUT(1,1,"Intruder!");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_home_automation+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;home_automation.c,107 :: 		delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main30:
	DECFSZ     R13+0, 1
	GOTO       L_main30
	DECFSZ     R12+0, 1
	GOTO       L_main30
	DECFSZ     R11+0, 1
	GOTO       L_main30
	NOP
;home_automation.c,108 :: 		baza=0;
	BCF        RD3_bit+0, 3
;home_automation.c,109 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;home_automation.c,110 :: 		goto main;
	GOTO       ___main_main
;home_automation.c,111 :: 		}
L_main29:
;home_automation.c,113 :: 		}while(kifaa_status==0);// do
	MOVF       _kifaa_status+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main26
;home_automation.c,126 :: 		if(kifaa_status==2){
	MOVF       _kifaa_status+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main31
;home_automation.c,127 :: 		taa=1;
	BSF        RD1_bit+0, 1
;home_automation.c,128 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;home_automation.c,129 :: 		LCD_OUT(1,1,"TAA IS ON");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_home_automation+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;home_automation.c,130 :: 		DELAY_MS(3000);
	MOVLW      31
	MOVWF      R11+0
	MOVLW      113
	MOVWF      R12+0
	MOVLW      30
	MOVWF      R13+0
L_main32:
	DECFSZ     R13+0, 1
	GOTO       L_main32
	DECFSZ     R12+0, 1
	GOTO       L_main32
	DECFSZ     R11+0, 1
	GOTO       L_main32
	NOP
;home_automation.c,131 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;home_automation.c,132 :: 		kifaa_status=0;
	CLRF       _kifaa_status+0
;home_automation.c,134 :: 		goto main;
	GOTO       ___main_main
;home_automation.c,135 :: 		}
L_main31:
;home_automation.c,137 :: 		else if(kifaa_status==3){
	MOVF       _kifaa_status+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main34
;home_automation.c,138 :: 		tv=1;
	BSF        RD2_bit+0, 2
;home_automation.c,139 :: 		fan=1;
	BSF        RD0_bit+0, 0
;home_automation.c,140 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;home_automation.c,141 :: 		LCD_OUT(1,1,"TV & FAN ON");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_home_automation+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;home_automation.c,142 :: 		DELAY_MS(3000);
	MOVLW      31
	MOVWF      R11+0
	MOVLW      113
	MOVWF      R12+0
	MOVLW      30
	MOVWF      R13+0
L_main35:
	DECFSZ     R13+0, 1
	GOTO       L_main35
	DECFSZ     R12+0, 1
	GOTO       L_main35
	DECFSZ     R11+0, 1
	GOTO       L_main35
	NOP
;home_automation.c,143 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;home_automation.c,144 :: 		kifaa_status=0;
	CLRF       _kifaa_status+0
;home_automation.c,145 :: 		goto main;
	GOTO       ___main_main
;home_automation.c,146 :: 		}
L_main34:
;home_automation.c,149 :: 		else if(kifaa_status==5){
	MOVF       _kifaa_status+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L_main37
;home_automation.c,150 :: 		taa=0;
	BCF        RD1_bit+0, 1
;home_automation.c,151 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;home_automation.c,152 :: 		LCD_OUT(1,1,"TAA IS OFF");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr11_home_automation+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;home_automation.c,153 :: 		DELAY_MS(3000);
	MOVLW      31
	MOVWF      R11+0
	MOVLW      113
	MOVWF      R12+0
	MOVLW      30
	MOVWF      R13+0
L_main38:
	DECFSZ     R13+0, 1
	GOTO       L_main38
	DECFSZ     R12+0, 1
	GOTO       L_main38
	DECFSZ     R11+0, 1
	GOTO       L_main38
	NOP
;home_automation.c,154 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;home_automation.c,155 :: 		kifaa_status=0;
	CLRF       _kifaa_status+0
;home_automation.c,156 :: 		goto main;
	GOTO       ___main_main
;home_automation.c,157 :: 		}
L_main37:
;home_automation.c,159 :: 		else if(kifaa_status==6){
	MOVF       _kifaa_status+0, 0
	XORLW      6
	BTFSS      STATUS+0, 2
	GOTO       L_main40
;home_automation.c,160 :: 		tv=0;
	BCF        RD2_bit+0, 2
;home_automation.c,161 :: 		fan=0;
	BCF        RD0_bit+0, 0
;home_automation.c,162 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;home_automation.c,163 :: 		LCD_OUT(1,1,"TV & FAN OFF");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr12_home_automation+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;home_automation.c,164 :: 		DELAY_MS(3000);
	MOVLW      31
	MOVWF      R11+0
	MOVLW      113
	MOVWF      R12+0
	MOVLW      30
	MOVWF      R13+0
L_main41:
	DECFSZ     R13+0, 1
	GOTO       L_main41
	DECFSZ     R12+0, 1
	GOTO       L_main41
	DECFSZ     R11+0, 1
	GOTO       L_main41
	NOP
;home_automation.c,165 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;home_automation.c,166 :: 		kifaa_status=0;
	CLRF       _kifaa_status+0
;home_automation.c,167 :: 		goto main;
	GOTO       ___main_main
;home_automation.c,168 :: 		}
L_main40:
;home_automation.c,171 :: 		kifaa_status=0;
	CLRF       _kifaa_status+0
;home_automation.c,172 :: 		goto main;}
	GOTO       ___main_main
;home_automation.c,173 :: 		} //main
L_end_main:
	GOTO       $+0
; end of _main
