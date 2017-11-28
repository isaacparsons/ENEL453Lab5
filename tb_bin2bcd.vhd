library ieee;
use ieee.std_logic_1164.all;
  
entity tb_bin2bcd is
end tb_bin2bcd;
 
architecture behavior of tb_bin2bcd is 

  component bin2bcd	
    port ( clk : in std_logic;                                      
           rst : in std_logic;
           acd_bin_out : in std_logic_vector (8 downto 0);   -- adc output value as a binary string              
           cm_tens : out std_logic_vector (3 downto 0);            -- xooo
           cm_ones : out std_logic_vector (3 downto 0);            -- oxoo
           cm_tenths : out std_logic_vector (3 downto 0);          -- ooxo
           cm_hundredths : out std_logic_vector (3 downto 0)      -- ooox
         );
  end component; 
       
  --inputs
  signal test_input : std_logic_vector(8 downto 0) := (others => '0'); -- don't know how to use generics here
  signal clk : std_logic := '0';
  signal rst : std_logic := '0';

  --outputs
  signal i_cm_tens : std_logic_vector(3 downto 0);
  signal i_cm_ones : std_logic_vector(3 downto 0);
  signal i_cm_tenths : std_logic_vector(3 downto 0);
  signal i_cm_hundredths : std_logic_vector(3 downto 0);

  -- clock period definitions
  constant clk_period : time := 10 ns;  

  -- miscellaneous
  signal full_number : std_logic_vector(11 downto 0);

  begin 	
  uut: bin2bcd
    port map ( clk => clk,
               rst => rst,
               acd_bin_out => test_input,
               cm_tens => i_cm_tens,
               cm_ones => i_cm_ones,
               cm_tenths => i_cm_tenths,
               cm_hundredths => i_cm_hundredths
             );
			
  clk_process : process
    begin
      clk <= '0';
      wait for clk_period/2;
      clk <= '1';
      wait for clk_period/2;
  end process; 
   
  full_number <= i_cm_tens & i_cm_ones & i_cm_tenths;

  stim_proc : process
    begin       
      rst <= '0'; wait for 100 ns;
      rst <= '1'; wait for 100 ns;
      rst <= '0'; wait for 100 ns;
    	
      test_input <= "000000000"; wait for 100ns;
      test_input <= "000000001"; wait for 100ns;
      test_input <= "000000010"; wait for 100ns;
      test_input <= "000000011"; wait for 100ns;
      test_input <= "110010000"; wait for 100ns;
      test_input <= "110010001"; wait for 100ns;
    
      rst <= '1'; wait for 100 ns;
      rst <= '0';
      wait;
  end process;
end behavior;