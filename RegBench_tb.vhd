------------ # Auteur : Julien GENTY # ------------
-- # Test Bench d'un banc de registre en VHDL # --

-- Librairies à utiliser --
library IEEE;
	use IEEE.std_logic_1164.ALL;
	use IEEE.numeric_std.ALL;
	use IEEE.std_logic_unsigned.all;
	
-- Declaration d'une entité pour le test bench	
entity RegBench_tb is 
end RegBench_tb;

architecture Behaviour of RegBench_tb is
-- Declarationdes signaux internes
	signal clk : std_logic := '0';
	signal rst : std_logic; 
	signal WE : std_logic := '1';
	signal W, A, B : std_logic_vector(31 downto 0);
	signal Ra : std_logic_vector(3 downto 0) := "0100";
	signal Rb : std_logic_vector(3 downto 0) := "0010";
	signal Rw : std_logic_vector(3 downto 0);
	

	begin
Test_Bench : 	entity work.RegBench(Behaviour)
					port map(clk, rst, WE, W, Ra, Rb, Rw, A, B);
	
	clk <= not(clk) after 5 ns;
	process 
		begin 
			W <= "00000111000000110000011100001010";
			Rw <= "0010";
			wait for 20 ns;
			W <= "00000111001100110000011100001010";
			Rw <= "0100";
			wait for 20 ns;
			
	end process;
end architecture;