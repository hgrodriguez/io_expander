with RP.Timer; use RP.Timer;
with RP.Device;

with LTP_305;

package body LED_Matrix is

   procedure Show_Hex (Number : Configuration.Byte) is
      T          : RP.Timer.Time;

      -----------------------------------------------------------------------
      --  references the font defintions, so we have easier indexing
      Hex_Letters : constant array (0 .. 15) of Integer
        := ((17 + 31), --  0
            (18 + 31), --  1
            (19 + 31), --  2
            (20 + 31), --  3
            (21 + 31), --  4
            (22 + 31), --  5
            (23 + 31), --  6
            (24 + 31), --  7
            (25 + 31), --  8
            (26 + 31), --  9
            (34 + 31), --  A
            (35 + 31), --  B
            (36 + 31), --  C
            (37 + 31), --  D
            (38 + 31), --  E
            (39 + 31)  --  F
           );
      Left_Letter : constant Integer := Hex_Letters (Integer (Number) / 16);
      Right_Letter : constant Integer := Hex_Letters (Integer (Number) mod 16);
   begin
      T := RP.Timer.Clock;
      LTP_305.Write (This     => Configuration.Port_LED'Access,
                     Address  => Configuration.Address_LED,
                     Location => LTP_305.Matrix_L,
                     Code     => Left_Letter,
                     DP       => True);
      LTP_305.Write (This     => Configuration.Port_LED'Access,
                     Address  => Configuration.Address_LED,
                     Location => LTP_305.Matrix_R,
                     Code     => Right_Letter,
                     DP       => True);
      LTP_305.Write_Byte_Data (Configuration.Port_LED'Access,
                               Configuration.Address_LED,
                               LTP_305.Update,
                               1);
      T := T + RP.Timer.Milliseconds (50);
      RP.Device.Timer.Delay_Until (T);
   end Show_Hex;

   procedure Display_Failure is
   begin
      LTP_305.Write (This    => Configuration.Port_LED'Access,
                  Address => Configuration.Address_LED,
                  Location => LTP_305.Matrix_R,
                  Code    => 8595,
                  DP       => True);
      LTP_305.Write_Byte_Data (This    => Configuration.Port_LED'Access,
                            Address => Configuration.Address_LED,
                            Cmd     => LTP_305.Update,
                            B       => 1);
   end Display_Failure;

   procedure Display_Success is
   begin
      LTP_305.Write (This    => Configuration.Port_LED'Access,
                  Address => Configuration.Address_LED,
                  Location => LTP_305.Matrix_R,
                  Code    => 8593,
                  DP       => True);
      LTP_305.Write_Byte_Data (This    => Configuration.Port_LED'Access,
                            Address => Configuration.Address_LED,
                            Cmd     => LTP_305.Update,
                            B       => 1);
   end Display_Success;
end LED_Matrix;
