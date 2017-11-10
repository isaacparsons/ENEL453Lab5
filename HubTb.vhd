library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity HubTb is
end HubTb;

architecture behaviour of HubTb is

	component HubTb
    Port ( 		clk   : in STD_LOGIC;
			reset : in STD_LOGIC; -- BTNC
			op_comp : in STD_LOGIC;
			to_filter : out STD_LOGIC;
			
			--sevensegment stuff
			CA : out  STD_LOGIC;
			CB : out  STD_LOGIC;
			CC : out  STD_LOGIC;
			CD : out  STD_LOGIC;
			CE : out  STD_LOGIC;
			CF : out  STD_LOGIC;
			CG : out  STD_LOGIC;
			DP : out  STD_LOGIC;
			AN1 : out STD_LOGIC;
			AN2 : out STD_LOGIC;
			AN3 : out STD_LOGIC;
			AN4 : out STD_LOGIC);
	end component;
	
signal i_to_filter : STD_LOGIC;
signal i_saw_amp   : integer;
signal i_locked_amp: std_logic_vector(8 downto 0);

component saw_wave
	Port ( 	clk   : in STD_LOGIC;
			reset : in STD_LOGIC;
			outamplitude : out integer;
			waveform     : out STD_LOGIC--;
			);
			
component amp_lock
	Port (	clk   : in STD_LOGIC;
			reset : in STD_LOGIC;
			comp_state : in STD_LOGIC;
			saw_amp    : in integer;
			locked_amp : out std_logic_vector(8 downto 0)--;
			);

--component BrandonName
--	Port (	HERE
--			
--			);

	
	  
		  
begin 
sawWave: saw_wave Port map(
	clk=> clk,
	reset => reset,
	outamplitude => outamplitude,
	waveform => waveform
);


ampLock: amp_lock Port map(
	clk=> clk,
	reset=> reset,
	comp_state=>comp_state,
	saw_amp=> saw_amp,
	locked_amp=> locked_amp	
);

clk_process :process
       begin
            clk <= '0';
            wait for 1 ns;
            clk <= '1';
            wait for 1 ns;
       end process;
        
     
    
       -- Stimulus process
       stim_proc: process
       begin        
          -- hold reset state for 100 ns.
            reset <= '0';
          wait for 100 ns;    
            reset <= '1';
          wait for 100 ns;
            reset <= '0';
          -- insert stimulus here 
    
          wait for clk_period*100;
       end process;
	   
	   stim_comp: process
       begin        
          
            op_comp <= '0';
            wait for 50 ns;
            op_comp <= '1';
            wait for 50 ns;
       end process;

end behaviour;