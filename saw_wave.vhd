library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity saw_wave is
    port ( clk   : in  std_logic;
		   reset        : in  std_logic;
		   outamplitude : out integer;
		   waveform		: out std_logic--;
		  );
end saw_wave;

architecture behavioral of saw_wave is

signal i_waveform : std_logic;
signal inc_ramp   : integer; --ramp amplitude to increment
signal int_count  : integer; --internal count
constant max_count  : integer := 9766;
--amount of time per pwm_gen segment(10ns*2048)
--do 5 segments before increasing (10ns*2148*5)
--invert that and you get a count each 9765.6 clock cycles


component pwm_gen
    port ( clk   	  : in  std_logic;
		   duty_cycle : in integer;
		   reset 	  : in  std_logic;
		   waveform   : out std_logic
		  );
end component;

begin

outamplitude <= inc_ramp;
waveform <= i_waveform;

amazing: pwm_gen
	port map( clk => clk,
			  duty_cycle => inc_ramp,
			  reset => reset,
			  waveform => i_waveform
			  );
		  
saw: process(clk, reset)
begin
	if(reset = '1') then
		inc_ramp <= 0;
		int_count <= 0;
	
	elsif(rising_edge(clk)) then
	    if(int_count < max_count) then
			int_count <= int_count + 1;
		else
			int_count <= 0;
		end if;
		
		if(int_count = max_count) then
			if(inc_ramp < 2047) then
				inc_ramp <= inc_ramp + 1;
			elsif(inc_ramp >= 2047) then
				inc_ramp <= 0;
			end if;
		end if;
	 end if;
end process;

end behavioral;