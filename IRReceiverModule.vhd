library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity irreceivermodule is
		port (clk : in std_logic;
		      reset : in std_logic;
		      irsignal : in std_logic; -- low means that the ball crossed and we must get the value of the dist.
			  distancedigitone : in std_logic_vector(3 downto 0); -- value of 0 to 3
			  distancedigittwo : in std_logic_vector(3 downto 0); -- value of 0 to 9 
			  distancedigitthree : in std_logic_vector(3 downto 0); -- value of 0 to 9

			  convertedscore : out std_logic_vector(2 downto 0) -- score recevied
				 );
end irreceivermodule;

architecture behavioral of irreceivermodule is
	-- signals

	signal iscore : std_logic_vector(2 downto 0);
	signal last_state: std_logic:= '0';

	
begin

convertscore: process(clk) begin

    if(reset = '1') then
       iscore <= "000";
       last_state <= '0';
	elsif(rising_edge(clk)) then
	   if(irsignal = '1' and last_state = '0')then
			if(distancedigitone = "0000") then
                if((distancedigittwo >= "0100") and (distancedigittwo < "1010")) then
                    iscore <= "001";
                end if;
            elsif(distancedigitone = "0001") then
                if((distancedigittwo >= "0101") and (distancedigittwo <= "1001")) then
                    iscore <= "011";
                else
                    iscore <= "010";
                end if;
            elsif(distancedigitone = "0010") then
                if((distancedigittwo >= "0101") and (distancedigittwo <= "1001")) then
                    iscore <= "101";
                else
                    iscore <= "100";
                end if;
            elsif(distancedigitone = "0011") then
                iscore <= "110";
            end if;
       end if;
       last_state <= irsignal;
	end if;
end process;

convertedscore <= iscore;

end behavioral;