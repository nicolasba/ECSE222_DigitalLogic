library ieee;
use ieee.std_logic_1164.all;
library work;
use work.all;

entity lab4_g12 is
port( clk, reset, tr1, tr2, operator : in std_logic;
out_1 : out std_logic_vector(8 downto 0);
in_1 :in std_logic_vector(7 downto 0);
operation : in std_logic_vector(1 downto 0));
end lab4_g12 ;



architecture lab4_g12 of lab4_g12 is
type state_type is (s0,s1,s2,s3);
signal state : state_type;
signal internal: std_logic_vector(31 downto 0);
signal sum, diff1, diff2: std_logic_vector(7 downto 0);
signal cout, bor1, bor2: std_logic;
	
	component adder is
	port(a,b : in std_logic_vector(7 downto 0);
	sum: out std_logic_vector(7 downto 0);
	cout: out std_logic);
	end component;
	
	component substractor is
	port(a,b : in std_logic_vector(7 downto 0);
	diff: out std_logic_vector(7 downto 0);
	bout: out std_logic);
	end component;

begin
adder_8: adder port map (internal(7 downto 0), internal(15 downto 8), sum, cout);
subtractor_8: substractor port map (internal(7 downto 0), internal(15 downto 8), diff1, bor1);
subtractor2_8: substractor port map (internal(15 downto 8), internal(7 downto 0), diff2, bor2);

	process(clk,reset)
	begin
			if reset = '0' then
			state <= s0; 

			elsif rising_edge(clk) then
			case state is --This is similar to high level language case statements
			
			--State transitions
			when s0 =>
			if tr1 = '0' then
			state <= s1;
			end if;
			
			when s1 =>
			if tr2 = '0' then
			state <= s2;
			end if;
			
			when s2 =>
			if operator = '0' then
			state <= s3;
			end if;
			
			--Go back to reset
			when s3 =>
			if operation = "11" then
			state <= s0;
			end if;
			end case;
			end if;
end process;

output_sys : process(state)
begin
	case state is
		--Since out_1 is mapped to the LEDs, everytime it's updated, the LED's will
		--show most current data
		
		--Reset output -> LEDs
		when s0 =>
		internal <= (others => '0');
		out_1 <= "000000000";

		when s1 =>
		internal(7 downto 0) <= in_1;
		out_1 <= '0' & in_1;	--LEDs will show 1st input

		when s2 =>
		internal(15 downto 8) <= in_1;
		out_1 <= '0' & in_1; --LEDs will show 2nd input

		--LEDs will show sum/diff and cout/bout
		when s3 =>
		if operation = "00" then
		internal(23 downto 16) <= sum; --Sum
		internal(24) <= cout;
		out_1 <= internal (24 downto 16);

		elsif operation = "01" then  -- 1st input - 2nd input
		internal(23 downto 16) <= diff1;
		internal(24) <= bor1;
		out_1 <= internal (24 downto 16);
		
		elsif operation = "10" then  -- 2nd input - 1st input
		internal(23 downto 16) <= diff2;
		internal(24) <= bor2;
		out_1 <= internal (24 downto 16);
		end if;
	end case;
end process;
end lab4_g12 ;
