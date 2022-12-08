#include "Protheus.ch"
#include "TOTVS.ch"
#include "Topconn.ch"

User Function GLEPY209()

	Private oReport := Nil
	Private oSection := NIL
	Private cPerg   := "PRGLT206"

	Pergunte(cPerg, .T.)
	ReportDef()
	oReport:PrintDialog()

Return

Static Function ReportDef()

	oReport := TReport():New("GLEPY209","Relatório Conferência Eventos CP e CR",cPerg,{|oReport| PrintReport(oReport)},;
		"Conferência Eventos CP e CR")

	oReport:SetLandScape(.T.)
	oReport:lParamPage := .F.
	oReport:oPage:SetPaperSize(9)

	oSection := TRSection():New(oReport,"CONFERENCIA EVENTOS CP CR")

	TrCell():New(oSection, "COD_EVENTO",      , "CODIGO")
	TrCell():New(oSection, "ZL8_DESCRI", "ZL8", "EVENTO")
	TrCell():New(oSection, "CR"        ,      , "C.RECEBER")
	TrCell():New(oSection, "CP"        ,      , "C.PAGAR","@E 999,999,999,999,999.99", , , ,"LEFT")

	oSection:SetTotalInLine(.F.)
	TRFunction():New(oSection:Cell("CR"), , "SUM")
	TRFunction():New(oSection:Cell("CP"), , "SUM")
	

Return

Static Function PrintReport()

	Local cAlias := GetNextAlias()

	oSection:BeginQuery()
	BeginSql Alias cAlias

         SELECT COD_EVENTO, ZL8_DESCRI, SUM(CR) AS CR, SUM(CP) AS CP
            FROM
                (
                SELECT  E1_L_EVENT AS COD_EVENTO
                    ,   E1_VALOR AS CR
                    ,   0 AS CP
                FROM %TABLE:SE1% SE1
                WHERE SE1.%notdel%
                    AND E1_FILIAL = %EXP:MV_PAR03% 
                    AND E1_EMISSAO BETWEEN %EXP:MV_PAR01% AND %EXP:MV_PAR02%
                    AND E1_TIPO   = 'FLE'
                UNION ALL
                SELECT  E2_L_EVENT AS COD_EVENTO    
                    ,   0 AS CR
                    ,   E2_VALOR AS CP
                FROM %TABLE:SE2% SE2
                WHERE SE2.%notdel% 
                    AND E2_FILIAL = %EXP:MV_PAR03% 
                    AND E2_EMISSAO BETWEEN %EXP:MV_PAR01% AND %EXP:MV_PAR02%
                    AND E2_TIPO   = 'FLE'
                ) 
        INNER JOIN %TABLE:ZL8% ZL8 ON ZL8.%notdel% AND ZL8_COD = COD_EVENTO
        GROUP BY COD_EVENTO, ZL8_DESCRI
        ORDER BY 1

	ENDSQL
	oSection:EndQuery()
	oSection:Print()
	(cAlias)->(DbCloseArea())

Return



