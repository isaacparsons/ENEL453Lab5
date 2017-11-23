library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IRReceiverModule is
		Port (clk : in std_logic;
		      reset : in std_logic;
		      irSignal : in std_logic; -- low means that the ball crossed and we must get the value of the dist.
			  distanceDigitOne : in std_logic_vector(1 downto 0); -- value of 0 to 3
			  distanceDigitTwo : in std_logic_vector(3 downto 0); -- value of 0 to 9 
			  distanceDigitThree : in std_logic_vector(3 downto 0); -- value of 0 to 9
			  
			  convertedScore : out std_logic_vector(2 downto 0) -- score recevied
				 );
end IRReceiverModule;

architecture Behavioral of IRReceiverModule is
	-- Signals
	signal iscore : std_logic_vector(2 downto 0):= "000";
	
begin

convertScore: process(clk) begin

    if(reset = '1') then
        iscore <= "000";
	elsif(rising_edge(clk) and irSignal = '0') then
		if(distanceDigitOne = "00") then
			if((distanceDigitTwo >= "0100") and (distanceDigitTwo < "1010")) then
				iscore <= "001";
			end if;
		elsif(distanceDigitOne = "01") then
			if((distanceDigitTwo >= "0101") and (distanceDigitTwo <= "1001")) then
				iscore <= "011";
			else
				iscore <= "010";
			end if;
		elsif(distanceDigitOne = "10") then
			if((distanceDigitTwo >= "0101") and (distanceDigitTwo <= "1001")) then
				iscore <= "101";
			else
				iscore <= "100";
			end if;
		elsif(distanceDigitOne = "11") then
			iscore <= "110";
		end if;

	end if;
end process;

convertedScore <= iscore;

end Behavioral;