library ieee;
use ieee.std_logic_1164.all;

entity tb_kHz_clk is
end tb_kHz_clk;

architecture behavior of tb_kHz_clk is 
	component kHz_clk
	port(
		clk_in : in  std_logic;
		reset  : in  std_logic;
		clk_out: out std_logic
	);
	end component;

	signal clk_in  : std_logic := '0';
	signal reset   : std_logic := '0';
	signal clk_out : std_logic;
    
	constant clk_period : time := 10 ns;
begin 
	uut: kHz_clk port map (
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
end;
