#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "TOPCONN.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ RGLT064     º Autor ³ Ramon Teles           º Data da Criacao  ³ 20/08/2013             						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio Analise da Qualidade         														                º±±
±±º          ³ 	 							                                                                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Gestao do Leite                                                   											º±±
±±º          ³ 	 							                                                                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³                                                                                        						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ Nenhum					                                                                                  	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUsuario   ³															                             						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºSetor     ³ Gestao do Leite	                                                                       						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º            						ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                   						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor     ³ Data     ³ Motivo da Alteracao  				               ³Usuario(Filial+Matricula+Nome)    ³Setor        º±±
±±ÌÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄ¹±±
±±º          ³          ³                    							   ³                                  ³ 			º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function RGLT064(_aToken)

	Private cPerg := "RGLT064"

	Private oReport
	Private lInverte	:= .F.
	Private _lTotem

	SetPrvt("oDlg","oSay")

		//Impressao Relatorio por Token
	If Empty(_aToken)
		Pergunte(cPerg,.T.,'Relatório Analise Qualidade')
	Else
		_lTotem		:= .T.
		mv_par01 	:= _aToken[1]
		mv_par02 	:= _aToken[2]
		mv_par03 	:= _aToken[3]
		mv_par04 	:= _aToken[4]
	EndIf

	sfPrint()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³sfPrint   ³ Autor ³ Ramon Teles           ³ Data ³ 20/08/13 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function sfPrint()

	Local cPerg

	oReport := ReportDef(cPerg)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ReportDef ³ Autor ³ Ramon Teles           ³ Data ³ 20/08/13 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportDef(cPerg)

	Private oReport,oSecZ0
	Private aTam := {}

	oReport := TReport():New("RGLT064","Relatório Analise Qualidade",cPerg,{|oReport|PrintReport()},"Este relatorio ira imprimir as informações da análise da qualidade.")

	oReport:lParamPage	:= .F.
	oReport:lHeaderVisible := .F.
	oReport:lFooterVisible := .F.
	If _lTOTEM
		oReport:cPrinterName	:= ALLTRIM(GETMV("MV_C_PRINT"))
		oReport:SetPreview(.F.)
		oReport:SetDevice(2)
		oReport:SetEnvironment(2)
		oReport:SetMsgPrint("Imprimindo...")
	EndIf
	oReport:SetPortrait(.T.)
	oReport:nLineHeight	:= 45
	oReport:Print(.F.)

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³PrintReport ³ Autor ³ Ramon Teles           ³ Data ³ 20/08/13 º±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Responsavel por montar o relatorio                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³                                                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function PrintReport()

	//Declaracao das Fontes
	Local oFont10 		:= TFont():New("COURIER NEW",10,10,,.F.,,,,.T.,.F.)
	Local oFont10N		:= TFont():New("COURIER NEW",10,10,,.T.,,,,.T.,.F.)
	Local oFont11 		:= TFont():New("COURIER NEW",11,11,,.F.,,,,.T.,.F.)
	Local oFont11N 		:= TFont():New("COURIER NEW",11,11,,.T.,,,,.T.,.F.)
	Local oFont12N		:= TFont():New("COURIER NEW",12,12,,.T.,,,,.T.,.F.)
	Local oFont14N		:= TFont():New("COURIER NEW",14,14,,.T.,,,,.T.,.F.)
	Local oFont16NS		:= TFont():New("COURIER NEW",16,16,,.T.,,,,.T.,.T.)
	Local _cQuery := ""
	Local _cLogo
	Local _cPar01 := Alltrim(mv_par01)
	Local _cPar02 := Alltrim(mv_par02)
	Local _dDtIni := dtos(mv_par03)
	Local _dDtFim := dtos(mv_par04)
	Local _nTab01 := oReport:PageWidth() * 0.02
	Local _nTab02 := oReport:PageWidth() * 0.14
	Local _nTab03 := oReport:PageWidth() * 0.24
	Local _nTab04 := oReport:PageWidth() * 0.34
	Local _nTab05 := oReport:PageWidth() * 0.44
	Local _nTab06 := oReport:PageWidth() * 0.54
	Local _nTab07 := oReport:PageWidth() * 0.64
	Local _nTab08 := oReport:PageWidth() * 0.74
	Local _nTab09 := oReport:PageWidth() * 0.84
	Local _nEST	:= 0
	Local _nGOR := 0
	Local _nESD := 0
	Local _nCCS := 0
	Local _nPRT := 0
	Local _nLAC := 0
	Local _nCBT	:= 0
	Local _nTEST := 0
	Local _nTGOR := 0
	Local _nTESD := 0
	Local _nTCCS := 0
	Local _nTPRT := 0
	Local _nTLAC := 0
	Local _nTNU  := 0
	Local _nTCBT := 0
	Local _nCount := 0
	Local cANACBT	:= GETMV("LT_ANACBT")
	Local cANACCS	:= GETMV("LT_ANACCS")
	Local cANAESD	:= GETMV("LT_ANAESD")
	Local cANAEST	:= GETMV("LT_ANAEST")
	Local cANAGORD	:= GETMV("LT_ANAGORD")
	Local cANALAC	:= GETMV("LT_ANALAC")
	Local cANAPROT	:= GETMV("LT_ANAPROT")
	Local cANAURE	:= GETMV("LT_ANAURE")

	oReport:SkipLine(6)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.02," ",oFont12N)
	oReport:SkipLine(1)

	DbSelectArea("SA2")
	DbSetOrder(1)
	DbSeek(xFilial("SA2")+mv_par01)

	_cLogo := GetSrvProfString("StartPath","")+"lgrl01.bmp"

	oReport:SayBitmap(005,010,_cLogo,162,164)
	oReport:SkipLine(1)

	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.32	, "Relatório Análise da Qualidade" 			,oFont16NS)
	oReport:SkipLine(2)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.05	, "Produtor: " + SA2->A2_NOME      		,oFont14N)
	oReport:SkipLine(1)
	IF SA2->A2_TIPO = "F"
		oReport:Say(oReport:Row(),oReport:PageWidth() * 0.05 , "CNPJ/CPF: " + Transform(AllTrim(SA2->A2_CGC),"@R 999.999.999-99")	 ,oFont12N)
	ELSE
		oReport:Say(oReport:Row(),oReport:PageWidth() * 0.05 , "CNPJ/CPF: " + Transform(AllTrim(SA2->A2_CGC),"@R 99.999.999/9999-99") ,oFont12N)
	ENDIF
	oReport:SkipLine(1)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.05	, "Período de "  + DTOC(mv_par03) + " até "+ DTOC(mv_par04) 		,oFont14N)

	SA2->(DBCLOSEAREA())

	oReport:SkipLine(2)

	oReport:ThinLine()

	oReport:SkipLine(2)

	oReport:Say(oReport:Row(),_nTab01	, "Dt Análise" 			,oFont11)
	oReport:Say(oReport:Row(),_nTab02	, "CBT(mil/ml)"     	,oFont11)
	oReport:Say(oReport:Row(),_nTab03	, "CCS(mil/ml)"     	,oFont11)
	oReport:Say(oReport:Row(),_nTab04	, "ESD(%)"		   		,oFont11)
	oReport:Say(oReport:Row(),_nTab05	, "EST(%)"		   		,oFont11)
	oReport:Say(oReport:Row(),_nTab06	, "GOR(%)"     			,oFont11)
	oReport:Say(oReport:Row(),_nTab07	, "LAC(%)"     			,oFont11)
	oReport:Say(oReport:Row(),_nTab08	, "PRT(%)"     			,oFont11)
	oReport:Say(oReport:Row(),_nTab09	, "UREIA"     			,oFont11)


	_cQuery := " SELECT * "
	_cQuery += " FROM "+RetSqlName("ZLB")+" ZLB  "
	_cQuery += " WHERE " + RetSqlCond("ZLB") + " "
	_cQuery += " AND ZLB.ZLB_RETIRO = '"+_cPar01+"' "
	_cQuery += " AND ZLB.ZLB_RETILJ = '"+_cPar02+"' "
	_cQuery += " AND ZLB.ZLB_DATA BETWEEN '"+_dDtIni+"' AND '"+_dDtFim+"'"
	_cQuery += " ORDER BY ZLB_DATA"


	If Select ("TRB") <> 0
		TRB->(dbCloseArea())
	EndIf

	_cQuery := changeQuery(_cQuery)

	dbUseArea(.T.,"TOPCONN",TCGenQry(,,_cQuery),"TRB",.F.,.T.)

	TRB->(dbGoTop())

	While TRB->(!Eof())

		_dData := TRB->ZLB_DATA
		_nEST := 0
		_nGOR := 0
		_nESD := 0
		_nCCS := 0
		_nPRT := 0
		_nLAC := 0
		_nNU  := 0
		_nCBT := 0

		While TRB->(!Eof()) .And. _dData = TRB->ZLB_DATA

			If TRB->ZLB_TIPOFX =  Alltrim(cANACBT)
				_nCBT += TRB->ZLB_VLRANA
			ElseIf TRB->ZLB_TIPOFX = Alltrim(cANACCS)
				_nCCS += TRB->ZLB_VLRANA
			ElseIf TRB->ZLB_TIPOFX = Alltrim(cANAESD)
				_nESD += TRB->ZLB_VLRANA
			ElseIf TRB->ZLB_TIPOFX = Alltrim(cANAEST)
				_nEST += TRB->ZLB_VLRANA
			ElseIf TRB->ZLB_TIPOFX = Alltrim(cANAGORD)
				_nGOR += TRB->ZLB_VLRANA
			ElseIf TRB->ZLB_TIPOFX = Alltrim(cANALAC)
				_nLAC += TRB->ZLB_VLRANA
			ElseIf TRB->ZLB_TIPOFX = Alltrim(cANAPROT)
				_nPRT += TRB->ZLB_VLRANA
			ElseIf TRB->ZLB_TIPOFX = Alltrim(cANAURE)
				_nNU += TRB->ZLB_VLRANA
			EndIf

			TRB->(dbSkip())

		EndDo

		oReport:SkipLine(1)
		oReport:Say(oReport:Row(),_nTab01	, DTOC(STOD(_dData))	   						,oFont10)
		oReport:Say(oReport:Row(),_nTab02	, cValtoChar(Transform(_nCBT,"@E 9999.99"))    	,oFont10)
		oReport:Say(oReport:Row(),_nTab03	, cValtoChar(Transform(_nCCS,"@E 9999.99"))     ,oFont10)
		oReport:Say(oReport:Row(),_nTab04	, cValtoChar(Transform(_nESD,"@E 9999.99"))  	,oFont10)
		oReport:Say(oReport:Row(),_nTab05	, cValtoChar(Transform(_nEst,"@E 9999.99"))		,oFont10)
		oReport:Say(oReport:Row(),_nTab06	, cValtoChar(Transform(_nGOR,"@E 9999.99"))     	,oFont10)
		oReport:Say(oReport:Row(),_nTab07	, cValtoChar(Transform(_nLAC,"@E 9999.99"))		,oFont10)
		oReport:Say(oReport:Row(),_nTab08	, cValtoChar(Transform(_nPRT,"@E 9999.99"))		,oFont10)
		oReport:Say(oReport:Row(),_nTab09	, cValtoChar(Transform(_nNU,"@E 9999.99"))    	,oFont10)


		_nTEST += IIF(_nEst>0,_nEst,_nTEST)
		_nTGOR += IIF(_nGOR>0,_nGOR,_nTGOR)
		_nTESD += IIF(_nESD>0,_nESD,_nTESD)
		_nTCCS += IIF(_nCCS>0,_nCCS,_nTCCS)
		_nTPRT += IIF(_nPRT>0,_nPRT,_nTPRT)
		_nTLAC += IIF(_nLAC>0,_nLAC,_nTLAC)
		_nTNU  += IIF(_nNU>0,_nNU,_nTNU)
		_nTCBT += IIF(_nCBT>0,_nCBT,_nTCBT)

		_nCount += 1
	EndDo

	//Totalizadores
	oReport:SkipLine(2)
	oReport:Say(oReport:Row(),_nTab01	, "Média"			,oFont11N)
	oReport:Say(oReport:Row(),_nTab02	, cValtoChar(Transform(_nTCBT/_nCount,"@E 9999.99"))    ,oFont10N)
	oReport:Say(oReport:Row(),_nTab03	, cValtoChar(Transform(_nTCCS/_nCount,"@E 9999.99"))    	,oFont10N)
	oReport:Say(oReport:Row(),_nTab04	, cValtoChar(Transform(_nTESD/_nCount,"@E 9999.99"))  	,oFont10N)
	oReport:Say(oReport:Row(),_nTab05	, cValtoChar(Transform(_nTEst/_nCount,"@E 9999.99"))		,oFont10N)
	oReport:Say(oReport:Row(),_nTab06	, cValtoChar(Transform(_nTGOR/_nCount,"@E 9999.99"))    	,oFont10N)
	oReport:Say(oReport:Row(),_nTab07	, cValtoChar(Transform(_nTLAC/_nCount,"@E 9999.99"))		,oFont10N)
	oReport:Say(oReport:Row(),_nTab08	, cValtoChar(Transform(_nTPRT/_nCount,"@E 9999.99"))		,oFont10N)
	oReport:Say(oReport:Row(),_nTab09	, cValtoChar(Transform(_nTNU/_nCount,"@E 9999.99"))    	,oFont10N)

	TRB->(DBCLOSEAREA())

Return