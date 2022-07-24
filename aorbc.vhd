LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY aorbc is
PORT( a,b,c:	IN   STD_LOGIC;
		    d:	OUT  STD_LOGIC);
END ENTITY;


ARCHITECTURE archi OF aorbc IS
BEGIN
	d<= a or (b and c) after 100ps;
END ARCHITECTURE; 