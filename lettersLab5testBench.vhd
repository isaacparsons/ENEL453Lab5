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
			
						--buttons
            upBtn: in std_logic;
            downBtn: in std_logic;
            leftBtn: in std_logic;
            rightBtn: in std_logic;
            
			binaryLetterLookupValue: in STD_LOGIC_VECTOR(8 downto 0);
			red: out STD_LOGIC_VECTOR(3 downto 0);
			blue: out STD_LOGIC_VECTOR(3 downto 0);
			green: out std_logic_vector(3 downto 0)
		  );
	end component;
	
	component upcounter
	Generic ( 	max: integer:= 480;				
                            WIDTH: integer:= 11);
	Port (clk : in  STD_LOGIC;
                reset : in  STD_LOGIC;
                        -- removed enable 
                enable : in STD_LOGIC;
                value: out STD_LOGIC_VECTOR(WIDTH-1 downto 0));
    end component;
    
constant clk_period : time := 24000 ns;
signal clk : std_logic := '0';
signal reset : std_logic:= '0';

signal scan_line_y : STD_LOGIC_VECTOR(10 downto 0) := "00000000000";
signal scan_line_x : STD_LOGIC_VECTOR(10 downto 0) := "00000000000";
signal letter_color : STD_LOGIC_VECTOR(11 downto 0) := "000000000000";
signal binaryLetterLookupValue: STD_LOGIC_VECTOR(8 downto 0);
signal red: STD_LOGIC_VECTOR(3 downto 0);
signal blue: STD_LOGIC_VECTOR(3 downto 0);
signal green: STD_LOGIC_VECTOR(3 downto 0);

signal scanxinInternal: std_logic_vector(10 downto 0);

signal enable: std_logic:= '1';


signal upBtn: std_logic:= '0';
signal downBtn: std_logic:= '0';
signal leftBtn: std_logic:= '0';
signal rightBtn: std_logic:= '0';
	  
		  
begin 

uut2: upcounter Generic Map(
    max => 480,
    width => 11
)
    Port Map(
    clk => clk,
    reset => reset, 
    enable => enable,
    value => scanxinInternal);


uut: lettersLab5 Port Map(
    clk => clk,
    reset => reset, 
    scan_line_x => scan_line_x,
    scan_line_y => scan_line_y,
    letter_color => letter_color,
    upBtn => upBtn,
    downBtn => downBtn,
    leftBtn => leftBtn,
    rightBtn => rightBtn,
    binaryLetterLookupValue => binaryLetterLookupValue,
    red => red,
    blue => blue,
    green => green);
    
    
    
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
        rightBtn <= '1';
        wait for 2 ns;
        rightBtn <= '0';
        
        end process;
       
       
       
scan_line_x <= scanxinInternal;
end behaviour;