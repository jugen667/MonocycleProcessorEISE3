------- # Auteur : Julien GENTY # -------
--- # Descprition d'une UAL en VHDL # ---

-- Librairies à utiliser --
library IEEE;
	use IEEE.std_logic_1164.ALL;
	use IEEE.numeric_std.ALL;
	use IEEE.std_logic_unsigned.all;
  
-- Déclaration de l'entité ALU --
entity ALU is 
	port(
		OP : in std_logic_vector(1 downto 0);		-- Signal de commande
		A, B: in std_logic_vector(31 downto 0); 	-- Bus 32 bits entrée
		S : out std_logic_vector(31 downto 0); 		-- Bus 32 bits sortie
		flag : out std_logic_vector(1 downto 0)
		);
end entity;

-- Déclaration de l'architecture Behaviour de ALU --
architecture Behaviour of ALU is 
Signal Temp_Out : std_logic_vector(31 downto 0);   	-- On crée un signal interne pour pouvoir recopier les bits de poids fort de la sortie dans le drapeau N
	begin
Sortie : with OP select 
			Temp_Out <= A + B when "00",			-- ADD
						B when "01",				-- B
						A - B when "10",			-- SUB
						A when "11",				-- A
						(others => '0') when others;
	flag(0) <= Temp_Out(31);	--On recupere le bit de poids fort pour le drapeau
	flag(1) <= '1' when Temp_Out = X"00000000" else '0';
	S <= Temp_Out;
end architecture Behaviour;

----------- # Fin du fichier # -----------