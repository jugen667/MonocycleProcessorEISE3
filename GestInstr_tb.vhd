--------------- # Auteur : Julien GENTY # ---------------
-- # Test bench gestion des instructions # --

-- Librairies à utiliser --
library IEEE;
	use IEEE.std_logic_1164.ALL;
	use IEEE.numeric_std.ALL;
	use IEEE.std_logic_unsigned.all;
	
--Declaration de l'entité
entity GestInstr_tb is
end entity;

architecture Behaviour of GestInstr_tb is 

signal Offset : std_logic_vector(23 downto 0) := X"00000A";
signal clk : std_logic := '1';
signal rst, nPCsel : std_logic;
signal Instruction : std_logic_vector(31 downto 0);


begin
	
GestInstr : entity work.GestInstr(Behaviour)
				port map(clk, rst, nPCsel, Offset, Instruction);

clk <= not(clk) after 5 ns;

process	
	begin
		rst <= '1';
		wait for 5 ns;
		rst <= '0';
		wait for 5 ns;
		nPCsel <= '0';
		wait for 50 ns;
		nPCsel <= '1';
		wait for 50 ns;
end process;

end architecture;	