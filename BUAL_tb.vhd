-------------------------- # Auteur : Julien GENTY # ---------------------
-- #  Test Bench de l'assemblage des entités de l'unité de traitement # --

-- Librairies à utiliser --
library IEEE;
	use IEEE.std_logic_1164.ALL;
	use IEEE.numeric_std.ALL;
	use IEEE.std_logic_unsigned.all;
	
-- Entité du Test Bench 
entity BUAL_tb is 
end entity;

architecture Behaviour of BUAL_tb is 

signal Ra, Rb, Rw : std_logic_vector(3 downto 0);
signal clk : std_logic := '0';
signal WE : std_logic := '1';
signal rst: std_logic;
signal OP, flag  : std_logic_vector(1 downto 0);
signal sortie : std_logic_vector(31 downto 0);

begin
Test_Bench : entity work.BUAL(Behaviour)
				port map(clk, rst, WE, flag, Ra, Rb, Rw, OP, sortie);

clk <= not(clk) after 5 ns;

process 
	begin
		-- R(1) = R(15)
		Rw <= "0001";
		Ra <= "1111";
		OP <= "01";
		wait for 20 ns;
		-- R(1) = R(1) + R(15)
		Ra <= "0001";
		Rb <= "1111";
		OP <= "00";
		wait for 20 ns;
		-- R(2) = R(1) + R(15)
		Rw <= "0010";
		Ra <= "0001";
		Rb <= "1111";
		OP <= "00";
		wait for 20 ns;
		-- R(3) = R(1) - R(15)
		Rw <= "0011";
		Ra <= "0001";
		Rb <= "1111";
		OP <= "10";
		wait for 20 ns;
		-- R(5) = R(7) - R(15)
		Rw <= "0101";
		Ra <= "0111";
		Rb <= "1111";
		OP <= "10";
		wait for 20 ns;
	end process;
end architecture;