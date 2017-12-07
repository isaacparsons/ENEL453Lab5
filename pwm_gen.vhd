library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity pwm_gen is
    port ( clk   : in  std_logic;
		   duty_cycle: in integer; -- between 0 and max_count;
		   reset       : in  std_logic;
		   waveform    : out std_logic
		  );
end pwm_gen;

architecture behavioral of pwm_gen is

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

end behavioral;