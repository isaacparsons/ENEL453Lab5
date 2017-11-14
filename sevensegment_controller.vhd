library ieee;
use ieee.std_logic_1164.all;

entity sevensegment_controller is
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
end sevensegment_controller;

architecture behavioral of sevensegment_controller is

signal i_dp: std_logic;
signal i_an: std_logic_vector(3 downto 0);
signal i_khz: std_logic;
signal digit_to_display: std_logic_vector(3 downto 0);

--outputs

signal i_cm_tens : std_logic_vector(3 downto 0);
signal i_cm_ones : std_logic_vector(3 downto 0);
signal i_cm_tenths : std_logic_vector(3 downto 0);
signal i_cm_hundredths : std_logic_vector(3 downto 0);

component bin2bcd is
    port ( clk : in std_logic;                                      
           rst : in std_logic;
           acd_bin_out : in  std_logic_vector (8 downto 0);   -- adc output value as a binary string              
           cm_tens : out  std_logic_vector (3 downto 0);            -- needs to display 0-4
           cm_ones : out  std_logic_vector (3 downto 0);            -- needs to display 0-9
           cm_tenths : out  std_logic_vector (3 downto 0);          -- needs to display 0-9
           cm_hundredths : out  std_logic_vector (3 downto 0)      -- always display 0
          );
end component;

component kHz_clk is
    port (  clk_in : in  std_logic;
            reset  : in  std_logic;
            clk_out: out std_logic
          );
end component;

component sevensegment_selector is
    port (clk : in std_logic;
            switch : in std_logic;
            output : out std_logic_vector(3 downto 0);
            reset : in std_logic
            );
end component;


component sevensegment_decoder is
    port ( ca : out  std_logic;
           cb : out  std_logic;
           cc : out  std_logic;
           cd : out  std_logic;
           ce : out  std_logic;
           cf : out  std_logic;
           cg : out  std_logic;
           dp : out  std_logic;
		   dp_in: in std_logic;
           data : in  std_logic_vector (3 downto 0)
			   );
end component;

begin

bcd: bin2bcd
    port map(          clk => clk,
                rst => reset,
    acd_bin_out => binary_value,
    cm_tens => i_cm_tens,
    cm_ones => i_cm_ones,
    cm_tenths => i_cm_tenths,
    cm_hundredths => i_cm_hundredths    
    );

selector: sevensegment_selector
port map( clk => clk,
          switch => i_khz,
          output => i_an,
          reset => reset
          );
          
khzclk: kHz_clk
port map(clk_in => clk,
         reset => reset,
         clk_out => i_khz

);		
decoder: sevensegment_decoder
port map(
    ca => ca,
    cb => cb,
    cc => cc,
    cd => cd,
    ce => ce,
    cf => cf,
    cg => cg,
    dp => dp,
    dp_in => i_dp,
    data => digit_to_display
    );

digit_mux: process(i_an, i_cm_tens, i_cm_ones, i_cm_tenths, i_cm_hundredths)
begin
    case(i_an) is
        when "0001" => digit_to_display <= i_cm_hundredths;
        when "0010" => digit_to_display <= i_cm_tenths;
        when "0100" => digit_to_display <= i_cm_ones;
        when "1000" => digit_to_display <= i_cm_tens;
        when others => digit_to_display <= "1111";
    end case;
end process;

an1 <= not i_an(0);
an2 <= not i_an(1);
an3 <= not i_an(2);
an4 <= not i_an(3);

--i_dp <= i_an(2);
end behavioral;
