library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lettersLab5testBench is
end lettersLab5testBench;

architecture behaviour of lettersLab5testBench is

	component lettersLab5
	
	Port ( 	clk : in  STD_LOGIC;
			reset : in  STD_LOGIC;
			scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
			scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
            letter_color: in STD_LOGIC_VECTOR(11 downto 0);
			--kHz: in STD_LOGIC; 
			scale : in std_logic_vector(3 downto 0);
			
			box_x_positionIn: in std_logic_vector(9 downto 0);
            box_y_positionIn: in std_logic_vector(9 downto 0);
            
            firstDigit : in std_logic_vector(1 downto 0);
            secondDigit : in std_logic_vector(3 downto 0);
            thirdDigit : in std_logic_vector(3 downto 0);
            
			red: out STD_LOGIC_VECTOR(3 downto 0);
			blue: out STD_LOGIC_VECTOR(3 downto 0);
			green: out std_logic_vector(3 downto 0)
		  );
	end component;
	
	component upcounter
	Generic ( 	max: integer:= 479;				
                            WIDTH: integer:= 11);
	Port (clk : in  STD_LOGIC;
                reset : in  STD_LOGIC;
                        -- removed enable 
                enable : in STD_LOGIC;
                value: out STD_LOGIC_VECTOR(WIDTH-1 downto 0));
    end component;
    
    component upcountery
    Generic ( 	max: integer:= 479;				
                            WIDTH: integer:= 3);
        Port ( clk : in  STD_LOGIC;
                   reset : in  STD_LOGIC;
                   Outvalue: out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
                 );
    end component;
	
	component VGAMoveLetters Port (clk : in  STD_LOGIC;
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
	end component;
    
constant clk_period : time := 24000 ns;
signal clk : std_logic := '0';
signal reset : std_logic:= '0';

signal firstDigit : std_logic_vector(1 downto 0):= "10";
signal secondDigit : std_logic_vector(3 downto 0):= "1000";
signal thirdDigit : std_logic_vector(3 downto 0):= "0011";

signal scan_line_y : STD_LOGIC_VECTOR(10 downto 0) := "00000000000";
signal scan_line_x : STD_LOGIC_VECTOR(10 downto 0) := "00000000000";
signal letter_color : STD_LOGIC_VECTOR(11 downto 0) := "000000000000";
signal red: STD_LOGIC_VECTOR(3 downto 0);
signal blue: STD_LOGIC_VECTOR(3 downto 0);
signal green: STD_LOGIC_VECTOR(3 downto 0);

signal scanxinInternal: std_logic_vector(10 downto 0);
signal scanyinInternal: std_logic_vector(10 downto 0);

signal enable: std_logic:= '1';

signal scale : std_logic_vector(3 downto 0):= "0011"; -- scale is 3

signal btnUp: std_logic:= '0';
signal btnDown: std_logic:= '0';
signal btnLeft: std_logic:= '0';
signal btnRight: std_logic:= '0';

signal increaseScale: std_logic:= '0';
signal decreaseScale: std_logic:= '0';
signal box_x_positionOut: std_logic_vector(9 downto 0):= "0000000000";
signal box_y_positionOut: std_logic_vector(9 downto 0):= "0000000000";
signal scaleOut: std_logic_vector(3 downto 0):= "0011";
  
		  
begin 


uut2: upcounter Generic Map(
    max => 479,
    width => 11
)
    Port Map(
    clk => clk,
    reset => reset, 
    enable => enable,
    value => scanxinInternal);

ycounter: upcountery Generic Map(
    max => 479,
    width => 11
)
    Port Map(
    clk => clk,
    reset => reset, 
    Outvalue => scanyinInternal);
uut: lettersLab5

	Port Map(
    clk => clk,
    reset => reset, 
    scan_line_x => scan_line_x,
    scan_line_y => scan_line_y,
    letter_color => letter_color,
	scale => scale,
	box_x_positionIn => box_x_positionOut,
	box_y_positionIn => box_y_positionOut,
	firstDigit => firstDigit,
	secondDigit => secondDigit,
	thirdDigit => thirdDigit,
    red => red,
    blue => blue,
    green => green);
    
uut3: VGAmoveLetters Port Map(
        clk => clk,
        reset => reset, 
        btnUp => btnUp,
        btnDown => btnDown,
        btnLeft => btnLeft,
        btnRight => btnRight,
        increaseScale => increaseScale,
        decreaseScale => decreaseScale,
        box_x_positionOut => box_x_positionOut,
        box_y_positionOut => box_y_positionOut,
        scaleOut => scaleOut);   
    
-- Clock process definitions
       clk_process :process
       begin
            clk <= '0';
            wait for 1 ns;
            clk <= '1';
            wait for 1 ns;
       end process;
        
     
    
       -- Stimulus process
       stim_proc: process
       begin        
          -- hold reset state for 100 ns.
            reset <= '0';
          wait for 100 ns;    
            reset <= '1';
          wait for 100 ns;
            reset <= '0';
          -- insert stimulus here 
    
          wait for clk_period*100;
       end process;
       
       stim_btn: process
       begin
       
        wait for 400 ns;
        btnRight <= '0';
        wait for 2 ns;
        btnRight <= '0';
        
        end process;
		
		
       
       
       
scan_line_x <= scanxinInternal;
scan_line_y <= scanyinInternal;
end behaviour;