library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity VGAMoveLetters is
	
		Port ( clk : in  STD_LOGIC;
				   reset : in  STD_LOGIC;
				   btnUp : in std_logic;
				   btnDown : in std_logic;
				   btnLeft : in std_logic;
				   btnRight : in std_logic;
				   
				   --increaseScale : in std_logic;
				   --decreaseScale : in std_logic;
				   
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
--        if(btnUp = '1' and lastStateUp = '0' and (ibox_y_pos < (14*6*currentScale))) then
--            lastStateUp <= '1';
--            ibox_y_pos <= ibox_y_pos + currentScale;
--        end if;
        
--        if((btnDown = '1') and lastStateDown = '0' and (ibox_y_pos > 0)) then
--            lastStateDown <= '1';
--            ibox_y_pos <= ibox_y_pos - currentScale;
--        end if;
            
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
        
		
		--if((increaseScale = '1') and (currentScale < maxScale) and decreaseScale = '0' ) then
			--currentScale <= currentScale + 1;
		--elsif((decreaseScale = '1') and (currentScale > minScale) and (increaseScale = '0')) then
			--currentScale <= currentScale - 1;
		--end if;
		
	end if;
end process;

-- Connect internal signals to output
box_x_positionOut <= ibox_x_pos;
box_y_positionOut <= ibox_y_pos;
scaleOut <= std_logic_vector(to_unsigned(currentScale, 4));

end Behavioral;