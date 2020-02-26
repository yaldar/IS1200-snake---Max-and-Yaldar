/* mipslabwork.c

   This file written 2015 by F Lundevall
   Updated 2017-04-21 by F Lundevall

   This file should be changed by YOU! So you must
   add comment(s) here with your name(s) and date(s):

   This file modified 2020-01-29 by Maximilian Nyberg

   For copyright and licensing, see file COPYING */

#include <stdint.h>   /* Declarations of uint_32 and the like */
#include <pic32mx.h>  /* Declarations of system-specific addresses etc */
#include "mipslab.h"  /* Declatations for these labs */

int prime = 1234567;

//int mytime = 0x5957;
double timeoutcount = 0;
//char textstring[] = "text, more text, and even more text!";
  volatile int *trise= (volatile int*)0xbf886100;
/* Interrupt Service Routine */


int i = 0;
//asdaosijdlaskjdlkj

void user_isr( void ) {
	IFSCLR(0) = (1 << 8);
	timeoutcount++;
if(timeoutcount == 5) {
	timeoutcount = 0;
  move_left();
	//time2string( textstring, mytime );
	//display_string( 3, textstring );
  //display_image(20, icon);
  //display_string( 0, itoaconv( i++ ));
  //display_update();

	//display_update();
	}
}


/* Lab-specific initialization goes here */
void labinit( void )
{

  *trise &= 0xff00;
  //*_TRISE &= ~0xff; //if data = 0, the I/0 is an output.

 TRISD &= 0x0fe0;
  T2CONCLR = 1 << 15;
  TMR2 = 0;
T2CONSET = 0x70;
PR2 = 31250;
IFSCLR(0) = 1 << 8;
T2CONSET = 1 << 15;
IECSET(0) = 1 << 8;
IPCSET(2) = 0x1f;
enable_interrupt();

}

/* This function is called repetitively from the main program */
void labwork( void ) {



//display_image(0, disp);
//prime = nextprime( prime );

//display_image(0, disp);
//display_update();


}
