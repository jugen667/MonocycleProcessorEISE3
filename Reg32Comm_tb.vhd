--------------- # Auteur : Julien GENTY # ---------------
-- # Test Bench Registre 32 bits avec commande de chargement # --

-- Librairies à utiliser --
library IEEE;
	use IEEE.std_logic_1164.ALL;
	use IEEE.numeric_std.ALL;
	use IEEE.std_logic_unsigned.all;
 
-- Declaration de l'entité
entity Reg32Comm_tb is
end entity;

-- Declaration de l'architecture
architecture Behaviour of Reg32Comm_tb is 
	signal clk : std_logic := '1';
	signal rst, WE : std_logic;
	signal DataIn, DataOut : std_logic_vector(31 downto 0);

begin

Registre : entity work.Reg32Comm(Behaviour)
			port map(clk, rst, WE, DataIn, DataOut);
DataIn <= X"000AA002";
	
clk <= not(clk) after 5 ns;		
process
	begin
		rst <= '1';
		wait for 5 ns;
		rst <= '0';
		wait for 5 ns;
		WE <= '1';
		wait for 20 ns;
		WE <= '0';
		wait for 20 ns;

end process;
end architecture;
		
		
