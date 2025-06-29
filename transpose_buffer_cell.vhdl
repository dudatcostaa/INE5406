library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity transpose_buffer_cell is

    generic(
        N : positive:=8 --tamanho das entradas
    );

    port(
        clk : in std_logic;
        rst : in std_logic;
        enable: in std_logic;
        direction:in std_logic;
        value0:in signed(N-1 downto 0);
        value1:in signed(N-1 downto 0);
        chosenValue: out signed(N-1 downto 0)
        
    );
end entity transpose_buffer_cell;

architecture RTL of transpose_buffer_cell is
    signal mux_holder : signed(N-1 downto 0);
    

begin
    Mux_tb: ENTITY work.mux_2to1(behavior)
    GENERIC MAP(N => N)
    PORT MAP(sel => direction, in_0 => value0, in_1 => value1 , y => mux_holder );

    register_process : process(clk, rst) is
    begin
        --reset assíncrono
        if rst='1' then
            --valor escolhido é 0
            chosenValue <= (others => '0');
        
        elsif rising_edge(clk) then
            if enable='1' then
                --na subida da borda do  clock, se o enable estiver ativado, o valor escolhido é aquele escolhido pelo mux pelo sinal direction
                chosenValue <= mux_holder;
            end if;
        end if;
        
        
    end process register_process;
    
end architecture RTL;


