LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY log_add IS

PORT

    (
     a,b:     IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
	  carryin: IN  STD_LOGIC;
	  sum:     OUT std_logic_vector(31 DOWNTO 0);
	  carryout:OUT STD_LOGIC
	  );
	  
END ENTITY;	


architecture archi of log_add is

SIGNAL g1,p1: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL g2,p2: STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL g3,p3: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL g4,p4: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL g5,p5: STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL g6,p6: STD_LOGIC;

SIGNAL carry:STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN 

             carry(0)<=carryin;

             carry(1)<= (a(0) and b(0)) or (b(0) and carry(0)) or (a(0) and carry(0));
             g1(0)<=carry(1);

first_order: FOR i IN 1 TO 31 GENERATE
					first_order_generate:entity work.andnew port map (a(i),b(i),g1(i));
					first_order_propagate:entity work.xor2 port map (a(i),b(i),p1(i)); 
				 END GENERATE;
				 
				 

              c2:entity work.aorbc port map (g1(1),p1(1),g1(0),carry(2));
              g2(0)<=carry(2);				 
				 
second_order: FOR i IN 1 TO 15 GENERATE
					second_order_generate:entity work.aorbc port map (g1(2*i+1),p1(2*i+1),g1(2*i),g2(i));
					second_order_propagate:entity work.andnew port map (p1(2*i+1),p1(2*i),p2(i));
	           END GENERATE;
				  
              c4:entity work.aorbc port map (g2(1),p2(1),g2(0),carry(4));
              g3(0)<=carry(4);				 
				 
third_order:  FOR i IN 1 TO 7 GENERATE
					third_order_generate:entity work.aorbc port map (g2(2*i+1),p2(2*i+1),g2(2*i),g3(i));
					third_order_propagate:entity work.andnew port map (p2(2*i+1),p2(2*i),p3(i));
	           END GENERATE;
				  

              c8:entity work.aorbc port map (g3(1),p3(1),g3(0),carry(8));
              g4(0)<=carry(8);				 
				 
fourth_order: FOR i IN 1 TO 3 GENERATE
              fourth_order_generate:entity work.aorbc port map (g3(2*i+1),p3(2*i+1),g3(2*i),g4(i));
	           fourth_order_propagate:entity work.andnew port map (p3(2*i+1),p3(2*i),p4(i));
	           END GENERATE;
				  
              
				  c16:entity work.aorbc port map (g4(1),p4(1),g4(0),carry(16));
              g5(0)<=carry(16);				 
				 
fifth_order:  FOR i IN 1 TO 1 GENERATE
              fifth_order_generate:entity work.aorbc port map (g4(2*i+1),p4(2*i+1),g4(2*i),g5(i));
	           fifth_order_propagate:entity work.andnew port map (p4(2*i+1),p4(2*i),p5(i));
	           END GENERATE;		
 
              s6g:entity work.aorbc port map (g5(1),p5(1),g5(0),g6);
				  s6p:entity work.andnew port map (p5(1),p5(0),p6);
				  

                  c3: entity work.aorbc port map (g1(2),p1(2),carry(2),carry(3));
	               c5: entity work.aorbc port map (g1(4),p1(4),carry(4),carry(5));
	               c6: entity work.aorbc port map (g2(3),p1(3),carry(4),carry(6));				  
				      c7: entity work.aorbc port map (g1(6),p1(6),carry(6),carry(7));
                  c9: entity work.aorbc port map (g1(8),p1(8),carry(8),carry(9));
	              c10: entity work.aorbc port map (g2(4),p2(4),carry(8),carry(10));
	              c11: entity work.aorbc port map (g1(10),p1(10),carry(10),carry(11));
				     c12: entity work.aorbc port map (g3(2),p3(2),carry(8),carry(12));
                 c13: entity work.aorbc port map (g1(12),p1(12),carry(12),carry(13));  
                 c14: entity work.aorbc port map (g2(6),p2(6),carry(12),carry(14));
					  c15: entity work.aorbc port map (g1(14),p1(14),carry(14),carry(15));
					  c17: entity work.aorbc port map (g1(16),p1(16),carry(16),carry(17));
					  c18: entity work.aorbc port map (g2(8),p2(8),carry(16),carry(18));
					  c19: entity work.aorbc port map (g1(18),p1(18),carry(18),carry(19));
					  c20: entity work.aorbc port map (g3(4),p3(4),carry(16),carry(20));
					  c21: entity work.aorbc port map (g1(20),p1(20),carry(20),carry(21));
					  c22: entity work.aorbc port map (g2(10),p2(10),carry(20),carry(22));
					  c23: entity work.aorbc port map (g1(22),p1(22),carry(22),carry(23));
					  c24: entity work.aorbc port map (g4(2),p4(2),carry(16),carry(24));
					  c25: entity work.aorbc port map (g1(24),p1(24),carry(24),carry(25));
					  c26: entity work.aorbc port map (g2(12),p2(12),carry(24),carry(26));
					  c27: entity work.aorbc port map (g1(26),p1(26),carry(26),carry(27));
					  c28: entity work.aorbc port map (g3(6),p3(6),carry(24),carry(28));
					  c29: entity work.aorbc port map (g1(28),p1(28),carry(28),carry(29));
					  c30: entity work.aorbc port map (g2(14),p2(14),carry(28),carry(30));
					  c31: entity work.aorbc port map (g1(30),p1(30),carry(30),carry(31));
					 
					 
                 carryout<=g6;

sum_generation:  FOR i IN 0 TO 31 GENERATE
						sum_generate: entity work.xor2 port map (p1(i),carry(i),sum(i));
                 END GENERATE;
					
END ARCHITECTURE;
					