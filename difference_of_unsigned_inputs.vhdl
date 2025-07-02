library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY difference_of_unsigned_inputs IS -- declaração da entidade

        generic (
        N : positive -- número de bits das entradas e da saída
    );
    PORT (
        A: IN  UNSIGNED(N-1 DOWNTO 0);  -- Entrada A, valor sem sinal de 8 bits (0,...,255).
        B: IN  UNSIGNED(N-1 DOWNTO 0);  -- Entrada B, valor sem sinal de 8 bits (0,...,255).
        S: OUT SIGNED(N DOWNTO 0) -- Saída S, valor com sinal em 9 bits representando A-B.
    );
END difference_of_unsigned_inputs;


ARCHITECTURE arch OF difference_of_unsigned_inputs IS
BEGIN
    s <= signed(resize(unsigned(A), N+1) - (resize(unsigned(B),N+1)));
END arch;
