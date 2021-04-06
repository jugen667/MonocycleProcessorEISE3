--- # Auteur : Julien GENTY # ---
--- # Multiplexeur 2 vers 1 # ---

-- Librairies à utiliser --
library IEEE;
	use IEEE.std_logic_1164.ALL;
	use IEEE.numeric_std.ALL;
	use IEEE.std_logic_unsigned.all;
 

-- Declaration de l'entité du multiplexeur --
entity Mux2_1 is
	generic (N : integer);
	port(
		A, B : in std_logic_vector(N-1 downto 0);
		COM : in std_logic;
		S : out std_logic_vector(N-1 downto 0)
		);
end entity;

-- Declaration de l'architecture du multiplexeur --
architecture Behaviour of Mux2_1 is
	begin
		with COM select
			S <= A when '0',
				 B when '1',
				 (others => '0') when others;

end architecture;
	