# Atividade Prática 2

A Atividade Prática 2 teve como objetivo a implementação da arquitetura SAD1, circuito responsável pelo cálculo da soma das diferenças absolutas, conforme estudado previamente nas aulas teóricas da disciplina.

Foram disponibilizados 10 arquivos para edição e complementação: absolute_difference.vhdl, mux_2to1.vhdl, partes_a_corrigir.json, sad.vhdl, sad_bc.vhdl, sad_bo.vhdl, sad_pack.vhdl, signed_subtractor.vhdl, unsigned_adder.vhdl e unsigned_register.vhdl. A implementação foi baseada no diagrama apresentado no slide 70 da aula 6T.

Durante a atividade, realizamos:

A implementação das entidades básicas do circuito: multiplexador (mux), registrador, somador/subtrator;

A descrição da FSMD, por meio do bloco de controle (sad_bc.vhdl);

A descrição do bloco operativo (sad_bo.vhdl);

A integração dos blocos de controle e operativo na entidade top-level (sad.vhdl), que representa o circuito SAD completo.

O arquivo sad_pack.vhdl foi utilizado como fornecido, sem necessidade de modificação. Já o arquivo partes_a_corrigir.json serviu como base para as etapas automatizadas de verificação e correção.

Após a finalização da implementação da SAD1, o projeto foi criado e compilado no Quartus. Por fim, foram anotados os parâmetros solicitados no enunciado.

## Dupla 1

- Sofia Gazolla da Costa Silva (Matrícula 24208690)
- Maria Eduarda Teixeira Costa (Matrícula 24203054)


## Descrição
O circuito tem três arquivos principais para a sua realização: sad.vhdl, sad_bc.vhdl e sad_bo.vhdl, e vários outros arquivos que são usados como entidades de sad_bc e sad_bo. 
O componente sad_bc é responsável por descrever o bloco de controle do circuito e gerar os sinais de controle necessários para o funcionamento do bloco operativo. A arquitetura comportamental é dividida em três processos (process) distintos, para que as responsabilidades do bloco de controle fiquem separadas de forma mais clara. 
- O primeiro process, chamado Parte1, é responsável pelo carregamento e reset do registrador de estado. Ele utiliza os sinais clk e rst_a como entradas, porque o comportamento sequencial do registrador depende da borda de subida do clock e de um reset assíncrono ativo em nível alto.
- O segundo process, que se chama Parte2, implementa a lógica de próximo estado. Ela considera o estado atual e os sinais iniciar (para o estado S0) e menor (no estado S2) para determinar o próximo estado da FSM. 
- Já o terceiro process, Parte3, define a lógica de saída da máquina de estados, ou seja, quais sinais de controle são ativados em cada estado. A saída só depende do estado atual (estadoatual).

O componente sad_bo descreve o bloco operativo do circuito. Ele está dividido logicamente em duas partes principais, uma responsável pelo cálculo da SAD e a outra responsável pelo cálculo e controle do endereço.
A parte responsável pelo cálculo da SAD inicia com dois registradores síncronos (unsigned_register), que armazenam as entradas amostraA e amostraB. Esses registradores são habilitados pelos sinais de controle cpA e cpB, respectivamente. 
As saídas desses registradores são encaminhadas ao componente absolute_difference, que calcula o valor absoluto da diferença entre as duas amostras. O componente realiza essa conta utilizando dois subtratores (signed_subtractor), um que realiza A - B (para valores positivos e zero) e B - A (para valores negativos). Então, um multiplexador (mux_2to1), que é controlado pelo bit de sinal do resultado da subtração, seleciona qual das duas saídas representa corretamente o valor absoluto. Após isso, esse resultado é redimensionado para o número de bits necessário para evitar overflow durante a soma acumulativa das diferenças absolutas. 
Em seguida, esse valor é somado ao valor acumulado anterior (utilizando unsigned_adder). A saída do somador é convertida para std_logic_vector e enviada a um multiplexador(mux_2to1), que seleciona entre esse valor e zero, tendo como sinal seletor o sinal de controle zsoma. Esse mux realiza isso para que a soma acumulada possa ser zerada quando necessário (no início do cálculo, por exemplo). 
A saída do multiplexador é registrada em outro registrador (unsigned_register), o qual é controlado pelo sinal csoma. A saída desse registrador passa a ser uma das entradas do somador, o que forma um acumulador. Após todos os valores serem somados, o valor final da SAD é registrado em um último registrador (também do tipo unsigned_register). A saída desse registrador representa a SAD final, é convertida para std_logic_vector e atribuída à porta de saída SAD. 

Já a outra parte, que é responsável pelo controle do endereço de leitura das amostras, começa com um somador (unsigned_adder) que incrementa o endereço atual, somando 1 aos 6 bits menos significativos do registrador de endereço. 
Esse novo valor é convertido de unsigned para std_logic_vector e enviado a um multiplexador (mux_2to1), que escolhe entre o endereço incrementado e o valor zero, seguindo o sinal de controle zi. Isso serve para que o endereço possa ser reiniciado no início do processamento. O valor selecionado é armazenado em um registrador síncrono (unsigned_register) de 7 bits, que é controlado pelo sinal ci. O bit mais significativo desse registrador é invertido para gerar o sinal menor, o qual indica se ainda há amostras a serem processadas. Esse sinal é enviado ao bloco de controle. 
Por fim, os 6 bits menos significativos do registrador são atribuídos a saída address, que indica qual o próximo endereço de leitura. 

Finalmente, o arquivo sad, que é a top level entity, instancia o BC e o BO. 

A utilização de todos os componentes auxiliares que foram instanciados em sad_bc, sad_bo e sad já foi explicada anteriormente, mas segue um resumo de como cada um deles funciona (com exceção de absolute_difference, que já foi explicado):
 - signed_subtractor: Subtrator que trabalha com entradas do tipo signed. Ele faz a operação input_a - input_b, e o número de bits das entradas e da saída pode ser ajustado com o parâmetro N.
 - mux_2to1: Multiplexador 2:1 para vetores de N bits. A saída será igual a in_0 quando o seletor for 0, e igual a in_1 quando o seletor for 1.
 - unsigned_adder: Somador que opera com entradas sem sinal. Ele soma dois valores de N bits e gera uma saída de N+1 bits, para evitar problemas com o carry e previnir overflow. As entradas são ajustadas internamente para que a soma funcione corretamente.
 - unsigned_register: Registrador com controle de carga (enable) que armazena valores do tipo unsigned. O valor de entrada é registrado na borda de subida do clock, desde que o sinal enable esteja ativado.


#### Simulação

A simulação do circuito foi realizada apenas no ambiente VPL. Durante o processo de desenvolvimento, apareceram erros em alguns casos (do teste 1 ao 8 deu certo desde o início), mas todos eles foram corrigidos. Na simulação da versão final do código, o circuito funcionou corretamente em todos os testes, sem nenhum problema. 

Tentamos realizar a simulação usando GHDL também, mas tivemos problemas com a versão instalada (e não conseguimos instalar uma diferente) e, por isso, não conseguimos simular lá. 

## Outras observações

A principal dificuldade enfrentada durante a atividade foi relacionada à transformação de tamanho e tipo das portas de entrada e saída entre as entidades. Essa etapa exigiu atenção especial à compatibilidade dos sinais, bem como ao uso correto de conversões e ajustes de vetores para garantir o funcionamento do circuito como especificado. Também tivemos dificuldades para usar as funções do sad_pack, pois a maneira que tentamos usar não era compatível com o quartus e, portanto, teve que ser modificada. Acabamos optando por não usar as funções que calculavam o número necessário de bits de determinados sinais e as fizemos manualmente, de maneira adaptada à arquitetura especifica da SAD1. 
