library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_2to1_tb is
end entity;

architecture tb of mux_2to1_tb is

    constant N : positive := 8;

    -- Entradas e saída
    signal sel         : std_logic := '0';
    signal in_0, in_1  : signed(N - 1 downto 0);
    signal y           : signed(N - 1 downto 0);

begin

    -- Instancia o MUX
    uut: entity work.mux_2to1
        generic map (N => N)
        port map (
            sel  => sel,
            in_0 => in_0,
            in_1 => in_1,
            y    => y
        );

    -- Processo de estímulo
    stim_proc: process
        variable expected : signed(N - 1 downto 0);
    begin
        -- Teste 1: sel = '0' → y = in_0
        in_0 <= to_signed(42, N);
        in_1 <= to_signed(99, N);
        sel  <= '0';
        expected := to_signed(42, N);
        wait for 10 ns;
        assert y = expected report "Erro: sel='0' não selecionou in_0 corretamente" severity error;

        -- Teste 2: sel = '1' → y = in_1
        sel <= '1';
        expected := to_signed(99, N);
        wait for 10 ns;
        assert y = expected report "Erro: sel='1' não selecionou in_1 corretamente" severity error;

        -- Teste 3: in_0 negativo, sel = '0'
        in_0 <= to_signed(-17, N);
        sel  <= '0';
        expected := to_signed(-17, N);
        wait for 10 ns;
        assert y = expected report "Erro: sel='0' com in_0 negativo" severity error;

        -- Teste 4: in_1 negativo, sel = '1'
        in_1 <= to_signed(-128, N);
        sel  <= '1';
        expected := to_signed(-128, N);
        wait for 10 ns;
        assert y = expected report "Erro: sel='1' com in_1 negativo" severity error;

        -- Teste 5: in_0 = in_1, qualquer sel deve funcionar
        in_0 <= to_signed(77, N);
        in_1 <= to_signed(77, N);

        sel  <= '0';
        wait for 5 ns;
        assert y = to_signed(77, N) report "Erro: in_0 = in_1, sel='0'" severity error;

        sel  <= '1';
        wait for 5 ns;
        assert y = to_signed(77, N) report "Erro: in_0 = in_1, sel='1'" severity error;

        wait; -- fim da simulação
    end process;

end architecture;
