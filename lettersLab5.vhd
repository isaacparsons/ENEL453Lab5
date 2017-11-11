library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lettersLab5 is
    Port ( 	clk : in  STD_LOGIC;
			reset : in  STD_LOGIC;
			scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
			scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
            letter_color: in STD_LOGIC_VECTOR(11 downto 0);
			binaryLetterLookupValue: in STD_LOGIC_VECTOR(8 downto 0);
			
			--buttons
			upBtn: in std_logic;
			downBtn: in std_logic;
			leftBtn: in std_logic;
			rightBtn: in std_logic;
			
			red: out STD_LOGIC_VECTOR(3 downto 0);
			blue: out STD_LOGIC_VECTOR(3 downto 0);
			green: out std_logic_vector(3 downto 0)
		  );
end lettersLab5;

architecture behaviour of lettersLab5 is
type LetterMatrix is array(0 to 13, 0 to 16) of integer;

signal pixel_color: std_logic_vector(11 downto 0);

signal SelectedLetterFirstDigit: LetterMatrix; --most significant
signal SelectedLetterSecondDigit: LetterMatrix;
signal SelectedLetterThirdDigit: LetterMatrix;

--current letter being "drawn" by the vga
signal currentCharacter: LetterMatrix;

constant scale: integer:= 3; -- chooses the size of the letters.
signal scale_counter: integer:= 0;


--for accessing letter number matrix's, LNX is letter number where X = 1,2,3
-- only need one y index since itll be the same across
signal xindexforEachLetter: integer:= 0;

signal xtotalIndex: integer:= 0;
signal ytotalIndex: integer:= 0;

signal box_x_position: integer:= 0;
signal box_y_position: integer:= 0;


signal zero: LetterMatrix:= ((0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0),		
							   (0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0),
							   (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0),
							   (0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0));

signal one: LetterMatrix:= ((0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0),		
							  (0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0),
							  (0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0),
							  (0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0),
							  (0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0),
							  (0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0),
							  (0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0),
							  (0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0),
							  (0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0),
							  (0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0),
							  (0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0),
							  (0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0),
							  (0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0),
							  (0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0));

signal two: LetterMatrix:= ((0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0),	
							  (0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0),
							  (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							  (0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0),
							  (0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0),
							  (0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0),
							  (0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0),
							  (0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0),
							  (0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0),
							  (0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0),
							  (0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0),
							  (0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0),
							  (0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0),
							  (0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0));

signal three: LetterMatrix:= ((0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0),	
							    (0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0),
							    (0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0),
							    (0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0),
							    (0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0),
							    (0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0),
							    (0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0),
							    (0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0),
							    (0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0),
							    (0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0),
							    (0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0),
							    (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							    (0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0),
							    (0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0));
							   
signal four: LetterMatrix:= ((0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0),	
							   (0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0),
							   (0,0,0,0,0,0,1,1,0,1,1,0,0,0,0,0,0),
							   (0,0,0,0,0,0,1,1,0,1,1,0,0,0,0,0,0),
							   (0,0,0,0,0,1,1,0,0,1,1,0,0,0,0,0,0),
							   (0,0,0,0,0,1,1,0,0,1,1,0,0,0,0,0,0),
							   (0,0,0,0,1,1,0,0,0,1,1,0,0,0,0,0,0),
							   (0,0,0,0,1,1,0,0,0,1,1,0,0,0,0,0,0),
							   (0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,0,0),
							   (0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0),
							   (0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0));							   


signal five: LetterMatrix:= ((0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0),		
							   (0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0),
							   (0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0),
							   (0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0),
							   (0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0));
							   
							   
signal six: LetterMatrix:= ((0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0),	
							  (0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0),
							  (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							  (0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0),
							  (0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0),
							  (0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0),
							  (0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0),
							  (0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0),
							  (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							  (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							  (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							  (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							  (0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0),
							  (0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0));
							   
							   
signal seven: LetterMatrix:= ((0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0),		
							    (0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0),
							    (0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0),
							    (0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0),
							    (0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0),
							    (0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0),
							    (0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0),
							    (0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0),
							    (0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0),
							    (0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0),
							    (0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0),
							    (0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0),
							    (0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0),
							    (0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0));
							   
							   
signal eight: LetterMatrix:= ((0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0),	
							    (0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0),
							    (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							    (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							    (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							    (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							    (0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0),
							    (0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0),
							    (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							    (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							    (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							    (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							    (0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0),
							    (0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0));
							   
							   
signal nine: LetterMatrix:= ((0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0),	
							   (0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0),
							   (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0),
							   (0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0),
							   (0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0));
							   
signal point: LetterMatrix:=((0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
							   
signal C: LetterMatrix:=((0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),  -- not done
						   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
							   
signal M: LetterMatrix:=((0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0), -- not done
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
 
 --add buttons to move the letters around up down left and right to sensitivity list
 begin
 
 
pixelOnorOff: process(scan_line_x, scan_line_y) begin
	-- case statement or something to choose 3 letters(numbers). result will give values to
	-- SelectedLetterFirstDigit, SelectedLetterSecondDigit, and SelectedLetterThirdDigit

	--select the first number 
	if(reset = '1') then
	   xtotalIndex<= 0;
	   ytotalIndex<= 0;
	   scale_counter <= 0;
	else
	
        if(scan_line_x < "00111100000") then
            xtotalIndex <= xtotalIndex + 1;
        -- less than 480 (width of vga display)
            if(scale_counter = scale - 1) then
                    scale_counter <= 0;
                    xindexforEachLetter<= xindexforEachLetter+1;
                else
                    scale_counter <= scale_counter + 1;
            end if;
        else
            -- if scan_line_x equals 480 increment ytotalIndex
            xtotalIndex <= 0;
            xindexforEachLetter <= 0;
            scale_counter <= 0;
            if(scan_line_y < "1010000000") then 
                ytotalIndex <= ytotalIndex + 1;
            else
                ytotalIndex<= 0;
            end if;
        end if;
        
        --reset the x index when in new character
        if(xtotalIndex = box_x_position + (34*scale) - 1) then
               xindexforEachLetter <= 0;
        elsif(xtotalIndex = box_x_position) then
              xindexforEachLetter <= 0;
        elsif(xtotalIndex = box_x_position + (17*scale) - 1) then
              xindexforEachLetter <= 0;
        elsif(xtotalIndex = box_x_position + (51*scale) - 1) then
              xindexforEachLetter <= 0;  
        elsif(xtotalIndex = box_x_position + (68*scale) - 1) then
              xindexforEachLetter <= 0;
        elsif(xtotalIndex = box_x_position + (85*scale) - 1) then
              xindexforEachLetter <= 0;
        elsif(xtotalIndex >= (box_x_position + (102 * scale) - 1)) then
              xindexforEachLetter <= 0;
        end if;
        
        --first character
        if(xtotalIndex >= box_x_position and xtotalIndex < (box_x_position + (17* scale))) then
            currentCharacter <= SelectedLetterFirstDigit;
        
        --second character
        elsif(xtotalIndex >= (box_x_position + (17*scale)) and xtotalIndex < (box_x_position + (34* scale))) then
            currentCharacter <= SelectedLetterSecondDigit;
        
        --point 
        elsif(xtotalIndex >= (box_x_position + (34*scale)) and xtotalIndex < (box_x_position + (51* scale))) then
            currentCharacter <= point;  
            
        -- third character      
        elsif(xtotalIndex >= (box_x_position + (51*scale)) and xtotalIndex < (box_x_position + (68* scale))) then
            currentCharacter <= SelectedLetterThirdDigit;
            
        -- "C"
        elsif(xtotalIndex >= (box_x_position + (68*scale)) and xtotalIndex < (box_x_position + (85* scale))) then
            currentCharacter <= C;
        
        -- "M"
        elsif(xtotalIndex >= (box_x_position + (85*scale)) and xtotalIndex < (box_x_position + (102* scale))) then
            currentCharacter <= M;
            
        end if;
            
        
        
    
        
        --if((currentCharacter(xindexforEachLetter, ytotalIndex) = 1) and x_scan_line < 17 * 6 * scale) then
        --    pixel_color <= letter_color;
        --else
         --   pixel_color <= "111111111111";
        --end if;
    end if;
								
red   <= pixel_color(11 downto 8);
green <= pixel_color(7 downto 4);
blue  <= pixel_color(3 downto 0);
end process;





moveBox: process(upBtn, downBtn, leftBtn, rightBtn, clk, reset) begin
    if(reset = '1') then
        box_x_position <= 0;
        box_y_position <= 0;
    elsif(rising_edge(clk)) then
        if(upBtn = '1'and (box_y_position < 480)) then
            box_y_position <= box_y_position + 1;
            if(ytotalindex > 0) then
                ytotalindex<= ytotalindex -1;
            end if;
        elsif((downBtn = '1') and (box_y_position > 0)) then
            box_y_position <= box_y_position - 1;
            if(ytotalindex < 640) then
                ytotalindex<= ytotalindex +1;
            end if;
        elsif((leftBtn = '1') and (box_x_position > 0)) then
            box_x_position <= box_x_position - 1;
            if(xtotalindex > 0) then
                xtotalindex<= ytotalindex -1;
            end if;
        elsif((rightBtn = '1') and (box_x_position < 640)) then
            box_x_position <= box_x_position + 1;
            if(xtotalindex < 480) then
                xtotalindex<= xtotalindex +1;
            end if;
        end if;
    end if;
end process;

 
end behaviour;