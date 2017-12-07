library ieee;
use ieee.std_logic_1164.all;

entity ss_hub_vga is
port ( 		clk   : in std_logic;
			reset : in std_logic; -- u17
			op_comp : in std_logic; --jb1
			to_filter : out std_logic; --jb0

			ir_comp : in std_logic;
			
			toggle : in std_logic;
			toggle2: in std_logic;

			calibrate : in std_logic;--added for calibration
			
			--vga
			vgared: out std_logic_vector(3 downto 0);
            vgagreen: out std_logic_vector(3 downto 0);
            vgablue: out std_logic_vector(3 downto 0);
            hsync: out std_logic;
            vsync: out std_logic;

            
            --change stuff
            btn_up_ss: in std_logic;
            btn_down_ss: in std_logic;
            btn_left_ss: in std_logic;
            btn_right_ss: in std_logic;
			
			--sevensegment stuff
			ca : out  std_logic;
			cb : out  std_logic;
			cc : out  std_logic;
			cd : out  std_logic;
			ce : out  std_logic;
			cf : out  std_logic;
			cg : out  std_logic;
			dp : out  std_logic;
			an1 : out std_logic;
			an2 : out std_logic;
			an3 : out std_logic;
			an4 : out std_logic			
						
			   );
end ss_hub_vga;

architecture Behavioral of ss_hub_vga is
--Signals:
signal i_to_filter : std_logic;
signal i_saw_amp   : integer;
signal i_locked_amp: std_logic_vector(10 downto 0);  --was 8
signal i_locked_int: std_logic_vector(10 downto 0);

signal i_offset: std_logic_vector(10 downto 0);

signal i_amp_int   : std_logic_vector(10 downto 0);

signal i_unused : std_logic_vector(3 downto 0);
signal i_rsd : std_logic_vector(3 downto 0);
signal i_msd : std_logic_vector(3 downto 0);
signal i_lsd : std_logic_vector(3 downto 0);


signal box_x_position_ss: std_logic_vector(9 downto 0);
signal box_y_position_ss: std_logic_vector(9 downto 0);

signal scale_i: std_logic_vector(3 downto 0);

signal goal_i: std_logic;

signal score_value_i: std_logic_vector(2 downto 0);

--Components:

component sevensegment_controller
	port ( clk : in std_logic;
		   reset : in std_logic;
		   toggle : in std_logic;
		   binary_value : in std_logic_vector (10 downto 0); -- was 8
		   ca : out std_logic;
		   cb : out std_logic;
		   cc : out std_logic;
		   cd : out std_logic;
		   ce : out std_logic;
		   cf : out std_logic;
		   cg : out std_logic;
		   dp : out std_logic;
		   an1 : out std_logic;
		   an2 : out std_logic;
		   an3 : out std_logic;
		   an4 : out std_logic--;
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


component VgaModuleLab5
    port (  clk : in  std_logic;
			reset : in std_logic;
            redout: out std_logic_vector(3 downto 0);
            greenout: out std_logic_vector(3 downto 0);
            blueout: out std_logic_vector(3 downto 0);
            hsync: out std_logic;
            vsync: out std_logic;
			
			firstDigitIn : in std_logic_vector(3 downto 0);
			secondDigitIn : in std_logic_vector(3 downto 0);
			thirdDigitIn : in std_logic_vector(3 downto 0);
			scale : in std_logic_vector(3 downto 0);
			ConvertedScoreVGAModuleIn: in std_logic_vector(2 downto 0);

			
			box_x_positionInVga: in std_logic_vector(9 downto 0);
			box_y_positionInVga: in std_logic_vector(9 downto 0)--;
	        );
end component;


component goal_register
    port ( reset : in std_logic;
           clk : in  STD_LOGIC;
		   ir_sig : in STD_LOGIC;
		   goal : out STD_LOGIC
		   );
			 
end component;

component IRReceiverModule
    port (clk : in std_logic;
		  reset : in std_logic;
		  irSignal : in std_logic; -- low means that the ball crossed and we must get the value of the dist.
		  distanceDigitOne : in std_logic_vector(3 downto 0); -- value of 0 to 3
		  distanceDigitTwo : in std_logic_vector(3 downto 0); -- value of 0 to 9 
		  distanceDigitThree : in std_logic_vector(3 downto 0); -- value of 0 to 9
		  
		  convertedScore : out std_logic_vector(2 downto 0) -- score recevied
		  );
end component;


component saw_wave
	port ( 	clk   : in std_logic;
			reset : in std_logic;
			outamplitude : out integer;
			waveform     : out std_logic--;
			);
end component;
			

component amp_lock_cal_2
	port (	clk   : in std_logic;
			reset : in std_logic;
			comp_state : in std_logic;
			calibrate  : in std_logic; --added for calibration
			saw_amp    : in integer;

			e_offset   : out std_logic_vector(10 downto 0);

			locked_amp : out std_logic_vector(10 downto 0); -- was 8
			locked_int : out std_logic_vector(10 downto 0)
			);
end component;

begin 

to_filter <= i_to_filter;

sw_int_amp :process(toggle)
begin
    if(toggle = '0') then
        i_amp_int <= i_locked_amp;

    elsif(toggle2 = '1') then
        i_amp_int <= i_offset;

    else
        i_amp_int <= i_locked_int;
    end if;
end process;

changeStuff: ChangeParametersModule 
    Port Map(
    clk => clk,
    reset => reset, 
	btn_up => btn_up_ss,
	btn_down => btn_down_ss,
	btn_left => btn_left_ss,
	btn_right => btn_right_ss,
	box_x_position => box_x_position_ss,
	box_y_position => box_y_position_ss,
	scaleOutParams => scale_i
	
    );


Vga : VgaModuleLab5
	Port MAP(clk => clk,
			reset => reset,
			redOut => vgaRed,
			greenOut => vgaGreen,
			blueOut => vgaBlue,
			hsync => hsync,
			vsync => vsync,
			
			firstDigitIn => i_lsd,

			secondDigitIn =>i_msd,
			thirdDigitIn =>	i_rsd,
			scale => scale_i,
			ConvertedScoreVGAModuleIn => score_value_i, 
			
			box_x_positionInVga => box_x_position_ss,
			box_y_positionInVga => box_y_position_ss
			);
			
goal_reg: goal_register
    port map(reset => reset,
             clk => clk,
            ir_sig => ir_comp,
            goal => goal_i
		    );
    
			
irReceiver: IRReceiverModule
    port map(
			clk => clk,
			reset => reset,
			irSignal => goal_i,
			distanceDigitOne => i_lsd,
			distanceDigitTwo => i_msd,
			distanceDigitThree => i_rsd,
			convertedScore => score_value_i
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
	port map (
			clk => clk,
			reset => reset,
			outamplitude => i_saw_amp,
			waveform => i_to_filter
			);
			

comp_check: amp_lock_cal_2
	port map (
				clk => clk,
				reset => reset,
				comp_state => op_comp,
				calibrate => calibrate,
				saw_amp => i_saw_amp,

				e_offset => i_offset,

				locked_amp => i_locked_amp,
				locked_int => i_locked_int
				);

ss_top: sevensegment_controller
	port map (
		  clk => clk,
		  reset => reset,

		  toggle => toggle,
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