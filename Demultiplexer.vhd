Library IEEE;
use ieee.std_logic_1164.all;

Entity Demux IS
	PORT ( 	En	: IN 	 std_logic;
		Sel	: IN	 std_logic_vector (1 downto 0);
		d_in	: IN 	 std_logic_vector (7 downto 0);
		d_out1	: OUT	 std_logic_vector (7 downto 0);
		d_out2	: OUT	 std_logic_vector (7 downto 0);
		d_out3	: OUT	 std_logic_vector (7 downto 0);
		d_out4	: OUT	 std_logic_vector (7 downto 0)
	);
END ENTITY Demux;

ARCHITECTURE Demux_arch of Demux is 

Begin
	start: PROCESS (En,Sel,d_in) is Begin
		IF (En = '1') THEN
			Case Sel IS

				WHEN "00" =>
				d_out1 <= d_in;

				WHEN "01" =>
				d_out2 <= d_in;

				WHEN "10" =>
				d_out3 <= d_in;

				WHEN "11" =>
				d_out4 <= d_in;
				
				WHEN OTHERS =>
				
			END CASE;
		END IF;
	END PROCESS;
END ARCHITECTURE Demux_arch;