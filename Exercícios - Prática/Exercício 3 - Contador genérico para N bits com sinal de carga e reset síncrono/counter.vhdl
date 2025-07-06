library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Não altere o nome da entidade e o nome das portas!
-- Porém, será necessário atualizar a entidade para que o código compile!
-- Você deverá criar o generic N e utilizar para definir o número de bits da porta count
ENTITY counter IS
	GENERIC (N: INTEGER := 4);
	-- e este deve ser do tipo POSITIVE.
	-- O valor padrão para N deve ser 4 (i.e., se não for definido N, será
	-- instânciado um counter com 4 bits).
	PORT (
		clock  : IN STD_LOGIC;
		reset  : IN STD_LOGIC;
		enable : IN STD_LOGIC;
		-- atualizar o range considerando o generic N
		count  : OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0)
	);
END counter;

-- Não alterar o nome da arquitetura!
ARCHITECTURE arch OF counter IS
	signal contador: UNSIGNED (N-1 DOWNTO 0);
BEGIN
    PROCESS(clock)
    BEGIN
        IF (rising_edge(clock) and (reset = '1')) THEN
            contador <= (OTHERS => '0');
        ELSIF (rising_edge(clock) and (reset = '0') and (enable = '1')) THEN
            contador <= contador + 1;
        END IF;
    END PROCESS;
    
    count <= STD_LOGIC_VECTOR(contador);
	-- preencher aqui (remova este comentário)
END arch;
