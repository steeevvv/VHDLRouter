LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;


entity FIFO is
port (  reset ,rclk,wclk,rreq,wreq : in std_logic; 
        datain: in std_logic_vector (7 downto 0);
        dataout: out std_logic_vector (7 downto 0);
	empty, full : out std_logic);
end entity FIFO;

Architecture structural of FIFO is 


component fifocontroller is
port (  reset ,rdclk,wrclk,r_req,w_req : in std_logic; 
        write_valid,read_valiad, empty,full : out std_logic;
        wr_ptr , rd_ptr : out std_logic_vector (3 downto 0)); 
end component fifocontroller;
for controller1:  fifocontroller use ENTITY work.FIFO_Controller(behave);

component DualPortBlockRam is
	port(
      		D_in: 	in  std_logic_vector (7 downto 0);
      		D_out: 	out std_logic_vector (7 downto 0);
      		WEA: 	in  std_logic;
      		REA: 	in  std_logic;
      		ADDRA: 	in  std_logic_vector (2 downto 0);
      		ADDRB: 	in  std_logic_vector (2 downto 0);   
      		CLKA: 	in  std_logic;
      		CLKB: 	in  std_logic);
End component;
for ram1:  DualPortBlockRam use ENTITY work.DualPortBlockRam(behavioural);

signal write_valid_sl,read_valiad_sl : std_logic; 
signal wr_ptr_sl , rd_ptr_sl : std_logic_vector (3 downto 0); 

begin

controller1:  fifocontroller port map(reset,rclk,wclk,rreq,wreq,write_valid_sl,read_valiad_sl, empty,full,wr_ptr_sl , rd_ptr_sl);
ram1: DualPortBlockRam port map(datain,dataout, write_valid_sl, read_valiad_sl,wr_ptr_sl(2 downto 0),rd_ptr_sl(2 downto 0),wclk, rclk);
end architecture structural;