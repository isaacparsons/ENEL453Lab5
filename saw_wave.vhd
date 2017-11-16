library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity saw_wave is
    Port ( clk   : in  STD_LOGIC;
		   reset        : in  STD_LOGIC;
		   outamplitude : out integer;
		   waveform		: out STD_LOGIC--;
		  );
end saw_wave;

architecture Behavioral of saw_wave is

signal i_waveform : STD_LOGIC;
signal inc_ramp   : integer; --ramp amplitude to increment
signal int_count  : integer; --internal count
signal max_count  : integer := 9766;--19532;--9766;
--Amount of time per pwm_gen segment(10ns*512)
--do 5 segments before increasing (10ns*512*5)
--invert that and you get a count each 39062.5 clock cycles


COMPONENT pwm_gen
    Port ( clk   	  : in  STD_LOGIC;
		   duty_cycle : in integer;
		   reset 	  : in  STD_LOGIC;
		   waveform   : out STD_LOGIC
		  );
END COMPONENT;

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
			if(inc_ramp < 511) then
				inc_ramp <= inc_ramp + 1;
			elsif(inc_ramp >= 511) then
				inc_ramp <= 0;
			end if;
		end if;
	 end if;
end process;

end Behavioral;