#include 'Protheus.ch'
#include 'TOTVS.ch'

User Function GLEPY206()

	Private oReport  := Nil
	Private oSection := Nil
	Private cPerg    := "PRGLT206"

	Pergunte(cPerg,.T.)
	ReportDef()
	oReport:PrintDialog()

Return

Static Function ReportDef()

	oReport :=TReport():New("GLEPY206","Relatório Crédidos Fixos",cPerg,{|oReport| PrintReport(oReport)},;
		"Relatório Credito Fixo")

    oReport:SetLandScape(.T.)
	oReport:lParamPage := .F.
	oReport:oPage:SetPaperSize(9)

	oSection:=TRSection():New(oReport,"CREDITO FIXO")

	TrCell():New(oSection,"E2_FORNECE","SE2","FORNECEDOR"  ,,,,,,,,,,,,,.F.)
	TrCell():New(oSection,"E2_LOJA"   ,"SE2","LOJA"        ,,,,,,,,,,,,,.F.)
	TrCell():New(oSection,"A2_NOME"   ,"SA2","RAZAO SOCIAL",,,,,,,,,,,,,.F.)
	TrCell():New(oSection,"A2_L_CREFX","SA2","CREDITO FIXO",,,,,,,,,,,,,.F.)

  //  oBreak := TRBreak():New(oSection,oSection:Cell("E2_FORNECE"),"TOTAL DE FORNECEDORES")
    TRFunction():New(oSection:Cell("A2_L_CREFX"),,"SUM")
Return

Static Function PrintReport()
	Local cAlias := GetNextAlias()

	oSection:BeginQuery()

	BeginSql Alias cAlias
        SELECT E2_FORNECE, E2_LOJA, A2_NOME, A2_L_CREFX 
        FROM (SELECT DISTINCT E2_FORNECE, E2_LOJA 
              FROM %table:SE2% SE2 WHERE SE2.%notdel%
                   AND E2_FILIAL = '47' 
                   AND E2_EMISSAO BETWEEN %EXP:MV_PAR01%  AND %EXP:MV_PAR02%
                   AND E2_PREFIXO IN ('100','890') ) 
              JOIN %table:SA2% SA2 ON A2_COD = E2_FORNECE AND A2_LOJA = E2_LOJA AND SA2.%notdel%  AND A2_L_CREFX > 0 
              ORDER BY 1,2
        ENDSQL

	oSection:EndQuery()
	oSection:Print()
	(cAlias)->(DbCloseArea())

Return
