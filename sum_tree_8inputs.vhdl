library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sum_tree_8inputs is
    generic (
        N : positive := 14
    );
    port (
        in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7 : in unsigned(N-1 downto 0);
        
        out_0 : out unsigned(N+2 downto 0)
    );
end entity sum_tree_8inputs;

architecture sum of sum_tree_8inputs is
    signal sum_0, sum_1, sum_2, sum_3 : unsigned(N downto 0);
    signal sum_4, sum_5 : unsigned(N+1 downto 0);

    component adder is
        generic (
            N : positive := 8
        );
        port (
            in_0, in_1: in unsigned (N-1 downto 0);
            out_0 : out unsigned(N downto 0)
        );
    end component;
begin
    adder_0: component adder generic map (N) port map (in_0, in_1, sum_0);
    adder_1: component adder generic map (N) port map (in_2, in_3, sum_1);
    adder_2: component adder generic map (N) port map (in_4, in_5, sum_2);
    adder_3: component adder generic map (N) port map (in_6, in_7, sum_3);

    adder_4: component adder generic map (N+1) port map (sum_0, sum_1, sum_4);
    adder_5: component adder generic map (N+1) port map (sum_2, sum_3, sum_5);
    
    adder_6: component adder generic map (N+2) port map (sum_4, sum_5, out_0);
end architecture sum;