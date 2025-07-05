library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity satd_toplevel_tb is
end entity;

architecture behavior of satd_toplevel_tb is
    constant N : positive := 8;

    signal clk     : std_logic := '0';
    signal rst     : std_logic := '1';
    signal enable  : std_logic := '0';
    signal direction_transpose_buffer : std_logic := '0';

    signal input01, input02, input11, input12, input21, input22, input31, input32 : std_logic_vector(N-1 downto 0);
    signal input41, input42, input51, input52, input61, input62, input71, input72 : std_logic_vector(N-1 downto 0);

    signal done : std_logic;
    signal satd : std_logic_vector(N+11 downto 0);

begin
    uut: entity work.satd_toplevel
        generic map(N => N)
        port map(
            clk     => clk,
            rst     => rst,
            enable  => enable,
            direction_transpose_buffer => direction_transpose_buffer,

            input01 => input01, input02 => input02,
            input11 => input11, input12 => input12,
            input21 => input21, input22 => input22,
            input31 => input31, input32 => input32,
            input41 => input41, input42 => input42,
            input51 => input51, input52 => input52,
            input61 => input61, input62 => input62,
            input71 => input71, input72 => input72,

            done => done,
            satd => satd
        );

    -- Clock generation
    clk_process: process
    begin
        while true loop
            clk <= '0'; wait for 5 ns;
            clk <= '1'; wait for 5 ns;
        end loop;
    end process;

    -- Stimulus
    stimulus: process
    begin
        rst <= '1';
        wait for 20 ns;
        -- Teste 1: Inputs iguais, resultado da satd deve ser 0
        rst <= '0';

        input01 <= x"10"; input02 <= x"10";
        input11 <= x"10"; input12 <= x"10";
        input21 <= x"10"; input22 <= x"10";
        input31 <= x"10"; input32 <= x"10";
        input41 <= x"10"; input42 <= x"10";
        input51 <= x"10"; input52 <= x"10";
        input61 <= x"10"; input62 <= x"10";
        input71 <= x"10"; input72 <= x"10";

        wait for 10 ns;
        enable <= '1';

        wait until done = '1';
        assert to_integer(unsigned(satd)) = 0
            report "Error: valor incorreto"
            severity error;

        enable <= '0';
        -------------------------------------------------------

        -- Teste 2: Inputs diferentes, resultado da satd deve ser 58521
        rst <= '1';
        wait for 20 ns;
        rst <= '0';

        input01 <= x"05"; input02 <= x"17";
        input11 <= x"61"; input12 <= x"41";
        input21 <= x"2B"; input22 <= x"01";
        input31 <= x"00"; input32 <= x"09";
        input41 <= x"08"; input42 <= x"9F";
        input51 <= x"06"; input52 <= x"6F";
        input61 <= x"A9"; input62 <= x"FF";
        input71 <= x"C1"; input72 <= x"09";


        wait for 10 ns;
        enable <= '1';

        wait until done = '1';
        assert to_integer(unsigned(satd)) = 33056
            report "Error: valor incorreto"
            severity error;

        enable <= '0';
        -------------------------------------------------------

        wait;
    end process;
end architecture;
