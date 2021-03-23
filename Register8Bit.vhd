LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Register8Bit IS
	PORT ( 	reset	 : IN 	 std_logic;
		clk	 : IN 	 std_logic;
		clk_en	 : IN 	 std_logic;
		data_in	 : IN 	 std_logic_vector (7 downto 0);
		data_out : OUT	 std_logic_vector (7 downto 0)
	);
END ENTITY Register8Bit;

ARCHITECTURE Register8BitArch OF Register8Bit IS BEGIN
	PROCESS (clk, reset) IS BEGIN
		IF reset = '1' THEN
			data_out <= (OTHERS=>'Z');
		ELSIF clk_en = '1' AND rising_edge(clk) THEN
			data_out <= data_in;
		END IF;
	END PROCESS;
END ARCHITECTURE;
