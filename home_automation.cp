#line 1 "H:/ /PROJECTS/Projects from Sanga/on process/HOME AUTOMATION/home_automation.c"
#line 8 "H:/ /PROJECTS/Projects from Sanga/on process/HOME AUTOMATION/home_automation.c"
sbit fan at RD0_bit;
sbit taa at RD1_bit;
sbit tv at RD2_bit;
sbit baza at RD3_bit;
sbit sensa at RA0_bit;


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
 if((delimiter_[0]== 0x4E && delimiter_[1]==0x4F) || (delimiter_[0]==0x46 && delimiter_[1]==0x46) || k>5)
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
}


void main() {
TrisD = 0x00;
PortD = 0x00;
TRISA=1;
PORTA=0;
INTCON = 0xC0;
RCIE_bit=1;
CMCON=7;
ADCON1=7;
Lcd_Init();

Lcd_Cmd(_LCD_CLEAR);
Lcd_Cmd(_LCD_CURSOR_OFF);



uart1_init(9600);
delay_ms(1000);

main:
 LCD_OUT(1,2,"HOME AUTOMATION") ;

 do{

 if (sensa==1) {
 baza=1;

 Lcd_Cmd(_LCD_CLEAR);
 LCD_OUT(1,1,"Intruder!");
 delay_ms(2000);
 baza=0;
 Lcd_Cmd(_LCD_CLEAR);
 goto main;
 }

 }while(kifaa_status==0);
#line 126 "H:/ /PROJECTS/Projects from Sanga/on process/HOME AUTOMATION/home_automation.c"
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
}
