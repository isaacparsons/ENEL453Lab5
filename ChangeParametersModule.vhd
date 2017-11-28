library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ChangeParametersModule is
	Port (clk: in std_logic;
	      reset: in std_logic;
		  btn_up: in std_logic;
		  btn_down: in std_logic;
		  btn_left: in std_logic;
		  btn_right: in std_logic;
		  
<<<<<<< HEAD
		  --scale_up: in std_logic;
		  --scale_down: in std_logic;
		  
		  scaleOutParams: out std_logic_vector(3 downto 0);
=======
		  scale_up: in std_logic;
		  scale_down: in std_logic;
		  
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
		  box_x_position: out std_logic_vector(9 downto 0);
		  box_y_position: out std_logic_vector(9 downto 0)	  
	);
end ChangeParametersModule;
	
architecture Behavioral of ChangeParametersModule is


component debounce is
      GENERIC(
			counter_size  :  INTEGER := 20); --counter size (20 bits gives 10.5ms with 100MHz clock)
      PORT(
			clk     : IN  STD_LOGIC;  --input clock
			button  : IN  STD_LOGIC;  --input signal to be debounced
			reset   : IN  STD_LOGIC;  --reset
			result  : OUT STD_LOGIC   --debounced signal
    );
END component;

component VGAMoveLetters is
      Port ( clk : in  STD_LOGIC;
				   reset : in  STD_LOGIC;
				   btnUp : in std_logic;
				   btnDown : in std_logic;
				   btnLeft : in std_logic;
				   btnRight : in std_logic;
				   
<<<<<<< HEAD
				   --increaseScale : in std_logic;
				   --decreaseScale : in std_logic;
=======
				   increaseScale : in std_logic;
				   decreaseScale : in std_logic;
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
				   
				   box_x_positionOut : out std_logic_vector(9 downto 0);
				   box_y_positionOut : out std_logic_vector(9 downto 0);
				   scaleOut : out std_logic_vector(3 downto 0)
				 
    );
END component;

signal upInternal: std_logic;
signal downInternal: std_logic;
signal leftInternal: std_logic;
signal rightInternal: std_logic;

signal scaleUpInternal: std_logic;
signal scaleDownInternal: std_logic;
<<<<<<< HEAD
signal scaleOut_i: std_logic_vector(3 downto 0);
=======
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff

begin

vgamove: VGAMoveLetters
	Port map(clk => clk,
			 reset => reset,
			 btnUp => upInternal,
			 btnDown => downInternal,
			 btnRight => rightInternal,
			 btnLeft => leftInternal,
<<<<<<< HEAD
			 --increaseScale => scaleUpInternal,
			 --decreaseScale => scaleDownInternal,
			 box_x_positionOut => box_x_position,
			 box_y_positionOut => box_y_position, 
			 scaleOut => scaleOut_i
=======
			 increaseScale => scaleUpInternal,
			 decreaseScale => scaleDownInternal,
			 box_x_positionOut => box_x_position,
			 box_y_positionOut => box_y_position
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
			 
			 );

up_bouncer: debounce
<<<<<<< HEAD
	Generic map(counter_size => 15)
=======
	Generic map(counter_size => 20)
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
	Port map(clk => clk,
	         button => btn_up,
			 reset => reset,
			 result => upInternal
	);
	
down_bouncer: debounce
<<<<<<< HEAD
	Generic map(counter_size => 15)
=======
	Generic map(counter_size => 20)
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
	Port map(clk => clk,
			 reset => reset,
			 button => btn_down,
			 result => downInternal
	);
	
left_bouncer: debounce
<<<<<<< HEAD
	Generic map(counter_size => 15)
=======
	Generic map(counter_size => 20)
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
	Port map(clk => clk,
			 reset => reset,
			 button => btn_left,
			 result => leftInternal
	);
	
right_bouncer: debounce
<<<<<<< HEAD
	Generic map(counter_size => 15)
=======
	Generic map(counter_size => 20)
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
	Port map(clk => clk,
			 reset => reset,
			 button => btn_right,
			 result => rightInternal
	);
	
<<<<<<< HEAD
--scale_up_bouncer: debounce
--	Generic map(counter_size => 20)
	--Port map(clk => clk,
		--	 reset => reset,
			-- button => scale_up,
			 --result => scaleUpInternal
	--);
--scale_down_bouncer: debounce
	--Generic map(counter_size => 20)
	--Port map(clk => clk,
		--	 reset => reset,
			-- button => scale_down,
			 --result => scaleDownInternal
	--);

scaleOutParams <= scaleOut_i;
=======
scale_up_bouncer: debounce
	Generic map(counter_size => 20)
	Port map(clk => clk,
			 reset => reset,
			 button => scale_up,
			 result => scaleUpInternal
	);
scale_down_bouncer: debounce
	Generic map(counter_size => 20)
	Port map(clk => clk,
			 reset => reset,
			 button => scale_down,
			 result => scaleDownInternal
	);

>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
end Behavioral;