--------------- # Auteur : Julien GENTY # ---------------
-- # Gestions des instructions # --

-- Librairies à utiliser --
library IEEE;
	use IEEE.std_logic_1164.ALL;
	use IEEE.numeric_std.ALL;
	use IEEE.std_logic_unsigned.all;
  

-- Declaration de l'entité
entity GestInstr is
	port(
		clk, rst, nPCSel : in std_logic;
		Offset : in std_logic_vector(23 downto 0);
		Instruction : out std_logic_vector(31 downto 0)
	);
end entity;

-- Declaration de l'architecture comportementale

architecture Behaviour of GestInstr is 

	signal A, B, PC, SignExtended : std_logic_vector(31 downto 0);
		
begin

ExtendedOffset : entity work.ExtSign(Behaviour)
					generic map(Offset'length)
					port map(Offset, SignExtended);
					
Instr : entity work.instruction_memory_3(RTL)
			port map(PC, Instruction);
		
		
	process(clk, rst)
		begin 
			if rst = '1' then
				PC <= (others => '0');
			elsif rising_edge(clk) then
				if nPCSel = '1' then
					PC <= PC + 1 + SignExtended;
				else
					PC <= PC + 1;
				end if;
			end if;
	end process;



end architecture;