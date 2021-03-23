LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
entity FIFO_Controller is
	port ( reset ,rdclk,wrclk,r_req,w_req : in std_logic; 
	      write_valid,read_valiad,empty,full : out std_logic;
	      wr_ptr , rd_ptr : out std_logic_vector (3 downto 0)); 
end entity FIFO_Controller;

Architecture behave of FIFO_Controller is 
	component gray_counter is
		port(	clk: in std_logic;
			reset: in std_logic;
			en: in std_logic;
			gray_count: out std_logic_vector(3 downto 0));
	end component ;
	for all:  gray_counter use ENTITY work.gray_counter;

	component graytobin is
		port (	gray_in : in std_logic_vector (3 downto 0);
			bin_out : out std_logic_vector (3 downto 0));
	end component ;
	for all : graytobin use entity work.graytobin;

	signal empty_sl,full_sl,wr_en,rd_en:std_logic;
	signal gray_rdout,gray_wrout,rd_binout,wr_binout :std_logic_vector(3 downto 0);

	BEGIN
	
	grey_wr: gray_counter port map(wrclk,reset,wr_en,gray_wrout);
	bin_wr: graytobin port map(gray_wrout,wr_binout);
	
	grey_rd: gray_counter  port map(rdclk,reset,rd_en,gray_rdout);
	bin_rd: graytobin port map(gray_rdout,rd_binout);

	wr_en<= w_req and (not full_sl) when falling_edge(wrclk);
	rd_en<= r_req and (not empty_sl) when falling_edge(rdclk);

	wr:process (wrclk,w_req)
	begin 
		if falling_edge(wrclk) and w_req ='1' then 
			if full_sl='0' then 
				write_valid <='1';
				wr_ptr<=wr_binout;
			else
				write_valid <='0';
			end if;
		end if;
	end process wr;

	rd: process (rdclk,r_req)
	begin 
		if falling_edge(rdclk) AND r_req ='1'  then 
			if empty_sl='0'  then 
				read_valiad <='1';
				rd_ptr <= rd_binout;
			else
				read_valiad <='0';
			end if;
		end if;
	end process rd;

	update: process(rd_binout,wr_binout,reset)
	begin 
		if reset ='1' then 
		   empty_sl<='1';
		   full_sl<='0';
		elsif rd_binout(2 downto 0)= wr_binout(2 downto 0) then
			if (rd_binout(3) XNOR wr_binout(3))='1' then 
     				empty_sl<='1';
				full_sl<='0';
     			else
				full_sl<='1';
				empty_sl<='0';
			end if;
		else 
			empty_sl<='0';
      			full_sl<='0';		 
		end if;
	end process update;

	empty<=empty_sl;
	full<=full_sl;

end architecture behave;
