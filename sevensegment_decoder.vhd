library ieee;
use ieee.std_logic_1164.all;

entity sevensegment_decoder is
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
end sevensegment_decoder;

architecture behavioral of sevensegment_decoder is

signal decoded_bits: std_logic_vector(6 downto 0);

begin

decoding: process(data) 
begin 
	case data is
		when "0000" => decoded_bits <= "1111110"; -- shows zero
		when "0001" => decoded_bits <= "0110000"; -- shows one
		when "0010" => decoded_bits <= "1101101"; -- shows two
		when "0011" => decoded_bits <= "1111001"; -- shows three
		when "0100" => decoded_bits <= "0110011"; -- shows four
		when "0101" => decoded_bits <= "1011011"; -- shows five
		when "0110" => decoded_bits <= "1011111"; -- shows six
		when "0111" => decoded_bits <= "1110000"; -- shows seven
		when "1000" => decoded_bits <= "1111111"; -- shows eight
		when "1001" => decoded_bits <= "1111011"; -- shows nine
		when "1111" => decoded_bits <= "0000000"; -- shows blank
		when others => decoded_bits <= "1001111"; -- for everything else, e for error
	end case;
end process;

-- the leds that compose the segments are active low
dp <= not dp_in;
ca <= not decoded_bits(6);
cb <= not decoded_bits(5);
cc <= not decoded_bits(4);
cd <= not decoded_bits(3);
ce <= not decoded_bits(2);
cf <= not decoded_bits(1);
cg <= not decoded_bits(0);

end behavioral;
