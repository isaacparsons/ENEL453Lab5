library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity pwm_gen is
    Port ( clk   : in  STD_LOGIC;
		   duty_cycle: in integer; -- between 0 and max_count;
		   reset       : in  STD_LOGIC;
		   waveform    : out STD_LOGIC
		  );
end pwm_gen;

architecture Behavioral of pwm_gen is

signal i_waveform: std_logic;
signal count: integer;
signal max_count: integer := 2048;--512;--1024;

begin

waveform <= i_waveform;

rst: process(clk, reset)
begin
	if(reset = '1') then
		i_waveform <= '0';
		count <= 0;
	elsif (rising_edge(clk)) then
		if((count <= duty_cycle) and (count < max_count)) then
			count <= count + 1;
			i_waveform <= '1';
		elsif((count > duty_cycle) and (count < max_count)) then
			count <= count + 1;
			i_waveform <= '0';
		else
			count <= 0;
		end if;
    end if;
end process;

end Behavioral;