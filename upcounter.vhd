library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity upcounter is
	Generic ( 	max: integer:= 4;				
					    WIDTH: integer:= 3);
		Port ( clk : in  STD_LOGIC;
				   reset : in  STD_LOGIC;
				   enable : in  STD_LOGIC;
				   value: out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
				 );
end upcounter;

architecture Behavioral of upcounter is
	signal 	current_count: std_logic_vector(WIDTH-1 downto 0);
	
	-- Convert the max counter to a logic vector (this is done during synthesis) 
	constant max_count: 		std_logic_vector(WIDTH-1 downto 0) := 
									        std_logic_vector(to_unsigned(max, WIDTH));
	-- Create a logic vector of proper length filled with zeros (also done during synthesis)
	constant zeros: 			std_logic_vector(WIDTH-1 downto 0) := (others => '0');
	
begin

count: process(clk,reset) begin
	if (reset = '1') then					-- Asynchronous reset
        current_count 	<= zeros;

	elsif (rising_edge(clk)) then 
        if (enable = '1') then				-- When counter is enabled
            if (current_count = max_count) then
                current_count 	<= zeros;
            else 
                current_count 	<= current_count + '1';
            end if;
		else 
			current_count <= zeros;
		end if;
	end if;
end process;

-- Connect internal signals to output
value <= current_count;	

end Behavioral;