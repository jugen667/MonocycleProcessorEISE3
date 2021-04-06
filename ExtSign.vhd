--- # Auteur : Julien GENTY # ---
--- # Extension de signe de N vers 32 bits # ---

-- Librairies à utiliser --
library IEEE;
	use IEEE.std_logic_1164.ALL;
	use IEEE.numeric_std.ALL;
	use IEEE.std_logic_unsigned.all;
 

-- Declaration de l'entité de l'extension de signe --
entity ExtSign is 
	generic (N : integer);
	port(
		E : in std_logic_vector(N-1 downto 0);
		S : out std_logic_vector(31 downto 0)
	);
end entity;

architecture Behaviour of ExtSign is 

begin
	S(31 downto N) <= (others => E(N-1));
	S(N-1 downto 0) <= E;
	
	
end architecture;