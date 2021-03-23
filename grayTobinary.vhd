LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity graytobin is
port ( gray_in : in std_logic_vector (3 downto 0);
       bin_out : out std_logic_vector (3 downto 0));
end entity graytobin;

Architecture behave of graytobin is 

begin 


bin_out(3)<= gray_in(3);
bin_out(2)<= gray_in(3) xor gray_in(2);
bin_out(1)<= gray_in(3) xor gray_in(2)xor gray_in(1);
bin_out(0)<= gray_in(3) xor gray_in(2)xor gray_in(1) xor gray_in(0);

end Architecture behave;