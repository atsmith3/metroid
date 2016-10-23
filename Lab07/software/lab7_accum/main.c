/*
 * main.c
 *
 *  Created on: Oct 10, 2016
 *      Author: zach
 */

int main()
{
	volatile unsigned int *LED_PIO = (unsigned int*)0x40; //make a pointer to access the PIO block
	volatile unsigned int *SW_PIO = (unsigned int*)0x30; //make a pointer to access the PIO block
	volatile unsigned int *KEY_PIO = (unsigned int*)0x20; //make a pointer to access the PIO block

	*LED_PIO = 0; //clear all LEDs
	while ( (1+1) != 3) //infinite loop
	{
		if(*KEY_PIO & 0x01 == 0)
			//Reset
			*LED_PIO&=0x00;
		else if(*KEY_PIO & 0x02 == 0)
			//Add
			*LED_PIO+=*SW_PIO;

		while(*KEY_PIO & 0x02 == 0) {/*Wait for KEY[3] to go high*/}
	}
	return 1; //never gets here
}
