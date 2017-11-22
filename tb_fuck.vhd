library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_fuck is
end tb_fuck;

architecture behaviour of tb_fuck is

	component VgaModuleLab5
	
	Port ( 	clk : in  STD_LOGIC;
                reset : in STD_LOGIC;
                redOut: out STD_LOGIC_VECTOR(3 downto 0);
                greenOut: out STD_LOGIC_VECTOR(3 downto 0);
                blueOut: out STD_LOGIC_VECTOR(3 downto 0);
                hsync: out STD_LOGIC;
                vsync: out STD_LOGIC--;
                
                --firstDigitIn : in std_logic_vector(3 downto 0);
                --secondDigitIn : in std_logic_vector(3 downto 0);
                --thirdDigitIn : in std_logic_vector(3 downto 0);
                --scale : in std_logic_vector(3 downto 0);
                
                --box_x_positionInVga: in std_logic_vector(9 downto 0);
                --box_y_positionInVga: in std_logic_vector(9 downto 0)
         );
	end component;
	
signal clk: STD_LOGIC;	
signal reset : STD_LOGIC;
signal redOut: STD_LOGIC_VECTOR(3 downto 0);
signal greenOut: STD_LOGIC_VECTOR(3 downto 0);
signal blueOut: STD_LOGIC_VECTOR(3 downto 0);
signal hsync: STD_LOGIC;
signal vsync: STD_LOGIC;

--signal firstDigitIn : std_logic_vector(3 downto 0) := "0001";
--signal secondDigitIn : std_logic_vector(3 downto 0) := "0001";
--signal thirdDigitIn : std_logic_vector(3 downto 0) := "0001";
--signal scale : std_logic_vector(3 downto 0) := "0011";

--signal box_x_positionInVga: std_logic_vector(9 downto 0) := "0000000000";
--signal box_y_positionInVga: std_logic_vector(9 downto 0) := "0000000000";		  

begin 


    uut: VgaModuleLab5
    PORT MAP( clk => clk,
              reset => reset,
              redOut => redOut,
              greenOut => greenOut,
              blueOut => blueOut,
              hsync => hsync,
              vsync => vsync--,
--              firstDigitIn => firstDigitIn,
--              secondDigitIn => secondDigitIn,
--              thirdDigitIn => thirdDigitIn,
--              scale => scale,
--              box_x_positionInVga => box_x_positionInVga,
--              box_y_positionInVga => box_y_positionInVga
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
          -- insert stimulus here 
    
          wait;
       end process;
       
       -- stimulate input here
       
       
      
end behaviour;