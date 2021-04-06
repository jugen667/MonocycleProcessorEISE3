--------------- # Auteur : Julien GENTY # ---------------
-- # Assemblage final de l'unité de traitement # --

-- Librairies à utiliser --
library IEEE;
	use IEEE.std_logic_1164.ALL;
	use IEEE.numeric_std.ALL;
	use IEEE.std_logic_unsigned.all;
  

-- Declaration de l'entité
entity AssembFinal is 
	port(
		clk, rst, RegWr, WrEn, SelMux1, Selmux2 : in std_logic;
		Imm : in std_logic_vector(7 downto 0);
		flag : out std_logic_vector(1 downto 0);
		Ra, Rb, Rw : in std_logic_vector(3 downto 0);
		OP : in std_logic_vector(1 downto 0);
		Sortie_Bus : out std_logic_vector(31 downto 0)
		);
end entity;

architecture Behaviour of AssembFinal is 

signal busA, busB, busW, EntreeMux1, SortieMux1, ALUOut, DataOut : std_logic_vector(31 downto 0);  -- busB servira aussi de DataIn

	begin
	
Registres : entity work.RegBench(Behaviour)
				port map(clk, rst, RegWr, busW, Ra, Rb, Rw, busA, busB);
				
				
Mux1 : 		entity work.Mux2_1(Behaviour)
				generic map(busA'length)
				port map(busB, EntreeMux1, SelMux1, SortieMux1);
				
ValImm : 	entity work.ExtSign(Behaviour)
				generic map(Imm'length)
				port map (Imm, EntreeMux1);

UAL : 		entity work.ALU(Behaviour)
				port map(OP, busA, SortieMux1, ALUOut, flag);

DataMem : 	entity work.DataMem(Behaviour)
				port map(clk, rst, WrEn, ALUOut(5 downto 0), busB, DataOut);

Mux2 : 		entity work.Mux2_1(Behaviour)
				generic map(ALUOut'length)
				port map(ALUOut, DataOut, SelMux2, busW);
				
Sortie_Bus <= busW;

end architecture;