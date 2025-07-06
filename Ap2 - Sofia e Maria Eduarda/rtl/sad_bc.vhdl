--------------------------------------------------
--	Author:      Ismael Seidel (entity)
--	Created:     May 1, 2025
--
--	Project:     Exercício 6 de INE5406
--	Description: Contém a descrição da entidade `sad_bc`, que representa o
--               bloco de controle (BC) do circuito para cálculo da soma das
--               diferenças absolutas (SAD - Sum of Absolute Differences).
--               Este bloco é responsável pela geração dos sinais de controle
--               necessários para coordenar o funcionamento do bloco operativo
--               (BO), como enable de registradores, seletores de multiplexadores,
--               sinais de início e término de processamento, etc.
--               A arquitetura é comportamental e deverá descrever uma máquina
--               de estados finitos (FSM) adequada ao controle do datapath.
--               Os sinais adicionais de controle devem ser definidos conforme
--               a necessidade do projeto. PS: já foram definidos nos slides
--               da aula 6T.
--------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-- Bloco de Controle (BC) do circuito SAD.
-- Responsável por gerar os sinais de controle para o bloco operativo (BO),
-- geralmente por meio de uma FSM.
entity sad_bc is
	port(
		clk   : in std_logic;  -- clock (sinal de relógio)
		rst_a : in std_logic;   -- reset assíncrono ativo em nível alto
		iniciar : in std_logic;
		menor : in std_logic; 
		
		pronto : out std_logic;
		read : out std_logic;
		zi : out std_logic; -- controle mux i
		ci : out std_logic; -- controle registrador i
		zsoma : out std_logic; -- controle mux soma
		csoma : out std_logic; -- controle reg soma
		cpA : out std_logic; -- controle reg pA
		cpB : out std_logic; -- controle reg pB
		csad_reg : out std_logic -- controle SAD_reg
	);
end entity;
-- Não altere o nome da entidade nem da arquitetura!

architecture behavior of sad_bc is
    type Estado is (S0, S1, S2, S3, S4, S5);
    signal estadoatual, proximoestado : Estado;
begin

    --carga e reset do registrador de estado
    Parte1 : process (clk, rst_a) 
    begin
    if rst_a = '1' then 
        estadoatual <= S0;
    elsif rising_edge(clk) then
        estadoatual <= proximoestado;
    end if;
    end process;
    
    
    --lógica de próximo estado
    Parte2 : process(estadoatual, iniciar, menor) -- o process tem estadoatual, iniciar e menor pois são essas as coisas que determinam qual vai ser o próximo estado 
    begin 
    case estadoatual is
        when S0 => 
            if iniciar = '0' then 
                proximoestado <= S0;
            else 
                proximoestado <= S1;
            end if;
            
        when S1 =>
            proximoestado <= S2;
            
        when S2 => 
            if menor = '1' then
                proximoestado <= S3;
            else 
                proximoestado <= S5;
            end if;
            
        when S3 =>
            proximoestado <= S4;
        
        when S4 => 
            proximoestado <= S2;
        
        when S5 => 
            proximoestado <= S0;
            
    end case;
    end process;
    
    --lógica de saída
    Parte3 : process (estadoatual) -- só tem estadoatual pois a saída só depende disso
    begin 
    case estadoatual is 
        when S0 => -- único estado em que pronto é igual a 1 
            pronto <= '1';
            read <= '0'; 
            zi <= '0';
            ci <= '0';
            zsoma <= '0';
            csoma <= '0';
            cpA <= '0';
            cpB <= '0';
            csad_reg <= '0'; 
       
        when S1 => 
            pronto <= '0';
            read <= '0'; 
            zi <= '1';
            ci <= '1';
            zsoma <= '1';
            csoma <= '1';
            cpA <= '0';
            cpB <= '0';
            csad_reg <= '0'; 
        
        when S2 =>
            pronto <= '0';
            read <= '0'; 
            zi <= '0';
            ci <= '0';
            zsoma <= '0';
            csoma <= '0';
            cpA <= '0';
            cpB <= '0';
            csad_reg <= '0'; 
        
        when S3 =>
            pronto <= '0';
            read <= '1'; 
            zi <= '0';
            ci <= '0';
            zsoma <= '0';
            csoma <= '0';
            cpA <= '1';
            cpB <= '1';
            csad_reg <= '0'; 
        
        when S4 =>
            pronto <= '0';
            read <= '0'; 
            zi <= '0';
            ci <= '1';
            zsoma <= '0';
            csoma <= '1';
            cpA <= '0';
            cpB <= '0';
            csad_reg <= '0'; 
        
        when S5 => -- único estado em que csad_reg é 1
            pronto <= '0';
            read <= '0'; 
            zi <= '0';
            ci <= '0';
            zsoma <= '0';
            csoma <= '0';
            cpA <= '0';
            cpB <= '0';
            csad_reg <= '1'; 
    end case;
    end process;

end architecture;
