/*
Project: A simple Home Automation System
Sw Developer: @IamNash |0xCrazy,
Mcu: 16f877A
Osc: Crystal @ 8Mhz
Date_Created: 14/05/2012
*/


/*
Disclaimer:

The source code provided herein is made available for educational and informational purposes only. By using this source code, you acknowledge and agree to assume full responsibility for any consequences arising from your use, including but not limited to any illegal or irresponsible activities conducted with the code.

The original author of the source code does not condone or endorse any illegal, unethical, or irresponsible use of this code. The author shall not be held liable for any damages, losses, or legal repercussions resulting from the use or misuse of this code.

It is your responsibility to ensure that your usage of this code complies with all applicable laws, regulations, and ethical guidelines. You are solely responsible for any actions taken based on the code, and you agree to indemnify and hold harmless the original author from any claims, damages, or liabilities arising from your use of the code.

It is strongly advised that you exercise caution, conduct proper testing, and adhere to legal and ethical practices when utilizing this source code. If you are unsure about the legality or appropriateness of any usage, consult with legal professionals or appropriate authorities before proceeding.

By using this source code, you confirm that you have read and understood this disclaimer and agree to its terms.

*/
sbit fan at RD0_bit;
sbit taa at RD1_bit;
sbit tv at RD2_bit;
sbit baza at RD3_bit;
sbit sensa at RA0_bit;

// LCD module connections
sbit LCD_RS at RB2_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;

sbit LCD_RS_Direction at TRISB2_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;
// End LCD module connections



short kifaa,i,kifaa_status;
const short time=1;

  void interrupt()
{
char delimiter_[2];
 char txt[20];
short k=0, j;
 do {
  while(!UART1_Data_Ready());
  delimiter_[1]=delimiter_[0];
  delimiter_[0]=UART1_Read();
  txt[k]=delimiter_[0];
  k++;
  if((delimiter_[0]== 0x4E && delimiter_[1]==0x4F) || (delimiter_[0]==0x46  && delimiter_[1]==0x46) || k>5)
  break;
 } while(1);
 RCIF_bit=0;
 delay_ms(20);

j=i;
i=10;
if(strncmp("FAON",txt,4)== 0){
kifaa_status=1;
}
else if(strncmp("TAAON",txt,5)== 0){
kifaa_status=2;
}
else if(strncmp("TFON",txt,4)== 0){
kifaa_status=3;
}
else if(strncmp("FAOFF",txt,5)== 0){
kifaa_status=4;
}
else if(strncmp("TAAOFF",txt,6)== 0){
kifaa_status=5;
}
else if(strncmp("TFOFF",txt,5)== 0){
kifaa_status=6;
}

else
i=j;
}//void interrupt


void main() {
TrisD = 0x00;
PortD = 0x00;
TRISA=1;
PORTA=0;
INTCON = 0xC0;
RCIE_bit=1;
CMCON=7;
ADCON1=7;
Lcd_Init();                        // Initialize LCD

Lcd_Cmd(_LCD_CLEAR);               // Clear display
Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off



uart1_init(9600);
delay_ms(1000);

main:
 LCD_OUT(1,2,"HOME AUTOMATION") ;

  do{
  
  if (sensa==1) {
  baza=1;
  //uart1_write_text("intruder!");
  Lcd_Cmd(_LCD_CLEAR);
  LCD_OUT(1,1,"Intruder!");
  delay_ms(2000);
  baza=0;
  Lcd_Cmd(_LCD_CLEAR);
  goto main;
  }

  }while(kifaa_status==0);// do



if(kifaa_status==2){
taa=1;
Lcd_Cmd(_LCD_CLEAR);
LCD_OUT(1,1,"TAA IS ON");
DELAY_MS(3000);
Lcd_Cmd(_LCD_CLEAR);
kifaa_status=0;

goto main;
}

else if(kifaa_status==3){
tv=1;
fan=1;
Lcd_Cmd(_LCD_CLEAR);
LCD_OUT(1,1,"TV & FAN ON");
DELAY_MS(3000);
Lcd_Cmd(_LCD_CLEAR);
kifaa_status=0;
goto main;
}


else if(kifaa_status==5){
taa=0;
Lcd_Cmd(_LCD_CLEAR);
LCD_OUT(1,1,"TAA IS OFF");
DELAY_MS(3000);
Lcd_Cmd(_LCD_CLEAR);
kifaa_status=0;
goto main;
}

else if(kifaa_status==6){
tv=0;
fan=0;
Lcd_Cmd(_LCD_CLEAR);
LCD_OUT(1,1,"TV & FAN OFF");
DELAY_MS(3000);
Lcd_Cmd(_LCD_CLEAR);
kifaa_status=0;
goto main;
}

else {
kifaa_status=0;
goto main;}
} //Mwisho wa Program Kuu