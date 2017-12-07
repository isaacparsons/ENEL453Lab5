library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity goal_register is
		port ( clk 		: in  std_logic;
			   reset    : in std_logic;
			   ir_sig : in std_logic;
			   goal     : out std_logic
			 );
end goal_register;

architecture behavioral of goal_register is

signal  i_ir_sig: std_logic;
signal  laststate: std_logic;
signal  i_goal: std_logic;

	
begin

process(clk, i_ir_sig)
begin
    if(reset = '1') then
        laststate <= '0';
        i_goal <= '0';
	elsif(rising_edge(clk)) then
        if(laststate /= i_ir_sig) then  
             i_goal <= not i_ir_sig;
		end if;
        laststate <= i_ir_sig;
    end if;
end process;

i_ir_sig <= ir_sig;
goal <= i_goal;

end behavioral;