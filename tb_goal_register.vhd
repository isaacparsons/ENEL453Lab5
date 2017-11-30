library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_goal_register is
end tb_goal_register;

ARCHITECTURE behavior OF tb_goal_register IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT  goal_register is
		Port ( clk    : in  STD_LOGIC;
			   reset  : in  STD_LOGIC;
			   ir_sig : in STD_LOGIC;
			   goal   : out STD_LOGIC
			 );
end component;
    
    --Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
	signal ir_sig : std_logic := '0';
	signal goal : std_logic;


	
   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: goal_register PORT MAP (
          clk => clk,
		  reset => reset,
		  ir_sig => ir_sig,
		  goal => goal--,
		  );

  
   
   -- Clock process definitions
   clk_process: process
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
   
   ir_proc: process
   begin
		wait for 500 ns;
		ir_sig <= '1';
		wait for 500 ns;
		ir_sig <= '0';
   end process;
END;