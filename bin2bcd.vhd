library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity bin2bcd is
    Generic(WIDTH : integer := 10); --Number of bits to represent ADC_BIN_OUT
    Port ( CLK : in STD_LOGIC;                                      
           RST : in STD_LOGIC;
           ACD_BIN_OUT : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);   -- ADC output value as a binary string              
           CM_TENS : out  STD_LOGIC_VECTOR (3 downto 0);            -- Needs to display 0-4
           CM_ONES : out  STD_LOGIC_VECTOR (3 downto 0);            -- Needs to display 0-9
           CM_TENTHS : out  STD_LOGIC_VECTOR (3 downto 0);          -- Needs to display 0-9
           CM_HUNDREDTHS : out  STD_LOGIC                           -- Always display 0
          );
          
end bin2bcd;

architecture Behavioral of bin2bcd is
begin

bcd1: process(CLK, RST)
variable temp : STD_LOGIC_VECTOR (WIDTH-1 downto 0); -- temporary variable
variable bcd : UNSIGNED (11 downto 0) := (others => '0'); -- variable to store the output BCD number

begin  
    if(RST = '1') then
        CM_TENS <= (others => '0');
        CM_ONES  <= (others => '0');
        CM_TENTHS  <= (others => '0');
        CM_HUNDREDTHS <= '0';
        bcd := (others => '0');
        temp := (others => '0');
    elsif (rising_edge(CLK)) then    
        bcd := (others => '0'); -- zero the bcd variable     
        temp(WIDTH-1 downto 0) := ACD_BIN_OUT; -- read input into temp variable
            
        for i in 0 to WIDTH-1 loop -- cycle WIDTH times as we have WIDTH input bits   
          if bcd(3 downto 0) > 4 then 
            bcd(3 downto 0) := bcd(3 downto 0) + 3;
          end if;
          
          if bcd(7 downto 4) > 4 then 
            bcd(7 downto 4) := bcd(7 downto 4) + 3;
          end if;
        
          if bcd(11 downto 8) > 4 then  
            bcd(11 downto 8) := bcd(11 downto 8) + 3;
          end if;    
          
          bcd := bcd(10 downto 0) & temp(WIDTH-1); -- shift bcd left by 1 bit, copy MSB of temp into LSB of bcd       
          temp := temp(WIDTH-2 downto 0) & '0'; -- shift temp left by 1 bit    
        end loop;     
        -- set outputs
        CM_TENS <= STD_LOGIC_VECTOR(bcd(11 downto 8));
        CM_ONES <= STD_LOGIC_VECTOR(bcd(7 downto 4));
        CM_TENTHS <= STD_LOGIC_VECTOR(bcd(3 downto 0));    
        CM_HUNDREDTHS <= '0';
    end if;  
  end process bcd1;
    
end Behavioral;