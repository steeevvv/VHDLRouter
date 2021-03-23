LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

Entity Register8BitTb IS
END ENTITY Register8BitTb;

ARCHITECTURE Register8BitTbArch OF Register8BitTb IS
	COMPONENT Register8Bit IS
		PORT ( 	reset	 : IN 	 std_logic;
			clk	 : IN 	 std_logic;
			clk_en	 : IN 	 std_logic;
			data_in	 : IN 	 std_logic_vector (7 downto 0);
			data_out : OUT	 std_logic_vector (7 downto 0)
		);
	END COMPONENT Register8Bit;

	FOR DUT: Register8Bit USE ENTITY WORK.Register8Bit (Register8BitArch);
	
	SIGNAL reset, clk, clk_en 	: std_logic;
	SIGNAL data_in, data_out	: std_logic_vector (7 downto 0);
BEGIN
	DUT: Register8Bit PORT MAP (reset, clk, clk_en, data_in, data_out);
	
	clock: PROCESS IS BEGIN
		clk <= '0';
		WAIT FOR 20 ns;
		clk <= '1';
		WAIT FOR 20 ns;
	END PROCESS;
	
	values: PROCESS IS BEGIN
		reset <= '0';
		clk_en <= '1';
		WAIT FOR 20 ns;
		data_in <= "00001000";
		WAIT FOR 40 ns;
		data_in <= "00001100";
		WAIT FOR 40 ns;
		clk_en <= '0';
		data_in <= "00000011";
		WAIT FOR 40 ns;
		clk_en <= '1';
		reset <= '0';
		data_in <= "11000000";
		WAIT FOR 10 ns;
		reset <= '1';
		WAIT FOR 40 ns;
		reset <= '0';
		WAIT;
	END PROCESS;
END ARCHITECTURE;
