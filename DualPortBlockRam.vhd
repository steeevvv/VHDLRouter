Library ieee;
Use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

Entity DualPortBlockRam is
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
End entity;

Architecture behavioural of DualPortBlockRam is 

type ram_type is array (7 downto 0) of std_logic_vector (7 downto 0);
SIGNAL ram : ram_type;

begin
	process (CLKA) is begin
		if rising_edge(CLKA) then 
			if WEA = '1' then
				ram(to_integer(unsigned(ADDRA)))<=D_in;
			end if;
		end if;

	end process;

	process (CLKB) is begin
		if rising_edge(CLKB) then 
			if REA = '1' AND NOT(ram(to_integer(unsigned(ADDRB)))="XXXXXXXX")then
				D_out<=ram(to_integer(unsigned(ADDRB)));
			else
				D_out <= "ZZZZZZZZ";
			end if;
		end if;
	end process;
end architecture;
