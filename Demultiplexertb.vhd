Library IEEE;
use ieee.std_logic_1164.all;
	
ENTITY Demux_tb IS
END ENTITY Demux_tb;

Architecture tb_arch of Demux_tb is
	COMPONENT Demux IS
		PORT( 	En	: IN 	 std_logic;
		Sel	: IN	 std_logic_vector (1 downto 0);
		d_in	: IN 	 std_logic_vector (7 downto 0);
		d_out1	: OUT	 std_logic_vector (7 downto 0);
		d_out2	: OUT	 std_logic_vector (7 downto 0);
		d_out3	: OUT	 std_logic_vector (7 downto 0);
		d_out4	: OUT	 std_logic_vector (7 downto 0)
	);
END COMPONENT Demux; 

Signal En	: std_logic;
Signal Sel	: std_logic_vector (1 downto 0);

Signal d_in,d_out1,d_out2,d_out3,d_out4	: std_logic_vector (7 downto 0);

For Demux_tb : Demux USE ENTITY work.Demux(Demux_arch);

Begin
	Demux_tb: Demux PORT MAP (En,Sel,d_in,d_out1,d_out2,d_out3,d_out4);
	
	clock: PROCESS IS
	BEGIN
		WAIT FOR 20 ns;
	END PROCESS clock;

	tb: PROCESS IS
	BEGIN

		d_in <=	"11111111";
		EN  <= 	'0';
		Sel <=	"00";
		WAIT FOR 10 ns;
		ASSERT not((d_out1 = d_in) or (d_out1 = d_in) or (d_out2 = d_in) or (d_out3 = d_in) or (d_out4 = d_in))
		Report "Enable at start is 0 , therefore all output shouldn't be equal to the input"
		SEVERITY WARNING;
		
		WAIT FOR 10 ns;

		EN<=	'1';
		Sel<=	"00";
		WAIT FOR 10 ns;
		Assert d_out1 = d_in
		Report "Error : Value of d_out1 should be equal to the input"
		SEVERITY WARNING;
		
		WAIT FOR 10 ns;
	
		d_in<=	"11111110";
		EN<=	'1';
		Sel<=	"01";
		WAIT FOR 10 ns;
		Assert d_out2 = d_in
		Report "Error : Value of d_out2 should be equal to the input"
		SEVERITY WARNING;

		WAIT FOR 10 ns;

		d_in<=	"11111100";
		EN<=	'1';
		Sel<=	"10";	
		WAIT FOR 10 ns;
		Assert d_out3 = d_in
		Report "Error : Value of d_out3 should be equal to the input"
		SEVERITY WARNING;

		WAIT FOR 10 ns;

		d_in<=	"11111000";
		EN<=	'1';
		Sel<=	"11";
		WAIT FOR 10 ns;
		Assert d_out4 = d_in
		Report "Error : Value of d_out4 should be equal to the input"
		SEVERITY WARNING;
		
		WAIT FOR 10 ns;

	END PROCESS;
END ARCHITECTURE tb_arch;