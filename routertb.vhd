LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

Entity RouterTb IS
END ENTITY RouterTb;

ARCHITECTURE RouterTbArch OF RouterTb IS
    COMPONENT router is
        PORT ( rst    : IN     std_logic;
            wclock    : IN     std_logic;
            rclock    : IN     std_logic;
            wr1       : IN     std_logic;
            wr2       : IN     std_logic;
            wr3       : IN     std_logic;
            wr4	      : IN     std_logic;
            datai1    : IN     std_logic_vector (7 downto 0);
            datai2    : IN     std_logic_vector (7 downto 0);
            datai3    : IN     std_logic_vector (7 downto 0);
            datai4    : IN     std_logic_vector (7 downto 0);
            datao1    : OUT    std_logic_vector (7 downto 0);
            datao2    : OUT    std_logic_vector (7 downto 0);
            datao3    : OUT    std_logic_vector (7 downto 0);
            datao4    : OUT    std_logic_vector (7 downto 0)
        );
    END COMPONENT router;

    FOR DUT: router USE ENTITY WORK.router (router_Arch);
    
    SIGNAL rst, wclock, rclock, wr1, wr2, wr3, wr4 : std_logic;
    SIGNAL datai1, datai2, datai3, datai4, datao1, datao2, datao3, datao4    :    std_logic_vector (7 downto 0);

BEGIN

    DUT: router PORT MAP (rst, wclock, rclock, wr1, wr2, wr3, wr4, datai1, datai2, datai3, datai4, datao1, datao2, datao3, datao4);

	wclk: PROCESS IS BEGIN
		wclock <= '0', '1' after 5 ns;
		wait for 10 ns;
    	END PROCESS;
    
   	 rclk: PROCESS IS BEGIN 
    		rclock <= '0', '1' after 5 ns;
    		wait for 10 ns;
    	END PROCESS;
	
	warnings: PROCESS IS BEGIN
		wait for 10 ns;
		----Checks if Data output 1 ends with "00" ----
		Assert (datao1(1 downto 0) = "00" or datao1 = "ZZZZZZZZ" or datao1 = "XXXXXXXX")
		Report "Data output 1 should end with 00" 
		Severity error;
		
		----Checks if Data output 2 ends with "01" ----
		Assert (datao2(1 downto 0) = "01" or datao2 = "ZZZZZZZZ" or datao2 = "XXXXXXXX")
		Report "Data output 2 should end with 01" 
		Severity error;

		----Checks if Data output 3 ends with "10" ----
		Assert (datao3(1 downto 0) = "10" or datao3 = "ZZZZZZZZ" or datao3 = "XXXXXXXX")
		Report "Data output 3 should end with 10" 
		Severity error;

		----Checks if Data output 4 ends with "11" ----
		Assert (datao4(1 downto 0) = "11" or datao4 = "ZZZZZZZZ" or datao4 = "XXXXXXXX")
		Report "Data output 4 should end with 11" 
		Severity error;

	END PROCESS;

	tb : PROCESS IS BEGIN
		rst <= '1';
		wait for 10 ns;
		
					--Test 1, Setting Values
		----Select --> 00 ----
		datai1 <= "11001000"; datai2 <= "10010000"; datai3 <= "01010100"; datai4 <= "10001000";
		rst <= '0';wr1 <= '1';wr2 <= '1';wr3 <= '1';wr4 <= '1';
		wait for 10 ns;

		----Select --> 01 ----
		datai1 <= "10100001"; datai2 <= "01110001"; datai3 <= "10100101"; datai4 <= "11100001";
		wait for 10 ns;
		
		----Select --> 10 ----
		datai1 <= "10111010"; datai2 <= "10110010"; datai3 <= "10110110"; datai4 <= "10100010";
		wait for 10 ns;
	
		----Select --> 11 ----
		datai1 <= "10101111"; datai2 <= "01100111"; datai3 <= "01110011"; datai4 <= "01100111";
		wait for 10 ns;
			
		----Removing Items ----
		datai1 <= "ZZZZZZZZ"; datai2 <= "ZZZZZZZZ"; datai3 <= "ZZZZZZZZ"; datai4 <= "ZZZZZZZZ";
		wait for 10 ns;
		
		wr1 <= '0';wr2 <= '0';wr3 <= '0';wr4 <= '0';
		wait for 100 ns;
			
					--Test 2, Setting values while wr ='0'
		datai1 <= "11001000"; datai2 <= "10010000"; datai3 <= "01010100"; datai4 <= "10001000";
		wait for 10 ns;

		datai1 <= "10100001"; datai2 <= "01110001"; datai3 <= "10100101"; datai4 <= "11100001";
		wait for 10 ns;
	
		datai1 <= "10111010"; datai2 <= "10110010"; datai3 <= "10110110"; datai4 <= "10100010";
		wait for 10 ns;
	
		datai1 <= "10101111"; datai2 <= "01100111"; datai3 <= "01110011"; datai4 <= "01100111";
		wait for 10 ns;
	
		wr1 <= '1';wr2 <= '1';wr3 <= '1';wr4 <= '1';
		wait for 10 ns;
		
		----Removing Items ----
		datai1 <= "ZZZZZZZZ"; datai2 <= "ZZZZZZZZ"; datai3 <= "ZZZZZZZZ"; datai4 <= "ZZZZZZZZ";
		wait for 10 ns;
	
		wr1 <= '0';wr2 <= '0';wr3 <= '0';wr4 <= '0';
		wait for 100 ns;
	
					--Test 3, Setting values with varying queues each clock

		wr1 <= '1';wr2 <= '1';wr3 <= '1';wr4 <= '1';
		datai1 <= "10000000"; datai2 <= "10000001"; datai3 <= "10000010"; datai4 <= "10000011";
		wait for 10 ns;
	
		datai1 <= "10100011"; datai2 <= "10100000"; datai3 <= "10100001"; datai4 <= "10100010";
		wait for 10 ns;
	
		datai1 <= "11100010"; datai2 <= "11100011"; datai3 <= "11100000"; datai4 <= "11100001";
		wait for 10 ns;
		
		datai1 <= "11110001"; datai2 <= "11110010"; datai3 <= "11110011"; datai4 <= "11110000";
		wait for 10 ns;
		
		----Removing Items ----
		datai1 <= "ZZZZZZZZ"; datai2 <= "ZZZZZZZZ"; datai3 <= "ZZZZZZZZ"; datai4 <= "ZZZZZZZZ";
		wait for 100 ns;
	
					--Test 4 , Stress testing on first queue

		wr1 <= '1';wr2 <= '1';wr3 <= '1';wr4 <= '1';
		datai1 <= "10000000"; datai2 <= "10010000"; datai3 <= "11000000"; datai4 <= "10000100";
		wait for 10 ns;
	
		datai1 <= "10100000"; datai2 <= "10100000"; datai3 <= "10100000"; datai4 <= "10100000";
		wait for 10 ns;

		datai1 <= "11100000"; datai2 <= "11100000"; datai3 <= "11100000"; datai4 <= "11100000";
		wait for 10 ns;
	
		datai1 <= "11110000"; datai2 <= "11110000"; datai3 <= "11110000"; datai4 <= "11110000";
		wait for 10 ns;
		
		----Removing Items ----
		datai1 <= "ZZZZZZZZ"; datai2 <= "ZZZZZZZZ"; datai3 <= "ZZZZZZZZ"; datai4 <= "ZZZZZZZZ";
		wait for 10 ns;
		wait;

	END PROCESS;
END ARCHITECTURE;