library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity satd_bo is
    generic (
        N : positive := 8
    );
    port (
        clk                 : in std_logic;

        rst                 : in std_logic;
        rst_tb              : in std_logic;
        rst_psad            : in std_logic;
        rst_satd            : in std_logic;

        enable_inputs       : in std_logic;
        enable_tb           : in std_logic;
        enable_psatd        : in std_logic;
        enable_satd         : in std_logic;

        change_tb_direction : in std_logic;

        input01,input02,input11,input12,input21,input22,input31,input32, 
        input41,input42,input51,input52,input61,input62,input71,input72: in std_logic_vector(N-1 downto 0); -- all of the 16 inputs

        satd_result : out unsigned(N+11 downto 0)
    );
end entity;

architecture structure of satd_bo is
    signal u_input01,u_input02,u_input11,u_input12,u_input21,u_input22,u_input31,u_input32, 
        u_input41,u_input42,u_input51,u_input52,u_input61,u_input62,u_input71,u_input72: unsigned(N-1 downto 0); -- all of the 16 inputs
    signal in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7 : signed(N downto 0);
    signal t1_out_0, t1_out_1, t1_out_2, t1_out_3, t1_out_4, t1_out_5, t1_out_6, t1_out_7 : signed(N+2 downto 0); -- saida da T1: N+3 bits

    signal tb_out_0, tb_out_1, tb_out_2, tb_out_3, tb_out_4, tb_out_5, tb_out_6, tb_out_7 : signed(N+2 downto 0); -- saida da transposta: N+3 bits
    
    signal t2_out_0, t2_out_1, t2_out_2, t2_out_3, t2_out_4, t2_out_5, t2_out_6, t2_out_7 : signed(N+5 downto 0); -- saida da T2: N+6 bits

    signal abs_0, abs_1, abs_2, abs_3, abs_4, abs_5, abs_6, abs_7 : unsigned(N+5 downto 0); -- saida da abs_layer

    signal tree_sum : unsigned(N+8 downto 0); -- soma da arvore
    signal psatd_result : unsigned(N+11 downto 0);
begin
    IB: entity work.input_buffer_8pairs(rtl)
        generic map (
            N => N
        )
        port map (
            clk => clk,
            rst => rst,
            in_01 => input01, in_02 => input02, in_11 => input11, in_12 => input12,
            in_21 => input21, in_22 => input22, in_31 => input31, in_32 => input32,
            in_41 => input41, in_42 => input42, in_51 => input51, in_52 => input52,
            in_61 => input61, in_62 => input62, in_71 => input71, in_72 => input72,

            out_01 => u_input01, out_02 => u_input02, out_11 => u_input11, out_12 => u_input12,
            out_21 => u_input21, out_22 => u_input22, out_31 => u_input31, out_32 => u_input32,
            out_41 => u_input41, out_42 => u_input42, out_51 => u_input51, out_52 => u_input52,
            out_61 => u_input61, out_62 => u_input62, out_71 => u_input71, out_72 => u_input72
        );

    DL: entity work.difference_layer(arch)
        generic map(
        	N => N
        )
        port map (  
            input01 => u_input01 ,input02 => u_input02,input11 => u_input11,input12 => u_input12,input21 => u_input21,input22 => u_input22,input31 => u_input31 ,input32=> u_input32, 
            input41 => u_input41,input42 => u_input42,input51=> u_input51,input52 => u_input52,input61 => u_input61,input62 => u_input62,input71 => u_input71,input72 => u_input72,
            out_0 => in_0,out_1 => in_1,out_2 => in_2,out_3 => in_3,out_4 => in_4,out_5 => in_5,out_6 => in_6,out_7 => in_7);
                                                                   
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
            rst => rst_tb,
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

    ABSL: entity work.abs_layer(comb)
        generic map (N => N+6)
        port map (
            in_0 => t2_out_0, in_1 => t2_out_1, in_2 => t2_out_2, in_3 => t2_out_3,
            in_4 => t2_out_4, in_5 => t2_out_5, in_6 => t2_out_6, in_7 => t2_out_7,
            out_0 => abs_0, out_1 => abs_1, out_2 => abs_2, out_3 => abs_3,
            out_4 => abs_4, out_5 => abs_5, out_6 => abs_6, out_7 => abs_7
        );

    SUM: entity work.sum_tree_8inputs(sum)
        generic map (N => N+6)
        port map (
            in_0 => abs_0, in_1 => abs_1, in_2 => abs_2, in_3 => abs_3,
            in_4 => abs_4, in_5 => abs_5, in_6 => abs_6, in_7 => abs_7,
            out_0 => tree_sum
        );

    ACC: entity work.accumulator(accumulation)
        generic map (
            NEntrada => N + 9,
            NMaxSaida => N + 12
        )
        port map (
            clk => clk,
            rst => rst_psad,
            enable => enable_psatd,
            inputValues => tree_sum,
            outputAcc => psatd_result
        );

    SATD_P: process(clk)
    begin
        if rising_edge(clk) then
            if rst_satd = '1' then
                satd_result <= 0;
            elsif enable_satd = '1' then
                satd <= psatd_result;
            end if;
        end if;
    end process;

end architecture;
