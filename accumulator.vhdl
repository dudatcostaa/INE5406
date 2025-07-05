library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity accumulator is

    --max output size é 20
    --entrada size é 14
    generic(
        NEntrada: positive:= 14;
        NMaxSaida: positive:=20
    );

    port(
        clk : in std_logic;
        rst : in std_logic;
        enable : in std_logic;
        inputValues : in unsigned(NEntrada-1 downto 0);
        outputAcc: out unsigned(NMaxSaida-1 downto 0)
    );
end entity accumulator;

architecture accumulation of accumulator is

    signal acc_reg : unsigned(NMaxSaida-1 downto 0):= (others => '0');
    

begin
    accumulator_process: process(clk,rst) is 
        begin
            if rising_edge(clk) then
                if rst = '1' then
                    acc_reg <= (others => '0');
                elsif enable = '1' then
						  acc_reg <= acc_reg + resize(inputValues, NMaxSaida);
                end if;
            end if;
        end process;

        outputAcc <= acc_reg;

end architecture accumulation;

