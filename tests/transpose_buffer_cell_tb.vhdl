library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity transpose_buffer_cell_tb is
end entity;

architecture tb of transpose_buffer_cell_tb is

    constant N : positive := 8;

    signal clk          : std_logic := '0';
    signal rst          : std_logic := '0';
    signal enable       : std_logic := '0';
    signal direction    : std_logic := '0';
    signal value0       : signed(N-1 downto 0);
    signal value1       : signed(N-1 downto 0);

    signal chosenValue  : signed(N-1 downto 0);

    constant clk_period : time := 10 ns;

begin

    uut: entity work.transpose_buffer_cell
        generic map (N => N)
        port map (
            clk => clk,
            rst => rst,
            enable => enable,
            direction => direction,
            value0 => value0,
            value1 => value1,
            chosenValue => chosenValue
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
        variable expected : signed(N-1 downto 0);
    begin
        wait for 5 ns; -- garantir borda do clock em 5ns

        -- Teste 1: reset deve zerar saída imediatamente (assíncrono)
        rst <= '1';
        wait for clk_period / 2; -- antes da borda
        assert chosenValue = to_signed(0, N) report "Erro: reset não zerou" severity error;

        rst <= '0';
        wait for clk_period; -- um ciclo completo

        -- Teste 2: direction = 0 → seleciona value0
        value0 <= to_signed(42, N);
        value1 <= to_signed(99, N);
        direction <= '0';
        enable <= '1';
        wait for clk_period;
        assert chosenValue = to_signed(42, N) report "Erro: direction=0 não selecionou value0" severity error;

        -- Teste 3: direction = 1 → seleciona value1
        direction <= '1';
        wait for clk_period;
        assert chosenValue = to_signed(99, N) report "Erro: direction=1 não selecionou value1" severity error;

        -- Teste 4: enable = 0 → valor não deve mudar
        enable <= '0';
        value0 <= to_signed(11, N);
        value1 <= to_signed(22, N);
        direction <= '0';
        wait for clk_period;
        assert chosenValue = to_signed(99, N) report "Erro: valor mudou mesmo com enable=0" severity error;

        -- Teste 5: novo valor com enable = 1, direction = 0
        enable <= '1';
        direction <= '0';
        wait for clk_period;
        assert chosenValue = to_signed(11, N) report "Erro: direction=0 com novo valor0" severity error;

        wait;

    end process;

end architecture;
