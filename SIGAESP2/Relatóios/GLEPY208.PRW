#include "Protheus.ch"
#include "TOTVS.ch"
#include "Topconn.ch"

User Function GLEPY208()

	Private oReport := Nil
	Private oSection := NIL
	Private cPerg   := "PRGLT208"

	Pergunte(cPerg, .T.)
	ReportDef()
	oReport:PrintDialog()

Return

Static Function ReportDef()

	oReport := TReport():New("GLEPY208","Relatório Conferência Movimentação Bancária",cPerg,{|oReport| PrintReport(oReport)},;
		"Conferência Movimentação Bancária")

	oReport:SetLandScape(.T.)
	oReport:lParamPage := .F.
	oReport:oPage:SetPaperSize(9)

	oSection := TRSection():New(oReport,"CONFERENCIA MOVIMENTACAO BANCARIA")

	TrCell():New(oSection, "E5_CLIFOR", "SE5", "FORNECEDOR")
	TrCell():New(oSection, "PAGAR"    ,      , "CONT.PAGAR")
	TrCell():New(oSection, "RECEBER"  ,      , "CONT.RECEBER")
	TrCell():New(oSection, "DIF"      ,      , "DIFERENCA")

	oSection:SetTotalInLine(.F.)
	TRFunction():New(oSection:Cell("PAGAR")  , , "SUM")
	TRFunction():New(oSection:Cell("RECEBER"), , "SUM")
	TRFunction():New(oSection:Cell("DIF")    , , "SUM")

Return

Static Function PrintReport()

	Local cAlias := GetNextAlias()

	oSection:BeginQuery()
	BeginSql Alias cAlias

            SELECT  E5_CLIFOR
                    , PAGAR AS PAGAR
                    , RECEBER AS RECEBER
                    , ( PAGAR - RECEBER ) AS DIF
            FROM
                (
                SELECT  SE5.E5_CLIFOR
                        ,SUM(CASE WHEN SE5.E5_RECPAG = 'P' THEN SE5.E5_VALOR END) AS PAGAR
                        ,SUM(CASE WHEN SE5.E5_RECPAG = 'R' THEN SE5.E5_VALOR END) AS RECEBER        
                    FROM %TABLE:SE5% SE5
                    WHERE SE5.E5_DATA = %EXP:MV_PAR01%   
                      AND SE5.%notdel% 
                      AND SE5.E5_MOTBX = 'GLT'
                      AND SE5.E5_TIPODOC <> 'JR'
                GROUP BY SE5.E5_CLIFOR
                ) 
            ORDER BY 4

	ENDSQL
	oSection:EndQuery()
	oSection:Print()
	(cAlias)->(DbCloseArea())

Return



