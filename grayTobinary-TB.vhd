LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity tb is 
end tb;

architecture behave of tb is 
component connvertgtob is 
port ( gray_in: in std_logic_vector (3 downto 0); 
      bin_out: out std_logic_vector (3 downto 0));

end component ;  
for convert: connvertgtob use entity work.graytobin(behave);
     signal bin,gray : std_logic_vector (3 downto 0):= (others => '0'); 
BEGIN 

convert: connvertgtob Port Map (bin, gray);

test: process 
BEGIN 
bin<="0000"; wait for 15 ns; 
bin<="0001"; wait for 15 ns; 
bin<="0010"; wait for 15 ns; 
bin<="0011"; wait for 15 ns; 
bin<="0100"; wait for 15 ns; 
bin<="0101"; wait for 15 ns; 
bin<="0110"; wait for 15 ns; 
bin<="0111"; wait for 15 ns; 
bin<="1000"; wait for 15 ns; 
bin<="1001"; wait for 15 ns; 
bin<="1010"; wait for 15 ns; 
bin<="1011"; wait for 15 ns; 
bin<="1100"; wait for 15 ns; 
bin<="1101"; wait for 15 ns; 
bin<="1110"; wait for 15 ns; 
bin<="1111"; wait for 15 ns; 
wait; 
end process test; 
end ; 