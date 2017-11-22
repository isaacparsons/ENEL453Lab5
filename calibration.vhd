LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY calibration IS
  PORT(
    clk     : in  std_logic;  
    reset   : in  std_logic;  
	button  : in  std_logic;
	saw_amp : in  integer;
	offset  : out integer
    );
END calibration;

ARCHITECTURE Behavioral OF calibration IS

constant exp_amp : integer := 1315;
signal   i_offset : integer;
signal   temp_offset : integer;
signal   d_button : std_logic;
signal   lastState: std_logic;

component debounce
  GENERIC(
    counter_size  :  INTEGER := 20); --counter size (20 bits gives 10.5ms with 100MHz clock)
  PORT(
    clk     : IN  STD_LOGIC;  --input clock
    button  : IN  STD_LOGIC;  --input signal to be debounced
    reset   : IN  STD_LOGIC;  --reset
    result  : OUT STD_LOGIC   --debounced signal
    );
END component;
  
begin


cal_bouncer: debounce
	Generic map(counter_size => 20)
	Port map(clk => clk,
	         button => button,
			 reset => reset,
			 result => d_button
	);

  process(clk,reset)
  begin
    if(reset = '1') then
      i_offset <= 0;
      temp_offset <= 0;
      lastState <= '0';
    
	elsif(rising_edge(clk)) then -- this is an alternative to "rising_edge(clk)" clk'EVENT and clk = '1'
      
	  if (lastState = '0' and d_button = '1') then
		temp_offset <= exp_amp - saw_amp;
	  end if;
	  
	  lastState <= d_button;
	  
	  if ((temp_offset < 200) AND (temp_offset > -200)) then
         i_offset <= temp_offset;
      end if;    
    end if;
  end process;

  offset <= temp_offset;--i_offset;
end behavioral;
