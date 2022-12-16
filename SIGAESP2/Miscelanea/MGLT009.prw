#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#include "rwmake.ch"

#DEFINE _ENTER CHR(13)+CHR(10)

/*/
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  � MGLT009  � Autor � TOTVS                 � Data da Criacao  � 14/10/2008                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Rotina desenvolvida para possibilitar o Acerto do Leite junto aos produtores.                                ���
���          �                        						  '			                               				        ���
���          � Serao calculados os dados Financeiros e gerado as notas fiscais para os produtores.                          ���
���          �                        									                               				        ���
���          �                        									                               				        ���
���          �                        									                               				        ���
���������������������������������������������������������������������������������������������������������������������������͹��
���Uso       � Fechamento do Leite.            						                                                        ���
���������������������������������������������������������������������������������������������������������������������������͹��
���Parametros� Nenhum						   							                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Retorno   � Nenhum						  							                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Usuario   � Microsiga                                                                                					���
���������������������������������������������������������������������������������������������������������������������������͹��
���Setor     � Gestao do Leite.                                                                        						���
���������������������������������������������������������������������������������������������������������������������������͹��
���            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Autor     � Data     � Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor        ���
���������������������������������������������������������������������������������������������������������������������������ĺ��
��� Totvs    �20/11/2008�-Mudanca devido a contabilizacao de titulos,      �                                  � TI	        ���
���          �          � geracao do titulo pelo valor bruto da Nota,      �                                  �   	        ���
���          �          � baixa dos titulos do produtor x titulo da Nota.  �                                  �   	        ���
���          �          �-Mudanca no tratamento dos convenios, eles passa- �                                  �   	        ���
���          �          � ram a gerar contas a pagar.                      �                                  �   	        ���
���          �          �-Mudanca na leitura dos Eventos, eles se tornaram �                                  �   	        ���
���          �          � dinamicos, com Condicao e Formula no cadastro.   �                                  �   	        ���
��� Totvs    �09/12/2008�-Criada a funcao ActMIX() para considerar os      �                                  � TI	        ���
���          �          � eventos de Debito incluidos na ZLF pelo MIX.     �                                  �   	        ���
��� Totvs    �16/12/2008�-Implementacoes para considerar o novo indice do  �                                  � TI	        ���
���          �          � MIX. Passou a considerar a Versao do MIX.        �                                  �   	        ���
���          �          �                                                  �                                  �   	        ���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���          �          �                    							   �                                  � 			���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���������������������������������������������������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
/*/
User Function MGLT009

	Local cPerSetor   := ""
	Local _bProcess    := {|oSelf| MGLT5Exec(oSelf)}
	Local _oTProces
	Private _cPerg     := PADR("PMGLT009",10)
	Private _cTpNF	  := AllTrim(GetMv("LT_ESPECIE"))//Armazena a especie das notas fiscais dos produtores
	Private _cMes      := SubStr(DtoS( ADDMes(dDataBase,1) ),5,2)
	Private _cAno      := SubStr(DtoS( ADDMes(dDataBase,1) ),1,4)
	Private _cVencto   := "" //Data de vencimento do titulo da Nota do Produtor
	Private _cHist     := "Fechamento GLT "+SubStr(DtoS(dDataBase),5,2)+"/"+SubStr(DtoS(dDataBase),1,4)
	Private _dDtBase   := dDatabase+7500 //Tratamento especifico para funcao SaldoTit funcionar corretamente.
	Private cGLTalias := GetNextAlias() //"GLT" //Nome do alias para as tabelas temporarias
	Private lDeuErro  := .F.
	Private _lStatus   := .F.
	Private _nReg      := 0
	Private _nSldPro   := 0
	Private _cNroNota  := ""
	Private cCodMIX   := ""
	Private _cVersao   := "1"
	Private _cSetores  := ""
	Private _cProdDe   := ""
	Private cProdAte  := ""
	Private cLojaDe   := ""
	Private cLojaAte  := ""
	Private cRotaDe   := ""
	Private cRotaAte  := ""
	Private _aPrdMin   := {}
	Private _cTamParc  := StrZero(1,TamSx3("E2_PARCELA")[1]) //Parcela do titulo do evento(NDF)
	Private _cParcNF   := Space(TamSx3("E2_PARCELA")[1]) //Tamanho da Parcela do titulo da Nota
	Private _cSerie	  := ""//leitura da ZL2 PADR(AllTrim(GETMV("LT_SERIE")),TamSx3("F1_PREFIXO")[1]) // Serie da NF
	Private _cPrefixo  := _cSerie
	Private _cMultNota := "S" //S para uma Nota por Produtor; N para uma Nota por Municipio
	Private _cMotBaixa := AllTrim(GETMV("LT_MOTBX"))  //Motivo de baixa utilizado para a rotina do Leite
	Private cEvetInc  := ALLTRIM(GetMv("LT_EVEINCE")) //Codigo do Evento de Incentivo(ICMS)
	Private cCodINSS := AllTrim(GetMv("LT_EVEINSS")) //Codigo do evento de INSS (Funrural)
	Private cEvetAdc := IIF(!Empty(GetMv("LT_EVEADIC")),AllTrim(GetMv("LT_EVEADIC")),Space(3)) //Codigo do Evento de Adicional de Mercado
	Private _nDifADC := 0
	Private _aLista    := {}
	Private aPrdMun   := {}
	Private cHoraIni  := TIME()
	Private nTxPar := GetMv("LT_TXPER")
	Private _cTipoTit := PADR(Alltrim(GetMv("LT_CONVTIP")),3)
	Private dBaixa     := dDataBase //Compatibilizacao com a funcao padrao fa080Juros
	Private nVlEstrang := 0
	Private _nTamFil    := TamSx3("ZLF_FILIAL")[1]
	Private _nTamLoj    := TamSx3("ZLF_RETILJ")[1]
	Private _nTamFor    := TamSx3("ZLF_RETIRO")[1]
	Private _lUsaSA5 := SuperGetMv("LT_CRIASA5",,.T.) //Valida se a empresa usa amarra��o Produto X Fornecedor
	Private _nTotDebito := 0 //Recebe total de debitos da fun��o MGLT032
	Private _lFechaFin := SuperGetMv("LT_FECHFIN",,.F.) //Par�metro indica se o financeiro ser� fechado junto com a gera��o da nota.(MGLT032)


	//����������������������������������������������������������������������Ŀ
	//�Variavel criada para armazenar o numero da primeira NF gerada         �
	//�para que o usuario saiba posteriormente o numero da primeira e ultima �
	//�NF que foi gerada.                                                    �
	//������������������������������������������������������������������������
	Private _cNumPriNF := ""
	Private _cNumUltNF := ""

	//���������������������������������������������������������������������Ŀ
	//�Armazena a filial corrente antes de iniciar o processo de fechamento.�
	//�����������������������������������������������������������������������
	Private _cFilEvent := cFilAnt
	Private _cFil_SE2  := xFILIAL("SE2")

	//����������������������������������������������������������������������������Ŀ
	//� Armazena o tipo da tributacao para ser usado nas formulas ( ZL8_FORMUL ).  �
	//������������������������������������������������������������������������������
	Private	_cTributac := ""

	Private _cFunrural := Rtrim(GetMv("LT_EVEINSS"))
	Private _cMsgNota := ""
	Private _aNfOri := {}

	//���������������������������������������������������������������������Ŀ
	//� Chama a tela para preenchimento dos parametros.                     �
	//�����������������������������������������������������������������������
	If !Pergunte(_cPerg,.T.)
		Return()
	EndIf

	//���������������������������������������������������������������������Ŀ
	//� Atribui valor a variaveis comuns a todas as Funcoes.                �
	//�����������������������������������������������������������������������
	cCodMIX  := MV_PAR01
	//_cVersao  := MV_PAR02
	_cSetores := AllTrim(MV_PAR02)
	_cProdDe  := MV_PAR03
	cProdAte := MV_PAR04
	cLojaDe  := "    "
	cLojaAte := "ZZZZ"
	cRotaDe  := MV_PAR05
	cRotaAte := MV_PAR06

	_cMsgNota := Alltrim(MV_PAR07)+" "+Alltrim(MV_PAR08)+" "+Alltrim(MV_PAR09)


	//���������������������������������������������������������������������Ŀ
	//� Verifica se os parametros estao em branco.                          �
	//�����������������������������������������������������������������������
	If Empty(cCodMIX)
		xMagHelpFis("PARAMETRO MIX VAZIO",;
			"O parametro Codigo do MIX nao foi informado.",;
			"Preencha nos parametros o codigo do MIX")
		Return()
	EndIf

	//����������������������������������������������������������������������Ŀ
	//� Verifica se o usuario tem permissao para executar a rotina de Acerto.�
	//������������������������������������������������������������������������
	dbSelectArea("ZLU")
	dbSetOrder(1)
	If MsSeek(xFilial("ZLU")+U_UCFG001(2))

		If ZLU->ZLU_ACERTO != "S"
			xMagHelpFis("USUARIO SEM PERMISSAO",;
				"Usuario sem permissao para executar esta rotina.",;
				"Acesse o m�dulo Configurador e altere o usu�rio para ter acesso a esta rotina.")
			Return()
		EndIf

		cPerSetor := U_VldSetor(_cSetores)//Retorna os setores que o usuario nao tem permissao para acessar.
		If !Empty(cPerSetor)
			xMagHelpFis("USUARIO SEM PERMISSAO",;
				"Usuario sem permissao para acessar os setores:"+cPerSetor,;
				"Acesse o m�dulo Configurador e altere o usu�rio para ter acesso a todos os setores selecionados "+;
				"ou informe nos parametros somente os setores que vc possue acesso.")
			Return()
		EndIf

	Else

		xMagHelpFis("USUARIO LEITE",;
			"Usuario n�o encontrado no cadastro de Acessos GLT.",;
			"Acesse o m�dulo Configurador e cadastre o usu�rio na rotina Acessos GLT.")
		Return()

	EndIf

	//��������������������������������������������������������������Ŀ
	//� Inicializa a tela de processamento.                          �
	//����������������������������������������������������������������

	cTexto := "Esta rotina tem o objetivo de efetuar o Acerto do LEITE dos Produtores"+_ENTER
	cTexto += " "+_ENTER
	cTexto += "Antes de executar essa rotina, � preciso gerar os eventos de cr�dito aos produtores no rotina de MIX!"+_ENTER
	cTexto += " "+_ENTER
	cTexto += "Ao confirmar a execu��o da rotina os t�tulos de d�bito e cr�dito ser�o gerados no financeiro! "+_ENTER
	cTexto += "Caso haja saldo, serao compensados os titulos de d�bitos. Caso contrario, esses d�bitos permanecer�o"+_ENTER
	cTexto += "no financeiro, e ser�o inclu�dos no proximo acerto! Por fim ser� gerado a NF."+_ENTER
	cTexto += " "+_ENTER
	cTexto += "A Data-Base do sistema deve ser a ultima do periodo!"+_ENTER

	//����������������������������������������������������������������������������������������������Ŀ
	//� Sintaxe da tNewProcess():New( cFunction, cTitle, _bProcess, cDescription, _cPerg, aInfoCustom) �
	//������������������������������������������������������������������������������������������������
	_oTProces := tNewProcess():New("MGLT009","Acerto do Leite",_bProcess,cTexto,_cPerg)


	SM0->(dbSetOrder(1))   // forca o indice na ordem certa
	SM0->(MsSeek(SUBS(cNumEmp,1,2) + cFilAnt))

Return()

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    �MGLT5Exec � Autor �Microsiga              � Data � 00.00.00 ���
�������������������������������������������������������������������������Ĵ��
���Descricao � Funcao para chamar as rotinas de Acerto.                   ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Parametros� ExpO01 - Objeto da Regua de processamento.                 ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MGLT009()                                                  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function MGLT5Exec(oObjProc)

	Local cESTADO		:= GetMV("MV_ESTADO")
	Local cFunc    		:= "1" //Codigo da Qry a ser executada
	Local cArqTmp  		:= cGLTalias+cFunc
	Local nCont    		:= 1
	Local nProd    		:= 0
	Local lContinue		:= .T.
	Local cxSetor  		:= ""
	Local cxLinha  		:= ""
	Local cxForn   		:= ""
	Local cxLoja   		:= ""
	Local cxTribu  		:= ""
	Local nxSaldo  		:= 0
	Local nxCredito  		:= 0
	Local nxDebito  		:= 0
	Local cHoraInicial 	:= TIME()
	Local _dDtBkpBas    := dDataBase
	Local _lNoAcerto	:= .F.
	Local _lYesAcert	:= .F.
	Private _lCredAssoc := .T.
	Public _pnVLEITE := 0
	Public _pnGetRedut := 0 //U_GetRedut(cCodMIX,SA2->A2_COD,SA2->A2_LOJA,ZL2->ZL2_COD,ZL3->ZL3_COD,_cVersao)
	Public _npGetCreditos := 0                        //


	dbSelectArea("ZLE")
	ZLE->(dbSetOrder(1))
	If ZLE->(MsSeek(xFilial("ZLE")+cCodMIX+_cVersao))

		Private	_dDtIni	:=	ZLE->ZLE_DTINI
		Private _dDtFim	:=	ZLE->ZLE_DTFIM

		//������������������������������������������������������������������Ŀ
		//� Verifica se o Mix ja esta encerrado.                             �
		//��������������������������������������������������������������������
		If ZLE->ZLE_STATUS == 'F'
			xMagHelpFis("NAO CONFORMIDADE 00 - MIX FECHADO",;
				"Este Mix ja foi fechado, logo n�o pode ser rodado o Acerto para o mesmo.",;
				"Escolha outro c�digo de Mix ou cancele o Acerto do mesmo.")
			Return()
		EndIf

		//������������������������������������������������������������������Ŀ
		//� Verifica se a data informada nos parametros eh uma data valida.  �
		//��������������������������������������������������������������������
		If Month(ZLE->ZLE_DTINI) != Month(ZLE->ZLE_DTFIM)
			xMagHelpFis("NAO CONFORMIDADE 01 - PERIODO INVALIDO",;
				"Mes inicial "+AllTrim(STR(Month(ZLE->ZLE_DTINI)))+" � diferente do mes final "+AllTrim(STR(Month(ZLE->ZLE_DTFIM)))+" !",;
				"Escolha um MIX onde a data Inicio e Fim estejam no mesmo m�s.")
			Return()
		EndIf

		//�����������������������������������������������������������������Ŀ
		//� Verifica se a database do sistema esta com o ultimo dia do mes. �
		//�������������������������������������������������������������������
		If ZLE->ZLE_DTFIM != dDataBase
			xMagHelpFis("NAO CONFORMIDADE 02 - DATABASE INVALIDA",;
				"A data do sistema("+DTOC(dDataBase)+") nao esta no ultimo dia do mes!",;
				"Altere a data do sistema para "+DTOC(LastDay(ZLE->ZLE_DTFIM)) )
			Return()
		EndIf



		//�����������������������������������������������������������������Ŀ
		//� Verifica se o financeiro ou estoque est�o bloqueados. �
		//�������������������������������������������������������������������
		If GetMV("MV_ULMES") > dDataBase .or. GetMV("MV_DATAFIN") > dDataBase .or. GetMV("MV_DBLQMOV") > dDataBase
			xMagHelpFis("NAO CONFORMIDADE 03 - DATABASE INVALIDA",;
				"Os par�metros de fechamento de estoque ou fechamento financeiro est�o maiores que a data base, e isso impede o fechamento de ser realizado.",;
				"Estoque MV_ULMES = "+DTOC(GetMV("MV_ULMES")) + _ENTER;
				+"Estoque MV_DBLQMOV = "+DTOC(GetMV("MV_DBLQMOV")) + _ENTER;
				+"Financeiro MV_DATAFIN = "+DTOC(GetMV("MV_DATAFIN")) )
			Return()
		EndIf


		//�������������������������������������������������������������������Ŀ
		//� Verifica se existem cadastros bloqueados no SA2 com leite entregue.
		//���������������������������������������������������������������������
		If !ValidaBloqueio()
			Return()
		EndIf

		If oObjProc<>Nil

			oObjProc:SaveLog("INICIO - ACERTO DO LEITE")

			//��������������������������������������������������������������������������������Ŀ
			//� Chama funcao para deletar na ZLF os eventos gerados pela rotina de Fechamento. �
			//����������������������������������������������������������������������������������
			MsgRun("Aguarde.... Preparando base para o Acerto...",,{||CursorWait(), MGLT5QRY("0"), CursorArrow()})


			//��������������������������������������������Ŀ
			//� Obtendo dados da ZLF                       �
			//����������������������������������������������
			MsgRun("Aguarde.... Verificando Produtores...",,{||CursorWait(), MGLT5QRY(cFunc), CursorArrow()})
			nProd:=_nReg

			(cArqTmp)->(DbGoTop())

			oObjProc:SetRegua1(nProd)

			//��������������������������������������������������������������������������������Ŀ
			//� Tratamento para chamar a numeracao da primeira nota fiscal.					   �
			//����������������������������������������������������������������������������������

			If (cArqTmp)->(!Eof())

				_cSerie := POSICIONE("ZL2",1,xFilial("ZL2")+(cArqTmp)->ZLF_SETOR,"ZL2_SERIE")
				_cPrefixo:= _cSerie

				If Sx5NumNota(_cSerie)
					_cNroNota := NxtSX5Nota(_cSerie)
					_cNroNota := IIF(Len(_cNroNota)<9,_cNroNota+"   ",_cNroNota)
				Else
					xMagHelpFis("NAO CONFORMIDADE 03 - NRO NOTA",;
						"O numero da Nota n�o foi informado!",;
						"Ao executar o Acerto no modo Definitivo, � obrigatorio informar o n�mero da Nota.")
					Return()
				EndIf
			EndIf

			While (cArqTmp)->(!Eof())

				// Substituindo variaveis pra facilitar modificacoes
				cxSetor := (cArqTmp)->ZLF_SETOR
				cxLinha := ""
				cxForn  := (cArqTmp)->ZLF_A2COD
				cxLoja  := (cArqTmp)->ZLF_A2LOJA
				nxSaldo := (cArqTmp)->CREDITO-(cArqTmp)->DEBITO
				nxCredito := (cArqTmp)->CREDITO
				nxDebito := (cArqTmp)->DEBITO
				cxTribu := "I"

				_pnVLEITE := (cArqTmp)->VLEITE
				//Compatibilizacao com a variavel utilizada no campo ZL8_FORMUL na geracao de eventos automaticos
				_cTributac := cxTribu

				IncProc("Produtor:"+cxForn+"-"+cxLoja)

				//�������������������������������������������������������Ŀ
				//� Verifica se a Linha e o produtor estao preparados     �
				//���������������������������������������������������������
				dbSelectArea("SA2")
				SA2->(dbSetOrder(1))
				SA2->(MsSeek(xFilial("SA2")+cxForn+cxLoja))

				If isPreparad(cCodMix,_cVersao,xFilial("ZLF"),cxSetor,cxLinha,cxForn,cxLoja,cxTribu) .or. (!Empty(SA2->A2_L_CODAS) .and. SA2->A2_L_ASSOC == 'S')

					//��������������������������������Ŀ
					//� Inicia o controle de transacao.�
					//����������������������������������
					Begin Transaction

						//�������������������������������������Ŀ
						//� Cadastro de Fornecedor( Produtor ). �
						//���������������������������������������
						dbSelectArea("SA2")
						SA2->(dbSetOrder(1))
						If SA2->(MsSeek(xFilial("SA2")+cxForn+cxLoja))
							/*
							//��������������������������������������������������������������Ŀ
							//�Adicionado pois nao estava                                    �
							//�posicionando no setor que foi gerado os eventos do produtor	 �
							//�e estava se utilizando a referencia do setor.                 �
							//����������������������������������������������������������������
							*/
							//_cTributac := SA2->A2_L_TRIBU
							//���������������������������������������������������������������������������������Ŀ
							//� Posiciona no Setor do Produtor.                                                 �
							//�����������������������������������������������������������������������������������
							DbSelectArea("ZL2")
							ZL2->(DbSetOrder(1))
							If !ZL2->(MsSeek(xFILIAL("ZL2") + cxSetor))

								lDeuErro := .T.


								oObjProc:SaveLog("ERRO 01 - SETOR INEXISTENTE " + cxSetor)

								xMagHelpFis("NAO CONFORMIDADE 04 - SETOR INEXISTENTE",;
									"O setor: " + cxSetor + " n�o existe no cadastro de Setores.",;
									"Informe no cadastro de produtor uma linha com Setor existente no cadastro de Setores.")

							Else
								_cVencto := DataValida(Condicao(1000,ZL2->ZL2_CONDPG)[1][1]) //Retorna vencimento da nota do produtor
								_cVencto := DTOS(_cVencto)
								_cSerie := ZL2->ZL2_SERIE

							EndIf

							//�����������������������������������Ŀ
							//� Atualiza a regua de processamento.�
							//�������������������������������������
							If oObjProc <> Nil
								oObjProc:IncRegua1("Produtor "+AllTrim(Str(nCont))+" de "+AllTrim(Str(nProd))+" ("+AllTrim(str( round((nCont/nProd)*100,0) ))+"%) -> " + SA2->A2_COD +"/"+SA2->A2_LOJA +" - "+SA2->A2_NOME)
							EndIf

							_nSldPro := Round(nxSaldo,2)


							//Grava variavel publica que ser� usada nos eventos
							_pnGetRedut := nxDebito//U_GetRedut(cCodMIX,SA2->A2_COD,SA2->A2_LOJA,ZL2->ZL2_COD,ZL3->ZL3_COD,_cVersao)
							_npGetCreditos := nxCredito //U_GetCredPr(ZLE->ZLE_COD,SA2->A2_COD,SA2->A2_LOJA,ZL2->ZL2_COD,ZL3->ZL3_COD,,.F.)



							If !lDeuErro

								//Se produtor diferente de pessoa jur�dica, gera a nota. Caso contrario so inclui titulo no financeiro
								If SA2->A2_L_GERNF == "S" //Campo controle para identificar se ser� gerada a nota.

									If Alltrim(cESTADO) == "RS"
										_aNfOri := GetNFOri()
										If Len(_aNfOri) <> 3
											lDeuErro := .t.
											xMagHelpFis("NAO CONFORMIDADE - NF ORIGEM",;
												"N�o encontrada NF Origem do produtor "+AllTrim(SA2->A2_COD+SA2->A2_LOJA)+" "+AllTrim(SA2->A2_NOME),;
												"Antes de prosseguir, efetue lan�amento de NF de bloco e informe o MIX de origem na linha do produto.")
										Else
											GrvNfPro(oObjProc) //Acerto Fiscal(Gera NF produtor)
										EndIf
									Else
										GrvNfPro(oObjProc) //Acerto Fiscal(Gera NF produtor)
									EndIf
								EndIf
							EndIf

							//���������������������������������������������������������������������������������Ŀ
							//�Incluido, para que as                                                            �
							//�baixas realizadas no titulo ja contemplem a data maxima do pagamento para o      �
							//�calculo de juros por exemplo:                                                    �
							//�Fechamento: 01/02/12 a 29/02/12 - somente era calculado o juros ate o dia        �
							//�29/02/12, agora com a alteracao sera considerada a data de fechamento, atualmente�
							//�o 15 dia do mes posterior no nosso exemplo seria: 15/03/12.                      �
							//�����������������������������������������������������������������������������������
							//dDataBase:= StoD(_cVencto)
							dBaixa   := StoD(_cVencto) //Compatibilizacao com a funcao padrao fa080Juros


							If !lDeuErro
								ActMix(oObjProc) //Acerto de Eventos de Debito incluidos pelo Mix(Le a ZLF, gera e baixa SE2).
							EndIf

							If !lDeuErro
								ActEvento(oObjProc) //Acerto de Eventos Automatico(Le a ZL8, gera ZLF e SE2 e baixa SE2)
							EndIf

							If !lDeuErro .and. _lFechaFin
								_nTotDebito := U_MGLT032(cCodMIX,cxForn,cxLoja,oObjProc) //Executa a rotina de fechamento fiannceiro para o produtor
								//O acerto financeiro desposiciona a loja, necessario reposicionar
								dbSelectArea("SA2")
								SA2->(dbSetOrder(1))
								SA2->(MsSeek(xFilial("SA2")+cxForn+cxLoja))


							EndIf

							If !lDeuErro
								dbSelectArea("SF1")
								SF1->(dbSetOrder(1))//F1_FILIAL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_TIPO
								If SF1->(MsSeek(xFilial("SF1") + _cNroNota + _cSerie + cxForn+cxLoja + "N"))
									RecLock("SF1",.F.)
									SF1->F1_L_MENSG	:= GetDescNF(SF1->F1_FILIAL,SF1->F1_DOC,SF1->F1_SERIE,SF1->F1_FORNECE,SF1->F1_LOJA,SF1->F1_VALBRUT,SF1->F1_VALICM,cCodMix,_cVersao,ZL2->ZL2_COD,_cTributac)
									SF1->(MsUnlock())

									//Altera ZLF fixando valor do Funrural igual o gerado pela NF - Guilherme Fran�a - 08/01/2019
									DbSelectArea("ZLF")
									DbSetOrder(1) //ZLF_FILIAL, ZLF_CODZLE, ZLF_VERSAO, ZLF_RETIRO, ZLF_RETILJ, ZLF_EVENTO, ZLF_SEQ, R_E_C_N_O_, D_E_L_E_T_
									If MsSeek(xFilial("ZLF")+cCodMix +_cVersao + SF1->F1_FORNECE + SF1->F1_LOJA + _cFunrural)
										If ZLF->ZLF_EVENTO == _cFunrural
											_nDifADC += (SF1->F1_CONTSOC + SF1->F1_INSS + SF1->F1_VLSENAR) - ZLF->ZLF_TOTAL

											RecLock("ZLF",.F.)
											ZLF->ZLF_TOTAL := (SF1->F1_CONTSOC + SF1->F1_INSS + SF1->F1_VLSENAR)
											ZLF->ZLF_VLRLTR := Round((SF1->F1_CONTSOC + SF1->F1_INSS + SF1->F1_VLSENAR) / ZLF->ZLF_QTDBOM,6)
											ZLF->(MsUnlock())
										EndIf
									EndIf
									//Altera ZLF fixando valor do Incentivo igual o gerado pela NF - Guilherme Fran�a - 08/01/2019
									DbSelectArea("ZLF")
									DbSetOrder(1) //ZLF_FILIAL, ZLF_CODZLE, ZLF_VERSAO, ZLF_RETIRO, ZLF_RETILJ, ZLF_EVENTO, ZLF_SEQ, R_E_C_N_O_, D_E_L_E_T_
									If MsSeek(xFilial("ZLF")+cCodMix +_cVersao + SF1->F1_FORNECE + SF1->F1_LOJA + cEvetInc)
										If ZLF->ZLF_EVENTO == cEvetInc
											_nDifADC += (SF1->F1_VALBRUT - SF1->F1_VALMERC) - ZLF->ZLF_TOTAL

											RecLock("ZLF",.F.)
											ZLF->ZLF_TOTAL := SF1->F1_VALBRUT - SF1->F1_VALMERC
											ZLF->ZLF_VLRLTR := Round((SF1->F1_VALBRUT - SF1->F1_VALMERC) / ZLF->ZLF_QTDBOM,6)
											ZLF->(MsUnlock())
										EndIf
									EndIf
								Endif
							EndIf

							If !lDeuErro
								AtualizaSld(oObjProc) //Grava dados do fechamento na tabela ZLV
							EndIf

							//����������������������������������������������������������������Ŀ
							//�Efetua a restauracao da database antes da realizacao das baixas.�
							//������������������������������������������������������������������
							dDataBase:= _dDtBkpBas
							dBaixa   := _dDtBkpBas

							//�����������������������������������������������������������Ŀ
							//� Apos processar todas as funcoes, flag a ZLF informando que�
							//� os eventos do produtor foram todos processados.           �
							//�������������������������������������������������������������
							If  !lDeuErro
								U_AtuStatus("F",cxForn,cxLoja,"","",cxTribu,_cMultNota,SA2->A2_COD_MUN,SA2->A2_EST,ZLE->ZLE_DTINI,ZLE->ZLE_DTFIM)
							EndIf
						Else

							oObjProc:SaveLog("ERRO 05 - Nao existe Produtor "+AllTrim(cxForn+cxLoja))

							xMagHelpFis("NAO CONFORMIDADE 08 - Nao existe Produtor",;
								"Produtor "+AllTrim(SA2->A2_COD+SA2->A2_LOJA)+" n�o existe no cadastro!",;
								"Nao sera gerado Acerto para esse produtor. Verifique o c�digo do produtor no MIX versus o cadastro!","Alerta")
						EndIf

						//������������������������������������������������������������������Ŀ
						//� Grava Descricao dos Descontos na NF e zera NroNota               �
						//��������������������������������������������������������������������
						If  _cMultNota == "S" //Uma Nota por produtor
							_cNroNota := ""
							_cParcNF  := Space(TamSx3("E2_PARCELA")[1]) //Tamanho da Parcela do titulo da Nota
						EndIf

						//������������������������������������������������������������������������Ŀ
						//�                                                                        �
						//� Se pelo menos um produtor estiver fechado, o status dos cadastros de   �
						//� TIPOS DE FAIXAS / VLR X GRUPO BONIFICACAO / ANALISES X DATA CALCULO /  �
						//� FAIXA DE INDICACAO /GRUPO BONIF. X TP FAIXAS/ CABECALHO DESCONTO FRETE �
						//� eh alterado para ficar com o Status Fechado.                           �
						//�                                                                        �
						//��������������������������������������������������������������������������
						If !_lStatus //Se nao rodou o update
							_lStatus := U_AtuStatus("S","","","","",_cTributac,,,,ZLE->ZLE_DTINI,ZLE->ZLE_DTFIM)
						EndIf

						//���������������������������������������������������Ŀ
						//� Se houve alguma falha, desfaz todas as transacoes.�
						//�����������������������������������������������������
						If lDeuErro
							lContinue := .F.
							DisarmTransaction()
							lDeuErro := .F.
						EndIf

						//����������������������������������������������������������Ŀ
						//� Finaliza o controle de transacao, caso nao hajam falhas. �
						//������������������������������������������������������������
					End Transaction
				Else

					xMagHelpFix("Aprovacao",;
						"O Produtor "+cxForn+"-"+cxLoja+" nao esta preparado para finalizar!",;
						"Efetue a autorizacao de acerto no Mix para esse Produtor em todas as linhas/rotas! ")
					lContinue := .F.

				EndIf // se isPreparad

				// Seta numero da parcela como 01 (by Abrahao em 02/02/2009)
				_cTamParc  := StrZero(1,TamSx3("E2_PARCELA")[1])

				If !lContinue
					If MsgYesNo("Ocorreram n�o conformidades no processo. Deseja continuar a rotina?")
						lContinue:=.T.
					Else
						lContinue:=.F.
					EndIf
				EndIf

				If !lContinue
					exit
				EndIf

				nCont++

				(cArqTmp)->(dbSkip())

			EndDo

		EndIf


		//�����������������������������������Ŀ
		//� Altera o Status da ZLE.           �
		//�������������������������������������
		cQry := "SELECT"
		cQry += " COUNT(*) AS QTD,
		cQry += " ZLF_ACERTO FROM "
		cQry += RetSqlName("ZLF") + " "
		cQry += "WHERE"
		cQry += " D_E_L_E_T_ = ' '"
		cQry += " AND ZLF_CODZLE = '" + cCodMIX  + "'"
		cQry += " AND ZLF_VERSAO = '" + _cVersao  + "' "
		cQry += "GROUP BY"
		cQry += " ZLF_ACERTO"

		TCQUERY cQry NEW ALIAS("GLT44")

		dbSelectArea("GLT44")
		GLT44->(dbGoTop())

		While GLT44->(!Eof())
				/*
				//�������������������������������������������������������������Ŀ
				//�Verifica se foram encontrados registros sem efetuar o acerto.�
				//���������������������������������������������������������������
				*/
			If GLT44->ZLF_ACERTO == 'N' .And. GLT44->QTD > 0

				_lNoAcerto:= .T.
					/*
					//������������������������������������������������������������������������Ŀ
					//�Verifica se foram encontrados registros que ja foram efetuados o acerto.�
					//��������������������������������������������������������������������������
					*/
			ElseIf GLT44->ZLF_ACERTO == 'S' .And. GLT44->QTD > 0

				_lYesAcert:= .T.

			EndIf

			GLT44->(dbSkip())
		EndDo

		dbSelectArea("GLT44")
		GLT44->(dbCloseArea())

		RecLock("ZLE",.F.)

			/*
			//��������������������������������������������������������������Ŀ
			//�Indica um Mix parcialmente fechado, ou seja, possui fechamento�
			//�e alguns fretistas ou produtores sem efetuar o fechamento.    �
			//����������������������������������������������������������������
			*/
		If _lNoAcerto .And. _lYesAcert

			ZLE->ZLE_STATUS := 'P'

				/*
				//�������������������������������������������
				//�Mix que se encontra totalmente em aberto.�
				//�������������������������������������������
				*/
		ElseIf _lNoAcerto .And. !_lYesAcert

			ZLE->ZLE_STATUS := 'A'

				/*
				//���������������������������������������Ŀ
				//�Mix que se encontra totalmente fechado.�
				//�����������������������������������������
				*/
		ElseIf !_lNoAcerto .And. _lYesAcert

			ZLE->ZLE_STATUS := 'F'

		EndIf

		ZLE->(MsUnLock())



		oObjProc:SaveLog("FIM - ACERTO DO LEITE")

	Else
		xMagHelpFis("NAO CONFORMIDADE 09 - MIX nao encontrado.",;
			"O MIX informado nos par�metros n�o foi encontrado!",;
			"Escolha um c�digo de MIX que exista.")
	EndIf

	(cArqTmp)->(DbCloseArea())

	MsgInfo("Tempo gasto no processamento:"+ELAPTIME(cHoraInicial,TIME()))

	//�������������������������������������������������������������������Ŀ
	//�Verifica se alguma nota fiscal foi gerada para imprimir o intervalo�
	//�inicial e final.                                                   �
	//���������������������������������������������������������������������
	If Len(AllTrim(_cNumPriNF)) > 0

		MsgInfo("O n�mero da(s) nota(s) inicial e final gerada(s) ao(s) produtor(es):" + _ENTER + _ENTER +;
		"N.F. Inicial: " + AllTrim(_cNumPriNF) + '/'+ _cSerie + _ENTER +;
		"N.F. Final  : " + AllTrim(_cNumUltNF) + '/'+ _cSerie,"Alerta")

	EndIf

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    � GrvNfPro � Autor �Microsiga              � Data � 00.00.00 ���
�������������������������������������������������������������������������Ĵ��
���Descricao � Funcao p/ realizar o Acerto Fiscal( Geracao da NF Produtor)���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Parametros� ExpO01 - Objeto da Regua de processamento.                 ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MGLT009()                                                  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function GrvNfPro(oObj)

	Local cFunc    := "2" //Codigo da Qry a ser executada
	Local cArqTmp  := cGLTalias+cFunc
	Local cItem    := "0001"
	Local cParcSE2 := Space(TamSx3("E2_PARCELA")[1])
	Local nPeso	:= 0
	Local nDescto  := 0
	Local nCont    := 1
	Local nTotReg  := 0
	Local _aCab    := {}
	Local _aItens  := {}
	Local _aArea   := {}
	Local _aAlias  := {}
	Local cSeekZLF := ""
	Local cSeekSD1 := ""
	Local nTotalNF := 0
	Local cCondPgt := ZL2->ZL2_CONDPG //AllTrim(GETMV("LT_CODPGTO"))
	Local aAreaSA2 := SA2->(GetArea())
	Local cTes     := ""
	Local cTesTrib     := ZL2->ZL2_TESTRI //AllTrim(GETMV("LT_TESTRIB")) //TES tributada com ICMS
	Local cTesDife     := ZL2->ZL2_TESDIF //AllTrim(GETMV("LT_TESDIFE")) //TES diferida de ICMS
	Local cTesDiSe     := ZL2->ZL2_TESDIS //AllTrim(GETMV("LT_TESDISE")) //TES Diferido sem c�lculo de Funrural, somente SENAR
	Local cTesIsen     := ZL2->ZL2_TESISE //AllTrim(GETMV("LT_TESISEN")) //TES isenta de ICMS
	Local _cNatureza 	:= IIF(SA2->A2_TIPO <> "J",ZL2->ZL2_NATURE,ZL2->ZL2_NATUPJ)
	Local nPosProd := 0
	Local cProdSB1 := ZL2->ZL2_PRODUT
	Local _nTotalSD1 := 0
	Local _nModAnt := nModulo
	Local _cModAnt := cModulo
	Local _lGerouNF := .F.
	Local ix		:= 0
	Private nQtde  := 0
	Private nVlrUnit := 0
	Private lMsErroAuto:= .F.
	Private lMsHelpAuto:= .T.

	//����������������Ŀ
	//�  Salva a area. �
	//������������������
	CtrlArea(1,@_aArea,@_aAlias,{"SA2","SB1","ZL2","ZL8","ZLF","SF1","SD1","SX1"})


	//�����������������������������������Ŀ
	//� Atualiza o log de processamento   �
	//�������������������������������������
	oObj:SaveLog("INICIO - Nota por Produtor - "+SA2->A2_COD +"/"+SA2->A2_LOJA)

	//��������������������������������������������Ŀ
	//� Chama funcao para criar tabela Temporaria. �
	//����������������������������������������������

	MGLT5QRY(cFunc)

	//�����������������������������������Ŀ
	//� Atualiza a regua de processamento.�
	//�������������������������������������
	If oObj <> Nil
		nTotReg := _nReg
		oObj:SetRegua2(nTotReg)
	EndIf

	//�����������������������������������Ŀ
	//� Pega o Numero da proxima Nota.    �
	//�������������������������������������
	If Len(AllTrim(_cNroNota)) == 0
		_cNroNota := NxtSX5Nota(_cSerie)
		_cNroNota := IIF(Len(_cNroNota)<9,_cNroNota+"   ",_cNroNota)
	EndIf

	//����������������������������������������������������������������Ŀ
	//�Tratamento efetuado para armazenar o numero da primeira e       �
	//�ultima nota do produtor, para que seja poss�vel emitir no final �
	//�do fechamento estas numeracoes ao usuario.                      �
	//������������������������������������������������������������������
	If Len(AllTrim(_cNumPriNF)) == 0

		_cNumPriNF:= _cNroNota

	EndIf

	_cNumUltNF:= _cNroNota


	//��������������������������������������������������������������������������������������Ŀ
	//� Chama funcao para calcular o desconto gerado pela penalizacao(Redutor) da qualidade. �
	//����������������������������������������������������������������������������������������
	dbSelectArea(cArqTmp)
	dbGoTop()


	//��������������������������������������������������������������������������������������Ŀ
	//� Calcula o desconto da NF, FUNRURAL E FRETE DE DESCONTO                               �
	//����������������������������������������������������������������������������������������

	dbSelectArea("ZL8")
	ZL8->(dbSetOrder(1))//ZL8_FILIAL+ZL8_COD

	If SA2->A2_TIPO == "J" //Se pessoa juridica a NF � diferida
		cTes := cTesDife
		_cTributac := "D"
	ElseIf SA2->A2_L_TRIBU == "T"
		cTes := cTesTrib
		_cTributac := "T"
	ElseIf SA2->A2_L_TRIBU == "D" .and. (SA2->A2_L_INSS == 'S' .and. SA2->A2_L_SENAR == 'S')
		cTes := cTesDife
		_cTributac := "D"
	ElseIf SA2->A2_L_TRIBU == "D" .and. (SA2->A2_L_INSS == 'N' .and. SA2->A2_L_SENAR == 'S')
		cTes := cTesDiSe
		_cTributac := "D"
	ElseIf SA2->A2_L_TRIBU == "I"
		cTes := cTesIsen
		_cTributac := "I"
	Else
		cTes := cTesIsen
		_cTributac := "I"
	EndIf

	//��������������������������������������Ŀ
	//� Cabecalho da Nota Fiscal( SigaAuto). �
	//����������������������������������������
	_aCab :={;
		{"F1_TIPO"      ,"N"			  ,NIL},;	// Tipo da Nota = Normal
	{"F1_FORMUL"	,"S"		      ,NIL},;	// Formulario Proprio = Sim.
	{"F1_DOC"		,_cNroNota        ,NIL},;	// Numero do Documento.
	{"F1_SERIE"		,_cSerie 	      ,NIL},;	// Serie do Documento.
	{"F1_PREFIXO"	,_cPrefixo 	      ,NIL},;	// Serie do Documento.
	{"F1_EMISSAO"	,dDataBase	      ,NIL},;	// Data de Emissao.
	{"F1_DESPESA"	,0			      ,NIL},;	// Despesa
	{"F1_FORNECE"	,SA2->A2_COD	  ,NIL},;	// Codigo do Fornecedor.
	{"F1_LOJA"	  	,SA2->A2_LOJA 	  ,NIL},;	// Loja do Fornecedor.
	{"F1_ESPECIE"	,_cTpNF    	      ,NIL},;	// Especie do Documento.
	{"F1_COND"		,cCondPgt         ,NIL},;	// Condicao de Pagamento.
	{"F1_SEGURO"	,0	    	      ,NIL},;	// Seguro
	{"F1_FRETE"		,0	    	      ,NIL},;	// Frete
	{"F1_DESCONT"	,nDescto          ,NIL},;   // Desconto (FUNRURAL + FRETE)
	{"F1_PESOL"		,0	              ,NIL},;	// Peso Liquido
	{"F1_HORA"		,Left(Time(),5)   ,NIL},;	// Hora de gera��o da NF.
	{"E2_NATUREZ"	,_cNatureza       ,NIL}}	// Natureza do titulo a pagar.

	dbSelectArea(cArqTmp)
	dbGoTop()
	While (cArqTmp)->(!Eof())


		_nTotalSD1 := (cArqTmp)->ZLF_TOTAL - _pnGetRedut


		//�����������������������������������Ŀ
		//� Atualiza a regua de processamento.�
		//�������������������������������������
		If oObj <> Nil
			oObj:IncRegua2("Nota Fiscal - Item "+AllTrim(Str(nCont))+" de "+AllTrim(Str(nTotReg)))
			nCont++
		EndIf


		//�����������������������Ŀ
		//� Cadastro de Produtos. �
		//�������������������������
		dbSelectArea("SB1")
		SB1->(dbSetOrder(1))
		If SB1->(MsSeek(xFilial("SB1") + cProdSB1 ))

			nQtde    := If((cArqTmp)->ZLF_QTDBOM>0,(cArqTmp)->ZLF_QTDBOM,1)
			cSeekSD1 := _cFilEvent + _cNroNota + _cSerie + SA2->A2_COD + SA2->A2_LOJA + SB1->B1_COD + cItem
			nPeso := SB1->B1_PESO

			cSeekZLF := GrvZLF((cArqTmp)->ZLF_EVENTO,0,cSeekSD1,.F.,.T.,(cArqTmp)->ZLF_SEQ,"GrvNfPro","",0,0,CTOD(""),"",0,0,SA2->A2_COD,SA2->A2_LOJA,"",cFilAnt,.F.)

			//Se o array esta vazio entao zera a variavel para adicionar os dados no array;
				//caso contrario verifica se o produto ja existe no array;
				//Se existir apenas soma-se os valores, senao adiciona o novo produto no array.
			If Len(_aItens) == 0
				nPosProd := 0
			Else
				nPosProd := ASCAN(_aItens,{|x| ALLTRIM(x[2][2]) == ALLTRIM(SB1->B1_COD)})
			EndIf

			//Se o produto nao existe no Array adiciona, caso contrario so incrementa valor
			If nPosProd == 0
				aAdd(_aItens,{;
				{"D1_ITEM"      ,cItem				          ,NIL},;	// Sequencia Item Pedido
				{"D1_COD"		,SB1->B1_COD         		  ,NIL},;	// Codigo do Produto
				{"D1_QUANT"		,nQtde						  ,NIL},;	// Quantidade
				{"D1_VUNIT"		,0							  ,NIL},;	// Valor Unitario
				{"D1_TOTAL"		,_nTotalSD1			          ,NIL},;	// Valor Total
				{"D1_TES"		,cTes		     			  ,NIL},;	// Tipo de Entrada - TES
				{"D1_LOCAL"		,SB1->B1_LOCPAD				  ,NIL},;	// Armazem Padrao do Produto
				{"D1_SEGURO"	,0							  ,NIL},;	// Seguro
				{"D1_VALFRE"	,0							  ,NIL},;	// Frete
				{"D1_DESPESA"	,0							  ,NIL},;	// Despesa
				{"D1_L_SEEK"	,cSeekZLF		              ,NIL}})	// Chave de pesquisa da SD1 na ZLF

				cItem    := SOMA1(cItem)
			Else
				_aItens[nPosProd,5,2] += (cArqTmp)->ZLF_TOTAL

			EndIf

			nTotalNf += (cArqTmp)->ZLF_TOTAL
		Else

			lDeuErro := .T.
			oObj:SaveLog("ERRO 06 - Produto "+AllTrim(cProdSB1)+" / Produtor "+AllTrim(SA2->A2_COD+SA2->A2_LOJA) )

			xMagHelpFis("NAO CONFORMIDADE 10 - Produto nao encontrado",;
				"Produto "+AllTrim(cProdSB1)+" n�o existe no cadastro!",;
				"Nao sera gerado Nota Fiscal para o produtor "+SA2->A2_COD+SA2->A2_LOJA)
			_aCab    := {}
			_aItens  := {}

		EndIf

		(cArqTmp)->(dbSkip())
	EndDo

	//�������������������������������������������������������������������������Ŀ
	//�                                                                         �
	//� Arredondamento de unitario e total.                                     �
	//�                                                                         �
	//���������������������������������������������������������������������������
	ix:= 0
	If Len(_aCab)>0 .And. Len(_aItens)>0
		For ix:= 1 to Len(_aItens)
			_aItens[ix,5,2]  := NoRound(_aItens[ix,5,2],2)		// Define D1_TOTAL com 2 casas
			_aItens[ix,4,2]  := (_aItens[ix,5,2] / _aItens[ix,3,2])// Divide D1_TOTAL por D1_QUANT para obter D1_VUNIT
		Next ix
	EndIf

	//Altera o modulo para compras para incluir a nota
	nModulo := 2
	cModulo := "COM"



	If _lUsaSA5 //Valida se ir� criar amarra��o Produto X Fornecedor
		CriaSA5(SA2->A2_COD, SA2->A2_LOJA,cProdSB1)
	EndIf

	//�����������������������������������Ŀ
	//� SigaAuto de Geracao da Nota.      �
	//�������������������������������������
	If Len(_aCab)>0 .And. Len(_aItens)>0 .and. _aItens[1,5,2]>0 .and. _aItens[1,4,2]>0

		Pergunte("MTA103",.F.)//Chama os parametros da rotina para nao gerar erro
		MATA103(_aCab,_aItens,3)
		Pergunte(_cPerg,.F.)
		If lMsErroAuto
			lDeuErro := .T.
			oObj:SaveLog("ERRO 07 - SIGAAUTO DE NOTA")

			MostraErro()
		Else

			dbSelectArea("SF1")
			SF1->(dbSetOrder(1))//F1_FILIAL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_TIPO
			If SF1->(MsSeek(xFilial("SF1") + _cNroNota + _cSerie + SA2->A2_COD + SA2->A2_LOJA + "N"))
				RecLock("SF1",.F.)
				SF1->F1_PLIQUI	:= nQtde * nPeso
				SF1->F1_PBRUTO	:= nQtde * nPeso
				SF1->F1_VOLUME1	:= nQtde
				SF1->F1_ESPECI1 := "LITROS"

				SF1->F1_L_MIX	:= cCodMix
				SF1->F1_L_SETOR	:= ZL2->ZL2_COD//Nao esta posicionado na ZL2
				SF1->(MsUnlock())
				_cPrefixo := SF1->F1_PREFIXO

				// Atualiza informa��es na tabela ZLF.
				GrvF1Seek(SA2->A2_COD, SA2->A2_LOJA, cCodMix, "1", ZL2->ZL2_COD, _cNroNota, _cSerie )

				If Len(_aNfOri) = 3
					dbSelectArea("SD1")
					SD1->(dbSetOrder(1))//D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEM
					If SD1->(MsSeek(xFilial("SD1") + _cNroNota + _cSerie + SA2->A2_COD + SA2->A2_LOJA + SB1->B1_COD + "0001"))
						RecLock("SD1",.F.)
						SD1->D1_NFORI	:= _aNfOri[1]
						SD1->D1_SERIORI	:= _aNfOri[2]
						SD1->D1_ITEMORI := _aNfOri[3]
						SD1->(MsUnlock())
					EndIf
				EndIf
				_lGerouNF := .T.
			Else
				xMagHelpFis("Nota nao econtrada","Nao foi possivel encontrar NF "+_cNroNota+" Serie:"+_cSerie,"Consulte Suporte!"+xFilial("SF1")+_cNroNota+_cSerie+SA2->A2_COD+SA2->A2_LOJA+"N")
				lDeuErro := .T.
			EndIf

		EndIf
	Else

		xMagHelpFis("Dados incompletos","Dados incompletos para gerar NF do Produtor "+SA2->A2_COD,"Comunique ao Suporte!")
		lDeuErro := .T.

	EndIf


	//���������������������������Ŀ
	//� Restaura o modulo em uso. �
	//�����������������������������
	nModulo := _nModAnt
	cModulo := _cModAnt



	RestArea(aAreaSA2)
	If _lGerouNF
		dbSelectArea("SE2")
		SE2->(dbSetOrder(1))
		If SE2->(MsSeek(xFilial("SE2") + _cPrefixo + _cNroNota + cParcSE2 + "NF " + SA2->A2_COD + SA2->A2_LOJA))

			/*
			//������������������������������������������������������������������Ŀ
			//�Incluido, devido ao valor                                         �
			//�do incentivo na ZLF ser somente uma simulacao, sendo que o real   �
			//�valor do incentivo eh gerado na insercao do documento de entrada  �
			//�ja considerando os redutores desta forma o valor a ser considerado�
			//�tem que ser o da SE2.                                             �
			//��������������������������������������������������������������������
			*/
			_nSldPro := Round(SE2->E2_SALDO,2)

			RecLock("SE2",.F.)

			SE2->E2_L_MIX   := cCodMix
			SE2->E2_L_VERSA := _cVersao
			SE2->E2_HIST    := "NOTA DE PRODUTOR"
			SE2->E2_L_SETOR := ZL2->ZL2_COD


			If SA2->A2_L_TPPAG == "B"
				SE2->E2_L_TPPAG := SA2->A2_L_TPPAG
				SE2->E2_L_BANCO := SA2->A2_BANCO
				SE2->E2_L_AGENC := SA2->A2_AGENCIA
				SE2->E2_L_CONTA := SA2->A2_NUMCON
				SE2->E2_PORTADO := SA2->A2_BANCO
			EndIf

			MsUnlock()

		Else

			xMagHelpFix("Titulo",;
				"A NF do Produtor nao gerou o titulo no Financeiro!",;
				"Verifique se a TES gera Duplicata ou se as configura��es de s�rie e condi��o de pagamento est�o corretas no cadastro de setor!")
			lDeuErro := .T.

		EndIf
	Else
		xMagHelpFix("NF N�O GERADA",;
			"N�o foi gerada NF do Produtor!",;
			"Verifique se os par�metros padr�es de fechamento de estoque MV_ULMES e MV_DBLQMOV est�o com datas igual ou maior que fechamento.")
			lDeuErro := .T.
	EndIf

	//�����������������������������������Ŀ
	//� Atualiza o log de processamento   �
	//�������������������������������������

	oObj:SaveLog("FIM - Nota por Produtor - " + SA2->A2_COD + "/" + SA2->A2_LOJA)

	//������������������Ŀ
	//� Restaura a area. �
	//��������������������
	CtrlArea(2,_aArea,_aAlias)

	//�����������������������������������Ŀ
	//� Apaga arquivo temporario.         �
	//�������������������������������������
	dbSelectArea(cArqTmp)
	(cArqTmp)->(dbCloseArea())

Return

/*******************************************************************
* GetNFOri() Fun��o que busca notas de origem para preencher na SD1
* Utilizado para estado de Rio Grande do Sul
****************************************************************/
Static Function GetNFOri()

	Local _aRet := {}
	Local _cDtOrFi := DTOS(DaySum(ZLE->ZLE_DTFIM,15))

	Local _cFiltro := "% D1_EMISSAO BETWEEN '"+DTOS(ZLE->ZLE_DTINI)+"' AND '"+_cDtOrFi+"' AND D1_L_MIXOR = '"+cCodMix+"' %"

	BeginSql alias "NFORI"
	SELECT D1_DOC, D1_SERIE ,D1_ITEM
	FROM %Table:SD1% SD1
	WHERE D1_FILIAL = %XFILIAL:SD1%
	AND D1_FORNECE = %Exp:SA2->A2_COD%
	AND D1_LOJA = %Exp:SA2->A2_LOJA%
	AND SD1.%NotDel%
	AND %Exp:_cFiltro%
	EndSql

	If !NFORI->(Eof())
		AADD(_aRet,NFORI->D1_DOC)
		AADD(_aRet,NFORI->D1_SERIE)
		AADD(_aRet,NFORI->D1_ITEM)
	EndIf

	NFORI->(DbCloseArea())

Return _aRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    � ActMix   � Autor �Microsiga              � Data � 00.00.00 ���
�������������������������������������������������������������������������Ĵ��
���Descricao � Funcao para realizar o Acerto dos Eventos de Debito e      ���
���          � gerados na ZLF pelo Mix.                                   ���
�������������������������������������������������������������������������Ĵ��
���Parametros� ExpO01 - Objeto da Regua de processamento.                 ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MGLT009()                                                  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ActMix(oObj)

	Local cFunc    := "3"
	Local cArqTmp  := cGLTalias+cFunc
	Local _aArea   := {}
	Local _aAlias  := {}
	Local nTotReg  := 0
	Local nCont    := 1
	Local nVlrEvto := 0
	Local cNroTit  := _cNroNota//Usa o nro da nota do produtor como nro do titulo
	Local cParc    := StrZero(1,TamSx3("E2_PARCELA")[1]) //Parcela do titulo do evento
	Local cSeekZLF := ""

	If Empty(cNroTit)  //Caso n�o seja gerada NF, cria um c�digo para os t�tulos (acontece com pessoa jur�dica)
		cNroTit:= Substr(SA2->A2_COD,2,5)+RIGHT(cCodMix,3)+StrZero(Val(_cVersao),1)
	EndIf

	//����������������Ŀ
	//�  Salva a area. �
	//������������������
	CtrlArea(1,@_aArea,@_aAlias,{"SA2","ZL2","SB1","ZL8","ZLF","SF1","SD1","SX1"})

	//�����������������������������������Ŀ
	//� Atualiza o log de processamento   �
	//�������������������������������������
	oObj:SaveLog("INICIO - Acerto Mix - "+SA2->A2_COD +"/"+SA2->A2_LOJA)

	//�����������������������������������������������������������������������������������������Ŀ
	//� Cria tabela temporaria com os dados dos Eventos(ZL8) para filtrar posteriormente o SE2. �
	//�������������������������������������������������������������������������������������������
	MsgRun("Aguarde.... Filtrando dados dos Eventos do Mix...",,{||CursorWait(), MGLT5QRY(cFunc), CursorArrow()})

	nTotReg := _nReg

	//�����������������������������������Ŀ
	//� Atualiza contador de registros    �
	//�������������������������������������
	oObj:SetRegua2(nTotReg)


	dbSelectArea(cArqTmp)
	dbGoTop()

	While (cArqTmp)->(!Eof())

		//�����������������������������������Ŀ
		//� Atualiza a regua de processamento.�
		//�������������������������������������
		If oObj <> Nil
			oObj:IncRegua2("Eventos Deb. Mix - Tarefa "+AllTrim(Str(nCont))+" de "+AllTrim(Str(nTotReg)))
			nCont++
		EndIf

		//�����������������������������������Ŀ
		//� Posiciona no cadastro de Eventos. �
		//�������������������������������������
		dbSelectArea("ZL8")
		ZL8->(dbSetOrder(1))
		ZL8->(MsSeek(xFilial("ZL8")+(cArqTmp)->ZL8_COD))

		//����������������������������������������������������Ŀ
		//� Busca o valor do Evento na ZLF e grava no titulo.  �
		//������������������������������������������������������
		nVlrEvto := Round((cArqTmp)->ZLF_TOTAL,2)

		If nVlrEvto > 0

			//����������������������������������������������������������������������������������������������������Ŀ
			//� Altera o registro na ZLF de Debito referente ao valor do evento lido.                              �
			//������������������������������������������������������������������������������������������������������

			cSeekZLF := GrvZLF(ZL8->ZL8_COD,0,cCodMIX+_cFil_SE2+ZL8->ZL8_PREFIX+cNroTit+cParc+_cTipoTit+SA2->A2_COD+SA2->A2_LOJA,.F.,.T.,(cArqTmp)->ZLF_SEQ,"ActMix","",nVlrEvto,nVlrEvto,dDataBase,AllTrim(ZL8->ZL8_DESCRI),0,0,SA2->A2_COD,SA2->A2_LOJA,"",cFilAnt,.F.)
			//����������������������������������������������������������������������������������������������������Ŀ
			//� Inclui o titulo relacionado ao evento lido.                                                        �
			//������������������������������������������������������������������������������������������������������

			U_IncluSE1(ZL8->ZL8_PREFIX,cNroTit,cParc,_cTipoTit,SA2->A2_COD,SA2->A2_LOJA,ZL8->ZL8_NATPRD,ZLE->ZLE_DTFIM,dBaixa,nVlrEvto,0,0,,ZL8->ZL8_DESCRI,NoRound(nTxPar,2),ZL8->ZL8_COD,"MGLT009",_cAno+_cMes,cFilAnt,cCodMIX)

		EndIf

		//������������������Ŀ
		//� Restaura a area. �
		//��������������������
		CtrlArea(2,_aArea,_aAlias)

		(cArqTmp)->(dbSkip())
	EndDo

	//�����������������������������������Ŀ
	//� Atualiza o log de processamento   �
	//�������������������������������������

	oObj:SaveLog("FIM - Acerto Mix - "+SA2->A2_COD +"/"+SA2->A2_LOJA)

	//�����������������������������������Ŀ
	//� Apaga arquivo temporario.         �
	//�������������������������������������
	dbSelectArea(cArqTmp)
	(cArqTmp)->(dbCloseArea())

	//������������������Ŀ
	//� Restaura a area. �
	//��������������������
	CtrlArea(2,_aArea,_aAlias)

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    � ActEvento� Autor �Microsiga              � Data � 00.00.00 ���
�������������������������������������������������������������������������Ĵ��
���Descricao � Funcao para realizar o Acerto dos Eventos Avulsos.         ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Parametros� ExpO01 - Objeto da Regua de processamento.                 ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MGLT009()                                                  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ActEvento(oObj)

	Local cFunc    := "4"
	Local cArqTmp  := cGLTalias+cFunc
	Local _aArea   := {}
	Local _aAlias  := {}
	Local nTotReg  := 0
	Local nCont    := 1
	Local nVlrEvto := 0
	Local cNroTit  := _cNroNota//Usa o nro da nota do produtor como nro do titulo
	Local cParc    := StrZero(1,TamSx3("E2_PARCELA")[1]) //Parcela do titulo do evento
	Local cSeekZLF := ""
	Local cSeek := ""

	If Empty(cNroTit)  //Caso n�o seja gerada NF, cria um c�digo para os t�tulos (acontece com pessoa jur�dica)
		cNroTit:= Substr(SA2->A2_COD,2,5)+RIGHT(cCodMix,3)+StrZero(Val(_cVersao),1)
	EndIf


	//����������������Ŀ
	//�  Salva a area. �
	//������������������
	CtrlArea(1,@_aArea,@_aAlias,{"SA2","SB1","ZL8","ZLF","SF1","SD1","SX1"})

	//�����������������������������������Ŀ
	//� Atualiza o log de processamento   �
	//�������������������������������������
	oObj:SaveLog("INICIO - Acerto Evento - "+SA2->A2_COD +"/"+SA2->A2_LOJA)


	MGLT5QRY(cFunc)

	nTotReg := _nReg

	//�����������������������������������Ŀ
	//� Atualiza contador de registros    �
	//�������������������������������������
	oObj:SetRegua2(nTotReg)

	dbSelectArea(cArqTmp)
	dbGoTop()

	While (cArqTmp)->(!Eof())

		//�����������������������������������Ŀ
		//� Atualiza a regua de processamento.�
		//�������������������������������������
		If oObj <> Nil
			oObj:IncRegua2("Eventos - Tarefa "+AllTrim(Str(nCont))+" de "+AllTrim(Str(nTotReg)))
			nCont++
		EndIf


		//�����������������������������������Ŀ
		//� Posiciona no cadastro de Eventos. �
		//�������������������������������������
		dbSelectArea("ZL8")
		ZL8->(dbSetOrder(1))
		ZL8->(MsSeek(xFilial("ZL8") + (cArqTmp)->ZL8_COD))

		//����������������������������������������������������Ŀ
		//� Verifica se a condicao do Evento eh satisfatoria.  �
		//������������������������������������������������������
		If &(ZL8->ZL8_CONDIC)

			//����������������������������������������������������Ŀ
			//� Busca o valor a ser gravado no Evento e no titulo. �
			//������������������������������������������������������
			nVlrEvto := &(ZL8->ZL8_FORMUL)
			nVlrEvto := Round(nVlrEvto,2) //Arredondo pra nao dar erro na baixa do SE2

			If nVlrEvto > 0

				ZL8->(MsSeek(xFilial("ZL8") + (cArqTmp)->ZL8_COD)) //Posiciona novamente a ZL8, pois a condi��o do evento pode ter desposicionado.


				//����������������������������������������������������������������������������������������������������Ŀ
				//� Inclui um registro na ZLF de Debito referente ao valor do evento lido.                             �
				//������������������������������������������������������������������������������������������������������

				//�����������������������������������������������������������������������������Ŀ
				//�A linha logo abaixo foi comentada,                                           �
				//�para que o tipo da tributacao do evento seja passado na sua geracao e retirar�
				//�o campo ZL3->ZL3_COD referente a linha que nao tem mais                      �
				//�posicionamento no fechamento do produtor.                                    �
				//�������������������������������������������������������������������������������

				_cHistor := AllTrim(ZL8->ZL8_DESCRI)

				//Tratamento para informar o volume de litros que estao sendo descontados na penalidade de crioscopia.
				If ZL8->ZL8_COD = "050001"
					_nVlCrio := U_CRIOSCOPIA(3,SA2->A2_COD,SA2->A2_LOJA,ZLE->ZLE_DTFIM)
					_cHistor := _cHistor +" ("+cValTochar(_nVlCrio)+" litros)"
				EndIf

				cSeek := cCodMIX+_cFil_SE2+ZL8->ZL8_PREFIX+cNroTit+cParc+_cTipoTit+SA2->A2_COD+SA2->A2_LOJA+SA2->A2_LOJA


				cSeekZLF := GrvZLF(ZL8->ZL8_COD,nVlrEvto,cSeek,.T.,.F.,,"ActEvento","",nVlrEvto,nVlrEvto,dDataBase,_cHistor,0,0,SA2->A2_COD,SA2->A2_LOJA,_cTributac,cFilAnt,.F.)

				//����������������������������������������������������������������������������������������������������Ŀ
				//� Inclui o titulo relacionado ao evento lido.                                                        �
				//������������������������������������������������������������������������������������������������������
				If ZL8->ZL8_COD <> "060005" // nao gera titulo de credito associa��o, pois foi adicionado no valor da nota
					If ZL8->ZL8_DEBCRE=="C"
						IncluiSE2(oObj,nVlrEvto,ZL8->ZL8_PREFIX,cNroTit,cParc,_cTipoTit,ZL8->ZL8_DESCRI,cSeekZLF,"ActEvento",ZL8->ZL8_NATFRT,ZL8->ZL8_COD)
					Else
						U_IncluSE1(ZL8->ZL8_PREFIX,cNroTit,cParc,_cTipoTit,SA2->A2_COD,SA2->A2_LOJA,ZL8->ZL8_NATPRD,ZLE->ZLE_DTFIM,dBaixa,nVlrEvto,0,0,,_cHistor,NoRound(nTxPar,2),ZL8->ZL8_COD,"MGLT009",_cAno+_cMes,cFilAnt,cCodMIX)
					EndIf
				EndIf

			EndIf
		EndIf

		(cArqTmp)->(dbSkip())
	EndDo

	//�����������������������������������Ŀ
	//� Atualiza o log de processamento   �
	//�������������������������������������
	oObj:SaveLog("FIM - Acerto Evento - "+SA2->A2_COD +"/"+SA2->A2_LOJA)

	//�����������������������������������Ŀ
	//� Apaga arquivo temporario.         �
	//�������������������������������������
	dbSelectArea(cArqTmp)
	(cArqTmp)->(dbCloseArea())

	//������������������Ŀ
	//� Restaura a area. �
	//��������������������
	CtrlArea(2,_aArea,_aAlias)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    �MGLT5QRY  � Autor �Microsiga              � Data � 00.00.00 ���
�������������������������������������������������������������������������Ĵ��
���Descricao � Funcao para executar querys e gerar arquivo temporario com ���
���          � o resultado da query.                                      ���
�������������������������������������������������������������������������Ĵ��
���Parametros� ExpC01 - Caracter que identifica a query a ser chamada de  ���
���          �          acordo com a rotina de Acerto em execucao.        ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MGLT009()                                                  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function MGLT5QRY(cOpc,cPrefSE2,cCodEve)

	//���������������������������������Ŀ
	//� Declaracao de variavies locais. �
	//�����������������������������������
	Local cQry   := ""
	Local lSqlOk := .T.
	Local _nVlrAux := 0

	DEFAULT cPrefSE2 := ""

	Do Case
		//�������������������������������������������������������������Ŀ
		//� Deleta os registros gerados na ZLF pela rotina de Acerto.   �
		//���������������������������������������������������������������
	Case cOpc == "0"
		cQry := "DELETE FROM"
		cQry += " " + RETSQLNAME("ZLF")
		cQry += " WHERE D_E_L_E_T_ = ' '"
		cQry += " AND ZLF_FILIAL = '" + xFilial("ZLF") 	+ "'"
		cQry += " AND ZLF_CODZLE = '" + cCodMIX			+ "'"
		cQry += " AND ZLF_VERSAO = '" + _cVersao			+ "'"
		cQry += " AND ZLF_A2COD  BETWEEN '" + _cProdDe +"' AND '"+ cProdAte +"'"//Alterado em 09/07/10
		cQry += " AND ZLF_A2LOJA BETWEEN '" + cLojaDe +"' AND '"+ cLojaAte +"'"//Alterado em 09/07/10
		cQry += " AND ZLF_LINROT BETWEEN '" + cRotaDe +"' AND '"+ cRotaAte +"'"//Alterado em 09/07/10
		cQry += " AND ZLF_ORIGEM =  'F'" //So deleta originados pela rotina do Acerto
		cQry += " AND ZLF_ACERTO <> 'S'" //Deleta se nao realizou acerto definitivo
		cQry += " AND ZLF_TP_MIX = 'L' " //Deleta apenas registros do leite

		If !Empty(_cSetores) //Se o parametro com os setores estiver vazio considera todos.
			cQry += " AND ZLF_SETOR IN (" + U_AjustSet(_cSetores) + ")"
		EndIf

		lSqlOk := !(TCSqlExec(cQry) < 0)

		If lSqlOk .and.  (TcGetDB() == 'ORACLE')
			lSqlOk := !(TCSqlExec(" COMMIT ") < 0)
		EndIf


		If !lSqlOk
			xMagHelpFis("NAO CONFORMIDADE 12 - NO DELETE",;
				TcSqlError(),;
				"Verifique a Sintaxe da Query de DELETE.")
		EndIf

		//�������������������������������������������������������������Ŀ
		//� Filtra os produtores do MIX para iniciar o processamento.   �
		//���������������������������������������������������������������
	Case cOpc == "1"

		//�����������������������������������������������������������Ŀ
		//�Alterado pode-se ter mais �
		//�de um setor dentro da mesma filial de fechamento.          �
		//�������������������������������������������������������������
		cQry := "SELECT ZLF_FILIAL, "
		cQry += "        ZLF_SETOR, "
		cQry += "        ZLF_A2COD, "
		cQry += "        ZLF_A2LOJA, "
		cQry += "        ZLF_A2NOME, "
		cQry += "        ZLF_LINROT, "
		cQry += "        SUM(VLEITE) AS VLEITE, "
		cQry += " 	   SUM(CREDITO)  AS CREDITO, "
		cQry += "        Sum(DEBITO)   AS DEBITO "
		cQry += "        FROM ( "

		cQry += " SELECT ZLF_FILIAL,ZLF_SETOR,ZLF_A2COD,ZLF_A2LOJA,ZLF.ZLF_A2NOME,ZLF_QTDBOM AS VLEITE,ZLF_LINROT,"
		cQry += " SUM(Case WHEN ZL8_DEBCRE = 'C'"
		cQry += "        THEN ZLF_TOTAL"
		cQry += "        Else 0"
		cQry += "     END) AS CREDITO,"
		cQry += " SUM(Case WHEN ZL8_DEBCRE = 'D'"
		cQry += "        THEN ZLF_TOTAL"
		cQry += "        Else 0"
		cQry += "     END) AS DEBITO"
		cQry += " FROM "+RetSqlName("ZLF")+" ZLF, "+RetSqlName("ZL8")+" ZL8, "+RetSqlName("SA2")+" SA2"
		cQry += " WHERE ZL8.ZL8_MSBLQL <> '1'"
		cQry += " AND ZLF.ZLF_FILIAL = '" +xFilial("ZLF")+ "'"
		cQry += " AND ZL8.ZL8_FILIAL = '" +xFilial("ZL8")+ "'"
		cQry += " AND SA2.A2_FILIAL = '"  +xFilial("SA2")+ "'"
		If !Empty(_cSetores) //Se o parametro com os setores estiver vazio considera todos.
			cQry += " AND ZLF.ZLF_SETOR IN (" + U_AjustSet(_cSetores) + ")"
		EndIf
		cQry += " AND ZLF.ZLF_A2COD BETWEEN  '" + _cProdDe +"' AND '"+ cProdAte +"'"
		cQry += " AND ZLF.ZLF_A2LOJA BETWEEN '" + cLojaDe +"' AND '"+ cLojaAte +"'"
		cQry += " AND ZLF.ZLF_LINROT BETWEEN '" + cRotaDe +"' AND '"+ cRotaAte +"'"
		cQry += " AND ZLF.ZLF_CODZLE = '" + cCodMIX + "'"
		cQry += " AND ZLF.ZLF_VERSAO = '" + _cVersao + "'"
		cQry += " AND SA2.A2_L_TPFOR = 'P'"
		cQry += " AND ZLF.ZLF_ACERTO <> 'S'"//Nao tiveram acerto
		cQry += " AND ZLF.ZLF_ORIGEM = 'M'"	//ZLF gerada pelo Mix
		cQry += " AND ZLF.ZLF_TP_MIX = 'L'" //Tipo do Mix igual a Leite
		cQry += " AND ZL8.ZL8_COD NOT IN ('" + _cFunrural + "')" //N�o considera evento INSS pois o c�lculo do Funrual � padr�o
		cQry += " AND ZLF.ZLF_EVENTO = ZL8.ZL8_COD"
		cQry += " AND ZLF.ZLF_A2COD  = SA2.A2_COD"
		cQry += " AND ZLF.ZLF_A2LOJA = SA2.A2_LOJA"
		cQry += " AND ZLF.D_E_L_E_T_ = ' '"
		cQry += " AND ZL8.D_E_L_E_T_ = ' '"
		cQry += " AND SA2.D_E_L_E_T_ = ' '"
		cQry += " GROUP BY ZLF.ZLF_FILIAL,ZLF.ZLF_SETOR,ZLF.ZLF_A2NOME,ZLF.ZLF_A2COD,ZLF.ZLF_A2LOJA,ZLF_QTDBOM,ZLF_LINROT"
		cQry += " UNION ALL "
		cQry += " SELECT '"+xFilial("ZLF")+"' AS ZLF_FILIAL, ZL3_SETOR AS ZLF_SETOR, SA2.A2_COD AS ZLF_A2COD, SA2.A2_LOJA AS ZLF_A2LOJA, "
		cQry += " SA2.A2_NOME AS ZLF_A2NOME, 0  AS VLEITE, SA2.A2_L_LI_RO AS ZLF_LINROT,"
		cQry += " 0 AS CREDITO, "
		cQry += " 0 AS DEBITO "
		cQry += " FROM "+RetSqlName("ZM3")+" ZM3 "
		cQry += " JOIN "+RetSqlName("SA2")+" SA2 ON A2_COD = ZM3.ZM3_CODSA2 AND A2_LOJA = ZM3.ZM3_LOJA AND SA2.D_E_L_E_T_ = ' ' "
		cQry += " JOIN "+RetSqlName("ZL3")+" ZL3 ON ZL3.ZL3_COD = SA2.A2_L_LI_RO  "
		cQry += " 	AND ZL3_COD BETWEEN '" + cRotaDe +"' AND '"+ cRotaAte +"'"
		cQry += " 	AND ZL3.D_E_L_E_T_ = ' '"
		cQry += " JOIN "+RetSqlName("ZL8")+" ZL8 ON ZL8_COD = '060005' AND ZL8.D_E_L_E_T_ = ' ' "
		cQry += " WHERE  (ZM3_DESCLT > 0 OR ZM3_DESCVL > 0)  "
		cQry += " AND ZM3_CODSA2 BETWEEN  '" + _cProdDe +"' AND '"+ cProdAte +"' "
		cQry += " AND ZM3_LOJA BETWEEN '" + cLojaDe +"' AND '"+ cLojaAte +"' "
		cQry += " AND ZM3.D_E_L_E_T_ = ' ' "
		cQry += " ) "
		cQry += " GROUP  BY ZLF_FILIAL,"
		cQry += "           ZLF_SETOR,"
		cQry += "           ZLF_A2NOME,"
		cQry += "           ZLF_A2COD,"
		cQry += "           ZLF_A2LOJA,"
		cQry += "           ZLF_LINROT       "
		cQry += " ORDER BY ZLF_A2NOME "

		If Select(cGLTalias+cOpc)<> 0
			dbSelectArea(cGLTalias+cOpc)
			(cGLTalias+cOpc)->(DbCloseArea())
		EndIf

		TCQUERY cQry NEW ALIAS (cGLTalias+cOpc)
		dbSelectArea(cGLTalias+cOpc)
		Count To _nReg

		//���������������������������������Ŀ
		//� Acerto Fiscal(Gera NF Produtor).�
		//�����������������������������������
	Case cOpc == "2"
		cQry := "SELECT ZLF_EVENTO,ZLF_SEQ,ZLF_QTDBOM,ZLF_TOTAL,ZLF_TRIBUT"
		cQry += " FROM "+RetSqlName("ZLF")
		cQry += " WHERE D_E_L_E_T_ = ' '"
		cQry += " AND ZLF_FILIAL = '" + xFilial("ZLF")	+ "'"
		cQry += " AND ZLF_CODZLE = '" + cCodMIX		   	+ "'"
		cQry += " AND ZLF_VERSAO = '" + _cVersao			+ "'"
		cQry += " AND ZLF_A2COD  = '" + SA2->A2_COD		+ "'"
		cQry += " AND ZLF_A2LOJA = '" + SA2->A2_LOJA	+ "'"
		cQry += " AND ZLF_SETOR  = '" + ZL2->ZL2_COD	+ "'"
		cQry += " AND ZLF_ORIGEM <> 'F'" //Somente registros gerados por rotinas diferentes do Acerto.
		cQry += " AND ZLF_ACERTO <> 'S'" //Somente registros que nao tiveram acerto.
		cQry += " AND ZLF_TP_MIX = 'L'"  //Somente registros do tipo Leite, exceto Frete.
		cQry += " AND ZLF_DEBCRE = 'C'"   //Somente movimentos de credito

		If !Empty(SA2->A2_L_CODAS) .and. SA2->A2_L_ASSOC == 'S'
			cQry += " UNION ALL "

			cQry += " SELECT '060005' AS ZLF_EVENTO, '001' AS ZLF_SEQ, 1 AS ZLF_QTDBOM,
			_nVlrAux := U_CREDASSOC(SA2->A2_L_CODAS,cCodMIX)

			cQry += " "+Alltrim(cValToChar(_nVlrAux))+" AS	ZLF_TOTAL,'T' AS ZLF_TRIBUT "
			cQry += " FROM "+RetSqlName("ZM3")+" ZM3 "
			cQry += " WHERE  (ZM3_DESCLT > 0 OR ZM3_DESCVL > 0)  "
			cQry += " AND ZM3_CODSA2 =  '" + SA2->A2_COD +"'  "
			cQry += " AND ZM3_LOJA = '" + SA2->A2_LOJA +"' "
			cQry += " AND ZM3.D_E_L_E_T_ = ' ' "

		EndIf

		cQry += " ORDER BY ZLF_SEQ, ZLF_EVENTO "
		TCQUERY cQry NEW ALIAS (cGLTalias+cOpc)
		dbSelectArea(cGLTalias+cOpc)
		Count To _nReg

		//�������������������������������������������Ŀ
		//� Acerto MIX (Le ZLF e gera e baixa SE2).   �
		//� Sao eventos do tipo Leite porem de Debito.�
		//� Sao eventos Incluidos pela rotina do Mix. �
		//���������������������������������������������
	Case cOpc == "3"
		cQry := "SELECT ZLF_EVENTO,ZLF_SEQ,ZL8_COD,ZLF_TOTAL,ZL8_NATPRD FROM "
		cQry += RetSqlName("ZLF")+" ZLF, "+RetSqlName("ZL8")+" ZL8"
		cQry += " WHERE ZLF.D_E_L_E_T_ = ' '"
		cQry += " AND ZL8.D_E_L_E_T_ = ' '"
		cQry += " AND ZL8.ZL8_MSBLQL <> '1'"
		cQry += " AND ZLF.ZLF_FILIAL = '" + xFilial("ZLF")	+ "'"
		cQry += " AND ZL8.ZL8_FILIAL = '" + xFilial("ZL8")	+ "'"
		cQry += " AND ZLF.ZLF_CODZLE = '" + cCodMIX			+ "'"
		cQry += " AND ZLF.ZLF_VERSAO = '" + _cVersao			+ "'"
		cQry += " AND ZLF.ZLF_SETOR  = '" + ZL2->ZL2_COD	+ "'"
		cQry += " AND ZLF.ZLF_A2COD  = '" + SA2->A2_COD		+ "'"
		cQry += " AND ZLF.ZLF_A2LOJA = '" + SA2->A2_LOJA	+ "'"
		cQry += " AND ZLF.ZLF_EVENTO = ZL8.ZL8_COD"
		cQry += " AND ZLF.ZLF_ORIGEM = 'M'"  //M-> incluido pelo MIX
		cQry += " AND ZLF.ZLF_DEBCRE = 'D'"  //Somente Debito
		cQry += " AND ZLF.ZLF_ACERTO <> 'S'" //Nao foi realizado acerto
		cQry += " AND ZLF.ZLF_TP_MIX = 'L'"  //L para Mix de Leite, F para Mix de Frete
		cQry += " AND ZL8.ZL8_PREFIX <> ' '" //Prefixo diferente de vazio
		cQry += " AND ZL8.ZL8_TPEVEN <> 'R'" //Nao considera os redutores de qualidade

		TCQUERY cQry NEW ALIAS (cGLTalias+cOpc)
		dbSelectArea(cGLTalias+cOpc)
		Count To _nReg

		//�����������������������������������Ŀ
		//� Acerto Eventos Automatico.        �
		//�������������������������������������
	Case cOpc == "4"
		cQry := "SELECT ZL8_COD,ZL8_NATPRD FROM " + RetSqlName("ZL8")
		cQry += " WHERE D_E_L_E_T_ = ' ' "
		cQry += " AND ZL8_FILIAL = '" + xFilial("ZL8") + "'"
		cQry += " AND ZL8_TPEVEN = 'A'" //Evento Automatico
		cQry += " AND ZL8_DEBCRE IN ('C','D')" //Evento de Debito
		cQry += " AND ZL8_PREFIX <> ' '"//Prefixo diferente de vazio
		cQry += " AND ZL8_MSBLQL <> '1'"//Evento n�o bloqueado
		cQry += " ORDER BY ZL8_PRIORI"
		TCQUERY cQry NEW ALIAS (cGLTalias+cOpc)
		dbSelectArea(cGLTalias+cOpc)
		Count To _nReg

		//"��������������������������������������������������Ŀ
		//� Acerto Financeiro - Eventos de d�bitos( 1 de 2 ). �
		//�����������������������������������������������������
	Case cOpc == "5"
		cQry := "SELECT ZL8_COD,ZL8_DESCRI,ZL8_PREFIX FROM "+RetSqlName("ZL8")
		cQry += " WHERE D_E_L_E_T_ = ' ' "
		cQry += " AND ZL8_FILIAL = '" + xFilial("ZL8")+ "'"
		cQry += " AND ZL8_MSBLQL <> '1'"
		cQry += " AND ZL8_TPEVEN = 'F'" //Eventos Financeiros
		cQry += " AND ZL8_DEBCRE = 'D'" //Evento de Debito
		cQry += " AND ZL8_PREFIX <> ' '"//Prefixo diferente de vazio
		cQry += " ORDER BY ZL8_PRIORI"
		TCQUERY cQry NEW ALIAS (cGLTalias+cOpc)
		dbSelectArea(cGLTalias+cOpc)
		Count To _nReg

		//"��������������������������������������������������Ŀ
		//� Acerto Financeiro - Eventos de cr�dito( 1 de 2 ). �
		//�����������������������������������������������������
	Case cOpc == "5B"
		cQry := "SELECT ZL8_COD,ZL8_DESCRI,ZL8_PREFIX FROM "+RetSqlName("ZL8")
		cQry += " WHERE D_E_L_E_T_ = ' ' "
		cQry += " AND ZL8_FILIAL = '" + xFilial("ZL8")+ "'"
		cQry += " AND ZL8_MSBLQL <> '1'"
		cQry += " AND ZL8_TPEVEN = 'F'" //Eventos Financeiros
		cQry += " AND ZL8_DEBCRE = 'C'" //Evento de Debito
		cQry += " AND ZL8_PREFIX <> ' '"//Prefixo diferente de vazio
		cQry += " ORDER BY ZL8_PRIORI"
		TCQUERY cQry NEW ALIAS (cGLTalias+cOpc)
		dbSelectArea(cGLTalias+cOpc)
		Count To _nReg


		//�����������������������������������������Ŀ
		//� Acerto Financeiro - Titulos( 2 de 2 ).  �
		//�������������������������������������������
	Case cOpc == "6A"
		cQry := "SELECT E2_FILIAL,E2_PREFIXO,E2_NUM,E2_PARCELA,E2_TIPO,E2_FORNECE,E2_LOJA,E2_SALDO,E2_VENCTO,E2_NATUREZ,E2_MOEDA,"
		cQry += " E2_VALOR,E2_VALJUR,E2_PORCJUR,E2_EMISSAO,E2_TXMOEDA,E2_BAIXA,E2_DECRESC,E2_ACRESC FROM "+RetSqlName("SE2")
		cQry += " WHERE D_E_L_E_T_ = ' '"

		//��������������������������������������������������������������Ŀ
		//�A filial foi comentada pois  �
		//�terao que ser considerados os debitos de todas as filiais nao �
		//�somente da filial de fechamento.                              �
		//����������������������������������������������������������������
		//cQry += " AND E2_FILIAL  = '" +xFilial("SE2")+ "'"
		cQry += " AND E2_PREFIXO = '" + cPrefSE2    			+ "'"
		cQry += " AND E2_TIPO = 'NDF'" //Somente titulos de Debito do Produtor
		cQry += " AND E2_SALDO   > 0"  //Somente titulos em aberto ou baixados parcialmente
		cQry += " AND E2_EMISSAO <= '" + DtoS(ZLE->ZLE_DTFIM) 	+ "'"
		cQry += " AND E2_VENCTO <= '"  + _cVencto   			+ "'"
		cQry += " AND E2_FORNECE = '"  + SA2->A2_COD 			+ "'"
		cQry += " AND E2_LOJA    = '"  + SA2->A2_LOJA			+ "'"
		cQry += " AND E2_L_EVENT = '" + cCodEve    			+ "'"

		cQry += " ORDER BY E2_VENCTO, E2_SALDO"
		TCQUERY cQry NEW ALIAS (cGLTalias+cOpc)
		dbSelectArea(cGLTalias+cOpc)
		Count To _nReg

		//�����������������������������������������Ŀ
		//� Acerto Lojas - Titulos( 2 de 2 ).       �
		//�������������������������������������������
	Case cOpc == "6B"
		cQry := "SELECT E2_FILIAL,E2_PREFIXO,E2_NUM,E2_PARCELA,E2_TIPO,E2_FORNECE,E2_LOJA,E2_SALDO,E2_VENCTO,E2_NATUREZ,E2_MOEDA,"
		cQry += " E2_VALOR,E2_VALJUR,E2_PORCJUR,E2_EMISSAO,E2_TXMOEDA,E2_BAIXA,E2_DECRESC,E2_ACRESC FROM "+RetSqlName("SE2")
		cQry += " WHERE D_E_L_E_T_ = ' '"

		//��������������������������������������������������������������Ŀ
		//�A filial foi comentada pois  �
		//�terao que ser considerados os debitos de todas as filiais nao �
		//�somente da filial de fechamento.                              �
		//����������������������������������������������������������������
		cQry += " AND E2_PREFIXO = '"	+ cPrefSE2				+ "'"
		cQry += " AND E2_TIPO = 'NDF'" //Somente titulos de Debito do Produtor
		cQry += " AND E2_SALDO   > 0"  //Somente titulos em aberto ou baixados parcialmente
		cQry += " AND E2_EMISSAO <= '" + DtoS(ZLE->ZLE_DTFIM) 	+ "'"
		cQry += " AND E2_VENCTO <= '"  + _cVencto				+ "'"
		cQry += " AND E2_FORNECE = '"  + SA2->A2_COD			+ "'"//Filtra somente o codigo, para compensar todas as lojas

		//���������������������������������������������������������������������Ŀ
		//�Alterado para que fossem baixados   �
		//�os titulos com vencimento primeiro por questoes de cobranca de juros.�
		//�����������������������������������������������������������������������
		//cQry += " ORDER BY E2_FORNECE,E2_LOJA,E2_SALDO,E2_VENCTO"

		cQry += " ORDER BY E2_VENCTO,E2_LOJA"
		TCQUERY cQry NEW ALIAS (cGLTalias+cOpc)
		dbSelectArea(cGLTalias+cOpc)
		Count To _nReg

		//����������������������������������������������������������������Ŀ
		//� Filtra os produtores do MIX para incluir os titulos do 2o Mix. �
		//������������������������������������������������������������������
	Case cOpc == "7"

		cQry := "SELECT ZLF_EVENTO,ZL8_PREFIX,ZLF_SEQ,ZLF_SETOR,ZLF_LINROT,SUM(ZLF_TOTAL) AS CREDITO"
		cQry += " FROM "+RetSqlName("ZLF")+" ZLF, "+RetSqlName("ZL8")+" ZL8"
		cQry += " WHERE ZLF.D_E_L_E_T_ = ' '"
		cQry += " AND ZL8.D_E_L_E_T_ = ' '"
		cQry += " AND ZL8.ZL8_MSBLQL <> '1'"
		cQry += " AND ZLF.ZLF_FILIAL = '" +xFilial("ZLF")+ "'"
		cQry += " AND ZL8.ZL8_FILIAL = '" +xFilial("ZL8")+ "'"
		If !Empty(_cSetores) //Se o parametro com os setores estiver vazio considera todos.
			cQry += " AND ZLF.ZLF_SETOR IN (" + U_AjustSet(_cSetores) + ")"
		EndIf
		cQry += " AND ZLF.ZLF_CODZLE = '" + cCodMIX + "'"
		cQry += " AND ZLF.ZLF_VERSAO = '" + _cVersao + "'"
		cQry += " AND ZLF.ZLF_A2COD  = '" + SA2->A2_COD + "'"
		cQry += " AND ZLF.ZLF_A2LOJA = '" + SA2->A2_LOJA + "'"
		If TcGetDB() == 'ORACLE'
			cQry += " AND SubStr(ZLF.ZLF_A2COD,1,1) = 'P'"
		Else
			cQry += " AND SubString(ZLF.ZLF_A2COD,1,1) = 'P'"
		EndIf
		cQry += " AND ZLF.ZLF_ACERTO <> 'S'" //Nao tiveram acerto
		cQry += " AND ZLF.ZLF_ORIGEM = 'M'"	 //ZLF gerada pelo Mix
		cQry += " AND ZLF.ZLF_TP_MIX = 'L'"  //Tipo do Mix igual a Leite
		cQry += " AND ZLF.ZLF_DEBCRE = 'C'"
		cQry += " AND ZLF.ZLF_EVENTO = ZL8.ZL8_COD"
		cQry += " AND ZL8.ZL8_IMPNF = 'N'"   //Somente eventos que nao sao impressos na Nota.
		cQry += " AND ZL8.ZL8_DEBCRE = 'C'"  //Somente eventos de Credito.
		cQry += " GROUP BY ZLF_EVENTO,ZL8_PREFIX,ZLF_SEQ,ZLF_SETOR,ZLF_LINROT"
		cQry += " ORDER BY ZLF_SETOR,ZLF_LINROT"
		TCQUERY cQry NEW ALIAS (cGLTalias+cOpc)
		dbSelectArea(cGLTalias+cOpc)
		Count To _nReg

	EndCase

Return()

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    � IncluiSE2� Autor � Microsiga             � Data � 00.00.00 ���
�������������������������������������������������������������������������Ĵ��
���Descricao � Inclui titulo no contas a pagar via SigaAuto.              ���
�������������������������������������������������������������������������Ĵ��
���Parametros� ExpO01 - Objeto da regua de Processamento.                 ���
���          � ExpN02 - Valor do titulo a ser incluido.                   ���
���          � ExpC03 - Prefixo do titulo a ser incluido.                 ���
���          � ExpC04 - Numero do titulo a ser incluido.                  ���
���          � ExpC05 - Parcela do titulo a ser incluido.                 ���
���          � ExpC06 - Tipo do titulo a ser incluido.                    ���
���          � ExpC07 - Historico do titulo a ser incluido.               ���
���          � ExpC08 - Chave de pesquisa para vincular o titulo na ZLF.  ���
���          � ExpC09 - Nome da Static Function que chamou a IncluiSE2(). ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � GENERICO                                                   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function IncluiSE2(oObj,nVlrTit,_cPrefixo,cNroTit,cParcela,cTipo,_cHistTit,cSeek,cFunName,cNatz,xcEvento)

	Local _nModAnt  := nModulo
	Local _cModAnt  := cModulo
	Local aAutoSE2 := {}
	Local lNoExist := .T.
	Local nVlTxPer := If(cTipo=="NDF",GetMv("LT_TXPER "),0)//Se eh debito do produtor, grava valor da Taxa de Permanencia para cobrar juros.
	Local cBcoSA2  := ""
	Local _dbkpData:= dDataBase

	Private lMsErroAuto:= .F.
	Private lMsHelpAuto:= .T.

	DEFAULT cSeek := ""

	//������������������������������������������������������������������������������Ŀ
	//�Todos os titulo incluidos na tabela SE2 devem ser incluidos no ultimo dia     �
	//�referente ao intervalo de fechamento do mix, isto se faz necessario pelo fato �
	//�das baixas serem realizadas no ultimo dia de pagamento para calculo de juros. �
	//��������������������������������������������������������������������������������
	dDataBase:= ZLE->ZLE_DTFIM

	//�����������������������������������������������������������������������Ŀ
	//� Verifica se o tipo do titulo eh NF e se o tipo de pagamento eh banco, �
	//� caso afirmativo, grava o portador.                                    �
	//�������������������������������������������������������������������������
	If cTipo=="NF "//Tipo do Titulo = NF
		If SA2->A2_L_TPPAG == "B"//Tipo de pagamento B=Banco;C=Cheque;D=Dinheiro
			cBcoSA2 := SA2->A2_BANCO
		Else
			cBcoSA2 := ""
		EndIf
	EndIf

	//������������������������������������������������������������Ŀ
	//� Verifica se o titulo ja existe na base, para nao duplicar. �
	//��������������������������������������������������������������
	dbSelectArea("SE2")
	SE2->(dbSetOrder(1))
	If SE2->(MsSeek(xFilial("SE2") + _cPrefixo + cNroTit + cParcela + cTipo + SA2->A2_COD + SA2->A2_LOJA))
		lDeuErro := .T.
		oObj:SaveLog("ERRO 12 - TITULO DUPLICADO - "+cFunName)

		xMagHelpFis("NAO CONFORMIDADE 16 - TITULO DUPLICADO",;
			"O titulo "+xFilial("SE2")+_cPrefixo+cNroTit+cParcela+cTipo+;
			" ja existe para o produtor"+SA2->A2_COD+"/"+SA2->A2_LOJA+"-"+SA2->A2_NOME,;
			"Verifique no financeiro porque ja existe um titulo com estas caracteristicas e exclua-o.")
		lNoExist:=.F.
		If MsgYesNo("Deseja gerar o titulo como nova parcela?")
			cParcela:=soma1(cParcela)
			_cTamParc:=cParcela
			lNoExist:=.T.
			lDeuErro:=.F.
		EndIf
	EndIf

	If lNoExist


		//������������������������������������������������������Ŀ
		//� Array com os dados a serem passados para o SigaAuto. �
		//��������������������������������������������������������
		aAutoSE2:={;
			{"E2_PREFIXO",_cPrefixo       		,Nil},;
			{"E2_NUM"    ,cNroTit        		,Nil},;
			{"E2_TIPO"   ,cTipo          		,Nil},;
			{"E2_PARCELA",cParcela       		,Nil},;
			{"E2_NATUREZ",cNatz    		  		,Nil},;
			{"E2_PORTADO",cBcoSA2        		,Nil},;
			{"E2_FORNECE",SA2->A2_COD    		,Nil},;
			{"E2_LOJA"   ,SA2->A2_LOJA   		,Nil},;
			{"E2_EMISSAO",dDataBase      		,Nil},;
			{"E2_VENCTO" ,STOD(_cVencto)  		,Nil},;
			{"E2_VENCREA",STOD(_cVencto)  		,Nil},;
			{"E2_HIST"   ,_cHistTit       		,Nil},;
			{"E2_VALOR"  ,nVlrTit        		,Nil},;
			{"E2_PORCJUR",nVlTxPer       		,Nil},;
			{"E2_DATALIB",dDataBase      		,Nil},;
			{"E2_USUALIB",AllTrim(cUserName)	,Nil},;
			{"E2_L_SETOR",ZL2->ZL2_COD   		,Nil},;
			{"E2_L_MIX"  ,cCodMIX        		,Nil},;
			{"E2_L_VERSA",_cVersao        		,Nil},;
			{"E2_L_SITUA","I"            		,Nil},;
			{"E2_L_SEEK" ,cSeek          		,Nil},;
			{"E2_L_EVENT" ,xcEvento          	,Nil}}


		//���������������������������������������������������������������Ŀ
		//� Altera o modulo para Financeiro, senao o SigaAuto nao executa.�
		//�����������������������������������������������������������������
		nModulo := 6
		cModulo := "FIN"

		//����������������������������������������������Ŀ
		//�Roda SigaAuto de inclusao de Titulos a Pagar. �
		//������������������������������������������������
		Pergunte("FIN050",.F.) //Chama perguntas da rotina FINA050 para evitar erros na execu��o do sigaauto.

		MSExecAuto({|x,y| Fina050(x,y)},aAutoSE2,3)


		Pergunte(_cPerg,.F.) //Restaura perguntas da fun��o principal


		//���������������������������Ŀ
		//� Restaura o modulo em uso. �
		//�����������������������������
		nModulo := _nModAnt
		cModulo := _cModAnt

		//��������������������������������������������������������������Ŀ
		//� Verifica se houve erro no SigaAuto, caso haja mostra o erro. �
		//����������������������������������������������������������������
		If lMsErroAuto

			lDeuErro := .T.

			oObj:SaveLog("ERRO 13 - SIGAAUTO INCLUSAO TITULO - "+cFunName)

			xMagHelpFis("INFORMA��O",;
				"Erro na inclus�o do t�tulo: " + cNroTit + '\' + cParcela + ' Prefixo\Tipo: '+ _cPrefixo + '\' + cTipo + "do Produtor: " + SA2->A2_COD + '\' + SA2->A2_LOJA,;
				"Favor copiar esta mensagem e informar ao departamento de inform�tica")

			Mostraerro()

		Else

			dbSelectArea("SE2")
			SE2->(dbSetOrder(1))
			If SE2->(MsSeek(xFilial("SE2") + _cPrefixo + cNroTit + cParcela + cTipo + SA2->A2_COD +SA2->A2_LOJA))

				RecLock("SE2",.F.)

				If SA2->A2_L_TPPAG == "B"

					SE2->E2_L_TPPAG	:= SA2->A2_L_TPPAG
					SE2->E2_L_BANCO	:= SA2->A2_BANCO
					SE2->E2_L_AGENC := SA2->A2_AGENCIA
					SE2->E2_L_CONTA	:= SA2->A2_NUMCON

				EndIf

				SE2->(MsUnlock())

			EndIf

		EndIf
	EndIf

	//����������������������������������������������������������������������Ŀ
	//�Restaura a database antes de iniciar o processo de inclusao do titulo.�
	//������������������������������������������������������������������������
	dDataBase:= _dbkpData

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    � LastZLF  � Autor �Microsiga              � Data � 00.00.00 ���
�������������������������������������������������������������������������Ĵ��
���Descricao � Funcao para retornar o ultimo sequencial + 1 da ZLF.       ���
�������������������������������������������������������������������������Ĵ��
���Parametros� Nenhum.                                                    ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � GENERICO                                                   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function LastZLF()

	Local _cSeq := ""
	Local cQry := ""

	cQry := "SELECT MAX(ZLF_SEQ) AS COD FROM "+RetSqlName("ZLF")
	cQry += " WHERE D_E_L_E_T_ = ' '"
	cQry += " AND ZLF_FILIAL = '" + xFILIAL("ZLF") + "'"
	cQry += " AND ZLF_CODZLE = '" + cCodMIX        + "'"
	cQry += " AND ZLF_VERSAO = '" + _cVersao       + "'"
	cQry += " AND ZLF_A2COD  = '" + SA2->A2_COD    + "'"
	cQry += " AND ZLF_A2LOJA = '" + SA2->A2_LOJA   + "'"
	TCQUERY cQry NEW ALIAS "GLT99"
	dbSelectArea("GLT99")

	If GLT99->(!Eof())
		_cSeq := SOMA1(GLT99->COD)
	EndIf

	dbSelectArea("GLT99")
	GLT99->(dbCloseArea())

Return(_cSeq)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CtrlArea � Autor � Microsiga          � Data �  00/00/00   ���
�������������������������������������������������������������������������͹��
���Descricao � Static Function auxiliar no GetArea e ResArea retornando   ���
���          � o ponteiro nos Aliases descritos na chamada da Funcao.     ���
���          � Exemplo:                                                   ���
���          � Local _aArea  := {} // Array que contera o GetArea         ���
���          � Local _aAlias := {} // Array que contera o                 ���
���          �                     // Alias(), IndexOrd(), Recno()        ���
���          �                                                            ���
���          � // Chama a Funcao como GetArea                             ���
���          � P_CtrlArea(1,@_aArea,@_aAlias,{"SL1","SL2","SL4"})         ���
���          �                                                            ���
���          � // Chama a Funcao como RestArea                            ���
���          � P_CtrlArea(2,_aArea,_aAlias)                               ���
�������������������������������������������������������������������������͹��
���Parametros� nTipo   = 1=GetArea / 2=RestArea                           ���
���          � _aArea  = Array passado por referencia que contera GetArea ���
���          � _aAlias = Array passado por referencia que contera         ���
���          �           {Alias(), IndexOrd(), Recno()}                   ���
���          � _aArqs  = Array com Aliases que se deseja Salvar o GetArea ���
�������������������������������������������������������������������������͹��
���Uso       � GENERICO                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function CtrlArea(_nTipo,_aArea,_aAlias,_aArqs)

	Local _nN := 0

	// Tipo 1 = GetArea()
	If _nTipo == 1
		_aArea := GetArea()
		For _nN := 1 To Len(_aArqs)
			dbSelectArea(_aArqs[_nN])
			AAdd(_aAlias,{ _aArqs[_nN], IndexOrd(), Recno() })
		Next
		// Tipo 2 = RestArea()
	Else
		For _nN := 1 To Len(_aAlias)
			dbSelectArea(_aAlias[_nN,1])
			dbSetOrder(_aAlias[_nN,2])
			DbGoto(_aAlias[_nN,3])
		Next
		RestArea(_aArea)
	EndIf

Return

/*/
	�������������������������������������������������������������������������������������������������������������������������������
	�������������������������������������������������������������������������������������������������������������������������������
	���������������������������������������������������������������������������������������������������������������������������ͻ��
	���Programa  �isPreparad� Autor � Microsiga             � Data da Criacao  � 09/02/2009                						���
	���������������������������������������������������������������������������������������������������������������������������͹��
	���Descricao � Verifica se o produtor esta preparado para acerto                                                            ���
	���          �                        									                               				        ���
	���������������������������������������������������������������������������������������������������������������������������͹��
	���Uso       � Fechamento do Leite.            						                                                        ���
	���������������������������������������������������������������������������������������������������������������������������͹��
	���Parametros� Mix,Versao,Filial,Setor,Linha,Produtor,Loja									          						���
	���������������������������������������������������������������������������������������������������������������������������͹��
	���Retorno   � .T. ou .F.		  							                               									���
	���������������������������������������������������������������������������������������������������������������������������͹��
	���Usuario   � Microsiga                                                                                					���
	���������������������������������������������������������������������������������������������������������������������������͹��
	���Setor     � Gestao do Leite.                                                                        						���
	���������������������������������������������������������������������������������������������������������������������������͹��
	���            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                   						���
	���������������������������������������������������������������������������������������������������������������������������͹��
	���Autor     � Data     � Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor        ���
	���������������������������������������������������������������������������������������������������������������������������ĺ��
	���          �          �                                                  �                                  �   	        ���
	���----------�----------�--------------------------------------------------�----------------------------------�-------------���
	���          �          �                    							   �                                  � 			���
	���----------�----------�--------------------------------------------------�----------------------------------�-------------���
	���������������������������������������������������������������������������������������������������������������������������ͼ��
	�������������������������������������������������������������������������������������������������������������������������������
	�������������������������������������������������������������������������������������������������������������������������������
/*/
Static Function isPreparad(cpNumMix,cpVersao,cpFilial,cpSetor,cpLinha,cpRetiro,cpLjRet,cxTribu)

	Local aArea  := GetArea()
	Local bRet   :=.F.
	Local nAbert := 0
	Local nPrep  := 0
	Local nFech  := 0

	//���������������������������������������������������������������������Ŀ
	//� Obtem Status agrupados e calcula qtd de cada status                 �
	//�����������������������������������������������������������������������
	cQuery := "SELECT ZLF_STATUS AS CSTATUS,COUNT(*) NUMREG FROM " + RetSqlName("ZLF") + " ZLF "
	cQuery += " WHERE D_E_L_E_T_ = ' '"
	cQuery += " AND ZLF_FILIAL ='" + cpFilial + "'"
	cQuery += " AND ZLF_CODZLE ='" + cpNumMix + "'"
	cQuery += " AND ZLF_TP_MIX = 'L'"
	If !Empty(AllTrim(cpSetor))
		cQuery += " AND ZLF_SETOR = '"  + cpSetor  + "'"
	EndIf
	If !Empty(AllTrim(cpLinha))
		cQuery += " AND ZLF_LINROT = '" + cpLinha  + "'"
	EndIf
	If !Empty(AllTrim(cpRetiro))
		cQuery += " AND ZLF_A2COD = '"  + cpRetiro + "'"
	EndIf
	If !Empty(AllTrim(cpLjRet))
		cQuery += " AND ZLF_A2LOJA = '" +cpLjRet   +"'"
	EndIf
	cQuery += " GROUP BY ZLF_STATUS "

	If Select("TRX") <> 0
		TRX->(dbCloseArea())
	EndIf

	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRX", .T., .F. )

	dbSelectArea("TRX")
	TRX->(dbGoTop())

	While !TRX->(Eof())

		Do Case

		Case TRX->CSTATUS == ""

			nAbert += TRX->NUMREG

		Case TRX->CSTATUS == "A"

			nAbert += TRX->NUMREG

		Case TRX->CSTATUS == "P"

			nPrep:= TRX->NUMREG

		Case TRX->CSTATUS == "F"

			nFech:= TRX->NUMREG

		OtherWise

			nAbert+= TRX->NUMREG

		EndCase

		TRX->(dbSkip())
	EndDo

	TRX->(dbCloseArea())

	If nPrep > 0 .And. nAbert == 0 .And. nFech == 0
		bRet:=.T.
	EndIf

	RestArea(aArea)

Return(bRet)


/*/
	�������������������������������������������������������������������������������������������������������������������������������
	�������������������������������������������������������������������������������������������������������������������������������
	���������������������������������������������������������������������������������������������������������������������������ͻ��
	���Programa  �GetDescNF � Autor �                       � Data da Criacao  � 16/07/2012                						���
	���������������������������������������������������������������������������������������������������������������������������͹��
	���	Descricao� Gera a mensagem que sera impressa na nota fiscal do produtor.												���
	���������������������������������������������������������������������������������������������������������������������������͹��
	���Uso       � Implantacao das rotinas referente a Gestao do Leite.                						                    ���
	���������������������������������������������������������������������������������������������������������������������������͹��
	���Retorno	 � _cMensagem - Mensagem que sera impressa na nota fiscal.                                        				���
	���������������������������������������������������������������������������������������������������������������������������͹��
	���Parametros� _cFil - Filial em que a nota do produtor foi gerada.                                                    		���
	���		     � _cDoc - Numero da nota fiscal                                                                           		���
	���			 � __cSerie - Serie da nota fiscal                                                                          		���
	���			 � _cFornec - Codigo do Produtor                                                                           		���
	���		     � _cLoja   - Loja do Produtor                                                                             		���
	���			 � _nValBruto - Valor bruto da nota fiscal gerada                                                          		���
	���			 � _nValICM   - Valor do ICMS gerado na nota fiscal                                                        		���
	���		     � _cCodMix   - Codigo do mix                                                                              		���
	���			 � _cVersMix  - Versao do mix                                                                             		���
	���			 � _cSetor    - Codigo do Setor                                                                            		���
	���			 � _cTpTribu  - Tipo de Tributacao                                                                        		���
	���������������������������������������������������������������������������������������������������������������������������͹��
	���Usuario   � Microsiga                                                                              					    ���
	���������������������������������������������������������������������������������������������������������������������������͹��
	���Setor     � Gestao do Leite.                                                                        						���
	�������������������������������������������������������������������������������������������������������������������������������
	�������������������������������������������������������������������������������������������������������������������������������
/*/

Static Function GetDescNF(_cFil,_cDoc,__cSerie,_cFornec,_cLoja,_nValBruto,_nValICM,_cCodMix,_cVersMix,_cSetor,_cTpTribu)

	Local aArea 	:= GetArea()
	Local _cAliasSD1:= GetNextAlias()
	Local _cAliasZLF:= ""
	Local _nPreco := 0
	Local _cMensagem:= ""
	Local _nTotDeb  := 0
	Local _nvlFun  := 0
	Local _nvlSen  := 0
	Local _nvlFund	:= 0
	Local _nvlInc  := 0

	dbSelectArea("ZL8")
	ZL8->(dbSetOrder(1))//ZL8_FILIAL+ZL8_COD

	// FUNRURAL
	_nvlFun := SF1->F1_CONTSOC + SF1->F1_INSS
	//SENAR
	_nvlSen := SF1->F1_VLSENAR
	//FUNDESA
	_nvlFund := SF1->F1_VALFUND


	If .T. //_cTpTribu == 'T' .Or. _cTpTribu == 'I'

		BeginSql alias _cAliasSD1
			SELECT
			(SUM(D1_TOTAL) / MAX(D1_QUANT)) PRECO,
			MAX(D1_QUANT) QUANT,
			SUM(D1_VLINCMG) INCENT
			FROM
			%Table:SD1% SD1
			WHERE
			D1_FILIAL  = %Exp:_cFil%
			AND D1_DOC     = %Exp:_cDoc%
			AND D1_SERIE   = %Exp:__cSerie%
			AND D1_FORNECE = %Exp:_cFornec%
			AND D1_LOJA    = %Exp:_cLoja%
			AND SD1.%NotDel%
		EndSql


		dbSelectArea(_cAliasSD1)
		(_cAliasSD1)->(dbGoTop())

		If !(_cAliasSD1)->(Eof())
			_nPreco:= (_cAliasSD1)->PRECO
			_nPreco -= (_nvlFun+_nvlSen+_nvlFund) / (_cAliasSD1)->QUANT

			//INCENTIVO
			_nvlInc := (_cAliasSD1)->INCENT

		EndIf



		dbSelectArea(_cAliasSD1)
		(_cAliasSD1)->(dbGoTop())

		If !(_cAliasSD1)->(Eof())


			_cAliasZLF:= GetNextAlias()

			//�������������������������������������������������������������Ŀ
			//�Query para selecionar os eventos de debito que devem aparecer�
			//�na nota fiscal do produtor, nas informacoes adicionais.      �
			//���������������������������������������������������������������

			BeginSql alias _cAliasZLF
				SELECT
				ZLF.ZLF_EVENTO,
				MAX(ZL8.ZL8_DESCRI) DESCRICAO,
				SUM(ZLF.ZLF_TOTAL) AS DEBITO
				FROM
				%Table:ZLF% ZLF
				JOIN %Table:ZL8% ZL8 ON ZL8.ZL8_COD = ZLF.ZLF_EVENTO
				AND ZL8.ZL8_TPEVEN IN ('A','F') AND ZL8.ZL8_IMPNF = 'S' AND ZL8.%NotDel%

				WHERE
				ZLF.ZLF_FILIAL = %Exp:xFilial("ZLF")%
				AND ZL8.ZL8_FILIAL = %Exp:xFilial("ZL8")%
				AND ZLF.ZLF_A2COD  = %Exp:_cFornec%
				AND ZLF.ZLF_A2LOJA = %Exp:_cLoja%
				AND ZLF.ZLF_CODZLE = %Exp:_cCodMix%
				AND ZLF.ZLF_SETOR  = %Exp:_cSetor%
				AND ZLF.ZLF_DEBCRE = 'D'
				AND ZLF.%NotDel%
				GROUP BY
				ZLF.ZLF_EVENTO
			EndSql

			_cMsgNota := Alltrim(_cMsgNota)
			If Len(_cMsgNota) > 0
				_cMensagem += " "+_cMsgNota+"  "
			EndIf
			If _nvlFun > 0
				_cMensagem += " Retencao Funrural de R$" +Transform(_nvlFun,"@E 999,999.99")+" conforme art. 25 da Lei no 8.212/1991 "+ _ENTER
			EndIf
			If _nvlSen > 0
				_cMensagem += " Valor do SENAR = R$" + AllTrim(Transform(_nvlSen,"@E 999,999.99")) + " "+ _ENTER
			EndIf
			If _nvlFund > 0
				_cMensagem += " Retencao Fundesa de R$ "+Transform(_nvlFund,"@E 999,999.99")+" cfe Lei no 12.380/2005." + _ENTER
			EndIf
			_cMensagem += "referente a leite recebido no periodo de "+dtoc(ZLE->ZLE_DTINI)+" a "+dtoc(ZLE->ZLE_DTFIM) + " "+ _ENTER
			_cMensagem += " Pre�o liquido p/ litro: R$"+ AllTrim(Transform(Round(_nPreco,4),"@E 999.9999")) + _ENTER

			_nTotDeb   += (_nvlFun+_nvlSen+_nvlFund)
			//���������������������������������������������������������������������������������������������Ŀ
			//�Efetua a deducao dos eventos de debito que devem aparecer nas informacoes adicionais da nota.�
			//�����������������������������������������������������������������������������������������������
			dbSelectArea(_cAliasZLF)
			(_cAliasZLF)->(dbGoTop())

			While !(_cAliasZLF)->(Eof())

				_cMensagem += Alltrim((_cAliasZLF)->DESCRICAO) + " = " + AllTrim(Transform((_cAliasZLF)->DEBITO,"@E 999,999,999.99")) + " " + _ENTER
				_nTotDeb   += (_cAliasZLF)->DEBITO

				(_cAliasZLF)->(dbSkip())
			EndDo
			_cMensagem += "Cod. Produtor: " +SA2->A2_COD +"-"+SA2->A2_LOJA+" " + _ENTER
			_cMensagem += "TOT.CRED = " + AllTrim(Transform(_nValBruto,"@E 999,999,999.99")) + " "  + _ENTER
			_cMensagem += "TOT.DEB. = "	+ AllTrim(Transform(_nTotDeb,"@E 999,999,999.99"))   + " " + _ENTER
			_cMensagem += "SALDO = " 	+ AllTrim(Transform(_nValBruto - _nTotDeb,"@E 999,999,999.99")) + _ENTER

			If SM0->M0_ESTENT == 'MG'
				_cMensagem += " Nota fiscal emitida em "+DTOC(Date())+", nos termos do art. 493 da Parte 1 do Anexo IX do RICMS."
			EndIf

			//�������������������������������������Ŀ
			//�Finaliza a area criada anteriormente.�
			//���������������������������������������
			dbSelectArea(_cAliasZLF)
			(_cAliasZLF)->(dbCloseArea())


		EndIf

		dbSelectArea(_cAliasSD1)
		(_cAliasSD1)->(dbCloseArea())

	EndIf

	RestArea(aArea)

Return _cMensagem


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � GetTitPr � Autor � TOTVS              � Data �  07/05/12   ���
�������������������������������������������������������������������������͹��
���Desc.     � Mostra uma lista de titulos existentes no financeiro do    ���
���          � produtor em quest�o.                                       ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Usado para buscar o titulo referente a nota de entrada dos ���
���          � produtores pessoa juridica, que nao tem a nota emitida pelo���
���          � laticinio, ou seja, o proprio produtor/empresa emite a NF. ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GetTitPr()

	Local oDlgTit
	Local lOk      := .F.
	Local lRet     := .F.
	Local cAlias   := GetNextAlias()

	Private oBrt
	Private aDadTit := {}

	cQuery := " SELECT E2_FILIAL,E2_PREFIXO,E2_NUM,E2_PARCELA,E2_TIPO,E2_LOJA,E2_VALOR,E2_FORNECE,E2_LOJA,E2_EMISSAO "
	cQuery += " FROM  " + RetSqlName("SE2") + " SE2 "
	cQuery += " WHERE D_E_L_E_T_ = ' ' "
	cQuery += " AND E2_FILIAL    = '"+ xFilial("SE2") +"'"
	cQuery += " AND E2_FORNECE   = '"+ SA2->A2_COD    +"'"
	cQuery += " AND E2_LOJA      = '"+ SA2->A2_LOJA   +"'"
	cQuery += " AND E2_VENCTO    <='"+ _cVencto        +"'"
	cQuery += " AND E2_TIPO      = 'NF '"
	cQuery += " AND E2_VALOR     > 0 "
	cQuery += " AND E2_SALDO     > 0 "
	cQuery += " AND E2_PREFIXO IN " + FormatIn(AllTrim(GETMV("LT_PRFNOTA")),"\") // Prefixo do Titulo
	cQuery += " ORDER BY E2_EMISSAO DESC "
	TCQUERY cQuery NEW ALIAS(cAlias)

	dbSelectArea(cAlias)
	(cAlias)->(dbGoTop())

	While (cAlias)->(!Eof())
		Aadd(aDadTit,{(cAlias)->E2_FILIAL,(cAlias)->E2_PREFIXO,(cAlias)->E2_NUM,(cAlias)->E2_PARCELA,StoD((cAlias)->E2_EMISSAO),(cAlias)->E2_VALOR})
		(cAlias)->(dbSkip())
	EndDo
	(cAlias)->(dbcloseArea())

	If Len(aDadTit) > 0

		//���������������������������������������������������������������������Ŀ
		//� Tela de Selecao do Titulo                                           �
		//�����������������������������������������������������������������������
		DEFINE MSDIALOG oDlgTit FROM 0,0 TO 220,415 PIXEL TITLE 'SELECAO DO TITULO - PRODUTOR QUE EMITE NOTA A COOPERATIVA'
		@007,005 say "Produtor: "+SA2->A2_COD+"-"+SA2->A2_LOJA+"-"+Left(SA2->A2_NOME,20)+"  R$: "+TransForm(_nSldPro,"@E 999,999,999.99") Pixel Of oDlgTit

		oBrT := VCBrowse():New(020,001,210,70,,{'Filial','Prefixo','Numero','Parcela','Emissao','Valor'},{20,20,30,30,30,30,30}, oDlgTit, ,,,,{||},,,,,,,.F.,,.T.,,.F.,,, )
		oBrT:SetArray(aDadTit)
		If len(aDadTit) > 0
			oBrT:bLine := {||{;
				aDadTit[oBrT:nAt,01], ;
				aDadTit[oBrT:nAt,02], ;
				aDadTit[oBrT:nAt,03], ;
				aDadTit[oBrT:nAt,04], ;
				aDadTit[oBrT:nAt,05], ;
				TransForm(aDadTit[oBrT:nAt,06],"@E 999,999,999,999.99") } }
		EndIf

		TButton():New(095,005, 'Confirmar', oDlgTit,{|| lOk:=.T. , If( VldTit(),oDlgTit:End(),lOk:=.F. )  },40,10,,,,.T.)
		TButton():New(095,060, 'Nenhum'   , oDlgTit,{|| oDlgTit:End()                                       },40,10,,,,.T.)
		ACTIVATE MSDIALOG oDlgTit CENTERED

		If !lOk
			MsgAlert("N�o foi selecionado nenhum Titulo! Logo n�o ser� realizado fechamento deste produtor.")
		Else
			lRet := .T.
		EndIf

	Else

		xMagHelpFis("INFORMA��O",;
			"O produtor: " + SA2->A2_COD + '/' + SA2->A2_LOJA + '-' + SA2->A2_NOME + " emite nota fiscal a cooperativa, no entanto n�o foi encontrada a nota referente ao fechamento corrente.",;
			"Desta forma n�o ser� realizado o fechamento do produtor, favor realizar a inser��o do documento de entrada antes de efetuar o fechamento.")

	EndIf

Return(lRet)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � VldTit   � Autor � TOTVS              � Data �  09/05/12   ���
�������������������������������������������������������������������������͹��
���Desc.     � Verifica se o titulo selecionado tem valor igual ao valor  ���
���          � do saldo do produtor.                                      ���
�������������������������������������������������������������������������͹��
���Uso       � GetTitPr()                                                 ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VldTit()

	Local lRet := .T.

	dbSelectArea("SE2")
	SE2->(dbSetOrder(1))//E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA
	If SE2->(MsSeek( aDadTit[oBrT:nAt,01]+aDadTit[oBrT:nAt,02]+aDadTit[oBrT:nAt,03]+aDadTit[oBrT:nAt,04]+"NF "+SA2->A2_COD+SA2->A2_LOJA ))
		If SE2->E2_VALOR <> _nSldPro
			MsgAlert( "O valor selecionado R$ "+AllTrim(Str(SE2->E2_VALOR))+" � diferente do saldo do produtor: R$ "+AllTrim(Str(_nSldPro))  )
			lRet := .F.
		Else
			//Atualiza as variaveis de busca do titulo na compensacao
			_cNroNota := SE2->E2_NUM
			_cPrefixo := SE2->E2_PREFIXO
			_cParcNF  := SE2->E2_PARCELA

			//Somente se o titulo selecionado tiver o mesmo valor do saldo a pagar ao Fretista que
			//altera o titulo informado pelo usuario
			RecLock("SE2",.F.)
			SE2->E2_L_MIX   := cCodMix
			SE2->E2_L_VERSA := _cVersao
			SE2->E2_L_SETOR := ZL2->ZL2_COD
			SE2->E2_L_BANCO := SA2->A2_BANCO
			SE2->E2_L_AGENC := SA2->A2_AGENCIA
			SE2->E2_L_CONTA := SA2->A2_NUMCON
			SE2->E2_DATALIB := dDataBase
			SE2->E2_USUALIB := AllTrim(SubStr(cUsuario,7,15))
			MsUnlock()
		EndIf
	EndIf

Return(lRet)


/*/
	�������������������������������������������������������������������������������������������������������������������������������
	�������������������������������������������������������������������������������������������������������������������������������
	���������������������������������������������������������������������������������������������������������������������������ͻ��
	���Programa  � GrvZLF   � Autor �                       � Data da Criacao  � 29/05/2012                						���
	���������������������������������������������������������������������������������������������������������������������������͹��
	���Descricao � Funcao usada para realizar a gravacao dos eventos automaticos e dos eventos de debitos referentes a convenios���
	���          � e emprestimos.																					            ���
	���������������������������������������������������������������������������������������������������������������������������͹��
	���Uso       � Fechamento do Leite.            						                                                        ���
	���������������������������������������������������������������������������������������������������������������������������͹��
	���Parametros� cEvento - Codigo do Evento			       									          						���
	���			 � nValor  - Valor do Evento			       									          						���
	���			 � cSeek   - Conteudo do indice para identificar o Titulo(SE2)					          						���
	���			 � lGrvZLF - Se .T. grava novo registro na ZLF mesmo se o evento ja existir, se .F. e nao	existir o registro  ���
	���			 � 			 na ZLF grava um novo.																				���
	���			 � lAltZLF - Se .T. indica para alterar um registro na ZLF, se .F. nao faz nada.								���
	���			 � _cSeq    - Codigo Sequencial do Evento. Se vazio eh porque sera feito inclusao na ZLF, se informado eh porque ���
	���			 � 			 se trata de alteracao de algum registro na ZLF.													���
	���			 � cFunName- Nome da Static Function que chamou a GrvZLF().														���
	���			 � cLinha  - Codigo da linha.																					���
	���			 � nSE2VLR - Valor do titulo na SE2.																			���
	���			 � nSE2SLD - Saldo do titulo na SE2.																			���
	���			 � dSE2VEN - Data de vencimento do titulo na SE2.																���
	���			 � cSE2HIS - Historico do titulo na SE2.																		���
	���			 � nSE2JUR - Juros do titulo na SE2.																			���
	���			 � nSE2ACRES- Saldo do acrescimo do titulo na SE2.																���
	���			 � _cCodForn- Codigo do Fornecedor.																				���
	���			 � _cLojForn- Loja do Fornecedor.																				���
	���			 � _cTpTrib - Tipo de tributacao.																				���
	���			 � _cFil    - Filial para geracao dos eventos, pois podem existir debitos de outros filiais, mas os eventos 	���
	���			 � 			  devem ser gerados somente na filial que esta ocorrendo o fechamento.								���
	���			 �_lFecham  - Como os titulos do tipo financeiro nao possuem um tipo de tributacao o evento referente a eles    ���
	���			 �			  deve entrar com o status indicando o seu fechamento.											    ���
	���������������������������������������������������������������������������������������������������������������������������͹��
	���Retorno   � Nada       	  							                    	           									���
	���������������������������������������������������������������������������������������������������������������������������͹��
	���Usuario   � Microsiga                                                                                					���
	���������������������������������������������������������������������������������������������������������������������������͹��
	���Setor     � Gestao do Leite.                                                                        						���
	���������������������������������������������������������������������������������������������������������������������������͹��
	���            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                   						���
	���������������������������������������������������������������������������������������������������������������������������͹��
	���Autor     � Data     � Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor        ���
	���������������������������������������������������������������������������������������������������������������������������ĺ��
	���          �          �                                                  �                                  �   	        ���
	���----------�----------�--------------------------------------------------�----------------------------------�-------------���
	���          �          �                    							   �                                  � 			���
	���----------�----------�--------------------------------------------------�----------------------------------�-------------���
	���������������������������������������������������������������������������������������������������������������������������ͼ��
	�������������������������������������������������������������������������������������������������������������������������������
	�������������������������������������������������������������������������������������������������������������������������������
/*/

Static Function GrvZLF(cEvento,nValor,cSeek,lGrvZLF,lAltZLF,_cSeq,cFunName,cLinha,;
		nSE2VLR,nSE2SLD,dSE2VEN,cSE2HIS,nSE2JUR,nSE2ACRES,;
		_cCodForn,_cLojForn,_cTpTrib,_cFil,_lFecham)

	//�����������������������������������Ŀ
	//�Efetua o backup da filial corrente.�
	//�������������������������������������
	Local _cBkpFil      := cFilAnt
	Local nContador		:= 0
	Local _cSeekRet     := ""

	DEFAULT _cSeq   	:= LastZLF()
	DEFAULT cSeek   	:= ""
	DEFAULT lGrvZLF 	:= .T.
	DEFAULT lAltZLF 	:= .F.
	DEFAULT nSE2VLR 	:= 0
	DEFAULT nSE2SLD 	:= 0
	DEFAULT dSE2VEN 	:= CTOD("")
	DEFAULT cSE2HIS 	:= ""
	DEFAULT nSE2JUR 	:= 0
	DEFAULT nSE2ACRES	:= 0
	DEFAULT _lFecham    := .F.

	//������������������������������������������������������������Ŀ
	//�Posiciona na filial de fechamento para gravacao ou alteracao�
	//�de um determinado evento.                                   �
	//��������������������������������������������������������������
	cFilAnt:= _cFilEvent

	SM0->(dbSetOrder(1))   // forca o indice na ordem certa
	SM0->(MsSeek(SUBS(cNumEmp,1,2) + cFilAnt))

	dbSelectArea("ZL8")
	ZL8->(dbSetOrder(1))//ZL8_FILIAL+ZL8_COD
	ZL8->(MsSeek(xFilial("ZL8") + cEvento))

	//�������������������������������������������������������������������������������������Ŀ
	//� Se altera a ZLF. Usado quando o Evento foi lancado na ZLF.                          �
	//���������������������������������������������������������������������������������������
	If lAltZLF
		//�������������������������������������������������������������������������������������������Ŀ
		//� Posiciona na ZLF para alterar o campo ZLF_L_SEEK do registro.                             �
		//���������������������������������������������������������������������������������������������
		dbSelectArea("ZLF")
		ZLF->(dbSetOrder(1))//ZLF_FILIAL + ZLF_CODZLE + ZLF_VERSAO + ZLF_A2COD + ZLF_A2LOJA + ZLF_EVENTO + ZLF_SEQ
		If ZLF->(MsSeek(xFilial("ZLF") + cCodMIX + _cVersao + _cCodForn + _cLojForn + cEvento + _cSeq))
			//������������������������������������������������������������������������Ŀ
			//� Gravacao dos dados.                                                    �
			//��������������������������������������������������������������������������
			dbSelectArea("ZLF")
			RecLock("ZLF",.F.)
			ZLF->ZLF_L_SEEK := cSeek
			ZLF->(MsUnlock())
		EndIf

		Return(ZLF->ZLF_FILIAL + ZLF->ZLF_CODZLE + ZLF->ZLF_VERSAO + ZLF->ZLF_A2COD + ZLF->ZLF_A2LOJA + ZLF->ZLF_EVENTO + ZLF->ZLF_SEQ)

	Else
		//���������������������������������������������������������������������������������������������������Ŀ
		//� Posiciona na ZLF para verificar se ja existe um registro para o mesmo evento.                     �
		//� Se existir e a variavel lGrvZLF estiver como .T., ele grava um novo registro para o mesmo evento. �
		//�����������������������������������������������������������������������������������������������������
		dbSelectArea("ZLF")
		ZLF->(dbSetOrder(1))//ZLF_FILIAL+ZLF_CODZLE+ZLF_VERSAO+ZLF_A2COD+ZLF_A2LOJA+ZLF_EVENTO+ZLF_SEQ
		If ZLF->(MsSeek(xFilial("ZLF") + cCodMIX + _cVersao + _cCodForn + _cLojForn + cEvento))
			//If ZLF->(ZLF_FILIAL+ZLF_CODZLE+_cVersao+ZLF_A2COD+ZLF_A2LOJA+ZLF_EVENTO) == xFilial("ZLF")+cCodMIX+_cVersao+SA2->A2_COD+SA2->A2_LOJA+cEvento

			If lGrvZLF

				//������������������������������������������������������������������������Ŀ
				//� Alimenta as variaveis de memoria.                                      �
				//��������������������������������������������������������������������������
				RegToMemory("ZLF",.F.)

				//������������������������������������������������������������������������Ŀ
				//� Gravacao dos dados.                                                    �
				//��������������������������������������������������������������������������
				dbSelectArea("ZLF")
				RecLock("ZLF",.T.)
				For nContador := 1 To FCount()
					If ("FILIAL" $ FieldName(nContador) )
						FieldPut(nContador,xFilial("ZLF"))
					ElseIf ("EVENTO" $ FieldName(nContador) )
						FieldPut(nContador,cEvento)
					ElseIf ("DCREVE" $ FieldName(nContador) )
						FieldPut(nContador,cSE2HIS)// ZL8->ZL8_DESCRI)
					ElseIf ("QTDBOM" $ FieldName(nContador) )
						FieldPut(nContador,0)
					ElseIf ("QTDACI" $ FieldName(nContador) )
						FieldPut(nContador,0)
					ElseIf ("VLRLTR" $ FieldName(nContador) )
						FieldPut(nContador,0)
					ElseIf ("TOTAL" $ FieldName(nContador) )
						FieldPut(nContador,nValor)
					ElseIf ("DEBCRE" $ FieldName(nContador) )
						FieldPut(nContador,ZL8->ZL8_DEBCRE)
					ElseIf ("ORIGEM" $ FieldName(nContador) )
						FieldPut(nContador,"F")
					ElseIf ("L_SEEK" $ FieldName(nContador) )
						FieldPut(nContador,cSeek)
					ElseIf ("SEQ" $ FieldName(nContador) )
						FieldPut(nContador,_cSeq)
					ElseIf ("VLRPAG" $ FieldName(nContador) )
						FieldPut(nContador,0)
					ElseIf ("LINROT" $ FieldName(nContador) .And. !Empty(cLinha) ) // by Abrahao em 23/03/09
						FieldPut(nContador,cLinha)
					ElseIf ("SE1VLR" $ FieldName(nContador))//Alterado 14/10/10
						FieldPut(nContador,nSE2VLR )
					ElseIf ("SE1SLD" $ FieldName(nContador))//Alterado 14/10/10
						FieldPut(nContador,nSE2SLD )
					ElseIf ("SE1VEN" $ FieldName(nContador))//Alterado 14/10/10
						FieldPut(nContador,dSE2VEN )
					ElseIf ("SE1HIS" $ FieldName(nContador))//Alterado 14/10/10
						FieldPut(nContador,cSE2HIS )
					ElseIf ("SE1JUR" $ FieldName(nContador))//Alterado 20/10/10
						FieldPut(nContador,nSE2JUR )
					ElseIf ("TRIBUT" $ FieldName(nContador))
						FieldPut(nContador,_cTpTrib )
					ElseIf ("ACERTO" $ FieldName(nContador) .And. _lFecham)
						FieldPut(nContador,"S")
					ElseIf ("STATUS" $ FieldName(nContador) .And. _lFecham)
						FieldPut(nContador,"F")
					Else
						FieldPut(nContador,M->&(FieldName(nContador)))
					EndIf
				Next nContador

				ZLF->(MsUnlock())

			EndIf
		Else
			//�������������������������������������������������������������������������������������������Ŀ
			//� Posiciona na ZLF para obter dados para gerar um novo registro na propria ZLF.             �
			//� O novo registro criado possui os mesmos valores nos campos, exceto para os campos abaixo. �
			//���������������������������������������������������������������������������������������������
			dbSelectArea("ZLF")
			ZLF->(dbSetOrder(1))//ZLF_FILIAL+ZLF_CODZLE+ZLF_VERSAO+ZLF_A2COD+ZLF_A2LOJA+ZLF_EVENTO+ZLF_SEQ
			If ZLF->(MsSeek(xFilial("ZLF") + cCodMIX + _cVersao + _cCodForn + _cLojForn))
				//If ZLF->(ZLF_FILIAL+ZLF_CODZLE+_cVersao+ZLF_A2COD+ZLF_A2LOJA) == xFilial("ZLF")+cCodMIX+_cVersao+SA2->A2_COD+SA2->A2_LOJA
				//������������������������������������������������������������������������Ŀ
				//� Alimenta as variaveis de memoria.                                      �
				//��������������������������������������������������������������������������
				RegToMemory("ZLF",.F.)

				//������������������������������������������������������������������������Ŀ
				//� Gravacao dos dados.                                                    �
				//��������������������������������������������������������������������������
				dbSelectArea("ZLF")
				RecLock("ZLF",.T.)
				For nContador := 1 To FCount()
					If ("FILIAL" $ FieldName(nContador) )
						FieldPut(nContador,xFilial("ZLF"))
					ElseIf ("EVENTO" $ FieldName(nContador) )
						FieldPut(nContador,cEvento)
					ElseIf ("DCREVE" $ FieldName(nContador) )
						FieldPut(nContador,cSE2HIS) //ZL8->ZL8_DESCRI)
					ElseIf ("ENTMIX" $ FieldName(nContador) )
						FieldPut(nContador,ZL8->ZL8_MIX)
					ElseIf ("QTDBOM" $ FieldName(nContador) )
						FieldPut(nContador,0)
					ElseIf ("QTDACI" $ FieldName(nContador) )
						FieldPut(nContador,0)
					ElseIf ("VLRLTR" $ FieldName(nContador) )
						FieldPut(nContador,0)
					ElseIf ("TOTAL" $ FieldName(nContador) )
						FieldPut(nContador,nValor)
					ElseIf ("DEBCRE" $ FieldName(nContador) )
						FieldPut(nContador,ZL8->ZL8_DEBCRE)
					ElseIf ("ORIGEM" $ FieldName(nContador) )
						FieldPut(nContador,"F")
					ElseIf ("L_SEEK" $ FieldName(nContador) )
						FieldPut(nContador,cSeek)
					ElseIf ("SEQ" $ FieldName(nContador) )
						FieldPut(nContador,_cSeq)
					ElseIf ("VLRPAG" $ FieldName(nContador) )
						FieldPut(nContador,0)
					ElseIf ("LINROT" $ FieldName(nContador) .And. !Empty(cLinha) ) // by Abrahao em 23/03/09
						FieldPut(nContador,cLinha)
					ElseIf ("SE1VLR" $ FieldName(nContador))//Alterado 14/10/10
						FieldPut(nContador,nSE2VLR )
					ElseIf ("SE1SLD" $ FieldName(nContador))//Alterado 14/10/10
						FieldPut(nContador,nSE2SLD )
					ElseIf ("SE1VEN" $ FieldName(nContador))//Alterado 14/10/10
						FieldPut(nContador,dSE2VEN )
					ElseIf ("SE1HIS" $ FieldName(nContador))//Alterado 14/10/10
						FieldPut(nContador,cSE2HIS )
					ElseIf ("SE1JUR" $ FieldName(nContador))//Alterado 20/10/10
						FieldPut(nContador,nSE2JUR )
					ElseIf ("TRIBUT" $ FieldName(nContador))
						FieldPut(nContador,_cTpTrib )
					ElseIf ("ACERTO" $ FieldName(nContador) .And. _lFecham)
						FieldPut(nContador,"N")
					ElseIf ("STATUS" $ FieldName(nContador) .And. _lFecham)
						FieldPut(nContador,"F")
					Else
						FieldPut(nContador,M->&(FieldName(nContador)))
					EndIf
				Next nContador

				ZLF->(MsUnlock())

				/*
				//���������������������������������������������������������������������������������Ŀ
				//�Inserido esta possibilidade                    �
				//�visa ao nao encontrar um evento com o codigo e loja do associado ou              �
				//�nao encontrar um evento gerado na ZLF com o codigo e loja                        �
				//�isto pode indicar que se trata de debito de uma associacao ou um                 �
				//�debito referente a um cooperado em determinada loja que nao teve saldo           �
				//�no fechamento anterior para quitar suas dividas e serao cobradas neste fechamento�
				//�em uma outra loja de fechamento.                                                 �
				//�����������������������������������������������������������������������������������
				*/
			Else

				//��������������������������������������������������������Ŀ
				//�Somente sera gravado o evento caso na chamada da rotina �
				//�seja indicado que sera necessario a gravacao do evento. �
				//����������������������������������������������������������
				If lGrvZLF

					_cSeq:= U_GetSeqZLF(cCodMIX,cEvento,_cCodForn,_cLojForn)

					RecLock("ZLF", .T.)

					ZLF->ZLF_FILIAL := xFilial("ZLF")
					ZLF->ZLF_CODZLE := cCodMIX
					ZLF->ZLF_VERSAO := _cVersao
					ZLF->ZLF_SETOR  := ZL2->ZL2_COD
					ZLF->ZLF_LINROT := ""
					ZLF->ZLF_RETIRO := _cCodForn
					ZLF->ZLF_RETILJ := _cLojForn
					ZLF->ZLF_A2COD  := _cCodForn
					ZLF->ZLF_A2LOJA := _cLojForn
					ZLF->ZLF_EVENTO := cEvento
					ZLF->ZLF_DCREVE := cSE2HIS //ZL8->ZL8_DESCRI
					ZLF->ZLF_ENTMIX := ZL8->ZL8_MIX
					ZLF->ZLF_DEBCRED:= ZL8->ZL8_DEBCRE
					ZLF->ZLF_DTINI  := ZLE->ZLE_DTINI
					ZLF->ZLF_DTFIM  := ZLE->ZLE_DTFIM
					ZLF->ZLF_ORIGEM := "F"
					//Quando ocorrer o registro por aqui quer disser que o codigo + loja do produtor nao teve entrada de leite
					// no periodo, pode ser que nem o codigo como o caso da associacao que somente sera debitado os convenios e emprestimos
					ZLF->ZLF_QTDBOM := 0
					ZLF->ZLF_TOTAL  := nValor
					ZLF->ZLF_VLRLTR := 0
					ZLF->ZLF_ACERTO := "N"
					ZLF->ZLF_TP_MIX := "L"
					ZLF->ZLF_TIPO   := "L"
					ZLF->ZLF_STATUS := "F"
					ZLF->ZLF_SEQ	:= _cSeq
					ZLF->ZLF_DCRSET := ZL2->ZL2_DESCRI
					ZLF->ZLF_TRIBUT := _cTpTrib

					ZLF->(MsUnLock())

				EndIf

			EndIf

		EndIf

	EndIf

	//ZLF_FILIAL+ZLF_CODZLE+ZLF_VERSAO+ZLF_A2COD+ZLF_A2LOJA+ZLF_EVENTO+ZLF_SEQ
	_cSeekRet:=  xFilial("ZLF") + cCodMIX + _cVersao + _cCodForn + _cLojForn + cEvento + _cSeq

	//���������������������������������������������Ŀ
	//�Restaura a filial corrente antes do processo.�
	//�����������������������������������������������
	cFilAnt:= _cBkpFil

	SM0->(dbSetOrder(1))   // forca o indice na ordem certa
	SM0->(MsSeek(SUBS(cNumEmp,1,2) + cFilAnt))

Return _cSeekRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MGLT009   �Autor  �Microsiga           � Data �  11/27/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ValidaBloqueio()

	Local _cMatriculas := ""
	Local _cFiltro := "% BETWEEN '"+DTOS(_dDtIni)+"' AND '"+DTOS(_dDtFim)+"' %"

	BeginSql alias "BLQ"
		SELECT (LD.ZLD_RETIRO || '-' || LD.ZLD_RETILJ) MAT
		FROM %Table:ZLD% LD
		JOIN %Table:SA2% A2 ON A2.A2_COD = LD.ZLD_RETIRO AND A2.A2_LOJA = LD.ZLD_RETILJ AND A2.A2_MSBLQL = '1' AND A2.D_E_L_E_T_ = ' '
		WHERE LD.ZLD_FILIAL = %Exp:xFilial("ZLD")% AND LD.ZLD_RETIRO BETWEEN %Exp:_cProdDe% AND %Exp:cProdAte% AND LD.ZLD_DTCOLE %Exp:_cFiltro%
		AND LD.D_E_L_E_T_ = ' '
	EndSql

	BLQ->(DbGoTop())
	While !BLQ->(Eof())
		_cMatriculas := _cMatriculas + BLQ->MAT+"/ "
		BLQ->(DbSkip())
	EndDo

	BLQ->(DbCloseArea())

	If !Empty(_cMatriculas)
		xMagHelpFis("Bloqueio","Existem cooperados deste MIX com cadastro bloqueado!",;
			"Desbloqueie os cadastros abaixo antes de prosseguir com o fechamento:"+_ENTER;
			+_cMatriculas)
		Return .f.
	EndIf

Return .t.

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MGLT009   �Autor  �Microsiga           � Data �  07/02/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GrvF1Seek(_pcRetiro, _pcLoja, _pcMix, _pcVersao, _pcSetor, _pcNumNf, _pcSerie )

	// Grava NF nos eventos da ZLF
	Local _cUpdate := ""

	_cUpdate := "UPDATE " + RetSqlName("ZLF")
	_cUpdate += " SET ZLF_F1SEEK = '"+xFilial("SF1")+_pcNumNf+_pcSerie+_pcRetiro+_pcLoja+"N"+"'"
	_cUpdate += " WHERE D_E_L_E_T_ = ' '"
	_cUpdate += " AND ZLF_FILIAL  = '" + xFilial("ZLF") + "'"
	_cUpdate += " AND ZLF_RETIRO  = '" + _pcRetiro + "'"
	_cUpdate += " AND ZLF_RETILJ  = '" + _pcLoja + "'"
	_cUpdate += " AND ZLF_CODZLE  = '" + _pcMix + "'"
	_cUpdate += " AND ZLF_VERSAO  = '" + _pcVersao + "'"
	_cUpdate += " AND ZLF_SETOR   = '" + _pcSetor + "'"
	_cUpdate += " AND ZLF_ACERTO = 'N'"
	_cUpdate += " AND ZLF_TP_MIX = 'L' "

	lSqlOk := !(TCSqlExec(_cUpdate) < 0)

	If lSqlOk .and.  (TcGetDB() == 'ORACLE')
		lSqlOk := !(TCSqlExec(" COMMIT ") < 0)
	EndIf

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CriaSA5   �Autor  �Microsiga           � Data �  07/02/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �  Verifica se existe amarra��o Produto X Fornecedor e a cria ���
���          �  caso necess�rio.                                          ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function CriaSA5(xcCod, xcLoja,xcProduto)

	Local _cDesc := Posicione("SB1",1,xFilial("SB1")+xcProduto,"B1_DESC")

	DbSelectArea("SA5")
	DbSetOrder(1) //A5_FILIAL, A5_FORNECE, A5_LOJA, A5_PRODUTO, R_E_C_N_O_, D_E_L_E_T_
	If !(MsSeek(xFilial("SA5")+xcCod+xcLoja+xcProduto))
		RecLock("SA5",.t.)
		SA5->A5_FILIAL := xFilial("SA5")
		SA5->A5_FORNECE := xcCod
		SA5->A5_LOJA := xcLoja
		SA5->A5_NOMEFOR := SA2->A2_NOME
		SA5->A5_PRODUTO := xcProduto
		SA5->A5_NOMPROD := _cDesc
		MsUnlock()
	EndIf

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � AtualizaSld� Autor �Guilherme Fran�a  � Data �  00/00/00   ���
�������������������������������������������������������������������������͹��
���Desc.     � Atualiza os saldos na tabela ZLV.                          ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function AtualizaSld(Obj)

	Local _cAno := Alltrim(Str(year(ZLE->ZLE_DTFIM)))
	Local _cMes := StrZero(Month(ZLE->ZLE_DTFIM),2)

	DbSelectArea("ZLV")
	DbSetOrder(1)
	If !ZLV->(MsSeek(xFilial("ZLV")+_cAno+_cMes+SA2->A2_COD+SA2->A2_LOJA))
		RecLock("ZLV",.T.)
		ZLV->ZLV_FILIAL := xFilial("SF2")
		ZLV->ZLV_PERIOD := _cAno+_cMes
		ZLV->ZLV_MIX := ZLE->ZLE_COD
		ZLV->ZLV_SA2COD := SA2->A2_COD
		ZLV->ZLV_SA2LJ := SA2->A2_LOJA
		ZLV->ZLV_SA2NOM := SA2->A2_NOME
		ZLV->ZLV_DATA	:= dDataBase
		ZLV->ZLV_VLRNF 	:= SF1->F1_VALBRUT
		ZLV->ZLV_PRECO 	:= Round((SF1->F1_VALBRUT / SF1->F1_VOLUME1),4)
		ZLV->ZLV_PRCNEG := SA2->A2_L_ADICI
		ZLV->ZLV_QTD := SF1->F1_VOLUME1
		ZLV->ZLV_ROTA  	:= ""
		ZLV->ZLV_NF    	:= SF1->F1_DOC
		ZLV->ZLV_DEBITO := _nTotDebito
		ZLV->ZLV_FUNRUR := SF1->F1_CONTSOC  + SF1->F1_INSS
		ZLV->ZLV_SENAR  := SF1->F1_VLSENAR
		ZLV->ZLV_FUNDES := 	SF1->F1_VALFUND
		ZLV->ZLV_VLRLIQ := SF1->F1_VALBRUT - (SF1->F1_CONTSOC  + SF1->F1_INSS) - SF1->F1_VLSENAR - _nTotDebito - SF1->F1_VALFUND

		ZLV->(MsUnlock())
	Else
		RecLock("ZLV",.F.)
		ZLV->ZLV_MIX := ZLE->ZLE_COD
		ZLV->ZLV_SA2NOM := SA2->A2_NOME
		ZLV->ZLV_DATA	:= dDataBase
		ZLV->ZLV_VLRNF 	:= SF1->F1_VALBRUT
		ZLV->ZLV_PRECO 	:= Round((SF1->F1_VALBRUT / SF1->F1_VOLUME1),4)
		ZLV->ZLV_PRCNEG := SA2->A2_L_ADICI
		ZLV->ZLV_QTD := SF1->F1_VOLUME1
		ZLV->ZLV_ROTA  	:= ""
		ZLV->ZLV_NF    	:= SF1->F1_DOC
		ZLV->ZLV_DEBITO := _nTotDebito
		ZLV->ZLV_FUNRUR := SF1->F1_CONTSOC  + SF1->F1_INSS
		ZLV->ZLV_SENAR  := SF1->F1_VLSENAR
		ZLV->ZLV_FUNDES := 	SF1->F1_VALFUND
		ZLV->ZLV_VLRLIQ := SF1->F1_VALBRUT - (SF1->F1_CONTSOC + SF1->F1_INSS) - SF1->F1_VLSENAR - _nTotDebito - SF1->F1_VALFUND

		ZLV->(MsUnlock())

	EndIf

Return