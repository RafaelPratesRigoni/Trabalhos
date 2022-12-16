
MÓDULO 96 - GESTÃO LEITE

Objetivo deste Arquivo é Facilitar o entendimento dos processo dó Módulo Gestão Leite
 
O Gestão Leite é o Módulo Customizado utilizado para  folha de pagamento ao Produtor Leite.
Manual de Operação do Protótipo

MANUAL DE OPERAÇÃO DO PROTÓTIPO

1.	CADASTRO DE SETOR 
Atualização > Cadastro > Setor 
Ponto de Entrada: AGLT004 
Tabela: ZL2 - Setor 
Principais Campos: Código, Descrição, Armazém, NF por Prod. Setor é um agrupamento de linhas/rotas que, por sua vez, são agrupamentos de produtores.

2.	CADASTRO DE ACESSOS USUÁRIOS 
Atualização > Cadastros > Acessos Usuários 
Ponto de Entrada: AGLT023.PRW 
Tabela: ZLU – Cadastro de Usuários 
Principais Campos: Usuário, Setores, Cod. Usuário, Nome. 
Rotina utilizada para cadastro dos usuários utilizadores do módulo permitindo controle de tarefas. Obs.: Para utilizar essa rotina é necessário que já exista um usuário cadastrado no configurador do Protheus.

3.	CADASTRO DE TANQUES 
Atualizações > Cadastros > Cadastro de Tanques 
Ponto de Entrada: AGLT036 
Tabelas: ZLS – Cabeçalho do Cadastro de Tanques / ZLT – Itens Cadastro de Tanques Principais Campos: Código, Descrição, Classif, Dono Tanque, Participante. Rotina utilizada para cadastrar os tanques de recebimento de leite dos produtores.

4.	CADASTRO DE MOTORISTAS
 Atualizações > Cadastros > Motoristas 
Ponto de Entrada: AGLT001 Tabelas: ZL0 – Cadastro de Motoristas 
Rotina utilizada para cadastro de todos os motoristas.

5.	CADASTRO DE VEÍCULOS 
Atualizações > Cadastros > Veículos 
Ponto de Entrada: AGLT002 Tabela: ZL4 – Cadastro de Veículos 
Rotina utilizada para cadastro dos veículos utilizados na empresa, para posteriormente serem utilizados em outras rotinas do sistema.

6.	CADASTRO DE GRUPO DE PREÇOS 
Atualizações > Cadastros > Grupo de Preços 
Ponto de Entrada: AGLT005 Tabela: ZL3 – Grupo Preço Leite 
Rotina utilizada para cadastro dos grupos de Preços do Leite. Utilizado para estabelecer um preço padrão pra determinadas regiões ou para controle da empresa por grupos.

7.	CADASTRO DE LINHAS/ROTAS
 Atualizações > Cadastros > Linhas/Rotas
 Ponto de Entrada: AGLT037 Tabela: ZLW – Linhas Rotas Rotina utilizada para cadastro das linhas/rotas dos veículos.

8.	CADASTRO DE LINHA/ROTA PRODUTOR 
Atualizações > Cadastros > Linha/Rota Produtor
 Ponto de Entrada: AGLT038 Tabelas: ZLY – Cabeçalho Linha Produtor / ZLZ – Itens Linha Produtor.
 Rotina para vincular os produtores às linhas/rotas de entrega.

9.	CADASTRO DE TIPOS DE FAIXA 
Atualizações > Cadastros > Tipos de Faixa 
Ponto de Entrada: AGLT013 Tabela: ZL9 – Glt Tipos de Faixa.
Rotina utilizada para cadastro dos tipos de faixa utilizados na Faixa de Indicação, podendo ser: “Qualidade”, quando é um tipo referente a qualidade do leite (Ex: Gordura) ou “Outros” para qualquer outra modalidade de faixa.

10.	 CADASTRO DE FAIXA DE INDICAÇÃO 
Atualizações > Cadastros > Faixa de Indicação 
Ponto de Entrada: AGLT014 Tabela: ZLA – Faixa de Indicação.
Rotina desenvolvida para possibilitar o cadastramento das Faixas de Indicação (Escala de valores). Toda Faixa de Indicação possui um código de Tipo de Faixa, as faixas são utilizadas para bonificar ou penalizar os produtores de acordo com o evento a ela relacionado.

11.	GRUPO DE EVENTOS
Atualizações > Roteiros de Cálculos > Grupo de Eventos 
Ponto de Entrada: AGLT018 Tabela: ZL7 – Glt Grupo de Eventos 
Rotina desenvolvida para possibilitar o cadastramento de Grupos de Eventos.

12.	PREFIXO DE EVENTOS 
Atualizações > Roteiros de Cálculos > Prefixo de Eventos 
Ponto de Entrada: AGLT016 Tabela: ZL6 – Glt Prefixo de Evento
 Rotina desenvolvida para possibilitar o cadastramento do Prefixo dos Eventos.

13.	EVENTOS 
Atualizações > Roteiros de Cálculos > Eventos 
Ponto de Entrada: AGLT006 Tabela: ZL8 – Glt Cadastro de Eventos
 Rotina utilizada para cadastro dos eventos que irão interferir no valor do leite. Rotina muito utilizada no Mix do Leite.

14.	RECEPÇÃO DO LEITE 
Atualizações > Movimentos > Recepção Leite 
Ponto de Entrada: AGLT003 Tabela: ZLD – Glt Recepção de Leite
 Rotina desenvolvida para possibilitar o cadastramento da Recepção de Leite.

15.	EMRPÉSTIMOS 
Atualizações > Movimentações > Empréstimos
 Ponto de Entrada: AGLT012 Tabelas: ZLM – Glt Solic. Empréstimo / ZLO – Glt Itens do Empréstimo .
Rotina criada para cadastro de solicitação de empréstimos ao fornecedor.

16.	CONVÊNIOS
 Atualizações > Movimentações > Convênios
 Ponto de Entrada: AGLT010 Tabelas: ZLL – Glt Lcto dos Convênios 
Rotina criada para lançamento dos convênios.

17.	ANÁLISE DA QUALIDADE
Atualizações > Movimentações > Analise da Qualidade 
Ponto de Entrada: AGLT015 Tabela: ZLB – Glt Análise de Qualidade. 
Rotina desenvolvida para cadastrar/importar os resultados providos da análise realizada pela clínica do leite.

18.	MIX DO LEITE
 Atualizações > Mix > Mix do Leite 
Ponto de Entrada: AGLT008 Tabela: ZLE – Glt Cabeçalho do Mix / ZLF – Glt Itens do Mix Rotina utilizada para gerar o calculo dos eventos aplicados no leite.

19.	IMPORTA ANÁLISE DE QUALIDADE 
Miscelanea > Qualidade > Importa Analise Qualidade
 Ponto de Entrada: MGLT0003 Tabela: ZLB – Glt Análise de Qualidade.
Essa rotina importa dados de analise de leite a partir de um arquivo enviado pelo laboratório e grava na tabela de analises.

20.	EXPORTA ETIQUETA 
Miscelanea > Qualidade > Exporta Etiqueta 
Ponto de Entrada: MGLT005 Essa rotina exporta os dados do Retiro e dos Tanques, para importação no Sistema LQL. O sistema LQL emite as etiquetas para serem anexadas ao tubo de ensaio enviado para Analise da Qualidade.

21.	ACERTO DO LEITE 
Miscelanea > Fechto Leite > Acerto Leite 
Ponto de Entrada: MGLT009 Rotina desenvolvida para possibilitar o Acerto do Leite junto aos produtores. Será calculados os dados Financeiros e gerado as notas fiscais para os produtores.

22.	CANCELA LEITE 
Miscelanea > Fechto Leite > Cancela Leite 
Ponto de Entrada: MGLT010 Rotina desenvolvida para possibilitar o CANCELAMENTO do Acerto do Leite junto aos produtores.

23.	FCHTO FINANCEIRO 
Miscelanea > Fechto Leite > Fchto Financeiro 
Ponto de Entrada: MGLT033 Rotina de acerto financeiro dos cooperados. Realiza baixa dos débitos compensando com o credito do leite.

24.	CANCELA FINANCEIRO 
Miscelanea > Fechto Leite > Cancela Financeiro
 Ponto de Entrada: MGLT032 Rotina de cancelamento financeiro dos cooperados.

25. TRANSFERENCIA LITRO DE LEITE
Movimentos > Transferencia Litros 
Ponto Entrada: AGLT107 Rotina transferencia de litros entre produtores, para gerar creditos e debitos
no fechamento do leite.


TABELA	DESCRIÇÃO NOME TABELA
ZL0010	GLT - CADASTRO DE MOTORISTA
ZL2010	GLT - SETOR
ZL3010	GLT - GRUPO PRECO LEITE
ZL4010	GLT - CADASTRO DE VEICULO
ZL5010	GLT - GRUPOS DE PRODUTORES
ZL6010	GLT - PREFIXO DO EVENTO
ZL7010	GLT - GRUPOS DE EVENTOS
ZL8010	GLT - CADASTRO DE EVENTOS
ZL9010	GLT - TIPOS DE FAIXAS
ZLA010	GLT - FAIXA DE INDICACAO
ZLB010	GLT - ANALISE DE QUALIDADE
ZLC010	GLT - CABEC. RECEPCAO DE LEITE
ZLD010	GLT - ITENS. RECEPCAO DE LEITE
ZLE010	GLT - CABECALHO DO MIX
ZLF010	GLT - ITENS DO MIX
ZLI010	GLT - ITENS TRANSF. DE LEITE
ZLJ010	GLT - TRANSF. DE LITROS
ZLK010	GLT - LCTO DOS CONVENIOS
ZLL010	GLT - LCTO DOS CONVENIOS
ZLM010	GLT - SOLIC. EMPRESTIMO
ZLN010	GLT - DESCARTE DE LEITE
ZLO010	GLT - ITENS DO EMPRESTIMO
ZLQ010	GLT - OCORRENCIAS PGTO FRETE
ZLS010	GLT - CABEC. CAD. TANQUES
ZLT010	GLT - ITENS CAD. TANQUES
ZLU010	GLT - ACESSOS DE USUARIOS
ZLV010	GLT-  REGISTRO DO FECHAMENTO
ZLW010	GLT - LINHAS ROTAS
ZLY010	GLT - CABEC. LINHA PRODUTOR
ZLZ010	GLT - ITENS LINHA PRODUTOR
ZM0010	GLT - CABECALHO PAGTO FRETE
ZM1010	GLT - DETALHES PAGTO FRETE
ZM2010	GLT - DEBITOS DO PAGTO FRETE
ZM3010	GLT – ASSOCIACOES DE PRODUTOR
ZM4010	GLT – PRODUTORES DA ASSOCIAÇÃO
ZLG010	GLT - Creditos Financeiros
ZML010	GLT-  COLETAS SMATQUESTIO
---------------------------------