library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity goal_register is
		Port ( clk 		: in  STD_LOGIC;
			   reset    : in STD_LOGIC;
			   ir_sig : in STD_LOGIC;
			   goal     : out STD_LOGIC
			 );
end goal_register;

architecture Behavioral of goal_register is

signal  i_ir_sig: std_logic;
signal  lastState: std_logic;
signal  i_goal: std_logic;

	
begin

process(clk, i_ir_sig)
begin
    if(reset = '1') then
        lastState <= '0';
        i_goal <= '0';
	elsif(rising_edge(clk)) then
        if(lastState /= i_ir_sig) then --(lastState = '1' and i_ir_sig = '0')) then      
             i_goal <= NOT i_ir_sig;
		end if;
        lastState <= i_ir_sig;
    end if;
end process;

i_ir_sig <= ir_sig;
goal <= i_goal;

end Behavioral;