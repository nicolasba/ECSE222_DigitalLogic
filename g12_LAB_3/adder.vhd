library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
-- This example I have replaced bit with 
-- std_logic (functionally the same for this)
entity adder is
       port ( a,b : in std_logic_vector(7 downto 0);
       sum: out std_logic_vector(7 downto 0);
		 cout: out std_logic);
end adder;
architecture rtl of adder is
-- temp will be a bit_vector of size 2 with cout as last bit
-- first bit will be sum
signal temp : std_logic_vector(8 downto 0);
-- 
begin 
      temp<= ("0"&a) + b; -- Concatenate "0" to a and add b
		sum<= temp(7 downto 0); -- Sum is the first bit of temp
		cout<= temp(8); -- cout is last bit of temp
end rtl;