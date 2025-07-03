library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity satd_input_buffer is

     generic (
        N : positive := 8
    );

    port(
        clk : in std_logic;
        rst : in std_logic;
        enable: in std_logic;

        inp_0, inp_1, inp_2, inp_3, inp_4, inp_5, inp_6, inp_7, inp_8, inp_9, inp_10, inp_11, inp_12, inp_13, inp_14, inp_15 : in std_logic_vector(N-1 downto 0);

        out_0,out_1, out_2, out_3, out_4, out_5, out_6, out_7, out_8, out_9, out_10, out_11, out_12, out_13, out_14, out_15 : out std_logic_vector(N-1 downto 0)
    );
end entity satd_input_buffer;

architecture inputBuffering of satd_input_buffer is
    
begin

    processing_buffering : process (clk) is
    begin
        if rising_edge(clk) then
            if rst = '1' then
                out_0 <= (others => '0');
                out_1 <= (others => '0');
                out_2 <= (others => '0');
                out_3 <= (others => '0');
                out_4 <= (others => '0');
                out_5 <= (others => '0');
                out_6 <= (others => '0');
                out_7 <= (others => '0');
                out_8 <= (others => '0');
                out_9 <= (others => '0');
                out_10 <= (others => '0');
                out_11 <= (others => '0');
                out_12 <= (others => '0');
                out_13 <= (others => '0');
                out_14 <= (others => '0');
                out_15 <= (others => '0');
                
            else if enable='1' then
                out_0 <= inp_0;
                out_1 <= inp_1;
                out_2 <= inp_2;
                out_3 <= inp_3;
                out_4 <= inp_4;
                out_5 <= inp_5;
                out_6 <= inp_6;
                out_7 <= inp_7;
                out_8 <= inp_8;
                out_9 <= inp_9;
                out_10 <= inp_10;
                out_11 <= inp_11;
                out_12 <= inp_12;
                out_13 <= inp_13;
                out_14 <= inp_14;
                out_15 <= inp_15;
            
            end if;
    
            end if;
        end if;
    end process processing_buffering;
end architecture inputBuffering;