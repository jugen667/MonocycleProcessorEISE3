------- # Auteur : Julien GENTY # -------
---- # Test Bench de l'ALU en VHDL # ----

-- Librairies à utiliser --
library IEEE;
	use IEEE.std_logic_1164.ALL;
	use IEEE.numeric_std.ALL;
	use IEEE.std_logic_unsigned.all;

-- Declaration d'une entité pour le test bench	
entity ALU_tb is 
end ALU_tb;

-- Architecture du test bench
architecture test_bench of ALU_tb is 

-- Declaration des signaux internes
	signal A : std_logic_vector(31 downto 0) := "00000111000000110000011100001010";
	signal B : std_logic_vector(31 downto 0) := "01110010101000001110000000000101";
	signal OP : std_logic_vector(1 downto 0);
	signal Drap : std_logic_vector(1 downto 0);
	signal Sortie : std_logic_vector(31 downto 0);
	
	begin
-- Import de l'entité ALU
Test_ALU : 	entity work.ALU(Behaviour)
				port map (OP, A, B, Sortie, Drap);
				
	
		process
			begin
				OP <= "00";
				wait for 10 ns;
				OP <= "01";
				wait for 10 ns;
				OP <= "10";
				wait for 10 ns;
				OP <= "11";
				wait for 10 ns;
		end process;
end architecture;
	
----------- # Fin du fichier # -----------