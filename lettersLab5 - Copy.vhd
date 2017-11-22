library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lettersLab5 is
	
	Port ( 	clk : in  STD_LOGIC;
			reset : in  STD_LOGIC;
			scan_line_x_l: in STD_LOGIC_VECTOR(10 downto 0);
			scan_line_y_l: in STD_LOGIC_VECTOR(10 downto 0);
            letter_color: in STD_LOGIC_VECTOR(11 downto 0);
			scale : in std_logic_vector(3 downto 0);
			
			firstDigit : in std_logic_vector(3 downto 0);
			secondDigit : in std_logic_vector(3 downto 0);
			thirdDigit : in std_logic_vector(3 downto 0);
			
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

signal SelectedLetterFirstDigit: LetterMatrix:= ((0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),		
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
                                               (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                               (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                               (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)); --most significant
signal SelectedLetterSecondDigit: LetterMatrix:=((0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),		
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
                                              (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                              (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                              (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
signal SelectedLetterThirdDigit: LetterMatrix:= ((0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),		
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
                                             (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                             (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                             (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));

--current letter being "drawn" by the vga
signal currentCharacter: LetterMatrix;

signal scale_counter: integer:= 0;
signal scaleInt : integer:= 1;

signal scale_counter_y: integer:= 0;


--for accessing letter number matrix's, LNX is letter number where X = 1,2,3
-- only need one y index since itll be the same across
signal xindexforEachLetter: integer:= 0;

signal xtotalIndex: integer:= 0;
signal ytotalIndex: integer:= 0;

signal box_x_positionInt: integer:= 0;
signal box_y_positionInt: integer:= 0;

signal testInt : integer;

--signal i_scan_line_x: std_logic_vector;

constant rightScreenBound : std_logic_vector(10 downto 0):= "00111011111"; -- 479
constant downScreenBound : std_logic_vector(10 downto 0):= "01001111111"; -- 639


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
 
selectedLetter: process(reset, clk) begin
    if (reset = '1') then
        SelectedLetterFirstDigit <= zero;
        SelectedLetterSecondDigit <= zero;
        SelectedLetterThirdDigit <= zero;
    elsif(rising_edge(clk)) then
        if(firstDigit = "0000") then
            SelectedLetterFirstDigit <= zero;
        elsif(firstDigit = "0001") then
            SelectedLetterFirstDigit <= one;
        elsif(firstDigit = "0010") then
             SelectedLetterFirstDigit <= two;
        elsif(firstDigit = "0011") then
             SelectedLetterFirstDigit <= three;   
        end if;
        
        --second digit
        if(secondDigit = "0000") then
            SelectedLetterSecondDigit <= zero;
        elsif(secondDigit = "0001") then
            SelectedLetterSecondDigit <= one;
        elsif(secondDigit = "0010") then
             SelectedLetterSecondDigit <= two;
        elsif(secondDigit = "0011") then
             SelectedLetterSecondDigit <= three;
        elsif(secondDigit = "0100") then
             SelectedLetterSecondDigit <= four;  
        elsif(secondDigit = "0101") then
              SelectedLetterSecondDigit <= five;  
        elsif(secondDigit = "0110") then
              SelectedLetterSecondDigit <= six;  
        elsif(secondDigit = "0111") then
              SelectedLetterSecondDigit <= seven;  
        elsif(secondDigit = "1000") then
              SelectedLetterSecondDigit <= eight;  
        elsif(secondDigit = "1001") then
              SelectedLetterSecondDigit <= nine;                                                                                                                                                                                                               
        end if;
        
        -- third digit
        if(thirdDigit = "0000") then
            SelectedLetterThirdDigit <= zero;
        elsif(thirdDigit = "0001") then
            SelectedLetterThirdDigit <= one;
        elsif(thirdDigit = "0010") then
             SelectedLetterThirdDigit <= two;
        elsif(thirdDigit = "0011") then
             SelectedLetterThirdDigit <= three;
        elsif(thirdDigit = "0100") then
             SelectedLetterThirdDigit <= four;  
        elsif(thirdDigit = "0101") then
              SelectedLetterThirdDigit <= five;  
        elsif(thirdDigit = "0110") then
              SelectedLetterThirdDigit <= six;  
        elsif(thirdDigit = "0111") then
              SelectedLetterThirdDigit <= seven;  
        elsif(thirdDigit = "1000") then
              SelectedLetterThirdDigit <= eight;  
        elsif(thirdDigit = "1001") then
              SelectedLetterThirdDigit <= nine;                                                                                                                                                                                                               
        end if;
    
    end if;
    
end process;
 
 
pixelOnorOff: process(clk) begin--scan_line_x_l, scan_line_y_l) begin
	-- case statement or something to choose 3 letters(numbers). result will give values to
	-- SelectedLetterFirstDigit, SelectedLetterSecondDigit, and SelectedLetterThirdDigit

	--select the first number 
	if(reset = '1') then
	   ytotalIndex<= 0;
	   scale_counter <= 0;
	   xindexforEachLetter <= 0;
	end if;           
    if(scan_line_x_l < rightScreenBound) then
    -- less than 480 (width of vga display)
        if((scale_counter = scaleInt - 1) or (to_integer(unsigned(scan_line_x_l)) = box_x_positionInt)) then
                scale_counter <= 0;
                xindexforEachLetter<= xindexforEachLetter+1;
        else
                scale_counter <= scale_counter + 1;
        end if;
    else
        --ytotalIndex<= 0;
        -- if scan_line_x equals 480 increment ytotalIndex
        if(scan_line_y_l < downScreenBound) then
            if(scan_line_y_l >= box_y_positionInt) then
                if(scale_counter_y = scaleInt - 1) then
                   if(ytotalIndex = 13) then
                       ytotalIndex <= 0;
                   else
                      ytotalIndex <= ytotalIndex + 1;
                   end if;
                    scale_counter_y <= 0;
                else
                        scale_counter_y <= scale_counter_y + 1;
                end if;
            else
                ytotalIndex <= 0;
            end if;
            
        else
            ytotalIndex<= 0;
            -- only update box_positions after a full cycle
            box_x_positionInt <= to_integer(unsigned(box_x_positionIn));
            box_y_positionInt <= to_integer(unsigned(box_y_positionIn));
        end if;
        
        -- reset the x index when in new character
		-- case where box_x_positionInt = 0 and scan_line_x = 0 is handled in the reset of a new x line
		if(scan_line_x_l = box_x_positionInt) then
			   xindexforEachLetter <= 0;
		elsif(scan_line_x_l = box_x_positionInt + (34*scaleInt)) then
               xindexforEachLetter <= 0;
        elsif(scan_line_x_l = box_x_positionInt + (17*scaleInt)) then
              xindexforEachLetter <= 0;
        elsif(scan_line_x_l = box_x_positionInt + (51*scaleInt)) then
              xindexforEachLetter <= 0;  
        elsif(scan_line_x_l = box_x_positionInt + (68*scaleInt)) then
              xindexforEachLetter <= 0;
        elsif(scan_line_x_l = box_x_positionInt + (85*scaleInt)) then
              xindexforEachLetter <= 0;
        elsif(scan_line_x_l >= (box_x_positionInt + (102 * scaleInt))) then
              xindexforEachLetter <= 0;
        end if;
        
        --first character
        if(scan_line_x_l >= box_x_positionInt and scan_line_x_l < (box_x_positionInt + (17* scaleInt))) then
            currentCharacter <= SelectedLetterFirstDigit;
        
        --second character
        elsif(scan_line_x_l >= (box_x_positionInt + (17*scaleInt)) and scan_line_x_l < (box_x_positionInt + (34* scaleInt))) then
            currentCharacter <= SelectedLetterSecondDigit;
        
        --point 
        elsif(scan_line_x_l >= (box_x_positionInt + (34*scaleInt)) and scan_line_x_l < (box_x_positionInt + (51* scaleInt))) then
            currentCharacter <= point;  
            
        -- third character      
        elsif(scan_line_x_l >= (box_x_positionInt + (51*scaleInt)) and scan_line_x_l < (box_x_positionInt + (68* scaleInt))) then
            currentCharacter <= SelectedLetterThirdDigit;
            
        -- "C"
        elsif(scan_line_x_l >= (box_x_positionInt + (68*scaleInt)) and scan_line_x_l < (box_x_positionInt + (85* scaleInt))) then
            currentCharacter <= C;
        
        -- "M"
        elsif(scan_line_x_l >= (box_x_positionInt + (85*scaleInt)) and scan_line_x_l < (box_x_positionInt + (102* scaleInt))) then
            currentCharacter <= M;
            
        end if;
            
		--testInt <= currentCharacter(ytotalindex,xindexforEachLetter);
        if(scan_line_y_l < box_y_positionInt or (scan_line_y_l > box_y_positionInt + (scaleInt * 14))) then
			pixel_color <="111111111111";
		elsif((currentCharacter(ytotalIndex, xindexforEachLetter) = 1)) then
			pixel_color <= letter_color;
		else 
			pixel_color <= "111111111111";
		
		end if;
        
       
    end if;
								
red   <= pixel_color(11 downto 8);
green <= pixel_color(7 downto 4);
blue  <= pixel_color(3 downto 0);
end process;



 
end behaviour;