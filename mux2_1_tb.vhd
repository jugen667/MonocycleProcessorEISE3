--- # Auteur : Julien GENTY # ---
--- # Test Bench Multiplexeur 2 vers 1 # ---

-- Librairies à utiliser --
library IEEE;
	use IEEE.std_logic_1164.ALL;
	use IEEE.numeric_std.ALL;
	use IEEE.std_logic_unsigned.all;
 

-- Declaration de l'entité du multiplexeur --
entity Mux2_1_tb is
end entity;

-- Declaration de l'architecture du multiplexeur --
architecture Behaviour of Mux2_1_tb is
	signal COM : std_logic;
	signal A : std_logic_vector(31 downto 0) := "00000111000000110000011100001010";
	signal B : std_logic_vector(31 downto 0) := "01110010101000001110000000000101";
	signal S : std_logic_vector(31 downto 0);
	
	begin
Test_Bench : entity work.Mux2_1(Behaviour)
	generic map(32)
	port map (A, B, COM, S);
		process
			begin
				COM <= '1';
				wait for 20 ns;
				COM <= '0';
				wait for 20 ns;
		end process;
end architecture;
	