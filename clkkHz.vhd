library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clkkhz is
    port (
        clk_in : in  std_logic;
        reset  : in  std_logic;
        clk_out: out std_logic
    );
end clkkhz;

architecture behavioral of clkkhz is
    signal i_clk_out: std_logic;
    signal count : std_logic_vector (15 downto 0);
begin
    frequency_divider: process (reset, clk_in) begin
        if (reset = '1') then
            i_clk_out <= '0';
            count <= (others => '0');
        elsif rising_edge(clk_in) then
            if (count = "1100001101001111") then --499,999
                i_clk_out <= not(i_clk_out);
                count <= (others => '0');
            else
                count <= count + '1';
            end if;
        end if;
    end process;
    
    clk_out <= i_clk_out;
end behavioral;