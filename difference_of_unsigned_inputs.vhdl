library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY difference_of_unsigned_inputs IS -- declaração da entidade
    PORT (
        A: IN  UNSIGNED(7 DOWNTO 0);  -- Entrada A, valor sem sinal de 8 bits (0,...,255).
        B: IN  UNSIGNED(7 DOWNTO 0);  -- Entrada B, valor sem sinal de 8 bits (0,...,255).
        S: OUT SIGNED(8 DOWNTO 0) -- Saída S, valor com sinal em 9 bits representando A-B.
    );
END difference_of_unsigned_inputs;


-- Não alterar o nome da arquitetura!
ARCHITECTURE arch OF difference_of_unsigned_inputs IS
    -- Se precisar, podes adicionar declarações aqui (remova este comentário).
BEGIN
    s <= signed(resize(unsigned(A), 9) - (resize(unsigned(B),9)));
END arch;