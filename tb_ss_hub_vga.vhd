library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb_ss_hub_vga is
end tb_ss_hub_vga;

architecture behavior of tb_ss_hub_vga is 
 
    -- component declaration for the unit under test (uut)
 
    component ss_hub_vga
    port ( 	clk   : in std_logic;
			reset : in std_logic; -- btnc
			op_comp : in std_logic;
			to_filter : out std_logic;
			ir_comp : in std_logic;
			
			toggle : in std_logic;
			toggle2: in std_logic;
			calibrate : in std_logic;
			
			btn_up_ss: in std_logic;
            btn_down_ss: in std_logic;
            btn_left_ss: in std_logic;
            btn_right_ss: in std_logic;
		
			--vga
			vgared: out std_logic_vector(3 downto 0);
            vgagreen: out std_logic_vector(3 downto 0);
            vgablue: out std_logic_vector(3 downto 0);
            hsync: out std_logic;
            vsync: out std_logic;
			
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
end component;
    
    --inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
	signal op_comp : std_logic := '0';
	signal ir_comp : std_logic := '0';
	signal calibrate: std_logic:= '0';
	signal btn_up_ss: std_logic:= '0';
    signal btn_down_ss: std_logic:= '0';
    signal btn_left_ss: std_logic:='0';
    signal btn_right_ss: std_logic:='0';
	signal to_filter : std_logic;
	signal toggle : std_logic := '0';
	signal toggle2 : std_logic := '0';
	signal vgared: std_logic_vector(3 downto 0);
    signal vgagreen: std_logic_vector(3 downto 0);
    signal vgablue: std_logic_vector(3 downto 0);
    signal hsync: std_logic;
    signal vsync: std_logic;
	signal ca : std_logic;
	signal cb : std_logic;
	signal cc : std_logic;
	signal cd : std_logic;
	signal ce : std_logic;
	signal cf : std_logic;
	signal cg : std_logic;
	signal dp : std_logic;
	signal an1 : std_logic;
	signal an2 : std_logic;
	signal an3 : std_logic;
	signal an4 : std_logic;

	
   -- clock period definitions
   constant clk_period : time := 10 ns;
 
begin
 
	-- instantiate the unit under test (uut)
   uut: ss_hub_vga port map (
          clk => clk,
		  reset => reset,
		  op_comp => op_comp,
		  ir_comp => ir_comp,
		  to_filter => to_filter,
		  btn_up_ss => btn_up_ss,
		  btn_down_ss => btn_down_ss,
		  btn_left_ss => btn_left_ss,
		  btn_right_ss => btn_right_ss,
		  toggle => toggle,
		  toggle2 => toggle2,
		  calibrate => calibrate,
		  vgared => vgared,
		  vgablue => vgablue,
		  vgagreen => vgagreen,
		  hsync => hsync,
		  vsync => vsync,
		  ca => ca,
		  cb => cb,
		  cc => cc,
		  cd => cd,
		  ce => ce,
		  cf => cf,
		  cg => cg,
		  dp => dp,
		  an1 => an1,
		  an2 => an2,
		  an3 => an3,
		  an4 => an4--,
		  );

  
   
   -- clock process definitions
   clk_process: process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process; 

   -- stimulus process
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
		ir_comp <= '1';
		wait for 500 ns;
		ir_comp <= '0';
   end process;
end;