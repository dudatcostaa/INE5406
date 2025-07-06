-------------------------------------------------------------------------------
-- ATENÇÃO: NÃO modificar este arquivo!
--     Este arquivo está disponível para sua consulta, mas NÃO é necessário 
-- alterá-lo para a conclusão desta atividade prática. 
-- Sendo detectada alguma modificação neste arquivo, haverá desconto de 10% na
-- nota da atividade. 
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY HalfAdder IS -- Descrição da entidade Half Adder
    PORT (a, b : IN STD_LOGIC; -- Entradas 'a' e 'b', 1-bit (std_logic)
          s, cout : OUT STD_LOGIC); -- Saídas 's' e 'cout', 1-bit (std_logic)
END HalfAdder ;

--     Descrição da arquitetura de meio somador conforme vista inicialmente na 
-- parte prática da disciplina. É uma dentre as possibilidades de implementação
-- de um meio somador (Half Adder).
ARCHITECTURE pratica OF HalfAdder IS
BEGIN
    s <= a XOR b;
    cout <= a AND b;
END pratica;

--     Descrição da arquitetura de meio somador conforme vista na parte teórica
-- da disciplina, usando lógica CMOS (pensando na redução do número de 
-- transistores CMOS). É outra dentre as possibilidades de implementação de um
-- meio somador (Half Adder).
ARCHITECTURE teorica OF HalfAdder IS
BEGIN
    s <= a XOR b;
    cout <= NOT (a NAND b);
END teorica;