package body MCP23x08.I2C.Internals is

   procedure Set_IPOL_Disabled (This : in out MCP23008_IO_Expander) is
   begin
      This.IO_Write (WriteAddr => MCP23x08.INPUT_POLARITY_REG,
                     Value     => 0);
   end Set_IPOL_Disabled;

   procedure Set_IPOL_Enabled (This : in out MCP23008_IO_Expander) is
   begin
      This.IO_Write (WriteAddr => MCP23x08.INPUT_POLARITY_REG,
                     Value     => 16#FF#);
   end Set_IPOL_Enabled;

end MCP23x08.I2C.Internals;
