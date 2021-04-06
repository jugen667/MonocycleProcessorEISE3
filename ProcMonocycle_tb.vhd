library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ProcMonocycle_tb is
end entity ProcMonocycle_tb;

architecture testbench of ProcMonocycle_tb is
    signal clk   : std_logic := '1';
	signal rst : std_logic;

	--constant Period : time := 1 ms;
	signal Done : boolean := false;
	
	

	begin


		clk <= '0' when Done else not(clk) after 5 us;
		Test_Bench : entity work.ProcMonocycle(Behaviour)
		port map(clk ,rst);

		process begin
			rst <= '1';

			wait for 10 us;

			rst <= '0';

			wait for 10000 us;
			
			Done <= true;
			wait;
		end process;

end architecture testbench;
