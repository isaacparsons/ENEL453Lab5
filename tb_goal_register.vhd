library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb_goal_register is
end tb_goal_register;

architecture behavior of tb_goal_register is 
 
    -- component declaration for the unit under test (uut)
 
    component  goal_register is
		port ( clk    : in  std_logic;
			   reset  : in  std_logic;
			   ir_sig : in std_logic;
			   goal   : out std_logic
			 );
end component;
    
    --inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
	signal ir_sig : std_logic := '0';
	signal goal : std_logic;


	
   -- clock period definitions
   constant clk_period : time := 10 ns;
 
begin
 
	-- instantiate the unit under test (uut)
   uut: goal_register port map (
          clk => clk,
		  reset => reset,
		  ir_sig => ir_sig,
		  goal => goal--,
		  );

  
   
   -- clock process definitions
   clk_process: process
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
   
   ir_proc: process
   begin
		wait for 500 ns;
		ir_sig <= '1';
		wait for 500 ns;
		ir_sig <= '0';
   end process;
end;