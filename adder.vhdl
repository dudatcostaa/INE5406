library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
    generic (
        N : positive := 8
    );
    port (
        in_0, in_1: in unsigned (N-1 downto 0);
        
        out_0 : out unsigned(N downto 0)
    );
end entity adder;

architecture sum of adder is
begin

    out_0 <= in_0 + in_1;

end architecture sum;