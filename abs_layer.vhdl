library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity abs_layer is
    generic (
        N : positive := 15
    );
    port (
        in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7 : in  signed(N-1 downto 0);
        
        out_0, out_1, out_2, out_3, out_4, out_5, out_6, out_7 : out unsigned(N-2 downto 0) -- não precisamos mais do bit do sinal
    );
end entity abs_layer;

architecture comb of abs_layer is
begin
    out_0 <= unsigned(abs(in_0));
    out_1 <= unsigned(abs(in_1));
    out_2 <= unsigned(abs(in_2));
    out_3 <= unsigned(abs(in_3));
    out_4 <= unsigned(abs(in_4));
    out_5 <= unsigned(abs(in_5));
    out_6 <= unsigned(abs(in_6));
    out_7 <= unsigned(abs(in_7));
end architecture comb;