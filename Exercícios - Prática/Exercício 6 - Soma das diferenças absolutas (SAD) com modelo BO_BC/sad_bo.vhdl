--------------------------------------------------
--	Author:      Ismael Seidel (entidade)
--	Created:     May 1, 2025
--
--	Project:     Exercício 6 de INE5406
--	Description: Contém a descrição da entidade `sad_bo`, que representa o
--               bloco operativo (BO) do circuito para cálculo da soma das
--               diferenças absolutas (SAD - Sum of Absolute Differences).
--               Este bloco implementa o *datapath* principal do circuito e
--               realiza operações como subtração, valor absoluto e acumulação
--               dos valores calculados. Além disso, também será feito aqui o
--               calculo de endereçamento e do sinal de controle do laço de
--               execução (menor), que deve ser enviado ao bloco de controle (i.e.,
--               menor será um sinal de status gerado no BO).
--               A parametrização é feita por meio do tipo
--               `datapath_configuration_t` definido no pacote `sad_pack`.
--               Os parâmetros incluem:
--               - `bits_per_sample`: número de bits por amostra; (uso obrigatório)
--               - `samples_per_block`: número total de amostras por bloco; (uso 
--                  opcional, útil para definição do número de bits da sad e 
--                  endereço, conforme feito no top-level, i.e., no arquivo sad.vhdl)
--               - `parallel_samples`: número de amostras processadas em paralelo.
--                  (uso opcional)
--               A arquitetura estrutural instanciará os componentes necessários
--               à implementação completa do bloco operativo.
--------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sad_pack.all;

-- Bloco Operativo (BO) do circuito SAD.
-- Responsável pelo processamento aritmético dos dados de entrada, incluindo
-- subtração, cálculo de valor absoluto e soma acumulada.
-- Totalmente parametrizável por meio do tipo `datapath_configuration_t`.
entity sad_bo is
	generic(
		CFG : datapath_configuration_t := (
			bits_per_sample   => 8,  -- número de bits por amostra
			samples_per_block => 64, -- número total de amostras por bloco
			parallel_samples  => 1   -- paralelismo no processamento
		)
	);
	port(
		clk : in std_logic;
        dadoA : in unsigned((CFG.bits_per_sample - 1) downto 0);
        dadoB : in unsigned((CFG.bits_per_sample - 1) downto 0);
        zi : in std_logic;
        ci : in std_logic;
        cpA : in std_logic;
        cpB : in std_logic;
        zsoma : in std_logic;
        csoma : in std_logic;
        csad_reg : in std_logic;
        menor : out std_logic;
        sad : out std_logic_vector(((CFG.bits_per_sample - 1) + 6) downto 0);
        address: out std_logic_vector(5 downto 0)
	);
end entity;

architecture structure OF sad_bo is

    --signals endereco
    signal saidaMuxEndereco : std_logic_vector(6 downto 0);
    signal saidaRegIEndereco : unsigned (6 downto 0);
    signal saidaSumEndereco : unsigned (6 downto 0);
    signal saidaRegConcEndereco : unsigned (5 downto 0);
    --signals sad
    signal saidaRegA, saidaRegB, resultadoAbsDiff : unsigned((CFG.bits_per_sample - 1) downto 0);
    signal saidaRegSoma, concat14bits, saidaSub, SAD_UNSIGNED : unsigned(((CFG.bits_per_sample - 1) + 6) downto 0);
    signal saidaMux : std_logic_vector(((CFG.bits_per_sample - 1) + 6) downto 0);
    signal saidaSum : unsigned(((CFG.bits_per_sample - 1) + 7) downto 0);
    signal zero_vector : std_logic_vector(((CFG.bits_per_sample) + 5) downto 0) := (others => '0');
    signal signal_bits_per_sample : std_logic_vector ((CFG.bits_per_sample - 1) downto 0);

begin

    ------------------------------------endereco---------------------------------------------
    mux: entity work.mux_2to1(behavior)
    generic map(N => 7)
    port map(
        sel => zi,
        in_0 => std_logic_vector(saidaSumEndereco),
        in_1 => "0000000",
        y => saidaMuxEndereco
    );
    -----------------------------------------------------------------------------------------
    registador_i : entity work.unsigned_register(behavior)
    generic map(N => 7)
    port map(
        clk => clk,
        enable => ci,
        d => unsigned(saidaMuxEndereco),
        q => saidaRegIEndereco
    );
   
    menor <= not std_logic(saidaRegIEndereco(6));

    saidaRegConcEndereco <= saidaRegIEndereco(5 downto 0);
    address <= std_logic_vector(saidaRegConcEndereco);
    -----------------------------------------------------------------------------------------
    somador_endereco  : entity work.unsigned_adder(arch)
    generic map(N => 6)
    port map(
        input_a => saidaRegConcEndereco, input_b => "000001", sum => saidaSumEndereco
    );

    -----------------------------------------sad----------------------------------------------

    reg_a: entity work.unsigned_register(behavior)
    generic map(N => CFG.bits_per_sample)
    port map(
        clk => clk,
        enable => cpA,
        d => dadoA,
        q => saidaRegA
    );
    -----------------------------------------------------------------------------------------
    reg_b : entity work.unsigned_register(behavior)
    generic map(N => CFG.bits_per_sample)
    port map(
        clk => clk,
        enable => cpB,
        d => dadoB,
        q => saidaRegB
    );
    -----------------------------------------------------------------------------------------
    diferenca_absoluta : entity work.absolute_difference(structure)
    generic map(N => CFG.bits_per_sample)
    port map(
        input_a => unsigned(saidaRegA),
        input_b => unsigned(saidaRegB),
        abs_diff => resultadoAbsDiff
    );

    concat14bits <= "000000" & resultadoAbsDiff;
    -----------------------------------------------------------------------------------------
    sum_sad : entity work.unsigned_adder(arch)
    generic map(N => CFG.bits_per_sample + 6)
    port map(
    input_a => concat14bits,
    input_b => saidaRegSoma,
    sum => saidaSum
    );

    saidaSub <= saidaSum((CFG.bits_per_sample + 5) downto 0);
    -----------------------------------------------------------------------------------------
    mux_sad : entity work.mux_2to1(behavior)
    generic map(N => CFG.bits_per_sample + 6)
    port map(
        sel => zsoma, 
        in_0 => std_logic_vector(saidaSub),
        in_1 => zero_vector,
        y => saidaMux
    );
    -----------------------------------------------------------------------------------------
    registrador_soma : entity work.unsigned_register(behavior)
    generic map(N => CFG.bits_per_sample + 6)
    port map(
        clk => clk,
        enable => csoma,
        d => unsigned(saidaMux),
        q => saidaRegSoma
    );
    -----------------------------------------------------------------------------------------
    sad_registrador : entity work.unsigned_register(behavior)
    generic map(N => CFG.bits_per_sample + 6)
    port map(
        clk => clk,
        enable => csad_reg,
        d => saidaRegSoma,
        q => SAD_UNSIGNED
    );

    sad <= std_logic_vector(SAD_UNSIGNED);

end architecture structure;