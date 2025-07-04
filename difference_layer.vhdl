library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY difference_layer IS -- declaration of the diff_layer

    generic (
        N : positive -- número de bits das entradas e da saída
    );

    PORT ( 
        out_0,out_1,out_2,out_3,out_4,out_5,out_6,out_7 :out signed(N downto 0); -- all of the 8 outputs
        input01,input02,input11,input12,input21,input22,input31,input32, 
        input41,input42,input51,input52,input61,input62,input71,input72: unsigned(N-1 downto 0) -- all of the 16 inputs
    );
END difference_layer;



ARCHITECTURE arch OF difference_layer IS

    -- arch of the difference_layer, creating 8 instances of the difference
component difference_of_unsigned_inputs
	generic(N : positive);
	port(
		A : IN  UNSIGNED(N-1 DOWNTO 0);
		B : IN  UNSIGNED(N-1 DOWNTO 0);
		S : OUT SIGNED(N DOWNTO 0)
	);
end component difference_of_unsigned_inputs;

BEGIN
    difference_of_unsigned_inputs_0: component difference_of_unsigned_inputs generic map (N => N) port map( A => input01, B => input02, S => out_0);
    difference_of_unsigned_inputs_1: component difference_of_unsigned_inputs generic map (N => N) port map( A => input11, B => input12, S => out_1);
    difference_of_unsigned_inputs_2: component difference_of_unsigned_inputs generic map (N => N) port map( A => input21, B => input22, S => out_2);
    difference_of_unsigned_inputs_3: component difference_of_unsigned_inputs generic map (N => N) port map( A => input31, B => input32, S => out_3);
    difference_of_unsigned_inputs_4: component difference_of_unsigned_inputs generic map (N => N) port map( A => input41, B => input42, S => out_4);
    difference_of_unsigned_inputs_5: component difference_of_unsigned_inputs generic map (N => N) port map( A => input51, B => input52, S => out_5);
    difference_of_unsigned_inputs_6: component difference_of_unsigned_inputs generic map (N => N) port map( A => input61, B => input62, S => out_6);
    difference_of_unsigned_inputs_7: component difference_of_unsigned_inputs generic map (N => N) port map( A => input71, B => input72, S => out_7);

END arch;
