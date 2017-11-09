library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_sevensegment_controller is
end tb_sevensegment_controller;

architecture Behavioral of tb_sevensegment_controller is

component sevensegment_controller
Generic(WIDTH : integer := 10);
    Port ( clk : in STD_LOGIC;
       reset : in STD_LOGIC;
       Binary_Value : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
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
       AN4 : out STD_LOGIC
       );
end component;
       
--Inputs
signal TEST_INPUT : std_logic_vector(9 downto 0) := (others => '0'); -- Don't know how to use generics here
signal CLK : STD_LOGIC := '0';
signal RST : std_logic := '0';

--Outputs
 signal     CA :  STD_LOGIC:= '0';
  signal     CB :  STD_LOGIC:= '0';
 signal      CC :  STD_LOGIC:= '0';
 signal      CD :  STD_LOGIC:= '0';
 signal      CE :  STD_LOGIC:= '0';
 signal      CF :  STD_LOGIC:= '0';
signal       CG :  STD_LOGIC:= '0';
signal       DP :  STD_LOGIC:= '0';
 signal      AN1 :  STD_LOGIC:= '0';
signal       AN2 :  STD_LOGIC:= '0';
 signal      AN3 :  STD_LOGIC:= '0';
signal       AN4 :  STD_LOGIC:= '0';

-- Clock period definitions
constant clk_period : time := 10 ns;  


BEGIN 

uut: sevensegment_controller PORT MAP (
	clk => clk,
	reset => RST,
	Binary_Value => TEST_INPUT,
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

   clk_process : process
   begin
		CLK <= '0';
		wait for clk_period/2;
		CLK <= '1';
		wait for clk_period/2;
   end process; 

stim_proc : process
   begin       
    RST <= '0'; wait for 1 ms;
    RST <= '1'; wait for 1 ms;
    RST <= '0'; wait for 1 ms;
    	
    TEST_INPUT <= "0000000000"; wait for 4 ms;
    TEST_INPUT <= "0000000001"; wait for 4 ms;
    TEST_INPUT <= "0000000010"; wait for 4 ms;
    TEST_INPUT <= "0000000011"; wait for 4 ms;
    TEST_INPUT <= "0000000100"; wait for 4 ms;
    TEST_INPUT <= "0000000101"; wait for 4 ms;
    
    RST <= '1'; wait for 4 ns;
    RST <= '0';
    wait;
   end process;
END;
