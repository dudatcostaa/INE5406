library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity satd_bc is 
    port (
        -- entradas
        clock : in std_logic;
        reset : in std_logic; -- assíncrono
        enable : in std_logic;
        
        -- saídas
        enable_inputs : out std_logic;
        reset_tb : out std_logic;
        enable_tb: out std_logic;
        change_tb_direction: out std_logic;
        reset_psatd: out std_logic;
        enable_psatd : out std_logic;
        reset_satd : out std_logic;
        enable_satd : out std_logic;
        done : out std_logic
    );

    end entity;

architecture behavior of satd_bc is
    type Estado is (
        inicial,
        inicializar_0, inicializar_1, inicializar_2, inicializar_3, inicializar_4, inicializar_5, inicializar_6, inicializar_7,
        pre_calcular_0, pre_calcular_1,
        calcular_0, calcular_1, calcular_2, calcular_3, calcular_4, calcular_5, calcular_6, calcular_7,
        terminar_0,terminar_1, terminar_2, terminar_3, terminar_4, terminar_5, terminar_6, terminar_7,
        ultimo_0, ultimo_1,
        pre_terminar_0, pre_terminar_1
    );

    signal estadoatual, proximoestado : Estado;

begin

--carga e reset do registrador de estado
    Parte1 : process (clock, reset) 
        begin
        if reset = '1' then
            estadoatual <= inicial;
        elsif rising_edge(clock) then
            estadoatual <= proximoestado;
        end if;
    end process;

-- lógica de próximo estado
    Parte2: process(estadoatual, enable)
    begin
    case estadoatual is

        when inicial =>
            if enable = '1' then
                proximoestado <= inicializar_0;
            else
                proximoestado <= inicial;
            end if;

        when inicializar_0 =>
            proximoestado <= inicializar_1;
        when inicializar_1 =>
            proximoestado <= inicializar_2;
        when inicializar_2 =>
            proximoestado <= inicializar_3;
        when inicializar_3 =>
            proximoestado <= inicializar_4;
        when inicializar_4 =>
            proximoestado <= inicializar_5;
        when inicializar_5 =>
            proximoestado <= inicializar_6;
        when inicializar_6 =>
            proximoestado <= inicializar_7;
        
        when inicializar_7 =>
            if enable = '1' then
                proximoestado <= pre_calcular_0; -- se o enable está ativo, inicia o processo do cálculo
            else
                proximoestado <= pre_terminar_0; -- caso contrário, inicia a finalização, mesmo sem realizar o cálculo
            end if;

        when pre_calcular_0 =>
            proximoestado <= pre_calcular_1;
        when pre_calcular_1 =>
            proximoestado <= calcular_2;

        when calcular_0 =>
            proximoestado <= calcular_1;
        when calcular_1 =>
            proximoestado <= calcular_2;
        when calcular_2 =>
            proximoestado <= calcular_3;
        when calcular_3 =>
            proximoestado <= calcular_4;
        when calcular_4 =>
            proximoestado <= calcular_5;
        when calcular_5 =>
            proximoestado <= calcular_6;
        when calcular_6 =>
            proximoestado <= calcular_7;
        
        when calcular_7 =>
            if enable = '1' then
                proximoestado <= calcular_0; -- se o enable estiver ativo, repete o loop principal
            else
                proximoestado <= terminar_0; -- se não, começa o processo de finalização
            end if;

        when pre_terminar_0 =>
                proximoestado <= pre_terminar_1;
            when pre_terminar_1 =>
                proximoestado <= terminar_2;

        when terminar_0 =>
            proximoestado <= terminar_1;
        when terminar_1 =>
            proximoestado <= terminar_2;
        when terminar_2 =>
            proximoestado <= terminar_3;
        when terminar_3 =>
            proximoestado <= terminar_4;
        when terminar_4 =>
            proximoestado <= terminar_5;
        when terminar_5 =>
            proximoestado <= terminar_6;
        when terminar_6 =>
            proximoestado <= terminar_7;
        when terminar_7 =>
            proximoestado <= ultimo_0;

        when ultimo_0 =>
            proximoestado <= ultimo_1;
        when ultimo_1 =>
            proximoestado <= inicial;

    end case;
    end process;

    --lógica de saída
    Parte3 : process(estadoatual)
    begin
    case estadoatual is

        when inicial =>
            enable_inputs <= '0';
            enable_tb <= '0';
            change_tb_direction <= '0';
            reset_psatd <= '1';
            enable_psatd <= '0';
            reset_satd <= '1';
            enable_satd <= '0';
            reset_tb <= '1';
            done <= '0';
        
        when inicializar_0 => -- habilita os registradores de input
            enable_inputs <= '1';
            enable_tb <= '0';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '0';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';

        -- mantêm os mesmos valores até inicializar_7
        -- nesses estados os inputs são carregados e os registrados internos são gradualmente habilitados
        when inicializar_1 =>
            enable_inputs <= '1';
            enable_tb <= '1';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '0';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';

        when inicializar_2 =>
            enable_inputs <= '1';
            enable_tb <= '1';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '0';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';

        when inicializar_3 =>
            enable_inputs <= '1';
            enable_tb <= '1';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '0';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';

        when inicializar_4 =>
            enable_inputs <= '1';
            enable_tb <= '1';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '0';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';

        when inicializar_5 =>
            enable_inputs <= '1';
            enable_tb <= '1';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '0';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';

        when inicializar_6 =>
            enable_inputs <= '1';
            enable_tb <= '1';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '0';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';
        
        when inicializar_7 =>
            enable_inputs <= '1';
            enable_tb <= '1';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '0';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';

        -- os estados de pré-calcular mudam a direção do bloco TB e ativam psatd, respectivamente
        when pre_calcular_0 =>
            enable_inputs <= '1';
            enable_tb <= '1';
            change_tb_direction <= '1';
            reset_psatd <= '0';
            enable_psatd <= '0';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';

        when pre_calcular_1 =>
            enable_inputs <= '1';
            enable_tb <= '1';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '1';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';

        when calcular_0 => 
            enable_inputs <= '1';
            enable_tb <= '1';
            change_tb_direction <= '1';
            reset_psatd <= '1'; -- reinicia o PSATD
            enable_psatd <= '0';
            reset_satd <= '0';
            enable_satd <= '1'; -- ativa satd (onde o cálculo principal é feito)
            reset_tb <= '0';
            done <= '0';
        
        when calcular_1 =>
            enable_inputs <= '1';
            enable_tb <= '1';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '1';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '1'; -- sinaliza que o primeiro par de saídas está pronto
        
        -- mantêm os mesmos valores até calcular_7
        -- cada estado avança uma parte do cálculo
        when calcular_2 =>
            enable_inputs <= '1';
            enable_tb <= '1';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '1';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';

        when calcular_3 =>
            enable_inputs <= '1';
            enable_tb <= '1';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '1';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';

        when calcular_4 =>
            enable_inputs <= '1';
            enable_tb <= '1';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '1';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';
        
        when calcular_5 =>
            enable_inputs <= '1';
            enable_tb <= '1';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '1';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';

        when calcular_6 =>
            enable_inputs <= '1';
            enable_tb <= '1';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '1';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';

        when calcular_7 =>
            enable_inputs <= '1';
            enable_tb <= '1';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '1';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';

        -- os estados pré-terminar são um atalho de finalização
        -- eles garantem que a finalização seja feita de maneira correta mesmo se nenhum cálculo for feito
        when pre_terminar_0 =>
            enable_inputs <= '0';
            enable_tb <= '1';
            change_tb_direction <= '1';
            reset_psatd <= '0';
            enable_psatd <= '0';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';

        when pre_terminar_1 =>
            enable_inputs <= '0';
            enable_tb <= '1';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '1';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';

        when terminar_0 => 
            enable_inputs <= '0';
            enable_tb <= '1';
            change_tb_direction <= '1';
            reset_psatd <= '1'; -- reinicia a PSATD
            enable_psatd <= '0';
            reset_satd <= '0';
            enable_satd <= '1'; -- ativa a SATD para o último processamento
            reset_tb <= '0';
            done <= '0';

        when terminar_1 =>
            enable_inputs <= '0';
            enable_tb <= '1';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '1';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '1'; -- sinaliza a saída final de dados

        -- mantêm os mesmos valores até terminar_7
        -- finaliza a transmissão dos dados
        when terminar_2 =>
            enable_inputs <= '0';
            enable_tb <= '1';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '1';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';

        when terminar_3 =>
            enable_inputs <= '0';
            enable_tb <= '1';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '1';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';

        when terminar_4 =>
            enable_inputs <= '0';
            enable_tb <= '1';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '1';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';

        when terminar_5 =>
            enable_inputs <= '0';
            enable_tb <= '1';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '1';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';

        when terminar_6 =>
            enable_inputs <= '0';
            enable_tb <= '1';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '1';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';

        when terminar_7 =>
            enable_inputs <= '0';
            enable_tb <= '1';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '1';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '0';

        when ultimo_0 =>
            enable_inputs <= '0';
            enable_tb <= '0';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '0';
            reset_satd <= '0';
            enable_satd <= '1';
            reset_tb <= '0';
            done <= '0';

        when ultimo_1 =>
            enable_inputs <= '0';
            enable_tb <= '0';
            change_tb_direction <= '0';
            reset_psatd <= '0';
            enable_psatd <= '0';
            reset_satd <= '0';
            enable_satd <= '0';
            reset_tb <= '0';
            done <= '1'; -- sinaliza que está pronto

    end case;
    end process;

end architecture;
