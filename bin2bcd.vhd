library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bin2bcd is
    port ( clk : in std_logic;                                      
           rst : in std_logic;
           acd_bin_out : in  std_logic_vector (8 downto 0);   -- adc output value as a binary string              
           cm_tens : out std_logic_vector (3 downto 0);            -- needs to display 0-4
           cm_ones : out std_logic_vector (3 downto 0);            -- needs to display 0-9
           cm_tenths : out std_logic_vector (3 downto 0);          -- needs to display 0-9
           cm_hundredths : out std_logic_vector (3 downto 0)       -- always display 0
          );
          
end bin2bcd;

architecture behavioral of bin2bcd is
begin

bcd1: process(clk, rst)
variable temp : std_logic_vector (8 downto 0); -- temporary variable
variable bcd : unsigned (11 downto 0) := (others => '0'); -- variable to store the output bcd number

begin  
    if(rst = '1') then
        cm_tens <= (others => '0');
        cm_ones  <= (others => '0');
        cm_tenths  <= (others => '0');
        cm_hundredths <= (others => '0');
        bcd := (others => '0');
        temp := (others => '0');
    elsif (rising_edge(clk)) then    
        bcd := (others => '0'); -- zero the bcd variable     
        temp(8 downto 0) := acd_bin_out; -- read input into temp variable
            
        for i in 0 to 8 loop -- cycle 9 times as we have 9 input bits   
          if bcd(3 downto 0) > 4 then 
            bcd(3 downto 0) := bcd(3 downto 0) + 3;
          end if;
          
          if bcd(7 downto 4) > 4 then 
            bcd(7 downto 4) := bcd(7 downto 4) + 3;
          end if;
        
          if bcd(11 downto 8) > 4 then  
            bcd(11 downto 8) := bcd(11 downto 8) + 3;
          end if;    
          
          bcd := bcd(10 downto 0) & temp(8); -- shift bcd left by 1 bit, copy msb of temp into lsb of bcd       
          temp := temp(7 downto 0) & '0'; -- shift temp left by 1 bit    
        end loop;     
        -- set outputs
        cm_tens <= std_logic_vector(bcd(11 downto 8));
        cm_ones <= std_logic_vector(bcd(7 downto 4));
        cm_tenths <= std_logic_vector(bcd(3 downto 0));    
        cm_hundredths <= "1111";
    end if;  
  end process bcd1;
    
end behavioral;