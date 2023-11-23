# tp-LaboratorioSistemasDigitais
O projeto representa a implementação de uma máquina de lavar, feita em VHDL, utilizando o software Quartus Prime, com implementação física na placa DE10 Lite, da Terasic.

A execução do projeto levou em conta uma implementação modularizada de uma máquina de lavar que contém 7 estados, formando uma máquina de estados finita, sendo esses estados, _inicial_, _enchimento_, _lavagem_,
_drenagem_, _segundo_enchimento_, _enxague_, _drenagem_ e _centrifugação_. Após finalizar a centrifugação, a máquina retorna para o estado inicial.

Nesse repositório temos duas implementações, sendo uma para simulação sintetizada, utilzando o software Modelsim, e outra para implementação e simulação física, na placa. Isto se deu pela limitação de pinos
apresentada pela placa DE10 Lite, limitando o projeto a ter somente 10 pinagens para entrada de dados. Assim, o projeto simulado por software tem maior precisão e riqueza de informações, enquanto o projeto 
implementado em placa tem um viés funcional, mantendo a lógica e implementação da máquina de estados.

Para o desenvolvimento do sstemas, foram utilizadas as seguintes entidades, modularizadas e integradas na top level, que é _MaquinaDeLavar_

## Adição De Água
Essa entidade é responsável por monitorar a adição de água na máquina. Ela recebe um enable, que quando está em nível alto verifica os valores de nível de roupa e nível de água e executa uma lógica para
continuar enchendo a máquina, ou para cessar o enchimento.

## Drenagem de Água
Essa entidade é responsável por monitorar o esvaziamento da máquina. Ela recebe um enable, que quando está em nível alto verifica se o sensor de nível de água está em nível alto e, a depender desse resultado,
determina se a máquina deve ser esvaziada ou não.

## Nível De Roupas
Essa entidade é responsável por determinar o nível de roupas na máquina. Ela recebe um sensor de distância e retorna um nível. Caso o sensor de distância esteja em nível alto, o nível também estará em nível alto,
e vice-versa.

## Motor
Essa entidade implementa a execução do motor da máquina, responsável pelas tarefas de lavagem, enxague e centrifugação. O motor recebe um enable, um temporizador e retorna um sinal para fim da operação, avaliando
essa lógica quando o sinal de enable está em nível alto.

## Temporizador
Essa entidade implementa um temporizador para as operações da máquina. Ela recebe um clock, um reset, um enable e retorna um sinal para o fim da operação. Temos uma constante que define o valor máximo para o contador iterar, e enquanto reset estiver em 0, em cada borda de subida de clock o contador é incrementado em uma unidade até que ele atinja o valor máximo delimitado. Caso o reset esteja em 1, o contador é sempre 0.

## Display
Essa entidade mapeia os estados da máquina de lavar e transforma em um std_logic_vector de 7 bits que indica a representação do estado atual no display de sete segmentos da placa. Na placa DE10 Lite, os leds 
se acendem quando o seu segmento está em baixo nível, isto é, em 0. Quando o segmento é setado com nível alto, ele permanece apagado.

## Máquina de Lavar
Top Level entity. Instancia todos os componentes acima, faz suas integrações e implementa a máquina de estados finita, que rege o comportamento do projeto. Optamos por integrar o datapath e a FSM pensando em 
otimização de tempo e implementação mais prática do projeto.
