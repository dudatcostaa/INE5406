library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity abs_layer_tb is
end entity;

architecture tb of abs_layer_tb is

    constant N : positive := 14;

    -- Sinais de entrada
    signal in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7 : signed(N-1 downto 0);

    -- Sinais de saída
    signal out_0, out_1, out_2, out_3, out_4, out_5, out_6, out_7 : unsigned(N-1 downto 0);

    -- Tipo auxiliar para array de entradas/saídas
    type signed_array   is array (0 to 7) of signed(N-1 downto 0);
    type unsigned_array is array (0 to 7) of unsigned(N-1 downto 0);

begin

    -- Instancia o módulo a ser testado
    uut: entity work.abs_layer
        generic map (N => N)
        port map (
            in_0 => in_0, in_1 => in_1, in_2 => in_2, in_3 => in_3,
            in_4 => in_4, in_5 => in_5, in_6 => in_6, in_7 => in_7,
            out_0 => out_0, out_1 => out_1, out_2 => out_2, out_3 => out_3,
            out_4 => out_4, out_5 => out_5, out_6 => out_6, out_7 => out_7
        );

    -- Processo de estímulo
    stim_proc: process
        -- variáveis auxiliares para comparar resultado
        variable input_vals  : signed_array;
        variable expected_abs : unsigned_array;
    begin

        -- Teste 1: todos positivos
        input_vals := (to_signed(3, N), to_signed(12, N), to_signed(1, N), to_signed(9, N),
                       to_signed(4, N), to_signed(7, N), to_signed(15, N), to_signed(0, N));
        
        -- Atribui sinais
        in_0 <= input_vals(0); in_1 <= input_vals(1); in_2 <= input_vals(2); in_3 <= input_vals(3);
        in_4 <= input_vals(4); in_5 <= input_vals(5); in_6 <= input_vals(6); in_7 <= input_vals(7);
        wait for 10 ns;

        -- Verifica resultado
        for i in 0 to 7 loop
            expected_abs(i) := unsigned(abs(input_vals(i)));
        end loop;

        assert out_0 = expected_abs(0) report "Erro em out_0 (teste 1)" severity error;
        assert out_1 = expected_abs(1) report "Erro em out_1 (teste 1)" severity error;
        assert out_2 = expected_abs(2) report "Erro em out_2 (teste 1)" severity error;
        assert out_3 = expected_abs(3) report "Erro em out_3 (teste 1)" severity error;
        assert out_4 = expected_abs(4) report "Erro em out_4 (teste 1)" severity error;
        assert out_5 = expected_abs(5) report "Erro em out_5 (teste 1)" severity error;
        assert out_6 = expected_abs(6) report "Erro em out_6 (teste 1)" severity error;
        assert out_7 = expected_abs(7) report "Erro em out_7 (teste 1)" severity error;

        -- Teste 2: valores negativos
        input_vals := (to_signed(-5, N), to_signed(-1, N), to_signed(-128, N), to_signed(-42, N),
                       to_signed(-7, N), to_signed(-3, N), to_signed(-15, N), to_signed(-2, N));
        
        in_0 <= input_vals(0); in_1 <= input_vals(1); in_2 <= input_vals(2); in_3 <= input_vals(3);
        in_4 <= input_vals(4); in_5 <= input_vals(5); in_6 <= input_vals(6); in_7 <= input_vals(7);
        wait for 10 ns;

        for i in 0 to 7 loop
            expected_abs(i) := unsigned(abs(input_vals(i)));
        end loop;

        assert out_0 = expected_abs(0) report "Erro em out_0 (teste 2)" severity error;
        assert out_1 = expected_abs(1) report "Erro em out_1 (teste 2)" severity error;
        assert out_2 = expected_abs(2) report "Erro em out_2 (teste 2)" severity error;
        assert out_3 = expected_abs(3) report "Erro em out_3 (teste 2)" severity error;
        assert out_4 = expected_abs(4) report "Erro em out_4 (teste 2)" severity error;
        assert out_5 = expected_abs(5) report "Erro em out_5 (teste 2)" severity error;
        assert out_6 = expected_abs(6) report "Erro em out_6 (teste 2)" severity error;
        assert out_7 = expected_abs(7) report "Erro em out_7 (teste 2)" severity error;

        -- Teste 3: valores mistos
        input_vals := (to_signed(-3, N), to_signed(7, N), to_signed(0, N), to_signed(-9, N),
                       to_signed(8, N), to_signed(-4, N), to_signed(5, N), to_signed(-1, N));
        
        in_0 <= input_vals(0); in_1 <= input_vals(1); in_2 <= input_vals(2); in_3 <= input_vals(3);
        in_4 <= input_vals(4); in_5 <= input_vals(5); in_6 <= input_vals(6); in_7 <= input_vals(7);
        wait for 10 ns;

        for i in 0 to 7 loop
            expected_abs(i) := unsigned(abs(input_vals(i)));
        end loop;

        assert out_0 = expected_abs(0) report "Erro em out_0 (teste 3)" severity error;
        assert out_1 = expected_abs(1) report "Erro em out_1 (teste 3)" severity error;
        assert out_2 = expected_abs(2) report "Erro em out_2 (teste 3)" severity error;
        assert out_3 = expected_abs(3) report "Erro em out_3 (teste 3)" severity error;
        assert out_4 = expected_abs(4) report "Erro em out_4 (teste 3)" severity error;
        assert out_5 = expected_abs(5) report "Erro em out_5 (teste 3)" severity error;
        assert out_6 = expected_abs(6) report "Erro em out_6 (teste 3)" severity error;
        assert out_7 = expected_abs(7) report "Erro em out_7 (teste 3)" severity error;

        wait; -- Fim da simulação

    end process;

end architecture tb;
