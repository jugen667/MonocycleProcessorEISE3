--------------- # Auteur : Julien GENTY # ----------------
---------- # Assemblage du processeur final ! # ----------

-- Librairies à utiliser --
library IEEE;
	use IEEE.std_logic_1164.ALL;
	use IEEE.numeric_std.ALL;
	use IEEE.std_logic_unsigned.all;
  

-- Declaration de l'entité
entity ProcMonocycle is
	port(
		clk, rst : in std_logic
	);
end entity;

architecture Behaviour of ProcMonocycle is

signal nPCSel, RegSel, PSREnable, RegWr, AluSrc, MemWr, WrSrc : std_logic;
signal Instruction, PSROut, busW : std_logic_vector(31 downto 0);
signal Offset : std_logic_vector(23 downto 0);
signal Imm : std_logic_vector(7 downto 0);
signal flag, AluCtr : std_logic_vector(1 downto 0);
signal Rd, Rn, Rm, SortieMuxR : std_logic_vector(3 downto 0);
signal flag_32 : std_logic_vector(31 downto 0);


	begin

GestInstr:		entity work.GestInstr(Behaviour)
					port map(clk, rst, nPCSel, Offset, Instruction);


decodInstr :  	entity work.decodInstr(RTL)
					port map(Instruction, PSROut, Offset, Imm, AluCtr, Rd, Rn, Rm, nPCSel, RegWr, AluSrc, PSREnable, MemWr, WrSrc, RegSel);
					

MuxR : 			entity work.Mux2_1(Behaviour)
					generic map(4)
					port map(Rm, Rd, RegSel, SortieMuxR);
					
	
AssembCalcul:	entity work.AssembFinal(Behaviour)
					port map(clk, rst, RegWr, MemWr, AluSrc, WrSrc, Imm, flag_32(1 downto 0), Rn, SortieMuxR, Rd, AluCtr, busW);	


PSRChanger :    entity work.Reg32Comm(Behaviour)
					port map(clk, rst, PSREnable, flag_32, PSROut);
	

end architecture;

