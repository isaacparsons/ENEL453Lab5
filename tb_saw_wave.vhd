library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb_saw_wave is
end tb_saw_wave;

architecture behavior of tb_saw_wave is 
 
    -- component declaration for the unit under test (uut)
 
    component saw_wave
    port ( clk     	   : in  std_logic;
		   reset       : in  std_logic;
		   outamplitude: out integer;
		   waveform	   : out std_logic--;
		   );
	end component;
    
    --inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
	signal outamplitude : integer := 0;
	signal waveform : std_logic;

	
   -- clock period definitions
   constant clk_period : time := 10 ns;
 
begin
 
	-- instantiate the unit under test (uut)
   uut: saw_wave port map (
          clk => clk,
          reset => reset,
		  outamplitude => outamplitude,
		  waveform => waveform--,
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
      wait for 100 ns;	
		reset <= '1';
      wait for 100 ns;
		reset <= '0';
      wait;
   end process;
end;