LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
  
ENTITY tb_bin2bcd IS
END tb_bin2bcd;
 
ARCHITECTURE behavior OF tb_bin2bcd IS 
 
    COMPONENT bin2bcd
    
    --GENERIC MAP(WIDTH => 10);
    Generic(WIDTH : integer := 10); --Number of bits to represent ADC_BIN_OUT
    Port ( CLK : in STD_LOGIC;                                      
           RST : in STD_LOGIC;
           ACD_BIN_OUT : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);   -- ADC output value as a binary string              
           CM_TENS : out  STD_LOGIC_VECTOR (3 downto 0);            -- Needs to display 0-4
           CM_ONES : out  STD_LOGIC_VECTOR (3 downto 0);            -- Needs to display 0-9
           CM_TENTHS : out  STD_LOGIC_VECTOR (3 downto 0);          -- Needs to display 0-9
           CM_HUNDREDTHS : out  STD_LOGIC                           -- Always display 0
          );
    END COMPONENT; 
       
   --Inputs
   signal TEST_INPUT : std_logic_vector(9 downto 0) := (others => '0'); -- Don't know how to use generics here
   signal CLK : STD_LOGIC := '0';
   signal RST : std_logic := '0';
   
 	--Outputs
   signal i_TENS : std_logic_vector(3 downto 0);
   signal i_ONES : std_logic_vector(3 downto 0);
   signal i_TENTHS : std_logic_vector(3 downto 0);
   signal i_HUNDREDTHS : std_logic;
   
   -- Clock period definitions
   constant clk_period : time := 10 ns;  
   
   -- Miscellaneous
   signal full_number : std_logic_vector(11 downto 0);
BEGIN 
   uut: bin2bcd PORT MAP (
          CLK => CLK,
          RST => RST,
          ACD_BIN_OUT => TEST_INPUT,
          CM_TENS => i_TENS,
          CM_ONES => i_ONES,
          CM_TENTHS => i_TENTHS,
          CM_HUNDREDTHS => i_HUNDREDTHS
        );
        
   clk_process : process
   begin
		CLK <= '0';
		wait for clk_period/2;
		CLK <= '1';
		wait for clk_period/2;
   end process; 
   
   full_number <= i_TENS & i_ONES & i_TENTHS;

stim_proc : process
   begin       
    RST <= '0'; wait for 100 ns;
    RST <= '1'; wait for 100 ns;
    RST <= '0'; wait for 100 ns;
    	
    TEST_INPUT <= "0000000000"; wait for 100ns;
    TEST_INPUT <= "0000000001"; wait for 100ns;
    TEST_INPUT <= "0000000010"; wait for 100ns;
    TEST_INPUT <= "0000000011"; wait for 100ns;
    TEST_INPUT <= "0110010000"; wait for 100ns;
    TEST_INPUT <= "0110010001"; wait for 100ns;
    
    RST <= '1'; wait for 100 ns;
    RST <= '0';
    wait;
   end process;
END;