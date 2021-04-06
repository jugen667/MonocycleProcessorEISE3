------------ # Auteur : Julien GENTY # ------------
-- # Test Bench pour la mémoire de données # --

-- Librairies à utiliser --
library IEEE;
	use IEEE.std_logic_1164.ALL;
	use IEEE.numeric_std.ALL;
	use IEEE.std_logic_unsigned.all;
	
-- Declaration d'une entité pour le test bench	
entity DataMem_tb is 
end entity;

architecture Behaviour of DataMem_tb is
-- Declarationdes signaux internes
	signal clk : std_logic := '0';
	signal rst : std_logic; 
	signal WE : std_logic := '1';
	signal DataIn, DataOut : std_logic_vector(31 downto 0);
	signal Addr : std_logic_vector(5 downto 0);

	begin
Test_Bench : 	entity work.DataMem(Behaviour)
					port map(clk, rst, WE, Addr, DataIn, DataOut);
	
	clk <= not(clk) after 5 ns;
	process 
		begin 
			DataIn<= "00000111000000110000011100001010";
			Addr <= "000010";
			wait for 20 ns;
			DataIn <= "00000111001100110000011100001010";
			Addr <= "010000";
			wait for 20 ns;
			
	end process;
end architecture;