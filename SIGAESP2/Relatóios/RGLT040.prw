#INCLUDE "TOTVS.CH"
#INCLUDE "REPORT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRGLT040   บAutor  ณGuilherme Fran็a    บ Data ณ  23/08/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Planilha de conferencia do fechamento mensal   Leite       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function RGLT040()

Private cPerg      := "PRGLT040"
Private _cEveCred  := AllTrim(SuperGETMV("LT_EVECRED",,"300001")) //Evento utilizado no titulo aglutinado de credito
Private _cEveDeb   := AllTrim(SuperGETMV("LT_EVEDEB",,"300002")) //Evento utilizado no titulo aglutinado de debito
Private _cEveINSS  := AllTrim(SuperGETMV("LT_EVEINSS",,"120001")) //Codigo do evento de INSS (Funrural)
Private _nFunrural := 0
Private _nFundesa  := 0
Private _lAcerto   := .F.
Private _aEveCel   := {}

If !Pergunte(cPerg,.T.)
	Return
EndIf

MsgInfo("Este relat๓rio ้ melhor visualizado em impressใo Planilha, devido ao volume de inform็a๕es!","Formato de Impressใo")

oReport := ReportDef()
oReport:PrintDialog()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportDef บAutor  ณMicrosiga           บ Data ณ  24/02/2016 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Defini็ใo do lay-out do relatorio.                         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()

Local oReport
Local oDetalhe
Local _aEveAuto   := {}
Local ix :=	0
Private _cAlias   := GetNextAlias()
Private cAliasEve := "EVE"
Private cAliasFin := "FIN"
Private aOrd      :={"Nome", "Codigo", "Grupo Preco"}

Eventos() //Gera lista dos eventos que irใo virar celulas do relatorio

DEFINE REPORT oReport NAME "RGLT040" TITLE "Conferencia do fechamento mensal." PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)}

oReport:SetLandscape()
oReport:SetTotalInLine(.F.)
oReport:nFontBody := 10

DEFINE SECTION oDetalhe OF oReport  TITLE "Detalhes" ORDERS aOrd
oDetalhe:SetTotalInLine(.F.)

DEFINE CELL NAME "GRPPRC" 		OF oDetalhe ALIAS "ZLF" TITLE "Grupo Pre็o"  			// 03
DEFINE CELL NAME "CODIGO" 		OF oDetalhe ALIAS "ZLF"	TITLE "C๓digo"  		// 01
DEFINE CELL NAME "LOJA" 		OF oDetalhe ALIAS "ZLF" TITLE "Loja"  			// 02
DEFINE CELL NAME "NOME" 		OF oDetalhe ALIAS "ZLF" TITLE "Nome"  			// 03
DEFINE CELL NAME "CODMUN" 		OF oDetalhe ALIAS "ZLF" TITLE "C๓d.IBGE"  			// 03

DEFINE CELL NAME "QTD_LEITE" 		OF oDetalhe ALIAS ""  	TITLE "Qtd. Leite" PICTURE "@E 99,999,999"  SIZE 14 	// 04

DEFINE CELL NAME "PRECO" 			OF oDetalhe ALIAS ""  	TITLE "Pr็.Unit.Brt." PICTURE "@E 9.9999"  SIZE 8    	// 05
DEFINE CELL NAME "PRECOL" 			OF oDetalhe ALIAS ""  	TITLE "Pr็.Unit.Liq." PICTURE "@E 9.9999"  SIZE 8    	// 05
DEFINE CELL NAME "VALOR" 			OF oDetalhe ALIAS ""  	TITLE "Valor Bruto" PICTURE "@E 99,999,999.99"  SIZE 16


If MV_PAR05 == 1
	//Celulas com eventos de precifica็ใo
	(cAliasEve)->(DbGoTop())
	While !(cAliasEve)->(Eof())
		If ASCAN(_aEveCel,Alltrim((cAliasEve)->EVENTO)) == 0
			_lAcerto := (cAliasEve)->ZLF_ACERTO == 'S' //Identifica se jแ rodou acerto do leite
			If Alltrim((cAliasEve)->EVENTO) <> _cEveINSS
				If (cAliasEve)->ORDEM == 1 .or. (cAliasEve)->ORDEM == 2
					DEFINE CELL NAME Alltrim((cAliasEve)->EVENTO)	OF oDetalhe ALIAS ""  	TITLE (cAliasEve)->NOME PICTURE "@E 9.9999"  SIZE 8
				EndIf
			Endif
			AADD(_aEveCel,Alltrim((cAliasEve)->EVENTO))
		EndIf
		(cAliasEve)->(DbSkip())
	EndDo
EndIf


//Celulas com eventos de cr้dito
(cAliasEve)->(DbGoTop())

While !(cAliasEve)->(Eof())
	If Alltrim((cAliasEve)->EVENTO) <> _cEveINSS
		If (cAliasEve)->ORDEM == 4
			DEFINE CELL NAME Alltrim((cAliasEve)->EVENTO)	OF oDetalhe ALIAS ""  	TITLE (cAliasEve)->NOME PICTURE "@E 9,999,999.99"  SIZE 14
		EndIf
	EndIf
	(cAliasEve)->(DbSkip())
EndDo

(cAliasEve)->(DbGoTop())
//Celulas com eventos de Debitos
While !(cAliasEve)->(Eof())
	If Alltrim((cAliasEve)->EVENTO) <> _cEveINSS
		If (cAliasEve)->ORDEM == 3 .or. (cAliasEve)->ORDEM == 5
			DEFINE CELL NAME Alltrim((cAliasEve)->EVENTO)	OF oDetalhe ALIAS ""  	TITLE (cAliasEve)->NOME PICTURE "@E 9,999,999.99"  SIZE 14
		EndIf
	EndIf
	(cAliasEve)->(DbSkip())
EndDo

(cAliasEve)->(DbGoTop())
//Celulas com o evento de Funrural por ๚ltimo

If !_lAcerto
	DEFINE CELL NAME Alltrim(_cEveINSS)	OF oDetalhe ALIAS ""  	TITLE "Funrural" PICTURE "@E 99,999.9999"  SIZE 14
ELSE
	// VlrFunrural() 
	// If _nFunrural > 0 
		DEFINE CELL NAME "FUNRURAL"	OF oDetalhe ALIAS ""  	TITLE "Funrural" PICTURE "@E 999,999.99"  SIZE 14
	// EndIf
	// If _nFundesa > 0
		DEFINE CELL NAME "FUNDESA"	OF oDetalhe ALIAS ""  	TITLE "Fundesa" PICTURE "@E 999,999.99"  SIZE 14
	// EndIf
EndIf


If !_lAcerto // Se nใo realizou acerto, busca dados do financeiro

	_aEveAuto := ActEveAuto("C")
	For ix := 1 to Len(_aEveAuto)
		If ASCAN(_aEveCel,Alltrim(_aEveAuto[ix][1])) == 0
			DEFINE CELL NAME Alltrim(_aEveAuto[ix][1])	OF oDetalhe ALIAS ""  	TITLE Alltrim(_aEveAuto[ix][2]) PICTURE "@E 99,999.9999"  SIZE 14
			AADD(_aEveCel,Alltrim(_aEveAuto[ix][1]))
		EndIf
	Next ix

	EventFin()
	While !(cAliasFin)->(Eof())
		If ASCAN(_aEveCel,Alltrim((cAliasFin)->EVENTO)) == 0
			DEFINE CELL NAME Alltrim((cAliasFin)->EVENTO)	OF oDetalhe ALIAS ""  	TITLE (cAliasFin)->NOME PICTURE "@E 99,999.9999"  SIZE 14
			AADD(_aEveCel,Alltrim((cAliasFin)->EVENTO))
		EndIf
		(cAliasFin)->(DbSkip())
	EndDo
EndIf

DEFINE CELL NAME "LIQUIDO" 			OF oDetalhe ALIAS ""  	TITLE "Lํquido"  PICTURE "@E 99,999,999.99"  SIZE 16
DEFINE CELL NAME "FORMA" 			OF oDetalhe ALIAS ""  	TITLE "Forma.Pgto"
DEFINE CELL NAME "NRONF" 	 	    OF oDetalhe ALIAS ""  	TITLE "Nro. N.F. "

Return(oReport)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPrintReport   บAutor  ณMicrosiga       บ Data ณ  11/24/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PrintReport(oReport)

Local _nReg      := 0
Local _nCont     := 0
Local oDetalhe   := oReport:Section(1)
Local _cRetiro   := ""
Local _cLoja     := ""
Local _nQtd      := 0
Local _nLiquido  := 0
Local _nPreco    := 0
Local _cAlias    := GetNextAlias()
Local _cAliasFin := GetNextAlias()
Local _nVlrImp   := 0
Local _nPrcImp   := 0
Local _nVlrINSS  := 0
Local ix         := 0
Local _aEveAuto := {}
Private _dDtIni	:= ""
Private _dDtFim	:= ""
Public _pnVLEITE := 0

CriaTab(_cAlias,oDetalhe)

dbSelectArea(_cAlias)
Count to _nReg

LimpaDet(@oDetalhe)

(_cAlias)->(dbGoTop())
oDetalhe:Init()

While !(_cAlias)->(Eof())

	If Alltrim(_cRetiro+_cLoja) <> Alltrim((_cAlias)->CODIGO + (_cAlias)->LOJA)

		DbSelectArea("SA2")
		SA2->(DbSetOrder(1))
		SA2->(MsSeek(xFilial("SA2")+(_cAlias)->CODIGO+(_cAlias)->LOJA))


		oDetalhe:Cell("CODIGO"):SetValue((_cAlias)->CODIGO)
		oDetalhe:Cell("LOJA"):SetValue((_cAlias)->LOJA)
		oDetalhe:Cell("NOME"):SetValue((_cAlias)->NOME)
		oDetalhe:Cell("CODMUN"):SetValue(SA2->A2_COD_MUN)
		oDetalhe:Cell("GRPPRC"):SetValue(SA2->A2_L_LI_RO)
		oDetalhe:Cell("QTD_LEITE"):SetValue((_cAlias)->QTD)

		_cRetiro := (_cAlias)->CODIGO
		_cLoja   := (_cAlias)->LOJA
		_nQtd := (_cAlias)->QTD
		_pnVLEITE := _nQtd
		_nPreco := 0
		_nLiquido := 0

		oDetalhe:Cell("NRONF"):SetValue(GetNF(_cRetiro, _cLoja))

		_lAcerto := (_cAlias)->ZLF_ACERTO == 'S' //Identifica se jแ rodou acerto do leite

		_nFunrural := 0
		_nFundesa  := 0
		If _lAcerto
			VlrFunrural(_cRetiro,_cLoja)
			If _nFunrural > 0
				oDetalhe:Cell("FUNRURAL"):SetValue(_nFunrural * -1)
			EndIf
			If _nFundesa > 0
				oDetalhe:Cell("FUNDESA"):SetValue(_nFundesa * -1)
			EndIf
		EndIf

	EndIf

	_nVlrINSS := _nFunrural + _nFundesa
	_nVlrImp := IIF((_cAlias)->DEBCRE="C",(_cAlias)->VALOR,(_cAlias)->VALOR*-1)
	_nPrcImp := IIF((_cAlias)->DEBCRE="C",(_cAlias)->PRECO,(_cAlias)->PRECO*-1)

	_nCont++
	oDetalhe:Cell(Alltrim((_cAlias)->EVENTO)):SetValue(IIF(_nPrcImp<>0,_nPrcImp,_nVlrImp) )

	_nPreco   += _nPrcImp
	_nLiquido += _nVlrImp

	_nVlrImp := 0
	_nPrcImp := 0


	(_cAlias)->(dbSkip())

	If Alltrim(_cRetiro+_cLoja) <> Alltrim((_cAlias)->CODIGO + (_cAlias)->LOJA)

		If !_lAcerto // Se o relatorio for gerado antes do fechamento do leite, gera colunas de dados do financeiro

			dbSelectArea("ZLE")
			ZLE->(dbSetOrder(1))
			ZLE->(MsSeek(xFilial("ZLE")+MV_PAR01))

			DbSelectArea("SA2")
			SA2->(DbSetOrder(1))
			SA2->(MsSeek(xFilial("SA2")+_cRetiro+_cLoja))

			DbSelectArea("ZL3")
			ZL3->(DbSetOrder(1))
			ZL3->(MsSeek(xFilial("ZL3")+SA2->A2_L_LI_RO))

			DbSelectArea("ZL2")
			ZL2->(DbSetOrder(1))
			ZL2->(MsSeek(xFILIAL("ZL2") + ZL3->ZL3_SETOR))


			_aEveAuto := ActEveAuto("R")
			For ix := 1 to Len(_aEveAuto)
				oDetalhe:Cell(Alltrim(_aEveAuto[ix][1])):SetValue(_aEveAuto[ix][2] )
			Next ix


			CriaFin(_cAliasFin,_cRetiro,_cLoja)
			While !(_cAliasFin)->(Eof())
				oDetalhe:Cell(Alltrim((_cAliasFin)->EVENTO)):SetValue((_cAliasFin)->VALOR*-1 )

				_nLiquido += (_cAliasFin)->VALOR * -1

				(_cAliasFin)->(DbSkip())
			EndDo
		EndIf

		_nLiquido -= _nVlrINSS
		// Cแlculo das colunas
		oDetalhe:Cell("PRECO"):SetValue(_nPreco)
		oDetalhe:Cell("PRECOL"):SetValue(_nPreco - (_nVlrINSS/_nQtd)) //Valor unitario menos o funrural
		oDetalhe:Cell("VALOR"):SetValue(_nPreco*_nQtd)
		oDetalhe:Cell("LIQUIDO"):SetValue(_nLiquido)

		dbSelectArea("SA2")
		SA2->(dbSetOrder(1))
		SA2->(dbSeek(xFilial("SA2") + _cRetiro + _cLoja ) )

		If SA2->A2_L_TPPAG == "B"
			oDetalhe:Cell("FORMA"):SetValue("Banco")
		Else
			oDetalhe:Cell("FORMA"):SetValue("Cheque")
		EndIf

		_nVlrINSS := 0

		oDetalhe:PrintLine()

		LimpaDet(@oDetalhe)

	EndIf

EndDo

oDetalhe:Finish()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaTab บAutor  ณMicrosiga             บ Data ณ  04/11/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Cria tabela temporแria para impressใo do relat๓rio.        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaTab(_cAlias,oObj)

Local nOrdem := 1
Local cOrdem := ""
Local _cFiltro := " "
Local _cValor := ""
Local _cEventos := "'"
Local ix := 0

If _lAcerto
	For ix := 1 to len(_aEveCel)
		If (_aEveCel[ix] != _cEveDeb) .and. (_aEveCel[ix] != _cEveCred) .and. (_aEveCel[ix] != _cEveINSS)
			_cEventos += _aEveCel[ix]+"','"
		EndiF
	Next ix
	_cEventos := SubSTR(_cEventos,1,Len(_cEventos)-2)

	_cValor := "% CASE WHEN MAX(ZL8_TPEVEN) IN ('A','F') AND MAX(ZL8_DEBCRE) = 'D' THEN SUM(ZLF_VLRPAG) ELSE SUM(ZLF_TOTAL+ZLF_SE1ACR) END %"
Else
	For ix := 1 to len(_aEveCel)
		If (_aEveCel[ix] != _cEveDeb) .and. (_aEveCel[ix] != _cEveCred)
			_cEventos += _aEveCel[ix]+"','"
		EndiF
	Next ix
	_cEventos := SubSTR(_cEventos,1,Len(_cEventos)-2)

	_cValor := "% SUM(ZLF_TOTAL+ZLF_SE1ACR) %"
EndIf
_cFiltro := "% ZLF_EVENTO IN ("+_cEventos+") %"


nOrdem := oObj:GetOrder()

If nOrdem == 1
	cOrdem := "% ZLF_A2NOME,ZLF_RETIRO,ZLF_RETILJ,ZLF_LINROT %"
ElseIf nOrdem == 2
	cOrdem := "% ZLF_RETIRO,ZLF_RETILJ,ZLF_A2NOME,ZLF_LINROT %"
Else
	cOrdem := "% ZLF_LINROT,ZLF_A2NOME,ZLF_RETIRO,ZLF_RETILJ %"
EndIf

BeginSql Alias _cAlias

	SELECT ZLF_RETIRO AS CODIGO,ZLF_RETILJ AS LOJA,ZLF_A2NOME AS NOME, ZLF_EVENTO AS EVENTO, MAX(ZLF_DEBCRE) AS DEBCRE, ZLF_QTDBOM AS QTD,ZLF_LINROT AS GRUPO,
		%Exp:_cValor% AS VALOR,
		SUM(ZLF_VLRLTR) AS PRECO,ZLF_FINOK as ZLF_ACERTO
		FROM %Table:ZLF% ZLF
		JOIN %Table:ZL8% ZL8 ON ZL8_COD = ZLF_EVENTO AND ZL8.%NotDel%
	WHERE ZLF.ZLF_FILIAL = %xFilial:ZLF%
	AND ZLF_CODZLE = %Exp:MV_PAR01%
	AND ZLF_SETOR = %Exp:MV_PAR02%
	AND ZLF_RETIRO  BETWEEN %Exp:MV_PAR03% AND %Exp:MV_PAR04%
	AND %Exp:_cFiltro%
	AND ZLF.%NotDel%
	GROUP BY ZLF_RETIRO,ZLF_RETILJ,ZLF_A2NOME, ZLF_EVENTO,ZLF_LINROT,ZLF_QTDBOM, ZLF_FINOK
	ORDER BY %Exp:cOrdem%

EndSql

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaFin บAutor  ณMicrosiga             บ Data ณ  23/11/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Cria tabela temporแria para impressใo do relat๓rio.        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaFin(cAliasFin,xcRetiro,xcLoja)

Local _cFiltro  := ""
Local _cEventos := " "
Local ix        := 0


If Select(cAliasFin) <> 0
	(cAliasFin)->(DbCloseArea())
EndIf

_dDtIni := ZLE->ZLE_DTINI
_dDtFim := DaySum(ZLE->ZLE_DTFIM,30) //soma 30 dias para vencimento final

For ix := 1 to len(_aEveCel)
	If (_aEveCel[ix] != _cEveDeb) .and. (_aEveCel[ix] != _cEveCred) .and. (_aEveCel[ix] != _cEveINSS)
		_cEventos += _aEveCel[ix]+"','"
	EndiF
Next ix
_cEventos := SubSTR(_cEventos,1,Len(_cEventos)-2)


_cFiltro := "% E1_VENCTO BETWEEN '"+DTOS(_dDtIni)+"' AND '"+DTOS(_dDtFim)+"'  AND E1_L_EVENT IN ('"+_cEventos+") %"


BeginSql Alias cAliasFin

	SELECT E1_L_EVENT AS EVENTO, SUM(E1_SALDO+E1_SDACRES) AS VALOR
	FROM %Table:SE1% SE1
		JOIN %Table:ZL8% ZL8 ON ZL8_FILIAL = %xFilial:ZL8% AND ZL8_COD = E1_L_EVENT AND ZL8.%NotDel%
	WHERE SE1.E1_FILIAL = %xFilial:SE1%
	AND E1_CLIENTE = %Exp:xcRetiro%
	AND E1_LOJA = %Exp:xcLoja%
	AND %Exp:_cFiltro%
	AND SE1.E1_SALDO > 0
	AND SE1.E1_L_EVENT <> ' '
	GROUP BY E1_L_EVENT
	ORDER BY E1_L_EVENT
EndSql

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEventos   บAutor  ณMicrosiga           บ Data ณ  22/08/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Eventos()

Local _cFiltro := " "

If Select(cAliasEve) <> 0
	(cAliasEve)->(DbCloseArea())
EndIf

If _lAcerto
	_cFiltro := "% ZLF_EVENTO NOT IN ('"+_cEveDeb+"','"+_cEveCred+"') %"
Else
	_cFiltro := "% ZLF_EVENTO NOT IN ('"+_cEveDeb+"','"+_cEveCred+"','"+_cEveINSS+"' ) %"
EndIf


BeginSql alias cAliasEve


	SELECT ZLF_EVENTO AS EVENTO,MAX(ZLF_DEBCRE) AS DEBCRE,
	ZL8_GRUPO AS GRUPO,ZL8_NREDUZ AS NOME, ZL8_TPEVEN AS TIPO, ZL8_MIX AS ENTMIX, ZLF_ACERTO,
		CASE WHEN ZL8_TPEVEN = 'L' THEN 1
				WHEN ZL8_TPEVEN = 'R' THEN 2
				WHEN ZL8_TPEVEN = 'A' THEN 3
				WHEN ZL8_TPEVEN = 'F' AND ZL8_DEBCRE = 'C' THEN 4
				WHEN ZL8_TPEVEN = 'F' AND ZL8_DEBCRE = 'D' THEN 5
				END AS ORDEM
	FROM %Table:ZLF% ZLF
		JOIN %Table:ZL8% ZL8 ON ZL8_FILIAL = %xFilial:ZL8% AND ZL8_COD = ZLF_EVENTO AND ZL8.%NotDel%
	WHERE ZLF.ZLF_FILIAL = %xFilial:ZLF%
	AND ZLF.ZLF_CODZLE =  %Exp:MV_PAR01%
	AND ZLF.ZLF_SETOR = %Exp:MV_PAR02%
	AND ZLF.ZLF_TP_MIX = 'L'
	AND %Exp:_cFiltro%
	AND ZLF.%NotDel%
	GROUP BY ZLF_EVENTO ,ZL8_GRUPO,ZL8_NREDUZ, ZL8_TPEVEN, ZL8_MIX,ZL8_DEBCRE, ZLF_ACERTO
	ORDER BY ORDEM,ZLF_EVENTO

EndSql

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEventFin   บAutor  ณMicrosiga           บ Data ณ  22/08/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function EventFin()

Local _cFiltro := ""

If Select(cAliasFin) <> 0
	(cAliasFin)->(DbCloseArea())
EndIf

dbSelectArea("ZLE")
ZLE->(dbSetOrder(1))
ZLE->(dbSeek(xFilial("ZLE")+MV_PAR01))
_dDtIni := ZLE->ZLE_DTINI
_dDtFim := DaySum(ZLE->ZLE_DTFIM,30) //soma 30 dias para vencimento final

_cFiltro := "% E1_VENCTO BETWEEN '"+DTOS(_dDtIni)+"' AND '"+DTOS(_dDtFim)+"'  %"

BeginSql alias cAliasFin


	SELECT E1_L_EVENT AS EVENTO, 'D' AS DEBCRE,
	ZL8_GRUPO AS GRUPO,ZL8_NREDUZ AS NOME, ZL8_TPEVEN AS TIPO, ZL8_MIX AS ENTMIX,
		CASE WHEN ZL8_TPEVEN = 'L' THEN 1
				WHEN ZL8_TPEVEN = 'R' THEN 2
				WHEN ZL8_TPEVEN = 'A' THEN 3
				WHEN ZL8_TPEVEN = 'F' AND ZL8_DEBCRE = 'C' THEN 4
				WHEN ZL8_TPEVEN = 'F' AND ZL8_DEBCRE = 'D' THEN 5
				END AS ORDEM
	FROM %Table:SE1% SE1
		JOIN %Table:ZL8% ZL8 ON ZL8_FILIAL = %xFilial:ZL8% AND ZL8_COD = E1_L_EVENT AND ZL8.%NotDel%
	WHERE SE1.E1_FILIAL = %xFilial:SE1%
	AND E1_SALDO > 0
	AND E1_CLIENTE BETWEEN %Exp:MV_PAR03% AND %Exp:MV_PAR04%
	AND %Exp:_cFiltro%
	AND SE1.E1_L_EVENT <> ' '
	GROUP BY E1_L_EVENT ,ZL8_GRUPO,ZL8_NREDUZ, ZL8_TPEVEN, ZL8_MIX,ZL8_DEBCRE
	ORDER BY ORDEM,E1_L_EVENT

EndSql

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLimpaDet  บAutor  ณMicrosiga           บ Data ณ  04/11/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Limpa c้lulas da sessใo oDetalhe.                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function LimpaDet(oDetalhe)

Local nTamanho := Len(oDetalhe:aCell)
Local _iCol := 0
// Limpa os dados das c้lulas do relat๓rio.
For _iCol := 1 to nTamanho
 If oDetalhe:Cell(_iCol):cType == "D"
  oDetalhe:Cell(_iCol):SetValue(CtoD("  /  /  "))
 ElseIf oDetalhe:Cell(_iCol):cType == "C"
  oDetalhe:Cell(_iCol):SetValue("")
 Else
  oDetalhe:Cell(_iCol):SetValue(0)
 EndIf
Next _iCol

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetNF บAutor  ณMicrosiga               บ Data ณ  04/11/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna n๚mero da nota fiscal de compra de leite.          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetNF(_pcProdutor, _pcLoja)

Local _cRetorno := ""
Local _cArq   := GetNextAlias()

BeginSql Alias _cArq

	SELECT F1_DOC

	FROM %Table:SF1% SF1

	WHERE F1_FILIAL >= ' '
	AND F1_FORNECE = %Exp:_pcProdutor%
	AND F1_LOJA    = %Exp:_pcLoja%
	AND F1_L_MIX  = %Exp:MV_PAR01%
	AND SF1.D_E_L_E_T_ = ' '

EndSql

dbSelectArea(_cArq)
(_cArq)->(dbGoTop())

_cRetorno := (_cArq)->F1_DOC

(_cArq)->(dbCloseArea())

If Empty(_cRetorno)
	_cRetorno := "ABERTO"
EndIf

Return(_cRetorno)



/*
===============================================================================================================================
Programa----------: VlrFunrural
Autor-------------: GUILHERME FRANวA
Data da Criacao---: 30/08/2019
===============================================================================================================================
Descricao---------: Retorna valor do funrural calculado na NF

===============================================================================================================================
Uso---------------: Modulo Gestao do Leite
===============================================================================================================================
*/
Static Function VlrFunrural(xcCod,xcLoja)

Local _cFiltro := ""
DEFAULT xcCod  := ""
DEFAULT xcLoja := ""


If !Empty(xcCod)
	_cFiltro := "% F1.F1_FORNECE = '"+xcCod+"' AND  F1.F1_LOJA = '"+xcLoja+"'  %"
else
	_cFiltro := "% F1.F1_FORNECE <> ' '	%"
ENDIF

BeginSql alias "TNFL"

	SELECT F1_FORNECE, F1_LOJA, SUM(F1_VLSENAR) AS F1_VLSENAR, SUM(F1_INSS + F1_CONTSOC) AS F1_INSS, SUM(F1_VALFUND) AS F1_VALFUND,
	SUM(F1_VLSENAR+ F1_CONTSOC + F1_INSS) AS VLRTOT
	FROM %Table:SF1%  F1
	WHERE F1.F1_L_MIX = %Exp:MV_PAR01%
	AND F1.F1_L_SETOR = %Exp:MV_PAR02%
	AND %Exp:_cFiltro%
	AND F1.%NotDel%

	GROUP BY F1_FORNECE, F1_LOJA
EndSql

DbSelectArea("TNFL")

If TNFL->VLRTOT > 0
	_nFunrural :=  TNFL->VLRTOT
EndIf

If TNFL->F1_VALFUND > 0
	_nFundesa := TNFL->F1_VALFUND
EndIf

TNFL->(DbCloseArea())

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
Static Function ActEveAuto(xOp)

	Local _cAliasEv := GetNextAlias()
	Local _aRet := {}
	Local nVlrEvto := 0

	BeginSql alias _cAliasEv
		SELECT ZL8_COD, ZL8_NREDUZ,ZL8_DEBCRE
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

		If xOp == "C"
			AADD(_aRet,{(_cAliasEv)->ZL8_COD, (_cAliasEv)->ZL8_NREDUZ})
		Else

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
				nVlrEvto := Iif((_cAliasEv)->ZL8_DEBCRE == "C",nVlrEvto,nVlrEvto*-1)
				If nVlrEvto <> 0
					AADD(_aRet,{(_cAliasEv)->ZL8_COD, nVlrEvto})
				EndIf
			EndIf
		EndIf
		(_cAliasEv)->(dbSkip())
	EndDo

	(_cAliasEv)->(DbCloseArea())

Return _aRet
