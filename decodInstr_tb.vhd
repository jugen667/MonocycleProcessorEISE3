library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decodInstr_tb is
end entity decodInstr_tb;

architecture testbench of decodInstr_tb is
	signal Instruction : std_logic_vector (31 downto 0);
	signal PSR : std_logic_vector (31 downto 0);
	signal Offset : std_logic_vector(23 downto 0);
	signal Imm : std_logic_vector(7 downto 0);
	signal Rn, Rd, Rm : std_logic_vector(3 downto 0);
	signal ALUctr : std_logic_vector(1 downto 0);
	signal nPCsel, RegWr, ALUsrc, PSREn, MemWr, WrSrc, RegSel : std_logic;

	begin

		UUT : entity work.decodInstr(RTL)
		port map
		(Instruction, PSR, Offset, Imm, ALUctr, Rn, Rd, Rm, nPCsel, RegWr, ALUsrc, PSREn, MemWr, WrSrc,RegSel);

		process
			begin
				Instruction <= x"E3A01010";		-- 0x0 _main  -- MOV R1,#0x10 -- R1 = 0x10       			--> GOOD
				PSR <= x"00000000";
				wait for 5 ms;
				Instruction <= x"E3A02000";		-- 0x1		 -- MOV R2,#0x00 -- R2 = 0						--> GOOD
				wait for 5 ms;
				Instruction <= x"E6110000";	-- 0x2 _loop -- LDR R0,0(R1) -- R0 = DATAMEM[R1] 			--> GOOD
				wait for 5 ms;
				Instruction <= x"E0822000";	-- 0x3		 -- ADD R2,R2,R0 -- R2 = R2 + R0				--> GOOD
				wait for 5 ms;
				Instruction <= x"E2811001";	-- 0x4		 -- ADD R1,R1,#1 -- R1 = R1 + 1					--> GOOD
				wait for 5 ms;
				Instruction <= x"E351002A";	-- 0x5		 -- CMP R1,0x1A  -- si R1 >= 0x1A				--> GOOD
				wait for 5 ms;								 -- ATTENTION <== Douze avait écris "1A" mais c'est "2A"
				PSR <= x"00000001";
				Instruction <= x"BAFFFFFB";	-- 0x6		 -- BLT loop 	 -- PC = PC + (-5) si N = 1		--> GOOD
				wait for 5 ms;
				Instruction <= x"E6012000";	-- 0x7		 -- STR R2,0(R1) -- DATAMEM[R1] = R2			--> GOOD
				wait for 5 ms;
				Instruction <= x"EAFFFFF7";	-- 0x8		 -- BAL main	 -- PC = PC + (-9)				--> GOOD
				wait for 5 ms;								 -- ATTENTION <== Douze avait écris "-7" mais c'est "-9"
		end process;

end architecture;
