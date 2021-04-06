--- # Auteur : Julien GENTY # ---
--- # Test Bench Extension de signe de N vers 32 bits # ---

-- Librairies à utiliser --
library IEEE;
	use IEEE.std_logic_1164.ALL;
	use IEEE.numeric_std.ALL;
	use IEEE.std_logic_unsigned.all;
 

-- Declaration de l'entité du tb de l'extension de signe --
entity ExtSign_tb is
end entity;


-- Architecture --

architecture Behaviour of ExtSign_tb is 
signal E : std_logic_vector(7 downto 0);
signal S : std_logic_vector(31 downto 0);
begin

test_bench : entity work.ExtSign(Behaviour)
	generic map(E'length)
	port map(E, S);
	
	process 
		begin
			E <= "10001100";
			wait for 20 ns;
			E <= "01101100";
			wait for 20 ns;
	end process;
end architecture;