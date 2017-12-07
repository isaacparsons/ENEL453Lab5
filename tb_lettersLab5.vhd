library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity tb_letterslab5 is
end tb_letterslab5;

architecture behaviour of tb_letterslab5 is

	component letterslab5
	
	port ( 	clk : in  std_logic;
			reset : in  std_logic;
			scan_line_x: in std_logic_vector(10 downto 0);
			scan_line_y: in std_logic_vector(10 downto 0);
            letter_color: in std_logic_vector(11 downto 0);
			scale : in std_logic_vector(3 downto 0);
			
			box_x_positionin: in std_logic_vector(9 downto 0);
            box_y_positionin: in std_logic_vector(9 downto 0);
            
            firstdigit : in std_logic_vector(3 downto 0);
            seconddigit : in std_logic_vector(3 downto 0);
            thirddigit : in std_logic_vector(3 downto 0);
            
			red: out std_logic_vector(3 downto 0);
			blue: out std_logic_vector(3 downto 0);
			green: out std_logic_vector(3 downto 0)
		  );
	end component;
	
	component upcounter
	generic ( 	max: integer:= 479;				
                            width: integer:= 11);
	port (clk : in  std_logic;
                reset : in  std_logic;
                enable : in std_logic;
                value: out std_logic_vector(width-1 downto 0));
    end component;
    
    component upcountery
    generic ( 	max: integer:= 479;				
                            width: integer:= 3);
        port ( clk : in  std_logic;
                   reset : in  std_logic;
                   outvalue: out std_logic_vector(width-1 downto 0)
                 );
    end component;
	
	component vgamoveletters port (clk : in  std_logic;
				   reset : in  std_logic;
				   btnup : in std_logic;
				   btndown : in std_logic;
				   btnleft : in std_logic;
				   btnright : in std_logic;
				   
				   increasescale : in std_logic;
				   decreasescale : in std_logic;
				   
				   box_x_positionout : out std_logic_vector(9 downto 0);
				   box_y_positionout : out std_logic_vector(9 downto 0);
				   scaleout : out std_logic_vector(3 downto 0)
				 );
	end component;
    
constant clk_period : time := 24000 ns;
signal clk : std_logic := '0';
signal reset : std_logic:= '0';

signal firstdigit : std_logic_vector(1 downto 0):= "10";
signal seconddigit : std_logic_vector(3 downto 0):= "1000";
signal thirddigit : std_logic_vector(3 downto 0):= "0011";

signal scan_line_y : std_logic_vector(10 downto 0) := "00000000000";
signal scan_line_x : std_logic_vector(10 downto 0) := "00000000000";
signal letter_color : std_logic_vector(11 downto 0) := "000000000000";
signal red: std_logic_vector(3 downto 0);
signal blue: std_logic_vector(3 downto 0);
signal green: std_logic_vector(3 downto 0);

signal scanxininternal: std_logic_vector(10 downto 0);
signal scanyininternal: std_logic_vector(10 downto 0);

signal enable: std_logic:= '1';

signal scale : std_logic_vector(3 downto 0):= "0011"; -- scale is 3

signal btnup: std_logic:= '0';
signal btndown: std_logic:= '0';
signal btnleft: std_logic:= '0';
signal btnright: std_logic:= '0';

signal increasescale: std_logic:= '0';
signal decreasescale: std_logic:= '0';
signal box_x_positionout: std_logic_vector(9 downto 0):= "0000000000";
signal box_y_positionout: std_logic_vector(9 downto 0):= "0000000000";
signal scaleout: std_logic_vector(3 downto 0):= "0011";
  
		  
begin 


uut2: upcounter generic map(
    max => 479,
    width => 11
)
    port map(
    clk => clk,
    reset => reset, 
    enable => enable,
    value => scanxininternal);

ycounter: upcountery generic map(
    max => 479,
    width => 11
)
    port map(
    clk => clk,
    reset => reset, 
    outvalue => scanyininternal);
uut: letterslab5

	port map(
    clk => clk,
    reset => reset, 
    scan_line_x => scan_line_x,
    scan_line_y => scan_line_y,
    letter_color => letter_color,
	scale => scale,
	box_x_positionin => box_x_positionout,
	box_y_positionin => box_y_positionout,
	firstdigit => firstdigit,
	seconddigit => seconddigit,
	thirddigit => thirddigit,
    red => red,
    blue => blue,
    green => green);
    
uut3: vgamoveletters port map(
        clk => clk,
        reset => reset, 
        btnup => btnup,
        btndown => btndown,
        btnleft => btnleft,
        btnright => btnright,
        increasescale => increasescale,
        decreasescale => decreasescale,
        box_x_positionout => box_x_positionout,
        box_y_positionout => box_y_positionout,
        scaleout => scaleout);   
    
-- clock process definitions
       clk_process :process
       begin
            clk <= '0';
            wait for 1 ns;
            clk <= '1';
            wait for 1 ns;
       end process;
        
     
    
       -- stimulus process
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
        btnright <= '0';
        wait for 2 ns;
        btnright <= '0';
        
        end process;
		
		
       
       
       
scan_line_x <= scanxininternal;
scan_line_y <= scanyininternal;
end behaviour;