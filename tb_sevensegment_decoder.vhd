library ieee;
use ieee.std_logic_1164.all;

entity tb_sevensegment_decoder is
end tb_sevensegment_decoder;
 
architecture behavior of tb_sevensegment_decoder is 
     component sevensegment_decoder
    port(
         ca : out  std_logic;
         cb : out  std_logic;
         cc : out  std_logic;
         cd : out  std_logic;
         ce : out  std_logic;
         cf : out  std_logic;
         cg : out  std_logic;
         dp : out  std_logic;
         dp_in : in  std_logic;
         data : in  std_logic_vector(3 downto 0)
        );
    end component;   

   --inputs
   signal dp_in : std_logic := '0';
   signal data : std_logic_vector(3 downto 0) := (others => '0');

 	--outputs
   signal ca : std_logic;
   signal cb : std_logic;
   signal cc : std_logic;
   signal cd : std_logic;
   signal ce : std_logic;
   signal cf : std_logic;
   signal cg : std_logic;
   signal dp : std_logic;
 
begin
   uut: sevensegment_decoder port map (
          ca => ca,
          cb => cb,
          cc => cc,
          cd => cd,
          ce => ce,
          cf => cf,
          cg => cg,
          dp => dp,
          dp_in => dp_in,
          data => data
        );

   stim_proc: process
   begin		
		  wait for 100 ns;

      wait;
   end process;

end;