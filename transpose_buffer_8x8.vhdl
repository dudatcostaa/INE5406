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
        direction : in  std_logic
    );
end entity transpose_buffer_8x8;


architecture transposer of transpose_buffer_cell is
    
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
    


end architecture transposer;