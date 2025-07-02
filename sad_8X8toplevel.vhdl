library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sad_8X8toplevel is

        generic (
        N : positive -- número de bits das entradas e da saída
    );

    port(

        clk : in std_logic;
        rst : in std_logic;

        enable_inputs    : in  std_logic;
        direction_transpose_buffer : in  std_logic;

        in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7,in_8, in_9, in_10, in_11, in_12, in_13, in_14, in_15: in signed(N-1 downto 0);

        out_0, out_1, out_2, out_3, out_4, out_5, out_6, out_7: out signed(N-1 downto 0);

        done: out std_logic;
        satd : out signed(N+11 downto 0)
    );
end entity sad_8X8toplevel;

architecture RTL of entityName is
    
    
begin
    
end architecture RTL;

