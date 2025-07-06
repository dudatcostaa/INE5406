--------------------------------------------------
--	Author:          Ismael Seidel
--	Created:         Apr 5, 2025
--
--	Project:         Exercício 4 de INE5406
--	Description:     Contém descrições úteis para a manipulação de imagens
-- com o hardware de processamento simples de imagens que é o foco do 
-- exercício 4 de VHDL. 
--
--------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use ieee.math_real.all;

package image_operations is
    -- criação de um tipo para manter os nomes das operações.
    -- Fazer assim deixa o código mais legível. Só precisamos nos adaptar
    -- nas entradas e saídas de mais alta hierarquia, que é quando usamos 
    -- sempre std_logic_vector por compatibilidade.
    type operation_type is (
        PASSTHROUGH, -- operação que faz o dado de entrada passar diretamente para a saída 
        -- (i.e., não modifica o dado, não faz nada)
        THRESHOLD, -- operação de limiarização. Se o valor de entrada for acima da metade do 
        -- seu intervalo de representação, a saída será o valor máximo representável. Caso 
        -- contrário, a saída será 0.
        ADD_OFFSET, -- adiciona um valor de offset. A saída será o valor de entrada + o valor 
        -- de offset, desde que seja possível representar no intervalo de saída. Para evitar
        -- erros, deve ser feita uma operação de clipping, que garante que o valor ficará no
        -- intervalo esperado. 
        SUB_OFFSET  -- subtrai um valor de offset. A saída será o valor de entrada - o valor 
        -- de offset, desde que seja possível representar no intervalo de saída. Para evitar
        -- erros, deve ser feita uma operação de clipping, que garante que o valor ficará no
        -- intervalo esperado. 
    );

    -- Função para conversão de variáveis/sinais do tipo operation_type para std_logic_vector.
    function to_std_logic_vector(operation : operation_type) return std_logic_vector;

    -- Função para conversão de variáveis/sinais do tipo std_logic_Vector para operation_type.
    function to_operation_type(operation: std_logic_vector(1 downto 0)) return operation_type;

    -- Declaração do tipo parallel_samples_vector. 
    -- Note que é um array que não tem tamanho especificado de unsigned, que por sua vez também
    -- é um array sem tamanho especificado. Assim, na declaração de um parallel_samples_vector é
    -- necessário especificar duas dimensões, uma para o número de elementos unsigned em paralelo 
    -- e outra para o número de elementos em unsigned. Por exemplo:
    -- signal oito_de_dez_bits_em_paralelo : parallel_samples_vector(0 to 7)(9 downto 0);
    type parallel_samples_vector is array (natural range<>) of unsigned;

    -- Função para conversão de std_logic_vector para parallel_samples_vector.
    -- Essa função auxiliar divide um std_logic_vector de comprimento PxN em P amostras de N 
    -- bits. Cada amostra é representada como um unsigned (veja a definição do tipo 
    -- parallel_samples_vector).
    function to_parallel_samples(param : std_logic_vector; N: positive; P: positive) return parallel_samples_vector;

    -- Função para conversão de parallel_samples_vector para std_logic_vector.
	function to_std_logic_vector(param: parallel_samples_vector; N: positive; P: positive) 
		return std_logic_vector;
end image_operations;

package body image_operations is
    function to_std_logic_vector(operation : operation_type) return std_logic_vector is
        -- constant index : integer := operation_type'pos(operation);
        -- constant n_values : integer := operation_type'pos(operation_type'right) + 1;
    begin
        -- return std_logic_vector(to_unsigned(index, natural(ceil(log2(real(n_values))))));
        case operation is
            when PASSTHROUGH  => return "00";
            when THRESHOLD     => return "01";
            when ADD_OFFSET    => return "10";
            when SUB_OFFSET    => return "11";            
        end case;
    end function to_std_logic_vector;

    function to_operation_type(operation: std_logic_vector(1 downto 0)) return operation_type is
        -- constant operation_as_unsigned : unsigned(operation'range) := unsigned(operation);
    begin
        -- return operation_type'val(to_integer(operation_as_unsigned));
    	case operation is
    		when "00" => return PASSTHROUGH;
    		when "01" => return THRESHOLD;
    		when "10" => return ADD_OFFSET;
    		when "11" => return SUB_OFFSET;
    		when others => return PASSTHROUGH;
    	end case;
	end function to_operation_type;

    function to_parallel_samples(param : std_logic_vector; N: positive; P: positive)
		return parallel_samples_vector is
		variable return_vector : parallel_samples_vector(0 to P-1)(N-1 downto 0);
	begin
		for i in return_vector'range loop
			return_vector(i) := unsigned(param(N*(i+1)-1 downto N*i));
		end loop;		
		return return_vector;
	end function to_parallel_samples;

	function to_std_logic_vector(param: parallel_samples_vector; N: positive; P: positive) 
		return std_logic_vector is
		variable return_vector: std_logic_vector(N*P-1 downto 0);
	begin
		for i in 0 to P-1 loop
			return_vector(N*(i+1)-1 downto N*i) := std_logic_vector(param(i));
		end loop;
		return return_vector;
	end function to_std_logic_vector;
end image_operations;