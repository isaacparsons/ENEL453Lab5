library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity tri_wave is
    Port ( clk   : in  STD_LOGIC;
		   reset        : in  STD_LOGIC;
		   outamplitude : out integer;
		   waveform		: out STD_LOGIC--;
		  );
end tri_wave;

architecture Behavioral of tri_wave is

signal i_waveform : STD_LOGIC;
signal down       : std_logic;
signal inc_ramp   : integer; --ramp amplitude to increment
signal int_count  : integer; --internal count
signal max_count  : integer := 27027;
--Amount of time per pwm_gen segment(10ns*370)
--do 10 segments before increasing (10ns*370*10)
--invert that and you get a count each 27027.027 clock cycles


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
		  
tri: process(clk, reset)
begin
	if(reset = '1') then
		inc_ramp <= 0;
		int_count <= 0;
		down <= '0';
	
	elsif(rising_edge(clk)) then
	    if(int_count < max_count) then
			int_count <= int_count + 1;
		else
			int_count <= 0;
		end if;
		
		if(int_count = max_count) then
			if(down = '0') then
				if(inc_ramp < 370) then
					inc_ramp <= inc_ramp + 1;
				elsif(inc_ramp >= 370) then
					down <= '1';
				end if;
			elsif(down = '1') then
				if(inc_ramp > 0) then
					inc_ramp <= inc_ramp - 1;
				elsif(inc_ramp <= 0) then
					down <= '0';
				end if;
			end if;
		end if;
	 end if;
end process;

end Behavioral;