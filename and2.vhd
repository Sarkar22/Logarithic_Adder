LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY andnew IS
PORT( a,b:IN STD_LOGIC; c:OUT STD_logic);
END ENTITY;

ARCHITECTURE andnew OF andnew IS
BEGIN
c<= a and b after 100ps;
END ARCHITECTURE;
