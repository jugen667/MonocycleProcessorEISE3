--------------- # Auteur : Julien GENTY # ---------------
-- # Registre 32 bits avec commande de chargement # --

-- Librairies à utiliser --
library IEEE;
	use IEEE.std_logic_1164.ALL;
	use IEEE.numeric_std.ALL;
	use IEEE.std_logic_unsigned.all;
 
-- Declaration de l'entité
entity Reg32Comm is
	port(
		clk, rst, WE : in std_logic;
		DataIn : in std_logic_vector(31 downto 0);
		DataOut : out std_logic_vector(31 downto 0)
	);
end entity;

-- Declaration de l'architecture 
architecture Behaviour of Reg32Comm is
	signal Sauvegarde : std_logic_vector(31 downto 0);
begin
	process(clk, rst)
	begin
		if rst = '1' then
			DataOut <= (others => '0');
		elsif rising_edge(clk) then
			if WE = '1' then
				DataOut <= Sauvegarde;
			end if;
		end if;

	Sauvegarde <= DataIn;
	end process;
end architecture;