;/**************************************************************************//**
; * @file     startup_ARMSC300.s
; * @brief    CMSIS Core Device Startup File for
; *           for ARMSC300 Device Series
; * @version  V1.08
; * @date     23. November 2012
; *
; * @note
; *
; ******************************************************************************/
;/* Copyright (c) 2011 - 2012 ARM LIMITED
;
;   All rights reserved.
;   Redistribution and use in source and binary forms, with or without
;   modification, are permitted provided that the following conditions are met:
;   - Redistributions of source code must retain the above copyright
;     notice, this list of conditions and the following disclaimer.
;   - Redistributions in binary form must reproduce the above copyright
;     notice, this list of conditions and the following disclaimer in the
;     documentation and/or other materials provided with the distribution.
;   - Neither the name of ARM nor the names of its contributors may be used
;     to endorse or promote products derived from this software without
;     specific prior written permission.
;   *
;   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;   ARE DISCLAIMED. IN NO EVENT SHALL COPYRIGHT HOLDERS AND CONTRIBUTORS BE
;   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;   POSSIBILITY OF SUCH DAMAGE.
;   ---------------------------------------------------------------------------*/


;
; The modules in this file are included in the libraries, and may be replaced
; by any user-defined modules that define the PUBLIC symbol _program_start or
; a user defined start symbol.
; To override the cstartup defined in the library, simply add your modified
; version to the workbench project.
;
; The vector table is normally located at address 0.
; When debugging in RAM, it can be located in RAM, aligned to at least 2^6.
; The name "__vector_table" has special meaning for C-SPY:
; it is where the SP start value is found, and the NVIC vector
; table register (VTOR) is initialized to this address if != 0.
;
; Cortex-M version
;

        MODULE  ?cstartup

        ;; Forward declaration of sections.
        SECTION CSTACK:DATA:NOROOT(3)

        SECTION .intvec:CODE:NOROOT(2)

        EXTERN  __iar_program_start
        EXTERN  SystemInit
        PUBLIC  __vector_table
        PUBLIC  __vector_table_0x1c
        PUBLIC  __Vectors
        PUBLIC  __Vectors_End
        PUBLIC  __Vectors_Size

        DATA

__vector_table
        DCD     sfe(CSTACK)
        DCD     Reset_Handler

        DCD     NMI_Handler
        DCD     HardFault_Handler
        DCD     MemManage_Handler
        DCD     BusFault_Handler
        DCD     UsageFault_Handler
__vector_table_0x1c
        DCD     0
        DCD     0
        DCD     0
        DCD     0
        DCD     SVC_Handler
        DCD     DebugMon_Handler
        DCD     0
        DCD     PendSV_Handler
        DCD     SysTick_Handler

        ; External Interrupts
        DCD     WDT_IRQHandler            ;  0:  Watchdog Timer
        DCD     RTC_IRQHandler            ;  1:  Real Time Clock
        DCD     TIM0_IRQHandler           ;  2:  Timer0 / Timer1
        DCD     TIM2_IRQHandler           ;  3:  Timer2 / Timer3
        DCD     MCIA_IRQHandler           ;  4:  MCIa
        DCD     MCIB_IRQHandler           ;  5:  MCIb
        DCD     UART0_IRQHandler          ;  6:  UART0 - DUT FPGA
        DCD     UART1_IRQHandler          ;  7:  UART1 - DUT FPGA
        DCD     UART2_IRQHandler          ;  8:  UART2 - DUT FPGA
        DCD     UART4_IRQHandler          ;  9:  UART4 - not connected
        DCD     AACI_IRQHandler           ; 10: AACI / AC97
        DCD     CLCD_IRQHandler           ; 11: CLCD Combined Interrupt
        DCD     ENET_IRQHandler           ; 12: Ethernet
        DCD     USBDC_IRQHandler          ; 13: USB Device
        DCD     USBHC_IRQHandler          ; 14: USB Host Controller
        DCD     CHLCD_IRQHandler          ; 15: Character LCD
        DCD     FLEXRAY_IRQHandler        ; 16: Flexray
        DCD     CAN_IRQHandler            ; 17: CAN
        DCD     LIN_IRQHandler            ; 18: LIN
        DCD     I2C_IRQHandler            ; 19: I2C ADC/DAC
        DCD     0                         ; 20: Reserved
        DCD     0                         ; 21: Reserved
        DCD     0                         ; 22: Reserved
        DCD     0                         ; 23: Reserved
        DCD     0                         ; 24: Reserved
        DCD     0                         ; 25: Reserved
        DCD     0                         ; 26: Reserved
        DCD     0                         ; 27: Reserved
        DCD     CPU_CLCD_IRQHandler       ; 28: Reserved - CPU FPGA CLCD
        DCD     0                         ; 29: Reserved - CPU FPGA
        DCD     UART3_IRQHandler          ; 30: UART3    - CPU FPGA
        DCD     SPI_IRQHandler            ; 31: SPI Touchscreen - CPU FPGA
__Vectors_End

__Vectors       EQU   __vector_table
__Vectors_Size  EQU   __Vectors_End - __Vectors


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Default interrupt handlers.
;;
        THUMB

        PUBWEAK Reset_Handler
        SECTION .text:CODE:REORDER(2)
Reset_Handler
        LDR     R0, =SystemInit
        BLX     R0
        LDR     R0, =__iar_program_start
        BX      R0

        PUBWEAK NMI_Handler
        SECTION .text:CODE:REORDER(1)
NMI_Handler
        B NMI_Handler

        PUBWEAK HardFault_Handler
        SECTION .text:CODE:REORDER(1)
HardFault_Handler
        B HardFault_Handler

        PUBWEAK MemManage_Handler
        SECTION .text:CODE:REORDER(1)
MemManage_Handler
        B MemManage_Handler

        PUBWEAK BusFault_Handler
        SECTION .text:CODE:REORDER(1)
BusFault_Handler
        B BusFault_Handler

        PUBWEAK UsageFault_Handler
        SECTION .text:CODE:REORDER(1)
UsageFault_Handler
        B UsageFault_Handler

        PUBWEAK SVC_Handler
        SECTION .text:CODE:REORDER(1)
SVC_Handler
        B SVC_Handler

        PUBWEAK DebugMon_Handler
        SECTION .text:CODE:REORDER(1)
DebugMon_Handler
        B DebugMon_Handler

        PUBWEAK PendSV_Handler
        SECTION .text:CODE:REORDER(1)
PendSV_Handler
        B PendSV_Handler

        PUBWEAK SysTick_Handler
        SECTION .text:CODE:REORDER(1)
SysTick_Handler
        B SysTick_Handler

        PUBWEAK WDT_IRQHandler
        SECTION .text:CODE:REORDER(1)
WDT_IRQHandler
        B WDT_IRQHandler

        PUBWEAK RTC_IRQHandler
        SECTION .text:CODE:REORDER(1)
RTC_IRQHandler
        B RTC_IRQHandler

        PUBWEAK TIM0_IRQHandler
        SECTION .text:CODE:REORDER(1)
TIM0_IRQHandler
        B TIM0_IRQHandler

        PUBWEAK TIM2_IRQHandler
        SECTION .text:CODE:REORDER(1)
TIM2_IRQHandler
        B TIM2_IRQHandler

        PUBWEAK MCIA_IRQHandler
        SECTION .text:CODE:REORDER(1)
MCIA_IRQHandler
        B MCIA_IRQHandler

        PUBWEAK MCIB_IRQHandler
        SECTION .text:CODE:REORDER(1)
MCIB_IRQHandler
        B MCIB_IRQHandler

        PUBWEAK UART0_IRQHandler
        SECTION .text:CODE:REORDER(1)
UART0_IRQHandler
        B UART0_IRQHandler

        PUBWEAK UART1_IRQHandler
        SECTION .text:CODE:REORDER(1)
UART1_IRQHandler
        B UART1_IRQHandler

        PUBWEAK UART2_IRQHandler
        SECTION .text:CODE:REORDER(1)
UART2_IRQHandler
        B UART2_IRQHandler

        PUBWEAK UART4_IRQHandler
        SECTION .text:CODE:REORDER(1)
UART4_IRQHandler
        B UART4_IRQHandler

        PUBWEAK AACI_IRQHandler
        SECTION .text:CODE:REORDER(1)
AACI_IRQHandler
        B AACI_IRQHandler

        PUBWEAK CLCD_IRQHandler
        SECTION .text:CODE:REORDER(1)
CLCD_IRQHandler
        B CLCD_IRQHandler

        PUBWEAK ENET_IRQHandler
        SECTION .text:CODE:REORDER(1)
ENET_IRQHandler
        B ENET_IRQHandler

        PUBWEAK USBDC_IRQHandler
        SECTION .text:CODE:REORDER(1)
USBDC_IRQHandler
        B USBDC_IRQHandler

        PUBWEAK USBHC_IRQHandler
        SECTION .text:CODE:REORDER(1)
USBHC_IRQHandler
        B USBHC_IRQHandler

        PUBWEAK CHLCD_IRQHandler
        SECTION .text:CODE:REORDER(1)
CHLCD_IRQHandler
        B CHLCD_IRQHandler

        PUBWEAK FLEXRAY_IRQHandler
        SECTION .text:CODE:REORDER(1)
FLEXRAY_IRQHandler
        B FLEXRAY_IRQHandler

        PUBWEAK CAN_IRQHandler
        SECTION .text:CODE:REORDER(1)
CAN_IRQHandler
        B CAN_IRQHandler

        PUBWEAK LIN_IRQHandler
        SECTION .text:CODE:REORDER(1)
LIN_IRQHandler
        B LIN_IRQHandler

        PUBWEAK I2C_IRQHandler
        SECTION .text:CODE:REORDER(1)
I2C_IRQHandler
        B I2C_IRQHandler

        PUBWEAK CPU_CLCD_IRQHandler
        SECTION .text:CODE:REORDER(1)
CPU_CLCD_IRQHandler
        B CPU_CLCD_IRQHandler

        PUBWEAK UART3_IRQHandler
        SECTION .text:CODE:REORDER(1)
UART3_IRQHandler
        B UART3_IRQHandler

        PUBWEAK SPI_IRQHandler
        SECTION .text:CODE:REORDER(1)
SPI_IRQHandler
        B SPI_IRQHandler

        END
