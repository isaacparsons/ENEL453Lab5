library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clkkHz is
    Port (
        clk_in : in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        clk_out: out STD_LOGIC
    );
end clkkHz;

architecture Behavioral of clkkHz is
    signal i_clk_out: STD_LOGIC;
    signal count : std_logic_vector (15 downto 0);
begin
    frequency_divider: process (reset, clk_in) begin
        if (reset = '1') then
            i_clk_out <= '0';
            count <= (others => '0');
        elsif rising_edge(clk_in) then
            if (count = "1100001101001111") then --499,999
                i_clk_out <= NOT(i_clk_out);
                count <= (others => '0');
            else
                count <= count + '1';
            end if;
        end if;
    end process;
    
    clk_out <= i_clk_out;
end Behavioral;