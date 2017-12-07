library ieee;
use ieee.std_logic_1164.all;

entity tb_sevensegment_controller is
end tb_sevensegment_controller;

architecture behavioral of tb_sevensegment_controller is

component sevensegment_controller
    port ( clk : in std_logic;
       reset : in std_logic;
       binary_value : in std_logic_vector (8 downto 0);
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
       an4 : out std_logic
       );
end component;
       
--inputs
signal test_input : std_logic_vector(8 downto 0) := (others => '0'); -- don't know how to use generics here
signal clk : std_logic := '0';
signal rst : std_logic := '0';

--outputs
signal ca :  std_logic:= '0';
signal cb :  std_logic:= '0';
signal cc :  std_logic:= '0';
signal cd :  std_logic:= '0';
signal ce :  std_logic:= '0';
signal cf :  std_logic:= '0';
signal cg :  std_logic:= '0';
signal dp :  std_logic:= '0';
signal an1 :  std_logic:= '0';
signal an2 :  std_logic:= '0';
signal an3 :  std_logic:= '0';
signal an4 :  std_logic:= '0';

-- clock period definitions
constant clk_period : time := 10 ns;  

signal segment_output : std_logic_vector(3 downto 0);
signal digit_output : std_logic_vector(10 downto 0);

begin 

uut: sevensegment_controller port map (
	clk => clk,
	reset => rst,
	binary_value => test_input,
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
	an4 => an4
    

    );

   clk_process : process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process; 

 segment_output <= (not an4) & (not an3) & (not an2) & (not an1);
 digit_output(0) <= (not ca) and (not cb) and (not cc) and (not cd) and (not ce) and (not cf) and (cg);
 digit_output(1) <= (ca) and (not cb) and (not cc) and (cd) and (ce) and (cf) and (cg);
 digit_output(2) <= (not ca) and (not cb) and (cc) and (not cd) and (not ce) and (cf) and (not cg);
 digit_output(3) <= (not ca) and (not cb) and (not cc) and (not cd) and (ce) and (cf) and (not cg);
 digit_output(4) <= (ca) and (not cb) and (not cc) and (cd) and (ce) and (not cf) and (not cg);
 digit_output(5) <= (not ca) and (cb) and (not cc) and (not cd) and (ce) and (not cf) and (not cg);
 digit_output(6) <= (not ca) and (cb) and (not cc) and (not cd) and (not ce) and (not cf) and (not cg);
 digit_output(7) <= (not ca) and (not cb) and (not cc) and (cd) and (ce) and (cf) and (cg);
 digit_output(8) <= (not ca) and (not cb) and (not cc) and (not cd) and (not ce) and (not cf) and (not cg);
 digit_output(9) <= (not ca) and (not cb) and (not cc) and (cd) and (ce) and (not cf) and (not cg);
 digit_output(10) <= (not ca) and (cb) and (cc) and (not cd) and (not ce) and (not cf) and (not cg);

stim_proc : process
   begin       
    rst <= '0'; wait for 1 ms;
    rst <= '1'; wait for 1 ms;
    rst <= '0'; wait for 1 ms;
    	
    test_input <= "000000000"; wait for 4 ms;
    test_input <= "000000001"; wait for 4 ms;
    test_input <= "000000010"; wait for 4 ms;
    test_input <= "000000011"; wait for 4 ms;
    test_input <= "000000100"; wait for 4 ms;
    test_input <= "000000101"; wait for 4 ms;
    test_input <= "111111111"; wait for 4 ms;
    
    rst <= '1'; wait for 4 ns;
    rst <= '0';
    wait;
   end process;
end;
