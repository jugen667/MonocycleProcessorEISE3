--------------- # Auteur : Julien GENTY # ---------------
-- # Decodage des instructions # --	

-- Librairies à utiliser --
library IEEE;
	use IEEE.std_logic_1164.ALL;
	use IEEE.numeric_std.ALL;
	use IEEE.std_logic_unsigned.all;
  

-- Declaration de l'entité
entity decodInstr is 
	port(
		Instruction, PSR : in std_logic_vector(31 downto 0);
		Offset : out std_logic_vector(23 downto 0);
		Imm : out std_logic_vector(7 downto 0);
		AluCtr : out std_logic_vector(1 downto 0);
		Rd, Rn, Rm : out std_logic_vector(3 downto 0);
		nPCSel, RegWr, AluSrc, PSREn, MemWr, WrSrc, RegSel : out std_logic
	);
end entity;

architecture RTL of decodInstr is
type enum_instruction is (ADDi, ADDr, ADDGT, BAL, BLT, BGT, BNE, CMPr, CMPi, LDR, MOV, STR, STRGT);
signal instr_courante : enum_instruction;

begin 
  		process(Instruction)

  			begin
			--CHecking Conditions
				if Instruction(31 downto 28)="1110" then   	--AL (toujours vrai)
					-- CHecking OPCODE
					if Instruction(24 downto 21)="0100" then   	--Addition sans condition
						if Instruction(25) ='1' then			  
							instr_courante <= ADDi;				--Immédiat 
						else 
							instr_courante <= ADDr;				--Entre registres
						end if;
						
					-- elsif Instruction(24 downto 21)="0010" then	--Soustraction sans condition / non utilisé ici
						-- if Instruction(25) ='1' then
							-- instr_courante <= SUBi;				--Immédiat
						-- else 
							-- instr_courante <= SUBr;				--Entre registres
						-- end if;
					
					elsif Instruction(24 downto 21) = "1101" then			-- Ecriture sur registre MOV
						instr_courante <= MOV;
					
					elsif Instruction(27 downto 26) ="10" then	--Branchement toujours vrai (ie jump)
						instr_courante <= BAL;
						
					elsif Instruction(27 downto 21)="0110000" then -- Opérations sur la mémoire
						if Instruction(20) = '1' then
							instr_courante <= LDR;				-- CHargement mémoire
						else
							instr_courante <= STR;				-- Ecriture en mémoire
						end if;
						
					elsif Instruction(24 downto 21)="1010" then --Comparaison
						if Instruction(25) = '1' then
							instr_courante <= CMPi;
						else
							instr_courante <= CMPr;
						end if;
					end if;
					
				-- elsif Instruction(31 downto 28)="0000" then   --EQ (si le flag Z renvoit 1 après CMP / non utilisé ici)
					-- CHecking OPCODE
					
					
				elsif Instruction(31 downto 28)="0001" then   --NE (si le flag ZE renvoit 0 après CMP)
					-- CHecking OPCODE
					if Instruction(27 downto 26) ="10" then
						instr_courante <= BNE;
					end if;
					
				elsif Instruction(31 downto 28)="1011" then   --LT
					-- CHecking OPCODE
					if Instruction(27 downto 26) ="10" then
						instr_courante <= BLT;
					end if;
					
				elsif Instruction(31 downto 28)="1100" then   --GT
					-- CHecking OPCODE
					if Instruction(24 downto 21)="0100" then -- Addition si flag N renvoit 0
						instr_courante <= ADDGT;
					elsif Instruction(27 downto 26) = "10" then
						instr_courante <= BGT;
					elsif Instruction(24 downto 21)="0000" then
						instr_courante <= STRGT;
					end if;
				end if;
  				
  		end process;

  		process(Instruction, instr_courante)

  			begin
  				Offset <= Instruction(23 downto 0);
  				Rn <= Instruction(19 downto 16);
  				Rd <= Instruction(15 downto 12);
  				Imm <= Instruction(7 downto 0);
  				Rm <= Instruction(3 downto 0);
  				case instr_courante is
					-- Addition immédiate
  					when ADDi =>
						nPCsel <= '0';
						RegWr  <= '1';
						ALUsrc <= '1';
						ALUctr <= "00";
						PSREn  <= '0';
						MemWr  <= '0';
						WrSrc  <= '0';
						RegSel <= '1';
					-- Addition entre registres
  					when ADDr =>
						nPCsel <= '0';
						RegWr  <= '1';
						ALUsrc <= '0';
						ALUctr <= "00";
						PSREn  <= '0';
						MemWr  <= '0';
						WrSrc  <= '0';
						RegSel <= '0';
					-- Addition immédiate avec condition GT
					when ADDGT =>
						nPCsel <= '0';
						RegWr  <= not(PSR(0));
						ALUsrc <= '1';
						ALUctr <= "00";
						PSREn  <= '0';
						MemWr  <= '0';
						WrSrc  <= '0';
						RegSel <= '1';
					-- Jump
  					when BAL  =>
						nPCsel <= '1';
						RegWr  <= '0';
						ALUsrc <= '0';
						ALUctr <= "00";
						PSREn  <= '0';
						MemWr  <= '0';
						WrSrc  <= '0';
						RegSel <= '1';
					-- Jump condition LT
					when BLT  =>
						nPCsel <= PSR(0);
						RegWr  <= '0';
						ALUsrc <= '0';
						ALUctr <= "00";
						PSREn  <= '0';
						MemWr  <= '0';
						WrSrc  <= '0';
						RegSel <= '1';
					-- Jump condition GT
					when BGT  =>
						nPCsel <= not(PSR(0));
						RegWr  <= '0';
						ALUsrc <= '0';
						ALUctr <= "00";
						PSREn  <= '0';
						MemWr  <= '0';
						WrSrc  <= '0';
						RegSel <= '1';
					-- Jump conditon NE
					when BNE  =>
						nPCsel <= not(PSR(1));
						RegWr  <= '0';
						ALUsrc <= '0';
						ALUctr <= "00";
						PSREn  <= '0';
						MemWr  <= '0';
						WrSrc  <= '0';
						RegSel <= '1';
					-- Comparaison immédiate
  					when CMPi  =>
						nPCsel <= '0';
						RegWr  <= '0';
						ALUsrc <= '1';
						ALUctr <= "10";
						PSREn  <= '1';
						MemWr  <= '0';
						WrSrc  <= '0';
						RegSel <= '1';
					-- Comparaison registres
					when CMPr  =>
						nPCsel <= '0';
						RegWr  <= '0';
						ALUsrc <= '0';
						ALUctr <= "10";
						PSREn  <= '1';
						MemWr  <= '0';
						WrSrc  <= '0';
						RegSel <= '0';
					-- Chargement mémoire -> Registre
  					when LDR  =>
						nPCsel <= '0';
						RegWr  <= '1';
						ALUsrc <= '1';
						ALUctr <= "00";
						PSREn  <= '0';
						MemWr  <= '0';
						WrSrc  <= '1';
						RegSel <= '1';
					-- Ecriture registres
  					when MOV  =>
						nPCsel <= '0';
						RegWr  <= '1';
						ALUsrc <= '1';
						ALUctr <= "01";
						PSREn  <= '0';
						MemWr  <= '0';
						WrSrc  <= '0';
						RegSel <= '1';
					-- CHargement Registre -> Memoire
  					when STR  =>
						nPCsel <= '0';
						RegWr  <= '0';
						ALUsrc <= '1';
						ALUctr <= "00";
						PSREn  <= '0';
						MemWr  <= '1';
						WrSrc  <= '0';
						RegSel <= '1';
					-- CHargement Registre -> Memoire avec condition GT
					when STRGT =>
						nPCsel <= '0';
						RegWr  <= '0';
						ALUsrc <= '1';
						ALUctr <= "00";
						PSREn  <= '0';
						MemWr  <= not(PSR(0));
						WrSrc  <= '0';
						RegSel <= '1';
					
  				end case;
  		end process;
end architecture;