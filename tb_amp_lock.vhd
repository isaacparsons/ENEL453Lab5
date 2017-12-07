library ieee;
use ieee.std_logic_1164.all;


entity tb_amp_lock is
end tb_amp_lock;

architecture behavior of tb_amp_lock is 
 
    -- component declaration for the unit under test (uut)
 
    component amp_lock
		port ( clk 		 : in  std_logic;
			   reset 	 : in  std_logic;
			   comp_state: in std_logic;
			   saw_amp 	 : in integer;
			   locked_amp: out std_logic_vector(8 downto 0)--;
			 );
	end component;
    
    --inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
	signal saw_amp : integer := 0;
	signal comp_state : std_logic := '0';
	signal locked_amp : std_logic_vector(8 downto 0);
	
   -- clock period definitions
   constant clk_period : time := 10 ns;
 
begin
 
	-- instantiate the unit under test (uut)
   uut: amp_lock port map (
          clk => clk,
          reset => reset,
		  comp_state => comp_state,
		  saw_amp => saw_amp,
		  locked_amp => locked_amp--,
        );

  
   
   -- clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process; 

   -- stimulus process
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
end;