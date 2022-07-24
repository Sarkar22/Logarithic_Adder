LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE std.textio.all;
USE ieee.std_logic_textio.all;

ENTITY log_add_test IS
END ENTITY;

ARCHITECTURE log_add_test OF log_add_test IS

	SIGNAL a_t,b_t:  STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL cin_t:    STD_LOGIC;
	SIGNAL sum_t:    STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL cout_t:   STD_LOGIC;

BEGIN
 
	dut: entity work.log_add port map (a_t,b_t,cin_t,sum_t,cout_t);

PROCESS

	VARIABLE a_inp,b_inp: STD_LOGIC_VECTOR(31 DOWNTO 0);
	VARIABLE cinp:        STD_LOGIC;
	VARIABLE sum_gold:    STD_LOGIC_VECTOR(31 DOWNTO 0);
	VARIABLE cout_gold:   STD_LOGIC;

file finp:text;


	variable inline:line;

BEGIN

	file_open(finp,"log_add_testing_file.txt",read_mode);

	while( not endfile(finp)) loop

		readline (finp,inline);

		read(inline,a_inp);
		read(inline,b_inp);
		read(inline,cinp);
		read(inline,sum_gold);
		read(inline,cout_gold);

		deallocate(inline);

		a_t<=a_inp;
		b_t<=b_inp;
		cin_t<=cinp;

		wait for 10ns;

		assert((cout_t=cout_gold) or (sum_t=sum_gold)) report "Error in Addition" severity failure;

	end loop;

report "Addition completed succesfully" severity note;

file_close(finp);

WAIT;

END PROCESS;

END ARCHITECTURE;
