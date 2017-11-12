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
			scale : in std_logic_vector(3 downto 0);
			
            box_x_positionIn: in std_logic_vector(9 downto 0);
            box_y_positionIn: in std_logic_vector(9 downto 0);
			
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

signal scale_counter: integer:= 0;
signal scaleInt : integer;


--for accessing letter number matrix's, LNX is letter number where X = 1,2,3
-- only need one y index since itll be the same across
signal xindexforEachLetter: integer:= 0;

signal xtotalIndex: integer:= 0;
signal ytotalIndex: integer:= 0;

signal box_x_positionInt: integer:= 0;
signal box_y_positionInt: integer:= 0;



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
 scaleInt <= to_integer(unsigned(scale));
 
 
pixelOnorOff: process(scan_line_x, scan_line_y, box_x_positionInt, box_y_positionInt) begin
	-- case statement or something to choose 3 letters(numbers). result will give values to
	-- SelectedLetterFirstDigit, SelectedLetterSecondDigit, and SelectedLetterThirdDigit

	--select the first number 
	if(reset = '1') then
	   xtotalIndex<= 0;
	   ytotalIndex<= 0;
	   scale_counter <= 0;
	else
	
        if(scan_line_x < "00111100000") then
            xtotalIndex <= box_x_positionInt;
        -- less than 480 (width of vga display)
            if(scale_counter = scaleInt - 1) then
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
                -- only update box_positions after a full cycle
                box_x_positionInt <= to_integer(unsigned(box_x_positionIn));
                box_y_positionInt <= to_integer(unsigned(box_y_positionIn));
            end if;
        end if;
        
        --reset the x index when in new character
        if(scan_line_x = box_x_positionInt + (34*scaleInt) - 1) then
               xindexforEachLetter <= 0;
        elsif(scan_line_x = box_x_positionInt) then
              xindexforEachLetter <= 0;
        elsif(scan_line_x = box_x_positionInt + (17*scaleInt) - 1) then
              xindexforEachLetter <= 0;
        elsif(scan_line_x = box_x_positionInt + (51*scaleInt) - 1) then
              xindexforEachLetter <= 0;  
        elsif(scan_line_x = box_x_positionInt + (68*scaleInt) - 1) then
              xindexforEachLetter <= 0;
        elsif(scan_line_x = box_x_positionInt + (85*scaleInt) - 1) then
              xindexforEachLetter <= 0;
        elsif(scan_line_x >= (box_x_positionInt + (102 * scaleInt) - 1)) then
              xindexforEachLetter <= 0;
        end if;
        
        --first character
        if(scan_line_x >= box_x_positionInt and scan_line_x < (box_x_positionInt + (17* scaleInt))) then
            currentCharacter <= SelectedLetterFirstDigit;
        
        --second character
        elsif(scan_line_x >= (box_x_positionInt + (17*scaleInt)) and scan_line_x < (box_x_positionInt + (34* scaleInt))) then
            currentCharacter <= SelectedLetterSecondDigit;
        
        --point 
        elsif(scan_line_x >= (box_x_positionInt + (34*scaleInt)) and scan_line_x < (box_x_positionInt + (51* scaleInt))) then
            currentCharacter <= point;  
            
        -- third character      
        elsif(scan_line_x >= (box_x_positionInt + (51*scaleInt)) and scan_line_x < (box_x_positionInt + (68* scaleInt))) then
            currentCharacter <= SelectedLetterThirdDigit;
            
        -- "C"
        elsif(scan_line_x >= (box_x_positionInt + (68*scaleInt)) and scan_line_x < (box_x_positionInt + (85* scaleInt))) then
            currentCharacter <= C;
        
        -- "M"
        elsif(scan_line_x >= (box_x_positionInt + (85*scaleInt)) and scan_line_x < (box_x_positionInt + (102* scaleInt))) then
            currentCharacter <= M;
            
        end if;
            
    
        --if((scan_line_x <= (box_x_positionInt + (102* scaleInt))) and (scan_line_x >= box_x_positionInt)) then
        --    if((currentCharacter(xindexforEachLetter, ytotalIndex) = 1) and (scan_line_x < 17 * 6 * scaleInt)) then
        --           pixel_color <= letter_color;
        --    else
        --           pixel_color <= "111111111111";
        --    end if;
        
        --end if;
    end if;
								
red   <= pixel_color(11 downto 8);
green <= pixel_color(7 downto 4);
blue  <= pixel_color(3 downto 0);
end process;



 
end behaviour;