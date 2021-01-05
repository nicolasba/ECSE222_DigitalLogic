-- ECSE 221-222 Lab #1 
-- g12_1_bit_Adder_Subtractor
-- Student Name: Alexandra Zajda
-- Student ID: 260807517
-- Student Name: Nicholas Barreyro
-- Student ID: 260730549
-- Sudent Name Gorkem Yalcinoz
-- Student ID: 260710053 
-- GROUP 12
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 


entity gUU_lab1 is
	port ( a,b : in std_logic ; -- a, b are inputs used in both add/sub
			 carry_in, borrow_in : in std_logic ;
			 sum, carry_out, difference, borrow : out std_logic );
end gUU_lab1;


architecture simple of gUU_lab1 is
	signal int_1, int_2, int_3, int_4, sub1, sub2, sub3 : std_logic; -- internal signals	
	begin 	

-- 1 bit-adder	circuit
		int_1 <= ((NOT a) AND b AND carry_in); --AND GATE 1
		int_2 <= (a AND b AND (NOT carry_in)); --AND GATE 2
		int_3 <= (a AND b AND carry_in);       --AND GATE 3
		int_4 <= (a and (NOT b) AND carry_in); --AND GATE 4
	
		sum <= a XOR b XOR carry_in;           			 --XOR GATE
		carry_out <= (int_1 OR int_2 OR int_3 OR int_4); --OR GATE

-- 1 bit-subber circuit
		sub1 <= ((NOT a) AND borrow_in); --AND GATE 1
		sub2 <= ((NOT a) AND b);         --AND GATE 2
		sub3 <= (b AND borrow_in);			--AND GATE 3
		
		difference <= a XOR b XOR borrow_in; --XOR GATE
		borrow <= sub1 OR sub2 OR sub3;      --OR GATE
		
	end simple;
	
	

