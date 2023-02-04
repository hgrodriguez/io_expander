with RP.Timer.Interrupts;

with Configuration;

package body Test_Shift_1Bit_Output is

   type Possibilities is array (0 .. 127) of Configuration.Byte;

   Possibilities_1 : constant Possibilities :=
     (
      0 => 2#0000_000#, 1 => 2#0000_001#, 2 => 2#0000_010#, 3 => 2#0000_011#,
      4 => 2#0000_100#, 5 => 2#0000_101#, 6 => 2#0000_110#, 7 => 2#0000_111#,
      others => 0
     );

   type Combinations is array (1 .. 1) of Possibilities;

   All_Combinations : constant Combinations :=
     ((1 => (Possibilities_1)));

   function Check return Boolean is
      T          : RP.Timer.Interrupts.Delays;

   begin
      T.Enable;
      T.Disable;
      return True;
   end Check;

end Test_Shift_1Bit_Output;
