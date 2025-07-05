library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity butterfly2_tb is
end entity;

architecture tb of butterfly2_tb is

    constant N : positive := 8;

    signal in_0, in_1 : signed(N-1 downto 0);
    signal out_0, out_1 : signed(N downto 0);

begin

    uut: entity work.butterfly2
        generic map (
            N => N
        )
        port map (
            in_0 => in_0,
            in_1 => in_1,
            out_0 => out_0,
            out_1 => out_1
        );

    stim_proc: process
        variable expected_sum  : signed(N downto 0);
        variable expected_diff : signed(N downto 0);
    begin
        -- Teste 1: 10 + 5
        in_0 <= to_signed(10, N);
        in_1 <= to_signed(5, N);
        expected_sum  := to_signed(10, N+1) + to_signed(5, N+1);
        expected_diff := to_signed(10, N+1) - to_signed(5, N+1);
        wait for 10 ns;

        assert out_0 = expected_sum
            report "Erro na soma (10 + 5)"
            severity error;
        assert out_1 = expected_diff
            report "Erro na subtração (10 - 5)"
            severity error;

        -- Teste 2: -8 + 3
        in_0 <= to_signed(-8, N);
        in_1 <= to_signed(3, N);
        expected_sum  := to_signed(-8, N+1) + to_signed(3, N+1);
        expected_diff := to_signed(-8, N+1) - to_signed(3, N+1);
        wait for 10 ns;

        assert out_0 = expected_sum
            report "Erro na soma (-8 + 3)"
            severity error;
        assert out_1 = expected_diff
            report "Erro na subtração (-8 - 3)"
            severity error;

        -- Teste 3: overflow controlado (127 + 1) para N=8
        in_0 <= to_signed(127, N);  -- máximo de 8 bits
        in_1 <= to_signed(1, N);
        expected_sum  := to_signed(127, N+1) + to_signed(1, N+1);  -- 128
        expected_diff := to_signed(127, N+1) - to_signed(1, N+1);  -- 126
        wait for 10 ns;

        assert out_0 = expected_sum
            report "Erro na soma (127 + 1)"
            severity error;
        assert out_1 = expected_diff
            report "Erro na subtração (127 - 1)"
            severity error;

        -- Teste 4: caso simétrico -3 + (-3)
        in_0 <= to_signed(-3, N);
        in_1 <= to_signed(-3, N);
        expected_sum  := to_signed(-3, N+1) + to_signed(-3, N+1); -- -6
        expected_diff := to_signed(-3, N+1) - to_signed(-3, N+1); -- 0
        wait for 10 ns;

        assert out_0 = expected_sum
            report "Erro na soma (-3 + -3)"
            severity error;
        assert out_1 = expected_diff
            report "Erro na subtração (-3 - -3)"
            severity error;

        -- Teste 5: zeros
        in_0 <= to_signed(0, N);
        in_1 <= to_signed(0, N);
        expected_sum  := to_signed(0, N+1);
        expected_diff := to_signed(0, N+1);
        wait for 10 ns;

        assert out_0 = expected_sum
            report "Erro na soma (0 + 0)"
            severity error;
        assert out_1 = expected_diff
            report "Erro na subtração (0 - 0)"
            severity error;

        wait; -- fim da simulação
    end process;

end architecture tb;
