library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ss_hub_vga is
Port ( 		clk   : in STD_LOGIC;
			reset : in STD_LOGIC; -- U17
			op_comp : in STD_LOGIC; --JB1
			to_filter : out STD_LOGIC; --JB0
<<<<<<< HEAD
			ir_comp : in std_logic;
			
			toggle : in STD_LOGIC;
			toggle2: in std_logic;
=======
			
			toggle : in STD_LOGIC;
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
			calibrate : in STD_LOGIC;--Added for calibration
			
			--vga
			vgaRed: out STD_LOGIC_VECTOR(3 downto 0);
            vgaGreen: out STD_LOGIC_VECTOR(3 downto 0);
            vgaBlue: out STD_LOGIC_VECTOR(3 downto 0);
            hsync: out STD_LOGIC;
            vsync: out STD_LOGIC;
<<<<<<< HEAD
            
            --change stuff
            btn_up_ss: in std_logic;
            btn_down_ss: in std_logic;
            btn_left_ss: in std_logic;
            btn_right_ss: in std_logic;
=======
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
			
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
<<<<<<< HEAD
signal i_offset: std_logic_vector(10 downto 0);
=======
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
signal i_amp_int   : std_logic_vector(10 downto 0);

signal i_unused : std_logic_vector(3 downto 0);
signal i_rsd : std_logic_vector(3 downto 0);
signal i_msd : std_logic_vector(3 downto 0);
signal i_lsd : std_logic_vector(3 downto 0);

<<<<<<< HEAD
signal box_x_position_ss: std_logic_vector(9 downto 0);
signal box_y_position_ss: std_logic_vector(9 downto 0);

signal scale_i: std_logic_vector(3 downto 0);

signal goal_i: std_logic;

signal score_value_i: std_logic_vector(2 downto 0);

--Components:

component sevensegment_controller
	Port ( clk : in STD_LOGIC;
		   reset : in STD_LOGIC;
		   toggle : in std_logic;
=======
--Components:
component sevensegment_controller
	Port ( clk : in STD_LOGIC;
		   reset : in STD_LOGIC;
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
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

<<<<<<< HEAD
component ChangeParametersModule
    Port (clk: in std_logic;
	      reset: in std_logic;
		  btn_up: in std_logic;
		  btn_down: in std_logic;
		  btn_left: in std_logic;
		  btn_right: in std_logic;
		  
		  --scale_up: in std_logic;
		  --scale_down: in std_logic;
		  
		  box_x_position: out std_logic_vector(9 downto 0);
		  box_y_position: out std_logic_vector(9 downto 0);
		  scaleOutParams: out std_logic_vector(3 downto 0)  
	);
end component;

=======
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
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
<<<<<<< HEAD
			ConvertedScoreVGAModuleIn: in std_logic_vector(2 downto 0);
=======
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
			
			box_x_positionInVga: in std_logic_vector(9 downto 0);
			box_y_positionInVga: in std_logic_vector(9 downto 0)--;
	 );
end component;

<<<<<<< HEAD
component goal_register
    Port ( reset : std_logic;
            clk 		: in  STD_LOGIC;
			   ir_sig : in STD_LOGIC;
			   goal     : out STD_LOGIC
			 );
			 
end component;

component IRReceiverModule
    Port (clk : in std_logic;
		      reset : in std_logic;
		      irSignal : in std_logic; -- low means that the ball crossed and we must get the value of the dist.
			  distanceDigitOne : in std_logic_vector(3 downto 0); -- value of 0 to 3
			  distanceDigitTwo : in std_logic_vector(3 downto 0); -- value of 0 to 9 
			  distanceDigitThree : in std_logic_vector(3 downto 0); -- value of 0 to 9
			  
			  convertedScore : out std_logic_vector(2 downto 0) -- score recevied
				 );
end component;

=======
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
component saw_wave
	Port ( 	clk   : in STD_LOGIC;
			reset : in STD_LOGIC;
			outamplitude : out integer;
			waveform     : out STD_LOGIC--;
			);
end component;
			
<<<<<<< HEAD
component amp_lock_cal_2
=======
component amp_lock_cal
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
	Port (	clk   : in STD_LOGIC;
			reset : in STD_LOGIC;
			comp_state : in STD_LOGIC;
			calibrate  : in STD_LOGIC; --added for calibration
			saw_amp    : in integer;
<<<<<<< HEAD
			e_offset   : out std_logic_vector(10 downto 0);
=======
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
			locked_amp : out std_logic_vector(10 downto 0); -- was 8
			locked_int : out std_logic_vector(10 downto 0)
			);
end component;

begin 

to_filter <= i_to_filter;
--vgaRed <= "1111";
--vgaBlue <= "1111";
--vgaGreen <= "1111";
<<<<<<< HEAD
=======

>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
sw_int_amp :process(toggle)
begin
    if(toggle = '0') then
        i_amp_int <= i_locked_amp;
<<<<<<< HEAD
    elsif(toggle2 = '1') then
        i_amp_int <= i_offset;
=======
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
    else
        i_amp_int <= i_locked_int;
    end if;
end process;

<<<<<<< HEAD
changeStuff: ChangeParametersModule 
    Port Map(
    clk => clk,
    reset => reset, 
	btn_up => btn_up_ss,
	btn_down => btn_down_ss,
	btn_left => btn_left_ss,
	btn_right => btn_right_ss,
	--scale_up => scale_up,
	--scale_down => scale_down,
	box_x_position => box_x_position_ss,
	box_y_position => box_y_position_ss,
	scaleOutParams => scale_i
	
    );

=======
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
Vga : VgaModuleLab5
	Port MAP(clk => clk,
			reset => reset,
			redOut => vgaRed,
			greenOut => vgaGreen,
			blueOut => vgaBlue,
			hsync => hsync,
			vsync => vsync,
			
			firstDigitIn => i_lsd,
<<<<<<< HEAD
			secondDigitIn =>i_msd,
			thirdDigitIn =>	i_rsd,
			scale => scale_i,
			ConvertedScoreVGAModuleIn => score_value_i,                 -------------- change to adjust scale (if testing is required)
			
			box_x_positionInVga => box_x_position_ss,
			box_y_positionInVga => box_y_position_ss
			);
			
goal_reg: goal_register
    Port Map(reset => reset,
             clk => clk,
            ir_sig => ir_comp,
            goal => goal_i
    );
    
			
irReceiver: IRReceiverModule
    Port Map(
    clk => clk,
    reset => reset,
	irSignal => goal_i,
    distanceDigitOne => i_lsd,
	distanceDigitTwo => i_msd,
	distanceDigitThree => i_rsd,
	convertedScore => score_value_i
    );
			
=======
			secondDigitIn => i_msd,
			thirdDigitIn =>	i_rsd,
			scale => "0011",
			
			box_x_positionInVga => "0000000000",
			box_y_positionInVga => "0000000000"
			);
			
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
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
			
<<<<<<< HEAD
comp_check: amp_lock_cal_2
=======
comp_check: amp_lock_cal
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
	PORT MAP (
				clk => clk,
				reset => reset,
				comp_state => op_comp,
				calibrate => calibrate,
				saw_amp => i_saw_amp,
<<<<<<< HEAD
				e_offset => i_offset,
=======
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
				locked_amp => i_locked_amp,
				locked_int => i_locked_int
				);

ss_top: sevensegment_controller
	PORT MAP (
		  clk => clk,
		  reset => reset,
<<<<<<< HEAD
		  toggle => toggle,
=======
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
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