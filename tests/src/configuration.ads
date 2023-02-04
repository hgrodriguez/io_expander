with HAL; use HAL;

with RP.Device;
with RP.GPIO;
with RP.I2C_Master;
with RP.UART;

with Pico;

package Configuration is

   subtype Byte is HAL.UInt8;

   SDA_LED        : RP.GPIO.GPIO_Point renames Pico.GP14;
   SCL_LED        : RP.GPIO.GPIO_Point renames Pico.GP15;
   Port_LED       : RP.I2C_Master.I2C_Master_Port renames RP.Device.I2CM_1;

   RESET_EXPANDER   : RP.GPIO.GPIO_Point renames Pico.GP1;
   SDA_EXPANDER     : RP.GPIO.GPIO_Point renames Pico.GP8;
   SCL_EXPANDER     : RP.GPIO.GPIO_Point renames Pico.GP9;
   Port_EXPANDER    : RP.I2C_Master.I2C_Master_Port renames RP.Device.I2CM_0;
   Address_EXPANDER : constant HAL.UInt3 :=  2#000# * 2;

   --------------------------------------------------------------------------
   --  Definitions of the UART ports to use for the communication with EDC
   --------------------------------------------------------------------------
   UART    : RP.UART.UART_Port renames RP.Device.UART_0;
   UART_TX : RP.GPIO.GPIO_Point renames Pico.GP12;
   UART_RX : RP.GPIO.GPIO_Point renames Pico.GP13;

   --------------------------------------------------------------------------
   --  WIRING of the test bed
   IOEXP_Pin_7      : RP.GPIO.GPIO_Point renames Pico.GP16;
   IOEXP_Pin_6      : RP.GPIO.GPIO_Point renames Pico.GP17;
   IOEXP_Pin_5      : RP.GPIO.GPIO_Point renames Pico.GP18;
   IOEXP_Pin_4      : RP.GPIO.GPIO_Point renames Pico.GP19;
   IOEXP_Pin_3      : RP.GPIO.GPIO_Point renames Pico.GP20;
   IOEXP_Pin_2      : RP.GPIO.GPIO_Point renames Pico.GP21;
   IOEXP_Pin_1      : RP.GPIO.GPIO_Point renames Pico.GP22;
   IOEXP_Pin_0      : RP.GPIO.GPIO_Point renames Pico.GP26;

end Configuration;
