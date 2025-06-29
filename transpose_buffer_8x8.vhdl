library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity transpose_buffer_8x8 is

    generic (
        N : positive -- número de bits das entradas e da saída
    );

    port(
        clk : in std_logic;
        rst : in std_logic;
        enable    : in  std_logic;
        direction : in  std_logic;


        in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7: in signed(N-1 downto 0);

        out_0, out_1, out_2, out_3, out_4, out_5, out_6, out_7: out signed(N-1 downto 0)



    );
end entity transpose_buffer_8x8;


architecture transposer of transpose_buffer_8x8 is

    --sinais utilizados para fazer a transposta
    signal 
    out_of_0_0, out_of_0_1, out_of_0_2, out_of_0_3, out_of_0_4, out_of_0_5, out_of_0_6, out_of_0_7,
     out_of_1_0, out_of_1_1, out_of_1_2, out_of_1_3, out_of_1_4, out_of_1_5, out_of_1_6, out_of_1_7,
      out_of_2_0, out_of_2_1, out_of_2_2, out_of_2_3, out_of_2_4, out_of_2_5, out_of_2_6, out_of_2_7,
       out_of_3_0, out_of_3_1, out_of_3_2, out_of_3_3, out_of_3_4, out_of_3_5, out_of_3_6, out_of_3_7,
        out_of_4_0, out_of_4_1, out_of_4_2, out_of_4_3, out_of_4_4, out_of_4_5, out_of_4_6, out_of_4_7,
         out_of_5_0, out_of_5_1, out_of_5_2, out_of_5_3, out_of_5_4, out_of_5_5, out_of_5_6, out_of_5_7,
          out_of_6_0, out_of_6_1, out_of_6_2, out_of_6_3, out_of_6_4, out_of_6_5, out_of_6_6, out_of_6_7,
           out_of_7_0, out_of_7_1, out_of_7_2, out_of_7_3, out_of_7_4, out_of_7_5, out_of_7_6, out_of_7_7
 : signed(N-1 downto 0);
    

    
    component transpose_buffer_cell
        
        generic(N : positive := 8);
        port(
            clk         : in  std_logic;
            rst         : in  std_logic;
            enable      : in  std_logic;
            direction   : in  std_logic;
            value0      : in  signed(N-1 downto 0);
            value1      : in  signed(N-1 downto 0);
            chosenValue : out signed(N-1 downto 0)
        );
    end component transpose_buffer_cell;

    


begin

    --Linha 0
    tb_cell_0_0: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=> in_7,  value1=> in_0,        chosenValue=> out_of_0_0);
    tb_cell_0_1: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=> in_6,  value1=> out_of_0_0,  chosenValue=> out_of_0_1);
    tb_cell_0_2: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=> in_5,  value1=> out_of_0_1,  chosenValue=> out_of_0_2);
    tb_cell_0_3: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=> in_4,  value1=> out_of_0_2,  chosenValue=> out_of_0_3);
    tb_cell_0_4: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=> in_3,  value1=> out_of_0_3,  chosenValue=> out_of_0_4);
    tb_cell_0_5: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=> in_2,  value1=> out_of_0_4,  chosenValue=> out_of_0_5);
    tb_cell_0_6: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=> in_1,  value1=> out_of_0_5,  chosenValue=> out_of_0_6);
    tb_cell_0_7: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=> in_0,  value1=> out_of_0_6,  chosenValue=> out_of_0_7);

    --Linha 1
    tb_cell_1_0: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_0_0, value1=>in_1,        chosenValue=>out_of_1_0);
    tb_cell_1_1: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_0_1, value1=>out_of_1_0,  chosenValue=>out_of_1_1);
    tb_cell_1_2: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_0_2, value1=>out_of_1_1,  chosenValue=>out_of_1_2);
    tb_cell_1_3: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_0_3, value1=>out_of_1_2,  chosenValue=>out_of_1_3);
    tb_cell_1_4: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_0_4, value1=>out_of_1_3,  chosenValue=>out_of_1_4);
    tb_cell_1_5: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_0_5, value1=>out_of_1_4,  chosenValue=>out_of_1_5);
    tb_cell_1_6: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_0_6, value1=>out_of_1_5,  chosenValue=>out_of_1_6);
    tb_cell_1_7: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_0_7, value1=>out_of_1_6,  chosenValue=>out_of_1_7);

    --Linha 2
    tb_cell_2_0: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_1_0, value1=>in_2,        chosenValue=>out_of_2_0);
    tb_cell_2_1: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_1_1, value1=>out_of_2_0,  chosenValue=>out_of_2_1);
    tb_cell_2_2: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_1_2, value1=>out_of_2_1,  chosenValue=>out_of_2_2);
    tb_cell_2_3: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_1_3, value1=>out_of_2_2,  chosenValue=>out_of_2_3);
    tb_cell_2_4: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_1_4, value1=>out_of_2_3,  chosenValue=>out_of_2_4);
    tb_cell_2_5: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_1_5, value1=>out_of_2_4,  chosenValue=>out_of_2_5);
    tb_cell_2_6: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_1_6, value1=>out_of_2_5,  chosenValue=>out_of_2_6);
    tb_cell_2_7: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_1_7, value1=>out_of_2_6,  chosenValue=>out_of_2_7);

    --Linha 3
    tb_cell_3_0: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_2_0, value1=>in_3,        chosenValue=>out_of_3_0);
    tb_cell_3_1: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_2_1, value1=>out_of_3_0,  chosenValue=>out_of_3_1);
    tb_cell_3_2: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_2_2, value1=>out_of_3_1,  chosenValue=>out_of_3_2);
    tb_cell_3_3: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_2_3, value1=>out_of_3_2,  chosenValue=>out_of_3_3);
    tb_cell_3_4: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_2_4, value1=>out_of_3_3,  chosenValue=>out_of_3_4);
    tb_cell_3_5: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_2_5, value1=>out_of_3_4,  chosenValue=>out_of_3_5);
    tb_cell_3_6: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_2_6, value1=>out_of_3_5,  chosenValue=>out_of_3_6);
    tb_cell_3_7: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_2_7, value1=>out_of_3_6,  chosenValue=>out_of_3_7);

    --Linha 4
    tb_cell_4_0: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_3_0, value1=>in_4,        chosenValue=>out_of_4_0);
    tb_cell_4_1: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_3_1, value1=>out_of_4_0,  chosenValue=>out_of_4_1);
    tb_cell_4_2: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_3_2, value1=>out_of_4_1,  chosenValue=>out_of_4_2);
    tb_cell_4_3: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_3_3, value1=>out_of_4_2,  chosenValue=>out_of_4_3);
    tb_cell_4_4: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_3_4, value1=>out_of_4_3,  chosenValue=>out_of_4_4);
    tb_cell_4_5: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_3_5, value1=>out_of_4_4,  chosenValue=>out_of_4_5);
    tb_cell_4_6: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_3_6, value1=>out_of_4_5,  chosenValue=>out_of_4_6);
    tb_cell_4_7: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_3_7, value1=>out_of_4_6,  chosenValue=>out_of_4_7);

    --Linha 5
    tb_cell_5_0: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_4_0, value1=>in_5,        chosenValue=>out_of_5_0);
    tb_cell_5_1: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_4_1, value1=>out_of_5_0,  chosenValue=>out_of_5_1);
    tb_cell_5_2: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_4_2, value1=>out_of_5_1,  chosenValue=>out_of_5_2);
    tb_cell_5_3: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_4_3, value1=>out_of_5_2,  chosenValue=>out_of_5_3);
    tb_cell_5_4: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_4_4, value1=>out_of_5_3,  chosenValue=>out_of_5_4);
    tb_cell_5_5: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_4_5, value1=>out_of_5_4,  chosenValue=>out_of_5_5);
    tb_cell_5_6: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_4_6, value1=>out_of_5_5,  chosenValue=>out_of_5_6);
    tb_cell_5_7: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_4_7, value1=>out_of_5_6,  chosenValue=>out_of_5_7);

    --Linha 6
    tb_cell_6_0: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_5_0, value1=>in_6,        chosenValue=>out_of_6_0);
    tb_cell_6_1: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_5_1, value1=>out_of_6_0,  chosenValue=>out_of_6_1);
    tb_cell_6_2: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_5_2, value1=>out_of_6_1,  chosenValue=>out_of_6_2);
    tb_cell_6_3: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_5_3, value1=>out_of_6_2,  chosenValue=>out_of_6_3);
    tb_cell_6_4: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_5_4, value1=>out_of_6_3,  chosenValue=>out_of_6_4);
    tb_cell_6_5: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_5_5, value1=>out_of_6_4,  chosenValue=>out_of_6_5);
    tb_cell_6_6: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_5_6, value1=>out_of_6_5,  chosenValue=>out_of_6_6);
    tb_cell_6_7: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_5_7, value1=>out_of_6_6,  chosenValue=>out_of_6_7);

    --Linha 7
    tb_cell_7_0: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_6_0, value1=>in_7,        chosenValue=>out_of_7_0);
    tb_cell_7_1: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_6_1, value1=>out_of_7_0,  chosenValue=>out_of_7_1);
    tb_cell_7_2: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_6_2, value1=>out_of_7_1,  chosenValue=>out_of_7_2);
    tb_cell_7_3: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_6_3, value1=>out_of_7_2,  chosenValue=>out_of_7_3);
    tb_cell_7_4: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_6_4, value1=>out_of_7_3,  chosenValue=>out_of_7_4);
    tb_cell_7_5: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_6_5, value1=>out_of_7_4,  chosenValue=>out_of_7_5);
    tb_cell_7_6: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_6_6, value1=>out_of_7_5,  chosenValue=>out_of_7_6);
    tb_cell_7_7: component transpose_buffer_cell generic map (N => N) port map (clk=>clk, rst=>rst, enable=>enable, direction=>direction, value0=>out_of_6_7, value1=>out_of_7_6,  chosenValue=>out_of_7_7);

    --Resultado final
    out_0 <= out_of_7_7 when direction = '0' else out_of_0_7;
    out_1 <= out_of_7_6 when direction = '0' else out_of_1_7;
    out_2 <= out_of_7_5 when direction = '0' else out_of_2_7;
    out_3 <= out_of_7_4 when direction = '0' else out_of_3_7;
    out_4 <= out_of_7_3 when direction = '0' else out_of_4_7;
    out_5 <= out_of_7_2 when direction = '0' else out_of_5_7;
    out_6 <= out_of_7_1 when direction = '0' else out_of_6_7;
    out_7 <= out_of_7_0 when direction = '0' else out_of_7_7;

end architecture transposer;