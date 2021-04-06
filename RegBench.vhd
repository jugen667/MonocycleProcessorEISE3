------------ # Auteur : Julien GENTY # ------------
-- # Descprition d'un banc de registre en VHDL # --

-- Librairies à utiliser --
library IEEE;
	use IEEE.std_logic_1164.ALL;
	use IEEE.numeric_std.ALL;
	use IEEE.std_logic_unsigned.all;
 
-- Declaration de l'entité RegBench 
entity RegBench is 
	port(
		clk, rst, write_enable : in std_logic;
		W : in std_logic_vector(31 downto 0);
		RA, RB, RW : in std_logic_vector(3 downto 0);
		A, B : out std_logic_vector(31 downto 0)
		);
end entity;


architecture Behaviour of RegBench is 

-- Declaration Type Tableau Memoire
	type table is array(15 downto 0) of std_logic_vector(31 downto 0);

-- Fonction d'Initialisation du Banc de Registres
	function init_banc return table is
		variable result : table;
		begin
			for i in 14 downto 0 loop
				result(i) := (others=>'0');
			end loop;
			result(15):=X"00000030";
		return result;
	end init_banc;

-- Déclaration et Initialisation du Banc de Registres 16x32 bits
	signal Banc: table:=init_banc;

	begin
		A <= Banc(to_integer(unsigned(RA)));
		B <= Banc(to_integer(unsigned(RB)));
		process(clk, rst)
			begin	
				if rst = '1' then
					for i in 14 downto 0 loop
						Banc(i) <= (others => '0');
					end loop;
					Banc(15) <= X"00000030";

				elsif rising_edge(clk) then
					if write_enable = '1' then
						Banc(to_integer(unsigned(RW))) <= W;
					end if;
				end if;
		end process;
end architecture;

---------------- # Fin du fichier # ----------------	
