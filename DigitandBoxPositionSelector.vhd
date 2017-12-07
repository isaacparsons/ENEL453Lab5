library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DigitandBoxPositionSelector is
		Port (clk: in std_logic;
			boxPositionxSelectIn: in std_logic_vector(9 downto 0);
			boxPositionySelectIn: in std_logic_vector(9 downto 0);
			DigitSelectOneIn: in std_logic_vector(3 downto 0);
			DigitSelectTwoIn: in std_logic_vector(3 downto 0);
			DigitSelectThreeIn: in std_logic_vector(3 downto 0);
			
			DigitSelectOneOut: out std_logic_vector(3 downto 0);
			DigitSelectTwoOut: out std_logic_vector(3 downto 0);
			DigitSelectThreeOut: out std_logic_vector(3 downto 0);
			
			boxPositionxSelectOut: out std_logic_vector(9 downto 0);
			boxPositionySelectOut: out std_logic_vector(9 downto 0)
				 );
end DigitandBoxPositionSelector;

architecture Behavioral of DigitandBoxPositionSelector is
	
begin

sync: process(clk) begin
	if(rising_edge(clk)) then
		boxPositionxSelectOut <= boxPositionxSelectIn;
		boxPositionySelectOut <= boxPositionySelectIn;
		
		DigitSelectOneOut <= DigitSelectOneIn;
		DigitSelectTwoOut <= DigitSelectTwoIn;
		DigitSelectThreeOut <= DigitSelectThreeIn;
	end if;
end process;

end Behavioral;