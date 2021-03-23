
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gray_counter is
port(
	clk: in std_logic;
	reset: in std_logic;
	en: in std_logic;
	gray_count: out std_logic_vector(3 downto 0));
	
end entity;

architecture counter_arch of gray_counter is

signal s1: std_logic_vector (3 downto 0);
begin

p1: process(clk, reset, en) is begin

--Asynchronous reset
if(reset = '1') then
s1 <= "0000";
		
elsif(clk'event and clk ='1' and en='1') then

case s1 is
when "0000" => s1 <= "0001";
when "0001" => s1 <= "0011";
when "0011" => s1 <= "0010";
when "0010" => s1 <= "0110";
when "0110" => s1 <= "0111";
when "0111" => s1 <= "0101";
when "0101" => s1 <= "0100";
when "0100" => s1 <= "1100";
when "1100" => s1 <= "1101";
when "1101" => s1 <= "1111";
when "1111" => s1 <= "1110";
when "1110" => s1 <= "1010";
when "1010" => s1 <= "1011";
when "1011" => s1 <= "1001";
when "1001" => s1 <= "1000";
when "1000" => s1 <= "0000";
when others => null;
end case;
end if;

end process p1;

gray_count <= s1;
end architecture counter_arch;
