library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity VgaModuleLab5 is
    Port (  clk : in  STD_LOGIC;
			reset : in STD_LOGIC;
            redOut: out STD_LOGIC_VECTOR(3 downto 0);
            greenOut: out STD_LOGIC_VECTOR(3 downto 0);
            blueOut: out STD_LOGIC_VECTOR(3 downto 0);
            hsync: out STD_LOGIC;
            vsync: out STD_LOGIC;
			
			firstDigitIn : in std_logic_vector(3 downto 0);
			secondDigitIn : in std_logic_vector(3 downto 0);
			thirdDigitIn : in std_logic_vector(3 downto 0);
			scale : in std_logic_vector(3 downto 0);
			
			box_x_positionInVga: in std_logic_vector(9 downto 0);
			box_y_positionInVga: in std_logic_vector(9 downto 0);
	 );
end VgaModuleLab5;

architecture Behavioral of VgaModuleLab5 is
-- Components:
component sync_signals_generator is
    Port ( pixel_clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           hor_sync: out STD_LOGIC;
           ver_sync: out STD_LOGIC;
           blank: out STD_LOGIC;
           scan_line_x: out STD_LOGIC_VECTOR(10 downto 0);
           scan_line_y: out STD_LOGIC_VECTOR(10 downto 0)
		  );
end component;


-- ADDED
component clock_divider is
Port (  clk : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        enable: in STD_LOGIC;
        kHz: out STD_LOGIC;	  
        seconds_port: out STD_LOGIC_VECTOR(4-1 downto 0);     -- unused
        ten_seconds_port: out STD_LOGIC_VECTOR(3-1 downto 0); -- unused
        minutes_port: out STD_LOGIC_VECTOR(4-1 downto 0);     -- unused
        ten_minutes_port: out STD_LOGIC_VECTOR(3-1 downto 0); -- unused
        twentyfive_MHz: out STD_LOGIC;
        hHz: out STD_LOGIC
	  );
end component;

 
 component lettersLab5 is
 Port (  clk : in  STD_LOGIC;
         reset : in  STD_LOGIC;
         scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
         scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
         letter_color: in STD_LOGIC_VECTOR(11 downto 0);
         scale : in std_logic_vector(3 downto 0);
			
		 firstDigit : in std_logic_vector(1 downto 0);
	 	 secondDigit : in std_logic_vector(3 downto 0);
		 thirdDigit : in std_logic_vector(3 downto 0);
			
         box_x_positionIn: in std_logic_vector(9 downto 0);
         box_y_positionIn: in std_logic_vector(9 downto 0);
         red: out STD_LOGIC_VECTOR(3 downto 0);
         blue: out STD_LOGIC_VECTOR(3 downto 0);
         green: out std_logic_vector(3 downto 0)
      );
end component;
-- END ADDED

-- Signals:
signal reset: std_logic;
signal vga_select: std_logic;

signal disp_blue: std_logic_vector(3 downto 0);
signal disp_red: std_logic_vector(3 downto 0);
signal disp_green: std_logic_vector(3 downto 0);


-- Clock divider signals:
signal i_kHz, i_hHz, i_pixel_clk: std_logic;

-- Sync module signals:
signal vga_blank : std_logic;
signal scan_line_x, scan_line_y: STD_LOGIC_VECTOR(10 downto 0);


-- Letter signals:
signal letter_color: std_logic_vector(11 downto 0);
signal letter_red: std_logic_vector(3 downto 0);
signal letter_green: std_logic_vector(3 downto 0);
signal letter_blue: std_logic_vector(3 downto 0);


begin

VGA_SYNC: sync_signals_generator
    Port map( 	pixel_clk   => i_pixel_clk,
                reset       => reset,
                hor_sync    => hsync,
                ver_sync    => vsync,
                blank       => vga_blank,
                scan_line_x => scan_line_x,
                scan_line_y => scan_line_y
			  );

-- ADDED	
DIVIDER: clock_divider
    Port map (  clk              => clk,
                reset            => reset,
                kHz              => i_kHz,
                twentyfive_MHz   => i_pixel_clk,
                enable           => '1',
                seconds_port     => open,
                ten_seconds_port => open,
                minutes_port     => open,
                ten_minutes_port => open,
                hHz              => i_hHz
		  );
		  
             
LETTERS: lettersLab5
    Port map ( clk => clk,
				reset => reset, 
				scan_line_x => scan_line_x,
				scan_line_y => scan_line_y,
				letter_color => letter_color,
				scale => scale,
				box_x_positionIn => box_x_positionInVga,
				box_y_positionIn => box_y_positionInVga,
				firstDigit => firstDigit,
				secondDigit => secondDigit,
				thirdDigit => thirdDigit,
				red => redOut,
				blue => blueOut,
				green => greenOut
           );
-- END ADDED

-- BLANKING:
-- Follow this syntax to assign other colors when they are not being blanked
redOut <= "0000" when (vga_blank = '1') else disp_red;
-- ADDED:
blueOut  <= "0000" when (vga_blank = '1') else disp_blue;
greenOut <= "0000" when (vga_blank = '1') else disp_green;

-- Connect input buttons and switches:
-- ADDED
-- These can be assigned to different switches/buttons
reset <= buttons(0);
box_color <= "00000000000";

--disp_red <= letter_red;
--disp_blue <= letter_blue;
--disp_green <= letter_green;

-----------------------------------------------------------------------------

end Behavioral;

