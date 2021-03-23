Library IEEE;
use ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;

Entity router is
	PORT ( 	rst	: IN 	 std_logic;
		wclock	: IN	 std_logic;
		rclock	: IN	 std_logic;
		wr1	: IN	 std_logic;
		wr2	: IN	 std_logic;
		wr3	: IN	 std_logic;
		wr4	: IN	 std_logic;
		datai1	: IN	 std_logic_vector (7 downto 0);
		datai2	: IN	 std_logic_vector (7 downto 0);
		datai3	: IN	 std_logic_vector (7 downto 0);
		datai4	: IN	 std_logic_vector (7 downto 0);
		datao1	: OUT	 std_logic_vector (7 downto 0);
		datao2	: OUT	 std_logic_vector (7 downto 0);
		datao3	: OUT	 std_logic_vector (7 downto 0);
		datao4	: OUT	 std_logic_vector (7 downto 0)
	);
End router;

Architecture router_Arch of router is
	Signal dataINReg1out, dataINReg2out, dataINReg3out ,dataINReg4out :std_logic_vector (7 downto 0);

	Signal	Demux1Q1 ,Demux1Q2 , Demux1Q3 , Demux1Q4,
		Demux2Q1 ,Demux2Q2 , Demux2Q3 , Demux2Q4,
		Demux3Q1 ,Demux3Q2 , Demux3Q3 , Demux3Q4,
		Demux4Q1 ,Demux4Q2 , Demux4Q3 , Demux4Q4 :std_logic_vector (7 downto 0);

	Signal	Q1O1out ,Q1O2out , Q1O3out , Q1O4out,
		Q2O1out ,Q2O2out , Q2O3out , Q2O4out,
		Q3O1out ,Q3O2out , Q3O3out , Q3O4out,
		Q4O1out ,Q4O2out , Q4O3out , Q4O4out :std_logic_vector (7 downto 0);

	Signal	wreq1Q1 ,wreq1Q2 , wreq1Q3 , wreq1Q4,
		wreq2Q1 ,wreq2Q2 , wreq2Q3 , wreq2Q4,
		wreq3Q1 ,wreq3Q2 , wreq3Q3 , wreq3Q4,
		wreq4Q1 ,wreq4Q2 , wreq4Q3 , wreq4Q4 :std_logic;

	SIGNAL RRState : std_logic_vector(1 downto 0) := "00";
	Signal	rreq :std_logic_vector (3 downto 0);

	Signal dataOUTReg1IN, dataOUTReg2IN, dataOUTReg3IN ,dataOUTReg4IN :std_logic_vector (7 downto 0);
	Component Register8Bit IS
		PORT ( 	reset	 : IN 	 std_logic;
			clk	 : IN 	 std_logic;
			clk_en	 : IN 	 std_logic;
			data_in	 : IN 	 std_logic_vector (7 downto 0);
			data_out : OUT	 std_logic_vector (7 downto 0)
		);
	END Component Register8Bit;
	FOR ALL: Register8Bit USE ENTITY WORK.Register8Bit (Register8BitArch);

	Component Demux IS
		PORT ( 	En	: IN 	 std_logic;
			Sel	: IN	 std_logic_vector (1 downto 0);
			d_in	: IN 	 std_logic_vector (7 downto 0);
			d_out1	: OUT	 std_logic_vector (7 downto 0);
			d_out2	: OUT	 std_logic_vector (7 downto 0);
			d_out3	: OUT	 std_logic_vector (7 downto 0);
			d_out4	: OUT	 std_logic_vector (7 downto 0)
		);
	END Component Demux;
	For ALL: Demux USE ENTITY work.Demux(Demux_arch);

	Component FIFO is
	Port (  reset ,rclk,wclk,rreq,wreq : in std_logic; 
			datain: in std_logic_vector (7 downto 0);
			dataout: out std_logic_vector (7 downto 0);
		empty, full : out std_logic);
	end component FIFO;
	FOR ALL: fifo use entity work.FIFO (structural);

	COMPONENT RoundRobinScheduler IS
			PORT ( 	clk	: IN 	 std_logic;
				din1	: IN 	 std_logic_vector (7 downto 0);
				din2	: IN 	 std_logic_vector (7 downto 0);
				din3	: IN 	 std_logic_vector (7 downto 0);
				din4	: IN 	 std_logic_vector (7 downto 0);
				dout	: OUT	 std_logic_vector (7 downto 0)
			);
	END COMPONENT RoundRobinScheduler;
	FOR ALL: RoundRobinScheduler USE ENTITY WORK.RoundRobinScheduler (RoundRobinSchedulerArch);
Begin
	RRState <= RRState + "01" when rising_edge(rclock);
	rreq <= 	"0001" when RRState = "00" else 
			"0010" when RRState = "01" else 
			"0100" when RRState = "10" else 
			"1000" when RRState = "11" else
			"XXXX";
			
	wreq1Q1 <= '1' when ((dataINReg1out(1 downto 0) = "00") and wr1 ='1' ) else '0';
	wreq1Q2 <= '1' when ((dataINReg2out(1 downto 0) = "00") and wr2 ='1' ) else '0';
	wreq1Q3 <= '1' when ((dataINReg3out(1 downto 0) = "00") and wr3 ='1' ) else '0';
	wreq1Q4 <= '1' when ((dataINReg4out(1 downto 0) = "00") and wr4 ='1' ) else '0';

	wreq2Q1 <= '1' when ((dataINReg1out(1 downto 0) = "01") and wr1 ='1' ) else '0';
	wreq2Q2 <= '1' when ((dataINReg2out(1 downto 0) = "01") and wr2 ='1' ) else '0';
	wreq2Q3 <= '1' when ((dataINReg3out(1 downto 0) = "01") and wr3 ='1' ) else '0';
	wreq2Q4 <= '1' when ((dataINReg4out(1 downto 0) = "01") and wr4 ='1' ) else '0';

	wreq3Q1 <= '1' when ((dataINReg1out(1 downto 0) = "10") and wr1 ='1' ) else '0';
	wreq3Q2 <= '1' when ((dataINReg2out(1 downto 0) = "10") and wr2 ='1' ) else '0';
	wreq3Q3 <= '1' when ((dataINReg3out(1 downto 0) = "10") and wr3 ='1' ) else '0';
	wreq3Q4 <= '1' when ((dataINReg4out(1 downto 0) = "10") and wr4 ='1' ) else '0';

	wreq4Q1 <= '1' when ((dataINReg1out(1 downto 0) = "11") and wr1 ='1' ) else '0';
	wreq4Q2 <= '1' when ((dataINReg2out(1 downto 0) = "11") and wr2 ='1' ) else '0';
	wreq4Q3 <= '1' when ((dataINReg3out(1 downto 0) = "11") and wr3 ='1' ) else '0';
	wreq4Q4 <= '1' when ((dataINReg4out(1 downto 0) = "11") and wr4 ='1' ) else '0';

	datai1_reg: Register8Bit PORT MAP (rst,wclock, wr1, datai1, dataINReg1out);
	datai2_reg: Register8Bit PORT MAP (rst,wclock, wr2, datai2, dataINReg2out);
	datai3_reg: Register8Bit PORT MAP (rst,wclock, wr3, datai3, dataINReg3out);
	datai4_reg: Register8Bit PORT MAP (rst,wclock, wr4, datai4, dataINReg4out);

	Demux1: Demux PORT MAP (wr1 ,dataINReg1out(1 downto 0),dataINReg1out ,Demux1Q1 ,Demux1Q2 , Demux1Q3 , Demux1Q4); 
	Demux2: Demux PORT MAP (wr2 ,dataINReg2out(1 downto 0),dataINReg2out ,Demux2Q1 ,Demux2Q2 , Demux2Q3 , Demux2Q4); 
	Demux3: Demux PORT MAP (wr3 ,dataINReg3out(1 downto 0),dataINReg3out ,Demux3Q1 ,Demux3Q2 , Demux3Q3 , Demux3Q4); 
	Demux4: Demux PORT MAP (wr4 ,dataINReg4out(1 downto 0),dataINReg4out ,Demux4Q1 ,Demux4Q2 , Demux4Q3 , Demux4Q4);  

	Data1Queue1: fifo PORT MAP (rst ,rclock,wclock,rreq(0),wreq1Q1,Demux1Q1, Q1O1out); 
	Data1Queue2: fifo PORT MAP (rst ,rclock,wclock,rreq(1),wreq1Q2,Demux2Q1, Q1O2out);
	Data1Queue3: fifo PORT MAP (rst ,rclock,wclock,rreq(2),wreq1Q3,Demux3Q1, Q1O3out);
	Data1Queue4: fifo PORT MAP (rst ,rclock,wclock,rreq(3),wreq1Q4,Demux4Q1, Q1O4out);

	Data2Queue1: fifo PORT MAP (rst ,rclock,wclock,rreq(0),wreq2Q1,Demux1Q2, Q2O1out); 
	Data2Queue2: fifo PORT MAP (rst ,rclock,wclock,rreq(1),wreq2Q2,Demux2Q2, Q2O2out);
	Data2Queue3: fifo PORT MAP (rst ,rclock,wclock,rreq(2),wreq2Q3,Demux3Q2, Q2O3out);
	Data2Queue4: fifo PORT MAP (rst ,rclock,wclock,rreq(3),wreq2Q4,Demux4Q2, Q2O4out);

	Data3Queue1: fifo PORT MAP (rst ,rclock,wclock,rreq(0),wreq3Q1,Demux1Q3, Q3O1out); 
	Data3Queue2: fifo PORT MAP (rst ,rclock,wclock,rreq(1),wreq3Q2,Demux2Q3, Q3O2out);
	Data3Queue3: fifo PORT MAP (rst ,rclock,wclock,rreq(2),wreq3Q3,Demux3Q3, Q3O3out);
	Data3Queue4: fifo PORT MAP (rst ,rclock,wclock,rreq(3),wreq3Q4,Demux4Q3, Q3O4out);

	Data4Queue1: fifo PORT MAP (rst ,rclock,wclock,rreq(0),wreq4Q1,Demux1Q4, Q4O1out); 
	Data4Queue2: fifo PORT MAP (rst ,rclock,wclock,rreq(1),wreq4Q2,Demux2Q4, Q4O2out);
	Data4Queue3: fifo PORT MAP (rst ,rclock,wclock,rreq(2),wreq4Q3,Demux3Q4, Q4O3out);
	Data4Queue4: fifo PORT MAP (rst ,rclock,wclock,rreq(3),wreq4Q4,Demux4Q4, Q4O4out);

	RR1: RoundRobinScheduler PORT MAP (rclock, Q1O1out, Q1O2out, Q1O3out, Q1O4out, dataOUTReg1IN);
	RR2: RoundRobinScheduler PORT MAP (rclock, Q2O1out, Q2O2out, Q2O3out, Q2O4out, dataOUTReg2IN);
	RR3: RoundRobinScheduler PORT MAP (rclock, Q3O1out, Q3O2out, Q3O3out, Q3O4out, dataOUTReg3IN);
	RR4: RoundRobinScheduler PORT MAP (rclock, Q4O1out, Q4O2out, Q4O3out, Q4O4out, dataOUTReg4IN);

	datao1_reg: Register8Bit PORT MAP (rst,rclock, '1', dataOUTReg1IN, datao1);
	datao2_reg: Register8Bit PORT MAP (rst,rclock, '1', dataOUTReg2IN, datao2);
	datao3_reg: Register8Bit PORT MAP (rst,rclock, '1', dataOUTReg3IN, datao3); 
	datao4_reg: Register8Bit PORT MAP (rst,rclock, '1', dataOUTReg4IN, datao4);
End Architecture router_Arch;