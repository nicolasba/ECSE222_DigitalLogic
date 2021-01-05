-- 8-bit substractor
-- Student Name: Nicolas Barreyro
-- Student ID: 260730549
-- Student Name: Gorkem Yalcinoz
-- Student ID: 260710053
-- Student Name: Alexandra Zajda
-- Student ID: 260807517
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
-- This example I have replaced bit with 
-- std_logic (functionally the same for this)
entity substractor is
       port ( a,b : in std_logic_vector(7 downto 0);
       diff: out std_logic_vector(7 downto 0);
		 bout: out std_logic);
end substractor;
architecture rtl of substractor is
-- temp will be a bit_vector of size 9 with bout as leftmost bit
signal temp : std_logic_vector(8 downto 0);
-- 
begin 
      temp<= ("0"&a) - b; -- Concatenate "0" to a and substract b
		diff<= temp(7 downto 0); -- Diff 
		bout<= temp(8); -- Bout
end rtl;