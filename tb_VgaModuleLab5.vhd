library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_VgaModuleLab5 is
end tb_VgaModuleLab5;

architecture behaviour of tb_VgaModuleLab5 is

	component VgaModuleLab5
		Port (  clk : in  STD_LOGIC;
				reset : in STD_LOGIC;
				redOut: out STD_LOGIC_VECTOR(3 downto 0);
				greenOut: out STD_LOGIC_VECTOR(3 downto 0);
				blueOut: out STD_LOGIC_VECTOR(3 downto 0);
				hsync: out STD_LOGIC;
				vsync: out STD_LOGIC;
				
				firstDigitIn : in std_logic_vector(3 downto 0);
				secondDigitIn : in std_logic_vector(3 downto 0);
				thirdDigitIn : in std_logic_vector(3 downto 0);
				scale : in std_logic_vector(3 downto 0);
				ConvertedScoreVGAModuleIn: in std_logic_vector(2 downto 0);
				
				box_x_positionInVga: in std_logic_vector(9 downto 0);
				box_y_positionInVga: in std_logic_vector(9 downto 0)
		 );
		 
	end component;
	

    
--signals (initialize all inputs and connections between components)
signal clk: std_logic:= '0';
signal reset: std_logic:= '0';
signal redOut: STD_LOGIC_VECTOR(3 downto 0):= "0000";
signal greenOut: STD_LOGIC_VECTOR(3 downto 0):= "0000";
signal blueOut: STD_LOGIC_VECTOR(3 downto 0):= "0000";
signal hsync: std_logic:= '0';
signal vsync: std_logic:= '0';
signal ConvertedScoreVGAModuleIn: std_logic_vector(2 downto 0):= "010";

signal firstDigitIn: std_logic_vector(3 downto 0):= "0000";
signal secondDigitIn: std_logic_vector(3 downto 0):= "0000";
signal thirdDigitIn: std_logic_vector(3 downto 0):= "0000";
signal scale: std_logic_vector(1 downto 0):= "0000";
signal box_x_positionInVga: std_logic_vector(9 downto 0):= "0000000000";
signal box_y_positionInVga: std_logic_vector(9 downto 0):= "0000000000";


	  
		  
begin 

		
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
	stim_stuff: process
	begin
		wait for 400 ns;
		firstDigitIn <= "0001";
		wait for 100 ns;
		firstDigitIn <= "0011";
		
	end process;
end behaviour;