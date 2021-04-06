--------------- # Auteur : Julien GENTY # ---------------
-- # Assemblage des entités de l'unité de traitement # --

-- Librairies à utiliser --
library IEEE;
	use IEEE.std_logic_1164.ALL;
	use IEEE.numeric_std.ALL;
	use IEEE.std_logic_unsigned.all;
  

-- Declaration de l'entité
entity BUAL is 
	port(
		clk, rst, write_enable : in std_logic;
		flag : out std_logic_vector(1 downto 0);
		Ra, Rb, Rw : in std_logic_vector(3 downto 0);
		OP : in std_logic_vector(1 downto 0);
		Sortie_Bus : out std_logic_vector(31 downto 0)
		);
end entity;

architecture Behaviour of BUAL is 

signal A, B, busW : std_logic_vector(31 downto 0);

	begin
	
Registres : entity work.RegBench(Behaviour)
				port map(clk, rst, write_enable, busW, Ra, Rb, Rw, A, B);
				
UAL : 	entity work.ALU(Behaviour)
			port map(OP, A, B, busW, flag);
			
Sortie_Bus <= busW;

end architecture;