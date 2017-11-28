library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_changeparametersmodule is
end tb_changeparametersmodule;

architecture behaviour of tb_changeparametersmodule is

	component ChangeParametersModule
	
	Port (clk: in std_logic;
	      reset: in std_logic;
		  btn_up: in std_logic;
		  btn_down: in std_logic;
		  btn_left: in std_logic;
		  btn_right: in std_logic;
		  
		  --scale_up: in std_logic;
		  --scale_down: in std_logic;
		  
		  scaleOutParams: out std_logic_vector(3 downto 0);
		  
		  box_x_position: out std_logic_vector(9 downto 0);
		  box_y_position: out std_logic_vector(9 downto 0)
		  
	);
	end component;

    
--signals (initialize all inputs and connections between components)
signal clk : std_logic:= '0';
signal reset : std_logic:= '0';
signal btn_up : std_logic:= '0';
signal btn_left : std_logic:= '0';
signal btn_right : std_logic:= '0';
signal btn_down : std_logic:= '0';

signal scale_up : std_logic:= '0';
signal scale_down : std_logic:= '0';

signal box_x_position : std_logic_vector(9 downto 0):= "0000000000";
signal box_y_position : std_logic_vector(9 downto 0):= "0000000000";

signal scaleOutParams : std_logic_vector(3 downto 0):= "0101";


		  
begin 


uut: ChangeParametersModule 
    Port Map(
    clk => clk,
    reset => reset, 
	btn_up => btn_up,
	btn_down => btn_down,
	btn_left => btn_left,
	btn_right => btn_right,
	--scale_up => scale_up,
	--scale_down => scale_down,
	scaleOutParams => scaleOutParams,
	box_x_position => box_x_position,
	box_y_position => box_y_position
    );


    
-- Clock process definitions
       clk_process :process
       begin
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
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
          wait;
       end process;
       
       -- stimulate input here
	   stim_btns: process
       begin        
          -- hold reset state for 100 ns.
          wait for 400 ns;    
            btn_up <= '1';
          wait for 10 ms;
			btn_up <= '0';
			
		  wait for 100 ns;    
            btn_down <= '1';
          wait for 1 ms;
			btn_down <= '0';
			
		  wait for 100 ns;    
            btn_left <= '1';
          wait for 1 ms;
			btn_left <= '0';
			
	      wait for 100 ns;    
            btn_right <= '1';
          wait for 1 ms;
			btn_right <= '0';
		  wait;

       end process;
       
       
      
end behaviour;