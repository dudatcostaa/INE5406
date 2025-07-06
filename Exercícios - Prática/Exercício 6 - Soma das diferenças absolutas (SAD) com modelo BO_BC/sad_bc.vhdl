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
use ieee.numeric_std.all;

-- Bloco de Controle (BC) do circuito SAD.
-- Responsável por gerar os sinais de controle para o bloco operativo (BO),
-- geralmente por meio de uma FSM.
entity sad_bc is
	port(
		clk   : in std_logic;  -- clock (sinal de relógio)
		rst_a : in std_logic;  -- reset assíncrono ativo em nível alto
		iniciar : in std_logic;
		
		pronto : out std_logic;
		read : out std_logic;
		zi : out std_logic;
		ci : out std_logic;
		zsoma : out std_logic;
		csoma : out std_logic;
		cpA : out std_logic;
		cpB : out std_logic;
		csad_reg : out std_logic;
		menor : in std_logic
	);
end entity;
-- Não altere o nome da entidade nem da arquitetura!

architecture behavior of sad_bc is
    type Estado is (s0, s1, s2, s3, s4, s5);
    signal ea, pe : Estado;
    
begin

    process1 : process (clk, rst_a)
    begin
        if rst_a = '1' then
            ea <= s0;
        elsif (rising_edge(clk)) then
            ea <= pe;
        end if;
    end process;
    
    process2 : process (ea, iniciar, menor)
    begin
        case ea is
            when s0 =>
                if iniciar = '0' then
                    pe <= s0;
                else
                    pe <= s1;
                end if;
            
            when s1 =>
                pe <= s2;
                
            when s2 =>
                if menor = '1' then
                    pe <= s3;
                else
                    pe <= s5;
                end if;
                    
            when s3 =>
                pe <= s4;
                
            when s4 =>
                pe <= s2;
                
            when s5 =>
                pe <= s0;
                
            when others =>
                pe <= s0;
        end case;
    end process;
    
    process3 : process (ea)
    begin
    --valores padrão
    pronto <= '0';
    read <= '0';
    zi <= '0';
    ci <= '0';
    zsoma <= '0';
    csoma <= '0';
    cpA <= '0';
    cpB <= '0';
    csad_reg <= '0';
    
    case ea is
        when s0 =>
            pronto <= '1';
        when s1 =>
            zi <= '1';
            ci <= '1';
            zsoma <= '1';
            csoma <= '1';
        when s3 =>
            read <= '1';
            cpA <= '1';
            cpB <= '1';
        when s4 =>
            ci <= '1';
            csoma <= '1';
        when s5 =>
            csad_reg <= '1';
        when others =>
            null;
    end case;
    end process;
end architecture;