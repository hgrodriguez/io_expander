with Ada.Unchecked_Conversion;

with RP.GPIO; use RP.GPIO;
with RP.I2C_Master;
with RP.Device;
with RP.Clock;
with Pico;

with LTP_305;

with Configuration;
with LED_Matrix;

with Test_All_Outputs;
with Test_All_Inputs;

procedure Tests is

   procedure Reset_Status;
   procedure Reset_Status is
   begin
      Configuration.LED_GREEN.Clear;
      Configuration.LED_RED.Clear;
   end Reset_Status;

   procedure Display_Failure;
   procedure Display_Failure is
   begin
      Configuration.LED_GREEN.Clear;
      Configuration.LED_RED.Set;
   end Display_Failure;

   procedure Display_Success;
   procedure Display_Success is
   begin
      Configuration.LED_RED.Clear;
      Configuration.LED_GREEN.Set;
   end Display_Success;

begin
   RP.Clock.Initialize (Pico.XOSC_Frequency);
   RP.Device.Timer.Enable;

   Configuration.SDA_LED.Configure (RP.GPIO.Output,
                      RP.GPIO.Pull_Up,
                      RP.GPIO.I2C,
                      Schmitt => True);
   Configuration.SCL_LED.Configure (RP.GPIO.Output,
                      RP.GPIO.Pull_Up,
                      RP.GPIO.I2C,
                      Schmitt => True);
   Configuration.Port_LED.Configure (400_000);

   LTP_305.Initialize (This    => Configuration.Port_LED'Access,
                       Address => Configuration.Address_LED);

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

   Configuration.LED_RED.Configure (RP.GPIO.Output,
                                         RP.GPIO.Pull_Down,
                                         RP.GPIO.SIO,
                                         Schmitt => True);
   Configuration.LED_GREEN.Configure (RP.GPIO.Output,
                                         RP.GPIO.Pull_Down,
                                         RP.GPIO.SIO,
                                         Schmitt => True);

   LED_Matrix.Show_Hex (Number => 1);
   Reset_Status;
   if Test_All_Outputs.Check then
      Display_Success;
   else
      Display_Failure;
   end if;

   LED_Matrix.Show_Hex (Number => 2);
   Reset_Status;
   if Test_All_Inputs.Check then
      Display_Success;
   else
      Display_Failure;
   end if;

end Tests;
