library ieee;
use ieee.std_logic_1164.all;

entity sevensegment_selector is
    port ( clk : in  std_logic;
           switch : in  std_logic;
           output : out  std_logic_vector (3 downto 0);
           reset : in  std_logic
         );
end sevensegment_selector;

architecture behavioral of sevensegment_selector is
	
signal d, q: std_logic_vector(3 downto 0);
signal  i_state: std_logic;
signal  lastState: std_logic;

begin

dffs: process(reset, clk, i_state)
begin
	if (reset = '1') then
		q <= "0001";		
		lastState <= '0';				
	elsif (rising_edge(clk)) then	
		if(lastState = '0' and switch = '1') then      
			q(0) <= d(0);
           		q(1) <= d(1);
           		q(2) <= d(2);
           		q(3) <= d(3);
        	end if;
        	lastState <= switch; 
	end if;
end process;

-- connect the dffs into a chain/loop
-- this means output of one needs to connect to input of the next one
d(0) <= q(3);
d(1) <= q(0);
d(2) <= q(1);
d(3) <= q(2);

-- copying q to the output of the block
output(0) <= q(0);
output(1) <= q(1);
output(2) <= q(2);
output(3) <= q(3);

end behavioral;
