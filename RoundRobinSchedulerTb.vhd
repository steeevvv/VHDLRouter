LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

Entity RoundRobinSchedulerTb IS
END ENTITY RoundRobinSchedulerTb;

ARCHITECTURE RoundRobinSchedulerTbArch OF RoundRobinSchedulerTb IS
	COMPONENT RoundRobinScheduler IS
		PORT ( 	clk	: IN 	 std_logic;
			din1	: IN 	 std_logic_vector (7 downto 0);
			din2	: IN 	 std_logic_vector (7 downto 0);
			din3	: IN 	 std_logic_vector (7 downto 0);
			din4	: IN 	 std_logic_vector (7 downto 0);
			dout	: OUT	 std_logic_vector (7 downto 0)
		);
	END COMPONENT RoundRobinScheduler;

	FOR DUT: RoundRobinScheduler USE ENTITY WORK.RoundRobinScheduler (RoundRobinSchedulerArch);
	
	SIGNAL clk : std_logic;
	SIGNAL din1, din2, din3, din4, dout	:	std_logic_vector (7 downto 0);
BEGIN
	DUT: RoundRobinScheduler PORT MAP (clk, din1, din2, din3, din4, dout);
	
	clock: PROCESS IS BEGIN
		clk <= '0';
		WAIT FOR 20 ns;
		clk <= '1';
		WAIT FOR 20 ns;
	END PROCESS;
	
	values: PROCESS IS BEGIN
		din1 <= "00000001";
		din2 <= "00000010";
		din3 <= "00000011";
		din4 <= "00000100";
		WAIT FOR 140 ns;
		din1 <= "00000101";
		din2 <= "00000110";
		din3 <= "00000111";
		din4 <= "00001000";
		WAIT;
	END PROCESS;
END ARCHITECTURE;
