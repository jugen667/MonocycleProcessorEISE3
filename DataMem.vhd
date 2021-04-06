--- # Auteur : Julien GENTY # ---
--- # Memoire de données # ---

-- Librairies à utiliser --
library IEEE;
	use IEEE.std_logic_1164.ALL;
	use IEEE.numeric_std.ALL;
	use IEEE.std_logic_unsigned.all;
 

-- Declaration de l'entité de mémoires de données --
entity DataMem is
	port(
		clk, rst, WrEn : in std_logic;
		Addr : in std_logic_vector(5 downto 0);
		DataIn : in std_logic_vector(31 downto 0);
		DataOut : out std_logic_vector(31 downto 0)
	);
end entity;

-- Declaration de l'architecture --
architecture Behaviour of DataMem is 


-- Declaration Type Tableau Memoire
	type table is array(63 downto 0) of std_logic_vector(31 downto 0); -- 64 registres --

-- Fonction d'Initialisation de la mémoire
	function init_data return table is
		variable result : table;
		begin
			for i in 63 downto 0 loop
				--result(i) := X"00000001";   							-- pour instruction_memory.vhd
				--result(i) := std_logic_vector(to_unsigned(i, 32));	-- pour instruction_memory_2.vhd
				result(i) := (others=> '0');							-- pour instruction_memory_3.vhd
			end loop;
			-- pour instruction_memory_3.vhd
			result(32) := x"00000003";				
			result(33) := x"0000006B";
			result(34) := x"0000001B";
			result(35) := x"0000000C";
			result(36) := x"00000142";
			result(37) := x"0000009B";
			result(38) := x"0000003F";
		return result;
	end init_data;

-- Déclaration et Initialisation de la mémoire 64x32 bits
	signal Data : table:=init_data;

	begin
		DataOut <= Data(to_integer(unsigned(Addr)));
		process(clk, rst)
			begin	
				if rst = '1' then
					Data <= init_data;
				elsif rising_edge(clk) then
					if WrEn = '1' then
						Data(to_integer(unsigned(Addr))) <= DataIn;
					end if;
				end if;
		end process;
end architecture;

---------------- # Fin du fichier # ----------------	
