Nesse repositório foi desenvolvido uma SATD - Sum of Absolute Transformed Differences para a matéria INE 5406, parte Prática com o professor Ismael Seidel
Membros da Equipe: Arthur Rosa Alves - Joshua Cruz do Amaral - Julia Macedo de Castro - Lucas Semprebon Herdt - Maria Eduarda Teixeira Costa - Pedro Silva Chaves - Sofia Gazolla da Costa Silva

Para o desenvolvimento, foi organizado durante o periodo de aula o que cada aluno seria responsável por realizar e também a organização da equipe.
Então o GitHub foi utilizado para salvar e compartilhar os arquivos nesse repositório durante o periodo entre-aulas, onde cada um poderia revisar e utilizar o código do colega para os seus próprios.
Após os módulos basicos estarem prontos, os seus respectivos testbenches foram criados, para que uma segunda leva de revisões e testes poderiam ser feitas.

Utilizamos de inspiração o código de TCC do doutor Marcio Monteiro, que realizou um trabalho similar no seu trabalho de conclusão de curso.
Também o trabalho de doutorado do Ismael Seidel, nosso professor que igualmente implementou uma SATD no seu projeto, e usamos como referência para a nossa, fazendo algumas alterações nas partes onde não se encaixava para o nosso caso.
Ambos foram extremamente atenciosos e cooperativos durante a realização do projeto, para entender todo o funcionamento e para que cada módulo funcionava.

ABS_lAYER - Layer de absoluts, entrando 8 valores signed de 15 bits e saindo 8 valores unsigned de 14.
ACCUMULATOR - O Accumulator é um módulo de acumulação com o resultado da árvore de somas, tudo que ele faz é unir todo esse somatório em registradores.
BUTTERFLY2 - Realiza a operação de soma e subtração no padrão butterfly, a primeira saida sendo a soma dos dois valores, e a segunda saida sendo a diferença entre o prímeiro e segundo.
           - Esse módulo acaba sendo crucial para toda a operação da transformada.
DIFFERENCE_LAYER - Faz a layer de 8 difference_of_unsigned_inputs, organizando e fazendo todas as subtrações necessárias de uma vez só
DIFFERENCE_OF_UNSIGNED_INPUTS - Faz a diferença entre duas entradas originalmente unsigned, transformando elas em signed com +1 bit, utilizada na parte inicial do            projeto
MUX_2TO1 - Mux seletor entre 2 entradas de N bits.
SAD_8X8TOPLEVEL - Top Level, instanciação do BC e BO, junto com os sinais iniciais.
SATD_BC - Bloco de Controle, aonde nossa maquina de estados opera, definindo os valores de enable e sinais de controle para todo o projeto.
SATD_BO - Bloco Operativo da SATD, onde todas as operações e instanciações dos outros módulos vem a ocorrer
TRANSFORM_1D_8INPUTS - Realiza o conjunto das operações de transformação, utilizando diversas butterflys para tal, somando e subtraindo todos os valores necessários
           para finalizar a transformada de hadamard
TRANSPOSE_BUFFER_8X8  - Conjunto de todas as células do transpose buffer únidas.
TRANSPOSE_BUFFER_CELL - Age como uma uníca celula to transpose buffer, podendo armazenar os valores dependendo da entrada do mux.
SUM_TREE_8INPUTS - Realizqa um conjunto de somas em pares, para que 8 valores sejam somados e unidos para uma saída única.
ADDER - Soma duas entradas de N bits unsigneds e retorna uma saida de N+1 bits




Ferramentas Utilizadas:
Quartus II, GTKWave, GHDL, MODELSim, VSCode com plugin da SIGASI.

Além disso, o Lucas desenvolveu um google sheet's capaz de calcular todas as etapas de todas as borboletas com as 16 entradas.
https://docs.google.com/spreadsheets/d/1lWjL5GMqJKJrzLq7CQQ9KBN26bHAwVbJFeXO_GNMZsg/edit?usp=sharing
