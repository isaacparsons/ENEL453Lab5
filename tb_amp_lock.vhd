library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_amp_lock is
end tb_amp_lock;

ARCHITECTURE behavior OF tb_amp_lock IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT amp_lock
		Port ( clk 		 : in  STD_LOGIC;
			   reset 	 : in  STD_LOGIC;
			   comp_state: in STD_LOGIC;
			   saw_amp 	 : in integer;
<<<<<<< HEAD
			   locked_amp: out std_logic_vector(8 downto 0)--;
=======
			   locked_amp: out std_logic_vector(8 downto 0);
>>>>>>> refs/remotes/origin/master
			 );
	end component;
    
    --Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
	signal saw_amp : integer := 0;
	signal comp_state : std_logic := '0';
	signal locked_amp : std_logic_vector(8 downto 0);
	
   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: amp_lock PORT MAP (
          clk => clk,
          reset => reset,
		  comp_state => comp_state,
		  saw_amp => saw_amp,
		  locked_amp => locked_amp--,
        );

  
   
   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process; 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		reset <= '0';
      wait for 100 ns;	
		reset <= '1';
      wait for 100 ns;
		reset <= '0';
      wait;
   end process;
   
   amp_proc: process
   begin
		saw_amp <= saw_amp + 1;
		wait for 20 ns;
   end process;
   
   comp_proc: process
   begin
		wait for 5000 ns;
		comp_state <= '1';
		wait for 40 ns;
		comp_state <= '0';
		wait for 300 ns;
		comp_state <= '1';
		wait for 40 ns;
		comp_state <= '0';
		wait for 300 ns;
		comp_state <= '1';
		wait for 40 ns;
		comp_state <= '0';
		wait;
	end process;
END;