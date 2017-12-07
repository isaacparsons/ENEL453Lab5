library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_IRReceiverModule is
end tb_IRReceiverModule;

architecture behaviour of tb_IRReceiverModule is

	component IRReceiverModule
	
	Port ( 	clk : in std_logic;
	        reset : in std_logic;
			  irSignal : in std_logic; -- low means that the ball crossed and we must get the value of the dist.
			  distanceDigitOne : in std_logic_vector(3 downto 0); -- value of 0 to 3
			  distanceDigitTwo : in std_logic_vector(3 downto 0); -- value of 0 to 9 
			  distanceDigitThree : in std_logic_vector(3 downto 0); -- value of 0 to 9
			  
			  convertedScore : out std_logic_vector(2 downto 0)
			
		  );
	end component;

    
--signals (initialize all inputs and connections between components)

signal irSignal : std_logic:= '0';
signal clk : std_logic:= '0';
signal reset : std_logic:= '0';
signal distanceDigitOne : std_logic_vector(3 downto 0):= "0001";
signal distanceDigitTwo : std_logic_vector(3 downto 0):= "0101";
signal distanceDigitThree : std_logic_vector(3 downto 0):= "0000";
signal convertedScore : std_logic_vector(2 downto 0):= "000";


	  
		  
begin 


uut: IRReceiverModule
    Port Map(
    clk => clk,
    reset => reset,
	irSignal => irSignal,
    distanceDigitOne => distanceDigitOne,
	distanceDigitTwo => distanceDigitTwo,
	distanceDigitThree => distanceDigitThree,
	convertedScore => convertedScore
    );


    
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
    
          wait;
       end process;
       
       -- stimulate input here
       stim_dist: process
          begin
               wait for 400 ns;
               distanceDigitOne <= "0001";
               wait for 200 ns;
               distanceDigitOne <= "0010";
               
           end process;
	   stim_irSig: process
	   begin
			wait for 300 ns;
			irSignal <= '1';
			wait for 2 ns;
			irSignal <= '0';
			wait for 300 ns;
			irSignal <= '1';
			wait for 2 ns;
			irSignal <= '0';
			wait;
        end process;
       
      
end behaviour;