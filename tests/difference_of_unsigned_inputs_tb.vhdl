library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity difference_of_unsigned_inputs_tb is
end entity;

architecture tb of difference_of_unsigned_inputs_tb is

    constant N : positive := 8;

    signal A, B : unsigned(N-1 downto 0);
    signal S    : signed(N downto 0);

begin
    uut: entity work.difference_of_unsigned_inputs
        generic map (N => N)
        port map (
            A => A,
            B => B,
            S => S
        );

    stim_proc: process
        variable expected : signed(N downto 0);
    begin
        -- Teste 1: A > B
        A <= to_unsigned(200, N);
        B <= to_unsigned(100, N);
        expected := to_signed(100, N+1);
        wait for 10 ns;
        assert S = expected report "Erro em A=200, B=100" severity error;

        -- Teste 2: A < B
        A <= to_unsigned(50, N);
        B <= to_unsigned(120, N);
        expected := to_signed(-70, N+1);
        wait for 10 ns;
        assert S = expected report "Erro em A=50, B=120" severity error;

        -- Teste 3: A = B
        A <= to_unsigned(77, N);
        B <= to_unsigned(77, N);
        expected := to_signed(0, N+1);
        wait for 10 ns;
        assert S = expected report "Erro em A=B=77" severity error;

        -- Teste 4: A = 0, B = 0
        A <= to_unsigned(0, N);
        B <= to_unsigned(0, N);
        expected := to_signed(0, N+1);
        wait for 10 ns;
        assert S = expected report "Erro em A=0, B=0" severity error;

        -- Teste 5: A = 0, B > 0
        A <= to_unsigned(0, N);
        B <= to_unsigned(25, N);
        expected := to_signed(-25, N+1);
        wait for 10 ns;
        assert S = expected report "Erro em A=0, B=25" severity error;

        -- Teste 6: A = 255, B = 0
        A <= to_unsigned(255, N);
        B <= to_unsigned(0, N);
        expected := to_signed(255, N+1);
        wait for 10 ns;
        assert S = expected report "Erro em A=255, B=0" severity error;

        wait; -- fim da simulação
    end process;

end architecture;
