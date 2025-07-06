--------------------------------------------------
--	Author:      Ismael Seidel (entity)
--	Created:     May 1, 2025
--
--	Project:     Exercício 6 de INE5406
--	Description: Contém a descrição de uma entidade para o cálculo da
--               diferença absoluta entre dois valores de N bits sem sinal.
--               A saída também é um valor de N bits sem sinal. 
--------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Calcula a diferença absoluta entre dois valores, similar ao Exercício 2.
-- Note que agora nosso circuito será parametrizável para N bits e as entradas
-- e saídas são unsigned (no Exercício 2 eram std_logic_vector pois tratava-se do
-- top-level). 
-- A saída abs_diff deve ser o resultado de |input_a - input_b|, onde | | é a operação
-- de valor absoluto.
entity absolute_difference IS
	generic(
		N : positive := 8
	);
	port(
		input_a  : in  unsigned(N - 1 downto 0);
		input_b  : in  unsigned(N - 1 downto 0);
		abs_diff : out unsigned(N - 1 downto 0)
	);
end entity;
-- Não altere a definição da entidade!
-- Ou seja, não modifique o nome da entidade, nome das portas e tipos/tamanhos das portas!

-- Não alterar o nome da arquitetura!
architecture structure OF absolute_difference IS
    signal input_a_signed, input_b_signed, diferencaPositiva, diferencaNegativa : signed (N downto 0);
    signal seletor : std_logic;
    signal absoluto : std_logic_vector (N downto 0);
    
begin
    --converte as entradas para signed e as aumenta (para previnir overflow)
    input_a_signed <= signed('0' & input_a); 
    input_b_signed <= signed('0' & input_b);
    
    positivo : entity work.signed_subtractor(arch) -- faz A - B (caso o valor seja positivo)
    generic map (
        N => N + 1
    )
    port map (
        input_a =>  input_a_signed,
        input_b => input_b_signed,
        difference => diferencaPositiva
    );
    
    negativo : entity work.signed_subtractor(arch) -- faz B - A (caso o valor seja negativo)
    generic map (
        N => N + 1
    )
    port map (
        input_a =>  input_b_signed,
        input_b => input_a_signed,
        difference => diferencaNegativa
    );
    
    seletor <= '0' when diferencaPositiva(N) = '0' else -- se o bit de sinal for positivo, o seletor é 0
            '1';
    
    mux : entity work.mux_2to1(behavior) -- seleciona entre as duas saídas dependendo do bit de sinal
    generic map (
        N => N + 1
    )
    port map (
        sel => seletor,
        in_0 => std_logic_vector(diferencaPositiva),
        in_1 => std_logic_vector(diferencaNegativa),
        y => absoluto
    );
    
    abs_diff <= unsigned(absoluto(N-1 downto 0)); -- o valor selecionado é passado para a saída no valor e tamanho certo
 
end architecture structure;