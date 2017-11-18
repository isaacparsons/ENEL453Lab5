library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_calibration is
end tb_calibration;

ARCHITECTURE behavior OF tb_calibration IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT calibration
		Port (	clk     : in  std_logic;  
				reset   : in  std_logic;  
				button  : in  std_logic;
				saw_amp : in  integer;
				offset  : out integer
				);
	end component;
    
    --Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
	signal saw_amp : integer := 0;
	signal button  : std_logic := '0';
	signal offset: integer := 0;
	
   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: calibration PORT MAP (
          clk => clk,
          reset => reset,
		  button => button,
		  saw_amp => saw_amp,
		  offset => offset--,
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
   
   amp_proc: process
   begin
		saw_amp <= 24; --Change this to test
		wait for 12 ms;
		saw_amp <= 1300;
		wait for 23 ms;
		saw_amp <= 2000;
		wait for 23 ms;
		saw_amp <= 1500;
   end process;
   
   comp_proc: process
   begin
		button <= '1';
		wait for 11 ms;
		button <= '0';
		wait for 11 ms;
	end process;
END;