#include "protheus.ch"
#include "report.ch"


// #########################################################################################
// Projeto: Gestão do Leite
// Modulo : Gestão do Leite
// Fonte  : RGLT037
// ---------+-------------------+-----------------------------------------------------------
// Data     | Autor             | Descricao
// ---------+-------------------+-----------------------------------------------------------
// 22/02/21 | Guilherme França  | Lista de Créditos do Produtor
// ---------+-------------------+-----------------------------------------------------------

User Function RGLT037()

Local _aArea := GetArea()
Local oReport
Local oCab
Local oDet
Private cPerg := "RGLT037"
Private _cAlias := "ZLG"

Pergunte(cPerg,.F.)

MV_PAR01 := MV_PAR02 := ZLG->ZLG_CODIGO
MV_PAR03 := MV_PAR04 := ZLG->ZLG_EVENTO
MV_PAR05 := MV_PAR06 := ZLG->ZLG_DTLANC


DEFINE REPORT oReport NAME "RGLT037" TITLE "Pagamento de Créditos" PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)}
oReport:SetTotalInLine(.F.)
oReport:nFontBody	:= 7
oReport:cFontBody	:= "Courier New"


DEFINE SECTION oCab OF oReport TITLE "Dados" TABLES "ZLG"

DEFINE CELL NAME "ZLG_CODIGO" OF oCab ALIAS _cAlias TITLE "Cod.Lancto."
DEFINE CELL NAME "ZLG_DTLANC" OF oCab
DEFINE CELL NAME "ZLG_CODMIX" OF oCab ALIAS _cAlias TITLE "Cod.MIX"
DEFINE CELL NAME "ZLG_EVENTO" OF oCab
DEFINE CELL NAME "ZLG_DESEVE" OF oCab
DEFINE CELL NAME "ZLG_VENCTO" OF oCab

oCab:SetTotalInLine(.F.)

DEFINE SECTION oDet OF oCab TITLE "Produtores" TABLE "ZLL"
DEFINE CELL NAME "ZLG_ITEM" OF oDet
DEFINE CELL NAME "ZLG_CODSA2" OF oDet
DEFINE CELL NAME "ZLG_LOJSA2" OF oDet
DEFINE CELL NAME "ZLG_NOME" OF oDet
DEFINE CELL NAME "ZLG_VALOR" OF oDet  ALIAS _cAlias TITLE "Valor Credito"	PICTURE "@E 9,999,999.99"

DEFINE FUNCTION FROM oDet:Cell("ZLG_VALOR") OF oCab FUNCTION SUM TITLE "Valor Total"


oReport:PrintDialog()

RestArea(_aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RGLT037   ºAutor  ³Microsiga           º Data ³  07/12/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport)

Local _cDatas := "% '"+DTOS(MV_PAR05)+"' AND '"+DTOS(MV_PAR06)+"'  %"

#IFDEF TOP
	cAlias := GetNextAlias()

	BEGIN REPORT QUERY oReport:Section(1)

	BeginSql alias cAlias

	SELECT *
	FROM
	 %table:ZLG% ZLG
	WHERE
	 ZLG.ZLG_FILIAL = %xFilial:ZLG%
	 and ZLG.ZLG_CODIGO between %exp:MV_PAR01% and %exp:MV_PAR02%
	 and ZLG.ZLG_EVENTO  between %exp:MV_PAR03% and %exp:MV_PAR04%
	 AND ZLG.ZLG_DTLANC BETWEEN %Exp:_cDatas%
	 AND ZLG.%NotDel%

	EndSql

	END REPORT QUERY oReport:Section(1)

	oReport:Section(1):Section(1):SetParentQuery()
	oReport:Section(1):Section(1):SetParentFilter({|cParam| (cAlias)->ZLG_CODIGO == cParam},{|| (cAlias)->ZLG_CODIGO})

	oReport:Section(1):Print()
#ENDIF
Return