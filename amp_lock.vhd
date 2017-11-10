library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity amp_lock is
		Port ( clk 		: in  STD_LOGIC;
			   reset 	: in  STD_LOGIC;
			   comp_state : in STD_LOGIC;
			   saw_amp 	: in integer;
<<<<<<< HEAD
			   locked_amp: out std_logic_vector (8 downto 0)
=======
			   locked_amp: out std_logic_vector (8 downto 0);
>>>>>>> refs/remotes/origin/master
			 );
end amp_lock;

architecture Behavioral of amp_lock is

signal  i_comp_state: std_logic;
signal  lastState: std_logic;
signal  i_locked_amp: std_logic_vector (8 downto 0);
	
begin

process(clk, reset, i_comp_state)
begin
	if (reset = '1') then					
        i_locked_amp <= "000000000";
        lastState <= i_comp_state;
        
    elsif(rising_edge(clk)) then
        if(lastState = '0' and i_comp_state = '1') then      
<<<<<<< HEAD
             i_locked_amp <= std_logic_vector(to_unsigned(saw_amp, 9));
=======
             i_locked_amp <= to_unsigned(saw_amp, 9);;
>>>>>>> refs/remotes/origin/master
	    end if;
        lastState <= i_comp_state;
    end if;
end process;

locked_amp <= i_locked_amp;
i_comp_state <= comp_state;

end Behavioral;