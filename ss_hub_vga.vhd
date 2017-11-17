library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ss_hub_vga is
Port ( 		clk   : in STD_LOGIC;
			reset : in STD_LOGIC; -- U17
			op_comp : in STD_LOGIC; --JB1
			to_filter : out STD_LOGIC; --JB0
			
			toggle : in STD_LOGIC;
			
			--vga
			vgaRed: out STD_LOGIC_VECTOR(3 downto 0);
            vgaGreen: out STD_LOGIC_VECTOR(3 downto 0);
            vgaBlue: out STD_LOGIC_VECTOR(3 downto 0);
            hsync: out STD_LOGIC;
            vsync: out STD_LOGIC;
			
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
end ss_hub_vga;

architecture Behavioral of ss_hub_vga is
--Signals:
signal i_to_filter : STD_LOGIC;
signal i_saw_amp   : integer;
signal i_locked_amp: std_logic_vector(10 downto 0);  --was 8
signal i_locked_int: std_logic_vector(10 downto 0);
signal i_amp_int   : std_logic_vector(10 downto 0);

signal i_unused : std_logic_vector(3 downto 0);
signal i_rsd : std_logic_vector(3 downto 0);
signal i_msd : std_logic_vector(3 downto 0);
signal i_lsd : std_logic_vector(3 downto 0);

--Components:
component sevensegment_controller
	Port ( clk : in STD_LOGIC;
		   reset : in STD_LOGIC;
		   Binary_Value : in STD_LOGIC_VECTOR (10 downto 0); -- was 8
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

component bin2bcd
    port ( clk : in std_logic;                                      
           rst : in std_logic;
           acd_bin_out : in  std_logic_vector (10 downto 0);   -- adc output value as a binary string              
           cm_tens : out std_logic_vector (3 downto 0);            -- needs to display 0-9
           cm_ones : out std_logic_vector (3 downto 0);            -- needs to display 0-9
           cm_tenths : out std_logic_vector (3 downto 0);          -- needs to display 0-9
           cm_hundredths : out std_logic_vector (3 downto 0)       -- needs to display 0-9
          );
end component;

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
			
			box_x_positionInVga: in std_logic_vector(9 downto 0);
			box_y_positionInVga: in std_logic_vector(9 downto 0)--;
	 );
end component;

component saw_wave
	Port ( 	clk   : in STD_LOGIC;
			reset : in STD_LOGIC;
			outamplitude : out integer;
			waveform     : out STD_LOGIC--;
			);
end component;
			
component amp_lock--_cal
	Port (	clk   : in STD_LOGIC;
			reset : in STD_LOGIC;
			comp_state : in STD_LOGIC;
			saw_amp    : in integer;
			locked_amp : out std_logic_vector(10 downto 0); -- was 8
			locked_int : out std_logic_vector(10 downto 0)
			);
end component;

begin 

to_filter <= i_to_filter;
--vgaRed <= "1111";
--vgaBlue <= "1111";
--vgaGreen <= "1111";

sw_int_amp :process(toggle)
begin
    if(toggle = '0') then
        i_amp_int <= i_locked_amp;
    else
        i_amp_int <= i_locked_int;
    end if;
end process;

Vga : VgaModuleLab5
	Port MAP(clk => clk,
			reset => reset,
			redOut => vgaRed,
			greenOut => vgaGreen,
			blueOut => vgaBlue,
			hsync => hsync,
			vsync => vsync,
			
			firstDigitIn => i_lsd,
			secondDigitIn => i_msd,
			thirdDigitIn =>	i_rsd,
			scale => "0011",
			
			box_x_positionInVga => "0000000000",
			box_y_positionInVga => "0000000000"
			);
			
vga_num : bin2bcd
	port map(clk => clk,
			rst => reset,
			acd_bin_out => i_locked_amp,
			cm_tens => i_unused,
			cm_ones => i_lsd,
			cm_tenths => i_msd,
			cm_hundredths => i_rsd
			);

saw: saw_wave
	PORT MAP (
				clk => clk,
				reset => reset,
				outamplitude => i_saw_amp,
				waveform => i_to_filter
			);
			
comp_check: amp_lock--_cal
	PORT MAP (
				clk => clk,
				reset => reset,
				comp_state => op_comp,
				saw_amp => i_saw_amp,
				locked_amp => i_locked_amp,
				locked_int => i_locked_int
				);

ss_top: sevensegment_controller
	PORT MAP (
		  clk => clk,
		  reset => reset,
		  Binary_Value => i_amp_int,
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