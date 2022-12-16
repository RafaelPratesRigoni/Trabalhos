#INCLUDE "Protheus.ch"
#INCLUDE "Report.ch"
#INCLUDE "TopConn.ch"
#INCLUDE "RwMake.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRGLT041   บAutor  ณGuilherme Fran็a    บ Data ณ  23/08/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relatorio da media de pre็o mensal de todas as filiais    บฑฑ
ฑฑบ          ณ somando o valor do frete.                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function RGLT041()

Private cPerg := "PRGLT41"

If !Pergunte(cPerg,.T.)
	Return
EndIf


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
Local nI	:= 0
Private _cAlias := GetNextAlias()

DEFINE REPORT oReport NAME "RGLT041" TITLE "M้dia Pre็o Mensal" PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)}

oReport:nLineHeight	:= 45            // Define a altura da linha.
oReport:lParamPage		:= .F.
oReport:SetLandscape(.t.)
oReport:GetOrientation(2)
oReport:SetTotalInLine(.F.)
oReport:nFontBody := 8

DEFINE SECTION oCab OF oReport TITLE "Cabe็alho" TABLES "ZLD"
DEFINE CELL NAME "CABEC" 		OF oCab ALIAS "" TITLE " " block {|| "Resultado consolidado de todas as filiais do mix: "+MV_PAR01 } SIZE 150


DEFINE SECTION oDetalhe OF oCab  TITLE "Detalhes"
//ORDERS aOrd

DEFINE CELL NAME "SETOR" 		OF oDetalhe ALIAS "" TITLE "Setor"  	SIZE 15	// 01
DEFINE CELL NAME "NOMSET" 		OF oDetalhe ALIAS "" TITLE "Descricao"  SIZE 30			// 02
DEFINE CELL NAME "QTD" 			OF oDetalhe ALIAS "" TITLE "Litragem"   PICTURE "@E 99,999,999"  SIZE 16
DEFINE CELL NAME "MIXLTE" 		OF oDetalhe ALIAS "" TITLE "Mix Leite"	PICTURE "@E 9.99999"  SIZE 10
DEFINE CELL NAME "MIXFRT" 		OF oDetalhe ALIAS "" TITLE "Mix Frete"	PICTURE "@E 9.99999"  SIZE 10
DEFINE CELL NAME "MIXTOT" 		OF oDetalhe ALIAS "" TITLE "Mix Final"	PICTURE "@E 9.99999"  SIZE 10
DEFINE CELL NAME "VLRLTE" 		OF oDetalhe ALIAS "" TITLE "Valor Leite" PICTURE "@E 99,999,999.99"  SIZE 20
DEFINE CELL NAME "VLRFRT" 		OF oDetalhe ALIAS "" TITLE "Valor Frete" PICTURE "@E 99,999,999.99"  SIZE 20
DEFINE CELL NAME "VALOR" 		OF oDetalhe ALIAS "" TITLE "Valor Pagar" PICTURE "@E 99,999,999.99"  SIZE 20



//Desenha as bordas das celulas
For nI := 1 To 9
	//Monta as bordas
	oDetalhe:Cell(nI):SetBorder("LEFT")
	oDetalhe:Cell(nI):SetBorder("TOP")
	oDetalhe:Cell(nI):SetBorder("RIGHT")
	oDetalhe:Cell(nI):SetBorder("BOTTOM")
	//Alinha as bordas
	oDetalhe:Cell(nI):SetHeaderAlign("CENTER")
	oDetalhe:Cell(nI):SetAlign("CENTER")
Next nI


oDetalhe:SetTotalInLine(.F.)

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


Local oDetalhe	:= oReport:Section(1):Section(1)
Local _nTQtd := 0
Local _nTVlrLte := 0
Local _nTVlrFrt := 0
Local ix		:= 0
Private _aQtd := {}
Private _aValor := {}
Private _aFrete := {}
Private _cProd := ""
Private _cSpot := GetNextAlias()
Private _cFiltro := ""

dbSelectArea("ZLE")
ZLE->(dbSetOrder(1))
ZLE->(dbSeek(xFilial("ZLE")+MV_PAR01))

_cFiltro := "%	'"+DTOS(ZLE->ZLE_DTINI)+"' AND '"+DTOS(ZLE->ZLE_DTFIM)+"'  %"
CriaTab()


LimpaDet(@oDetalhe)


oDetalhe:Init()

If Len(_aQtd)>0 .and. Len(_aValor)>0

	For ix:= 1 to Len(_aQtd)

		oDetalhe:Cell("SETOR"):SetValue(_aQtd[ix][1])
		oDetalhe:Cell("NOMSET"):SetValue(_aQtd[ix][2])
		oDetalhe:Cell("QTD"):SetValue(_aQtd[ix][3])
		oDetalhe:Cell("MIXLTE"):SetValue(_aValor[ix][2]/_aQtd[ix][3])
		If Len(_aFrete) > 0
			oDetalhe:Cell("MIXFRT"):SetValue(_aFrete[ix][2]/_aQtd[ix][3])
			oDetalhe:Cell("MIXTOT"):SetValue((_aValor[ix][2]+_aFrete[ix][2])/_aQtd[ix][3])
			oDetalhe:Cell("VLRFRT"):SetValue(_aFrete[ix][2])
			oDetalhe:Cell("VALOR"):SetValue(_aValor[ix][2]+_aFrete[ix][2])

		Else
			oDetalhe:Cell("MIXFRT"):SetValue(0)
			oDetalhe:Cell("MIXTOT"):SetValue((_aValor[ix][2])/_aQtd[ix][3])
			oDetalhe:Cell("VLRFRT"):SetValue(0)
			oDetalhe:Cell("VALOR"):SetValue(_aValor[ix][2])

		EndIf
		oDetalhe:Cell("VLRLTE"):SetValue(_aValor[ix][2])
		oDetalhe:Cell("VLRFRT"):SetValue(_aFrete[ix][2])
		oDetalhe:Cell("VALOR"):SetValue(_aValor[ix][2]+_aFrete[ix][2])

		_nTQtd += _aQtd[ix][3]
		_nTVlrLte += _aValor[ix][2]
		_nTVlrFrt += _aFrete[ix][2]

		oDetalhe:PrintLine()

		LimpaDet(@oDetalhe)

		If Empty(_cProd)
			_cProd := GetAdvFVal("ZL2","ZL2_PRODUT",xFilial("ZL2")+_aQtd[ix][1],1,"")
		EndIf

	Next ix

	// LEITE SPOT
	If Select(_cSpot) <> 0
		(_cSpot)->(DbCloseArea())
	EndIf

	BeginSql alias _cSpot
		SELECT A2_NOME AS NOME, SUM(D1_QUANT) AS QTD, SUM(D1_TOTAL) AS VALOR
		FROM %Table:SD1% D1
			JOIN %Table:SA2% A2 ON A2.A2_COD = D1.D1_FORNECE AND A2.A2_LOJA = D1.D1_LOJA AND A2_TIPO = 'J' AND A2.%NotDel%
			JOIN %Table:SF4% F4 ON F4_CODIGO = D1.D1_TES AND F4_DUPLIC = 'S' AND F4_ESTOQUE = 'S' AND F4.%NotDel%
		WHERE D1_COD = %Exp:_cProd%
		AND D1_FORMUL <> 'S'
		AND D1_EMISSAO BETWEEN %Exp:_cFiltro%
		AND D1.%NotDel%
		GROUP BY A2_NOME
	EndSql

	While !(_cSpot)->(Eof())
		oDetalhe:Cell("SETOR"):SetValue("SPOT")
		oDetalhe:Cell("NOMSET"):SetValue(SubStr((_cSpot)->NOME,1,30))
		oDetalhe:Cell("QTD"):SetValue((_cSpot)->QTD)

		_nTQtd += (_cSpot)->QTD

		oDetalhe:Cell("MIXLTE"):SetValue( Round((_cSpot)->VALOR/(_cSpot)->QTD,4))

		If .F. //MV_PAR04 >0
			oDetalhe:Cell("MIXFRT"):SetValue(MV_PAR04/MV_PAR02)
		Else
			oDetalhe:Cell("MIXFRT"):SetValue(0)
		EndIf

		oDetalhe:Cell("MIXTOT"):SetValue( Round((_cSpot)->VALOR/(_cSpot)->QTD,4))

		oDetalhe:Cell("VLRLTE"):SetValue((_cSpot)->VALOR)
		_nTVlrLte += (_cSpot)->VALOR

		oDetalhe:Cell("VLRFRT"):SetValue(0)
		_nTVlrFrt += 0
		oDetalhe:Cell("VALOR"):SetValue((_cSpot)->VALOR)

		oDetalhe:PrintLine()

		LimpaDet(@oDetalhe)
		(_cSpot)->(DbSkip())
	EndDo

Else
	MsgInfo("Dados nใo encontrados para o MIX selecionado!","Arquivo Vazio")

EndIf

//Totais
If _nTQtd > 0

	oDetalhe:Cell("SETOR"):Hide();oDetalhe:Cell("QTD"):Hide();oDetalhe:Cell("MIXLTE"):Hide();oDetalhe:Cell("MIXFRT"):Hide();oDetalhe:Cell("MIXTOT"):Hide();	oDetalhe:Cell("VLRLTE"):Hide();	oDetalhe:Cell("VLRFRT"):Hide();oDetalhe:Cell("VALOR"):Hide()

	oDetalhe:PrintLine()

	oDetalhe:Cell("SETOR"):Show();oDetalhe:Cell("QTD"):Show();oDetalhe:Cell("MIXLTE"):Show();oDetalhe:Cell("MIXFRT"):Show();oDetalhe:Cell("MIXTOT"):Show();	oDetalhe:Cell("VLRLTE"):Show();	oDetalhe:Cell("VLRFRT"):Show();oDetalhe:Cell("VALOR"):Show()

	oDetalhe:Cell("SETOR"):SetValue("Resultado Final -->")
	oDetalhe:Cell("QTD"):SetValue(_nTQtd)
	oDetalhe:Cell("MIXLTE"):SetValue(_nTVlrLte/_nTQtd)
	oDetalhe:Cell("MIXFRT"):SetValue(_nTVlrFrt/_nTQtd)
	oDetalhe:Cell("MIXTOT"):SetValue((_nTVlrLte+_nTVlrFrt)/_nTQtd)
	oDetalhe:Cell("VLRLTE"):SetValue(_nTVlrLte)
	oDetalhe:Cell("VLRFRT"):SetValue(_nTVlrFrt)
	oDetalhe:Cell("VALOR"):SetValue(_nTVlrLte+_nTVlrFrt)

	oDetalhe:PrintLine()
	LimpaDet(@oDetalhe)
EndIf

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
Static Function CriaTab()


Local _cFiltro := ""

DbSelectArea("ZLE")
DbSetOrder(1)
MsSeek(xFilial("ZLE")+MV_PAR01)

// Select para buscar quantidades do MIX
BeginSql alias "TQTD"

	SELECT ZLD_FILIAL AS SETOR,L2.ZL2_DESCRI AS DESCRI, SUM(ZLD_QTDBOM) AS QTD
	FROM %Table:ZLD% ZLD
	JOIN %Table:ZL2% L2 ON ZL2_FILIAL = ZLD_FILIAL AND ZL2_COD = ZLD_SETOR AND L2.%NotDel%
	WHERE ZLD_DTCOLE BETWEEN %Exp:ZLE->ZLE_DTINI% AND %Exp:ZLE->ZLE_DTFIM%
	AND ZLD.%NotDel%
	GROUP BY ZLD_FILIAL,ZL2_DESCRI
	ORDER BY ZLD_FILIAL
EndSql

DbSelectArea("TQTD")
("TQTD")->(DbGoTop())

//Preenche array de quantidade
While !("TQTD")->(Eof())
	AADD(_aQtd,{("TQTD")->SETOR,("TQTD")->DESCRI,("TQTD")->QTD})
	("TQTD")->(DbSkip())
EndDo

// Select para buscar valor do mix
_cFiltro := "% %"

BeginSql alias "TVLR"

	SELECT ZLF_FILIAL AS FILIAL,SUM(CASE WHEN ZLF_DEBCRE = 'C' THEN ZLF_TOTAL ELSE -ZLF_TOTAL END) AS VALOR
	FROM %Table:ZLF% ZLF
	WHERE ZLF_CODZLE = %Exp:MV_PAR01%
	AND ZLF_ORIGEM = 'M'
	%Exp:_cFiltro%
	AND ZLF.%NotDel%
	GROUP BY ZLF_FILIAL
	ORDER BY ZLF_FILIAL

EndSql

DbSelectArea("TVLR")
("TVLR")->(DbGoTop())

//Preenche array de valor
While !("TVLR")->(Eof())
	AADD(_aValor,{("TVLR")->FILIAL,("TVLR")->VALOR})
	("TVLR")->(DbSkip())
EndDo


// Select para buscar frete
BeginSql alias "TFRT"

	SELECT ZLQ_FILIAL AS FILIAL, ZLQ_MIX,
	SUM(CASE WHEN ZLQ_DEBCRE = 'C' THEN ZLQ_VLRTOT ELSE -ZLQ_VLRTOT END) AS VALOR
	FROM %Table:ZLQ% ZLQ
	WHERE ZLQ_MIX = %Exp:MV_PAR01%
	AND ZLQ.%NotDel%
	GROUP BY ZLQ_FILIAL, ZLQ_MIX

EndSql


DbSelectArea("TFRT")
("TFRT")->(DbGoTop())

//Preenche array de valor
While !("TFRT")->(Eof())
	AADD(_aFrete,{("TFRT")->FILIAL,("TFRT")->VALOR})
	("TFRT")->(DbSkip())
EndDo

//Tratamento para zerar frete caso nใo seja informado
If Len(_aFrete)<1
	DbSelectArea("TVLR")
	("TVLR")->(DbGoTop())

	//Preenche array de valor
	While !("TVLR")->(Eof())
		AADD(_aFrete,{("TVLR")->FILIAL,0})
		("TVLR")->(DbSkip())
	EndDo

EndIf

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
Local _iCol	:= 0

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