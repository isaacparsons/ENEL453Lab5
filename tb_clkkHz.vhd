LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_clkkHz IS
END tb_clkkHz;

ARCHITECTURE behavior OF tb_clkkHz IS 
	COMPONENT clkkHz
	PORT(
		clk_in : in  std_logic;
		reset  : in  std_logic;
		clk_out: out std_logic
	);
	END COMPONENT;

	signal clk_in  : std_logic := '0';
	signal reset   : std_logic := '0';
	signal clk_out : std_logic;
    
	constant clk_period : time := 10 ns;
BEGIN 
	uut: clkkHz PORT MAP (
		clk_in  => clk_in,
		reset   => reset,
		clk_out => clk_out
	);

	clk :process
		begin
		clk_in <= '0';
		wait for clk_period / 2;
		clk_in <= '1';
		wait for clk_period / 2;
	end process;

	stim: process
	begin
		reset <= '1';
		wait for 100 ns;
		reset <= '0';
        wait;
	end process;
END;