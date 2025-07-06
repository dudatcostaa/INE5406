library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- Em sua implementação, use as funções disponíveis na biblioteca numeric_std:
USE IEEE.NUMERIC_STD.ALL;
-- Perceba que ela já é usada na definição das entradas e saídas da arquitetura.

-- Não altere a definição da entidade!
-- Ou seja, não modifique o nome da entidade, nome das portas e tipos/tamanhos das portas!
ENTITY Difference8Bits IS -- declaração da entidade Difference8Bits
    PORT (
        A: IN  UNSIGNED(7 DOWNTO 0);  -- Entrada A, valor sem sinal de 8 bits (0,...,255).
        B: IN  UNSIGNED(7 DOWNTO 0);  -- Entrada B, valor sem sinal de 8 bits (0,...,255).
        S: OUT SIGNED(8 DOWNTO 0) -- Saída S, valor com sinal em 9 bits representando A-B.
    );
END Difference8Bits;


-- Não alterar o nome da arquitetura!
ARCHITECTURE arch OF Difference8Bits IS
    
BEGIN
    S <= SIGNED('0' & a) - SIGNED('0' & b);
END arch;