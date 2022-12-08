#include 'Protheus.ch'
#include 'Topconn.ch'
#include 'Totvs.ch'

User Function GLEPY211()

	Private oReport  := Nil
	Private oSection := Nil
	Private oSection2:= Nil
	Private cPerg    := "PRGLT301"

	Pergunte(cPerg,.T.)
	ReportDef()
	oReport:PrintDialog()

Return

Static Function ReportDef()

	oReport := TReport():New("GLEPY211", "Relatório Produtores Por Rota", cPerg, {|oReport| PrintReport(oReport)}, "Relatório Produtores Por Rota")
	oReport:SetLandscape(.T.)

	oReport:oPage:SetPaperSize(9)

	oReport:lParamPage := .F.

	// SESSÃO 01
	oSection := TRSection():New(oReport,"SETOR")
	TrCell():New(oSection, "ZL2_COD"   , "ZL2", "SETOR"    , , , , , , , , , , , , , .T.)
    TrCell():New(oSection, "ZL2_DESCRI", "ZL2", "DESCRIÇÃO", , , , , , , , , , , , , .T.)
	TrCell():New(oSection, "ZLW_COD"   , "ZLW", "CODIGO"   , , , , , , , , , , , , , .T.)
	TrCell():New(oSection, "ZLW_DESCRI", "ZLW", "ROTA"     , , , , , , , , , , , , , .T.)

	// SESSÃO 02
	oSection2:= TRSection():New(oSection,"ROTA")
	TrCell():New(oSection2, "ZLZ_CODPRO", "ZLZ")
	TrCell():New(oSection2, "ZLZ_LJPROD", "ZLZ")
	TrCell():New(oSection2, "ZLZ_NOMEPR", "ZLZ")

	// TOTALIZADORES
	TRFunction():New(oSection2:Cell("ZLZ_CODPRO"), Nil, "COUNT")
	
	oSection2:SetTotalInLine(.F.)

Return

Static Function PrintReport()

	Local cAlias := GetNextAlias()

	oSection:BeginQuery()
	BeginSql Alias cAlias

            SELECT 
                 ZLW_COD ,ZLW_DESCRI ,ZL2_COD ,ZL2_DESCRI ,ZLZ_CODPRO ,ZLZ_LJPROD ,ZLZ_NOMEPR
            FROM %TABLE:ZLZ% ZLZ
            INNER JOIN %TABLE:ZLW% ZLW ON ZLW.ZLW_COD = ZLZ.ZLZ_ROTA 
            INNER JOIN %TABLE:ZL2% ZL2 ON ZL2.ZL2_COD = ZLW.ZLW_SETOR
            WHERE ZLW.ZLW_COD BETWEEN %exp:MV_PAR01% AND %exp:MV_PAR02%
                AND ZLZ.%NOTDEL%
                AND ZLW.%NOTDEL%
            ORDER BY 1,2 
            ENDSQL

	oSection:EndQuery()
	oSection2:SetParentQuery()
	oSection2:SetParentFilter({|cSetor|(cAlias)->ZLW_COD = cSetor},{||(cAlias)->ZLW_COD})
	oSection:Print()

	(cAlias)->(DbCloseArea())

Return
