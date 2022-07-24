LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY xor2 is
PORT( a,b:	IN   STD_LOGIC;
		  c:	OUT  STD_LOGIC);
END ENTITY;


ARCHITECTURE archi OF xor2 IS
BEGIN
	c<= a xor b after 100ps;
END ARCHITECTURE; 

