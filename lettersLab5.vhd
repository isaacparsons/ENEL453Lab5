library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity letterslab5 is

	port (pixel_clkvga: in std_logic;
	       scan_line_x_l: in std_logic_vector(10 downto 0);
			scan_line_y_l: in std_logic_vector(10 downto 0);

            letter_color: in std_logic_vector(11 downto 0);
			scale : in std_logic_vector(3 downto 0);
			
			firstdigit : in std_logic_vector(3 downto 0);
			seconddigit : in std_logic_vector(3 downto 0);
			thirddigit : in std_logic_vector(3 downto 0);

			convertedscorevgain: in std_logic_vector(2 downto 0);

			box_x_positionin: in std_logic_vector(9 downto 0);
            box_y_positionin: in std_logic_vector(9 downto 0);
			
			red: out std_logic_vector(3 downto 0);
			blue: out std_logic_vector(3 downto 0);
			green: out std_logic_vector(3 downto 0)
		  );
end lettersLab5;

architecture behaviour of lettersLab5 is

type LetterMatrix is array(0 to 13, 0 to 12) of integer;

signal i_converted_score: LetterMatrix;

signal SelectedLetterFirstDigit: LetterMatrix;--:= ((0,0,0,1,1,1,1,1,1,1,0,0,0),		
--                                                   (0,0,1,1,1,1,1,1,1,1,1,0,0),
--                                                   (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                   (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                   (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                   (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                   (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                   (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                   (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                   (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                   (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                   (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                   (0,0,1,1,1,1,1,1,1,1,1,0,0),
--                                                   (0,0,0,1,1,1,1,1,1,1,0,0,0));--most significant

signal SelectedLetterSecondDigit: LetterMatrix;--:=((0,0,0,1,1,1,1,1,1,1,0,0,0),		
--                                                  (0,0,1,1,1,1,1,1,1,1,1,0,0),
--                                                  (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                  (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                  (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                  (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                  (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                  (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                  (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                  (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                  (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                  (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                  (0,0,1,1,1,1,1,1,1,1,1,0,0),
--                                                  (0,0,0,1,1,1,1,1,1,1,0,0,0));
signal SelectedLetterThirdDigit: LetterMatrix;--:= ((0,0,0,1,1,1,1,1,1,1,0,0,0),		
--                                                 (0,0,1,1,1,1,1,1,1,1,1,0,0),
--                                                 (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                 (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                 (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                 (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                 (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                 (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                 (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                 (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                 (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                 (0,0,1,1,0,0,0,0,0,1,1,0,0),
--                                                 (0,0,1,1,1,1,1,1,1,1,1,0,0),
--                                                 (0,0,0,1,1,1,1,1,1,1,0,0,0));
--current letter being "drawn" by the vga
signal currentCharacter: LetterMatrix:= ((0,0,0,1,1,1,1,1,1,1,0,0,0),	
							  (0,0,1,1,1,1,1,1,1,1,1,0,0),
							  (0,0,1,1,0,0,0,0,0,1,1,0,0),
							  (0,0,0,0,0,0,0,0,0,1,1,0,0),
							  (0,0,0,0,0,0,0,0,0,1,1,0,0),
							  (0,0,0,0,0,0,0,0,0,1,1,0,0),
							  (0,0,0,0,0,0,0,0,1,1,1,0,0),
							  (0,0,0,0,0,0,0,1,1,1,0,0,0),
							  (0,0,0,0,0,0,1,1,1,0,0,0,0),
							  (0,0,0,0,0,1,1,1,0,0,0,0,0),
							  (0,0,0,0,1,1,1,0,0,0,0,0,0),
							  (0,0,0,1,1,1,0,0,0,0,0,0,0),
							  (0,0,1,1,1,1,1,1,1,1,1,0,0),
							  (0,0,1,1,1,1,1,1,1,1,1,0,0));


constant empty: LetterMatrix:=((0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0));

constant zero: LetterMatrix:= ((0,0,0,1,1,1,1,1,1,1,0,0,0),		
							   (0,0,1,1,1,1,1,1,1,1,1,0,0),
							   (0,0,1,1,0,0,0,0,0,1,1,0,0),
							   (0,0,1,1,0,0,0,0,0,1,1,0,0),
							   (0,0,1,1,0,0,0,0,0,1,1,0,0),
							   (0,0,1,1,0,0,0,0,0,1,1,0,0),
							   (0,0,1,1,0,0,0,0,0,1,1,0,0),
							   (0,0,1,1,0,0,0,0,0,1,1,0,0),
							   (0,0,1,1,0,0,0,0,0,1,1,0,0),
							   (0,0,1,1,0,0,0,0,0,1,1,0,0),
							   (0,0,1,1,0,0,0,0,0,1,1,0,0),
							   (0,0,1,1,0,0,0,0,0,1,1,0,0),
							   (0,0,1,1,1,1,1,1,1,1,1,0,0),
							   (0,0,0,1,1,1,1,1,1,1,0,0,0));

constant one: LetterMatrix:= ((0,0,0,0,0,1,1,1,0,0,0,0,0),	
							  (0,0,0,0,1,1,1,1,0,0,0,0,0),
							  (0,0,0,0,0,0,1,1,0,0,0,0,0),
							  (0,0,0,0,0,0,1,1,0,0,0,0,0),
							  (0,0,0,0,0,0,1,1,0,0,0,0,0),
							  (0,0,0,0,0,0,1,1,0,0,0,0,0),
							  (0,0,0,0,0,0,1,1,0,0,0,0,0),
							  (0,0,0,0,0,0,1,1,0,0,0,0,0),
							  (0,0,0,0,0,0,1,1,0,0,0,0,0),
							  (0,0,0,0,0,0,1,1,0,0,0,0,0),
							  (0,0,0,0,0,0,1,1,0,0,0,0,0),
							  (0,0,0,0,0,0,1,1,0,0,0,0,0),
							  (0,0,0,0,1,1,1,1,1,1,0,0,0),
							  (0,0,0,0,1,1,1,1,1,1,0,0,0));

constant two: LetterMatrix:= ((0,0,0,1,1,1,1,1,1,1,0,0,0),	
							  (0,0,1,1,1,1,1,1,1,1,1,0,0),
							  (0,0,1,1,0,0,0,0,0,1,1,0,0),
							  (0,0,0,0,0,0,0,0,0,1,1,0,0),
							  (0,0,0,0,0,0,0,0,0,1,1,0,0),
							  (0,0,0,0,0,0,0,0,0,1,1,0,0),
							  (0,0,0,0,0,0,0,0,1,1,1,0,0),
							  (0,0,0,0,0,0,0,1,1,1,0,0,0),
							  (0,0,0,0,0,0,1,1,1,0,0,0,0),
							  (0,0,0,0,0,1,1,1,0,0,0,0,0),
							  (0,0,0,0,1,1,1,0,0,0,0,0,0),
							  (0,0,0,1,1,1,0,0,0,0,0,0,0),
							  (0,0,1,1,1,1,1,1,1,1,1,0,0),
							  (0,0,1,1,1,1,1,1,1,1,1,0,0));

constant three: LetterMatrix:= ((0,0,1,1,1,1,1,1,1,1,1,0,0),	
							    (0,0,1,1,1,1,1,1,1,1,1,0,0),
							    (0,0,0,0,0,0,0,0,1,1,1,0,0),
							    (0,0,0,0,0,0,0,1,1,1,0,0,0),
							    (0,0,0,0,0,0,1,1,1,0,0,0,0),
							    (0,0,0,0,0,1,1,1,0,0,0,0,0),
							    (0,0,0,0,1,1,1,1,1,1,0,0,0),
							    (0,0,0,0,1,1,1,1,1,1,1,0,0),
							    (0,0,0,0,0,0,0,0,0,1,1,0,0),
							    (0,0,0,0,0,0,0,0,0,1,1,0,0),
							    (0,0,0,0,0,0,0,0,0,1,1,0,0),
							    (0,0,1,1,0,0,0,0,0,1,1,0,0),
							    (0,0,1,1,1,1,1,1,1,1,1,0,0),
							    (0,0,0,1,1,1,1,1,1,1,0,0,0));
							   
constant four: LetterMatrix:= ((0,0,0,0,0,0,1,1,1,0,0,0,0),	
							   (0,0,0,0,0,1,1,1,1,0,0,0,0),
							   (0,0,0,0,1,1,0,1,1,0,0,0,0),
							   (0,0,0,0,1,1,0,1,1,0,0,0,0),
							   (0,0,0,1,1,0,0,1,1,0,0,0,0),
							   (0,0,0,1,1,0,0,1,1,0,0,0,0),
							   (0,0,1,1,0,0,0,1,1,0,0,0,0),
							   (0,0,1,1,0,0,0,1,1,0,0,0,0),
							   (0,1,1,0,0,0,0,1,1,0,0,0,0),
							   (0,1,1,1,1,1,1,1,1,1,1,0,0),
							   (0,1,1,1,1,1,1,1,1,1,1,0,0),
							   (0,0,0,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,0,0,0,1,1,0,0,0,0),
							   (0,0,0,0,0,0,0,1,1,0,0,0,0));							   


constant five: LetterMatrix:= ((0,0,1,1,1,1,1,1,1,1,1,0,0),		
							   (0,0,1,1,1,1,1,1,1,1,1,0,0),
							   (0,0,1,1,0,0,0,0,0,0,0,0,0),
							   (0,0,1,1,0,0,0,0,0,0,0,0,0),
							   (0,0,1,1,0,0,0,0,0,0,0,0,0),
							   (0,0,1,1,0,0,0,0,0,0,0,0,0),
							   (0,0,1,1,1,1,1,1,1,1,0,0,0),
							   (0,0,0,1,1,1,1,1,1,1,1,0,0),
							   (0,0,0,0,0,0,0,0,0,1,1,0,0),
							   (0,0,0,0,0,0,0,0,0,1,1,0,0),
							   (0,0,0,0,0,0,0,0,0,1,1,0,0),
							   (0,0,1,1,0,0,0,0,0,1,1,0,0),
							   (0,0,1,1,1,1,1,1,1,1,1,0,0),
							   (0,0,0,1,1,1,1,1,1,1,0,0,0));
							   
							   
constant six: LetterMatrix:= ((0,0,0,1,1,1,1,1,1,1,0,0,0),	
							  (0,0,1,1,1,1,1,1,1,1,1,0,0),
							  (0,0,1,1,0,0,0,0,0,1,1,0,0),
							  (0,0,1,1,0,0,0,0,0,0,0,0,0),
							  (0,0,1,1,0,0,0,0,0,0,0,0,0),
							  (0,0,1,1,0,0,0,0,0,0,0,0,0),
							  (0,0,1,1,1,1,1,1,1,1,0,0,0),
							  (0,0,1,1,1,1,1,1,1,1,1,0,0),
							  (0,0,1,1,0,0,0,0,0,1,1,0,0),
							  (0,0,1,1,0,0,0,0,0,1,1,0,0),
							  (0,0,1,1,0,0,0,0,0,1,1,0,0),
							  (0,0,1,1,0,0,0,0,0,1,1,0,0),
							  (0,0,1,1,1,1,1,1,1,1,1,0,0),
							  (0,0,0,1,1,1,1,1,1,1,0,0,0));
							   
							   
constant seven: LetterMatrix:= ((0,0,1,1,1,1,1,1,1,1,1,0,0),		
							    (0,0,1,1,1,1,1,1,1,1,1,0,0),
							    (0,0,0,0,0,0,0,0,0,1,1,0,0),
							    (0,0,0,0,0,0,0,0,1,1,0,0,0),
							    (0,0,0,0,0,0,0,0,1,1,0,0,0),
							    (0,0,0,0,0,0,0,1,1,0,0,0,0),
							    (0,0,0,0,0,0,0,1,1,0,0,0,0),
							    (0,0,0,0,0,0,1,1,0,0,0,0,0),
							    (0,0,0,0,0,0,1,1,0,0,0,0,0),
							    (0,0,0,0,0,1,1,0,0,0,0,0,0),
							    (0,0,0,0,0,1,1,0,0,0,0,0,0),
							    (0,0,0,0,1,1,0,0,0,0,0,0,0),
							    (0,0,0,0,1,1,0,0,0,0,0,0,0),
							    (0,0,0,0,1,1,0,0,0,0,0,0,0));
							   
							   
constant eight: LetterMatrix:= ((0,0,0,1,1,1,1,1,1,1,0,0,0),	
							    (0,0,1,1,1,1,1,1,1,1,1,0,0),
							    (0,0,1,1,0,0,0,0,0,1,1,0,0),
							    (0,0,1,1,0,0,0,0,0,1,1,0,0),
							    (0,0,1,1,0,0,0,0,0,1,1,0,0),
							    (0,0,1,1,0,0,0,0,0,1,1,0,0),
							    (0,0,0,1,1,1,1,1,1,1,0,0,0),
							    (0,0,0,1,1,1,1,1,1,1,0,0,0),
							    (0,0,1,1,0,0,0,0,0,1,1,0,0),
							    (0,0,1,1,0,0,0,0,0,1,1,0,0),
							    (0,0,1,1,0,0,0,0,0,1,1,0,0),
							    (0,0,1,1,0,0,0,0,0,1,1,0,0),
							    (0,0,1,1,1,1,1,1,1,1,1,0,0),
							    (0,0,0,1,1,1,1,1,1,1,0,0,0));
							   
							   
constant nine: LetterMatrix:= ((0,0,0,1,1,1,1,1,1,1,0,0,0),	
							   (0,0,1,1,1,1,1,1,1,1,1,0,0),
							   (0,0,1,1,0,0,0,0,0,1,1,0,0),
							   (0,0,1,1,0,0,0,0,0,1,1,0,0),
							   (0,0,1,1,0,0,0,0,0,1,1,0,0),
							   (0,0,1,1,0,0,0,0,0,1,1,0,0),
							   (0,0,0,1,1,1,1,1,1,1,0,0,0),
							   (0,0,0,1,1,1,1,1,1,1,0,0,0),
							   (0,0,0,0,0,0,0,0,0,1,1,0,0),
							   (0,0,0,0,0,0,0,0,0,1,1,0,0),
							   (0,0,0,0,0,0,0,0,0,1,1,0,0),
							   (0,0,0,1,1,0,0,0,0,1,1,0,0),
							   (0,0,1,1,1,1,1,1,1,1,1,0,0),
							   (0,0,0,1,1,1,1,1,1,1,0,0,0));
							   
constant point: LetterMatrix:=((0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,1,1,0,0,0,0,0,0),
							   (0,0,0,0,0,1,1,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0));
							   
constant C: LetterMatrix:=((0,0,0,1,1,1,1,1,1,1,0,0,0),
                              (0,0,1,1,1,1,1,1,1,1,1,0,0),
                              (0,0,1,1,0,0,0,0,0,1,1,0,0),
                              (0,0,1,1,0,0,0,0,0,0,0,0,0),
                              (0,0,1,1,0,0,0,0,0,0,0,0,0),
                              (0,0,1,1,0,0,0,0,0,0,0,0,0),
                              (0,0,1,1,0,0,0,0,0,0,0,0,0),
                              (0,0,1,1,0,0,0,0,0,0,0,0,0),
                              (0,0,1,1,0,0,0,0,0,0,0,0,0),
                              (0,0,1,1,0,0,0,0,0,0,0,0,0),
                              (0,0,1,1,0,0,0,0,0,0,0,0,0),
                              (0,0,1,1,0,0,0,0,0,1,1,0,0),
                              (0,0,1,1,1,1,1,1,1,1,1,0,0),
                              (0,0,0,1,1,1,1,1,1,1,0,0,0));
                              
constant M: LetterMatrix:=((1,1,1,1,1,0,0,1,1,1,0,0,0),
                             (1,1,1,1,1,1,1,1,1,1,1,0,0),
                             (1,1,0,0,0,1,1,0,0,0,1,1,0),
                             (1,1,0,0,0,1,1,0,0,0,1,1,0),
                             (1,1,0,0,0,1,1,0,0,0,1,1,0),
                             (1,1,0,0,0,1,1,0,0,0,1,1,0),
                             (1,1,0,0,0,1,1,0,0,0,1,1,0),
                             (1,1,0,0,0,1,1,0,0,0,1,1,0),
                             (1,1,0,0,0,1,1,0,0,0,1,1,0),
                             (1,1,0,0,0,1,1,0,0,0,1,1,0),
                             (1,1,0,0,0,1,1,0,0,0,1,1,0),
                             (1,1,0,0,0,1,1,0,0,0,1,1,0),
                             (1,1,0,0,0,1,1,0,0,0,1,1,0),
                             (1,1,0,0,0,1,1,0,0,0,1,1,0));
                           
constant S: LetterMatrix:=((0,0,0,0,0,0,0,0,0,0,0,0,0),
                          (0,0,0,0,0,0,0,0,0,0,0,0,0),
                          (0,0,0,1,1,1,1,1,1,1,1,0,0),
                          (0,0,1,1,1,1,1,1,1,1,1,0,0),
                          (0,0,1,1,0,0,0,0,0,0,0,0,0),
                          (0,0,1,1,0,0,0,0,0,0,0,0,0),
                          (0,0,1,1,1,1,1,1,1,1,0,0,0),
                          (0,0,0,1,1,1,1,1,1,1,1,0,0),
                          (0,0,0,0,0,0,0,0,0,1,1,0,0),
                          (0,0,0,0,0,0,0,0,0,1,1,0,0),
                          (0,0,1,1,1,1,1,1,1,1,1,0,0),
                          (0,0,1,1,1,1,1,1,1,1,0,0,0),
                          (0,0,0,0,0,0,0,0,0,0,0,0,0),
                          (0,0,0,0,0,0,0,0,0,0,0,0,0));
                          
constant Clower: LetterMatrix:=((0,0,0,0,0,0,0,0,0,0,0,0,0),
                                (0,0,0,0,0,0,0,0,0,0,0,0,0),
                                (0,0,0,1,1,1,1,1,1,1,0,0,0),
                            (0,0,1,1,1,1,1,1,1,1,1,0,0),
                            (0,0,1,1,0,0,0,0,0,1,1,0,0),
                            (0,0,1,1,0,0,0,0,0,0,0,0,0),
                            (0,0,1,1,0,0,0,0,0,0,0,0,0),
                            (0,0,1,1,0,0,0,0,0,0,0,0,0),
                            (0,0,1,1,0,0,0,0,0,0,0,0,0),
                            (0,0,1,1,0,0,0,0,0,1,1,0,0),
                            (0,0,1,1,1,1,1,1,1,1,1,0,0),
                            (0,0,0,1,1,1,1,1,1,1,0,0,0),
                            (0,0,0,0,0,0,0,0,0,0,0,0,0),
                            (0,0,0,0,0,0,0,0,0,0,0,0,0));
                          
constant O: LetterMatrix:=((0,0,0,0,0,0,0,0,0,0,0,0,0),
                          (0,0,0,0,0,0,0,0,0,0,0,0,0),
                          (0,0,0,1,1,1,1,1,1,1,0,0,0),		
                         (0,0,1,1,1,1,1,1,1,1,1,0,0),
                         (0,0,1,1,0,0,0,0,0,1,1,0,0),
                         (0,0,1,1,0,0,0,0,0,1,1,0,0),
                         (0,0,1,1,0,0,0,0,0,1,1,0,0),
                         (0,0,1,1,0,0,0,0,0,1,1,0,0),
                         (0,0,1,1,0,0,0,0,0,1,1,0,0),
                         (0,0,1,1,0,0,0,0,0,1,1,0,0),
                         (0,0,1,1,1,1,1,1,1,1,1,0,0),
                         (0,0,0,1,1,1,1,1,1,1,0,0,0),
                         (0,0,0,0,0,0,0,0,0,0,0,0,0),
                         (0,0,0,0,0,0,0,0,0,0,0,0,0));
                            
constant R: LetterMatrix:=((0,0,0,0,0,0,0,0,0,0,0,0,0),
                            (0,0,0,0,0,0,0,0,0,0,0,0,0),
                            (0,0,0,0,1,1,0,1,1,1,0,0,0),
                            (0,0,0,0,1,1,1,1,1,1,0,0,0),
                            (0,0,0,0,1,1,1,0,0,0,0,0,0),
                            (0,0,0,0,1,1,0,0,0,0,0,0,0),
                            (0,0,0,0,1,1,0,0,0,0,0,0,0),
                            (0,0,0,0,1,1,0,0,0,0,0,0,0),
                            (0,0,0,0,1,1,0,0,0,0,0,0,0),
                            (0,0,0,0,1,1,0,0,0,0,0,0,0),
                            (0,0,0,0,1,1,0,0,0,0,0,0,0),
                            (0,0,0,0,1,1,0,0,0,0,0,0,0),
                            (0,0,0,0,0,0,0,0,0,0,0,0,0),
                            (0,0,0,0,0,0,0,0,0,0,0,0,0));
                            
constant E: LetterMatrix:=((0,0,0,0,0,0,0,0,0,0,0,0,0),
                            (0,0,0,0,0,0,0,0,0,0,0,0,0),
                            (0,0,0,1,1,1,1,1,1,1,0,0,0),
                            (0,0,1,1,1,1,1,1,1,1,1,0,0),
                            (0,0,1,1,0,0,0,0,0,1,1,0,0),
                            (0,0,1,1,0,0,0,0,0,1,1,0,0),
                            (0,0,1,1,1,1,1,1,1,1,1,0,0),
                            (0,0,1,1,1,1,1,1,1,1,0,0,0),
                            (0,0,1,1,0,0,0,0,0,0,0,0,0),
                            (0,0,1,1,0,0,0,0,0,0,0,0,0),
                            (0,0,1,1,1,1,1,1,1,1,1,0,0),
                            (0,0,0,1,1,1,1,1,1,1,1,0,0),
                            (0,0,0,0,0,0,0,0,0,0,0,0,0),
                            (0,0,0,0,0,0,0,0,0,0,0,0,0));

constant colon: LetterMatrix:=((0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,1,1,0,0,0,0,0,0),
							   (0,0,0,0,0,1,1,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,1,1,0,0,0,0,0,0),
							   (0,0,0,0,0,1,1,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0),
							   (0,0,0,0,0,0,0,0,0,0,0,0,0));
 
 --add buttons to move the letters around up down left and right to sensitivity list
signal pixel_color: std_logic_vector(11 downto 0);
signal scaleInt : integer;
 
signal xindexforEachLetter: integer:= 0;
signal ytotalIndex: integer:= 0;
 
signal box_x_positionInt: integer:= 0;
signal box_y_positionInt: integer:= 0;
 
signal scan_line_x_INT: integer;
signal scan_line_y_INT: integer;
 
constant downScreenBound : std_logic_vector(10 downto 0):= "00111011111"; -- 479
constant rightScreenBound : std_logic_vector(10 downto 0):= "01001111111"; -- 639
 
type ArrayofLetters is array(0 to 12) of LetterMatrix;
constant LettersArray: ArrayofLetters:= (zero, one, two, three, four, five, six, seven, eight, nine, point, C, M);

begin

scaleInt <= to_integer(unsigned(scale));

SelectedLetterFirstDigit <= LettersArray(to_integer(unsigned(firstDigit + 4)));
SelectedLetterSecondDigit <= LettersArray(to_integer(unsigned(secondDigit)));
SelectedLetterThirdDigit <= LettersArray(to_integer(unsigned(thirdDigit)));
i_converted_score <= LettersArray(to_integer(unsigned("0"&ConvertedScoreVGAIn)));

box_x_positionInt <= to_integer(unsigned(box_x_positionIn));
box_y_positionInt <= to_integer(unsigned(box_y_positionIn));
 
updatePixel: process(pixel_clkVGA, scan_line_x_l, scan_line_y_l) begin
    scan_line_x_INT <= to_integer(unsigned(scan_line_x_l));
    scan_line_y_INT <= to_integer(unsigned(scan_line_y_l));
    if(rising_edge(pixel_clkVGA)) then
        if((scan_line_x_INT >= box_x_positionInt) and (scan_line_x_INT < box_x_positionInt + (13*scaleInt*6))) then
            if((scan_line_x_INT mod scaleInt = 0) and (scan_line_x_INT /= 0))then
                if(xindexforEachLetter < 12)then
                    xindexforEachLetter <= xindexforEachLetter +1;
                else
                    xindexforEachLetter<= 0;
                end if;
            end if;
        end if;
        if(scan_line_y_INT = 1) then
            ytotalIndex <= 0;
        end if;
        if(scan_line_x_INT = 1) then
           xindexforEachLetter <= 0;
        end if;

        
        if(scan_line_x_INT = 639 and scan_line_y_INT < (scaleInt * 3 * 14))then
            if(scan_line_y_INT mod scaleInt = 0) then
                if(ytotalIndex < 13)then
                    ytotalIndex <= ytotalIndex +1;
                else
                    ytotalIndex <= 0;
                end if;
            end if;
        end if;
        
        
        --first character
        if(scan_line_y_INT >= box_y_positionInt and scan_line_y_INT < (box_y_positionInt + (14* scaleInt))) then
            if(scan_line_x_INT >= box_x_positionInt and scan_line_x_INT < (box_x_positionInt + (13* scaleInt))) then
                currentCharacter <= SelectedLetterFirstDigit;
            
            --second character
            elsif(scan_line_x_INT >= (box_x_positionInt + (13*scaleInt)) and scan_line_x_INT < (box_x_positionInt + (13*2* scaleInt))) then
                currentCharacter <= SelectedLetterSecondDigit;
            
            --point 
            elsif(scan_line_x_INT >= (box_x_positionInt + (13*2*scaleInt)) and scan_line_x_INT < (box_x_positionInt + (13*3* scaleInt))) then
                currentCharacter <= point;  
                
            -- third character      
            elsif(scan_line_x_INT >= (box_x_positionInt + (13*3*scaleInt)) and scan_line_x_INT < (box_x_positionInt + (13*4* scaleInt))) then
                currentCharacter <= SelectedLetterThirdDigit;
                
            -- "C"
            elsif(scan_line_x_INT >= (box_x_positionInt + (13*4*scaleInt)) and scan_line_x_INT < (box_x_positionInt + (13*5* scaleInt))) then
                currentCharacter <= C;
            
            -- "M"
            elsif(scan_line_x_INT >= (box_x_positionInt + (13*5*scaleInt)) and scan_line_x_INT < (box_x_positionInt + (13*6* scaleInt))) then
                currentCharacter <= M;
                
            end if;
        elsif(scan_line_y_INT >= (box_y_positionInt + (14* scaleInt)) and scan_line_y_INT < (box_y_positionInt + (14*2* scaleInt))) then
            --S
            if(scan_line_x_INT >= box_x_positionInt and scan_line_x_INT < (box_x_positionInt + (13* scaleInt))) then
                        currentCharacter <= S;
                    
            --C
            elsif(scan_line_x_INT >= (box_x_positionInt + (13*scaleInt)) and scan_line_x_INT < (box_x_positionInt + (13*2* scaleInt))) then
                currentCharacter <= Clower;
            
            --O
            elsif(scan_line_x_INT >= (box_x_positionInt + (13*2*scaleInt)) and scan_line_x_INT < (box_x_positionInt + (13*3* scaleInt))) then
                currentCharacter <= O;  
                
            -- R   
            elsif(scan_line_x_INT >= (box_x_positionInt + (13*3*scaleInt)) and scan_line_x_INT < (box_x_positionInt + (13*4* scaleInt))) then
                currentCharacter <= R;
                
            -- E
            elsif(scan_line_x_INT >= (box_x_positionInt + (13*4*scaleInt)) and scan_line_x_INT < (box_x_positionInt + (13*5* scaleInt))) then
                currentCharacter <= E;
            
            -- colon
            elsif(scan_line_x_INT >= (box_x_positionInt + (13*5*scaleInt)) and scan_line_x_INT < (box_x_positionInt + (13*6* scaleInt))) then
                currentCharacter <= colon;
                        
            end if;
        elsif(scan_line_y_INT >= (box_y_positionInt + (14*2* scaleInt)) and scan_line_y_INT < (box_y_positionInt + (14*3* scaleInt)))then
            if(scan_line_x_INT >= box_x_positionInt and scan_line_x_INT < (box_x_positionInt + (13* scaleInt))) then
                                currentCharacter <= empty;
                    
            --C
            elsif(scan_line_x_INT >= (box_x_positionInt + (13*scaleInt)) and scan_line_x_INT < (box_x_positionInt + (13*2* scaleInt))) then
                currentCharacter <= empty;
            
            --O
            elsif(scan_line_x_INT >= (box_x_positionInt + (13*2*scaleInt)) and scan_line_x_INT < (box_x_positionInt + (13*3* scaleInt))) then
                currentCharacter <= empty;  
                
            -- R   
            elsif(scan_line_x_INT >= (box_x_positionInt + (13*3*scaleInt)) and scan_line_x_INT < (box_x_positionInt + (13*4* scaleInt))) then
                currentCharacter <= i_converted_score;
                
            -- E
            elsif(scan_line_x_INT >= (box_x_positionInt + (13*4*scaleInt)) and scan_line_x_INT < (box_x_positionInt + (13*5* scaleInt))) then
                currentCharacter <= empty;
            
            -- colon
            elsif(scan_line_x_INT >= (box_x_positionInt + (13*5*scaleInt)) and scan_line_x_INT < (box_x_positionInt + (13*6* scaleInt))) then
                currentCharacter <= empty;
                        
            end if;
        end if;

        if(scan_line_y_INT < box_y_positionInt or (scan_line_y_INT > box_y_positionInt + (scaleInt * 14*3))) then
            pixel_color <="111111111111";
        elsif((currentCharacter(ytotalIndex, xindexforEachLetter) = 1)) then
             pixel_color <= letter_color;
        else 
            pixel_color <= "111111111111";
        end if;  
    end if;
    
        
end process;	

red   <= pixel_color(11 downto 8);
green <= pixel_color(7 downto 4);
blue  <= pixel_color(3 downto 0);


 
end behaviour;