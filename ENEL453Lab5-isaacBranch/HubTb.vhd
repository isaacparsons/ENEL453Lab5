library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity HubTb is
end HubTb;

architecture behaviour of HubTb is

	component ss_hub
    Port ( 		clk   : in STD_LOGIC;
			reset : in STD_LOGIC; -- BTNC
			op_comp : in STD_LOGIC;
			to_filter : out STD_LOGIC;
			
			--sevensegment stuff
			CA : out  STD_LOGIC;
			CB : out  STD_LOGIC;
			CC : out  STD_LOGIC;
			CD : out  STD_LOGIC;
			CE : out  STD_LOGIC;
			CF : out  STD_LOGIC;
			CG : out  STD_LOGIC;
			DP : out  STD_LOGIC;
			AN1 : out STD_LOGIC;
			AN2 : out STD_LOGIC;
			AN3 : out STD_LOGIC;
			AN4 : out STD_LOGIC);
	end component;
	
signal clk   : STD_LOGIC;
signal reset :  STD_LOGIC; -- BTNC
signal op_comp : STD_LOGIC;
signal to_filter : STD_LOGIC;
                
                --sevensegment stuff
signal CA :   STD_LOGIC;
signal CB :   STD_LOGIC;
signal CC :   STD_LOGIC;
signal CD :   STD_LOGIC;
signal CE :   STD_LOGIC;
signal CF :   STD_LOGIC;
signal CG :   STD_LOGIC;
signal DP :   STD_LOGIC;
signal AN1 :  STD_LOGIC;
signal AN2 :  STD_LOGIC;
signal AN3 :  STD_LOGIC;
signal AN4 :  STD_LOGIC;


	  
		  
begin

uut: ss_hub PORT MAP(
          clk => clk,
		  reset => reset,
		  op_comp => op_comp,
		  to_filter => to_filter,
		  CA => CA,
		  CB => CB,
		  CC => CC,
		  CD => CD,
		  CE => CE,
		  CF => CF,
		  CG => CG,
		  DP => DP,
		  AN1 => AN1,
		  AN2 => AN2,
		  AN3 => AN3,
		  AN4 => AN4
);

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
    
          wait;
       end process;
	   
	   stim_comp: process
       begin        
          
            op_comp <= '0';
            wait for 50 ns;
            op_comp <= '1';
            wait for 50 ns;
       end process;

end behaviour;