library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity accumulator_tb is
end entity;

architecture tb of accumulator_tb is

    constant NEntrada  : positive := 8;
    constant NMaxSaida : positive := 20;

    signal clk        : std_logic := '0';
    signal rst        : std_logic := '0';
    signal enable     : std_logic := '0';
    signal inputValues: unsigned(NEntrada-1 downto 0) := (others => '0');
    signal outputAcc  : unsigned(NMaxSaida-1 downto 0);

    constant clk_period : time := 10 ns;

begin

    uut: entity work.accumulator
        generic map (
            NEntrada => NEntrada,
            NMaxSaida => NMaxSaida
        )
        port map (
            clk => clk,
            rst => rst,
            enable => enable,
            inputValues => inputValues,
            outputAcc => outputAcc
        );

    clk_process: process
    begin
        while now < 200 ns loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    stim_proc: process
        variable expected : unsigned(NMaxSaida-1 downto 0) := (others => '0');
    begin
        -- Reset inicial
        rst <= '1';
        wait for clk_period;
        rst <= '0';

        -- Teste 1: acumular 10 + 5 + 3
        enable <= '1';

        inputValues <= to_unsigned(10, NEntrada);
        expected := expected + to_unsigned(10, NMaxSaida);
        wait for clk_period;

        inputValues <= to_unsigned(5, NEntrada);
        expected := expected + to_unsigned(5, NMaxSaida);
        wait for clk_period;

        inputValues <= to_unsigned(3, NEntrada);
        expected := expected + to_unsigned(3, NMaxSaida);
        wait for clk_period;

        assert outputAcc = expected
            report "Erro: valor acumulado incorreto no teste 1. Esperado: " & integer'image(to_integer(expected))
            severity error;

        -- Teste 2: disable = 0, não deve acumular
        enable <= '0';
        inputValues <= to_unsigned(100, NEntrada); -- valor ignorado
        wait for clk_period;

        assert outputAcc = expected
            report "Erro: acumulador mudou mesmo com enable = 0"
            severity error;

        -- Teste 3: reset deve zerar
        rst <= '1';
        wait for clk_period;
        rst <= '0';

        assert outputAcc = to_unsigned(0, NMaxSaida)
            report "Erro: reset falhou"
            severity error;

        wait;
    end process;

end architecture tb;
