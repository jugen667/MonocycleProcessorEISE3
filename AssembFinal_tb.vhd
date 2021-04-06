--------------- # Auteur : Julien GENTY # ---------------
-- # Assemblage final de l'unité de traitement # --

-- Librairies à utiliser --
library IEEE;
	use IEEE.std_logic_1164.ALL;
	use IEEE.numeric_std.ALL;
	use IEEE.std_logic_unsigned.all;
  

-- Declaration de l'entité
entity AssembFinal_tb is
end entity;

-- Declaration de l'architecture

architecture Behaviour of AssembFinal_tb is

-- Declaration des signaux
signal Imm : std_logic_vector(7 downto 0);
signal clk : std_logic := '1';
signal rst, RegWr, WrEn, SelMux1, SelMux2 : std_logic;
signal flag, OP : std_logic_vector(1 downto 0);
signal Ra, Rb, Rw : std_logic_vector(3 downto 0);
signal Sortie : std_logic_vector(31 downto 0);

begin

Assemblage : entity work.AssembFinal(Behaviour)
				port map(clk, rst, RegWr, WrEn, SelMux1, SelMux2, Imm, flag, Ra, Rb, Rw, OP, Sortie);

	clk <= not(clk) after 5 ns;
	process
		begin 
			-- Addition de 2 registres
			RegWr <= '1';
			Ra <= "1111";
			Rb <= "1111";
			SelMux1 <= '0';
			OP <= "00";
			SelMux2 <= '0';
			wait for 20 ns;
			-- Addition avec valeur immédiate
			RegWr <= '1';
			Ra <= "1111";
			Imm <= "00001110";
			SelMux1 <= '1';
			OP <= "00";
			SelMux2 <= '0';
			wait for 20 ns;
			-- Soustraction de 2 regitres
			RegWr <= '1';
			Ra <= "1111";
			Rb <= "1111";
			SelMux1 <= '0';
			OP <= "10";
			SelMux2 <= '0';
			wait for 20 ns;
			-- Soustraction avec valeur immédiate
			RegWr <= '1';
			Ra <= "1111";
			Imm <= "00001110";
			SelMux1 <= '1';
			OP <= "10";
			SelMux2 <= '0';
			wait for 20 ns;
			--Copie de la valeur d'un registre dans un autre registre
			RegWr <= '1';
			Rw <= "0111";
			Ra <= "1111";
			OP <= "11";
			SelMux2 <= '0';
			wait for 20 ns;
			-- Ecriture d'un registre dans un mot mémoire
			RegWr <= '1';
			WrEn <= '1';
			Rb <= "0111";
			SelMux1 <= '0';
			OP <= "01";
			SelMux2 <= '0';
			wait for 20 ns;
			-- Lecture d'un mot mémoire
			RegWr <= '1';
			Rb <= "0111";
			SelMux1 <= '0';
			OP <= "01";
			SelMux2 <= '0';
			wait for 20 ns;
			
	end process;
end architecture;