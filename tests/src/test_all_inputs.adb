with Ada.Unchecked_Conversion;

with HAL; use HAL;

with RP.GPIO;

with MCP23x08;
with MCP23008;

with Configuration;

package body Test_All_Inputs is

   type GPIO_Pin is (Pin_0, Pin_1, Pin_2, Pin_3,
                     Pin_4, Pin_5, Pin_6, Pin_7);
   type ALL_GPIO_Array is array (GPIO_Pin) of Boolean
     with Pack, Size => 8;

   function To_UInt8 is
     new Ada.Unchecked_Conversion (Source => MCP23x08.ALl_IO_Array,
                                   Target => Configuration.Byte);

   function To_All_GPIO_Array is
     new Ada.Unchecked_Conversion (Source => Configuration.Byte,
                                   Target => ALL_GPIO_Array);

   procedure Set_All_Outputs (Number : Configuration.Byte);
   procedure Initialize;

   My_Expander      : MCP23008.MCP23008_IO_Expander
     (Port => Configuration.Port_EXPANDER'Access,
      Addr  => Configuration.Address_EXPANDER);

   function Check return Boolean is
      Check_Result : MCP23x08.ALl_IO_Array;
      Check_Number : Configuration.Byte;
   begin
      Initialize;
      for I in Configuration.Byte'Range loop
         Set_All_Outputs (I);
         Check_Result := My_Expander.All_IO;
         Check_Number := To_UInt8 (Check_Result);
         if (I and Check_Number) /= I then
            return False;
         end if;
      end loop;
      return True;
   end Check;

   procedure Initialize is
   begin
      My_Expander.Configure (Pin     => MCP23x08.Pin_0,
                             Output  => False,
                             Pull_Up => False);
      My_Expander.Configure (Pin     => MCP23x08.Pin_1,
                             Output  => False,
                             Pull_Up => False);
      My_Expander.Configure (Pin     => MCP23x08.Pin_2,
                             Output  => False,
                             Pull_Up => False);
      My_Expander.Configure (Pin     => MCP23x08.Pin_3,
                             Output  => False,
                             Pull_Up => False);
      My_Expander.Configure (Pin     => MCP23x08.Pin_4,
                             Output  => False,
                             Pull_Up => False);
      My_Expander.Configure (Pin     => MCP23x08.Pin_5,
                             Output  => False,
                             Pull_Up => False);
      My_Expander.Configure (Pin     => MCP23x08.Pin_6,
                             Output  => False,
                             Pull_Up => False);
      My_Expander.Configure (Pin     => MCP23x08.Pin_7,
                             Output  => False,
                             Pull_Up => False);

      --
      Configuration.IOEXP_Pin_0.Configure (RP.GPIO.Output,
                                           RP.GPIO.Pull_Up,
                                           RP.GPIO.SIO,
                                           Schmitt => True);
      Configuration.IOEXP_Pin_1.Configure (RP.GPIO.Output,
                                           RP.GPIO.Pull_Up,
                                           RP.GPIO.SIO,
                                           Schmitt => True);
      Configuration.IOEXP_Pin_2.Configure (RP.GPIO.Output,
                                           RP.GPIO.Pull_Up,
                                           RP.GPIO.SIO,
                                           Schmitt => True);
      Configuration.IOEXP_Pin_3.Configure (RP.GPIO.Output,
                                           RP.GPIO.Pull_Up,
                                           RP.GPIO.SIO,
                                           Schmitt => True);
      Configuration.IOEXP_Pin_4.Configure (RP.GPIO.Output,
                                           RP.GPIO.Pull_Up,
                                           RP.GPIO.SIO,
                                           Schmitt => True);
      Configuration.IOEXP_Pin_5.Configure (RP.GPIO.Output,
                                           RP.GPIO.Pull_Up,
                                           RP.GPIO.SIO,
                                           Schmitt => True);
      Configuration.IOEXP_Pin_6.Configure (RP.GPIO.Output,
                                           RP.GPIO.Pull_Up,
                                           RP.GPIO.SIO,
                                           Schmitt => True);
      Configuration.IOEXP_Pin_7.Configure (RP.GPIO.Output,
                                           RP.GPIO.Pull_Up,
                                           RP.GPIO.SIO,
                                           Schmitt => True);

   end Initialize;

   procedure Set_All_Outputs (Number : Configuration.Byte) is
      All_Outputs : constant ALL_GPIO_Array := To_All_GPIO_Array (Number);
   begin
      if All_Outputs (Pin_0) then
         Configuration.IOEXP_Pin_0.Set;
      else
         Configuration.IOEXP_Pin_0.Clear;
      end if;
      if All_Outputs (Pin_1) then
         Configuration.IOEXP_Pin_1.Set;
      else
         Configuration.IOEXP_Pin_1.Clear;
      end if;
      if All_Outputs (Pin_2) then
         Configuration.IOEXP_Pin_2.Set;
      else
         Configuration.IOEXP_Pin_2.Clear;
      end if;
      if All_Outputs (Pin_3) then
         Configuration.IOEXP_Pin_3.Set;
      else
         Configuration.IOEXP_Pin_3.Clear;
      end if;
      if All_Outputs (Pin_4) then
         Configuration.IOEXP_Pin_4.Set;
      else
         Configuration.IOEXP_Pin_4.Clear;
      end if;
      if All_Outputs (Pin_5) then
         Configuration.IOEXP_Pin_5.Set;
      else
         Configuration.IOEXP_Pin_5.Clear;
      end if;
      if All_Outputs (Pin_6) then
         Configuration.IOEXP_Pin_6.Set;
      else
         Configuration.IOEXP_Pin_6.Clear;
      end if;
      if All_Outputs (Pin_7) then
         Configuration.IOEXP_Pin_7.Set;
      else
         Configuration.IOEXP_Pin_7.Clear;
      end if;
   end Set_All_Outputs;

end Test_All_Inputs;
