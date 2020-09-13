/*
 * Copyright (C) 2018 Infineon Technologies AG. All rights reserved.
 *
 * Infineon Technologies AG (Infineon) is supplying this software for use with
 * Infineon's microcontrollers.
 * This file can be freely distributed within development tools that are
 * supporting such microcontrollers.
 *
 * THIS SOFTWARE IS PROVIDED "AS IS". NO WARRANTIES, WHETHER EXPRESS, IMPLIED
 * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
 * INFINEON SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL,
 * OR CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
 *
 */

#ifndef CONSOLE_IO_H
#define CONSOLE_IO_H

#ifdef __cplusplus
extern "C" {
#endif

#define CONSOLE_IO_UART_BAUDRATE 115200
#define CONSOLE_IO_UART_CH XMC_UART1_CH1
#define CONSOLE_IO_UART_TX_PIN P0_1
#define CONSOLE_IO_UART_TX_PIN_AF P0_1_AF_U1C1_DOUT0
#define CONSOLE_IO_UART_RX_PIN P0_0
#define CONSOLE_IO_UART_INPUT USIC1_C1_DX0_P0_0

/**
 *
 */
void CONSOLE_IO_Init(void);

#ifdef __cplusplus
}
#endif

#endif
