library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity sevensegment_controller is
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
end sevensegment_controller;

architecture Behavioral of sevensegment_controller is

signal i_dp: std_logic;
signal i_an: STD_LOGIC_VECTOR(3 downto 0);
signal i_kHz: std_logic;
signal digit_to_display: std_logic_vector(3 downto 0);

--Outputs

signal i_CM_TENS : std_logic_vector(3 downto 0);
signal i_CM_ONES : std_logic_vector(3 downto 0);
signal i_CM_TENTHS : std_logic_vector(3 downto 0);
signal i_CM_HUNDREDTHS : std_logic_vector(3 downto 0);

component bin2bcd is
    Generic(WIDTH : integer := 10); --Number of bits to represent ADC_BIN_OUT
    Port ( CLK : in STD_LOGIC;                                      
           RST : in STD_LOGIC;
           ACD_BIN_OUT : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);   -- ADC output value as a binary string              
           CM_TENS : out  STD_LOGIC_VECTOR (3 downto 0);            -- Needs to display 0-4
           CM_ONES : out  STD_LOGIC_VECTOR (3 downto 0);            -- Needs to display 0-9
           CM_TENTHS : out  STD_LOGIC_VECTOR (3 downto 0);          -- Needs to display 0-9
           CM_HUNDREDTHS : out  STD_LOGIC_VECTOR (3 downto 0)      -- Always display 0
          );
end component;

component clkkHz is
    Port (  clk_in : in  STD_LOGIC;
            reset  : in  STD_LOGIC;
            clk_out: out STD_LOGIC
          );
end component;

component sevensegment_selector is
    Port (clk : in STD_LOGIC;
            switch : in std_logic;
            output : out std_logic_vector(3 downto 0);
            reset : in STD_LOGIC
            );
end component;


component sevensegment is
    Port ( CA : out  STD_LOGIC;
           CB : out  STD_LOGIC;
           CC : out  STD_LOGIC;
           CD : out  STD_LOGIC;
           CE : out  STD_LOGIC;
           CF : out  STD_LOGIC;
           CG : out  STD_LOGIC;
           DP : out  STD_LOGIC;
		   dp_in: in STD_LOGIC;
           data : in  STD_LOGIC_VECTOR (3 downto 0)
			   );
end component;

begin

BCD1: bin2bcd
    Generic Map(WIDTH => 10)
    port map(          CLK => CLK,
                RST => reset,
    ACD_BIN_OUT => Binary_Value,
    CM_TENS => i_CM_TENS,
    CM_ONES => i_CM_ONES,
    CM_TENTHS => i_CM_TENTHS,
    CM_HUNDREDTHS => i_CM_HUNDREDTHS    
    );

SELECTOR: sevensegment_selector
port map( clk => clk,
          switch => i_kHz,
          output => i_an,
          reset => reset
          );
          
kHZCLK: clkkHz
port map(clk_in => clk,
         reset => reset,
         clk_out => i_kHz

);		
DISPLAY: sevensegment
port map(
    CA => CA,
    CB => CB,
    CC => CC,
    CD => CD,
    CE => CE,
    CF => CF,
    CG => CG,
    DP => DP,
    dp_in => i_dp,
    data => digit_to_display
    );

digit_mux: process(i_an, i_CM_HUNDREDTHS, i_CM_TENTHS, i_CM_ONES, i_CM_TENS)
begin
    case(i_an) is
        when "0001" => digit_to_display <= i_CM_HUNDREDTHS;
        when "0010" => digit_to_display <= i_CM_TENTHS;
        when "0100" => digit_to_display <= i_CM_ONES;
        when "1000" => digit_to_display <= i_CM_TENS;
        when others => digit_to_display <= "1111";
    end case;
end process;

AN1 <= not i_an(0);
AN2 <= not i_an(1);
AN3 <= not i_an(2);
AN4 <= not i_an(3);

--i_dp <= i_an(2);
end Behavioral;