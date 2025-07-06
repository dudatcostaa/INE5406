-------------------------------------------------------------------------------
-- ATENÇÃO: NÃO modificar este arquivo!
--     Este arquivo está disponível para sua consulta, mas NÃO é necessário 
-- alterá-lo para a conclusão desta atividade prática. 
-- Sendo detectada alguma modificação neste arquivo, haverá desconto de 10% na
-- nota da atividade. 
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FullAdder IS
    PORT (cin, a, b : IN STD_LOGIC;
          s, cout : OUT STD_LOGIC);
END FullAdder ;

ARCHITECTURE pratica OF FullAdder IS
BEGIN
    s <= a XOR b XOR cin;
    cout <= (a AND b) OR (a AND cin) OR (b AND cin);
END pratica;

ARCHITECTURE teorica OF FullAdder IS
    SIGNAL a_xor_b: STD_LOGIC;
BEGIN
    a_xor_b <= a XOR b;
    s <= a_xor_b XOR cin;
    cout <= (a NAND b) NAND (cin NAND a_xor_b);
END teorica;

ARCHITECTURE comportamento OF FullAdder IS
BEGIN
    s <= '0';
    cout <= '0';
END comportamento;
