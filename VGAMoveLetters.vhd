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
				   
				   increaseScale : in std_logic;
				   decreaseScale : in std_logic;
				   
				   box_x_positionOut : out std_logic_vector(9 downto 0);
				   box_y_positionOut : out std_logic_vector(9 downto 0);
				   scaleOut : out std_logic_vector(3 downto 0)
				 );
end VGAMoveLetters;

architecture Behavioral of VGAMoveLetters is
	signal ibox_x_pos : std_logic_vector(9 downto 0):= "0000000000";
	signal ibox_y_pos : std_logic_vector(9 downto 0):= "0000000000";
	
	signal currentScale: integer:= 3;
	signal maxScale: integer:= 10;
	signal minScale: integer:= 1;
	
begin

changePosition: process(clk, reset, btnUp, btnDown, btnRight, btnLeft) begin
	if (reset = '1') then					-- Asynchronous reset
        ibox_x_pos 	<= (others=> '0');
		ibox_y_pos 	<= (others=> '0');

	elsif (rising_edge(clk)) then 			-- When counter is enabled
        if(btnUp = '1'and (ibox_y_pos < 480)) then
            ibox_y_pos <= ibox_y_pos + 1;
			
        elsif((btnDown = '1') and (ibox_y_pos > 0)) then
            ibox_y_pos <= ibox_y_pos - 1;
            
        elsif((btnLeft = '1') and (ibox_x_pos > 0)) then
            ibox_x_pos <= ibox_x_pos - 1;
            
        elsif((btnRight = '1') and (ibox_x_pos < 640)) then
            ibox_x_pos <= ibox_x_pos + 1;
            
        end if;
		
		if((increaseScale = '1') and (currentScale < maxScale) and decreaseScale = '0' ) then
			currentScale <= currentScale + 1;
		elsif((decreaseScale = '1') and (currentScale > minScale) and (increaseScale = '0')) then
			currentScale <= currentScale - 1;
		end if;
		
	end if;
end process;

-- Connect internal signals to output
box_x_positionOut <= ibox_x_pos;
box_y_positionOut <= ibox_y_pos;
scaleOut <= std_logic_vector(to_unsigned(currentScale, 4));

end Behavioral;