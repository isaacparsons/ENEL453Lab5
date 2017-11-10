--NEED TO CONFIRM TB WORKS

library ieee;
use ieee.std_logic_1164.all;
 
entity tb_sevensegment_selector is
end tb_sevensegment_selector;
 
architecture behavior of tb_sevensegment_selector is  
    component sevensegment_selector
    port(
         clk : in  std_logic;
         switch : in  std_logic;
         output : out  std_logic_vector(3 downto 0);
         reset : in  std_logic
        );
    end component;
    
   --inputs
   signal clk : std_logic := '0';
   signal switch : std_logic := '0';
   signal reset : std_logic := '0';

 	--outputs
   signal output : std_logic_vector(3 downto 0);

   -- clock period definitions
   constant clk_period : time := 10 ns;
 
begin
   uut: sevensegment_selector port map (
          clk => clk,
          switch => switch,
          output => output,
          reset => reset
        );

   -- clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
   
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		reset <= '0';
      wait for 100 ns;	
		reset <= '1';
      wait for clk_period*10;
		reset <= '0';

      wait for clk_period*100;
   end process;

end; 
