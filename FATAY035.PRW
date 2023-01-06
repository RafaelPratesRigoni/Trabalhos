#INCLUDE "PROTHEUS.CH"

/*/{Protheus.doc} User Function FATAY035
    (Geração de pedido de venda de transferencia para filial 35)
    @type  Function
    @author Jose Neto
    @since 26/04/2022
    @version 1.0
    @param , ,
    @return lRet, Bolean, Se ocorrer erro na geração da transferencia restorna falso impedindo a geração da nota fiscal
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function FATAY035()

	FWMsgRun(, {|oSay| FATAY035B(oSay)},"Agurande ! Gerando Pedido de Transferencia ...")
	 Processa({|| FATAY035A()},"Buscando Dados...")

Return Nil 

Static Function FATAY035B(oSay)

	Local cNumPred   := ""
	Local cA1Cod     := "N62048"
	Local cA1Loja    := "35"
	Local cTpOp      := "F"
	Local cE4Codigo  := "001"
	Local nOpcX      := 0
	Local nX         := 0
	Local nY         := 0
	Local aCabec     := {}
	Local aItens     := {}
	Local aLinha     := {}
	Local aErroAuto  := {}
	Local cFilProd   := ""
	Local cC6Local   := "02"
	Local lRet       := .T.
	Local cPeds      := ""
	Private aProds         := {}
	Private lMsErroAuto    := .F.
	Private lAutoErrNoFile := .F.
	
	
	
	FATAY035A()
	
	If Len(aProds) > 0

		//****************************************************************
		//* Inclusao - INÍCIO
		//****************************************************************
		aCabec   := {}
		aItens   := {}
		aLinha   := {}

		Begin Transaction

			For nX := 1 To Len(aProds)

				cNumPred := GetSxeNum("SC5", "C5_NUM")

				If cFilProd == AllTrim(aProds[nX][5])
					Loop
				EndIf
			    
				aCabec   := {}

				aadd(aCabec, {"C5_NUM",     cNumPred,  			Nil})
				aadd(aCabec, {"C5_TIPO",    "N",       			Nil})
				aadd(aCabec, {"C5_CLIENTE", cA1Cod,    			Nil})
				aadd(aCabec, {"C5_LOJACLI", cA1Loja,   			Nil})
				aadd(aCabec, {"C5_LOJAENT", cA1Loja,   			Nil})
				aadd(aCabec, {"C5_CONDPAG", cE4Codigo, 			Nil})
				aadd(aCabec, {"C5_YOPER", 	cTpOp,     			Nil})
				aAdd(aCabec, {"C5_TPFRETE"	,"C",				Nil})
				aadd(aCabec, {"C5_TRANSP", 	aProds[nX][6],     	Nil})
				aadd(aCabec, {"C5_VEICULO", aProds[nX][7],     	Nil})
				cFilProd := Alltrim(aProds[nX][5])

				

				cPeds    += cNumPred + "-" + cFilProd + " / "

				// tramsmissão 
				//aadd(aPeds,{cFilProd,cNumPred})

				cItem := StrZero(1,2)
				aItens := {}

				For nY := 1 To Len(aProds)
					aLinha := {}

					//--- Informando os dados do item do Pedido de Venda
					If cFilProd == Alltrim(aProds[nY][5])

						aLinha := {}
						aadd(aLinha,{"C6_ITEM",     StrZero(nY,2),                  Nil})
						aadd(aLinha,{"C6_PRODUTO",  aProds[nY][1],                  Nil})
						aadd(aLinha,{"C6_QTDVEN",   aProds[nY][2],                  Nil})
						aadd(aLinha,{"C6_PRCVEN",   aProds[nY][3] / aProds[nY][2],  Nil})
						aadd(aLinha,{"C6_PRUNIT",   aProds[nY][3] / aProds[nY][2],  Nil})
						aadd(aLinha,{"C6_VALOR",    Round(aProds[nY][3],2),  		Nil})
						aadd(aLinha,{"C6_LOCAL",    cC6Local ,                      Nil})
						aAdd(aLinha,{"C6_OPER",     cTpOp,                          Nil})
						aadd(aItens, aLinha)

						cItem := Soma1(cItem)
					EndIf
			
					oSay:SetText("Adicionando Itens ao Pedido " + cNumPred +" Filial "+ cFilProd + "...")

				Next nY

				nOpcX := 3

				cFilOld := cFilant
				cFilant := cFilProd

				MSExecAuto({|a, b, c, d| MATA410(a, b, c, d)}, aCabec, aItens, nOpcX, .F.)
				If lMsErroAuto
					MostraErro()
					aErroAuto := GetAutoGRLog()

					FWLogMsg(;
						"INFO",;        //cSeverity      - Informe a severidade da mensagem de log. As opções possíveis são: INFO, WARN, ERROR, FATAL, DEBUG
					"LAST",;        //cTransactionId - Informe o Id de identificação da transação para operações correlatas. Informe "LAST" para o sistema assumir o mesmo id anterior
					"ZCONOUT",;     //cGroup         - Informe o Id do agrupador de mensagem de Log
					,;              //cCategory      - Informe o Id da categoria da mensagem
					,;              //cStep          - Informe o Id do passo da mensagem
					,;              //cMsgId         - Informe o Id do código da mensagem
					,;              //cMessage       - Informe a mensagem de log. Limitada à 10K
					,;              //nMensure       - Informe a uma unidade de medida da mensagem
					,;              //nElapseTime    - Informe o tempo decorrido da transação
					aErroAuto;      //aMessage       - Informe a mensagem de log em formato de Array - Ex: { {"Chave" ,"Valor"} }
					)

					lRet := .F.

				EndIf

			Next nX

			If lRet
				MsgInfo( "Pedidos gerados: " + cPeds, "FATAY035")
				EndTran()
			Else
			DisarmTransaction()
			EndIf

		 		
		End Transaction
	// 	DbSelectArea('SC5')
	// 	DbSetOrder(1)
	// 	MsgInfo("INICIANDO PROCESSO")
	//    If lRet	
	// 		IF SC5->(DbSeek(cFilProd + cNumPred))
			
	// 			MsgYesNo("Pedido Transferencia gravado com o código " + SC5->C5_NUM + ". Deseja REalizar o Faturamento do pedido? Em caso negativo, o pedido deverá ser faturado utilizando a rotina PEDIDOS DE VENDA no módulo FATURAMENTO.")
	// 						cFunName := FunName()
	// 						SetFunName("MATA410")
	// 						Processa({||Ma410PvNfs("SC5", SC5->(Recno()))},"Gerando a nota fiscal.","Processando aguarde...", .F.)
	// 						SetFunName(cFunName)
	// 		EndIf
	// 	ENDIF
	cFilant :=  cFilOld
	//else //menssagem COM AS NOTAS NÃO TRANSMITIDAS
	EndIf

	// RecLock(cAlias, bInsert)
		
	// MsUnlock()

Return lRet

Static Function FATAY035A()
	Local cAliasPrd := GetNextAlias()
	Local cGrupoFil  := GETMV("MV_YGRFI49")
	Local cGrupo := ""


	cGrupoFil :=  FormatIn(cGrupoFil, ",")
	cGrupo      := "%"+cGrupoFil+"%"

	BeginSQL Alias cAliasPrd

        SELECT
            C9_PRODUTO,
            SUM(C9_QTDLIB) C9_QTDLIB,
            ROUND(SUM(C9_PRCVEN), 2) C9_PRCVEN,
            C9_GRUPO,
            DAK.DAK_TRANSP,
            DAK.DAK_CAMINH,
            CASE
                WHEN C9_GRUPO IN %Exp:cGrupo% THEN '49'
                ELSE '47'
            END FILIAL
        FROM
            %Table:DAI% DAI
            INNER JOIN %Table:SC9% SC9 ON SC9.C9_FILIAL = '35'
            AND SC9.C9_CARGA  = DAI.DAI_COD
            AND SC9.C9_SEQCAR = DAI.DAI_SEQCAR
            AND SC9.C9_PEDIDO = DAI.DAI_PEDIDO
            AND SC9.%NotDel%
            INNER JOIN %Table:DAK% DAK ON DAK.DAK_FILIAL = DAI.DAI_FILIAL
            AND DAK.DAK_COD = DAI.DAI_COD
            AND DAK.%NotDel%
            INNER JOIN %Table:SF3% SF3 ON SF3.F3_FILIAL = '35'
            AND SF3.F3_NFISCAL = SC9.C9_NFISCAL
            AND SF3.F3_SERIE = SC9.C9_SERIENF
            AND SF3.%NotDel%
        WHERE
            DAI.DAI_FILIAL = %Exp:xFilial("DAI")%
            AND DAI.DAI_COD = %Exp:DAK->DAK_COD%
            AND DAI.DAI_SEQCAR = %Exp:DAK->DAK_SEQCAR%
			AND SF3.F3_CODRSEF = '100'
			AND DAI.%NotDel%
        GROUP BY
            C9_PRODUTO, C9_GRUPO,DAK.DAK_TRANSP,DAK.DAK_CAMINH
        ORDER BY
            FILIAL,C9_PRODUTO
	EndSQL

	DBSelectArea(cAliasPrd)

	While (cAliasPrd)->(!Eof())
	//	IF (cAliasPrd)->F3_CODRSEF = '100'
			aadd(aProds,{(cAliasPrd)->C9_PRODUTO,(cAliasPrd)->C9_QTDLIB,(cAliasPrd)->C9_PRCVEN,(cAliasPrd)->C9_GRUPO,(cAliasPrd)->FILIAL,(cAliasPrd)->DAK_TRANSP,(cAliasPrd)->DAK_CAMINH})
			(cAliasPrd)->(DbSkip())
	//	ELSE // CRIAR ARRAY PARA RECEBER AS NOTAS NÃO PREOCESSDAS.
		//ENDIF 
	ENDDO

	(cAliasPrd)->(DBCloseArea())
	
Return
