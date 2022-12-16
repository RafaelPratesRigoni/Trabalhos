#include "protheus.ch"
#include "report.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RGLT038   ºAutor  ³Microsiga           º Data ³  08/24/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function RGLT038()
Local oReport
Local oCabec
Local oDet01

Pergunte("RGLT038",.F.)

DEFINE REPORT oReport NAME "RGLT038" TITLE "Relação das Notas Fiscais Emitidas" PARAMETER "RGLT038" ACTION {|oReport| PrintReport(oReport)}

	DEFINE SECTION oCabec OF oReport TITLE "Município" TABLES "SA1"

		DEFINE CELL NAME "A1_COD" OF oCabec ALIAS "SA1"

	DEFINE SECTION oDet01 OF oCabec TITLE "Pedido" TABLE "SC5"

		DEFINE CELL NAME "NUM" OF oDet01 TITLE "Produtor" SIZE 10
		DEFINE CELL NAME "C5_NUM" OF oDet01 TITLE "Nome"
		DEFINE CELL NAME "C5_TIPO" OF oDet01 TITLE "Nr NF"
		DEFINE CELL NAME "C5_VEND1" OF oDet01 TITLE "Cota"
		DEFINE CELL NAME "C5_VEND1" OF oDet01 TITLE "EXCES"
		DEFINE CELL NAME "C5_VEND1" OF oDet01 TITLE "M GORDA"
		DEFINE CELL NAME "C5_VEND1" OF oDet01 TITLE "BON/PRM"
		DEFINE CELL NAME "C5_VEND1" OF oDet01 TITLE "Total"
		DEFINE CELL NAME "C5_VEND1" OF oDet01 TITLE "Funrural"
		DEFINE CELL NAME "C5_VEND1" OF oDet01 TITLE "Liquido"

		DEFINE FUNCTION FROM oDet01:Cell("COTA") FUNCTION SUM
		DEFINE FUNCTION FROM oDet01:Cell("EXCES") FUNCTION SUM
		DEFINE FUNCTION FROM oDet01:Cell("M GORDA") FUNCTION SUM
		DEFINE FUNCTION FROM oDet01:Cell("BON/PRM") FUNCTION SUM
		DEFINE FUNCTION FROM oDet01:Cell("TOTAL") FUNCTION SUM
		DEFINE FUNCTION FROM oDet01:Cell("FUNRURAL") FUNCTION SUM
		DEFINE FUNCTION FROM oDet01:Cell("LIQUIDO") FUNCTION SUM


oReport:PrintDialog()
Return

Static Function PrintReport(oReport)
Local cAlias := GetNextAlias()

BEGIN REPORT QUERY oReport:Section(1)

BeginSql alias cAlias
	SELECT A1_COD,A1_NOME,A1_VEND,A1_MCOMPRA,
		C5_NUM NUM,C5_NUM,C5_TIPO,C5_VEND1,C5_CLIENTE,
		C6_ITEM,C6_PRODUTO,C6_UM,C6_QTDVEN,C6_PRCVEN,C6_VALOR,C6_NUM,
		B1_DESC,B1_GRUPO

	FROM %table:SA1% SA1, %table:SC5% SC5, %table:SC6% SC6, %table:SB1% SB1

	WHERE A1_FILIAL = %xfilial:SA1% AND SA1.%notDel% AND
		C5_FILIAL = %xfilial:SC5% AND SC5.%notDel% AND C5_CLIENTE = A1_COD AND
		C6_FILIAL = %xfilial:SC6% AND SC6.%notDel% AND C6_NUM = C5_NUM AND
		B1_FILIAL = %xfilial:SB1% AND SB1.%notDel% AND B1_COD = C6_PRODUTO

	ORDER BY A1_FILIAL,A1_COD,
		C5_FILIAL,C5_NUM,
		C6_FILIAL,C6_ITEM
EndSql

END REPORT QUERY oReport:Section(1) PARAM mv_par01

oReport:Section(1):Section(1):SetParentQuery()
oReport:Section(1):Section(1):SetParentFilter({|cParam| (cAlias)->C5_CLIENTE == cParam},{|| (cAlias)->A1_COD})

oReport:Section(1):Print()
Return