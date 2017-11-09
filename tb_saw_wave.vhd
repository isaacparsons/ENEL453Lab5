library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_saw_wave is
end tb_saw_wave;

ARCHITECTURE behavior OF tb_saw_wave IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT saw_wave
    Port ( clk     	   : in  STD_LOGIC;
		   reset       : in  STD_LOGIC;
		   outamplitude: out integer;
		   waveform	   : out std_logic--;
		   );
	END COMPONENT;
    
    --Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
	signal outamplitude : integer := 0;
	signal waveform : std_logic;

	
   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: saw_wave PORT MAP (
          clk => clk,
          reset => reset,
		  outamplitude => outamplitude,
		  waveform => waveform--,
        );

  
   
   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
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
      wait;
   end process;
END;