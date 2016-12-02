/*---------------------------------------------------------------------------
  --      main.c                                                    	   --
  --      Christine Chen                                                   --
  --      Ref. DE2-115 Demonstrations by Terasic Technologies Inc.         --
  --      Fall 2014                                                        --
  --                                                                       --
  --      For use with ECE 298 Experiment 7                                --
  --      UIUC ECE Department                                              --
  ---------------------------------------------------------------------------*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <io.h>
#include <fcntl.h>

#include "system.h"
#include "alt_types.h"
#include <unistd.h>  // usleep
#include "sys/alt_irq.h"
#include "io_handler.h"

#include "cy7c67200.h"
#include "usb.h"
#include "lcp_cmd.h"
#include "lcp_data.h"

#define SAMUS_EN (volatile char*) SAMUS_EN_BASE
#define SAMUS_X (volatile int*) SAMUS_X_BASE
#define SAMUS_Y (volatile int*) SAMUS_Y_BASE
#define SAMUS_DIR (volatile char*) SAMUS_DIR_BASE
#define SAMUS_WALK (volatile char*) SAMUS_WALK_BASE
#define SAMUS_JUMP (volatile char*) SAMUS_JUMP_BASE
#define SAMUS_UP (volatile char*) SAMUS_UP_BASE

#define MON1_EN (volatile char*) MONSTER1_EN_BASE
#define MON1_X (volatile int*) MONSTER1_X_BASE
#define MON1_Y (volatile int*) MONSTER1_Y_BASE

#define MON2_EN (volatile char*) MONSTER2_EN_BASE
#define MON2_X (volatile int*) MONSTER2_X_BASE
#define MON2_Y (volatile int*) MONSTER2_Y_BASE

#define MON3_EN (volatile char*) MONSTER3_EN_BASE
#define MON3_X (volatile int*) MONSTER3_X_BASE
#define MON3_Y (volatile int*) MONSTER3_Y_BASE

#define EXP1_EN (volatile int*) EXPLOSION1_EN_BASE
#define EXP1_X (volatile int*) EXPLOSION1_X_BASE
#define EXP1_Y (volatile int*) EXPLOSION1_Y_BASE

#define EXP2_EN (volatile int*) EXPLOSION2_EN_BASE
#define EXP2_X (volatile int*) EXPLOSION2_X_BASE
#define EXP2_Y (volatile int*) EXPLOSION2_Y_BASE

#define EXP3_EN (volatile int*) EXPLOSION3_EN_BASE
#define EXP3_X (volatile int*) EXPLOSION3_X_BASE
#define EXP3_Y (volatile int*) EXPLOSION3_Y_BASE

#define BUL1_EN (volatile int*) BULLET1_EN_BASE
#define BUL1_X (volatile int*) BULLET1_X_BASE
#define BUL1_Y (volatile int*) BULLET1_Y_BASE

#define BUL2_EN (volatile int*) BULLET2_EN_BASE
#define BUL2_X (volatile int*) BULLET2_X_BASE
#define BUL2_Y (volatile int*) BULLET2_Y_BASE

#define BUL3_EN (volatile int*) BULLET3_EN_BASE
#define BUL3_X (volatile int*) BULLET3_X_BASE
#define BUL3_Y (volatile int*) BULLET3_Y_BASE

#define HEALTH (volatile int*) HEALTH_BASE

#define TIT_EN (volatile int*) TITLE_EN_BASE

#define LOSS_EN (volatile int*) LOSS_EN_BASE

#define WIN_EN (volatile int*) WIN_EN_BASE

#define SCENE_SELECT (volatile int*) SCENE_SEL_BASE

#define True (int) 1
#define False (int) 0

//----------------------------------------------------------------------------------------//
//
//                                Main function
//
//----------------------------------------------------------------------------------------//
int main(void)
{
	IO_init();

	/*while(1)
	{
		IO_write(HPI_MAILBOX,COMM_EXEC_INT);
		printf("[ERROR]:routine mailbox data is %x\n",IO_read(HPI_MAILBOX));
		//UsbWrite(0xc008,0x000f);
		//UsbRead(0xc008);
		usleep(10*10000);
	}*/

	alt_u16 intStat;
	alt_u16 usb_ctl_val;
	static alt_u16 ctl_reg = 0;
	static alt_u16 no_device = 0;
	alt_u16 fs_device = 0;
	long keycode = 0;
	alt_u8 toggle = 0;
	alt_u8 data_size;
	alt_u8 hot_plug_count;
	alt_u16 code;

	printf("USB keyboard setup...\n\n");

	//----------------------------------------SIE1 initial---------------------------------------------------//
	USB_HOT_PLUG:
	UsbSoftReset();

	// STEP 1a:
	UsbWrite (HPI_SIE1_MSG_ADR, 0);
	UsbWrite (HOST1_STAT_REG, 0xFFFF);

	/* Set HUSB_pEOT time */
	UsbWrite(HUSB_pEOT, 600); // adjust the according to your USB device speed

	usb_ctl_val = SOFEOP1_TO_CPU_EN | RESUME1_TO_HPI_EN;// | SOFEOP1_TO_HPI_EN;
	UsbWrite(HPI_IRQ_ROUTING_REG, usb_ctl_val);

	intStat = A_CHG_IRQ_EN | SOF_EOP_IRQ_EN ;
	UsbWrite(HOST1_IRQ_EN_REG, intStat);
	// STEP 1a end

	// STEP 1b begin
	UsbWrite(COMM_R0,0x0000);//reset time
	UsbWrite(COMM_R1,0x0000);  //port number
	UsbWrite(COMM_R2,0x0000);  //r1
	UsbWrite(COMM_R3,0x0000);  //r1
	UsbWrite(COMM_R4,0x0000);  //r1
	UsbWrite(COMM_R5,0x0000);  //r1
	UsbWrite(COMM_R6,0x0000);  //r1
	UsbWrite(COMM_R7,0x0000);  //r1
	UsbWrite(COMM_R8,0x0000);  //r1
	UsbWrite(COMM_R9,0x0000);  //r1
	UsbWrite(COMM_R10,0x0000);  //r1
	UsbWrite(COMM_R11,0x0000);  //r1
	UsbWrite(COMM_R12,0x0000);  //r1
	UsbWrite(COMM_R13,0x0000);  //r1
	UsbWrite(COMM_INT_NUM,HUSB_SIE1_INIT_INT); //HUSB_SIE1_INIT_INT
	IO_write(HPI_MAILBOX,COMM_EXEC_INT);

	while (!(IO_read(HPI_STATUS) & 0xFFFF) )  //read sie1 msg register
	{
	}
	while (IO_read(HPI_MAILBOX) != COMM_ACK)
	{
		printf("[ERROR]:routine mailbox data is %x\n",IO_read(HPI_MAILBOX));
		goto USB_HOT_PLUG;
	}
	// STEP 1b end

	printf("STEP 1 Complete");
	// STEP 2 begin
	UsbWrite(COMM_INT_NUM,HUSB_RESET_INT); //husb reset
	UsbWrite(COMM_R0,0x003c);//reset time
	UsbWrite(COMM_R1,0x0000);  //port number
	UsbWrite(COMM_R2,0x0000);  //r1
	UsbWrite(COMM_R3,0x0000);  //r1
	UsbWrite(COMM_R4,0x0000);  //r1
	UsbWrite(COMM_R5,0x0000);  //r1
	UsbWrite(COMM_R6,0x0000);  //r1
	UsbWrite(COMM_R7,0x0000);  //r1
	UsbWrite(COMM_R8,0x0000);  //r1
	UsbWrite(COMM_R9,0x0000);  //r1
	UsbWrite(COMM_R10,0x0000);  //r1
	UsbWrite(COMM_R11,0x0000);  //r1
	UsbWrite(COMM_R12,0x0000);  //r1
	UsbWrite(COMM_R13,0x0000);  //r1

	IO_write(HPI_MAILBOX,COMM_EXEC_INT);

	while (IO_read(HPI_MAILBOX) != COMM_ACK)
	{
		printf("[ERROR]:routine mailbox data is %x\n",IO_read(HPI_MAILBOX));
		goto USB_HOT_PLUG;
	}
	// STEP 2 end

	ctl_reg = USB1_CTL_REG;
	no_device = (A_DP_STAT | A_DM_STAT);
	fs_device = A_DP_STAT;
	usb_ctl_val = UsbRead(ctl_reg);

	if (!(usb_ctl_val & no_device))
	{
		for(hot_plug_count = 0 ; hot_plug_count < 5 ; hot_plug_count++)
		{
			usleep(5*1000);
			usb_ctl_val = UsbRead(ctl_reg);
			if(usb_ctl_val & no_device) break;
		}
		if(!(usb_ctl_val & no_device))
		{
			printf("\n[INFO]: no device is present in SIE1!\n");
			printf("[INFO]: please insert a USB keyboard in SIE1!\n");
			while (!(usb_ctl_val & no_device))
			{
				usb_ctl_val = UsbRead(ctl_reg);
				if(usb_ctl_val & no_device)
					goto USB_HOT_PLUG;

				usleep(2000);
			}
		}
	}
	else
	{
		/* check for low speed or full speed by reading D+ and D- lines */
		if (usb_ctl_val & fs_device)
		{
			printf("[INFO]: full speed device\n");
		}
		else
		{
			printf("[INFO]: low speed device\n");
		}
	}



	// STEP 3 begin
	//------------------------------------------------------set address -----------------------------------------------------------------
	UsbSetAddress();

	while (!(IO_read(HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
	{
		UsbSetAddress();
		usleep(10*1000);
	}

	UsbWaitTDListDone();

	IO_write(HPI_ADDR,0x0506); // i
	printf("[ENUM PROCESS]:step 3 TD Status Byte is %x\n",IO_read(HPI_DATA));

	IO_write(HPI_ADDR,0x0508); // n
	usb_ctl_val = IO_read(HPI_DATA);
	printf("[ENUM PROCESS]:step 3 TD Control Byte is %x\n",usb_ctl_val);
	while (usb_ctl_val != 0x03) // retries occurred
	{
		usb_ctl_val = UsbGetRetryCnt();

		goto USB_HOT_PLUG;
	}

	printf("------------[ENUM PROCESS]:set address done!---------------\n");

	// STEP 4 begin
	//-------------------------------get device descriptor-1 -----------------------------------//
	// TASK: Call the appropriate function for this step.
	UsbGetDeviceDesc1(); 	// Get Device Descriptor -1

	//usleep(10*1000);
	while (!(IO_read(HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
	{
		// TASK: Call the appropriate function again if it wasn't processed successfully.
		UsbGetDeviceDesc1();
		usleep(10*1000);
	}

	UsbWaitTDListDone();

	IO_write(HPI_ADDR,0x0506);
	printf("[ENUM PROCESS]:step 4 TD Status Byte is %x\n",IO_read(HPI_DATA));

	IO_write(HPI_ADDR,0x0508);
	usb_ctl_val = IO_read(HPI_DATA);
	printf("[ENUM PROCESS]:step 4 TD Control Byte is %x\n",usb_ctl_val);
	while (usb_ctl_val != 0x03)
	{
		usb_ctl_val = UsbGetRetryCnt();
	}

	printf("---------------[ENUM PROCESS]:get device descriptor-1 done!-----------------\n");


	//--------------------------------get device descriptor-2---------------------------------------------//
	//get device descriptor
	// TASK: Call the appropriate function for this step.
	UsbGetDeviceDesc2(); 	// Get Device Descriptor -2

	//if no message
	while (!(IO_read(HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
	{
		//resend the get device descriptor
		//get device descriptor
		// TASK: Call the appropriate function again if it wasn't processed successfully.
		UsbGetDeviceDesc2();
		usleep(10*1000);
	}

	UsbWaitTDListDone();

	IO_write(HPI_ADDR,0x0506);
	printf("[ENUM PROCESS]:step 4 TD Status Byte is %x\n",IO_read(HPI_DATA));

	IO_write(HPI_ADDR,0x0508);
	usb_ctl_val = IO_read(HPI_DATA);
	printf("[ENUM PROCESS]:step 4 TD Control Byte is %x\n",usb_ctl_val);
	while (usb_ctl_val != 0x03)
	{
		usb_ctl_val = UsbGetRetryCnt();
	}

	printf("------------[ENUM PROCESS]:get device descriptor-2 done!--------------\n");


	// STEP 5 begin
	//-----------------------------------get configuration descriptor -1 ----------------------------------//
	// TASK: Call the appropriate function for this step.
	UsbGetConfigDesc1(); 	// Get Configuration Descriptor -1

	//if no message
	while (!(IO_read(HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
	{
		//resend the get device descriptor
		//get device descriptor

		// TASK: Call the appropriate function again if it wasn't processed successfully.
		UsbGetConfigDesc1();
		usleep(10*1000);
	}

	UsbWaitTDListDone();

	IO_write(HPI_ADDR,0x0506);
	printf("[ENUM PROCESS]:step 5 TD Status Byte is %x\n",IO_read(HPI_DATA));

	IO_write(HPI_ADDR,0x0508);
	usb_ctl_val = IO_read(HPI_DATA);
	printf("[ENUM PROCESS]:step 5 TD Control Byte is %x\n",usb_ctl_val);
	while (usb_ctl_val != 0x03)
	{
		usb_ctl_val = UsbGetRetryCnt();
	}
	printf("------------[ENUM PROCESS]:get configuration descriptor-1 pass------------\n");

	// STEP 6 begin
	//-----------------------------------get configuration descriptor-2------------------------------------//
	//get device descriptor
	// TASK: Call the appropriate function for this step.
	UsbGetConfigDesc2(); 	// Get Configuration Descriptor -2

	usleep(100*1000);
	//if no message
	while (!(IO_read(HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
	{
		// TASK: Call the appropriate function again if it wasn't processed successfully.
		UsbGetConfigDesc2();
		usleep(10*1000);
	}

	UsbWaitTDListDone();

	IO_write(HPI_ADDR,0x0506);
	printf("[ENUM PROCESS]:step 6 TD Status Byte is %x\n",IO_read(HPI_DATA));

	IO_write(HPI_ADDR,0x0508);
	usb_ctl_val = IO_read(HPI_DATA);
	printf("[ENUM PROCESS]:step 6 TD Control Byte is %x\n",usb_ctl_val);
	while (usb_ctl_val != 0x03)
	{
		usb_ctl_val = UsbGetRetryCnt();
	}


	printf("-----------[ENUM PROCESS]:get configuration descriptor-2 done!------------\n");


	// ---------------------------------get device info---------------------------------------------//

	// TASK: Write the address to read from the memory for byte 7 of the interface descriptor to HPI_ADDR.
	IO_write(HPI_ADDR,0x056c);
	code = IO_read(HPI_DATA);
	code = code & 0x003;
	printf("\ncode = %x\n", code);

	if (code == 0x01)
	{
		printf("\n[INFO]:check TD rec data7 \n[INFO]:Keyboard Detected!!!\n\n");
	}
	else
	{
		printf("\n[INFO]:Keyboard Not Detected!!! \n\n");
	}

	// TASK: Write the address to read from the memory for the endpoint descriptor to HPI_ADDR.

	IO_write(HPI_ADDR,0x0576);
	IO_write(HPI_DATA,0x073F);
	IO_write(HPI_DATA,0x8105);
	IO_write(HPI_DATA,0x0003);
	IO_write(HPI_DATA,0x0008);
	IO_write(HPI_DATA,0xAC0A);
	UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0576); //HUSB_SIE1_pCurrentTDPtr

	//data_size = (IO_read(HPI_DATA)>>8)&0x0ff;
	//data_size = 0x08;//(IO_read(HPI_DATA))&0x0ff;
	//UsbPrintMem();
	IO_write(HPI_ADDR,0x057c);
	data_size = (IO_read(HPI_DATA))&0x0ff;
	printf("[ENUM PROCESS]:data packet size is %d\n",data_size);
	// STEP 7 begin
	//------------------------------------set configuration -----------------------------------------//
	// TASK: Call the appropriate function for this step.
	UsbSetConfig();		// Set Configuration

	while (!(IO_read(HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
	{
		// TASK: Call the appropriate function again if it wasn't processed successfully.
		UsbSetConfig();		// Set Configuration
		usleep(10*1000);
	}

	UsbWaitTDListDone();

	IO_write(HPI_ADDR,0x0506);
	printf("[ENUM PROCESS]:step 7 TD Status Byte is %x\n",IO_read(HPI_DATA));

	IO_write(HPI_ADDR,0x0508);
	usb_ctl_val = IO_read(HPI_DATA);
	printf("[ENUM PROCESS]:step 7 TD Control Byte is %x\n",usb_ctl_val);
	while (usb_ctl_val != 0x03)
	{
		usb_ctl_val = UsbGetRetryCnt();
	}

	printf("------------[ENUM PROCESS]:set configuration done!-------------------\n");

	//----------------------------------------------class request out ------------------------------------------//
	// TASK: Call the appropriate function for this step.
	UsbClassRequest();

	while (!(IO_read(HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
	{
		// TASK: Call the appropriate function again if it wasn't processed successfully.
		UsbClassRequest();
		usleep(10*1000);
	}

	UsbWaitTDListDone();

	IO_write(HPI_ADDR,0x0506);
	printf("[ENUM PROCESS]:step 8 TD Status Byte is %x\n",IO_read(HPI_DATA));

	IO_write(HPI_ADDR,0x0508);
	usb_ctl_val = IO_read(HPI_DATA);
	printf("[ENUM PROCESS]:step 8 TD Control Byte is %x\n",usb_ctl_val);
	while (usb_ctl_val != 0x03)
	{
		usb_ctl_val = UsbGetRetryCnt();
	}


	printf("------------[ENUM PROCESS]:class request out done!-------------------\n");

	// STEP 8 begin
	//----------------------------------get descriptor(class 0x21 = HID) request out --------------------------------//
	// TASK: Call the appropriate function for this step.
	UsbGetHidDesc();

	while (!(IO_read(HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
	{
		// TASK: Call the appropriate function again if it wasn't processed successfully.
		UsbGetHidDesc();
		usleep(10*1000);
	}

	UsbWaitTDListDone();

	IO_write(HPI_ADDR,0x0506);
	printf("[ENUM PROCESS]:step 8 TD Status Byte is %x\n",IO_read(HPI_DATA));

	IO_write(HPI_ADDR,0x0508);
	usb_ctl_val = IO_read(HPI_DATA);
	printf("[ENUM PROCESS]:step 8 TD Control Byte is %x\n",usb_ctl_val);
	while (usb_ctl_val != 0x03)
	{
		usb_ctl_val = UsbGetRetryCnt();
	}

	printf("------------[ENUM PROCESS]:get descriptor (class 0x21) done!-------------------\n");

	// STEP 9 begin
	//-------------------------------get descriptor (class 0x22 = report)-------------------------------------------//
	// TASK: Call the appropriate function for this step.
	UsbGetReportDesc();
	//if no message
	while (!(IO_read(HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
	{
		// TASK: Call the appropriate function again if it wasn't processed successfully.
		UsbGetReportDesc();
		usleep(10*1000);
	}

	UsbWaitTDListDone();

	IO_write(HPI_ADDR,0x0506);
	printf("[ENUM PROCESS]: step 9 TD Status Byte is %x\n",IO_read(HPI_DATA));

	IO_write(HPI_ADDR,0x0508);
	usb_ctl_val = IO_read(HPI_DATA);
	printf("[ENUM PROCESS]: step 9 TD Control Byte is %x\n",usb_ctl_val);
	while (usb_ctl_val != 0x03)
	{
		usb_ctl_val = UsbGetRetryCnt();
	}

	printf("---------------[ENUM PROCESS]:get descriptor (class 0x22) done!----------------\n");



	//-----------------------------------get keycode value------------------------------------------------//
	/*HERE
	 *
	 *
	 *
	 *
	 *
	 *
	 *
	 *
	 *
	 *
	 *
	 *
	 *
	 */
	int scene[5][16][21] = 	{
							{
							{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
							{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3},
							{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,6},
							{6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,4},
							{4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,5},
							{5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,3,3,3,3,0,0,0,1,3},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,3},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3},
							{3,3,3,0,0,0,0,0,0,0,0,0,0,3,1,1,1,1,0,0,1,3},
							{3,3,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,1},
							{3,3,0,0,0,0,0,0,1,1,3,0,0,0,0,0,0,0,0,0,1,1},
							{3,3,3,3,3,3,3,1,1,1,3,3,0,0,0,0,0,0,0,0,1,1},
							{3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
							},
							{
							{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
							{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3},
							{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,6},
							{6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,4},
							{4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,5},
							{5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,3,3,3,3,0,0,0,1,3},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,3},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3},
							{3,3,3,0,0,0,0,0,0,0,0,0,0,3,1,1,1,1,0,0,1,3},
							{3,3,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,1},
							{3,3,0,0,0,0,0,0,1,1,3,0,0,0,0,0,0,0,0,0,1,1},
							{3,3,3,3,3,3,3,1,1,1,3,3,0,0,0,0,0,0,0,0,1,1},
							{3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
							},
							{
							{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
							{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3},
							{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,6},
							{6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,4},
							{4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,5},
							{5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,3,3,3,3,0,0,0,1,3},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,3},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3},
							{3,3,3,0,0,0,0,0,0,0,0,0,0,3,1,1,1,1,0,0,1,3},
							{3,3,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,1},
							{3,3,0,0,0,0,0,0,1,1,3,0,0,0,0,0,0,0,0,0,1,1},
							{3,3,3,3,3,3,3,1,1,1,3,3,0,0,0,0,0,0,0,0,1,1},
							{3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
							},
							{
							{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
							{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3},
							{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,6},
							{6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,4},
							{4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,5},
							{5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,3,3,3,3,0,0,0,1,3},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,3},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3},
							{3,3,3,0,0,0,0,0,0,0,0,0,0,3,1,1,1,1,0,0,1,3},
							{3,3,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,1},
							{3,3,0,0,0,0,0,0,1,1,3,0,0,0,0,0,0,0,0,0,1,1},
							{3,3,3,3,3,3,3,1,1,1,3,3,0,0,0,0,0,0,0,0,1,1},
							{3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
							},
							{
							{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
							{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3},
							{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,6},
							{6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,4},
							{4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,5},
							{5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,3,3,3,3,0,0,0,1,3},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,3},
							{3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3},
							{3,3,3,0,0,0,0,0,0,0,0,0,0,3,1,1,1,1,0,0,1,3},
							{3,3,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,1},
							{3,3,0,0,0,0,0,0,1,1,3,0,0,0,0,0,0,0,0,0,1,1},
							{3,3,3,3,3,3,3,1,1,1,3,3,0,0,0,0,0,0,0,0,1,1},
							{3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
							}
							};

	usleep(10000);
	*SAMUS_EN = 1;
	*SAMUS_X = 150;
	*SAMUS_Y = 400;
	int SAMUS_BOT = 70;
	int SAMUS_RIGHT = 35;
	float y_inc = 0;
	float gravity = .8;
	float jump_height = 0;
	float max_jump_height = 80;
	int grounded = False;
	int let_go = False;
	int bulinc = 12;
	int bul1Left = 0;
	int bul1Up = 0;
	int bul1start = 0;
	int bul2Left = 0;
	int bul2Up = 0;
	int bul2start = 0;
	int bul3Left = 0;
	int bul3Up = 0;
	int bul3start = 0;
	int bullet_en = True;
	int sceneNum = 3;
	int sceneStart = True;
	int scenVictory = False;
	int finalVictory = False;
	int scene0_x = 0;
	int scene0_y = 0;
	int scene0_dir = 0;
	int scene1_dir = 0;
	int scene2_dir = 0;
	int scene3_dir = 0;
	int scene4_dir = 0;
	int scene1_x = 0;
	int scene1_y = 0;
	int scene2_x = 0;
	int scene2_y = 0;
	int scene3_x = 10;
	int scene3_y = 110;
	int scene4_x = 0;
	int scene4_y = 0;
	int monster1_1_x_scene3 = 420;
	int monster1_1_y_scene3 = 185;
	int monster1_1_x = 420;
	int monster1_1_y = 185;
	int monster1_1_left = True;
	int monster1_1_health = 3;
	int monster2_1_x_scene3 = 420;
	int monster2_1_y_scene3 = 205;
	int monster2_1_x = 420;
	int monster2_1_y = 205;
	int monster2_1_left = True;
	int monster2_1_health = 3;

	while(1)
	{
		toggle++;
		IO_write(HPI_ADDR,0x0500); //the start address
		//data phase IN-1
		IO_write(HPI_DATA,0x051c); //500

		IO_write(HPI_DATA,0x000f & data_size);//2 data length

		IO_write(HPI_DATA,0x0291);//4 //endpoint 1
		if(toggle%2)
		{
			IO_write(HPI_DATA,0x0001);//6 //data 1
		}
		else
		{
			IO_write(HPI_DATA,0x0041);//6 //data 1
		}
		IO_write(HPI_DATA,0x0013);//8
		IO_write(HPI_DATA,0x0000);//a
		UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr

		while (!(IO_read(HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
		{
			IO_write(HPI_ADDR,0x0500); //the start address
			//data phase IN-1
			IO_write(HPI_DATA,0x051c); //500

			IO_write(HPI_DATA,0x000f & data_size);//2 data length

			IO_write(HPI_DATA,0x0291);//4 //endpoint 1
			if(toggle%2)
			{
				IO_write(HPI_DATA,0x0001);//6 //data 1
			}
			else
			{
				IO_write(HPI_DATA,0x0041);//6 //data 1
			}
			IO_write(HPI_DATA,0x0013);//8
			IO_write(HPI_DATA,0x0000);//
			UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
			usleep(10*1000);
		}//end while



		usb_ctl_val = UsbWaitTDListDone();

		// packet starts from 0x051c, reading third byte
		// TASK: Write the address to read from the memory for byte 3 of the report descriptor to HPI_ADDR.
		IO_write(HPI_ADDR,0x051e); //the start address
		keycode = IO_read(HPI_DATA);
		printf("\nkeycode value is %x\n",keycode);
		IOWR(KEYCODE_BASE, 0, keycode & 0xff);


		usleep(200);//usleep(5000);
		usb_ctl_val = UsbRead(ctl_reg);

		if(!(usb_ctl_val & no_device))
		{
			//USB hot plug routine
			for(hot_plug_count = 0 ; hot_plug_count < 7 ; hot_plug_count++)
			{
				usleep(5*1000);
				usb_ctl_val = UsbRead(ctl_reg);
				if(usb_ctl_val & no_device) break;
			}
			if(!(usb_ctl_val & no_device))
			{
				printf("\n[INFO]: the keyboard has been removed!!! \n");
				printf("[INFO]: please insert again!!! \n");
			}
		}

		while (!(usb_ctl_val & no_device))
		{

			usb_ctl_val = UsbRead(ctl_reg);
			usleep(5*1000);
			usb_ctl_val = UsbRead(ctl_reg);
			usleep(5*1000);
			usb_ctl_val = UsbRead(ctl_reg);
			usleep(5*1000);

			if(usb_ctl_val & no_device)
				goto USB_HOT_PLUG;

			usleep(200);
		}


    // GAME START
	//Scene Init
	if(sceneStart == True){
		if(sceneNum == 3){
			*SAMUS_X = scene3_x;
			*SAMUS_Y = scene3_y;
			*SAMUS_DIR = scene3_dir;
			monster1_1_x = monster1_1_x_scene3;
			monster1_1_y = monster1_1_y_scene3;
			monster1_1_health = 3;
			monster2_1_x = monster2_1_x_scene3;
			monster2_1_y = monster2_1_y_scene3;
			monster2_1_health = 3;
			*MON1_EN = 1;
			*MON2_EN = 1;
		}
		sceneStart = False;
		*EXP1_EN = 0;
		*EXP2_EN = 0;
		*EXP3_EN = 0;
	}


	*HEALTH = 3;
    //SAMUS MOVEMENT
    *SCENE_SELECT = 4;
    *TIT_EN = 0;
    *SCENE_SELECT = 4;
    //Move Right
    if((keycode&0x0000FF)==0x1A || (keycode&0x00FF00)>>8 == 0x1A || (keycode&0xFF0000)>>16 == 0x1A){
    	*SAMUS_UP = 1;
    }
    else{
    	*SAMUS_UP = 0;
    }
    if((keycode&0x0000FF)==7 || (keycode&0x00FF00)>>8 == 7 || (keycode&0xFF0000)>>16 == 7){
    	if(scene[sceneNum][(*SAMUS_Y+10)/30][(*SAMUS_X+40)/30]==0 && scene[sceneNum][(*SAMUS_Y+25)/30][(*SAMUS_X+40)/30]==0 && scene[sceneNum][(*SAMUS_Y+50)/30][(*SAMUS_X+40)/30]==0 && scene[sceneNum][(*SAMUS_Y+70)/30][(*SAMUS_X+40)/30]==0){
    		*SAMUS_DIR = 0;
    		*SAMUS_X+=6;
    		if(grounded == True){
    			*SAMUS_WALK = 1;
    		}
    		else{
    			*SAMUS_WALK = 0;
    		}
    	}
    }
    //Move Left
    else if((keycode&0x0000FF)==4 || (keycode&0x00FF00)>>8 == 4 || (keycode&0xFF0000)>>16 == 4){
    	if(scene[sceneNum][(*SAMUS_Y+15)/30][(*SAMUS_X-3)/30]==0 && scene[sceneNum][(*SAMUS_Y+25)/30][(*SAMUS_X-3)/30]==0 && scene[sceneNum][(*SAMUS_Y+50)/30][(*SAMUS_X-3)/30]==0 && scene[sceneNum][(*SAMUS_Y+70)/30][(*SAMUS_X-3)/30]==0){
    		*SAMUS_DIR = 1;
    		*SAMUS_X-=6;
    		if(grounded == True){
				*SAMUS_WALK = 1;
			}
    		else{
				*SAMUS_WALK = 0;
			}
    	}
    }
    else if(keycode==0x17){
    	*TIT_EN = 1;
    	continue;
    }
    else{
        *SAMUS_WALK = 0;
    }

    // Jump code
    if(grounded == False){
    	*SAMUS_JUMP = 1;
    }
    else{
    	*SAMUS_JUMP = 0;
    }
    if(((keycode&0x0000FF)==0x2c || (keycode&0x00FF00)>>8 == 0x2c || (keycode&0xFF0000)>>16 == 0x2c) && grounded == True && let_go == False){
    	y_inc = -12;
    	grounded = False;
    	let_go = True;
    	jump_height = 0;
    }
    if((((keycode&0x0000FF)!=0x2c && (keycode&0x00FF00)>>8 != 0x2c && (keycode&0xFF0000)>>16 != 0x2c) && let_go == True)){
    	let_go = False;
    }

    if(let_go == False || jump_height >= max_jump_height){
    	if(y_inc < -6){
    		y_inc = -6;
    	}
    	y_inc += gravity;
    	let_go = False;
    }

    if(grounded == True){
    	y_inc = 0;
    }
    if(y_inc > 12){
    	y_inc = 12;
    }

    *SAMUS_Y += y_inc;
    jump_height -= y_inc;

    //bot collision detection
    if((scene[sceneNum][(*SAMUS_Y+80)/30][(*SAMUS_X+2)/30] != 0 || scene[sceneNum][(*SAMUS_Y+80)/30][(*SAMUS_X+33)/30] != 0) && let_go == False){
    	*SAMUS_Y = (*SAMUS_Y/30)*30+19;
    	grounded = True;
    }
    else{
    	grounded = False;
    }

    if(grounded == False){
    	*SAMUS_WALK = 0;
    }

    //If hits head
    if(scene[sceneNum][(*SAMUS_Y+5)/30][(*SAMUS_X+2)/30] != 0 || scene[sceneNum][(*SAMUS_Y+5)/30][(*SAMUS_X+33)/30] != 0){
    	y_inc = -y_inc;
    	let_go = False;
    }


    //Bullet code
    if(!((keycode&0x0000FF)==0x0d || (keycode&0x00FF00)>>8 == 0x0d || (keycode&0xFF0000)>>16 == 0x0d)){
    	bullet_en = True;
    }
    if(((keycode&0x0000FF)==0x0d || (keycode&0x00FF00)>>8 == 0x0d || (keycode&0xFF0000)>>16 == 0x0d) && bullet_en == True){
    	if(*BUL1_EN == True && *BUL2_EN == True && *BUL3_EN == False){
    		if(*SAMUS_DIR == 1){
    			*BUL3_EN = True;
    			*BUL3_X = *SAMUS_X;
    			*BUL3_Y = *SAMUS_Y+25;
    			bul3Left = True;
    		}
    		else{
    			*BUL3_EN = True;
    			*BUL3_X = *SAMUS_X+30;
    			*BUL3_Y = *SAMUS_Y+25;
    			bul3Left = False;
    		}
    		if((keycode&0x0000FF)==0x1A || (keycode&0x00FF00)>>8 == 0x1A || (keycode&0xFF0000)>>16 == 0x1A){
    			bul3Up = True;
    			*BUL3_Y = *SAMUS_Y;
    			*BUL3_X = *SAMUS_X+18;
    		}
    		else{
    			bul3Up = False;
    		}
    		bul3start = 0;
    	}
    	else if(*BUL1_EN == True && *BUL2_EN == False){

			if(*SAMUS_DIR == 1){
				*BUL2_EN = True;
				*BUL2_X = *SAMUS_X;
				*BUL2_Y = *SAMUS_Y+25;
				bul2Left = True;
			}
			else{
				*BUL2_EN = True;
				*BUL2_X = *SAMUS_X+30;
				*BUL2_Y = *SAMUS_Y+25;
				bul2Left = False;
			}

			if((keycode&0x0000FF)==0x1A || (keycode&0x00FF00)>>8 == 0x1A || (keycode&0xFF0000)>>16 == 0x1A){
				bul2Up = True;
				*BUL2_Y = *SAMUS_Y;
				*BUL2_X = *SAMUS_X+18;
			}
			else{
				bul2Up = False;
			}
			bul2start = 0;
		}
    	else if(*BUL1_EN == False){
			if(*SAMUS_DIR == 1){
				*BUL1_EN = True;
				*BUL1_X = *SAMUS_X;
				*BUL1_Y = *SAMUS_Y+25;
				bul1Left = True;
			}
			else{
				*BUL1_EN = True;
				*BUL1_X = *SAMUS_X+30;
				*BUL1_Y = *SAMUS_Y+25;
				bul1Left = False;
			}
			bul1start = 0;
			if((keycode&0x0000FF)==0x1A || (keycode&0x00FF00)>>8 == 0x1A || (keycode&0xFF0000)>>16 == 0x1A){
				bul1Up = True;
				*BUL1_Y = *SAMUS_Y;
				*BUL1_X = *SAMUS_X+18;
			}
			else{
				bul1Up = False;
			}
		}
    	bullet_en = False;
    }
    //Left collisions
    if(*BUL3_EN == True && bul1Up == False && bul3Left == True && (scene[sceneNum][(*BUL3_Y)/30][(*BUL3_X-8)/30]!=0 || scene[sceneNum][(*BUL3_Y+8)/30][(*BUL3_X-8)/30]!=0)){
    	*BUL3_EN = False;
    }
    if(*BUL1_EN == True && bul1Up == False && bul1Left == True && (scene[sceneNum][(*BUL1_Y)/30][(*BUL1_X-8)/30]!=0 || scene[sceneNum][(*BUL1_Y+8)/30][(*BUL1_X-8)/30]!=0)){
		*BUL1_EN = False;
	}
    if(*BUL2_EN == True && bul2Up == False && bul2Left == True && (scene[sceneNum][(*BUL2_Y)/30][(*BUL2_X-8)/30]!=0 || scene[sceneNum][(*BUL2_Y+8)/30][(*BUL2_X-8)/30]!=0)){
		*BUL2_EN = False;
	}
    //Right collisions
    if(*BUL3_EN == True && bul3Up == False && bul3Left == False && (scene[sceneNum][(*BUL3_Y)/30][(*BUL3_X+18)/30]!=0 || scene[sceneNum][(*BUL3_Y+8)/30][(*BUL3_X+18)/30]!=0)){
		*BUL3_EN = False;
	}
	if(*BUL1_EN == True && bul1Up == False && bul1Left == False && (scene[sceneNum][(*BUL1_Y)/30][(*BUL1_X+18)/30]!=0 || scene[sceneNum][(*BUL1_Y+8)/30][((*BUL1_X+18)/30)]!=0)){
		*BUL1_EN = False;
	}
	if(*BUL2_EN == True && bul2Up == False && bul2Left == False && (scene[sceneNum][(*BUL2_Y)/30][(*BUL2_X+18)/30]!=0 || scene[sceneNum][(*BUL2_Y+8)/30][((*BUL2_X+18)/30)]!=0)){
		*BUL2_EN = False;
	}
	//Top collisions
	if(*BUL1_EN == True && bul1Up == True && (scene[sceneNum][(*BUL1_Y-8)/30][(*BUL1_X)/30]!=0 || scene[sceneNum][(*BUL1_Y-8)/30][(*BUL1_X+8)/30]!=0)){
		*BUL1_EN = False;
	}
	if(*BUL2_EN == True && bul2Up == True && (scene[sceneNum][(*BUL2_Y-8)/30][(*BUL2_X)/30]!=0 || scene[sceneNum][(*BUL2_Y-8)/30][(*BUL2_X+8)/30]!=0)){
		*BUL2_EN = False;
	}
	if(*BUL3_EN == True && bul3Up == True && (scene[sceneNum][(*BUL3_Y-8)/30][(*BUL3_X)/30]!=0 || scene[sceneNum][(*BUL3_Y-8)/30][(*BUL3_X+8)/30]!=0)){
		*BUL3_EN = False;
	}

    if(*BUL3_EN == True){
    	if(bul3start >= 110)
    		*BUL3_EN = False;
    	else{
    		if(bul3Up == True){
    			*BUL3_Y -= bulinc;
    		}
    		else if(bul3Left == True){
    			*BUL3_X -= bulinc;
    		}
    		else{
    			*BUL3_X += bulinc;
    		}
    		bul3start += bulinc;
    	}
    }
    if(*BUL2_EN == True){
		if(bul2start >= 110)
			*BUL2_EN = False;
		else{
			if(bul2Up == True){
				*BUL2_Y -= bulinc;
			}
			else if(bul2Left == True){
				*BUL2_X -= bulinc;
			}
			else{
				*BUL2_X += bulinc;
			}
			bul2start += bulinc;
		}
	}
    if(*BUL1_EN == True){
		if(bul1start >= 110)
			*BUL1_EN = False;
		else{
			if(bul1Up == True){
				*BUL1_Y -= bulinc;
			}
			else if(bul1Left == True){
				*BUL1_X -= bulinc;
			}
			else{
				*BUL1_X += bulinc;
			}
			bul1start += bulinc;
		}
	}


    //monsters code
    *MON1_X = monster1_1_x;
    *MON1_Y = monster1_1_y;
    if(*MON1_EN == True){
		if(monster1_1_left == True){
			monster1_1_x-=5;
		}
		else{
			monster1_1_x+=5;
		}
    }

    if(scene[sceneNum][(monster1_1_y+35)/30][monster1_1_x/30]==0){
    	monster1_1_left = False;
    }
    else if(scene[sceneNum][(monster1_1_y+35)/30][(monster1_1_x+30)/30]==0){
    	monster1_1_left = True;
    }
    //Monster 2
    *MON2_X = monster2_1_x;
	*MON2_Y = monster2_1_y;
	if(*MON2_EN == True){
		if(monster2_1_left == True){
			monster2_1_x-=5;
		}
		else{
			monster2_1_x+=5;
		}
	}

	if(scene[sceneNum][(monster1_1_y+35)/30][monster1_1_x/30]==0){
		monster1_1_left = False;
	}
	else if(scene[sceneNum][(monster1_1_y+35)/30][(monster1_1_x+30)/30]==0){
		monster1_1_left = True;
	}


    //bullet collision with monsters
    if(*BUL1_X+12 > monster1_1_x && *BUL1_X < monster1_1_x+30 && *BUL1_Y+12 > monster1_1_y && *BUL1_Y < monster1_1_y+30 && *MON1_EN == True && *BUL1_EN == 1){
    	*BUL1_EN=0;
    	monster1_1_health-=1;
    }
    if(*BUL2_X+12 > monster1_1_x && *BUL2_X < monster1_1_x+30 && *BUL2_Y+12 > monster1_1_y && *BUL2_Y < monster1_1_y+30 && *MON1_EN == True && *BUL2_EN == 1){
       	*BUL2_EN=0;
       	monster1_1_health-=1;
    }
    if(*BUL3_X+12 > monster1_1_x && *BUL3_X < monster1_1_x+30 && *BUL3_Y+12 > monster1_1_y && *BUL3_Y < monster1_1_y+30 && *MON1_EN == True && *BUL3_EN == 1){
       	*BUL3_EN=0;
       	monster1_1_health-=1;
    }
    if(*BUL1_X+12 > monster2_1_x && *BUL1_X < monster2_1_x+30 && *BUL1_Y+12 > monster2_1_y && *BUL1_Y < monster2_1_y+30 && *MON2_EN == True && *BUL1_EN == 1){
		*BUL1_EN=0;
		monster2_1_health-=1;
	}
	if(*BUL2_X+12 > monster2_1_x && *BUL2_X < monster2_1_x+30 && *BUL2_Y+12 > monster2_1_y && *BUL2_Y < monster2_1_y+30 && *MON2_EN == True && *BUL2_EN == 1){
		*BUL2_EN=0;
		monster2_1_health-=1;
	}
	if(*BUL3_X+12 > monster2_1_x && *BUL3_X < monster2_1_x+30 && *BUL3_Y+12 > monster2_1_y && *BUL3_Y < monster2_1_y+30 && *MON2_EN == True && *BUL3_EN == 1){
		*BUL3_EN=0;
		monster2_1_health-=1;
	}

    if(monster1_1_health == 0){
    	*MON1_EN = 0;
    	*EXP1_X = monster1_1_x;
    	*EXP1_Y = monster1_1_y;
    	*EXP1_EN = 1;
    }
    if(monster2_1_health == 0){
    	*MON2_EN = 0;
    	*EXP2_X = monster2_1_x;
    	*EXP2_Y = monster2_1_y;
    	*EXP2_EN = 1;
    }

    //EXTRA
    //debugging reset
    if (keycode == 0x15){
    	sceneStart = True;
    }

	}//end while

	return 0;
}

