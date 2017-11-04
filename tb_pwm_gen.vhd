library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_pwm_gen is
end tb_pwm_gen;

ARCHITECTURE behavior OF tb_pwm_gen IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT pwm_gen
    Port ( clk   : in  STD_LOGIC;
		   duty_cycle : integer;
		   reset : in  STD_LOGIC;
		   waveform : out STD_LOGIC
		  );
	END COMPONENT;
    
    --Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
	signal waveform : std_logic;
	signal duty_cycle : integer := 20;

	
   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pwm_gen PORT MAP (
          clk => clk,
          reset => reset,
		  duty_cycle => duty_cycle,
		  waveform => waveform
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
      wait for 40 ns;	
		reset <= '1';
      wait for 60 ns;
		reset <= '0';
      wait;
   end process;
   
   stim: process
   begin
     wait for 740 ns;
        duty_cycle <= duty_cycle + 1;
   end process;
        
END;