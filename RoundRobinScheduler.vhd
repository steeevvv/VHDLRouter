LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY RoundRobinScheduler IS
    PORT (     clk    : IN      std_logic;
        din1    : IN      std_logic_vector (7 downto 0);
        din2    : IN      std_logic_vector (7 downto 0);
        din3    : IN      std_logic_vector (7 downto 0);
        din4    : IN      std_logic_vector (7 downto 0);
        dout    : OUT     std_logic_vector (7 downto 0)
    );
END ENTITY RoundRobinScheduler;

ARCHITECTURE RoundRobinSchedulerArch OF RoundRobinScheduler IS
    TYPE state IS (A,B,C,D);
	SIGNAL currentState : state:=D;
	SIGNAL nextState : state:=A;
BEGIN
	PROCESS(clk) IS
	BEGIN
		IF rising_edge(clk) THEN
			currentState <= nextState;
		END IF;
	END PROCESS;

	calcNextState : PROCESS (currentState) IS BEGIN
		case currentState is
		when A =>
			nextState <= B;
		when B =>
			nextState <= C;
		when C =>
			nextState <= D;
		when D =>
			nextState <= A;

	END CASE;
	END PROCESS;


	calcOutput : PROCESS (currentState) IS BEGIN
		CASE currentState IS
			WHEN A => dout <= din1;
			WHEN B => dout <= din2;
			WHEN C => dout <= din3;
			WHEN D => dout <= din4;
		END CASE;
	END PROCESS;
END ARCHITECTURE;
