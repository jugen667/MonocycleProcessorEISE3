library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity instruction_memory_2 is 
	port(
		PC: in std_logic_vector (31 downto 0);
		Instruction: out std_logic_vector (31 downto 0)
    );
end entity;

architecture RTL of instruction_memory_2 is
	type RAM64x32 is array (0 to 63) of std_logic_vector (31 downto 0);
	
function init_mem return RAM64x32 is 
	variable result : RAM64x32;
begin
	for i in 63 downto 0 loop
		result (i):=(others=>'0');
	end loop;					-- PC        -- INSTRUCTION  	-- COMMENTAIRE
		result (0):=x"E3A00010";-- 0x0 _main -- MOV R0,#0x10	-- R0 = 0x10
		result (1):=x"E3A01001";-- 0x1		 -- MOV R1,#0x01 	-- I = 1
		result (2):=x"E6103000";-- 0x2 _for  -- LDR R3,0(R0) 	-- TAB[i] 
		result (3):=x"E6104001";-- 0x3		 -- LDR R4,[R0,#1] 	-- TAB[i+1]
		result (4):=x"E6004000";-- 0x4		 -- STR R4, [R0]	-- TAB[i] = R4
		result (5):=x"E6003001";-- 0x5		 -- STR R3, [R0,#1] -- TAB[i+1] = R3
		result (6):=x"E2800001";-- 0x6		 -- ADD R0,R0,#1 	-- incrémente adresse du Tab
		result (7):=x"E2811001";-- 0x7		 -- ADD R1,R1,#1 	-- i++
		result (8):=x"E351000A";-- 0x8	     -- CMP R1,0xA   	-- si R1 >= 0xA soit i > 10
		result (9):=x"BAFFFFF8";-- 0x9       -- BLT for		 	-- PC = PC + (-8) si N = 1
		result(10):=x"EAFFFFFF";-- 0xA _wait -- BAL wait		-- boucle infinie		
	return result;
end init_mem;	

signal mem: RAM64x32 := init_mem;

begin 
			Instruction <= mem(to_integer (unsigned (PC(5 downto 0))));
end architecture;
	
