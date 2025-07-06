--------------------------------------------------
--	Author:      Ismael Seidel (entity)
--	Created:     May 1, 2025
--
--	Project:     Exercício 6 de INE5406
--	Description: Contém a descrição da entidade sad (que é o top-level). Tal
--               Entidade calcula a Soma das Diferenças Absolutas (SAD) entre
--               duas matrizes (blocos) de amostras, chamadas de bloco original
--               e bloco candidato. Ambos os blocos estão armazenados em memórias 
--               externas: o bloco original está em uma memória chamada de Mem_A
--               e o bloco candidato está em uma memória chamada de Mem_B. As
--               memórias são lidas de maneira assíncrona, através de um sinal
--               de endereço (address) e um sinal que habilita a leitura (read_mem).
--               O valor lido de Mem_A fica disponível na entrada sample_ori, 
--               enquanto que o valor lido de Mem_B fica fisponível na entrada
--               sample_can. O número de bits de cada amostra é parametrizado
--               através do generic bits_per_sample, que tem valor padrão 8. Os
--               valores de cada amostra são números inteiros sem sinal. Além 
--               disso, o número total de amostras por bloco também é parametrizável
--               através do generic samples_per_block. Porém, neste exercício você
--               pode assumir que esse valor não será modificado e será sempre 64.
--               Com 64 amostras em um bloco, podemos assumir que nossa arquitetura
--               será capaz de calcular a SAD entre dois blocos com tamanho 8x8 (cada).
--               Outro parâmetro da entidade é parallel_samples, que define o número
--               de amostras que serão processadas em paralelo. Neste exercício
--               podemos assumir também que esse valor não será modificado, e o 
--               valor padrão será adotado (ou seja, apenas 1 amostra de cada 
--               bloco será lida da memória por vez). Ainda que não sejam obrigatórios,
--               os generics samples_per_block e parallel_samples devem ser mantidos
--               na descrição da entidade. 
--------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sad_pack.all;

entity sad is
	generic(
		bits_per_sample   : positive := 8; -- número de bits por amostra
		samples_per_block : positive := 64; -- número de amostras por bloco
		parallel_samples  : positive := 1 -- número de amostras de cada bloco lidas em paralelo
	);
	port(
		clk        : in  std_logic;     -- ck
		rst_a      : in  std_logic;     -- reset
		enable     : in  std_logic;     -- iniciar
		sample_ori : in  std_logic_vector(bits_per_sample * parallel_samples - 1 downto 0); -- Mem_A[end]
		sample_can : in  std_logic_vector(bits_per_sample * parallel_samples - 1 downto 0); -- Mem_B[end]
		read_mem   : out std_logic;     -- read
		address    : out std_logic_vector(address_length(
			samples_per_block => samples_per_block,
			parallel_samples  => parallel_samples
		) - 1 downto 0);                -- end
		sad_value  : out std_logic_vector(sad_length(
			bits_per_sample   => bits_per_sample,
			samples_per_block => samples_per_block
		) - 1 downto 0);                -- SAD
		done       : out std_logic      -- pronto
	);
end entity sad;

architecture structure of sad is

	signal menor_entradaBC, zi_bo, ci_bo, cpa_bo, cpb_bo, csad_reg_bo, zsoma_bo, csoma_bo : std_logic;

begin
	
sad_bc : entity work.sad_bc(behavior)
port map (
	clk => clk,
	rst_a => rst_a,
	iniciar => enable,
	menor => menor_entradaBC,
	pronto => done,
	read => read_mem,
	zi => zi_bo,
	ci => ci_bo,
	cpa => cpa_bo,
	cpb => cpb_bo,
	csad_reg => csad_reg_bo,
	zsoma => zsoma_bo,
	csoma => csoma_bo
);

sad_bo : entity work.sad_bo(structure)
generic map(
	CFG.bits_per_sample => bits_per_sample,
	CFG.samples_per_block => samples_per_block,
	CFG.parallel_samples => parallel_samples
)
port map(
	clk => clk,
	dadoA => unsigned(sample_ori),
	dadoB => unsigned(sample_can),
	zi => zi_bo,
	ci => ci_bo,
	cpa => cpa_bo,
	cpb => cpb_bo,
	csad_reg => csad_reg_bo,
	zsoma => zsoma_bo,
	csoma => csoma_bo,
	menor => menor_entradaBC,
	sad => sad_value,
	address => address
);

end architecture structure; 