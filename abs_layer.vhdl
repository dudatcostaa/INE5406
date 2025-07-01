library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity abs_layer is
    generic (
        N : positive := 14
    );
    port (
        in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7 : in  signed(N-1 downto 0);
        
        out_0, out_1, out_2, out_3, out_4, out_5, out_6, out_7 : out unsigned(N-1 downto 0)
    );
end entity abs_layer;

architecture comb of abs_layer is
begin

    process(in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7)
    begin
        -- entrada 0
        if in_0 < 0 then
            out_0 <= unsigned(-in_0);
        else
            out_0 <= unsigned(in_0);
        end if;

        -- entrada 1
        if in_1 < 0 then
            out_1 <= unsigned(-in_1);
        else
            out_1 <= unsigned(in_1);
        end if;

        -- entrada 2
        if in_2 < 0 then
            out_2 <= unsigned(-in_2);
        else
            out_2 <= unsigned(in_2);
        end if;

        -- entrada 3
        if in_3 < 0 then
            out_3 <= unsigned(-in_3);
        else
            out_3 <= unsigned(in_3);
        end if;

        -- entrada 4
        if in_4 < 0 then
            out_4 <= unsigned(-in_4);
        else
            out_4 <= unsigned(in_4);
        end if;

        -- entrada 5
        if in_5 < 0 then
            out_5 <= unsigned(-in_5);
        else
            out_5 <= unsigned(in_5);
        end if;

        -- entrada 6
        if in_6 < 0 then
            out_6 <= unsigned(-in_6);
        else
            out_6 <= unsigned(in_6);
        end if;

        -- entrada 7
        if in_7 < 0 then
            out_7 <= unsigned(-in_7);
        else
            out_7 <= unsigned(in_7);
        end if;

    end process;

end architecture comb;