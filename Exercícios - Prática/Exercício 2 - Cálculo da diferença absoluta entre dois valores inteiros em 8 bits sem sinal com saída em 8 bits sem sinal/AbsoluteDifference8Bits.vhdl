LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Não altere a definição da entidade!
-- Ou seja, não modifique o nome da entidade, nome das portas e tipos/tamanhos das portas!
ENTITY AbsoluteDifference8Bits IS -- declaração da entidade AbsoluteDifference8Bits
	PORT (
        A : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- Entrada A, valor sem sinal de 8 bits (0,...,255).
        B : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- Entrada B, valor sem sinal de 8 bits (0,...,255).
    	S : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)  -- Saída S,   valor sem sinal em 8 bits (0,...,255), representando |A-B|.
    );
END AbsoluteDifference8Bits;

-- Não alterar o nome da arquitetura!
ARCHITECTURE structure OF AbsoluteDifference8Bits IS
    signal diferenca: SIGNED (8 DOWNTO 0);
    signal resultado: UNSIGNED (7 DOWNTO 0);
    
BEGIN
    difference : ENTITY work.Difference8Bits(arch)
    PORT MAP (A => UNSIGNED(A) , B => UNSIGNED(B), S => diferenca); --o primeiro a é o a do Difference e o segundo é a entrada desse Absolute
                                                                   -- como aqui ele é std_logic_vector e no DIferrence ele é unsigned transformo
    
    absolute : ENTITY work.Absolute9Bits(arch)
    PORT MAP (value => diferenca, absoluteValue => resultado, overflow => open ); --open significa que eu nao vou usar
    
    S <= STD_LOGIC_VECTOR(resultado);

END structure;
