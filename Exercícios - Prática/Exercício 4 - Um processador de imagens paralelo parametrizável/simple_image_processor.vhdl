library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.image_operations.all;

entity simpleImageProcessor is
	generic( -- Declaração dos parâmetros desta entidade.
		N : positive := 8; -- Número de bits por amostra.
		P : positive := 1  -- Número de amostras processadas em paralelo.
	);
	port (
		clock : in std_logic; -- Sinal de relógio.
		reset_a : in std_logic; -- Reset assíncrono.
		enable_operation: in std_logic; -- Sinal de carga da entrada operação.
		enable_samples: in std_logic; -- Sinal de carga da entrada de amostras.
		enable_offset: in std_logic; -- Sinal de carga da entrada de offset. 
		operation: in std_logic_vector(1 downto 0); -- Entrada da operação a ser efetuada.
		input_samples : in std_logic_vector(P*N-1 downto 0); -- Entrada de amostras. Pode conter P amostras de N bits.
		input_offset: in std_logic_vector(N-1 downto 0); -- Entrada do valor de offset. Terá apenas N bits. 
		output_samples: out std_logic_vector(P*N-1 downto 0) -- Saída de amostras. Deve conter P amostras de N bits.
	);
end simpleImageProcessor;

architecture arch of simpleImageProcessor is
	signal temp : std_logic_vector(input_samples'range);
	signal internal_samples, internal_result : parallel_samples_vector(0 to P-1)(N-1 downto 0);
	signal internal_offset : unsigned(input_offset'range);
	signal internal_operation : operation_type;	
begin
	-- Instanciação do registrador para manter o valor de offset.
	-- Nosso registrador armazena std_logic_vector, mas já aproveitamos o
	-- port map da saída (output_values) do registrador para fazer o cast
	-- de std_logic_vector para unsigned, que é o tipo do sinal internal_offset.
	REG_OFFSET: entity work.registerNBits(behavior)
		generic map(
			N => N
		)
		port map(
			clk           => clock,
			rst_a         => reset_a,
			enable        => enable_offset,
			input_values  => input_offset,
			unsigned(output_values) => internal_offset
		);

	-- Instanciação do registrador para manter a operação selecionada. 
	-- Note que internal_operation é do tipo operation_type, definido no 
	-- pacote image_operations, definido por sua vez no arquivo image_operations.vhdl.
	-- Por outro lado, nosso registrador armazena std_logic_vector. Assim, embora a
	-- entrada do registrador seja mapeada diretamente na entrada operation do top-level,
	-- a saída precisa ser convertida de std_logic_vector para operation_type.
	-- Para tal conversão utilizamos a função to_operation_type, também definida no
	-- pacote image_operations.
	REG_OPERATION: entity work.registerNBits(behavior)
		generic map(
			N => operation'length
		)
		port map(
			clk           => clock,
			rst_a         => reset_a,
			enable        => enable_operation,
			input_values  => operation,
			to_operation_type(output_values) => internal_operation
		);

	-- Instanciação do registradore para manter os PxN bits das amostras a serem processadas.
	-- Embora as P amostras estejam juntas, podemos assumir a semântica de que a cada N bits 
	-- temos uma amostra única. 
	REG_INPUTS: entity work.registerNBits(behavior)
		generic map(
			N => P*N
		)
		port map(
			clk           => clock,
			rst_a         => reset_a,
			enable        => enable_samples,
			input_values  => input_samples,
			output_values => temp
		);
		
		internal_samples <= to_parallel_samples(temp, N, P);
		
		lilica: for i in 0 to P - 1 generate
		
		    PE: entity work.processingElement(mixed)
		    
		    generic map(
		    N => N
		    )
		    
		    port map(
		    operation => internal_operation,
		    offset => resize(internal_offset, N),
		    sample => resize(unsigned(internal_samples(i)), N),
		    result => internal_result(i)
		    );
		    
	    end generate lilica;
	    
	    output_samples <= to_std_logic_vector (internal_result, N, P);
		
	
	-- Sua tarefa aqui é implementar a geração paramétrica de P elementos de processamento
	-- i.e., P ProcessingElements. Para isso, será necessário utilizar o for generate.
	-- Ainda, será necessário fazer o correto mapeamento dos bits de entrada e saída do
	-- top-level (a entidade presente neste arquivo), que tem PxN bits, nas entradas e saídas
	-- de N bits dos ProcessingElements.
	--
	-- Dicas: explore os arquivos disponíveis para ver se há algo útil que possa ser utilizado.
	-- Note os sinais declarados na arquitetura. Talvez algum deles possa ser útil e facilitar
	-- a implementação do generate. 
	-- Além disso, garanta que as demais partes estejam funcionando corretamente (ou seja, 
	-- primeiro corrija e implemente o necessário nas partes 1 até 3 deste exercício, para só
	-- então implementar o que é necessário nesta parte).
	
	---------------------------------------------------------------------------------
	---------------------------------------------------------------------------------
	------- IMPLEMENTE AQUI (pode apagar os comentários)
	---------------------------------------------------------------------------------
	---------------------------------------------------------------------------------

end arch;