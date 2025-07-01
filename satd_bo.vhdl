library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity satd_bo is
    generic (
        N : positive := 8
    );
    port (
        clk   : in std_logic;
        rst   : in std_logic;

        in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7 : in signed(N-1 downto 0);

        enable_inputs       : in std_logic;
        enable_tb           : in std_logic;
        change_tb_direction : in std_logic;

        satd_result : out unsigned(16 downto 0)
    );
end entity;

architecture structure of satd_bo is

    signal t1_out_0, t1_out_1, t1_out_2, t1_out_3, t1_out_4, t1_out_5, t1_out_6, t1_out_7 : signed(N+2 downto 0); -- saida da T1: N+3 bits

    signal tb_out_0, tb_out_1, tb_out_2, tb_out_3, tb_out_4, tb_out_5, tb_out_6, tb_out_7 : signed(N+2 downto 0); -- saida da transposta: N+3 bits
    
    signal t2_out_0, t2_out_1, t2_out_2, t2_out_3, t2_out_4, t2_out_5, t2_out_6, t2_out_7 : signed(N+5 downto 0); -- saida da T2: N+6 bits

    signal abs_0, abs_1, abs_2, abs_3, abs_4, abs_5, abs_6, abs_7 : unsigned(N+5 downto 0); -- saida da abs_layer

    signal sum : unsigned(16 downto 0); -- soma total

begin

    T1: entity work.transform_1d_8inputs(arch)
        generic map (N => N)
        port map (
            in_0 => in_0, in_1 => in_1, in_2 => in_2, in_3 => in_3,
            in_4 => in_4, in_5 => in_5, in_6 => in_6, in_7 => in_7,
            out_0 => t1_out_0, out_1 => t1_out_1, out_2 => t1_out_2, out_3 => t1_out_3,
            out_4 => t1_out_4, out_5 => t1_out_5, out_6 => t1_out_6, out_7 => t1_out_7
        );

    TB: entity work.transpose_buffer_8x8(transposer)
        generic map (N => N+3)
        port map (
            clk => clk,
            rst => rst,
            enable => enable_tb,
            direction => change_tb_direction,
            in_0 => t1_out_0, in_1 => t1_out_1, in_2 => t1_out_2, in_3 => t1_out_3,
            in_4 => t1_out_4, in_5 => t1_out_5, in_6 => t1_out_6, in_7 => t1_out_7,
            out_0 => tb_out_0, out_1 => tb_out_1, out_2 => tb_out_2, out_3 => tb_out_3,
            out_4 => tb_out_4, out_5 => tb_out_5, out_6 => tb_out_6, out_7 => tb_out_7
        );

    T2: entity work.transform_1d_8inputs(arch)
        generic map (N => N+3)
        port map (
            in_0 => tb_out_0, in_1 => tb_out_1, in_2 => tb_out_2, in_3 => tb_out_3,
            in_4 => tb_out_4, in_5 => tb_out_5, in_6 => tb_out_6, in_7 => tb_out_7,
            out_0 => t2_out_0, out_1 => t2_out_1, out_2 => t2_out_2, out_3 => t2_out_3,
            out_4 => t2_out_4, out_5 => t2_out_5, out_6 => t2_out_6, out_7 => t2_out_7
        );

    ABS: entity work.abs_layer(comb)
        generic map (N => N+6)
        port map (
            in_0 => t2_out_0, in_1 => t2_out_1, in_2 => t2_out_2, in_3 => t2_out_3,
            in_4 => t2_out_4, in_5 => t2_out_5, in_6 => t2_out_6, in_7 => t2_out_7,
            out_0 => abs_0, out_1 => abs_1, out_2 => abs_2, out_3 => abs_3,
            out_4 => abs_4, out_5 => abs_5, out_6 => abs_6, out_7 => abs_7
        );

    sum <= abs_0 + abs_1 + abs_2 + abs_3 + abs_4 + abs_5 + abs_6 + abs_7;

    satd_result <= sum;

end architecture;