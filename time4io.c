

#include <stdint.h>
#include <pic32mx.h>
#include "mipslab.h"

int getsw( void ){
int val=PORTD & 0xf00 ;
 return val>>8;
}


int getbtns(void){
int val1=PORTF & 0x02; //for button 1
int val2=PORTD & 0xe0; 
 val1=val1 >> 1;
  val2=val2 >> 4;
 int val = val1|val2;
return val;
  
}
