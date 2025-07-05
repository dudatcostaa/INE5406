library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity butterfly2 is
    generic (
        N : positive := 8 -- número de bits das entradas e da saída
    );
    port(
        in_0, in_1: in signed(N-1 downto 0);
        out_0, out_1: out signed(N downto 0)
    );
end entity butterfly2;

architecture arch of butterfly2 is
begin
    out_0 <= resize(in_0 + in_1, N+1);
    out_1 <= resize(in_0 - in_1, N+1);
end architecture arch;