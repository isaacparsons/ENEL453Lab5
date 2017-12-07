library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity VGAMoveLetters is
	
		port ( clk : in  std_logic;
			   reset : in  std_logic;
			   btnUp : in std_logic;
			   btnDown : in std_logic;
			   btnLeft : in std_logic;
			   btnRight : in std_logic;
							   
			   box_x_positionOut : out std_logic_vector(9 downto 0);
			   box_y_positionOut : out std_logic_vector(9 downto 0);
			   scaleOut : out std_logic_vector(3 downto 0)
			   );
end VGAMoveLetters;

architecture Behavioral of VGAMoveLetters is

	signal ibox_x_pos : std_logic_vector(9 downto 0):= "0000000111";
	signal ibox_y_pos : std_logic_vector(9 downto 0):= "0000000000";
	
	signal currentScale: integer:= 7;
	signal maxScale: integer:= 10;
	signal minScale: integer:= 1;
	
	signal lastStateUp: std_logic:='0';
	signal lastStateDown: std_logic:='0';
	signal lastStateLeft: std_logic:='0';
	signal lastStateRight: std_logic:='0';
	

begin

changePosition: process(clk, reset, btnUp, btnDown, btnRight, btnLeft) begin
	if (reset = '1') then					-- Asynchronous reset
        ibox_x_pos 	<= (others=> '0');
		ibox_y_pos 	<= (others=> '0');


	elsif (rising_edge(clk)) then		-- When counter is enabled
           
        if((btnLeft = '1') and lastStateLeft = '0' and  (ibox_x_pos > 7)) then
            lastStateLeft <= '1';
            ibox_x_pos <= ibox_x_pos - currentScale;
        end if;
            
        if((btnRight = '1') and lastStateRight = '0' and (ibox_x_pos < 13*currentScale)) then
            lastStateRight <= '1';
            ibox_x_pos <= ibox_x_pos + currentScale;
        end if;
        
        lastStateUp <= btnUp;
        lastStateDown <= btnDown;
        lastStateLeft <= btnLeft;
        lastStateRight <= btnRight;

		
	end if;
end process;

-- Connect internal signals to output
box_x_positionOut <= ibox_x_pos;
box_y_positionOut <= ibox_y_pos;
scaleOut <= std_logic_vector(to_unsigned(currentScale, 4));

end Behavioral;