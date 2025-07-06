library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registerNBits is
    generic(
        N : positive := 8 -- Genérico para parametrizar o registrador.
    );
    port(
        clk : in std_logic; -- Sinal do relógio.
        rst_a : in std_logic; -- Sinal de reset assíncrono (por isso o _a ali), ativo alto.
        enable : in std_logic; -- Sinal de carga, só quando for 1 o dado da entrada é carregado.
        input_values: in std_logic_vector(N-1 downto 0); -- Dado de entrada.
        output_values: out std_logic_vector(N-1 downto 0) -- Dado de saída.
    );
end entity registerNBits;

-- Descrição comportamental do registrador de N bits. 
architecture behavior of registerNBits is
begin
    register_process: process(clk, rst_a)
        -- variável para armazenar o estado do registrador. Note o uso do atributo 'range
        -- para manter o intervalo (range) da variável igual ao intervalo da entrada. 
        variable reg_value : std_logic_vector(input_values'range);
    begin
        if rst_a = '1' then -- Reset assíncrono ativo alto com prioridade
            -- Quando rst_a = 1, todos os bits do registrador são zerados.
            reg_value := ( others => '0' );
        elsif rising_edge(clk) then
            -- Quando ocorre uma borda de subida de relógio 
            if enable = '1' then
                --e o sinal de carga (enable) é igual a 1, 
                -- então o sinal de entrada (input_values) é armazenado. 
                reg_value := input_values;
            end if;
        end if;
        -- Faz com que o valor da saída output_values sempre seja o mesmo de reg_value.
        output_values <= reg_value;
    end process;

end architecture behavior;
