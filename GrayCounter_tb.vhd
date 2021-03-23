library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gcounter is
end gcounter;

architecture gcounter_tb of gcounter is

component graycounter is 
port (
	clk: in std_logic;
	reset: in std_logic;
	en: in std_logic;
	gray_count: out std_logic_vector(3 downto 0));
end component;
for DUT: graycounter use entity work.gray_counter (counter_arch);

signal clk, reset, en: std_logic;
signal gray_count: std_logic_vector (3 downto 0);

begin
DUT: graycounter port map (clk, reset, en, gray_count);
                      
  Vector_proc: PROCESS
  BEGIN

clk <='0';
reset <= '1'; en <= '1'; wait for 10 ns;
assert gray_count = "0000" report "Reset problem" severity warning;
clk <= '1'; wait for 10ns;

en <= '0'; reset <='0';
clk <= '0'; wait for 10 ns;
clk<= '1' ; wait for 10 ns;
assert gray_count = "0000" report "enable 0 problem" severity warning;
clk <= '0'; wait for 10 ns;

en <= '1'; clk <='1'; wait for 10ns; 
assert gray_count = "0001" report "count 1 problem" severity warning;
clk <= '0' ; wait for 10 ns;

clk <='1'; wait for 10ns; 
assert gray_count = "0011" report "count 2 problem" severity warning;
clk <= '0' ; wait for 10 ns;

clk <='1'; wait for 10ns; 
assert gray_count = "0010" report "count 3 problem" severity warning;
clk <= '0' ; wait for 10 ns;

clk <='1'; wait for 10ns; 
assert gray_count = "0110" report "count 4 problem" severity warning;
clk <= '0' ; wait for 10 ns;

clk <='1'; wait for 10ns; 
assert gray_count = "0111" report "count 5 problem" severity warning;
clk <= '0' ; wait for 10 ns;

clk <='1'; wait for 10ns; 
assert gray_count = "0101" report "count 6 problem" severity warning;
clk <= '0' ; wait for 10 ns;

clk <='1'; wait for 10ns; 
assert gray_count = "0100" report "count 7 problem" severity warning;
clk <= '0' ; wait for 10 ns;

clk <='1'; wait for 10ns; 
assert gray_count = "1100" report "count 8 problem" severity warning;
clk <= '0' ; wait for 10 ns;

clk <='1'; wait for 10ns; 
assert gray_count = "1101" report "count 9 problem" severity warning;
clk <= '0' ; wait for 10 ns;

clk <='1'; wait for 10ns; 
assert gray_count = "1111" report "count 10 problem" severity warning;
clk <= '0' ; wait for 10 ns;

clk <='1'; wait for 10ns; 
assert gray_count = "1110" report "count 11 problem" severity warning;
clk <= '0' ; wait for 10 ns;

clk <='1'; wait for 10ns; 
assert gray_count = "1010" report "count 12 problem" severity warning;
clk <= '0' ; wait for 10 ns;

clk <='1'; wait for 10ns; 
assert gray_count = "1011" report "count 13 problem" severity warning;
clk <= '0' ; wait for 10 ns;

clk <='1'; wait for 10ns; 
assert gray_count = "1001" report "count 14 problem" severity warning;
clk <= '0' ; wait for 10 ns;

clk <='1'; wait for 10ns; 
assert gray_count = "1000" report "count 15 problem" severity warning;
clk <= '0' ; wait for 10 ns;

clk <='1'; wait for 10ns; 
assert gray_count = "0000" report "count 0 problem" severity warning;
clk <= '0' ; wait for 10 ns;

    WAIT;
  END PROCESS Vector_proc;

end architecture gcounter_tb;
