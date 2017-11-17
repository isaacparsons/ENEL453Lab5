library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity amp_lock_cal is
		Port ( clk 		: in  STD_LOGIC;
			   reset 	: in  STD_LOGIC;
			   comp_state : in STD_LOGIC;
			   saw_amp 	: in integer;
			   locked_amp: out std_logic_vector (10 downto 0)
			 );
end amp_lock_cal;

architecture Behavioral of amp_lock_cal is

signal  i_comp_state: std_logic;
signal  lastState: std_logic;
signal  i_locked_amp: std_logic_vector (10 downto 0);
--signal  table_output : std_logic_vector (8 downto 0);

	
begin

process(clk, reset, i_comp_state)
begin
	if (reset = '1') then					
        i_locked_amp <= "00000000000";
        lastState <= i_comp_state;
        
    elsif(rising_edge(clk)) then
        if(lastState = '1' and i_comp_state = '0') then      
             i_locked_amp <= std_logic_vector(to_unsigned(saw_amp, 11));
	    end if;
        lastState <= i_comp_state;
    end if;
end process;

locked_amp <= i_locked_amp;
i_comp_state <= comp_state;

end Behavioral;