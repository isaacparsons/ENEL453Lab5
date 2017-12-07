library ieee;
use ieee.std_logic_1164.all;

entity changeparametersmodule is
	port (clk: in std_logic;
	      reset: in std_logic;
		  btn_up: in std_logic;
		  btn_down: in std_logic;
		  btn_left: in std_logic;
		  btn_right: in std_logic;
		  scaleoutparams: out std_logic_vector(3 downto 0);

		  box_x_position: out std_logic_vector(9 downto 0);
		  box_y_position: out std_logic_vector(9 downto 0)	  
	);
end changeparametersmodule;
	
architecture behavioral of changeparametersmodule is


component debounce is
      generic(
			counter_size  :  integer := 20); 
      port(
			clk     : in  std_logic;  
			button  : in  std_logic;  
			reset   : in  std_logic;  
			result  : out std_logic   
    );
end component;

component vgamoveletters is
      port ( clk : in  std_logic;
				   reset : in  std_logic;
				   btnup : in std_logic;
				   btndown : in std_logic;
				   btnleft : in std_logic;
				   btnright : in std_logic;
				   
			   
				   box_x_positionout : out std_logic_vector(9 downto 0);
				   box_y_positionout : out std_logic_vector(9 downto 0);
				   scaleout : out std_logic_vector(3 downto 0)
				 
    );
end component;

signal upinternal: std_logic;
signal downinternal: std_logic;
signal leftinternal: std_logic;
signal rightinternal: std_logic;

signal scaleupinternal: std_logic;
signal scaledowninternal: std_logic;

signal scaleout_i: std_logic_vector(3 downto 0);


begin

vgamove: vgamoveletters
	port map(clk => clk,
			 reset => reset,
			 btnup => upinternal,
			 btndown => downinternal,
			 btnright => rightinternal,
			 btnleft => leftinternal,

			 box_x_positionout => box_x_position,
			 box_y_positionout => box_y_position, 
			 scaleout => scaleout_i

			 
			 );

up_bouncer: debounce

	generic map(counter_size => 15)

	port map(clk => clk,
	         button => btn_up,
			 reset => reset,
			 result => upinternal
	);
	
down_bouncer: debounce

	generic map(counter_size => 15)

	port map(clk => clk,
			 reset => reset,
			 button => btn_down,
			 result => downinternal
	);
	
left_bouncer: debounce

	generic map(counter_size => 15)

	port map(clk => clk,
			 reset => reset,
			 button => btn_left,
			 result => leftinternal
	);
	
right_bouncer: debounce

	generic map(counter_size => 15)

	port map(clk => clk,
			 reset => reset,
			 button => btn_right,
			 result => rightinternal
	);

scaleoutparams <= scaleout_i;
end behavioral;