#include <stdio.h>
#include "XMC4800.h"
#include "xmc4_gpio_map.h"
#include "xmc_gpio.h"
#include "xmc_uart.h"


#include "serial.h"

#define LED1 P4_0

__STATIC_FORCEINLINE void delay(uint32_t cycles)
{
  while(--cycles > 0)
  {
    __NOP();
  }
}

void XMC_AssertHandler(const char *const msg, const char *const file, uint32_t line)
{
  printf("%s at line %u of %s\n", msg, (unsigned int)line, file);
  while(1);
}


int main(void)
{
  CONSOLE_IO_Init();

  XMC_GPIO_SetMode(LED1, XMC_GPIO_MODE_OUTPUT_PUSH_PULL);

  while(true) {
    XMC_GPIO_ToggleOutput(LED1);
    delay(10000000);

    char buf[9] = "toggle\r\n";
    for (int i = 0; i < 9; i++) {
      XMC_UART_CH_Transmit(CONSOLE_IO_UART_CH,  buf[i]);
    }
  }
}
