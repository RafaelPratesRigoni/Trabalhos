#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TBICODE.CH"
#INCLUDE 'PARMTYPE.CH'

#DEFINE _ENTER CHR(13)+CHR(10)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºProgram   ³ M460FIM	ºAuthor ³ Ylram Mariani		 º Date ³  12/12/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Este P.E. e' chamado apos a Gravacao da NF de Saida, 	  º±±
±±º          ³ e fora da transacao.					  					  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUse       ³ SIGAFAT - MATA461 - GRAVACAO DA NOTA FISCAL DE SAIDA       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function M460FIM()
	Local aCampos		:= {}
	Local aDadosBanco	:= {}
	Local aArea			:= GetArea()
	Local aAreaSF3		:= SF3->(GetArea())
	Local aAreaSF4		:= SF4->(GetArea())
	Local aAreaSD2		:= SD2->(GetArea())
	Local lYBOLGRF		:= GetMv("MV_YBOLGRF") 		//Verifica se imprime boleto grafico
	Local cYFILNFE		:= GetMV("MV_YFILNFE") 		//Filiais que emitem NF-e
	Local cForma		:= Alltrim(SC5->C5_FORMA)
	Local cFluig		:= ""
	Local cErro			:= ""
	Local cQuery		:= ""
	Local nValDifal		:= 0

	//Grava a tag de retorno manual
	If SC5->C5_YRET == "M" .and. cFilAnt == "48"
		RecLock("SF2",.F.)
		SF2->F2_YRET := "M"
		SF2->(MsUnlock())
	EndIf

	//Atualiza legenda barter
	StatBarter()

	cQuery := GetNextAlias()

	BeginSql ALIAS cQuery
		SELECT
		    SUM(CASE
		            WHEN SD2.D2_UM    = 'CX' THEN SD2.D2_QUANT
		            WHEN SD2.D2_SEGUM = 'CX' THEN SD2.D2_QTSEGUM
				ELSE 0
				END
		    ) AS CAIXAS
		FROM %TABLE:SD2% SD2
		WHERE SD2.%NOTDEL%
		  AND SD2.D2_FILIAL  = %Exp:SF2->F2_FILIAL%
		  AND SD2.D2_DOC     = %Exp:SF2->F2_DOC%
		  AND SD2.D2_SERIE   = %Exp:SF2->F2_SERIE%
		  AND SD2.D2_CLIENTE = %Exp:SF2->F2_CLIENTE%
		  AND SD2.D2_LOJA    = %Exp:SF2->F2_LOJA%
	EndSql

	If (cQuery)->(!Eof()) .and. !U_CAFA022()
		Reclock("SF2", .F.)
		SF2->F2_VOLUME1 := (cQuery)->(CAIXAS)
		SF2->F2_ESPECI1 := "CAIXAS"
		SF2->(MsUnlock())
	EndIf

	(cQuery)->(DbCloseArea())



	SD2->(DbSetOrder(3))
	If SD2->(DbSeek(SF2->(F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA)))
		RecLock("SF2",.F.)
		SF2->F2_YLIBDEV := !AllTrim(SD2->D2_CF) $ "5101_5102_5405_5656_5117_5116_5118_5922_6101_6102_6405_6656_6117_6116_6118_6922"
		SF2->(MsUnLock())

		Do While SD2->(!Eof()) .And. SF2->(F2_FILIAL + F2_DOC + F2_SERIE + F2_CLIENTE + F2_LOJA) == SD2->(D2_FILIAL + D2_DOC + D2_SERIE + D2_CLIENTE + D2_LOJA)
			nValDifal += SD2->D2_DIFAL
			SD2->(DbSkip())
		EndDo
	EndIf

	// ------------------------------------------------
	//  Verifica se o documento possui DIFAL
	//  e abre o processo para pagamento pelo fiscal
	// ------------------------------------------------
	If nValDifal > 0
		Alert("Essa saída interestadual possui ICMS de diferencial de alíquotas para ser recolhida, procure o setor fiscal para emissão da guia e pagamento.")

		aAdd(aCampos, {"txtFilial"			, SF2->F2_FILIAL})
		aAdd(aCampos, {"txtDocumento"		, SF2->F2_DOC})
		aAdd(aCampos, {"txtSerie"			, SF2->F2_SERIE})
		aAdd(aCampos, {"txtData"			, DtoC(SF2->F2_EMISSAO)})
		aAdd(aCampos, {"txtValorDocumento"	, AllTrim(Transform(SF2->F2_VALBRUT, "@E 999,999,999.99"))})
		aAdd(aCampos, {"txtValorDifal"		, AllTrim(Transform(nValDifal, "@E 999,999,999.99"))})
		aAdd(aCampos, {"txtEstado"			, SF2->F2_EST})

		cFluig := U_FLUIG02C("Solicitacao_Pagamento_Difal", 5, {"Pool:Group:WF_Solicitacao_Pagamento_Difal_5"}, aCampos, @cErro)

		If Empty(cErro)
			U_ZAXNovo("SF2", SF2->(Recno()), "Solicitacao_Pagamento_Difal", cFluig)
		Else
			ShowHelpDlg("M460FIM", {"Falha ao iniciar o processo de pagamento de DIFAL.", cErro}, 3, {"Procure o setor FISCAL"}, 2)
		EndIf
	EndIf

	If IsInCallStack("MATA460B")
		Reclock("SF2", .F.)
		SF2->F2_YOBS := DAK->DAK_YOBSNF
		SF2->(MsUnlock())
	Else
		u_CAFA023()
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Utiliza a geracao automatica do pedido de compra quando houver devolucao de terceiros em nosso poder do Template Cafe			³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	u_CAFA029()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Geracao do Pedido de Compra na Transferencia do CD sem Processo completo de "Processar PC"										³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	u_COMA0013()

	RestArea(aArea)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Chama a rotina de impressao da nota fiscal apenas para as filiais que nao emitem NF-e			³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !(cFilAnt $ cYFILNFE)
		Execblock("COPRNFS",.F.,.F.)
	EndIf

	//-----------------------------------------------------------
	// Data criação: 10-02-2020.
	// Autor: Totvs ES.
	// Descrição: Chama rotina de geração da DAE.
	//-----------------------------------------------------------
	U_FATAY026()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se for BOLETO BANCARIO, FINANCIAMENTO, FINANCIAMENTO MAQUINAS, BARTER ou CAMPANHA e foi gerado contas a receber, chama a tela de impressao do boleto.			³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ("BO" $ cForma .Or. "FN" $ cForma .Or. "MQ" $ cForma .Or. "BT" $ cForma .Or. "CM" $ cForma) .And. SE1->(DbSeek(xFilial("SE1")+SC5->C5_SERIE+SC5->C5_NOTA)) .And. !FWIsInCallStack("MATA460B")
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Banco, agencia e conta corrente para impressao do boleto bancario			³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cYBCOBOL := GetMv("MV_YBCOBOL")

		If Empty(cYBCOBOL)
			Aviso("Erro", "Configure o parametro MV_YBCOBOL para efetuar a impressão do boleto bancário.", {"Ok"},,"Atenção")
		Else
			aDadosBanco	:= StrTokArr(cYBCOBOL, "/")

			If lYBOLGRF

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Atualiza parametros da rotina C_FINR600 com dados do cupom impresso de modo que o usuario nao necessita digitar.			³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				U_GRVPERG("COPR05",{ {"01",aDadosBanco[1]},{"02",aDadosBanco[2]},{"03",aDadosBanco[3]},{"04",SC5->C5_SERIE},{"05",SC5->C5_SERIE},{"06",SC5->C5_NOTA},{"07",SC5->C5_NOTA},{"08"," "},{"09"," "},{"10","   "},{"11","   "},{"12",SC5->C5_CLIENTE},{"13",SC5->C5_CLIENTE},{"14",SC5->C5_LOJACLI},{"15",SC5->C5_LOJACLI},{"16",CToD("")},{"17",CToD("")},{"18",CToD("")},{"19",CToD("")} })
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Chama a rotina customizada de impressao do boleto grafico			³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				U_COPR005(.T.)
			Else
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Atualiza parametros da rotina C_FINR600 com dados do cupom impresso de modo que o usuario nao necessita digitar.			³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				U_GRVPERG("COO001",{ {"01",aDadosBanco[1]},{"02",SC5->C5_NOTA},{"03",SC5->C5_NOTA},{"04",NIL},{"05",NIL},{"06",NIL},{"07",NIL},{"08",NIL},{"09",SC5->C5_SERIE} })
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Chama a rotina customizada de impressao do boleto em formulario matricial			³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				U_C_FINR600()
			EndIf
		EndIf

	EndIf

	DbSelectArea("SA2")
	DbSetOrder(1)
	If DbSeek(xFilial("SA2")+ SF2->F2_CLIENTE + SF2->F2_LOJA)
		If A2_L_TPFOR == "P"
			U_M460FIMA(SF2->F2_FILIAL,SF2->F2_DOC,SF2->F2_SERIE,SF2->F2_CLIENTE,SF2->F2_LOJA)
		EndIf
	EndIf

	RestArea(aArea)
	RestArea(aAreaSF3)
	RestArea(aAreaSF4)
	RestArea(aAreaSD2)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºProgram   ³ SF2460I	ºAuthor ³ Ylram Mariani		 º Date ³ 11/08/2014  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de entrada localizado apos a atualizacao das tabelas º±±
±±º          ³ referentes a nota fiscal (SF2/SD2), mas antes da   		  º±±
±±º          ³ contabilizacao. ATENCAO: Este ponto de entrada esta dentro º±±
±±º          ³ da transacao na gravacao das tabelas do documento.		  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUse       ³ SIGAFAT - MATA461 - GRAVACAO DA NOTA FISCAL DE SAIDA       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function SF2460I()

	Local aCampos		:= {}
	Local MV_ATVPCAF	:= GetMv("MV_YATVPCA")
	Local _cAlias		:= ""

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas no Dialog			³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local oDlg
	Local oMark
	Local lInverte 		:= .F.
	Local cMarca 		:= GetMark()
	Local lCompensado	:= .F.

	Private oTempTable	:= Nil

	If u_CAFA022() .And. SF2->F2_SERIE == "   " .And. SC5->C5_YTPSERV == '1' .And. AllTrim(MV_ATVPCAF) == "S"
		_cAlias := fProc()

		(_cAlias)->(dbGoTop())

		If (_cAlias)->(!Eof())
			aAdd(aCampos, {"OK" 			,, "   "							})
			aAdd(aCampos, {"FILIAL"			,, "Filial"							})
			aAdd(aCampos, {"PREFIXO"		,, "Prefixo"						})
			aAdd(aCampos, {"NUM"			,, "Titulo"							})
			aAdd(aCampos, {"TIPO"			,, "Tipo"							})
			aAdd(aCampos, {"VALOR"			,, "Valor",		"@E 999,999,999.99" })
			aAdd(aCampos, {"SALDO"			,, "Saldo",		"@E 999,999,999.99" })
			aAdd(aCampos, {"EMISSAO"		,, "Emissao"						})

			DEFINE MSDIALOG oDlg TITLE "Compensação Automática" FROM  177, 000 TO 790, 790 PIXEL
			@ 005,010 TO 45 , 390 LABEL "" OF oDlg  PIXEL
			@ 050,010 TO 275, 390 LABEL "" OF oDlg  PIXEL

			@ 010, 017 SAY "Filial:"											SIZE 30, 7 OF oDlg PIXEL
			@ 010, 055 SAY SE1->E1_FILIAL										SIZE 30, 7 OF oDlg PIXEL

			@ 020, 017 SAY "Titulo:" 										    SIZE 30, 7 OF oDlg PIXEL
			@ 020, 055 SAY SE1->E1_NUM											SIZE 30, 7 OF oDlg PIXEL

			@ 030, 017 SAY "Prefixo:"		    								SIZE 30, 7 OF oDlg PIXEL
			@ 030, 055 SAY SE1->E1_PREFIXO										SIZE 30, 7 OF oDlg PIXEL

			@ 010, 200 SAY "Cliente:"											SIZE 30, 7 OF oDlg PIXEL
			@ 010, 230 SAY SE1->E1_CLIENTE							  			SIZE 30, 7 OF oDlg PIXEL

			@ 020, 200 SAY "Loja:"      						       			SIZE 30, 7 OF oDlg PIXEL
			@ 020, 230 SAY SE1->E1_LOJA								   			SIZE 30, 7 OF oDlg PIXEL

			@ 030, 200 SAY "Valor:"												SIZE 30, 7 OF oDlg PIXEL
			@ 030, 230 SAY AllTrim(Transform(SE1->E1_VALOR,"@E 999,999.99"))	SIZE 30, 7 OF oDlg PIXEL

			oMark := MsSelect():New(_cAlias, "OK", "", aCampos, @lInverte, @cMarca, {55, 15, 270, 385})
			oMark:bAval := {|| fMarcar(@_cAlias, @cMarca, @oMark)}

			@(oDlg:nHeight/2)-35,(oDlg:nWidth/2)-45 Button "&Ok" 				Size 40, 12 PIXEL OF oDlg Action fOk(@_cAlias, SE1->(Recno()), @oDlg, @lCompensado)

			ACTIVATE MSDIALOG oDlg CENTERED
		EndIf

		(_cAlias)->(DbCloseArea())
		oTempTable:Delete()

	EndIf

Return Nil

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Funcao executada apos o OK na tela de selecao de titulos a compensar³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function fOk(_cAlias, nRecnoTit, oDlg, lCompensado)

	Local aRecnoRA		:= {}
	Local nTaxaCM 		:= 0
	Local aTxMoeda 		:= {}

	oDlg:End()

	(_cAlias)->(DbGoTop())
	Do While (_cAlias)->(!EOF())
		If !Empty((_cAlias)->OK)
			aAdd(aRecnoRA, (_cAlias)->R_E_C_N_O_)
		EndIf
		(_cAlias)->(Dbskip())
	EndDo

	PERGUNTE("AFI340",.F.)
	lContabiliza  	:= MV_PAR11 == 1
	lAglutina   	:= MV_PAR08 == 1
	lDigita   		:= MV_PAR09 == 1
	nTaxaCM			:= RecMoeda(dDataBase,SE1->E1_MOEDA)
	aAdd(aTxMoeda, {1, 1} )
	aAdd(aTxMoeda, {2, nTaxaCM} )

	If !Empty(aRecnoRA)
		If !MaIntBxCR(3,{nRecnoTit},,aRecnoRA,,{lContabiliza,lAglutina,lDigita,.F.,.F.,.F.},,,,,dDatabase )
			Help("XAFCMPAD",1,"HELP","XAFCMPAD","Não foi possível a compensação do titulo do adiantamento",1,0)
		EndIf

		lCompensado := SE1->E1_SALDO = 0
	EndIf

Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Funcao de montagem de alias para utilizacao na tela de 				³
//³	titulos a compensar													³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function fProc()

	Local _cAlias1		:= GETNEXTALIAS()
	Local _cAlias2		:= ""
	Local _aStruct		:= {}

	aAdd(_aStruct, {"OK"		,"C",02,0})
	aAdd(_aStruct, {"FILIAL"	,"C",02,0})
	aAdd(_aStruct, {"PREFIXO"	,"C",03,0})
	aAdd(_aStruct, {"NUM"		,"C",09,0})
	aAdd(_aStruct, {"TIPO"		,"C",03,0})
	aAdd(_aStruct, {"VALOR"		,"N",17,2})
	aAdd(_aStruct, {"SALDO"		,"N",17,2})
	aAdd(_aStruct, {"EMISSAO"	,"D",08,0})
	aAdd(_aStruct, {"RECNO"		,"N",17,0})

	oTempTable := FWTemporaryTable():New("TMP", _aStruct)
	oTempTable:Create()

	_cAlias2 := oTempTable:GetAlias()

	BeginSql ALIAS _cAlias1
		SELECT
			SE1.E1_FILIAL			AS FILIAL,
			SE1.E1_PREFIXO			AS PREFIXO,
			SE1.E1_NUM				AS NUM,
			SE1.E1_TIPO				AS TIPO,
			SE1.E1_VALOR			AS VALOR,
			SE1.E1_SALDO			AS SALDO,
			SE1.E1_EMISSAO			AS EMISSAO,
			SE1.E1_OK				AS OK,
			SE1.R_E_C_N_O_			AS RECNO
		FROM %TABLE:SE1% SE1
		WHERE SE1.E1_TIPO  		= 'RA'
		AND SE1.E1_NATUREZ 		= %EXP:GetMv("MV_YNARACA")%
		AND SE1.E1_SALDO   		> 0
		AND SE1.E1_CLIENTE 		= %EXP:SC5->C5_CLIENTE%
		AND SE1.E1_LOJA	   		= %EXP:SC5->C5_LOJACLI%
		AND SE1.%NOTDEL%
	EndSql

	(_cAlias1)->(DbGoTop())

	Do While (_cAlias1)->(!EOF())
		Reclock(_cAlias2, .T.)

		(_cAlias2)->FILIAL	:= (_cAlias1)->FILIAL
		(_cAlias2)->PREFIXO	:= (_cAlias1)->PREFIXO
		(_cAlias2)->NUM		:= (_cAlias1)->NUM
		(_cAlias2)->TIPO	:= (_cAlias1)->TIPO
		(_cAlias2)->VALOR	:= (_cAlias1)->VALOR
		(_cAlias2)->SALDO	:= (_cAlias1)->SALDO
		(_cAlias2)->EMISSAO	:= SToD((_cAlias1)->EMISSAO)
		(_cAlias2)->RECNO	:= (_cAlias1)->RECNO
		(_cAlias2)->OK		:= ""

		(_cAlias2)->(MsUnlock())

		(_cAlias1)->(Dbskip())
	End Do
	(_cAlias1)->(DbCloseArea())

Return _cAlias2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Funcao para tratamento dos itens marcados na tela de selecao de		³
//³	titulos a compensar													³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function fMarcar(_cAlias, cMarca, oMark)
	RecLock(_cAlias, .F.)
	(_cAlias)->OK := IIF((_cAlias)->OK != cMarca, cMarca, "")
	MsUnlock()

	oMark:oBrowse:Refresh()
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MSD2460   ºAutor  ³Ihorran Milholi     º Data ³  19/01/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de Entrada criado na gravacao dos Itens da NF, para  º±±
±±º          ³ executar um execblock criado pelo usuario apos a gravacao  º±±
±±º          ³ da tabela SD2. 											  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParam.    ³ cAliasSD2: PARAMIXB[1], Alias da tabela SD2.      		  º±±
±±º          ³ lForceEst: PARAMIXB[2], Forca a atualizacao de estoque.    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUse       ³ SIGAFAT - MATA461 - GRAVACAO DA NOTA FISCAL DE SAIDA       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MSD2460

	Local cMovIntR 	:= AllTrim(GETMV("MV_YAJCUSR"))
	Local aArea		:= GetArea()
	Local aVetorD3	:= {}
	Local cChave	:= ""
	Private lMsErroAuto := .F.
	Private lMsHelpAuto := .T.

	If !Empty(SC6->C6_YCULTRA) .And. Trim(xFilial("SD2")+SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_ITEM) == Trim(xFilial("SC6")+SC6->C6_NOTA+SC6->C6_SERIE+SC6->C6_ITEM)
		//Atualiza informacao da CULTURA.
		SD2->D2_YCULTRA := SC6->C6_YCULTRA
	EndIf

	//Rotina sera executada apenas para as filias que utilizam o template de cafe
	If !Empty(cMovIntR) .And. u_CAFA022()

		//Tratamento para o custo nas movimentacoes de devolucao do cafe de terceiros
		//que nao movimentam estoque
		SF4->(dbSetOrder(1))
		If SF4->(dbSeek(xFilial("SF4")+SD2->D2_TES))

			If SF4->F4_ESTOQUE == 'N' .and. SF4->F4_PODER3 == 'D' .and. SF4->F4_YCOMENC == 'S' .and. SD2->D2_TIPO == 'B'

				SB1->(dbSetOrder(1))
				If SB1->(dbSeek(xFilial("SB1")+SD2->D2_COD))

					//Verifica se o produto e cafe
					If AllTrim(SB1->B1_LIGA) $ 'AR/CO'

						//Gera movimentação interna valorizada para acerto do custo
						cChave		:= "SD2"+SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_TIPO+SD2->D2_CLIENTE+SD2->D2_LOJA

						//Dados para a movimentacao
						aVetorD3 := {	{"D3_FILIAL"	,xFilial("SD3")		,Nil},;
							{"D3_TM"		,cMovIntR			,Nil},;
							{"D3_COD"		,SD2->D2_COD		,Nil},;
							{"D3_LOCAL"		,SD2->D2_LOCAL		,Nil},;
							{"D3_EMISSAO" 	,SD2->D2_EMISSAO 	,Nil},;
							{"D3_CUSTO1"	,SD2->D2_TOTAL		,Nil},;
							{"D3_QUANT"   	,0        			,Nil},;
							{"D3_YCHAVE"	,cChave				,Nil}	}

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³CHAMADA A ROTINA DE MOVIMENTACAO INTERNA³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						MsExecAuto({|x,y| MATA240(x,y)},aVetorD3,3)

						If lMsErroAuto
							DisarmTransaction()
							MostraErro()
						EndIf

					EndIf

				EndIf

			EndIf

		EndIf

	EndIf

	RestArea(aArea)
Return

/*/{Protheus.doc} StatBarter
	(long_description)
	@type  Static Function
	@author Jose Neto
	@since 20/04/2021
	@version 1,0
	@param , param_type, param_descr
	@return , return_type, return_description
	@example
	(examples)
	@see (links_or_references)
	/*/
Static Function StatBarter()
	cQuery      := GetNextAlias()

	BeginSql ALIAS cQuery

        SELECT * FROM %Table:SC5% SC5
        WHERE SC5.%Notdel%
        AND SC5.C5_FILIAL = %Exp:SF2->F2_FILIAL%
        AND SC5.C5_NOTA = %Exp:SF2->F2_DOC%
        AND SC5.C5_SERIE = %Exp:SF2->F2_SERIE%

	EndSql

	cQuerySun      := GetNextAlias()

	BeginSql ALIAS cQuerySun

        SELECT SUM(C6_QTDVEN) - SUM(C6_QTDENT) TOTAL FROM %Table:SC6% SC6
        WHERE SC6.%Notdel%
        AND SC6.C6_FILIAL = %Exp:(cQuery)->C5_FILIAL%
        AND SC6.C6_NUM = %Exp:(cQuery)->C5_NUM%

	EndSql


	DbSelectArea("ZM5")
	ZM5->(DbSetOrder(1))
	ZM5->(DbGoTop())

	If ZM5->(DbSeek(xFilial("ZM5") + (cQuery)->C5_YBARTER + (cQuery)->C5_FILIAL)) //ZM5_FILIAL+ZM5_CODIGO+ZM5_FILORI

		RecLock("ZM5",.F.)

		ZM5->ZM5_STATUS := Iif((cQuerySun)->TOTAL == 0, "A","8")
		ZM5->(MsUnlock())
		ZM5->(DbCloseArea())
	EndIf

	(cQuery)->(DbCloseArea())
	(cQuerySun)->(DbCloseArea())
Return

