library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_ss_hub_vga is
end tb_ss_hub_vga;

ARCHITECTURE behavior OF tb_ss_hub_vga IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ss_hub_vga
    Port ( 	clk   : in STD_LOGIC;
			reset : in STD_LOGIC; -- BTNC
			op_comp : in STD_LOGIC;
			to_filter : out STD_LOGIC;
<<<<<<< HEAD
			ir_comp : in std_logic;
			
			toggle : in STD_LOGIC;
			toggle2: in std_logic;
			calibrate : in STD_LOGIC;
			
			btn_up_ss: in std_logic;
            btn_down_ss: in std_logic;
            btn_left_ss: in std_logic;
            btn_right_ss: in std_logic;
=======
			
			toggle : in STD_LOGIC;
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
			
			--vga
			vgaRed: out STD_LOGIC_VECTOR(3 downto 0);
            vgaGreen: out STD_LOGIC_VECTOR(3 downto 0);
            vgaBlue: out STD_LOGIC_VECTOR(3 downto 0);
            Hsync: out STD_LOGIC;
            Vsync: out STD_LOGIC;
			
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
end component;
    
    --Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
	signal op_comp : std_logic := '0';
<<<<<<< HEAD
	signal ir_comp : std_logic := '0';
	signal calibrate: std_logic:= '0';
	signal btn_up_ss: std_logic:= '0';
    signal btn_down_ss: std_logic:= '0';
    signal btn_left_ss: std_logic:='0';
    signal btn_right_ss: std_logic:='0';
	signal to_filter : std_logic;
	signal toggle : std_logic := '0';
	signal toggle2 : std_logic := '0';
=======
	signal to_filter : std_logic;
	signal toggle : std_logic := '0';
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
	signal vgaRed: STD_LOGIC_VECTOR(3 downto 0);
    signal vgaGreen: STD_LOGIC_VECTOR(3 downto 0);
    signal vgaBlue: STD_LOGIC_VECTOR(3 downto 0);
    signal Hsync: STD_LOGIC;
    signal Vsync: STD_LOGIC;
	signal CA : STD_LOGIC;
	signal CB : STD_LOGIC;
	signal CC : STD_LOGIC;
	signal CD : STD_LOGIC;
	signal CE : STD_LOGIC;
	signal CF : STD_LOGIC;
	signal CG : STD_LOGIC;
	signal DP : STD_LOGIC;
	signal AN1 : STD_LOGIC;
	signal AN2 : STD_LOGIC;
	signal AN3 : STD_LOGIC;
	signal AN4 : STD_LOGIC;

	
   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ss_hub_vga PORT MAP (
          clk => clk,
		  reset => reset,
		  op_comp => op_comp,
<<<<<<< HEAD
		  ir_comp => ir_comp,
		  to_filter => to_filter,
		  btn_up_ss => btn_up_ss,
		  btn_down_ss => btn_down_ss,
		  btn_left_ss => btn_left_ss,
		  btn_right_ss => btn_right_ss,
		  toggle => toggle,
		  toggle2 => toggle2,
		  calibrate => calibrate,
=======
		  to_filter => to_filter,
		  toggle => toggle,
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
		  vgaRed => vgaRed,
		  vgaBlue => vgaBlue,
		  vgaGreen => vgaGreen,
		  Hsync => Hsync,
		  Vsync => Vsync,
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

  
   
   -- Clock process definitions
   clk_process: process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process; 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		reset <= '1';
      wait for 100 ns;
		reset <= '0';
      wait;
   end process;
   
   comp_proc: process
   begin
		wait for 500 ns;
<<<<<<< HEAD
		ir_comp <= '1';
		wait for 500 ns;
		ir_comp <= '0';
=======
		op_comp <= '1';
		wait for 500 ns;
		op_comp <= '0';
>>>>>>> b9fee138f175d338331473809642f5f1799d66ff
   end process;
END;