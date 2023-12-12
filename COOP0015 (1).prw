#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"


// //Estrutura de Entrada - Itens do Pedido de Compras
// WSSTRUCT ITENSPC

// 	WSDATA IPEDIDO 			AS ARRAY OF ITENSPEDPC

// ENDWSSTRUCT

// //Estrutura do Itens - Itens do Pedido de Compras
// WSSTRUCT ITENSPEDPC
// 	WSDATA PRODUTO			AS STRING
// 	WSDATA QUANTIDADE		AS STRING
// 	WSDATA PRECOUNITARIO	AS STRING
// ENDWSSTRUCT

// WSSERVICE WSCOOPCONDCOMPRAS NAMESPACE 'http://wscoopcondcompras'

// 	// PARAMETROS
// 	WSDATA cCodFilial					AS STRING
// 	WSDATA cNumRecep					AS STRING
// 	WSDATA cLote						AS STRING
// 	WSDATA cCodGuia						AS STRING
// 	WSDATA cQtdOvos						AS STRING
// 	WSDATA cDataEnt						AS STRING
// 	WSDATA cCondPag						AS STRING
// 	WSDATA cFornece						AS STRING
// 	WSDATA cLoja						AS STRING
// 	WSDATA cLogin						AS STRING
// 	WSDATA cSenha						AS STRING
// 	WSDATA 	ItensPedido					AS ITENSPC

// 	// RETORNO
// 	WSDATA cRetorno						AS STRING

// 	WSMETHOD RATEIOPEDIDOCOMPRA		DESCRIPTION 'Gera? de Rateio de Entrada Ovos do Condom?io.'
// 	WSMETHOD EXCLUIRATEIO			DESCRIPTION 'Exclusao de Recepao de Ovos do Condom?io'

// ENDWSSERVICE

Static Function COOP0015I(cCodFilial, cNumRecep, cLote, cCodGuia, cQtdOvos, cDataEnt, ItensPedido, cFornece, cLoja, cLogin, cSenha, _cCodZap)

	// Local _cEmpresa 	:= "01"
	Local _cCodFilial  	:= cCodFilial
	Local _cLote		:= ""
	Local _cCond		:= ""
	Local _cNumRecep	:= ""
	Local _cCodGuia		:= ""
	Local _cFornece		:= ""
	Local _cLoja		:= ""
	Local _nQtdOvos		:= 0
	Local _dDataEnt		:= CToD('//')
	// Local _cLogin		:= cLogin
	// Local _cSenha		:= cSenha
	Local _nDifRat		:= 0
	Local _aItens		:= ItensPedido
	Local aCab			:= {}
	Local aItens		:= {}
	Local lGeraPc		:= .T.
	Local cYREGESP		:= ""
	Local aCabMI		:= {}
	Local aErro			:= {}
	Local aItemMI		:= {}
	Local cYPROVOL		:= ""
	Local cQuery		:= ""
	Local cQuery2		:= ""
	Local cQuery3		:= ""
	Local cErroTemp		:= ""
	Local lIncLanc      := .F.
	Local I				:= 0
	Local nI		    := 0
	// Local _cCondom		:= cCodGuia
	Local _nTotalRat	:= 0
	//Variaveis Privadas
	//Tratamento de erro do EXECAUTO
	Private lMsErroAuto := .F.
	Private lMsHelpAuto := .T.
	Private lAutoErrNoFile := .T.

	// If !(U_WSVLOGIN(_cEmpresa, _cCodFilial, _cLogin, _cSenha))
	// 	SETSOAPFAULT('LOGINSENHA','USUARIO OU SENHA INVALIDOS!')
	// 	Return .F.
	// EndIf

	// RpcSetType(4)
	// RpcSetEnv("01", ::cCodFilial, ::cLogin, ::cSenha, "COM")

	// FwLogMsg("INFO", , FunName(), , , , "+-------------------------------------------------+")
	// FwLogMsg("INFO", , FunName(), , , , "  WEBSERVICE RATEIO DE PRODUCAO                    ")
	// FwLogMsg("INFO", , FunName(), , , , "  EXECUTANDO METODO RATEIOPEDIDOCOMPRA	           ")

	cQuery := " SELECT * "
	cQuery += " FROM "+RetSqlName("ZAE")+" ZAE "
	cQuery += " WHERE ZAE.D_E_L_E_T_ = ' ' "
	// cQuery += " AND ZAE.ZAE_ARMAZE = '"+StrZero(Val(AllTrim(cLote)),TamSX3("ZAE_COD")[1])+"' "
	cQuery += " AND ZAE.ZAE_COD = '"+ AllTrim(cLote)+"' "
	TcQuery cQuery New Alias "_ZAE"
	If !_ZAE->(Eof())
		_cLote	:= _ZAE->ZAE_COD
	EndIf
	_ZAE->(DbCloseArea())

	cYREGESP		:= GetMv("MV_YREGESP")
	cYPROVOL		:= GetMv("MV_YPROVOL")
	cYOvoLiqTr      := GetMv("MV_YOVOLTR")   // Codigo do ovo liquido e trincado
	cYCondOvoL      := GetMv("MV_YCONOVO")   // Codigo do condominio ovo liquido e trincado

	_cCodFilial  	:= Padr(cCodFilial											, TamSX3("ZAP_FILIAL")[1])
	_cNumRecep 		:= StrZero(Val(cNumRecep),TamSX3("ZAP_RECPOV")[1])
	_cCond			:= Padr(Posicione("ZAF",2,xFilial("ZAF")+_cLote,"ZAF_COD")	, TamSX3("ZAF_COD")[1])
	_cCodGuia 		:= Padr(cCodGuia											, TamSX3("ZAP_GUIATR")[1])
	_cFornece		:= Padr(cFornece											, TamSX3("A2_COD")[1])
	_cLoja			:= Padr(cLoja												, TamSX3("A2_LOJA")[1])
	_nQtdOvos		:= cQtdOvos
	_dDataEnt		:= stod(cDataEnt)

	If !Empty(_cCodGuia)

		ZAP->(DbSetOrder(4))
		If !ZAP->(DbSeek(xFilial("ZAP")+_cNumRecep))

			//_cCod	:= GetSxeNum("ZAP","ZAP_COD")
            _cCod	:= _cCodZap

			//Grava Recepcao de Ovos 
			If RecLock("ZAP",.T.)
				ZAP->ZAP_FILIAL		:= xFilial("ZAP")
				ZAP->ZAP_COD		:= _cCod
				ZAP->ZAP_DATA		:= _dDataEnt
				ZAP->ZAP_COND		:= _cCond
				ZAP->ZAP_GUIATR		:= _cCodGuia
				ZAP->ZAP_QTD		:= _nQtdOvos
				ZAP->ZAP_RECPOV		:= _cNumRecep
				ZAP->(MsUnLock())
				ConfirmSx8()
				FwLogMsg("INFO", , FunName(), , , , "  GRAVADO RECEPCAO DE OVOS NUMERO: "+_cCod+"	          ")


				//Verifica se envia workflow de divergencia de ovos
				ZAS->(DbSetOrder(1))
				If ZAS->(DbSeek(xFilial("ZAS")+_cCodGuia))
					If ZAS->ZAS_QTD != _nQtdOvos
						U_CONAY016(_cCod, _cCodGuia)
					EndIf
				EndIf

			Else
				RollbackSx8()
			EndIf

			//Realiza Rateio dos Itens
			For I:= 1 To Len(_aItens)

				// If AllTrim(_WS_SOAPaItens[I]:PRODUTO) $ cYPROVOL
				If AllTrim(_aItens[I][1]) $ cYPROVOL

					//Query do Rateio das Cotas	em caso de Ovo Liquido
					cQuery := " SELECT ZAG.ZAG_FILIAL AS FILIAL "
					cQuery += "        ,ZAG.ZAG_COND AS CONDOMINIO "
					cQuery += "        ,ZAG.ZAG_CLIENT AS CLIENTE "
					cQuery += "        ,ZAG.ZAG_LOJA AS LOJA  "
					cQuery += "        ,TRUNC("+cvaltochar(_aItens[I][3])+" * (ZAG.ZAG_QTDCOT / 100) , 0 ) AS COTA  "
					cQuery += "        ,ROUND("+cvaltochar(_aItens[I][3])+" * (ZAG.ZAG_QTDCOT / 100),2) AS TOTAL_RAT "
					cQuery += " FROM "+RetSqlName("ZAG")+" ZAG "
					cQuery += " WHERE ZAG.D_E_L_E_T_ = ' ' "
					cQuery += "   AND ZAG.ZAG_COND = '"+_cCond+"' "
					cQuery += "   AND ZAG.ZAG_QTDCOT > 0 "
					cQuery += " ORDER BY ZAG.ZAG_SOBOVO , ZAG.ZAG_QTDCOT, ZAG.ZAG_CLIENT, ZAG.ZAG_LOJA "
					TcQuery cQuery New Alias "TRB"

					If !TRB->(Eof())

						cQuery2 := " SELECT SUM(ROUND("+cvaltochar(_aItens[I][3])+" * (ZAG.ZAG_QTDCOT / 100),2)) AS SUM_RAT "
						cQuery2 += " FROM "+RetSqlName("ZAG")+" ZAG "
						cQuery2 += " WHERE ZAG.D_E_L_E_T_ = ' ' "
						cQuery2 += "   AND ZAG.ZAG_COND = '"+_cCond+"' "
						cQuery2 += "   AND ZAG.ZAG_QTDCOT > 0 "
						cQuery2 += " ORDER BY ZAG.ZAG_SOBOVO , ZAG.ZAG_QTDCOT, ZAG.ZAG_CLIENT, ZAG.ZAG_LOJA "
						TcQuery cQuery2 New Alias "TRC"

						If !TRC->(Eof())
							nPrcUni	:= ((_aItens[I][3]) * (_aItens[I][2]) ) / TRC->SUM_RAT
						EndIf
						TRC->(DbCloseArea())

						//Roda query para gerar gravar o rateio
						Do While !TRB->(Eof())

							RecLock("ZAQ",.T.)
							ZAQ->ZAQ_FILIAL		:= TRB->FILIAL
							ZAQ->ZAQ_COD		:= _cCod
							ZAQ->ZAQ_DATA		:= _dDataEnt
							ZAQ->ZAQ_CLIENT		:= TRB->CLIENTE
							ZAQ->ZAQ_LOJA		:= TRB->LOJA
							ZAQ->ZAQ_QTD		:= TRB->TOTAL_RAT
							ZAQ->ZAQ_ITEM		:= StrZero(I,4)
							ZAQ->ZAQ_PRODUT		:= AllTrim(_aItens[I][1])
							ZAQ->ZAQ_VLRUNI		:= nPrcUni
							ZAQ->(MsUnLock())

							TRB->(DbSkip())
						EndDo
					EndIf
					TRB->(DbCloseArea())

				Else

					//Query do Rateio das Cotas
					cQuery := " SELECT ZAG.ZAG_FILIAL AS FILIAL "
					cQuery += "       ,ZAG.ZAG_COND AS CONDOMINIO "
					cQuery += "       ,ZAG.ZAG_CLIENT AS CLIENTE "
					cQuery += "       ,ZAG.ZAG_LOJA AS LOJA "
					cQuery += "       ,TRUNC("+cvaltochar(_aItens[I][3])+" * (ZAG.ZAG_QTDCOT / 100) , 0 ) AS COTA "
					cQuery += "       ,"+cvaltochar(_aItens[I][3])+" * (ZAG.ZAG_QTDCOT / 100) AS TOTAL_RAT "
					cQuery += "       ,"+cvaltochar(_aItens[I][3])+" * (ZAG.ZAG_QTDCOT / 100)- TRUNC("+cvaltochar(_aItens[I][3])+" * (ZAG.ZAG_QTDCOT / 100) , 0 ) AS DIFERENCA "
					cQuery += " FROM "+RetSqlName("ZAG")+" ZAG "
					cQuery += " WHERE ZAG.D_E_L_E_T_ = ' ' "
					cQuery += "   AND ZAG.ZAG_COND = '"+_cCond+"' "
					cQuery += "   AND ZAG.ZAG_QTDCOT > 0 "
					cQuery += " ORDER BY ZAG.ZAG_SOBOVO , ZAG.ZAG_QTDCOT, ZAG.ZAG_CLIENT, ZAG.ZAG_LOJA "
					TcQuery cQuery New Alias "TRB"

					If !TRB->(Eof())

						//Roda query para pegar sobras do Rateio
						Do While !TRB->(Eof())
							_nDifRat	+= TRB->DIFERENCA
							TRB->(DbSkip())
						EndDo
						TRB->(DbGoTop())

						//Roda query para gerar o orcamento distribuindo as sobras
						Do While !TRB->(Eof())

							RecLock("ZAQ",.T.)
							ZAQ->ZAQ_FILIAL := TRB->FILIAL
							ZAQ->ZAQ_COD    := _cCod
							ZAQ->ZAQ_DATA   := _dDataEnt
							ZAQ->ZAQ_CLIENT := TRB->CLIENTE
							ZAQ->ZAQ_LOJA   := TRB->LOJA
							// If TRB->CONDOMINIO $ 'G20008_G10009'
								ZAQ->ZAQ_QTD    := TRB->COTA + IIF(_nDifRat > 0, 1,0)
							// Else
							// 	If TRB->CLIENTE+TRB->LOJA == "N6204843"
							// 		ZAQ->ZAQ_QTD    := TRB->COTA + IIF(_nDifRat > 0, 2,0)
							// 	Else
							// 		ZAQ->ZAQ_QTD    := TRB->COTA + IIF(_nDifRat > 0, 1,0)
							// 	EndIf
							// Endif
							ZAQ->ZAQ_ITEM   := StrZero(I,4)
							ZAQ->ZAQ_PRODUT := AllTrim(_aItens[I][1])
							ZAQ->ZAQ_VLRUNI := (_aItens[I][2])
							_nTotalRat += ZAQ->ZAQ_QTD
							ZAQ->(MsUnLock())

							//Atualiza dados da cota com numero de frangas e sobras
							ZAG->(DbSetOrder(2))
							If ZAG->(DbSeek(xFilial("ZAG")+TRB->CONDOMINIO+TRB->CLIENTE+TRB->LOJA))
								RecLock("ZAG",.F.)
								If _nDifRat > 0
									ZAG->ZAG_SOBOVO	:= ZAG->ZAG_SOBOVO + 1
									_nDifRat--
								EndIf
								ZAG->(MsUnLock())
							EndIf

							TRB->(DbSkip())
						EndDo
						
					EndIf

					// Realiza a Repartição das Sobras do Rateio. 
					
					_nDifRat:= 0

					If _nQtdOvos - _nTotalRat > 0

						_nDifRat := _nQtdOvos - _nTotalRat 

						cQuery3 := " SELECT ZAG.ZAG_FILIAL AS FILIAL "
						cQuery3 += "       ,ZAG.ZAG_COND AS CONDOMINIO "
						cQuery3 += "       ,ZAG.ZAG_CLIENT AS CLIENTE "
						cQuery3 += "       ,ZAG.ZAG_LOJA AS LOJA "
						cQuery3 += " FROM "+RetSqlName("ZAG")+" ZAG "
						cQuery3 += " WHERE ZAG.D_E_L_E_T_ = ' ' "
						cQuery3 += "   AND ZAG.ZAG_COND = '"+_cCond+"' "
						cQuery3 += "   AND ZAG.ZAG_QTDCOT > 0 "
						cQuery3 += " ORDER BY ZAG_SOBOVO,ZAG_CLIENT"
						TcQuery cQuery3 New Alias "TRR"
						
						Do While !TRR->(Eof())
							If _nDifRat > 0
								ZAQ->(DbSetOrder(3))
								If ZAQ->(DbSeek(xFilial("ZAQ")+_cCod+TRR->CLIENTE+TRR->LOJA))
									
									RecLock("ZAQ",.F.)
									ZAQ->ZAQ_QTD    := ZAQ->ZAQ_QTD + 1	
									ZAQ->(MsUnLock())
									
								EndIf

								ZAG->(DbSetOrder(2))

								If ZAG->(DbSeek(xFilial("ZAG")+TRR->CONDOMINIO+TRR->CLIENTE+TRR->LOJA))
									RecLock("ZAG",.F.)
									If _nDifRat > 0
										ZAG->ZAG_SOBOVO	:= ZAG->ZAG_SOBOVO + 1
										_nDifRat--
									EndIf
									ZAG->(MsUnLock())
								EndIf
							EndIf

							TRR->(DbSkip())
						EndDo

						TRR->(DbCloseArea())

					Endif
					
					TRB->(DbCloseArea())

				EndIf

			Next I

			FwLogMsg("INFO", , FunName(), , , , "  GRAVADO RATEIOS DE OVOS NUMERO: "+_cCod+"	          ")

			//Inclui o Pedido de Compras Resultantes do Rateio
			If cYREGESP == "S"

				aCabMI		:= {}
				aItemMI		:= {}

				//Cabecalho da Movimentacao
				aAdd(aCabMI, {"D3_TM"		, "151"			,Nil})
				aAdd(aCabMI, {"D3_EMISSAO"	, DDATABASE		,Nil})

				//Dados do Itens da Movimentacao
				ZAQ->(DbSetOrder(1))
				If ZAQ->(DbSeek(xFilial("ZAQ")+_cCod))
					Do While !ZAQ->(Eof()) .And. ZAQ->ZAQ_FILIAL == xFilial("ZAQ") .And. ZAQ->ZAQ_COD == _cCod

						aAux	:= {}

						aAdd(aAux,{"D3_COD"			,ZAQ->ZAQ_PRODUT												, Nil})
						aAdd(aAux,{"D3_UM"			,Posicione("SB1",1,xFilial("SB1")+ZAQ->ZAQ_PRODUT,"B1_UM")		, Nil})
						aAdd(aAux,{"D3_QUANT"		,ZAQ->ZAQ_QTD													, Nil})

						If (ZAQ->ZAQ_CLIENT + ZAQ->ZAQ_LOJA) == 'N6204843'.And. !AllTrim(ZAQ->ZAQ_PRODUT) $ cYPROVOL
							aAdd(aAux,{"D3_LOCAL"		,"13"															, Nil})
						else
							aAdd(aAux,{"D3_LOCAL"		,Posicione("SB1",1,xFilial("SB1")+ZAQ->ZAQ_PRODUT,"B1_LOCPAD")	, Nil})
						EndIf

						aAdd(aAux,{"D3_CUSTO1"		,ZAQ->ZAQ_VLRUNI * ZAQ->ZAQ_QTD									, Nil})

						aAdd(aItemMI, aAux)

						ZAQ->(DbSkip())
					EndDo
				EndIf

				//Caso encontre Item inicia execucao
				If Len(aItemMI) > 0
					//Executa a Inclusao Automatica da Movimentacao Interna

					aArea := GetArea()
					dbSelectArea("SD1")
					dbSetOrder(1)
					dbGoBottom()
					dbSelectArea("SD2")
					dbSetOrder(1)
					dbGoBottom()
					dbSelectArea("SD3")
					dbSetOrder(1)
					dbGoBottom()

					MSExecAuto({|x,y,z| MATA241(x,y,z)},aCabMI,aItemMI,3)

					If lMsErroAuto
						aErro := GetAutoGRLog()
						For nI := 1 To Len(aErro)
							cErroTemp += aErro[nI] +CRLF
						Next nI

						FwLogMsg("ERROR", , FunName(), , , , cErroTemp)
						DisarmTransaction()
						RestArea(aArea)

						ZAQ->(DbSetOrder(1))
						If ZAQ->(DbSeek(xFilial("ZAQ")+_cCod))
							Do While !ZAQ->(Eof()) .And. ZAQ->ZAQ_FILIAL == xFilial("ZAQ") .And. ZAQ->ZAQ_COD == _cCod
								//Exclui ratieo pois deu erro na inclusão do movimento interno
								RecLock("ZAQ",.F.)
								ZAQ->(DbDelete())
								ZAQ->(MsUnLock())
							EndDo
						EndIf

						//Realiza Exclusao da Recepcao de Ovos
						ZAP->(DbSetOrder(1))
						If ZAP->(DbSeek(xFilial("ZAP")+_cCod))
							RecLock("ZAP",.F.)
							ZAP->(DbDelete())
							ZAP->(MsUnLock())
						EndIf
						::cRetorno	:= "X"
					Else
						RestArea(aArea)
						ZAQ->(DbSetOrder(1))
						If ZAQ->(DbSeek(xFilial("ZAQ")+_cCod))
							Do While !ZAQ->(Eof()) .And. ZAQ->ZAQ_FILIAL == xFilial("ZAQ") .And. ZAQ->ZAQ_COD == _cCod
								//Atualiza a numeracao da Movimentacao Gerada
								RecLock("ZAQ",.F.)
								ZAQ->ZAQ_MVINT	:= SD3->D3_DOC
								ZAQ->(MsUnLock())
								ZAQ->(DbSkip())
							EndDo
						EndIf
					EndIf
				EndIf
			Else
				ZAG->(DbSetOrder(1))
				If ZAG->(DbSeek(xFilial("ZAG")+_cCond))
					Do While !ZAG->(Eof()) .And. ZAG->ZAG_FILIAL == xFilial("ZAG") .And. ZAG->ZAG_COND == _cCond

						ZAQ->(DbSetOrder(3))
						If ZAQ->(DbSeek(xFilial("ZAQ")+_cCod+ZAG->ZAG_CLIENT+ZAG->ZAG_LOJA))

							aItens		:= {}
							aCab		:= {}
							_cFornece	:= Posicione("SA1",1,xFilial("SA1")+ZAG->ZAG_CLIENT+ZAG->ZAG_LOJA, "A1_YCODFOR")
							_cLoja		:= Posicione("SA1",1,xFilial("SA1")+ZAG->ZAG_CLIENT+ZAG->ZAG_LOJA, "A1_YLOJFOR")

							Do While !ZAQ->(Eof()) .And. ZAQ->ZAQ_FILIAL == xFilial("ZAQ") .And. ZAQ->ZAQ_COD == _cCod .And. ZAQ->ZAQ_CLIENT == ZAG->ZAG_CLIENT .And. ZAQ->ZAQ_LOJA == ZAG->ZAG_LOJA

								aAux	:= {}

								aAdd(aAux,{"C7_PRODUTO"		,ZAQ->ZAQ_PRODUT				,Nil})
								aAdd(aAux,{"C7_QUANT"		,ZAQ->ZAQ_QTD					,Nil})
								aAdd(aAux,{"C7_PRECO"		,ZAQ->ZAQ_VLRUNI				,Nil})
								aAdd(aAux,{"C7_TES"			,"081"							,Nil})

								aAdd(aItens,aAux)

								ZAQ->(DbSkip())
							EndDo

							If Len(aItens) > 0

								SC7->(DbSetOrder(1))
								SC7->(DbSeek(xFilial("SC7")+"ZZZZZZZZZZZZZZZZZ"))

								cNumPed := GetNumSC7(.T.)
								ConfirmSX8()
								aAdd(aCab,{"C7_FILIAL"	,xFilial("SC7")		,Nil})
								aAdd(aCab,{"C7_NUM"		,cNumPed			,Nil})
								aAdd(aCab,{"C7_EMISSAO"	,dDatabase			,Nil})
								aAdd(aCab,{"C7_FORNECE"	,_cFornece			,Nil})
								aAdd(aCab,{"C7_LOJA"	,_cLoja				,Nil})
								aAdd(aCab,{"C7_COND"	,"177"				,Nil})
								aAdd(aCab,{"C7_CONTATO"	,""					,Nil})
								aAdd(aCab,{"C7_FILENT"	,xFilial("SC7")		,Nil})
								aAdd(aCab,{"C7_YCOND"	,_cCond				,Nil})

								_cA120Oper	:= '51'

								//Chama ExecAuto para gerar o Pedido de Compras
								MsExecAuto({|x,y,z,w,k| Mata120(x,y,z,w,k)},1,aCab,aItens,3,.F.)

								If lMsErroAuto
									DisarmTransaction()
									aErro := GetAutoGRLog()
									For nI := 1 To Len(aErro)
										cErroTemp += aErro[nI] +CRLF
									Next nI

									FwLogMsg("ERROR", , FunName(), , , , cErroTemp)
								Else
									//Grava Numero do PC
									ZAQ->(DbSetOrder(3))
									If ZAQ->(DbSeek(xFilial("ZAQ")+_cCod+ZAG->ZAG_CLIENT+ZAG->ZAG_LOJA))
										Do While !ZAQ->(Eof()) .And. ZAQ->ZAQ_FILIAL == xFilial("ZAQ") .And. ZAQ->ZAQ_COD == _cCod .And. ZAQ->ZAQ_CLIENT == ZAG->ZAG_CLIENT .And. ZAQ->ZAQ_LOJA == ZAG->ZAG_LOJA

											RecLock("ZAQ",.F.)
											ZAQ->ZAQ_FILPC		:= xFilial("SC7")
											ZAQ->ZAQ_NUMPC		:= cNumPed
											ZAQ->(MsUnLock())

											ZAQ->(DbSkip())
										EndDo
									EndIf


									_aAreaSC7	:= SC7->(GetArea())
									SC7->(DbSetOrder(1))
									If SC7->(DbSeek(xFilial("SC7")+cNumPed))
										Do While !SC7->(Eof()) .And. SC7->C7_FILIAL == xFilial("SC7") .And. SC7->C7_NUM == cNumPed

											RecLock("SC7",.F.)
											SC7->C7_YCOND		:= _cCond
											SC7->(MsUnLock())

											SC7->(DbSkip())
										EndDo
									EndIf
									RestArea(_aAreaSC7)

								EndIf

							EndIf

						EndIf

						ZAG->(DbSkip())
					EndDo
				EndIf
			EndIf
			//::cRetorno	:= _cCod
		Else
			//::cRetorno	:= "R"
		EndIf

	Else
		// gravar parte dos ovos liquido e trincados conforme parametro
		lIncLanc := .F.
		For I:= 1 To Len(_aItens)
			If	AllTrim(_aItens[I][1]) $ cYOvoLiqTr
				lIncLanc := .T.
			EndIf
		Next I
		If	lIncLanc
			ZAP->(DbSetOrder(4))
			If !ZAP->(DbSeek(xFilial("ZAP")+_cNumRecep))

				_cCod	:= GetSxeNum("ZAP","ZAP_COD")

				//Grava Recepcao de Ovos CABEÇALHO (ZAP)
				If RecLock("ZAP",.T.)
					ZAP->ZAP_FILIAL		:= xFilial("ZAP")
					ZAP->ZAP_COD		:= _cCod
					ZAP->ZAP_DATA		:= _dDataEnt
					ZAP->ZAP_COND		:= cYCondOvoL //_cCond  // código fixo do condomino para ovo liquido
					ZAP->ZAP_GUIATR		:= _cCodGuia
					ZAP->ZAP_QTD		:= _nQtdOvos
					ZAP->ZAP_RECPOV		:= _cNumRecep
					ZAP->(MsUnLock())
					ConfirmSx8()
					FwLogMsg("INFO", , FunName(), , , , "  GRAVADO RECEPCAO DE OVOS NUMERO: "+_cCod+"	          ")
				Else
					RollbackSx8()
				EndIf

				//Realiza gravação do Itens (ZAQ)
				For I:= 1 To Len(_aItens)
					RecLock("ZAQ",.T.)
					ZAQ->ZAQ_FILIAL		:= xFilial("ZAQ")
					ZAQ->ZAQ_COD		:= _cCod
					ZAQ->ZAQ_DATA		:= _dDataEnt
					ZAQ->ZAQ_CLIENT		:= _cFornece
					ZAQ->ZAQ_LOJA		:= _cLoja
					ZAQ->ZAQ_QTD		:= _aItens[I][3] //AllTrim(_aItens[I][3])
					ZAQ->ZAQ_ITEM		:= StrZero(I,4)
					ZAQ->ZAQ_PRODUT		:= AllTrim(_aItens[I][1])
					ZAQ->ZAQ_VLRUNI		:= (_aItens[I][2])
					ZAQ->(MsUnLock())
				Next I

				FwLogMsg("INFO", , FunName(), , , , "  GRAVADO RATEIOS DE OVOS NUMERO: "+_cCod+"	          ")
				//Inclui o Pedido de Compras ou o movimento interno

				aCabMI		:= {}
				aItemMI		:= {}

				//Cabecalho da Movimentacao
				aAdd(aCabMI, {"D3_TM"		, "151"			,Nil})
				aAdd(aCabMI, {"D3_EMISSAO"	, DDATABASE		,Nil})

				//Dados do Itens da Movimentacao
				ZAQ->(DbSetOrder(1))
				If 	ZAQ->(DbSeek(xFilial("ZAQ")+_cCod))
					Do While !ZAQ->(Eof()) .And. ZAQ->ZAQ_FILIAL == xFilial("ZAQ") .And. ZAQ->ZAQ_COD == _cCod

						aAux	:= {}
						aAdd(aAux,{"D3_COD"			,ZAQ->ZAQ_PRODUT												, Nil})
						aAdd(aAux,{"D3_UM"			,Posicione("SB1",1,xFilial("SB1")+ZAQ->ZAQ_PRODUT,"B1_UM")		, Nil})
						aAdd(aAux,{"D3_QUANT"		,ZAQ->ZAQ_QTD													, Nil})
						aAdd(aAux,{"D3_LOCAL"		,"01"	                                                        , Nil})
						aAdd(aAux,{"D3_CUSTO1"		,ZAQ->ZAQ_VLRUNI * ZAQ->ZAQ_QTD									, Nil})
						aAdd(aItemMI, aAux)

						ZAQ->(DbSkip())
					EndDo
				EndIf

				//Caso encontre Item inicia execucao
				If Len(aItemMI) > 0
					//Executa a Inclusao Automatica da Movimentacao Interna
					FwLogMsg("INFO", , FunName(), , , , " GRAVANDO MOVIMENTO INTERNO: "+_cCod+" - "+_cNumRecep+"  ")
					// Posicionando no ultimo registro para o sistema pegar ajustar o MV_DOCSEQ
					aArea := GetArea()
					dbSelectArea("SD1")
					dbSetOrder(1)
					dbGoBottom()
					dbSelectArea("SD2")
					dbSetOrder(1)
					dbGoBottom()
					dbSelectArea("SD3")
					dbSetOrder(1)
					dbGoBottom()

					MSExecAuto({|x,y,z| MATA241(x,y,z)},aCabMI,aItemMI,3)
					If 	lMsErroAuto
						aErro := GetAutoGRLog()
						For nI := 1 To Len(aErro)
							cErroTemp += aErro[nI] +CRLF
						Next nI

						FwLogMsg("ERROR", , FunName(), , , , cErroTemp)
						DisarmTransaction()
						RestArea(aArea)

						ZAQ->(DbSetOrder(1))
						If 	ZAQ->(DbSeek(xFilial("ZAQ")+_cCod))
							Do While !ZAQ->(Eof()) .And. ZAQ->ZAQ_FILIAL == xFilial("ZAQ") .And. ZAQ->ZAQ_COD == _cCod
								//Exclui ratieo pois deu erro na inclusão do movimento interno
								RecLock("ZAQ",.F.)
								ZAQ->(DbDelete())
								ZAQ->(MsUnLock())
							EndDo
						EndIf

						//Realiza Exclusao da Recepcao de Ovos
						ZAP->(DbSetOrder(1))
						If 	ZAP->(DbSeek(xFilial("ZAP")+_cCod))
							RecLock("ZAP",.F.)
							ZAP->(DbDelete())
							ZAP->(MsUnLock())
						EndIf
						FwLogMsg("ERROR", , FunName(), , , , "Erro na gravacao -- movimento interno")
						// ::cRetorno	:= "X"
					Else
						If 	Empty(SD3->D3_DOC)
							RestArea(aArea)
							ZAQ->(DbSetOrder(1))
							If 	ZAQ->(DbSeek(xFilial("ZAQ")+_cCod))
								Do While !ZAQ->(Eof()) .And. ZAQ->ZAQ_FILIAL == xFilial("ZAQ") .And. ZAQ->ZAQ_COD == _cCod
									//Exclui ratieo pois deu erro na inclusão do movimento interno
									RecLock("ZAQ",.F.)
									ZAQ->(DbDelete())
									ZAQ->(MsUnLock())
								EndDo
							EndIf
							//Realiza Exclusao da Recepcao de Ovos
							ZAP->(DbSetOrder(1))
							If 	ZAP->(DbSeek(xFilial("ZAP")+_cCod))
								RecLock("ZAP",.F.)
								ZAP->(DbDelete())
								ZAP->(MsUnLock())
							EndIf
							FwLogMsg("ERROR", , FunName(), , , , "Erro na gravacao -- movimento interno")
							// ::cRetorno	:= "X"
						Else
							RestArea(aArea)
							ZAQ->(DbSetOrder(1))
							If 	ZAQ->(DbSeek(xFilial("ZAQ")+_cCod))
								Do While !ZAQ->(Eof()) .And. ZAQ->ZAQ_FILIAL == xFilial("ZAQ") .And. ZAQ->ZAQ_COD == _cCod
									//Atualiza a numeracao da Movimentacao Gerada
									RecLock("ZAQ",.F.)
									ZAQ->ZAQ_MVINT	:= SD3->D3_DOC
									ZAQ->(MsUnLock())
									ZAQ->(DbSkip())
								EndDo
							EndIf
							FwLogMsg("INFO", , FunName(), , , , "Movimento interno gravado com sucesso ( "+_cCod+" - "+_cNumRecep+" )")
							// ::cRetorno	:= _cCod
						EndIf
					EndIf
				Else
					// ::cRetorno	:= "R"
				EndIf
			EndIf
		Else
			//Gera Pedido de Compras sem Rateio
			cQuery := " SELECT COUNT(*) AS TOTAL "
			cQuery += " FROM "+RetSqlName("SC7")+" SC7 "
			cQuery += " WHERE SC7.D_E_L_E_T_ = ' ' "
			cQuery += "   AND SC7.C7_FILIAL = '"+_cCodFilial+"' "
			cQuery += "   AND SC7.C7_YRCPOVO = '"+_cNumRecep+"' "
			TcQuery cQuery New Alias "TRB"

			If !TRB->(Eof())
				If TRB->TOTAL > 0
					lGeraPC	:= .F.
				EndIf
			EndIf
			TRB->(DbCloseArea())


			If lGeraPC

				aItens		:= {}
				aCab		:= {}

				If Empty(_cFornece)
					SetSoapFault('Gerar Pedido','Fornecedor n? informado!')
					Return .F.
				EndIf

				If Empty(_cLoja)
					SetSoapFault('Gerar Pedido','Loja n? informado!')
					Return .F.
				EndIf

				For I:= 1 To Len(_aItens)

					aAux	:= {}

					aAdd(aAux,{"C7_PRODUTO"		,AllTrim(_aItens[I][1])				,Nil})
					aAdd(aAux,{"C7_QUANT"		,(_aItens[I][3])		,Nil})
					aAdd(aAux,{"C7_PRECO"		,_aItens[I][2]				,Nil})
					aAdd(aAux,{"C7_TES"			,"081"										,Nil})

					aAdd(aItens,aAux)

				Next I

				If Len(aItens) > 0

					SC7->(DbSetOrder(1))
					SC7->(DbSeek(xFilial("SC7")+"ZZZZZZZZZZZZZZZZZ"))

					cNumPed := GetNumSC7(.T.)
					ConfirmSX8()
					aAdd(aCab,{"C7_FILIAL"	,xFilial("SC7")		,Nil})
					aAdd(aCab,{"C7_NUM"		,cNumPed			,Nil})
					aAdd(aCab,{"C7_EMISSAO"	,dDatabase			,Nil})
					aAdd(aCab,{"C7_FORNECE"	,_cFornece			,Nil})
					aAdd(aCab,{"C7_LOJA"	,_cLoja				,Nil})
					aAdd(aCab,{"C7_COND"	,"037"				,Nil})
					aAdd(aCab,{"C7_CONTATO"	,""					,Nil})
					aAdd(aCab,{"C7_FILENT"	,xFilial("SC7")		,Nil})
					aAdd(aCab,{"C7_YRCPOVO"	,_cNumRecep			,Nil})

					_cA120Oper	:= '51'

					//Chama ExecAuto para gerar o Pedido de Compras
					MsExecAuto({|x,y,z,w,k| Mata120(x,y,z,w,k)},1,aCab,aItens,3,.F.)

					If lMsErroAuto
						DisarmTransaction()
						aErro := GetAutoGRLog()
						For nI := 1 To Len(aErro)
							cErroTemp += aErro[nI] +CRLF
						Next nI

						FwLogMsg("ERROR", , FunName(), , , , cErroTemp)
					Else
						// ::cRetorno	:= cNumPed

						_aAreaSC7	:= SC7->(GetArea())
						SC7->(DbSetOrder(1))
						If SC7->(DbSeek(xFilial("SC7")+cNumPed))
							Do While !SC7->(Eof()) .And. SC7->C7_FILIAL == xFilial("SC7") .And. SC7->C7_NUM == cNumPed

								RecLock("SC7",.F.)
								SC7->C7_YRCPOVO		:= _cNumRecep
								SC7->(MsUnLock())

								SC7->(DbSkip())
							EndDo
						EndIf
						RestArea(_aAreaSC7)

					EndIf
				EndIf
			Else
				// ::cRetorno	:= "E"
			EndIf
		EndIf
	EndIf

Return .T.


User Function COOP15QI()

	Local _cEmpresa 	:= "01"
	Local _cCodFilial  	:= "14"
	Local _cLogin		:= "henry.woelffel"
	Local _cSenha		:= "Coop@2020"   
    Local cQuery3       := " "

	RpcSetType(4)
	RpcSetEnv(_cEmpresa, _cCodFilial, _cLogin, _cSenha, "COM")
    
    cQuery3	:= " SELECT * "
    cQuery3	+= " FROM RAFAEL_COND "
    //cQuery3	+= " WHERE ZAPCOD in ('024965','025456') "
    TcQuery cQuery3 New Alias "TRDA"

    Do While !TRDA->(Eof())
        
        //COOP0015E (TRD->ZAQFILPC, TRD->ZAPRECPOV, TRD->ZAPGUIATR, TRD->ZAPCOND, _cLogin, _cLogin)
        COOP0015I(TRDA->ZAQFILPC, TRDA->ZAPRECPOV, TRDA->ZAPCOND, TRDA->ZAPGUIATR, TRDA->ZAPQTD, TRDA->ZAPDATA, {{TRDA->ZAQPRODUT, TRDA->ZAQVLRUNI, TRDA->ZAPQTD}}, "", "", _cLogin, _cSenha, TRDA->ZAPCOD)

        TRDA->(DbSkip())
    EndDo

    TRDA->(DbCloseArea())

Return


User Function COOP15QE()

	Local _cEmpresa 	:= "01"
	Local _cCodFilial  	:= "14"
	Local _cLogin		:= "henry.woelffel"
	Local _cSenha		:= "Coop@2020"   
    Local cQuery3       := " "

	RpcSetType(4)
	RpcSetEnv(_cEmpresa, _cCodFilial, _cLogin, _cSenha, "COM")
    
    cQuery3	:= " SELECT * "
    cQuery3	+= " FROM RAFAEL_COND "
    //cQuery3	+= " WHERE ZAPCOD = '025456' "
    TcQuery cQuery3 New Alias "TRDA"

    Do While !TRDA->(Eof())
        
        COOP0015E(TRDA->ZAQFILPC, TRDA->ZAPRECPOV, TRDA->ZAPGUIATR, TRDA->ZAPCOND, _cLogin, _cLogin)

        TRDA->(DbSkip())
    EndDo

    TRDA->(DbCloseArea())

Return

Static Function COOP0015E(cCodFilial, cNumRecep, cCodGuia, cLote, cLogin, cSenha)

	// Local _cEmpresa 	:= "01"
	Local _cCodFilial  	:= cCodFilial
	Local _cLote		:= ""
	Local _cCond		:= ""
	Local _cNumRecep	:= ""
	Local _cCodGuia		:= ""
	// Local _cLogin		:= cLogin
	// Local _cSenha		:= cSenha
	Local aCabec		:= {}
	Local aItens		:= {}
	Local cQuery		:= ""
	Local cQuery2		:= ""
	Local cQuery3		:= ""
	Local cYREGESP 		:= ""
	Local aItemMI		:= {}
	Local lExcZAQ		:= .F.
	Local lExcZAP		:= .F.
	Local cErroTemp		:= ""
	Local nI			:= 0
	Local cYOvoLiqTr    := GetMv("MV_YOVOLTR")   // Codigo do ovo liquido e trincado
	Local cYCondOvoL    := GetMv("MV_YCONOVO")   // Codigo do condominio ovo liquido e trincado
	Local lIncLanc 		:= .F.  // verifica se é ovo liquido ou trincado

	//Variaveis Privadas
	//Tratamento de erro do EXECAUTO
	Private lMsErroAuto := .F.
	Private lMsHelpAuto := .T.
	Private lAutoErrNoFile := .T.

	// RpcSetType(4)
	// RpcSetEnv("01", cCodFilial, cLogin, cSenha, "COM")

	cQuery := " SELECT * "
	cQuery += " FROM "+RetSqlName("ZAE")+" ZAE "
	cQuery += " WHERE ZAE.D_E_L_E_T_ = ' ' "
	cQuery += " AND ZAE.ZAE_COD = '"+ cLote +"' "
	TcQuery cQuery New Alias "_ZAE"
	If !_ZAE->(Eof())
		_cLote	:= _ZAE->ZAE_COD
	EndIf
    _ZAE->(DbCloseArea())

	cYREGESP		:= GetMv("MV_YREGESP")
	_cCodFilial  	:= Padr(cCodFilial											, TamSX3("ZAP_FILIAL")[1])
	_cCodGuia 		:= Padr(cCodGuia											, TamSX3("ZAP_GUIATR")[1])
	_cNumRecep 		:= StrZero(Val(cNumRecep),TamSX3("ZAP_RECPOV")[1])
	_cCond			:= Padr(Posicione("ZAF",2,xFilial("ZAF")+_cLote,"ZAF_COD")	, TamSX3("ZAF_COD")[1])


	If !Empty(_cCodGuia)
		//Query para verificar se algum item do rateio foi faturado
		cQuery	:= " SELECT COUNT(*) AS TOTAL "
		cQuery	+= " FROM "+RetSqlName("ZAP")+" ZAP "
		cQuery	+= " INNER JOIN "+RetSqlName("ZAQ")+" ZAQ ON (ZAQ.D_E_L_E_T_ = ZAP.D_E_L_E_T_ "
		cQuery	+= "                       AND ZAP.ZAP_COD = ZAQ.ZAQ_COD) "
		cQuery	+= " INNER JOIN "+RetSqlName("SC7")+" SC7 ON (SC7.D_E_L_E_T_ = ZAP.D_E_L_E_T_ "
		cQuery	+= "                       AND SC7.C7_FILIAL = ZAQ.ZAQ_FILPC "
		cQuery	+= "                       AND SC7.C7_NUM = ZAQ.ZAQ_NUMPC "
		cQuery	+= "                       AND SC7.C7_QUJE >= SC7.C7_QUANT ) "
		cQuery	+= " WHERE ZAP.D_E_L_E_T_ = ' ' "
		cQuery	+= "   AND ZAP.ZAP_COND = '"+_cCond+"' "
		cQuery	+= "   AND ZAP.ZAP_RECPOV = '"+_cNumRecep+"' "
		TcQuery cQuery New Alias "TRB"

		If !TRB->(Eof())

			If TRB->TOTAL > 0
				// ::cRetorno	:= "F"
			Else

				If cYREGESP == "S"

					//Realiza Query para Exclusao da Movimentacao Interna
					cQuery2	:= " SELECT ZAP_COD AS CODIGO "
					cQuery2	+= " FROM "+RetSqlName("ZAP")+" ZAP "
					cQuery2	+= " WHERE ZAP.D_E_L_E_T_ = ' ' "
					cQuery2	+= "   AND ZAP.ZAP_COND = '"+_cCond+"' "
					cQuery2	+= "   AND ZAP.ZAP_RECPOV = '"+_cNumRecep+"'"
					TcQuery cQuery2 New Alias "TRC"

					If !TRC->(Eof())

						//Query para buscar a movimentacao interna
						cQuery3 := " SELECT DISTINCT ZAQ.ZAQ_MVINT AS MOVIMENTO"
						cQuery3 += " FROM "+RetSqlName("ZAQ")+" ZAQ "
						cQuery3 += " WHERE ZAQ.D_E_L_E_T_ = ' ' "
						cQuery3 += "   AND ZAQ.ZAQ_COD = '"+TRC->CODIGO+"' "
						TcQuery cQuery3 New Alias "TRD"

						If !TRD->(Eof()) .And. !Empty(TRD->MOVIMENTO)

							FwLogMsg("INFO", , FunName(), , , , "XXX - contou o array com os dados do ME Filia: " + _cCodFilial )
							SD3->(DbSetOrder(2))
							If SD3->(DbSeek(xFilial("SD3")+ TRD->MOVIMENTO))

								aItemMI		:= {}

								//Dados do Itens da Movimentacao
								Do While !SD3->(Eof()) .And. SD3->D3_FILIAL == xFilial("SD3") .And. SD3->D3_DOC == TRD->MOVIMENTO

									aAdd(aItemMI,{SD3->D3_COD, SD3->D3_QUANT, SD3->D3_CONTA, SD3->D3_LOCAL, SD3->D3_DOC, SD3->D3_EMISSAO, SD3->D3_GRUPO, SD3->D3_CUSTO1, SD3->D3_NUMSEQ, SD3->D3_TIPO, SD3->D3_USUARIO, SD3->D3_CHAVE, SD3->D3_STSERV, SD3->D3_GARANTI, SD3->D3_UM})

									RecLock("SD3",.F.)
									SD3->D3_ESTORNO := "S"
									SD3->(MsUnLock())

									SD3->(DbSkip())
								EndDo

								//Caso encontre Item inicia execucao
								If Len(aItemMI)

									For nI := 1 To Len(aItemMI)

										RecLock("SD3",.T.)
										SD3->D3_FILIAL		:= xFilial("SD3")
										SD3->D3_TM			:= "999"
										SD3->D3_COD			:= aItemMI[nI][1]
										SD3->D3_QUANT		:= aItemMI[nI][2]
										SD3->D3_CF			:= "RE6"
										SD3->D3_CONTA		:= aItemMI[nI][3]
										SD3->D3_LOCAL		:= aItemMI[nI][4]
										SD3->D3_DOC			:= aItemMI[nI][5]
										SD3->D3_EMISSAO		:= aItemMI[nI][6]
										SD3->D3_GRUPO		:= aItemMI[nI][7]
										SD3->D3_CUSTO1		:= aItemMI[nI][8]
										SD3->D3_ESTORNO		:= "S"
										SD3->D3_NUMSEQ		:= aItemMI[nI][9]
										SD3->D3_TIPO		:= aItemMI[nI][10]
										SD3->D3_USUARIO		:= aItemMI[nI][11]
										SD3->D3_CHAVE		:= aItemMI[nI][12]
										SD3->D3_STSERV		:= aItemMI[nI][13]
										SD3->D3_GARANTI		:= aItemMI[nI][14]
										SD3->D3_UM			:= aItemMI[nI][15]

										SD3->(MsUnLock())

									Next nI

									ZAQ->(DbSetOrder(1))
									If ZAQ->(DbSeek(xFilial("ZAQ")+TRC->CODIGO))
										Do While !ZAQ->(Eof()) .And. ZAQ->ZAQ_FILIAL == xFilial("ZAQ") .And. ZAQ->ZAQ_COD == TRC->CODIGO
											//Exclui Movimentacao Gerada
											RecLock("ZAQ",.F.)
											ZAQ->(DbDelete())
											ZAQ->(MsUnLock())

											ZAQ->(DbSkip())

										EndDo
									EndIf

									//Realiza Exclusao da Recepcao de Ovos
									ZAP->(DbSetOrder(1))
									If ZAP->(DbSeek(xFilial("ZAP")+TRC->CODIGO))
										RecLock("ZAP",.F.)
										ZAP->(DbDelete())
										ZAP->(MsUnLock())

									EndIf

									// ::cRetorno	:= "T"

								EndIf
							EndIf
                            //TRD->(DbCloseArea())
						Else
							ZAQ->(DbSetOrder(1))
							If ZAQ->(DbSeek(xFilial("ZAQ")+TRC->CODIGO))
								Do While !ZAQ->(Eof()) .And. ZAQ->ZAQ_FILIAL == xFilial("ZAQ") .And. ZAQ->ZAQ_COD == TRC->CODIGO
									//Atualiza a numeracao da Movimentacao Gerada
									RecLock("ZAQ",.F.)
									ZAQ->(DbDelete())
									ZAQ->(MsUnLock())

									ZAQ->(DbSkip())

									lExcZAQ := .T.
								EndDo
							EndIf

							//Realiza Exclusao da Recepcao de Ovos
							ZAP->(DbSetOrder(1))
							If ZAP->(DbSeek(xFilial("ZAP")+TRC->CODIGO))
								RecLock("ZAP",.F.)
								ZAP->(DbDelete())
								ZAP->(MsUnLock())

								lExcZAP := .T.
							EndIf

							If lExcZAQ .And. lExcZAP
								// ::cRetorno	:= "T"
							Else
								// ::cRetorno	:= "F"
							EndIf

							//TRD->(DbCloseArea())
						EndIf
                        TRD->(DbCloseArea())
					EndIf
					TRC->(DbCloseArea())

				Else

					//Realiza Processo de Exclusao dos Pedidos de Compras
					cQuery2	:= " SELECT ZAP_COD AS CODIGO "
					cQuery2	+= " FROM "+RetSqlName("ZAP")+" ZAP "
					cQuery2	+= " WHERE ZAP.D_E_L_E_T_ = ' ' "
					cQuery2	+= "   AND ZAP.ZAP_COND = '"+_cCond+"' "
					cQuery2	+= "   AND ZAP.ZAP_RECPOV = '"+_cNumRecep+"'"
					TcQuery cQuery2 New Alias "TRC"

					If !TRC->(Eof())

						//Query para Listar Pedidos de Compras gerados no Rateio
						cQuery3	:= " SELECT DISTINCT ZAQ.ZAQ_FILPC AS FILIAL "
						cQuery3	+= " 			   , ZAQ.ZAQ_NUMPC AS PEDIDO "
						cQuery3	+= "			   , ZAQ.ZAQ_CLIENT AS CLIENTE "
						cQuery3 += "			   , ZAQ.ZAQ_LOJA AS LOJA "
						cQuery3	+= " FROM "+RetSqlName("ZAQ")+" ZAQ "
						cQuery3	+= " WHERE ZAQ.D_E_L_E_T_ = ' ' "
						cQuery3	+= " AND ZAQ.ZAQ_COD = '"+TRC->CODIGO+"' "
						TcQuery cQuery3 New Alias "TRD"

						If !TRD->(Eof())

							Do While !TRD->(Eof())
								aCabec := {}
								aItens := {}

								SC7->(DbSetOrder(1))
								If SC7->(DbSeek(TRD->FILIAL+TRD->PEDIDO))

									//Adiciona Dados do Cabecalho
									aAdd(aCabec,{"C7_NUM" 			,SC7->C7_NUM		, Nil})
									aAdd(aCabec,{"C7_EMISSAO" 		,SC7->C7_EMISSAO	, Nil})
									aAdd(aCabec,{"C7_FORNECE" 		,SC7->C7_FORNECE	, Nil})
									aAdd(aCabec,{"C7_LOJA" 			,SC7->C7_LOJA		, Nil})
									aAdd(aCabec,{"C7_COND" 			,SC7->C7_COND		, Nil})
									aAdd(aCabec,{"C7_CONTATO" 		,SC7->C7_CONTATO	, Nil})
									aAdd(aCabec,{"C7_FILENT" 		,SC7->C7_FILENT		, Nil})

									Do While !SC7->(Eof()) .And. SC7->C7_FILIAL == TRD->FILIAL .And. SC7->C7_NUM == TRD->PEDIDO

										aLinha	:= {}

										//Adiciona Itens
										aAdd(aLinha,{"C7_ITEM"			,SC7->C7_ITEM		,Nil})
										aAdd(aLinha,{"C7_PRODUTO"		,SC7->C7_PRODUTO	,Nil})
										aAdd(aLinha,{"C7_QUANT"			,SC7->C7_QUANT		,Nil})
										aAdd(aLinha,{"C7_PRECO"			,SC7->C7_PRECO		,Nil})
										aAdd(aLinha,{"C7_TOTAL"			,SC7->C7_TOTAL		,Nil})

										aAdd(aLinha,{"C7_REC_WT" ,SC7->(RECNO()) ,Nil})
										aAdd(aItens,aLinha)

										SC7->(DbSkip())
									EndDo
								EndIf

								If Len(aItens) > 0

									_cA120Oper	:= '51'

									//Chama ExecAuto para excluir o Pedido de Compras
									MsExecAuto({|x,y,z,w,k| Mata120(x,y,z,w,k)},1,aCabec,aItens,5,.F.)

									If lMsErroAuto
										DisarmTransaction()
										aErro := GetAutoGRLog()
										For nI := 1 To Len(aErro)
											cErroTemp += aErro[nI] +CRLF
										Next nI

										FwLogMsg("ERROR", , FunName(), , , , cErroTemp)
									Else
										//Exclui Itens do Rateio referente ao pedido de compras excluido
										ZAQ->(DbSetOrder(3))
										If ZAQ->(DbSeek(xFilial("ZAQ")+TRC->CODIGO+TRD->CLIENTE+TRD->LOJA))
											Do While !ZAQ->(Eof()) .And. ZAQ->ZAQ_FILIAL == xFilial("ZAQ") .And. ZAQ->ZAQ_COD == TRC->CODIGO .And. ZAQ->ZAQ_CLIENT == TRD->CLIENTE .And. ZAQ->ZAQ_LOJA == TRD->LOJA

												RecLock("ZAQ",.F.)
												ZAQ->(DbDelete())
												ZAQ->(MsUnLock())

												ZAQ->(DbSkip())
											EndDo
										EndIf
									EndIf

								EndIf


								TRD->(DbSkip())
							EndDo

						EndIf
						TRD->(DbCloseArea())

						//Realiza Exclusao da Recepcao de Ovos
						ZAP->(DbSetOrder(1))
						If ZAP->(DbSeek(xFilial("ZAP")+TRC->CODIGO))
							RecLock("ZAP",.F.)
							ZAP->(DbDelete())
							ZAP->(MsUnLock())
							// ::cRetorno	:= "T"

						EndIf

					Else
						// ::cRetorno	:= "G"
					EndIf
					TRC->(DbCloseArea())

				EndIf

			EndIf

		EndIf

		TRB->(DbCloseArea())
	Else
		// verifica se o produto é ovos liquido e trincados conforme parametro
		lIncLanc := .F.
		cQuery10	:= " SELECT ZAQ.ZAQ_PRODUT AS PRODUTO "
		cQuery10	+= " FROM "+RetSqlName("ZAP")+" ZAP "
		cQuery10	+= " INNER JOIN "+RetSqlName("ZAQ")+" ZAQ ON (ZAQ.D_E_L_E_T_ = ZAP.D_E_L_E_T_ "
		cQuery10	+= "                       AND ZAP.ZAP_COD = ZAQ.ZAQ_COD) "
		cQuery10	+= " WHERE ZAP.D_E_L_E_T_ = ' ' "
		cQuery10	+= "   AND ZAP.ZAP_COND = '"+cYCondOvoL+"' "
		cQuery10	+= "   AND ZAP.ZAP_RECPOV = '"+_cNumRecep+"' "
		TcQuery cQuery10 New Alias "TRB10"
		While !TRB10->(Eof())
			If	Alltrim(TRB10->PRODUTO) $ Alltrim(cYOvoLiqTr)
				lIncLanc := .T.
				exit
			EndIf
        	dbSelectArea("TRB10")
        	dbSkip()
			loop
		EndDo
		If	lIncLanc
			//Query para verificar se algum item do rateio foi faturado
			cQuery	:= " SELECT COUNT(*) AS TOTAL "
			cQuery	+= " FROM "+RetSqlName("ZAP")+" ZAP "
			cQuery	+= " INNER JOIN "+RetSqlName("ZAQ")+" ZAQ ON (ZAQ.D_E_L_E_T_ = ZAP.D_E_L_E_T_ "
			cQuery	+= "                       AND ZAP.ZAP_COD = ZAQ.ZAQ_COD) "
			cQuery	+= " INNER JOIN "+RetSqlName("SC7")+" SC7 ON (SC7.D_E_L_E_T_ = ZAP.D_E_L_E_T_ "
			cQuery	+= "                       AND SC7.C7_FILIAL = ZAQ.ZAQ_FILPC "
			cQuery	+= "                       AND SC7.C7_NUM = ZAQ.ZAQ_NUMPC "
			cQuery	+= "                       AND SC7.C7_QUJE >= SC7.C7_QUANT ) "
			cQuery	+= " WHERE ZAP.D_E_L_E_T_ = ' ' "
			cQuery	+= "   AND ZAP.ZAP_COND = '"+cYCondOvoL+"' "
			cQuery	+= "   AND ZAP.ZAP_RECPOV = '"+_cNumRecep+"' "
			TcQuery cQuery New Alias "TRB"

			If !TRB->(Eof())

				If TRB->TOTAL > 0
					FwLogMsg("WARN", , FunName(), , , , "Já houve entrada no pedido de compra")
					// ::cRetorno	:= "F"
				Else

					If cYREGESP == "S"

						//Realiza Query para Exclusao da Movimentacao Interna
						cQuery2	:= " SELECT ZAP_COD AS CODIGO "
						cQuery2	+= " FROM "+RetSqlName("ZAP")+" ZAP "
						cQuery2	+= " WHERE ZAP.D_E_L_E_T_ = ' ' "
						cQuery2	+= "   AND ZAP.ZAP_COND = '"+cYCondOvoL+"' "
						cQuery2	+= "   AND ZAP.ZAP_RECPOV = '"+_cNumRecep+"'"
						TcQuery cQuery2 New Alias "TRC"

						If !TRC->(Eof())

							//Query para buscar a movimentacao interna
							cQuery3 := " SELECT DISTINCT ZAQ.ZAQ_MVINT AS MOVIMENTO"
							cQuery3 += " FROM "+RetSqlName("ZAQ")+" ZAQ "
							cQuery3 += " WHERE ZAQ.D_E_L_E_T_ = ' ' "
							cQuery3 += "   AND ZAQ.ZAQ_COD = '"+TRC->CODIGO+"' "
							TcQuery cQuery3 New Alias "TRD"

							If !TRD->(Eof()) .And. !Empty(TRD->MOVIMENTO)

								FwLogMsg("INFO", , FunName(), , , , "XXX - contou o array com os dados do ME Filial: " + _cCodFilial )
								SD3->(DbSetOrder(2))
								If SD3->(DbSeek(xFilial("SD3")+ TRD->MOVIMENTO))

									aItemMI		:= {}

									//Dados do Itens da Movimentacao
									Do While !SD3->(Eof()) .And. SD3->D3_FILIAL == xFilial("SD3") .And. SD3->D3_DOC == TRD->MOVIMENTO

										aAdd(aItemMI,{SD3->D3_COD, SD3->D3_QUANT, SD3->D3_CONTA, SD3->D3_LOCAL, SD3->D3_DOC, SD3->D3_EMISSAO, SD3->D3_GRUPO, SD3->D3_CUSTO1, SD3->D3_NUMSEQ, SD3->D3_TIPO, SD3->D3_USUARIO, SD3->D3_CHAVE, SD3->D3_STSERV, SD3->D3_GARANTI, SD3->D3_UM})

										RecLock("SD3",.F.)
										SD3->D3_ESTORNO := "S"
										SD3->(MsUnLock())

										SD3->(DbSkip())
									EndDo

									//Caso encontre Item inicia execucao
									If Len(aItemMI)

										For nI := 1 To Len(aItemMI)

											RecLock("SD3",.T.)
											SD3->D3_FILIAL		:= xFilial("SD3")
											SD3->D3_TM			:= "999"
											SD3->D3_COD			:= aItemMI[nI][1]
											SD3->D3_QUANT		:= aItemMI[nI][2]
											SD3->D3_CF			:= "RE6"
											SD3->D3_CONTA		:= aItemMI[nI][3]
											SD3->D3_LOCAL		:= aItemMI[nI][4]
											SD3->D3_DOC			:= aItemMI[nI][5]
											SD3->D3_EMISSAO		:= aItemMI[nI][6]
											SD3->D3_GRUPO		:= aItemMI[nI][7]
											SD3->D3_CUSTO1		:= aItemMI[nI][8]
											SD3->D3_ESTORNO		:= "S"
											SD3->D3_NUMSEQ		:= aItemMI[nI][9]
											SD3->D3_TIPO		:= aItemMI[nI][10]
											SD3->D3_USUARIO		:= aItemMI[nI][11]
											SD3->D3_CHAVE		:= aItemMI[nI][12]
											SD3->D3_STSERV		:= aItemMI[nI][13]
											SD3->D3_GARANTI		:= aItemMI[nI][14]
											SD3->D3_UM			:= aItemMI[nI][15]

											SD3->(MsUnLock())

										Next nI

										ZAQ->(DbSetOrder(1))
										If ZAQ->(DbSeek(xFilial("ZAQ")+TRC->CODIGO))
											Do While !ZAQ->(Eof()) .And. ZAQ->ZAQ_FILIAL == xFilial("ZAQ") .And. ZAQ->ZAQ_COD == TRC->CODIGO
												//Exclui Movimentacao Gerada
												RecLock("ZAQ",.F.)
												ZAQ->(DbDelete())
												ZAQ->(MsUnLock())

												ZAQ->(DbSkip())

											EndDo
										EndIf

										//Realiza Exclusao da Recepcao de Ovos
										ZAP->(DbSetOrder(1))
										If ZAP->(DbSeek(xFilial("ZAP")+TRC->CODIGO))
											RecLock("ZAP",.F.)
											ZAP->(DbDelete())
											ZAP->(MsUnLock())

										EndIf
										FwLogMsg("INFO", , FunName(), , , , "Exclusão realizada com sucesso!!")
										// ::cRetorno	:= "T"

									EndIf
								EndIf
							Else
								ZAQ->(DbSetOrder(1))
								If ZAQ->(DbSeek(xFilial("ZAQ")+TRC->CODIGO))
									Do While !ZAQ->(Eof()) .And. ZAQ->ZAQ_FILIAL == xFilial("ZAQ") .And. ZAQ->ZAQ_COD == TRC->CODIGO
										//Atualiza a numeracao da Movimentacao Gerada
										RecLock("ZAQ",.F.)
										ZAQ->(DbDelete())
										ZAQ->(MsUnLock())

										ZAQ->(DbSkip())

										lExcZAQ := .T.
									EndDo
								EndIf

								//Realiza Exclusao da Recepcao de Ovos
								ZAP->(DbSetOrder(1))
								If ZAP->(DbSeek(xFilial("ZAP")+TRC->CODIGO))
									RecLock("ZAP",.F.)
									ZAP->(DbDelete())
									ZAP->(MsUnLock())

									lExcZAP := .T.
								EndIf

								If lExcZAQ .And. lExcZAP
									FwLogMsg("INFO", , FunName(), , , , "Exclusão realizada com sucesso!!")
									// ::cRetorno	:= "T"
								Else
									FwLogMsg("ERROR", , FunName(), , , , "Falha na Exclusão !!")
									// ::cRetorno	:= "F"
								EndIf

								TRD->(DbCloseArea())
							EndIf
						EndIf
						TRC->(DbCloseArea())

					Else

						//Realiza Processo de Exclusao dos Pedidos de Compras
						cQuery2	:= " SELECT ZAP_COD AS CODIGO "
						cQuery2	+= " FROM "+RetSqlName("ZAP")+" ZAP "
						cQuery2	+= " WHERE ZAP.D_E_L_E_T_ = ' ' "
						cQuery2	+= "   AND ZAP.ZAP_COND = '"+cYCondOvoL+"' "
						cQuery2	+= "   AND ZAP.ZAP_RECPOV = '"+_cNumRecep+"'"
						TcQuery cQuery2 New Alias "TRC"

						If !TRC->(Eof())

							//Query para Listar Pedidos de Compras gerados no Rateio
							cQuery3	:= " SELECT DISTINCT ZAQ.ZAQ_FILPC AS FILIAL "
							cQuery3	+= " 			   , ZAQ.ZAQ_NUMPC AS PEDIDO "
							cQuery3	+= "			   , ZAQ.ZAQ_CLIENT AS CLIENTE "
							cQuery3 += "			   , ZAQ.ZAQ_LOJA AS LOJA "
							cQuery3	+= " FROM "+RetSqlName("ZAQ")+" ZAQ "
							cQuery3	+= " WHERE ZAQ.D_E_L_E_T_ = ' ' "
							cQuery3	+= " AND ZAQ.ZAQ_COD = '"+TRC->CODIGO+"' "
							TcQuery cQuery3 New Alias "TRD"

							If !TRD->(Eof())

								Do While !TRD->(Eof())
									aCabec := {}
									aItens := {}

									SC7->(DbSetOrder(1))
									If SC7->(DbSeek(TRD->FILIAL+TRD->PEDIDO))

										//Adiciona Dados do Cabecalho
										aAdd(aCabec,{"C7_NUM" 			,SC7->C7_NUM		, Nil})
										aAdd(aCabec,{"C7_EMISSAO" 		,SC7->C7_EMISSAO	, Nil})
										aAdd(aCabec,{"C7_FORNECE" 		,SC7->C7_FORNECE	, Nil})
										aAdd(aCabec,{"C7_LOJA" 			,SC7->C7_LOJA		, Nil})
										aAdd(aCabec,{"C7_COND" 			,SC7->C7_COND		, Nil})
										aAdd(aCabec,{"C7_CONTATO" 		,SC7->C7_CONTATO	, Nil})
										aAdd(aCabec,{"C7_FILENT" 		,SC7->C7_FILENT		, Nil})

										Do While !SC7->(Eof()) .And. SC7->C7_FILIAL == TRD->FILIAL .And. SC7->C7_NUM == TRD->PEDIDO

											aLinha	:= {}

											//Adiciona Itens
											aAdd(aLinha,{"C7_ITEM"			,SC7->C7_ITEM		,Nil})
											aAdd(aLinha,{"C7_PRODUTO"		,SC7->C7_PRODUTO	,Nil})
											aAdd(aLinha,{"C7_QUANT"			,SC7->C7_QUANT		,Nil})
											aAdd(aLinha,{"C7_PRECO"			,SC7->C7_PRECO		,Nil})
											aAdd(aLinha,{"C7_TOTAL"			,SC7->C7_TOTAL		,Nil})

											aAdd(aLinha,{"C7_REC_WT" ,SC7->(RECNO()) ,Nil})
											aAdd(aItens,aLinha)

											SC7->(DbSkip())
										EndDo
									EndIf

									If Len(aItens) > 0

										_cA120Oper	:= '51'

										//Chama ExecAuto para excluir o Pedido de Compras
										MsExecAuto({|x,y,z,w,k| Mata120(x,y,z,w,k)},1,aCabec,aItens,5,.F.)

										If lMsErroAuto
											DisarmTransaction()
											aErro := GetAutoGRLog()
											For nI := 1 To Len(aErro)
												cErroTemp += aErro[nI] +CRLF
											Next nI

											FwLogMsg("ERROR", , FunName(), , , , cErroTemp)
										Else
											//Exclui Itens do Rateio referente ao pedido de compras excluido
											ZAQ->(DbSetOrder(3))
											If ZAQ->(DbSeek(xFilial("ZAQ")+TRC->CODIGO+TRD->CLIENTE+TRD->LOJA))
												Do While !ZAQ->(Eof()) .And. ZAQ->ZAQ_FILIAL == xFilial("ZAQ") .And. ZAQ->ZAQ_COD == TRC->CODIGO .And. ZAQ->ZAQ_CLIENT == TRD->CLIENTE .And. ZAQ->ZAQ_LOJA == TRD->LOJA

													RecLock("ZAQ",.F.)
													ZAQ->(DbDelete())
													ZAQ->(MsUnLock())

													ZAQ->(DbSkip())
												EndDo
											EndIf
										EndIf

									EndIf


									TRD->(DbSkip())
								EndDo

							EndIf
							TRD->(DbCloseArea())

							//Realiza Exclusao da Recepcao de Ovos
							ZAP->(DbSetOrder(1))
							If ZAP->(DbSeek(xFilial("ZAP")+TRC->CODIGO))
								RecLock("ZAP",.F.)
								ZAP->(DbDelete())
								ZAP->(MsUnLock())
								FwLogMsg("INFO", , FunName(), , , , "Exclusão realizada com sucesso!!")
								//::cRetorno	:= "T"

							EndIf

						Else
							// ::cRetorno	:= "G"
						EndIf
						TRC->(DbCloseArea())

					EndIf

				EndIf

			EndIf

			TRB->(DbCloseArea())

		Else
			//Pesquisa se pode ser excluido o documento de recepacao de Fornecedor
			cQuery := " SELECT SC7.C7_FILIAL AS FILIAL "
			cQuery += "      , SC7.C7_NUM AS PEDIDO "
			cQuery += " FROM "+RetSqlName("SC7")+" SC7 "
			cQuery += " WHERE SC7.D_E_L_E_T_ = ' ' "
			cQuery += "   AND SC7.C7_FILIAL = '"+_cCodFilial+"' "
			cQuery += "   AND SC7.C7_YRCPOVO = '"+_cNumRecep+"' "
			cQuery += "   AND SC7.C7_QUJE = 0 "
			TcQuery cQuery New Alias "TRB"

			If !TRB->(Eof())

				aCabec := {}
				aItens := {}

				SC7->(DbSetOrder(1))
				If SC7->(DbSeek(TRB->FILIAL+TRB->PEDIDO))

					//Adiciona Dados do Cabecalho
					aAdd(aCabec,{"C7_NUM" 			,SC7->C7_NUM		, Nil})
					aAdd(aCabec,{"C7_EMISSAO" 		,SC7->C7_EMISSAO	, Nil})
					aAdd(aCabec,{"C7_FORNECE" 		,SC7->C7_FORNECE	, Nil})
					aAdd(aCabec,{"C7_LOJA" 			,SC7->C7_LOJA		, Nil})
					aAdd(aCabec,{"C7_COND" 			,SC7->C7_COND		, Nil})
					aAdd(aCabec,{"C7_CONTATO" 		,SC7->C7_CONTATO	, Nil})
					aAdd(aCabec,{"C7_FILENT" 		,SC7->C7_FILENT		, Nil})

					Do While !SC7->(Eof()) .And. SC7->C7_FILIAL == TRB->FILIAL .And. SC7->C7_NUM == TRB->PEDIDO

						aLinha	:= {}

						//Adiciona Itens
						aAdd(aLinha,{"C7_ITEM"			,SC7->C7_ITEM		,Nil})
						aAdd(aLinha,{"C7_PRODUTO"		,SC7->C7_PRODUTO	,Nil})
						aAdd(aLinha,{"C7_QUANT"			,SC7->C7_QUANT		,Nil})
						aAdd(aLinha,{"C7_PRECO"			,SC7->C7_PRECO		,Nil})
						aAdd(aLinha,{"C7_TOTAL"			,SC7->C7_TOTAL		,Nil})

						aAdd(aLinha,{"C7_REC_WT" ,SC7->(RECNO()) ,Nil})
						aAdd(aItens,aLinha)

						SC7->(DbSkip())
					EndDo
				EndIf

				If Len(aItens) > 0

					_cA120Oper	:= '51'

					//Chama ExecAuto para excluir o Pedido de Compras
					MsExecAuto({|x,y,z,w,k| Mata120(x,y,z,w,k)},1,aCabec,aItens,5,.F.)

					If lMsErroAuto
						DisarmTransaction()
						cErroTemp:=Mostraerro()
						FwLogMsg("ERROR", , FunName(), , , , cErroTemp)
					Else
						// ::cRetorno	:= "T"
					EndIf

				EndIf

			Else
				// ::cRetorno	:= "F"
			EndIf
			TRB->(DbCloseArea())

		EndIf
	EndIf

Return .T.
