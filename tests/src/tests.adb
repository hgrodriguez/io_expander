with Ada.Unchecked_Conversion;

with RP.Clock;
with RP.Device;
with RP.GPIO; use RP.GPIO;
with RP.I2C_Master;

with Pico;

with Configuration;

with Edc_Client;
with Edc_Client.LED;
with Edc_Client.Matrix.Word;

with Transmitter.UART.Pico;

with Test_All_Outputs;
with Test_All_Inputs;
--  with Test_Shift_1Bit_Output;

procedure Tests is

   procedure Reset_Status;
   procedure Reset_Status is
   begin
      Edc_Client.LED.Green_Off;

      Edc_Client.LED.Red_Off;
   end Reset_Status;

   procedure Display_Failure;
   procedure Display_Failure is
   begin
      Edc_Client.LED.Green_Off;

      Edc_Client.LED.Red_On;
   end Display_Failure;

   procedure Display_Success;
   procedure Display_Success is
   begin
      Edc_Client.LED.Red_Off;

      Edc_Client.LED.Green_On;
   end Display_Success;

   procedure UART_Initialize;
   procedure UART_Initialize is
   begin
      Configuration.UART_TX.Configure (RP.GPIO.Output,
                                       RP.GPIO.Pull_Up,
                                       RP.GPIO.UART);
      Configuration.UART_RX.Configure (RP.GPIO.Input,
                                       RP.GPIO.Floating,
                                       RP.GPIO.UART);
      Configuration.UART.Configure
        (Config =>
           (Baud      => Edc_Client.SERIAL_BAUD_RATE,
            Word_Size => 8,
            Parity    => False,
            Stop_Bits => 1,
            others    => <>));
   end UART_Initialize;

begin
   RP.Clock.Initialize (Pico.XOSC_Frequency);
   RP.Clock.Enable (RP.Clock.PERI);
   RP.Device.Timer.Enable;
   RP.GPIO.Enable;

   Configuration.SDA_LED.Configure (RP.GPIO.Output,
                      RP.GPIO.Pull_Up,
                      RP.GPIO.I2C,
                      Schmitt => True);
   Configuration.SCL_LED.Configure (RP.GPIO.Output,
                      RP.GPIO.Pull_Up,
                      RP.GPIO.I2C,
                      Schmitt => True);
   Configuration.Port_LED.Configure (400_000);

   UART_Initialize;

   Configuration.RESET_EXPANDER.Configure (RP.GPIO.Output,
                           RP.GPIO.Pull_Up,
                           RP.GPIO.SIO,
                             Schmitt => True);
   Configuration.RESET_EXPANDER.Set;

   Configuration.SDA_EXPANDER.Configure (RP.GPIO.Output,
                      RP.GPIO.Pull_Up,
                      RP.GPIO.I2C,
                      Schmitt => True);
   Configuration.SCL_EXPANDER.Configure (RP.GPIO.Output,
                      RP.GPIO.Pull_Up,
                      RP.GPIO.I2C,
                      Schmitt => True);
   Configuration.Port_EXPANDER.Configure (400_000);

   Edc_Client.Initialize (T => Transmitter.UART.Pico.Transmit_Control'Access);

   Reset_Status;

   Edc_Client.Matrix.Word.Show_LSB (Value => 1);
   Reset_Status;
   if Test_All_Outputs.Check then
      Display_Success;
   else
      Display_Failure;
   end if;

   Edc_Client.Matrix.Word.Show_LSB (Value => 2);
   Reset_Status;
   if Test_All_Inputs.Check_Non_Inverted then
      Display_Success;
   else
      Display_Failure;
   end if;

   Edc_Client.Matrix.Word.Show_LSB (Value => 3);
   Reset_Status;
   if Test_All_Inputs.Check_Inverted then
      Display_Success;
   else
      Display_Failure;
   end if;

   --     LED_Matrix.Show_Hex (Number => 3);
--     Reset_Status;
--     if Test_Shift_1Bit_Output.Check then
--        Display_Success;
--     else
--        Display_Failure;
--     end if;
end Tests;
