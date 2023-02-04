with Ada.Unchecked_Conversion;

with HAL; use HAL;

with RP.GPIO;
with RP.Timer.Interrupts;

with MCP23x08;
with MCP23008;

with Configuration;

package body Test_All_Outputs is

   type GPIO_Pin is (Pin_0, Pin_1, Pin_2, Pin_3,
                         Pin_4, Pin_5, Pin_6, Pin_7);
   type ALL_GPIO_Array is array (GPIO_Pin) of Boolean
     with Pack, Size => 8;

   My_Expander      : MCP23008.MCP23008_IO_Expander
     (Port => Configuration.Port_EXPANDER'Access,
      Addr  => Configuration.Address_EXPANDER);

   function To_All_IO_Array is
     new Ada.Unchecked_Conversion (Source => Configuration.Byte,
                                   Target => MCP23x08.ALl_IO_Array);

   function To_Byte is
     new Ada.Unchecked_Conversion (Source => ALL_GPIO_Array,
                                   Target => Configuration.Byte);
   procedure Initialize;
   function Read_All_Inputs return ALL_GPIO_Array;

   --
   function Check return Boolean is
      T          : RP.Timer.Interrupts.Delays;

      Check_Result : ALL_GPIO_Array;
      Check_Number : Configuration.Byte;
   begin
      Initialize;
      T.Enable;
      for I in Configuration.Byte'Range loop
         My_Expander.Set_All_IO (IOs => To_All_IO_Array (I));
         T.Delay_Milliseconds (1);
         Check_Result := Read_All_Inputs;
         Check_Number := To_Byte (Check_Result);
         if (I and Check_Number) /= I then
            T.Disable;
            return False;
         end if;
      end loop;
      T.Disable;
      return True;
   end Check;

   procedure Initialize is
      T          : RP.Timer.Interrupts.Delays;
   begin
      T.Enable;
      Configuration.RESET_EXPANDER.Clear;
      T.Delay_Milliseconds (1);
      Configuration.RESET_EXPANDER.Set;
      T.Disable;

      My_Expander.Configure (Pin     => MCP23x08.Pin_0,
                             Output  => True,
                             Pull_Up => True);
      My_Expander.Configure (Pin     => MCP23x08.Pin_1,
                             Output  => True,
                             Pull_Up => True);
      My_Expander.Configure (Pin     => MCP23x08.Pin_2,
                             Output  => True,
                             Pull_Up => True);
      My_Expander.Configure (Pin     => MCP23x08.Pin_3,
                             Output  => True,
                             Pull_Up => True);
      My_Expander.Configure (Pin     => MCP23x08.Pin_4,
                             Output  => True,
                             Pull_Up => True);
      My_Expander.Configure (Pin     => MCP23x08.Pin_5,
                             Output  => True,
                             Pull_Up => True);
      My_Expander.Configure (Pin     => MCP23x08.Pin_6,
                             Output  => True,
                             Pull_Up => True);
      My_Expander.Configure (Pin     => MCP23x08.Pin_7,
                             Output  => True,
                             Pull_Up => True);

      --
      Configuration.IOEXP_Pin_0.Configure (RP.GPIO.Input);
      Configuration.IOEXP_Pin_1.Configure (RP.GPIO.Input);
      Configuration.IOEXP_Pin_2.Configure (RP.GPIO.Input);
      Configuration.IOEXP_Pin_3.Configure (RP.GPIO.Input);
      Configuration.IOEXP_Pin_4.Configure (RP.GPIO.Input);
      Configuration.IOEXP_Pin_5.Configure (RP.GPIO.Input);
      Configuration.IOEXP_Pin_6.Configure (RP.GPIO.Input);
      Configuration.IOEXP_Pin_7.Configure (RP.GPIO.Input);

   end Initialize;

   function Read_All_Inputs return ALL_GPIO_Array is
      Result : ALL_GPIO_Array;
   begin
      Result (Pin_0) := Configuration.IOEXP_Pin_0.Get;
      Result (Pin_1) := Configuration.IOEXP_Pin_1.Get;
      Result (Pin_2) := Configuration.IOEXP_Pin_2.Get;
      Result (Pin_3) := Configuration.IOEXP_Pin_3.Get;
      Result (Pin_4) := Configuration.IOEXP_Pin_4.Get;
      Result (Pin_5) := Configuration.IOEXP_Pin_5.Get;
      Result (Pin_6) := Configuration.IOEXP_Pin_6.Get;
      Result (Pin_7) := Configuration.IOEXP_Pin_7.Get;
      return Result;
   end Read_All_Inputs;

end Test_All_Outputs;
