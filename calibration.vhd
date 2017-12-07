library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity calibration is
  port(
    clk     : in  std_logic;  
    reset   : in  std_logic;  
	button  : in  std_logic;
	saw_amp : in  integer;
	offset  : out integer
    );
end calibration;

architecture behavioral of calibration is


constant exp_amp : integer := 280;
signal   i_offset : integer;
signal   temp_offset : integer;
signal   d_button : std_logic;
signal   laststate: std_logic;

component debounce
  generic(
    counter_size  :  integer := 20);
  port(
    clk     : in  std_logic;  
    button  : in  std_logic;  
    reset   : in  std_logic;  
    result  : out std_logic   
    );
end component;
  
begin


cal_bouncer: debounce
	generic map(counter_size => 20)
	port map(clk => clk,
	         button => button,
			 reset => reset,
			 result => d_button
	);

  process(clk,reset)
  begin
    if(reset = '1') then
      i_offset <= 0;
      temp_offset <= 0;
      laststate <= '0';
    
	elsif(rising_edge(clk)) then
      if (laststate = '0' and d_button = '1') then
		temp_offset <= exp_amp - saw_amp;
	  end if;
	  
	  laststate <= d_button;
	  
	  if ((temp_offset < 200) and (temp_offset > -200)) then
         i_offset <= temp_offset;
      end if;    
    end if;
  end process;

  offset <= i_offset;
end behavioral;
