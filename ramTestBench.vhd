library ieee;
use ieee.std_logic_1164.all;	
entity ramTestBench is 
end entity;

architecture testing of ramTestBench is 
component ram is 
	port(
      		D_in: 	in  std_logic_vector (7 downto 0);
      		D_out: 	out std_logic_vector (7 downto 0);
      		WEA: 	in  std_logic;
      		REA: 	in  std_logic;
      		ADDRA: 	in  std_logic_vector (2 downto 0);
      		ADDRB: 	in  std_logic_vector (2 downto 0);   
      		CLKA: 	in  std_logic;
      		CLKB: 	in  std_logic
    	);
end component;
for DUT:ram use entity work.DualPortBlockRam (behavioural);
signal WEA, REA, CLKA, CLKB: std_logic;
signal D_in, D_out: std_logic_vector (7 downto 0);
signal ADDRA, ADDRB: std_logic_vector (2 downto 0);
begin
	DUT: ram port map (D_in,D_out,WEA,REA,ADDRA,ADDRB,CLKA,CLKB);
	process is begin
		CLKA<='0';
		CLKB<='0';
		WAIT FOR 10 ns;
		CLKA<='1';
		CLKB<='1';
		WAIT FOR 10 ns;
	end process;

	process is begin
		wait for 10 ns;
		D_in<="11111111";
		ADDRA<="111";
		ADDRB<="111";
		REA<='1';
		WEA<='1';
		-- wait for 20 ns;
		-- ADDRB<="111";
		-- REA<='1';
		-- D_in<="10000000";
		-- ADDRA<="001";

		wait;
	end process;
end architecture;