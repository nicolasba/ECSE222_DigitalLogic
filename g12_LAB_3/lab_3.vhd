library ieee;
use ieee.std_logic_1164.all;
entity lab_3 is
port( clk, reset, enable : in std_logic;
	wr_reg : in std_logic; --wr_reg = '0' to write to R0, wr_reg = '1' to write to R1
	user_input : in std_logic_vector(7 downto 0);
	add_mode : in std_logic; -- add_mode = '1' to add, add_mode = '0' to substract
	data_out : out std_logic_vector(7 downto 0); -- sum or diff
	bit_out : out std_logic); -- cout or bout
end entity;
	  
architecture example of lab_3 is

--4 8-bit register memory
signal internal : std_logic_vector(31 downto 0);

--adder
component adder is
port (a, b: in std_logic_vector(7 downto 0);
	sum : out std_logic_vector(7 downto 0);
	cout : out std_logic);
end component;
	
--substractor
component substractor is
port (a, b: in std_logic_vector(7 downto 0);
	diff : out std_logic_vector(7 downto 0);
	bout : out std_logic);
end component;

--internal signal
signal sum, diff : std_logic_vector(7 downto 0);
signal cout, bout : std_logic;
begin
	add: adder port map(a=>internal(7 downto 0), b=>internal(15 downto 8), sum=>sum, cout=>cout);
	sub: substractor port map(a=>internal(7 downto 0), b=>internal(15 downto 8), diff=>diff, bout=>bout);

--control
	process(clk, reset, enable, wr_reg, add_mode)
	begin
		if reset = '0' then --reset data
			internal <= (others=>'0');
		
		elsif rising_edge(clk) then
			if enable = '0' then
				if wr_reg = '1' then --write to R1
					internal(15 downto 8)<= user_input;
				else --write to R0
					internal(7 downto 0)<= user_input;
				end if;
			end if;
		
			if add_mode='1' then --add R0 and R1
				internal(23 downto 16)<= sum;
				internal(24)<=cout;
				
				data_out<=sum;
				bit_out<=cout;
			else 						--substract R1 from R0
				internal(23 downto 16)<= diff;
				internal(24)<=bout;
				
				data_out<=diff;
				bit_out<=bout;
			end if;
		end if;
	end process;
end architecture;