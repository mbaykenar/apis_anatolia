/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

/************************** Library Definitions *****************************/
#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "xgpio.h"
#include "xil_exception.h"
#include "xintc.h"

/************************** Constant Definitions *****************************/
#define GPIO_DEVICE_ID			XPAR_GPIO_0_DEVICE_ID
#define INTC_GPIO_INTERRUPT_ID	XPAR_INTC_0_GPIO_0_VEC_ID
#define INTC_DEVICE_ID			XPAR_INTC_0_DEVICE_ID
#define BUTTON_CHANNEL	 		1	/* Channel 1 of the GPIO Device */
#define LED_CHANNEL	 			2	/* Channel 2 of the GPIO Device */
#define INTC_HANDLER			XIntc_InterruptHandler

/************************** Variable Definitions *****************************/
XGpio Gpio; /* The Instance of the GPIO Driver */
XIntc Intc; /* The Instance of the Interrupt Controller Driver */
static volatile u32 IntrFlag; /* Interrupt Handler Flag */

/************************** Function Definitions *****************************/
void GpioHandler(void *CallBackRef);

int main()
{
    init_platform();
    int Status;
	u32 switches_val = 0;

	/* Initialize the GPIO driver. If an error occurs then exit */
	Status = XGpio_Initialize(&Gpio, GPIO_DEVICE_ID);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/* Set channels data direction for GPIO, if it is input or output */
	XGpio_SetDataDirection(&Gpio,1,0xFFFF);	// ch1 switches
	XGpio_SetDataDirection(&Gpio,2,0x0000);	// ch2 leds

	/*
	 * Enable the GPIO channel interrupts so that push button can be
	 * detected and enable interrupts for the GPIO device
	 */
	XGpio_InterruptEnable(&Gpio, BUTTON_CHANNEL);
	XGpio_InterruptGlobalEnable(&Gpio);

	/*
	 * Initialize the interrupt controller driver so that it's ready to use.
	 * specify the device ID that was generated in xparameters.h
	 */
	Status = XIntc_Initialize(&Intc, INTC_DEVICE_ID);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/* Hook up interrupt service routine */
	XIntc_Connect(&Intc, INTC_GPIO_INTERRUPT_ID,
		      //(Xil_ExceptionHandler)GpioHandler, &Gpio);
			(XInterruptHandler)GpioHandler, &Gpio);

	/* Enable the interrupt vector at the interrupt controller */
	XIntc_Enable(&Intc, INTC_GPIO_INTERRUPT_ID);

	/*
	 * Start the interrupt controller such that interrupts are recognized
	 * and handled by the processor
	 */
	Status = XIntc_Start(&Intc, XIN_REAL_MODE);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Initialize the exception table and register the interrupt
	 * controller handler with the exception table
	 */
	Xil_ExceptionInit();

	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
			 (Xil_ExceptionHandler)INTC_HANDLER, &Intc);



	/* Enable non-critical exceptions */
	Xil_ExceptionEnable();

	// infinite loop
	for (;;)
	{
		if (IntrFlag == 1)
		{
			IntrFlag = 0;
			switches_val = XGpio_DiscreteRead(&Gpio,BUTTON_CHANNEL);
			XGpio_DiscreteWrite(&Gpio,LED_CHANNEL,switches_val);

		}
	}


    cleanup_platform();
    return 0;
}

/******************************************************************************/
/**
*
* This is the interrupt handler routine for the GPIO for this example.
*
* @param	CallbackRef is the Callback reference for the handler.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void GpioHandler(void *CallBackRef)
{
	XGpio *GpioPtr = (XGpio *)CallBackRef;

	IntrFlag = 1;

	/* Clear the Interrupt */
	XGpio_InterruptClear(GpioPtr, BUTTON_CHANNEL);
}
