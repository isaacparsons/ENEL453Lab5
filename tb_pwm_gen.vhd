library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb_pwm_gen is
end tb_pwm_gen;

architecture behavior of tb_pwm_gen is 
 
    -- component declaration for the unit under test (uut)
 
    component pwm_gen
    port ( clk   : in  std_logic;
		   duty_cycle : in integer;
		   reset : in  std_logic;
		   waveform : out std_logic
		  );
	end component;
    
    --inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
	signal waveform : std_logic;
	signal duty_cycle : integer := 20;

	
   -- clock period definitions
   constant clk_period : time := 10 ns;
 
begin
 
	-- instantiate the unit under test (uut)
   uut: pwm_gen port map (
          clk => clk,
          reset => reset,
		  duty_cycle => duty_cycle,
		  waveform => waveform
        );

  
   
   -- clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process; 

   -- stimulus process
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
        
end;