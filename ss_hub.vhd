library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ss_hub is
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
			AN4 : out STD_LOGIC
						
			   );
end ss_hub;

architecture Behavioral of ss_hub is
--Signals:
signal i_to_filter : STD_LOGIC;
signal i_saw_amp   : integer;
signal i_locked_amp: std_logic_vector(8 downto 0);

--Components:
component sevensegment_controller
	Port ( clk : in STD_LOGIC;
		   reset : in STD_LOGIC;
		   Binary_Value : in STD_LOGIC_VECTOR (8 downto 0);
		   CA : out STD_LOGIC;
		   CB : out STD_LOGIC;
		   CC : out STD_LOGIC;
		   CD : out STD_LOGIC;
		   CE : out STD_LOGIC;
		   CF : out STD_LOGIC;
		   CG : out STD_LOGIC;
		   DP : out STD_LOGIC;
		   AN1 : out STD_LOGIC;
		   AN2 : out STD_LOGIC;
		   AN3 : out STD_LOGIC;
		   AN4 : out STD_LOGIC--;
		   );
end component;

component saw_wave
	Port ( 	clk   : in STD_LOGIC;
			reset : in STD_LOGIC;
			outamplitude : out integer;
			waveform     : out STD_LOGIC--;
			);
end component;
			
component amp_lock
	Port (	clk   : in STD_LOGIC;
			reset : in STD_LOGIC;
			comp_state : in STD_LOGIC;
			saw_amp    : in integer;
			locked_amp : out std_logic_vector(8 downto 0)--;
			);
end component;

begin 

to_filter <= i_to_filter;

saw: saw_wave
	PORT MAP (
				clk => clk,
				reset => reset,
				outamplitude => i_saw_amp,
				waveform => i_to_filter
			);
			
comp_check: amp_lock
	PORT MAP (
				clk => clk,
				reset => reset,
				comp_state => op_comp,
				saw_amp => i_saw_amp,
				locked_amp => i_locked_amp
				);

ss_top: sevensegment_controller
	PORT MAP (
		  clk => clk,
		  reset => reset,
		  Binary_Value => i_locked_amp,
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
		  AN4 => AN4--,
		  );
end Behavioral;