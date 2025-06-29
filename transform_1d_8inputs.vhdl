library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity transform_1d_8inputs is
    generic (
        N : positive -- número de bits das entradas e da saída
    );
    port(
        in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7: in signed(N-1 downto 0);
        out_0, out_1, out_2, out_3, out_4, out_5, out_6, out_7: out signed(N+2 downto 0)
    );
end entity transform_1d_8inputs;

architecture arch of transform_1d_8inputs is
    signal wire_0_0, wire_0_1, wire_0_2, wire_0_3, wire_0_4, wire_0_5, wire_0_6, wire_0_7: signed(N downto 0);
    signal wire_1_0, wire_1_1, wire_1_2, wire_1_3, wire_1_4, wire_1_5, wire_1_6, wire_1_7: signed(N+1 downto 0);

    component butterfly2
        generic(N : positive := 8);
        port(
            in_0, in_1: in signed(N-1 downto 0);
            out_0, out_1: out signed(N downto 0)
        );
    end component butterfly2;
begin
    -- layer 0 (first)
    butterfly2_0_0: component butterfly2 generic map (N => N) port map (in_0, in_1, wire_0_0, wire_0_1);
    butterfly2_0_1: component butterfly2 generic map (N => N) port map (in_2, in_3, wire_0_2, wire_0_3);
    butterfly2_0_2: component butterfly2 generic map (N => N) port map (in_4, in_5, wire_0_4, wire_0_5);
    butterfly2_0_3: component butterfly2 generic map (N => N) port map (in_6, in_7, wire_0_6, wire_0_7);

    -- layer 1
    butterfly2_1_0: component butterfly2 generic map (N => N+1) port map (wire_0_0, wire_0_1, wire_1_0, wire_1_1);
    butterfly2_1_1: component butterfly2 generic map (N => N+1) port map (wire_0_2, wire_0_3, wire_1_2, wire_1_3);
    butterfly2_1_2: component butterfly2 generic map (N => N+1) port map (wire_0_4, wire_0_5, wire_1_4, wire_1_5);
    butterfly2_1_3: component butterfly2 generic map (N => N+1) port map (wire_0_6, wire_0_7, wire_1_6, wire_1_7);

    -- layer 2 (last)
    butterfly2_2_0: component butterfly2 generic map (N => N+2) port map (wire_1_0, wire_1_1, out_0, out_1);
    butterfly2_2_1: component butterfly2 generic map (N => N+2) port map (wire_1_2, wire_1_3, out_2, out_3);
    butterfly2_2_2: component butterfly2 generic map (N => N+2) port map (wire_1_4, wire_1_5, out_4, out_5);
    butterfly2_2_3: component butterfly2 generic map (N => N+2) port map (wire_1_6, wire_1_7, out_6, out_7);
end architecture arch;