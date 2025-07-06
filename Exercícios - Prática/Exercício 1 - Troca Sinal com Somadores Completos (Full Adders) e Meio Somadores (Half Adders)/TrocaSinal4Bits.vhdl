LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity TrocaSinal4Bits is
  port (b: in STD_LOGIC_VECTOR(3 DOWNTO 0);    -- Valor de entrada: b
  		  s: out STD_LOGIC_VECTOR(3 DOWNTO 0); -- Valor de saída:  -b
  		  overflow: out STD_LOGIC 
          -- A saída overflow sinaliza que a conversão não é válida. 
  ) ;
end entity ; -- TrocaSinal4Bits


-- Atenção: 
--    - Não alterar o nome da arquitetura!
--    - Não alterar a ordem das arquiteturas!

architecture usingFAs of TrocaSinal4Bits is
    SIGNAL c : STD_LOGIC_VECTOR (4 DOWNTO 1);
    SIGNAL b_inv: STD_LOGIC_VECTOR (3 DOWNTO 0);
BEGIN
    
    ----- Modifique o código desta arquitetura para que ela implemente
    -- corretamente a troca de sinal! 

    b_inv <= not b;  -- Válido apenas a partir de VHDL-2008

    FA0: ENTITY work.FullAdder(pratica) 
    PORT MAP (cin=>'1',  a=>'0', b=>b_inv(0), s=>s(0), cout=>c(1));

    FA1: ENTITY work.FullAdder(pratica) 
    PORT MAP (cin=>c(1),  a=>'0', b=>b_inv(1), s=>s(1), cout=>c(2));

    FA2: ENTITY work.FullAdder(pratica) 
    PORT MAP (cin=>c(2),  a=>'0', b=>b_inv(2), s=>s(2), cout=>c(3));

    FA3: ENTITY work.FullAdder(pratica) 
    PORT MAP (cin=>c(3),  a=>'0', b=>b_inv(3), s=>s(3), cout=>c(4));

    overflow <= c(3) XOR c(4);

end architecture ; -- arch

-- Completar a descrição abaixo sem usar full adder!
-- Atenção: 
--    - Não alterar o nome da arquitetura!
--    - Não alterar a ordem das arquiteturas!

architecture usingHAs of TrocaSinal4Bits is
    SIGNAL c : STD_LOGIC_VECTOR (4 DOWNTO 1);
    SIGNAL b_inv: STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL bha: STD_LOGIC_VECTOR (3 DOWNTO 0);
BEGIN

    b_inv <= not b;
    
    HA0: ENTITY work.HalfAdder(pratica)
    PORT MAP (a=>'1', b=>b_inv(0), s=>bha(0), cout=>c(1));
    
    HA1: ENTITY work.HalfAdder(pratica)
    PORT MAP (a=>c(1), b=>b_inv(1), s=>bha(1), cout=>c(2));
    
    HA2: ENTITY work.HalfAdder(pratica)
    PORT MAP (a=>c(2), b=>b_inv(2), s=>bha(2), cout=>c(3));
    
    HA3: ENTITY work.HalfAdder(pratica)
    PORT MAP (a=>c(3), b=>b_inv(3), s=>bha(3), cout=>c(4));
    
    s <= bha;
    overflow <= c(3) XOR c(4);

end architecture ; -- arch