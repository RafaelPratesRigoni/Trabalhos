#INCLUDE "RWMAKE.CH"
#INCLUDE "SHELL.CH"
#INCLUDE "Protheus.ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "RPTDEF.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TOTVS.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ RGLT003  บ Autor ณ Guilherme Fran็a      บ Data da Criacao  ณ 31/01/2019              						บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Demonstrativo do produtor																	  				บฑฑ
ฑฑบ          ณ 																											    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ  				             						                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 														 		บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ Num้rico														                             					บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUsuario   ณ Microsiga                                                                                					บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบSetor     ณ Financeiro			                                                                  						บฑฑ
ฑฑฬออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                   						บฑฑ
ฑฑฬออออออออออัออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออัออออออออออออออออออออออออออออออออออัอออออออออออออนฑฑ
ฑฑบAutor     ณ Data     ณ Motivo da Alteracao  				               ณUsuario(Filial+Matricula+Nome)    ณSetor        บฑฑ
ฑฑบฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤบฑฑ
ฑฑบ          ณ          ณ                                			       ณ                                  ณ   	        บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑบ          ณ          ณ                    							   ณ                                  ณ 			บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑศออออออออออฯออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออออออออออออออออออออออออออออออฯอออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function RGLT003()

	Private dBkDtBase := dDataBase
	Private cPerg 		:= "PRGLT003A"
	Private _cLogo 		:= GetSrvProfString("Startpath","") + "DANFE01.bmp"//"lgrl01.bmp"
	Private oPrinter
	Private cNomePDF	:= 'RGLT003'
	Private _lAuto	:= .f.
	Private _NFUNRURAL := 0
	Private _nCredLeite := 0
	Private _lAcertook := .f.  //Indica se jแ foi executado acerto do leite
	Private _nOutDesc := 0
	Private _cMes := ""
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณCriacao das fontes.                                                     ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	PRIVATE oFontTit
	PRIVATE oFontRod
	PRIVATE oFont07
	PRIVATE oFont07N
	PRIVATE oFont10
	PRIVATE oFont10N
	PRIVATE oFont14N
	PRIVATE oFont14
	PRIVATE oFont12
	PRIVATE oFont12N
	PRIVATE oFontA16N
	PRIVATE oBrush   := TBrush():New( , CLR_GRAY)

	Public _pnVLEITE := 0

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณPergunta n๚mero da proposta a ser impressa.                             ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If !Pergunte(cPerg,.T.)
		Return
	EndIf
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณInicializacao do objeto grafico                                         ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	cNomePDF := 'demonstrativo_'//+Alltrim(MV_PAR01)+'_'+Alltrim(MV_PAR02)

	oPrinter := GetPrint(cNomePDF)

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณCriacao das fontes.                                                     ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oFontTit 	:= TFontEx():New(oPrinter,"Times New Roman",,016,,.T.,,,,,.F.,.F.)
	oFontRod 	:= TFontEx():New(oPrinter,"Times New Roman",,015,,.T.,,,,,.F.,.F.)
	oFont06  	:= TFontEx():New(oPrinter,"Arial",06,06,.F.,.T.,.F.)
	oFont07  	:= TFontEx():New(oPrinter,"Arial",07,07,.F.,.T.,.F.)
	oFont07N  	:= TFontEx():New(oPrinter,"Arial",07,07,.T.,.T.,.F.)
	oFont10  	:= TFontEx():New(oPrinter,"Arial",08,08,.F.,.T.,.F.)
	oFont10N  	:= TFontEx():New(oPrinter,"Arial",08,08,.T.,.T.,.F.)
	oFont14N 	:= TFontEx():New(oPrinter,"Arial",13,13,.T.,.T.,.F.)
	oFont14  	:= TFontEx():New(oPrinter,"Arial",13,13,.F.,.T.,.F.)
	oFont12 	:= TFontEx():New(oPrinter,"Arial",12,12,.F.,.T.,.F.)
	oFont12N	:= TFontEx():New(oPrinter,"Arial",12,12,.T.,.T.,.F.)
	oFontA16N 	:= TFontEx():New(oPrinter,"Arial",,015,,.T.,,,,,.F.,.F.)

	Processa({|| PrintRel() },"Aguarde a abertura do relatorio...",)

	dDataBase := dBkDtBase

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPrintRel  บAutor  ณGuilherme Fran็a    บ Data ณ  23/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Impressao do relatorio.                                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function GetPrint(_pcFileName,_plAdjustToLegacy,cPathInServer,lDisabeSetup)
	Local oPrinter
	DEFAULT _pcFileName := "demonstrativo_"
	DEFAULT _plAdjustToLegacy := .f.
	DEFAULT cPathInServer := GetTempPath()	// define local padrao para gerar arquivo
	DEFAULT lDisabeSetup := .T. 			// .t. desabilita a tela de configura็ใo de impressao

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณCriacao do objeto.                                                     ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

	oPrinter := FWMSPrinter():New(_pcFileName+"_" + DtoS(Date())+ "_"+StrTran(Time(),':','-'), IMP_SPOOL, _plAdjustToLegacy,cPathInServer,lDisabeSetup)

	oPrinter:SetDevice(IMP_SPOOL) //IMP_SPOOL=IMPRESSORA, IMP_PDF=PDF
	oPrinter:SetPortrait() // Formato Retrato
	oPrinter:SetPaperSize(9) // Papel A4
	oPrinter:SetPaperSize(DMPAPER_A4) // Papel A4
	oPrinter:SetMargin(10,10,10,10) // Margem
	oPrinter:Setup()

Return oPrinter

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPrintRel  บAutor  ณGuilherme Fran็a    บ Data ณ  23/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Impressao do relatorio.                                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PrintRel()


	Local _nReg        := 0
	Local _nCont       := 0
	Local _nVlrLtr     := 0
	Local _nDeb        := 0
	Local _nCred       := 0
	Local _cDtBetw     := ""
	Local _aColetas    := {}
	Local _aEveAuto    := {}
	Local _nLFinCol    := 0
	Local _dDtAna      := ""
	Local _cMasc       := ""
	Local _nAux        := 0
	Local _nCEve       := 300
	Local _nCTit       := _nCEve + 30
	Local _nCHis       := _nCTit + 60
	Local _nCVlr       := _nCHis + 110
	Local _cFAIXAS     := AllTrim(SuperGETMV("LT_FAIXEXT",,"010003/010004/010006/")) //Faixas de qualidade para apresentar no demonstrativo
	Local _cFxAux      := ""
	Local _cCFx        := 05
	Local _cHist       := ""
	Local ix           := 0
	Local _nCAna1      := 110
	Local _nCAna2      := 160
	Local _nCAna3      := 210
	Private _nTotCol   := 0
	Private _nLiLin    := 0
	Private _nLiZLA    := 0
	Private _nDias     := 0
	Private _nColD     := 0
	Private _nColV     := 0
	Private _cEVEINSS  := AllTrim(GETMV("LT_EVEINSS"))
	Private _nLinMax   := 770 //800
	Private _cProd     := ""
	Private _cLoja     := " "
	Private _nLin      := 20
	Private _cAlias    := GetNextAlias()
	Private _nColEv    := 220
	Private _nColQtd   := 360
	Private _nColUnit  := 420
	Private _nColDeb   := 490
	Private _nColCred  := 540
	Private _nPag      := 0
	Private _dDtini    := ""
	Private _nDescConv := 0
	Private _nCredConv := 0
	Private _nDevedor  := 0
	Private _aCreditos := {}
	Private _aDebitos  := {}
	Private _aDevedor  := {}
	Private _lFinOK    := .f.
	Private _cEveCred := AllTrim(SuperGETMV("LT_EVECRED",,"300001")) //Evento utilizado no titulo aglutinado de credito
	Private _cEveDeb := AllTrim(SuperGETMV("LT_EVEDEB",,"300002")) //Evento utilizado no titulo aglutinado de debito

	_cFAIXAS := "% ("+ U_AjustSet(_cFAIXAS) + ") %"

	QueryTRB() //Seleciona dados da NF

	DbSelectArea("ZLE")
	DbSetOrder(1)
	MsSeek(xFilial("ZLE")+MV_PAR01)
	dDataBase := ZLE->ZLE_DTFIM
	_dDtini := ZLE->ZLE_DTFIM

 	_nDias := (ZLE->ZLE_DTFIM  - ZLE->ZLE_DTINI) +1

	 _cDtBetw := "% "+DTOS(ZLE->ZLE_DTINI)+" AND "+DTOS(ZLE->ZLE_DTFIM)+" %"


	DbSelectArea(_cAlias)
	Count to _nReg


	DbSelectArea(_cAlias)
	(_cAlias)->(DbGoTop())

	While !(_cAlias)->(Eof())

		_nCont++
		_cProd := (_cAlias)->CODIGO
		_cLoja := (_cAlias)->LOJA
		_nPag	:= 0
		_nTotCol := 0
		_lFinOK := ((_cAlias)->ZLF_FINOK == "S")
		_lAcertook := ((_cAlias)->ZLF_ACERTO == "S")
		DbSelectArea("SA2")
		DbSetOrder(1)
		MsSeek(xFilial("SA2")+_cProd+_cLoja)

		DbSelectArea("ZL3")
		ZL3->(DbSetOrder(1))
		ZL3->(MsSeek(xFilial("ZL3")+SA2->A2_L_LI_RO))

		DbSelectArea("ZL2")
		ZL2->(DbSetOrder(1))
		ZL2->(MsSeek(xFILIAL("ZL2") + (_cAlias)->ZLF_SETOR))


		Cabec()

		_nLiLin := _nLin - 1

		//Consulta para preencher dias de coleta
		BeginSql alias "DTCOLE"
			SELECT SUBSTR(ZLD_DTCOLE,7,2) AS DIA, SUM(ZLD_QTDBOM ) QTD
			FROM %Table:ZLD% ZLD
			WHERE ZLD_DTCOLE  BETWEEN %Exp:_cDtBetw%
			AND ZLD_RETIRO = %Exp:_cProd%
			AND ZLD_RETILJ = %Exp:_cLoja%
			AND ZLD.%NotDel%
			GROUP BY ZLD_DTCOLE
			ORDER BY ZLD_DTCOLE
		EndSql
		While !DTCOLE->(Eof())
			AADD(_aColetas,{Val(DTCOLE->DIA),DTCOLE->QTD})
			_nTotCol+= DTCOLE->QTD
			DTCOLE->(DbSkip())
		EndDo
		DTCOLE->(DbCloseArea())

		For ix := 1 to _nDias
			If ix <= 10
				oPrinter:SayAlign( _nLin,_nColD,StrZero(ix,2),oFont07:oFont,30,10,,0,1 )
				nPos := aScan( _aColetas, { |x| x[1] == ix  } )
				If nPos > 0
					oPrinter:SayAlign( _nLin,_nColV,TRANSFORM(_aColetas[nPos][2],"@E 999,999"),oFont07:oFont,30,10,,1,1 )
				Else
					oPrinter:SayAlign( _nLin,_nColV,TRANSFORM(0,"@E 999,999"),oFont07:oFont,30,10,,1,1 )
				EndIf
			ElseIf ix <= 20
			 	_nLin := IIf(ix=11,_nLiLin,_nLin)
				oPrinter:SayAlign( _nLin,_nColD+60,StrZero(ix,2),oFont07:oFont,30,10,,0,1 )
				nPos := aScan( _aColetas, { |x| x[1] == ix  } )
				If nPos > 0
					oPrinter:SayAlign( _nLin,_nColV+60,TRANSFORM(_aColetas[nPos][2],"@E 999,999"),oFont07:oFont,30,10,,1,1 )
				Else
					oPrinter:SayAlign( _nLin,_nColV+60,TRANSFORM(0,"@E 999,999"),oFont07:oFont,30,10,,1,1 )
				EndIf
			ElseIf ix <= 31
				_nLin := IIf(ix=21,_nLiLin,_nLin)
				oPrinter:SayAlign( _nLin,_nColD+120,StrZero(ix,2),oFont07:oFont,30,10,,0,1 )
				nPos := aScan( _aColetas, { |x| x[1] == ix  } )
				If nPos > 0
					oPrinter:SayAlign( _nLin,_nColV+120,TRANSFORM(_aColetas[nPos][2],"@E 999,999"),oFont07:oFont,30,10,,1,1 )
				Else
					oPrinter:SayAlign( _nLin,_nColV+120,TRANSFORM(0,"@E 999,999"),oFont07:oFont,30,10,,1,1 )
				EndIf
			EndIf
			_nLin+= 8
		Next ix
		_nLin := _nLiLin + 90

		oPrinter:Line( _nLiLin,_nColD+57, _nLin, _nColD+57)
		oPrinter:Line( _nLiLin,_nColD+117, _nLin, _nColD+117)

		oPrinter:Line( _nLin,005, _nLin, _nColEv-10)
		_nLin+=05

		oPrinter:SayAlign( _nLin,010,"Coleta M๊s: ",oFont10N:oFont,100,10,,0,1 )
		oPrinter:SayAlign( _nLin,_nColD+10,TRANSFORM(_nTotCol,"@E 9,999,999"),oFont10:oFont,050,10,,1,1 )

		oPrinter:SayAlign( _nLin,_nColD+080,"M้dia Diแria: ",oFont10N:oFont,100,10,,0,1 )
		oPrinter:SayAlign( _nLin,_nColD+120,TRANSFORM(_nTotCol/_nDias,"@E 99,999.99"),oFont10:oFont,050,10,,1,1 )

		_nLin+=08

		_nLFinCol := _nLin

		_nLin := _nLiLin

		While !(_cAlias)->(Eof()) .AND. (_cProd == (_cAlias)->CODIGO) .and. (_cLoja == (_cAlias)->LOJA)


			If _nLin > (_nLinMax - 50)
				oPrinter:Say(_nLinMax+15,_nColEv,"Continua pr๓xima pแgina ---->"	,oFont12N:oFont)
				oPrinter:EndPage()
				Cabec()

				_nLin+= 10
				_nLiLin := _nLin - 1
			EndIf
			dbSelectArea("ZL8")
			ZL8->(dbSetOrder(1))
			ZL8->(MsSeek(xFilial("ZL8") + (_cAlias)->ZLF_EVENTO))

			If _pnVLEITE == 0 //variแvel publica para compabitiliza็ใo com o cแlculo dos eventos
				_pnVLEITE := (_cAlias)->ZLF_QTDBOM
			EndIf

			If (_cAlias)->ZLF_EVENTO=='020008'
				_cHist := (_cAlias)->ZL8_NREDUZ+" (R$"+TRANSFORM((_cAlias)->ZL8_VALOR,"@E 99.99")+" x " +TRANSFORM(_nTotCol - (SA2->A2_L_VCOTA*_nDias),"@E 99,999")+" litros)"
			ElseIf (_cAlias)->ZLF_EVENTO=='020009'
				_cHist := (_cAlias)->ZL8_NREDUZ+" "+U_PagtoFidel("01","10","T")
			Else
				_cHist := Substr((_cAlias)->ZL8_DESCRI,1,40)
			EndIf

			oPrinter:SayAlign( _nLin,_nColEv,_cHist,oFont10:oFont,230,10,,0,1 )
			If (_cAlias)->ZLF_EVENTO != '020009' //nใo imprime unitแrio da fidelidade.
				oPrinter:SayAlign( _nLin,_nColUnit,IIF((_cAlias)->ZLF_VLRLTR<>0,TRANSFORM((_cAlias)->ZLF_VLRLTR,"@E 99.9999")," "),oFont10:oFont,50,10,,1,1 )
			EndIf
			oPrinter:SayAlign( _nLin,_nColDeb-10,IIF((_cAlias)->ZLF_DEBCRE = "D",TRANSFORM((_cAlias)->ZLF_TOTAL,"@E 999,999.99")," "),oFont10:oFont,50,10,,1,1 )
			oPrinter:SayAlign( _nLin,_nColCred-10,IIF((_cAlias)->ZLF_DEBCRE = "C",TRANSFORM((_cAlias)->ZLF_TOTAL,"@E 999,999.99")," "),oFont10:oFont,50,10,,1,1 )


			_nVlrLtr += (_cAlias)->ZLF_VLRLTR

			_nCred += IIf((_cAlias)->ZLF_DEBCRE = "C",(_cAlias)->ZLF_TOTAL,0)
			_nDeb += IIf((_cAlias)->ZLF_DEBCRE = "D",(_cAlias)->ZLF_TOTAL,0)

			_nLin+= 10

			(_cAlias)->(DbSkip())
		EndDo

		If !_lAcertook //Se nใo executou acerto do leite, simula os valores dos eventos Automแticos e Financeiros

			_nFunrural := U_Funrural(_nCred - _nDeb) //Retorna valor do funrural


			_aEveAuto := ActEveAuto()

			If SA2->(Fieldpos("A2_L_DINSS")) > 0
				If SA2->A2_L_DINSS == 'S' .AND. _nFunrural > 0
					AADD(_aEveAuto,{"DEVOLUวรO FUNRURAL",0,_nFunrural})
				EndIf
			EndIf

			For ix := 1 to Len(_aEveAuto)
				oPrinter:SayAlign( _nLin,_nColEv,_aEveAuto[ix][1],oFont10:oFont,150,10,,0,1 )
				oPrinter:SayAlign( _nLin,_nColDeb-10,TRANSFORM(_aEveAuto[ix][2],"@E 999,999.99"),oFont10:oFont,50,10,,1,1 )
				oPrinter:SayAlign( _nLin,_nColCred-10,TRANSFORM(_aEveAuto[ix][3],"@E 999,999.99"),oFont10:oFont,50,10,,1,1 )

				_nDeb += _aEveAuto[ix][2]
				_nCred += _aEveAuto[ix][3]

				_nLin+= 10
			Next ix

		Endif

		If _nFunrural > 0
			// IMPRESSรO FUNRURAL
			oPrinter:SayAlign( _nLin,_nColEv,"FUNRURAL",oFont10:oFont,150,10,,0,1 )
			oPrinter:SayAlign( _nLin,_nColDeb-10,TRANSFORM(_nFunrural,"@E 999,999.99"),oFont10:oFont,50,10,,1,1 )
			_nLin+= 10
			_nDeb += _nFunrural
		EndIf

		_nLin := IIF(_nLFinCol>_nLin,_nLFinCol,_nLin)

		oPrinter:Line( _nLiLin, _nColEv-10, _nLin,  _nColEv-10)
		oPrinter:Line( _nLiLin, _nColUnit-10, _nLin, _nColUnit-10)
		oPrinter:Line( _nLiLin, _nColDeb-10, _nLin, _nColDeb-10)
		oPrinter:Line( _nLiLin, _nColCred-08, _nLin, _nColCred-08)
		//_nLin+= 10
		_nLiLin := _nLin
		oPrinter:Line( _nLin, 005, _nLin, 590) //linha separa primeiro quadro, dos totais
		_nLin+= 05

		oPrinter:SayAlign( _nLin,_nColUnit-25,"Totais: ",oFont10:oFont,50,10,,1,1 )
		oPrinter:SayAlign( _nLin,_nColUnit,TRANSFORM(_nVlrLtr,"@E 99.9999"),oFont10N:oFont,50,10,,1,1 )
		oPrinter:SayAlign( _nLin,_nColDeb-10,TRANSFORM(_nDeb,"@E 999,999.99"),oFont10N:oFont,50,10,,1,1 )
		oPrinter:SayAlign( _nLin,_nColCred-10,TRANSFORM(_nCred,"@E 999,999.99"),oFont10N:oFont,50,10,,1,1 )
		_nLin+= 10

		oPrinter:Line( _nLin, _nColEv-10, _nLin, 590)
		_nLin+= 05

		EveFinanc(_cProd,_cLoja)

		oPrinter:SayAlign( _nLin,_nColDeb-20,"Outros Cr้ditos: ",oFont10:oFont,70,10,,1,1 )
		oPrinter:SayAlign( _nLin,_nColCred-10,TRANSFORM(_nCredConv,"@E 999,999.99"),oFont10N:oFont,50,10,,1,1 )
		_nLin+= 10
		oPrinter:Line( _nLin, _nColEv-10, _nLin, 590)
		_nLin+= 05

		oPrinter:SayAlign( _nLin,_nColDeb-20,"Conv๊nios: ",oFont10:oFont,70,10,,1,1 )
		oPrinter:SayAlign( _nLin,_nColCred-10,TRANSFORM(_nDescConv,"@E 999,999.99"),oFont10N:oFont,50,10,,1,1 )
		_nLin+= 10
		oPrinter:Line( _nLin, _nColEv-10, _nLin, 590)
		_nLin+= 05

		_nLiquido := _nCred - _nDeb + _nCredConv - _nDescConv
		oPrinter:SayAlign( _nLin,_nColDeb-20,"Lํquido: ",oFont10:oFont,70,10,,1,1 )
		oPrinter:SayAlign( _nLin,_nColCred-10,TRANSFORM(_nLiquido,"@E 999,999.99"),oFont10N:oFont,50,10,,1,1 )
		_nLin+= 10
		oPrinter:Line( _nLin,_nColEv-10, _nLin, 590)
		_nLin+= 10

		// Box leite plus
		oPrinter:Box(_nLiLin+5,010,_nLin-5,_nColEv-15)
		oPrinter:Fillrect( {_nLiLin+5,010,_nLiLin+20,_nColEv-15 }, oBrush, "-2")
		_nLin := _nLiLin + 7
		oPrinter:SayAlign(_nLin,055,"CมLCULO COTA LEITE PLUS",oFont07N:oFont,100,10,CLR_WHITE,0,1 )
		_nLin+= 15
		oPrinter:SayAlign( _nLin,015,"Cota diแria: ",oFont10N:oFont,70,10,,0,1 )
		oPrinter:SayAlign( _nLin,065,TRANSFORM(SA2->A2_L_VCOTA,"@E 999,999.99"),oFont07:oFont,120,10,,1,1 )
		_nLin+= 10
		oPrinter:Line( _nLin,012, _nLin,_nColEv-20)
		_nLin+= 07
		oPrinter:SayAlign( _nLin,015,"M้dia Mensal: ",oFont10N:oFont,70,10,,0,1 )
		oPrinter:SayAlign( _nLin,065,TRANSFORM(_nDias,"@E 99")+" x "+TRANSFORM(SA2->A2_L_VCOTA,"@E 999,999")+" = "+TRANSFORM(_nDias * SA2->A2_L_VCOTA,"@E 999,999,999"),oFont07:oFont,120,10,,1,1 )
		_nLin+= 10
		oPrinter:Line( _nLin,012, _nLin,_nColEv-20)
		_nLin+= 07
		oPrinter:SayAlign( _nLin,015,"Volume Leite Plus: ",oFont10N:oFont,70,10,,0,1 )
		oPrinter:SayAlign( _nLin,075,TRANSFORM(_nTotCol ,"@E 9,999,999")+" - "+TRANSFORM(_nDias * SA2->A2_L_VCOTA,"@E 9,999,999")+" = "+TRANSFORM(_nTotCol - (_nDias * SA2->A2_L_VCOTA),"@E 999,999,999"),oFont07:oFont,120,10,,1,1 )
		_nLin+= 10

		// Box Resultado anแlises
		_nLiLin := _nLin+5
		oPrinter:Fillrect( {_nLiLin,010,_nLin+20,290 }, oBrush, "-2")
		_nLin +=  7
		oPrinter:SayAlign(_nLin,090,"RESULTADO DAS ANมLISES DO LEITE",oFont07N:oFont,150,10,CLR_WHITE,0,1 )
		_nLin+= 13
		oPrinter:SayAlign( _nLin,015,"Anแlise",oFont10N:oFont,70,10,,0,1 )
		oPrinter:SayAlign( _nLin,050,"Refer๊ncia",oFont10N:oFont,70,10,,1,1 )
		For ix := 1 to 3
			_nAux := Month(MonthSub(ZLE->ZLE_DTFIM,3-ix))
			_nCol := &("_nCAna"+Alltrim(cValToChar(ix)))
			_cMes := IIF(Alltrim(MesExtenso(_nAux))=="Marco","Mar็o",Alltrim(MesExtenso(_nAux)))
			oPrinter:SayAlign( _nLin,_nCol,_cMes,oFont10N:oFont,70,10,,1,1 )
		Next ix
		_nLin +=  9
		oPrinter:Line( _nLin,010, _nLin,290)
		_nLin +=  5
		dbSelectArea("ZL9")
		dbSetOrder(1)
		dbSeek(xFILIAL("ZL9"),.t.)

		While !ZL9->(Eof()) .And. xFILIAL("ZL9")==ZL9->ZL9_FILIAL
			If ZL9->ZL9_TIPO == "Q" .AND. ZL9->ZL9_MSBLQL <> "1"
				//ZL9_COD, ZL9_MEDIA,ZL9_DESCRI, ZL9_REFERE
				_cMasc := Iif(ZL9->ZL9_COD $ "010003#010004","@E 9,999,999","@E 99,999.99")
				oPrinter:SayAlign( _nLin,015,Alltrim(ZL9->ZL9_DESCRI),oFont07:oFont,70,10,,0,1 )
				oPrinter:SayAlign( _nLin,050,Alltrim(ZL9->ZL9_REFERE),oFont07:oFont,70,10,,1,1 )
				For ix := 1 to 3
					_dDtAna := MonthSub(ZLE->ZLE_DTFIM,3-ix)
					_nAux := u_getIndice(xFILIAL("ZLB"),ZL2->ZL2_COD,SA2->A2_COD,SA2->A2_LOJA,ZL9->ZL9_CODLAB,ZL9->ZL9_MEDIA,_dDtAna,"3")
					_nCol := &("_nCAna"+Alltrim(cValToChar(ix)))
					oPrinter:SayAlign( _nLin,_nCol,TransForm(_nAux,_cMasc),oFont07:oFont,70,10,,1,1 )
				Next ix
				_nLin +=  8
			EndIf
			ZL9->(DbSkip())
		EndDo
		//oPrinter:Box(_nLiLin,010,_nLin-5,290)
		oPrinter:Line( _nLin,010, _nLin,290)
		oPrinter:Line( _nLiLin,010, _nLin,010)
		oPrinter:Line( _nLiLin,290, _nLin,290)
		//Fim Box Anแlises


		// Box parโmetros da qualidade
		_nLiZLA := _nLin+5
		oPrinter:Fillrect( {_nLiZLA,010,_nLin+20,290 }, oBrush, "-2")
		_nLin +=  7
		oPrinter:SayAlign(_nLin,080,"PARยMETROS DE ANมLISES DA QUALIDADE",oFont07N:oFont,150,10,CLR_WHITE,0,1 )

		BeginSql alias "FAIXA"
			Select * from %Table:ZLA% ZLA
			Where ZLA_SETOR = %Exp:ZL2->ZL2_COD%
			AND ZLA_COD IN %Exp:_cFAIXAS%
			AND ZLA.%notDel%
			ORDER BY ZLA_COD, ZLA_SEQ
		EndSql

		While !FAIXA->(Eof())
			//ZLA_DCRANA, ZLA_FXINI, ZLA_FXFIM, ZLA_VALOR
			_nLin := _nLiZLA + 15
			_cFxAux := FAIXA->ZLA_COD
			oPrinter:SayAlign( _nLin,_cCFx+40,Alltrim(FAIXA->ZLA_DCRANA),oFont10N:oFont,70,10,,0,1 )
			_nLin +=  9
			oPrinter:Line( _nLin,010, _nLin,290)
			_nLin +=  5
			oPrinter:SayAlign( _nLin,_cCFx+10,"MAIOR",oFont06:oFont,70,10,,0,1 )
			oPrinter:SayAlign( _nLin,_cCFx+40,"ATษ",oFont06:oFont,70,10,,0,1 )
			oPrinter:SayAlign( _nLin,_cCFx+57,"VALOR(R$)",oFont06:oFont,70,10,,0,1 )
			_nLin +=  8
			oPrinter:Line( _nLin,010, _nLin,290)
			_nLin +=  5
			While _cFxAux == FAIXA->ZLA_COD
				_cMasc := Iif(FAIXA->ZLA_COD $ "010003#010004","@E 9,999,999","@E 999.99")
				oPrinter:SayAlign( _nLin,_cCFx-25,TransForm(FAIXA->ZLA_FXINI,_cMasc),oFont06:oFont,50,10,,1,1 )
				_nAux := IIF(FAIXA->ZLA_FXFIM>1000,99999,FAIXA->ZLA_FXFIM)
				_cMasc := IIF(FAIXA->ZLA_FXFIM>1000,"@E 9,999,999",_cMasc)
				oPrinter:SayAlign( _nLin,_cCFx,TransForm(_nAux,_cMasc),oFont06:oFont,50,10,,1,1 )
				oPrinter:SayAlign( _nLin,_cCFx+35,TransForm(FAIXA->ZLA_VALOR,"@E 99.999"),oFont06:oFont,50,10,,1,1 )
				_nLin +=  8
				FAIXA->(DbSkip())
			Enddo
			_cCFx += 95
		EndDo
		FAIXA->(DbCloseArea())
		//oPrinter:Box(_nLiZLA,010,_nLin-5,290)
		_cCFx := 100
		oPrinter:Line( _nLiZLA+15,_cCFx, _nLin,_cCFx)
		oPrinter:Line( _nLiZLA+15,_cCFx+100, _nLin,_cCFx+100)

		oPrinter:Line( _nLin,010, _nLin,290)
		oPrinter:Line( _nLiZLA,010, _nLin,010)
		oPrinter:Line( _nLiZLA,290, _nLin,290)

		// Fim Box parโmetros da qualidade



		//Box Detalhamento Cr้ditos
		If Len(_aCreditos)>0
			_nLin := _nLiLin
			oPrinter:Fillrect( {_nLiLin,_nCEve-05,_nLiLin+20,585 }, oBrush, "-2")
			_nLin +=  3
			oPrinter:SayAlign(_nLin,_nCEve+70,"DETALHAMENTO OUTROS CRษDITOS",oFont07N:oFont,150,10,CLR_WHITE,0,1 )
			_nLin+= 7
			oPrinter:SayAlign(_nLin,_nCEve,"Evento",oFont07N:oFont,070,10,CLR_WHITE,0,1 )
			oPrinter:SayAlign(_nLin,_nCTit,"Tํtulo",oFont07N:oFont,070,10,CLR_WHITE,0,1 )
			oPrinter:SayAlign(_nLin,_nCHis,"Observa็ใo",oFont07N:oFont,070,10,CLR_WHITE,0,1 )
			oPrinter:SayAlign(_nLin,_nCVlr,"Valor(R$)",oFont07N:oFont,070,10,CLR_WHITE,1,1 )
			_nLin+= 12
			For ix := 1 to Len(_aCreditos)

				If _nLin > (_nLinMax - 50)
					oPrinter:Say(_nLinMax+15,_nColEv,"Continua pr๓xima pแgina ---->"	,oFont12N:oFont)
					oPrinter:EndPage()
					Cabec()

					_nLin+= 10
					_nLiLin := _nLin - 1
				EndIf

				oPrinter:SayAlign( _nLin,_nCEve,Alltrim(_aCreditos[ix][1]),oFont07:oFont,70,10,,0,1 )
				oPrinter:SayAlign( _nLin,_nCTit,Alltrim(_aCreditos[ix][2]),oFont07:oFont,70,10,,0,1 )
				oPrinter:SayAlign( _nLin,_nCHis,Alltrim(_aCreditos[ix][3]),oFont06:oFont,120,10,,0,1 )
				oPrinter:SayAlign( _nLin,_nCVlr,TRANSFORM(_aCreditos[ix][4],"@E 999,999.99"),oFont07:oFont,70,10,,1,1 )
				_nLin+= 07
				oPrinter:Line( _nLin,_nCEve, _nLin,585)
				_nLin+= 08
			Next ix
			oPrinter:SayAlign( _nLin,_nCHis,"Total: ",oFont07:oFont,100,10,,1,1 )
			oPrinter:SayAlign( _nLin,_nCVlr,TRANSFORM(_nCredConv,"@E 9,999,999.99"),oFont07:oFont,70,10,,1,1 )
			_nLin+= 10
			oPrinter:Line( _nLin,_nCEve-05, _nLin,585)
			oPrinter:Line( _nLiLin,_nCEve-05, _nLin,_nCEve-05)
			oPrinter:Line( _nLiLin,585, _nLin,585)
			_nLin+= 10
			_nLiLin := _nLin
		EndIf
		//Fim BOX Creditos

		//Box Detalhamento D้bitos
		If Len(_aDebitos)>0
			_nLin := _nLiLin
			oPrinter:Fillrect( {_nLiLin,_nCEve-05,_nLiLin+20,585 }, oBrush, "-2")
			_nLin +=  3
			oPrinter:SayAlign(_nLin,_nCEve+70,"DETALHAMENTO CONVสNIOS",oFont07N:oFont,150,10,CLR_WHITE,0,1 )
			_nLin+= 7
			oPrinter:SayAlign(_nLin,_nCEve,"Evento",oFont07N:oFont,070,10,CLR_WHITE,0,1 )
			oPrinter:SayAlign(_nLin,_nCTit,"Tํtulo",oFont07N:oFont,070,10,CLR_WHITE,0,1 )
			oPrinter:SayAlign(_nLin,_nCHis,"Observa็ใo",oFont07N:oFont,070,10,CLR_WHITE,0,1 )
			oPrinter:SayAlign(_nLin,_nCVlr,"Vlr.Pago(R$)",oFont07N:oFont,070,10,CLR_WHITE,1,1 )
			_nLin+= 12
			For ix := 1 to Len(_aDebitos)

				If _nLin > (_nLinMax - 80)
					oPrinter:Say(_nLinMax+15,_nColEv,"Continua pr๓xima pแgina ---->"	,oFont12N:oFont)
					oPrinter:EndPage()
					Cabec()

					_nLin+= 10
					_nLiLin := _nLin - 1
				EndIf

				oPrinter:SayAlign( _nLin,_nCEve,Alltrim(_aDebitos[ix][1]),oFont07:oFont,70,10,,0,1 )
				oPrinter:SayAlign( _nLin,_nCTit,Alltrim(_aDebitos[ix][2]),oFont07:oFont,70,10,,0,1 )
				oPrinter:SayAlign( _nLin,_nCHis,Alltrim(_aDebitos[ix][3]),oFont06:oFont,120,10,,0,1 )
				oPrinter:SayAlign( _nLin,_nCVlr,TRANSFORM(_aDebitos[ix][4],"@E 999,999.99"),oFont07:oFont,70,10,,1,1 )
				_nLin+= 07
				oPrinter:Line( _nLin,_nCEve, _nLin,585)
				_nLin+= 08
			Next ix
			oPrinter:SayAlign( _nLin,_nCHis,"Total: ",oFont07:oFont,100,10,,1,1 )
			oPrinter:SayAlign( _nLin,_nCVlr,TRANSFORM(_nDescConv,"@E 9,999,999.99"),oFont07:oFont,70,10,,1,1 )
			_nLin+= 10
			oPrinter:Line( _nLin,_nCEve-05, _nLin,585)
			oPrinter:Line( _nLiLin,_nCEve-05, _nLin,_nCEve-05)
			oPrinter:Line( _nLiLin,585, _nLin,585)
			_nLin+= 10
			_nLiLin := _nLin
		EndIf
		//Fim BOX Debitos


		//Inicio box titulos Devedor

		If Len(_aDevedor)>0
			_nLin := _nLiLin

			If _nLin > 640 .and. Len(_aDevedor)>3
				oPrinter:Say(_nLinMax+15,_nColEv,"Continua pr๓xima pแgina ---->"	,oFont12N:oFont)
				oPrinter:EndPage()
				Cabec()

				_nLin+= 10
				_nLiLin := _nLin - 1
			EndIf

			oPrinter:Fillrect( {_nLiLin,_nCEve-05,_nLiLin+20,585 }, oBrush, "-2")
			_nLin +=  3
			oPrinter:SayAlign(_nLin,_nCEve+70,"DEBITOS EM ABERTO",oFont07N:oFont,150,10,CLR_WHITE,0,1 )
			_nLin+= 7
			oPrinter:SayAlign(_nLin,_nCEve,"Evento",oFont07N:oFont,070,10,CLR_WHITE,0,1 )
			oPrinter:SayAlign(_nLin,_nCTit,"Tํtulo",oFont07N:oFont,070,10,CLR_WHITE,0,1 )
			oPrinter:SayAlign(_nLin,_nCHis,"Observa็ใo",oFont07N:oFont,070,10,CLR_WHITE,0,1 )
			oPrinter:SayAlign(_nLin,_nCVlr,"Saldo(R$)",oFont07N:oFont,070,10,CLR_WHITE,1,1 )
			_nLin+= 12
			For ix := 1 to Len(_aDevedor)

				If _nLin > (_nLinMax - 80)
					oPrinter:Say(_nLinMax+15,_nColEv,"Continua pr๓xima pแgina ---->"	,oFont12N:oFont)
					oPrinter:EndPage()
					Cabec()

					_nLin+= 10
					_nLiLin := _nLin - 1
				EndIf

				oPrinter:SayAlign( _nLin,_nCEve,Alltrim(_aDevedor[ix][1]),oFont07:oFont,70,10,,0,1 )
				oPrinter:SayAlign( _nLin,_nCTit,Alltrim(_aDevedor[ix][2]),oFont07:oFont,70,10,,0,1 )
				oPrinter:SayAlign( _nLin,_nCHis,Alltrim(_aDevedor[ix][3]),oFont06:oFont,120,10,,0,1 )
				oPrinter:SayAlign( _nLin,_nCVlr,TRANSFORM(_aDevedor[ix][4],"@E 999,999.99"),oFont07:oFont,70,10,,1,1 )
				_nLin+= 07
				oPrinter:Line( _nLin,_nCEve, _nLin,585)
				_nLin+= 08
			Next ix
			oPrinter:SayAlign( _nLin,_nCHis,"Total: ",oFont07:oFont,100,10,,1,1 )
			oPrinter:SayAlign( _nLin,_nCVlr,TRANSFORM(_nDevedor,"@E 9,999,999.99"),oFont07:oFont,70,10,,1,1 )
			_nLin+= 10
			oPrinter:Line( _nLin,_nCEve-05, _nLin,585)
			oPrinter:Line( _nLiLin,_nCEve-05, _nLin,_nCEve-05)
			oPrinter:Line( _nLiLin,585, _nLin,585)
			_nLin+= 10
		EndIf

		// Fim box Devedor

		If _nLin < (_nLinMax - 50)
			_nLin := _nLinMax - 50
		Else
			If _nLin > (_nLinMax - 50)
				oPrinter:Say(_nLinMax+15,_nColEv,"Continua pr๓xima pแgina ---->"	,oFont12N:oFont)
				oPrinter:EndPage()
				Cabec()

				_nLin+= 10
				_nLiLin := _nLin - 1
			EndIf
		EndIf
		oPrinter:Say(_nLin-5,010,"Mensagem:"	,oFont12N:oFont)
		oPrinter:Say(_nLin-5,075,Alltrim(MV_PAR12)	,oFont12:oFont)
		oPrinter:Line( _nLin,010, _nLin,580)
		_nLin+= 15

		oPrinter:Say(_nLin-5,010,Alltrim(MV_PAR13)	,oFont12:oFont)
		oPrinter:Line( _nLin,010, _nLin,580)
		_nLin+= 15

		oPrinter:Say(_nLin-5,010,Alltrim(MV_PAR14)	,oFont12:oFont)
		oPrinter:Line( _nLin,010, _nLin,580)

		_nCred := 0
		_nDeb := 0
		_nVlrLtr := 0
		_nValor := 0
		_nFunrural := 0
		_nCredConv := 0
		_nDescConv := 0
		_aColetas := {}
		_pnVLEITE := 0
	 	_aCreditos := {}
		_aDebitos := {}
		_aDevedor := {}
		_nDevedor := 0
		_cCFx := 05

		oPrinter:EndPage()


	ENDDO

	(_cAlias)->(DbCloseArea())

	oPrinter:Preview()

	oPrinter := Nil

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQueryTRB  บAutor  ณMicrosiga           บ Data ณ  09/02/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function QueryTRB()

	Local _nOrdem := MV_PAR08
	Local _cRotas := "%  %"
	Local _cFilSA2 := "% "

	If !Empty(MV_PAR09)
		_cRotas := "%  AND ZLZ_ROTA IN "+FormatIn(SubStr(MV_PAR09,1,Len(Alltrim(MV_PAR09))-1),"/")+"  %"
	EndIf

	If !Empty(MV_PAR10)
		_cFilSA2 += " AND A2_L_TECLC = '"+MV_PAR10+"' "
	EndIf

	If !Empty(MV_PAR11)
		_cFilSA2 += " AND A2_L_COMPL IN "+FormatIn(SubStr(MV_PAR11,1,Len(Alltrim(MV_PAR11))-1),"/")+"  "
	EndIf
	_cFilSA2 += " %"

	If _nOrdem == 1
		_cOrdem := "% ZLF_SETOR,ZLF_LINROT,PRIORIDADE,CODIGO,LOJA ,NOME,ZLF_EVENTO  %"
	ElseIf _nOrdem == 2
		_cOrdem := "% ZLF_SETOR,ZLF_LINROT,PRIORIDADE,NOME,CODIGO,LOJA, ZLF_EVENTO  %"
	Else
		_cOrdem := "% ZLF_SETOR,PRIORIDADE,NOME,ZLF_LINROT,CODIGO,LOJA, ZLF_EVENTO  %"
	EndIf

	BeginSql alias _cAlias
	SELECT
		ZLF_SETOR, A2_COD AS CODIGO ,A2_LOJA AS LOJA, A2.A2_NOME AS NOME, ZLF_QTDBOM, ZLF_DEBCRE,
		(CASE WHEN ZLF_DEBCRE = 'D' THEN -ZLF_VLRLTR ELSE ZLF_VLRLTR END) AS ZLF_VLRLTR,
		ZLF_TOTAL, ZLF_FINOK, ZLF_ACERTO,
		ZL8_DESCRI, ZL8_TPEVEN, ZL8_NREDUZ, ZL8_VALOR, ZL8_FORMUL,
		ZLF_EVENTO, ZLF_LINROT,
		(CASE WHEN ZL8_TPEVEN IN ('L','R') THEN '1' ELSE '2' END) AS PRIORIDADE
	FROM %Table:ZLF% ZLF
		JOIN %Table:SA2% A2 ON A2_COD = ZLF.ZLF_RETIRO AND A2_LOJA = ZLF.ZLF_RETILJ  AND A2.%NotDel%  %Exp:_cFilSA2%
		JOIN %Table:ZL8% ZL8 ON ZL8_COD = ZLF_EVENTO AND ZL8_RECIBO = 'S' AND ZL8_TPEVEN IN ('L','R') AND ZL8_COD <> %Exp:_cEVEINSS% AND ZL8.%NotDel%
		JOIN %Table:ZLZ% ZLZ ON ZLZ.ZLZ_CODPRO = A2_COD AND ZLZ.ZLZ_LJPROD = A2_LOJA AND ZLZ.%NotDel% %Exp:_cRotas%
		WHERE ZLF_FILIAL = %xfilial:ZLF%
		AND ZLF_CODZLE = %Exp:MV_PAR01%
		AND ZLF_RETIRO BETWEEN %Exp:MV_PAR02% AND %Exp:MV_PAR03%
		AND ZLF_RETILJ BETWEEN %Exp:MV_PAR04% AND %Exp:MV_PAR05%
		AND ZLF_LINROT BETWEEN %Exp:MV_PAR06% AND %Exp:MV_PAR07%
		AND ZLF.%NotDel%

	UNION ALL

	SELECT	ZL3_SETOR AS ZLF_SETOR, A2_COD AS CODIGO ,A2_LOJA AS LOJA, SA2.A2_NOME AS NOME, 0 AS ZLF_QTDBOM, 'C' AS ZLF_DEBCRE,
		0 AS ZLF_VLRLTR,
		0 AS ZLF_TOTAL, 'N' AS ZLF_FINOK, 'N' AS ZLF_ACERTO,
		ZL8_DESCRI, ZL8_TPEVEN, ZL8_NREDUZ, ZL8_VALOR, ZL8_FORMUL,
		ZL8_COD AS  ZLF_EVENTO, SA2.A2_L_LI_RO AS ZLF_LINROT,
		'1' AS PRIORIDADE
	FROM %Table:ZM3% ZM3
		JOIN %Table:SA2% SA2 ON A2_COD = ZM3_CODSA2 AND A2_LOJA = ZM3_LOJA  AND SA2.%NotDel%   %Exp:_cFilSA2%
		JOIN %Table:ZL3% ZL3 ON ZL3.ZL3_COD = SA2.A2_L_LI_RO
			AND ZL3_COD BETWEEN %Exp:MV_PAR06% AND %Exp:MV_PAR07%
			AND ZL3.%NotDel%
		JOIN %Table:ZL8% ZL8 ON ZL8_COD = '060005' AND ZL8.%NotDel%
		JOIN %Table:ZLZ% ZLZ ON ZLZ.ZLZ_CODPRO = A2_COD AND ZLZ.ZLZ_LJPROD = A2_LOJA  AND ZLZ.%NotDel% %Exp:_cRotas%
	WHERE  (ZM3_DESCLT > 0 OR ZM3_DESCVL > 0)
		AND ZM3_CODSA2 BETWEEN %Exp:MV_PAR02% AND %Exp:MV_PAR03%
		AND ZM3_LOJA BETWEEN %Exp:MV_PAR04% AND %Exp:MV_PAR05%
		AND ZM3.%NotDel%

	ORDER BY %Exp:_cOrdem%

	EndSql


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEveFinanc  บAutor  ณMicrosiga           บ Data ณ  09/02/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function EveFinanc(xcProd,xcLoja)

Local _cAliCred := GetNextAlias()
Local _cAliSE1 := GetNextAlias()
Local _cAliConv := GetNextAlias()
Local _cHist := ""
Local _cNotIn := "% ('"+_cEveCred+"','"+_cEveDeb+"') %"


If _lAcertook .and. _lFinOK //Se jแ rodou acerto busca informa็๕es da ZLF
	BeginSql alias _cAliCred

		SELECT
			ZLF_SETOR, ZLF_RETIRO AS CODIGO ,ZLF_RETILJ AS LOJA, A2.A2_NOME AS NOME, ZLF_QTDBOM, ZL8_DEBCRE as DEBCRE,
			ZLF_TOTAL, ZLF_VLRPAG,
			ZL8_DESCRI, ZL8_TPEVEN, ZL8_NREDUZ, ZL8_VALOR,
			ZLF_SE1PRE, ZLF_SE1NUM, ZLF_SE1PAR, ZLF_SE1HIS,
			SUBSTRING(ZLF_L_SEEK,7,19) AS E1SEEK, ZLF_ORIGEM AS ORIGEM, ZLF_EVENTO,
			ZL8_PRIORI
		FROM %Table:ZLF% ZLF
			JOIN %Table:SA2% A2 ON A2_COD = ZLF.ZLF_RETIRO AND A2_LOJA = ZLF.ZLF_RETILJ AND A2.%NotDel%
			JOIN %Table:ZL8% ZL8 ON ZL8_COD = ZLF_EVENTO AND ZL8_RECIBO = 'S' AND ZL8_TPEVEN IN ('F','A') AND ZL8.%NotDel%
			WHERE ZLF_FILIAL = %xfilial:ZLF%
			AND ZLF_CODZLE = %Exp:MV_PAR01%
			AND ZLF_RETIRO = %Exp:xcProd%
			AND ZLF_RETILJ = %Exp:xcLoja%
			AND ZLF_EVENTO NOT IN %Exp:_cNotIn%
			AND ZLF.%NotDel%
		ORDER BY ZL8_PRIORI

	EndSql

	DbSelectArea(_cAliCred)
	(_cAliCred)->(DbGoTop())

	While !(_cAliCred)->(Eof())
		If (_cAliCred)->DEBCRE == "D"
			_nDescConv += (_cAliCred)->ZLF_VLRPAG //(_cAliCred)->ZLF_TOTAL
			AADD(_aDebitos,{(_cAliCred)->ZLF_EVENTO,;
							(_cAliCred)->ZLF_SE1PRE+ (_cAliCred)->ZLF_SE1NUM+ (_cAliCred)->ZLF_SE1PAR,;
							Iif(Empty((_cAliCred)->ZLF_SE1HIS),(_cAliCred)->ZL8_DESCRI,(_cAliCred)->ZLF_SE1HIS),;
							(_cAliCred)->ZLF_VLRPAG,(_cAliCred)->ZLF_TOTAL})
		Else
			_nCredConv += (_cAliCred)->ZLF_TOTAL
			_cHist := Iif(Empty((_cAliCred)->ZLF_SE1HIS),(_cAliCred)->ZL8_DESCRI,(_cAliCred)->ZLF_SE1HIS)

			If (_cAliCred)->ZLF_EVENTO=='060005'
				_cHist := (_cAliCred)->ZL8_NREDUZ+" "+U_CREDASSOC(SA2->A2_L_CODAS,MV_PAR01,"R")
			EndIf

			AADD(_aCreditos,{(_cAliCred)->ZLF_EVENTO,;
							(_cAliCred)->ZLF_SE1PRE+ (_cAliCred)->ZLF_SE1NUM+ (_cAliCred)->ZLF_SE1PAR,;
							_cHist,;
							(_cAliCred)->ZLF_TOTAL})

		EndIf
		(_cAliCred)->(DbSkip())
	EndDo
	(_cAliCred)->(DbCloseArea())

	//Busca por tํtulos que ficaram em aberto
	_cVencto := DataValida(Condicao(1000,ZL2->ZL2_CONDPG)[1][1])// SubStr(DTOS(MonthSum(ZLE->ZLE_DTFIM,1)),1,6) + _cDia
	_cVencto := DTOS(_cVencto)
	_cDtEmis := DTOS(_dDtini)

	BeginSql alias _cAliSE1
		SELECT E1_L_EVENT, E1_PREFIXO, E1_NUM, E1_PARCELA,E1_HIST,ZL8_DESCRI, (E1_SALDO+E1_SDACRES) AS VALDEB
		FROM %Table:SE1% SE1
			JOIN %Table:ZL8% ZL8 ON ZL8_COD = E1_L_EVENT AND ZL8_RECIBO = 'S'  AND ZL8.%NotDel%
		WHERE
		E1_CLIENTE =  %Exp:SA2->A2_COD%
		AND E1_LOJA  =  %Exp:SA2->A2_LOJA%
		AND E1_VENCTO <= %Exp:_cVencto%
		AND E1_TIPO <> 'NCC'
		AND E1_SALDO > 0
		AND E1_EMISSAO	<=  %Exp:_cDtEmis%
		AND E1_L_EVENT <> ' '
		AND E1_L_EVENT NOT IN %Exp:_cNotIn%
		AND SE1.%NotDel%
	EndSql
	While !(_cAliSE1)->(Eof())
		_nDevedor += (_cAliSE1)->VALDEB
		AADD(_aDevedor,{(_cAliSE1)->E1_L_EVENT,;
					(_cAliSE1)->E1_PREFIXO+ (_cAliSE1)->E1_NUM+ (_cAliSE1)->E1_PARCELA,;
					Iif(Empty((_cAliSE1)->E1_HIST),(_cAliSE1)->ZL8_DESCRI,(_cAliSE1)->E1_HIST),;
					(_cAliSE1)->VALDEB,0})

		(_cAliSE1)->(DbSkip())
	EndDo

	//Fim tํtulos em aberto



Else // Se nใo rodou acerto, busca dados do financeiro e ZLL
	_cVencto := DataValida(Condicao(1000,ZL2->ZL2_CONDPG)[1][1])// SubStr(DTOS(MonthSum(ZLE->ZLE_DTFIM,1)),1,6) + _cDia
	_cVencto := DTOS(_cVencto)
	_cDtEmis := DTOS(_dDtini)

	BeginSql alias _cAliCred
		SELECT E2_L_EVENT, E2_PREFIXO, E2_NUM, E2_PARCELA,E2_HIST,ZL8_DESCRI,ZL8_NREDUZ, E2_SALDO AS SALDO
		FROM %Table:SE2% SE2
			JOIN %Table:ZL8% ZL8 ON ZL8_COD = E2_L_EVENT AND ZL8_RECIBO = 'S'  AND ZL8.%NotDel%
		WHERE
		E2_FILIAL = %xFilial:SE2%
		AND E2_FORNECE =  %Exp:SA2->A2_COD%
		AND E2_LOJA  =  %Exp:SA2->A2_LOJA%
		AND E2_VENCTO <= %Exp:_cVencto%
		AND E2_TIPO NOT IN ('PA','NDF')
		AND E2_SALDO > 0
		AND E2_EMISSAO	<=  %Exp:_cDtEmis%
		AND E2_L_EVENT <> ' '
		AND E2_L_EVENT NOT IN ('110023','110024','110025')
		AND E2_L_EVENT NOT IN %Exp:_cNotIn%
		AND SE2.%NotDel%
	EndSql

	While !(_cAliCred)->(Eof())
		_nCredConv += (_cAliCred)->SALDO
		_cHist := Iif(Empty((_cAliCred)->E2_HIST),(_cAliCred)->ZL8_DESCRI,(_cAliCred)->E2_HIST)

		If (_cAliCred)->E2_L_EVENT=='060005'
			_cHist := (_cAliCred)->ZL8_NREDUZ+" "+U_CREDASSOC(SA2->A2_L_CODAS,MV_PAR01,"R")
		EndIf

		AADD(_aCreditos,{(_cAliCred)->E2_L_EVENT,;
					(_cAliCred)->E2_PREFIXO+ (_cAliCred)->E2_NUM+ (_cAliCred)->E2_PARCELA,;
					_cHist,;
					(_cAliCred)->SALDO})

		(_cAliCred)->(DbSkip())
	EndDo

	//Calcula d้bitos lan็ados no contas a receber
	BeginSql alias _cAliSE1
		SELECT E1_L_EVENT, E1_PREFIXO, E1_NUM, E1_PARCELA,E1_HIST,ZL8_DESCRI, (E1_SALDO+E1_SDACRES) AS VALDEB
		FROM %Table:SE1% SE1
			JOIN %Table:ZL8% ZL8 ON ZL8_COD = E1_L_EVENT AND ZL8_RECIBO = 'S'  AND ZL8.%NotDel%
		WHERE
		E1_CLIENTE =  %Exp:SA2->A2_COD%
		AND E1_LOJA  =  %Exp:SA2->A2_LOJA%
		AND E1_VENCTO <= %Exp:_cVencto%
		AND E1_TIPO <> 'NCC'
		AND E1_SALDO > 0
		AND E1_EMISSAO	<=  %Exp:_cDtEmis%
		AND E1_L_EVENT <> ' '
		AND E1_L_EVENT NOT IN %Exp:_cNotIn%
		AND SE1.%NotDel%
	EndSql
	While !(_cAliSE1)->(Eof())
		_nDescConv += (_cAliSE1)->VALDEB
		AADD(_aDebitos,{(_cAliSE1)->E1_L_EVENT,;
					(_cAliSE1)->E1_PREFIXO+ (_cAliSE1)->E1_NUM+ (_cAliSE1)->E1_PARCELA,;
					Iif(Empty((_cAliSE1)->E1_HIST),(_cAliSE1)->ZL8_DESCRI,(_cAliSE1)->E1_HIST),;
					(_cAliSE1)->VALDEB,0})

		(_cAliSE1)->(DbSkip())
	EndDo
	//Calcula d้bito de conv๊nios lan็ados
	BeginSql alias _cAliConv
		SELECT ZLL_EVENTO, ZL8_PREFIX, ZLL_COD, ZLL_SEQ,ZLL_OBSERV, ZLL_VALOR AS VALDEB
		FROM %Table:ZLL% ZLL
			JOIN %Table:ZL8% ZL8 ON ZL8_COD = ZLL_EVENTO AND ZL8_RECIBO = 'S'  AND ZL8.%NotDel%
		WHERE ZLL_RETIRO 	=  %Exp:SA2->A2_COD%
		AND ZLL_RETILJ  =  %Exp:SA2->A2_LOJA%
		AND ZLL_VENCTO 	<= %Exp:_cVencto%
		AND ZLL_STATUS	= 'A'
		AND ZLL_DATA <=  %Exp:_cDtEmis%
		AND ZLL.%NotDel%
	EndSql

	While !(_cAliConv)->(Eof())
		_nDescConv += (_cAliConv)->VALDEB
		AADD(_aDebitos,{(_cAliConv)->ZLL_EVENTO,;
					(_cAliConv)->ZL8_PREFIX+ (_cAliConv)->ZLL_COD+ (_cAliConv)->ZLL_SEQ,;
					Iif(Empty((_cAliConv)->ZLL_OBSERV),(_cAliConv)->ZL8_DESCRI,(_cAliConv)->ZLL_OBSERV),;
					(_cAliConv)->VALDEB,0})

		(_cAliConv)->(DbSkip())
	EndDo
	(_cAliCred)->(DbCloseArea())
	(_cAliSE1)->(DbCloseArea())
	(_cAliConv)->(DbCloseArea())

EndIf


Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ActEveAuto()  บAutor  ณMicrosiga           บ Data ณ  09/02/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Simula valores dos eventos para relat๓rio antes do acerto  บฑฑ
ฑฑบ          ณ do leite.                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ActEveAuto()

	Local _cAliasEv := GetNextAlias()
	Local _aRet := {}
	Local nVlrEvto := 0
	Local _nVol := 0
	Local _cHist := ""

	BeginSql alias _cAliasEv
		SELECT ZL8_COD
		FROM %Table:ZL8% ZL8
		WHERE ZL8_FILIAL = %xFilial:ZL8%
		AND ZL8_TPEVEN = 'A'
		AND ZL8_DEBCRE IN ('C','D')
		AND ZL8_PREFIX <> ' '
		AND ZL8_MSBLQL <> '1'
		AND ZL8.%NotDel%
		ORDER BY ZL8_PRIORI
	EndSql


	While (_cAliasEv)->(!Eof())

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Posiciona no cadastro de Eventos. ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		dbSelectArea("ZL8")
		ZL8->(dbSetOrder(1))
		ZL8->(MsSeek(xFilial("ZL8") + (_cAliasEv)->ZL8_COD))

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Verifica se a condicao do Evento eh satisfatoria.  ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If &(ZL8->ZL8_CONDIC)

			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Busca o valor a ser gravado no Evento e no titulo. ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			nVlrEvto := 0
			nVlrEvto := &(ZL8->ZL8_FORMUL)
			nVlrEvto := Round(nVlrEvto,2) //Arredondo pra nao dar erro na baixa do SE2
			_nVol := 0
			If nVlrEvto > 0

				ZL8->(MsSeek(xFilial("ZL8") + (_cAliasEv)->ZL8_COD)) //Posiciona novamente a ZL8, pois a condi็ใo do evento pode ter desposicionado.
				_cHist := AllTrim(ZL8->ZL8_DESCRI)
				If ZL8->ZL8_COD=='060005'
					_cHist := ZL8->ZL8_NREDUZ+" "+U_CREDASSOC(SA2->A2_L_CODAS,MV_PAR01,"R")
				EndIf

				AADD(_aRet,{_cHist,;
					IIF(ZL8->ZL8_DEBCRE = "D",nVlrEvto,0),;
					IIF(ZL8->ZL8_DEBCRE = "C",nVlrEvto,0)})
			EndIf
		EndIf

		(_cAliasEv)->(dbSkip())
	EndDo

	(_cAliasEv)->(DbCloseArea())

Return _aRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCabec()  บAutor  ณMicrosiga           บ Data ณ  09/02/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Cabec()

	Local _cRota := ""

	_nPag++

	oPrinter:StartPage()

	oPrinter:Box(005,005,_nLinMax,590)
	oPrinter:SayBitmap(013,018,_cLogo,120,120)
	oPrinter:Line( 005, 170, 110, 170)
	_cMes := IIF(Alltrim(MesExtenso(STR(Month(_dDtini))))=="Marco","Mar็o",Alltrim(MesExtenso(STR(Month(_dDtini)))))
	oPrinter:Say(030,180,"DEMONSTRATIVO DO PRODUTOR"+Space(3)+UPPER(_cMes)+" - "+STR(YEAR(_dDtini),4)	,oFontTit:oFont)
	oPrinter:Line( 005, 495, 045, 495) // separador Data
	oPrinter:Say(020,505,"Emissใo: "+DTOC(dDataBase) 	,oFont10:oFont)
	oPrinter:Say(030,505,"Hora   :  "+Time() 	,oFont10:oFont)
	oPrinter:Say(040,505,"Pแgina : "+StrZero(_nPag,2) 	,oFont10:oFont)
	oPrinter:Line( 045, 170, 045, 590)
	oPrinter:Say(060,180,FWFilRazSocial(cEmpAnt,cFilAnt)	,oFontRod:oFont)
	oPrinter:Say(075,180,Alltrim(SM0->M0_ENDCOB)+" - "+Alltrim(SM0->M0_BAIRCOB) 	,oFont12:oFont)
	oPrinter:Say(090,180,"CEP: "+Transform(SM0->M0_CEPCOB,"@r 99999-999")+" - "+Alltrim(SM0->M0_CIDCOB)+"-"+SM0->M0_ESTCOB	,oFont12:oFont)
	oPrinter:Say(105,180,"CNPJ:"+Transform(SM0->M0_CGC,"@r 99.999.999/9999-99")			,oFont12:oFont)

	oPrinter:Line( 110, 005, 110, 590)

	oPrinter:Say(125,020,"Produtor:"	,oFont12N:oFont)
	oPrinter:Say(125,080,SA2->A2_COD+" "+SA2->A2_LOJA+" - "+SA2->A2_NOME			,oFont12:oFont)
	oPrinter:Say(140,020,"Endere็o :"	,oFont12N:oFont)
	oPrinter:Say(140,080,SA2->A2_END	,oFont12:oFont)
	oPrinter:Say(155,020,"Bairro   :"	,oFont12N:oFont)
	oPrinter:Say(155,080,SA2->A2_BAIRRO	,oFont12:oFont)

	oPrinter:Say(170,020,"Municipio:",oFont12N:oFont)
	oPrinter:Say(170,080,Alltrim(SA2->A2_MUN)+"-"+SA2->A2_EST+" CEP: "+Transform(SA2->A2_CEP,"@r 99999-999"),oFont12:oFont)
	oPrinter:Say(170,370,"ROTA: "	,oFont12N:oFont)
	_cRota := GetRota(SA2->A2_COD,SA2->A2_LOJA)
	oPrinter:Say(170,430,_cRota,oFont12:oFont)

	If SA2->A2_TIPO = 'J'
		oPrinter:Say(185,020,"CNPJ      :"			,oFont12N:oFont)
		oPrinter:Say(185,080,Transform(SA2->A2_CGC,"@r 99.999.999/9999-99")			,oFont12:oFont)
	Else
		oPrinter:Say(185,020,"CPF       :"			,oFont12N:oFont)
		oPrinter:Say(185,080,Transform(SA2->A2_CGC,"@r 999.999.999-99")			,oFont12:oFont)
	EndIf
	oPrinter:Say(185,370,"INSC.EST.: "	,oFont12N:oFont)
	oPrinter:Say(185,430,SA2->A2_INSCR,oFont12:oFont)

	oPrinter:Say(200,020,"Banco :",oFont12N:oFont)
	oPrinter:Say(200,060,SA2->A2_BANCO,oFont12:oFont)
	oPrinter:Say(200,080,"Ag๊ncia :",oFont12N:oFont)
	oPrinter:Say(200,128,Alltrim(SA2->A2_AGENCIA)+IIF(Empty(SA2->A2_DVAGE),"","-"+SA2->A2_DVAGE),oFont12:oFont)
	oPrinter:Say(200,160,"Conta :",oFont12N:oFont)
	oPrinter:Say(200,198,Alltrim(SA2->A2_NUMCON)+IIF(Empty(SA2->A2_DVCTA),"","-"+SA2->A2_DVCTA),oFont12:oFont)
	If !Empty(SA2->A2_L_NOMFA)
		oPrinter:Say(200,250,"Favorecido:",oFont12N:oFont)
		oPrinter:Say(200,310,Alltrim(SA2->A2_L_NOMFA),oFont10:oFont)
		If !Empty(SA2->A2_L_CGCFA) .and. SA2->A2_L_CGCFA <> SA2->A2_CGC
			If SA2->A2_L_TPFAV = 'J'
				oPrinter:Say(200,480,"CNPJ :"			,oFont12N:oFont)
				oPrinter:Say(200,510,Transform(SA2->A2_L_CGCFA,"@r 99.999.999/9999-99")			,oFont12:oFont)
			Else
				oPrinter:Say(200,480,"CPF  :"			,oFont12N:oFont)
				oPrinter:Say(200,510,Transform(SA2->A2_L_CGCFA,"@r 999.999.999-99")			,oFont12:oFont)
			EndIf
		EndIf
	EndIf
	_nLin := 210

	oPrinter:Line( _nLin, 005, _nLin, 590)


	_nLin += 10
	BeginSql alias "TNFL"

			SELECT F1.F1_DOC AS NUMNF, F1.F1_SERIE AS SERIE, F1.F1_VALBRUT AS VALOR,F1.F1_DESCONT AS DESCON, SUM(D1.D1_QUANT) AS QTD,
			SUM(F1_VLSENAR+ F1_CONTSOC + F1_INSS) AS FUNRURAL
			FROM %Table:SF1%  F1
				JOIN %Table:SD1%  D1 ON D1.D1_FILIAL =F1.F1_FILIAL AND D1.D1_DOC = F1.F1_DOC AND D1.D1_SERIE = F1.F1_SERIE
				AND D1.D1_FORNECE = F1.F1_FORNECE AND D1.%NotDel%
			WHERE F1.F1_FORNECE = %Exp:SA2->A2_COD% AND F1.F1_LOJA = %Exp:SA2->A2_LOJA% AND F1.F1_L_MIX = %Exp:MV_PAR01% AND F1.%NotDel%
			GROUP BY F1.F1_DOC, F1.F1_SERIE, F1.F1_VALBRUT,F1.F1_DESCONT
	EndSql
	_nFunrural := 0
	_nCredLeite := 0
	_nOutDesc := 0
	If !TNFL->(Eof())
		oPrinter:Say(_nLin,220,"FORNECIMENTO DE LEITE",oFont12N:oFont)
	EndIf
	While !TNFL->(Eof())
		_nFunrural += TNFL->FUNRURAL
		_nCredLeite += TNFL->VALOR
		_nOutDesc += TNFL->DESCON
		_nLin+= 15
		oPrinter:Say(_nLin,20,"Nota Fiscal:"	,oFont12N:oFont)
		oPrinter:Say(_nLin,80,TNFL->SERIE+"/"+TNFL->NUMNF		,oFont12:oFont)
		oPrinter:Say(_nLin,160,"Volume: "	,oFont12N:oFont)
		oPrinter:Say(_nLin,200,TRANSFORM(TNFL->QTD,"@E 999,999,999")  ,oFont12:oFont)
		oPrinter:Say(_nLin,300,"Valor Bruto: "	,oFont12N:oFont)
		oPrinter:Say(_nLin,380,"R$ "+TRANSFORM(TNFL->VALOR,"@E 999,999,999.99")  ,oFont12:oFont)

		TNFL->(DbSkip())
	EndDo
	TNFL->(DbCloseArea())

	If _nCredLeite > 0
		_lAcertook := .t. //Indica se jแ foi executado acerto do leite
	EndIf

	_nLin+= 10
	oPrinter:Line( _nLin, 005, _nLin, 590)


	oPrinter:Fillrect( {_nLin,005,_nLin+18,590 }, oBrush, "-2")

	oPrinter:SayAlign(_nLin,070,"COLETAS DIมRIAS",oFont07N:oFont,100,10,CLR_WHITE,0,1 )
	_nLin+=7
	_nColD := 25
	_nColV := _nColD + 20
	oPrinter:SayAlign(_nLin,_nColD,"DIA",oFont07N:oFont,30,10,CLR_WHITE,0,1 )
	oPrinter:SayAlign(_nLin,_nColV,"QTDE.",oFont07N:oFont,30,10,CLR_WHITE,0,1 )
	oPrinter:SayAlign(_nLin,_nColD+60,"DIA",oFont07N:oFont,30,10,CLR_WHITE,0,1 )
	oPrinter:SayAlign(_nLin,_nColV+60,"QTDE",oFont07N:oFont,30,10,CLR_WHITE,0,1 )
	oPrinter:SayAlign(_nLin,_nColD+120,"DIA",oFont07N:oFont,30,10,CLR_WHITE,0,1 )
	oPrinter:SayAlign(_nLin,_nColV+120,"QTDE",oFont07N:oFont,30,10,CLR_WHITE,0,1 )
	_nLin+=3

	oPrinter:Say(_nLin,_nColEv,"EVENTO",oFont12N:oFont,,CLR_WHITE)
	oPrinter:Say(_nLin,_nColUnit,"VLR.LITRO",oFont12N:oFont,,CLR_WHITE)
	oPrinter:Say(_nLin,_nColDeb,"DEBITO",oFont12N:oFont,,CLR_WHITE)
	oPrinter:Say(_nLin,_nColCred,"CREDITO",oFont12N:oFont,,CLR_WHITE)
	_nLin+= 10

Return

/**********************************************************
* Retorna rota do produ็ใo para impressใo do cabe็alho
*********************************************************/
Static Function GetRota(xcCod, xcLoja)

Local _cRet := ""
Local _cAlias := GetNextAlias()

BeginSql Alias _cAlias

	SELECT ZLW_COD, ZLW_VERSAO, ZLW_DESCRI
	FROM %Table:ZLZ% ZLZ
		JOIN %Table:ZLW% ZLW ON ZLW_FILIAL = %xFilial:ZLW%
		AND ZLW_COD = ZLZ_ROTA
		AND ZLW_VERSAO = ZLZ_VERSAO
		AND ZLW.%NotDel%
	WHERE ZLZ_FILIAL = %xFilial:ZLZ%
	AND ZLZ_CODPRO = %Exp:xcCod%
	AND ZLZ_LJPROD = %Exp:xcLoja%
	AND ZLZ.%NotDel%
EndSql

If !(_cAlias)->(Eof())
	_cRet := (_cAlias)->ZLW_COD+" "+(_cAlias)->ZLW_DESCRI
EndIf
(_cAlias)->(dbCloseArea())

Return _cRet