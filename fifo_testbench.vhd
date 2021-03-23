library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;

entity fifoo is
end fifoo;

architecture fifotb of fifoo is

component fifo is
port ( reset ,rclk,wclk,rreq,wreq : in std_logic; 
        datain: in std_logic_vector (7 downto 0);
        dataout: out std_logic_vector (7 downto 0);
	empty, full : out std_logic);
end component fifo;
FOR DUT: fifo use entity work.FIFO (structural);

signal	reset ,rclk,wclk,rreq,wreq,empty, full : std_logic; 
signal datain , dataout : std_logic_vector(7 downto 0);



begin
DUT: fifo port map (reset ,rclk,wclk,rreq,wreq,datain , dataout,empty, full);
     	
   wclock: PROCESS IS BEGIN
    WAIT FOR 5 ns;
        wclk <= '0';
        WAIT FOR 10 ns;
        wclk <= '1';
        WAIT FOR 5 ns;
    END PROCESS;
    
    rclockk: PROCESS IS BEGIN  
		rclk <= '0';
        WAIT FOR 10 ns;
        rclk <= '1';
        WAIT FOR 10 ns;
    END PROCESS;
	
  Vector_proc: PROCESS
  BEGIN
	reset <= '1';  WAIT FOR 5 ns; 
	reset <= '0';  WAIT FOR 5 ns; 

	wreq <='1';
	rreq <='0';

	datain<= "00000001"; WAIT FOR 20 ns; 
	datain<= "00000010"; WAIT FOR 20 ns; 
	datain<= "00000011"; WAIT FOR 20 ns; 
	datain<= "00000100"; WAIT FOR 20 ns; 
	
	--rreq <='1';
	
	datain<= "00000101"; WAIT FOR 20 ns;
	datain<= "00000110"; WAIT FOR 20 ns;  
	datain<= "00000111"; WAIT FOR 20 ns;
	
	--wreq <='0';
	rreq <='1';
	WAIT;
  END PROCESS Vector_proc;

end architecture fifotb;
