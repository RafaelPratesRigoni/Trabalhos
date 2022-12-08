#include 'Protheus.ch'
#include 'Topconn.ch'
#include 'Totvs.ch'

User Function GLEPY210()

	Private oReport  := Nil
	Private oSection := Nil
	Private oSection2:= Nil
	Private cPerg    := "PRGLT206"

	Pergunte(cPerg,.T.)
	ReportDef()
	oReport:PrintDialog()

Return

Static Function ReportDef()

	oReport := TReport():New("GLEPY210","Relatório Quadro Recepção de Leite  Veiculo",cPerg,{|oReport| PrintReport(oReport)},;
		"Relatório Quadro Recepção de Leite  Veiculo")
	
	oReport:oPage:SetPaperSize(9)
    oReport:SetLandScape(.F.)
    oReport:lParamPage := .F.
    

	oSection := TRSection():New(oReport,"DATA")
	TrCell():New(oSection,"ZLC_DTCOLE","ZLC","DATA COLETA")

    
    oSection2:= TRSection():New(oSection,"Veiculo")
	TrCell():New(oSection2, "ZLC_VEICUL"         , "ZL4", "COD.VEICULO")
    TrCell():New(oSection2, "ZL4_PLACA"          , "ZL4", "PLACA VEICULO")
    TrCell():New(oSection2, "QDT_VEICULO"         ,     , "QDT_VEICULO","@E 999,999,999,999,999")
    TrCell():New(oSection2, "QDT_DESCARREGAMENTO",      , "QDT_DESCARREGAMENTO","@E 999,999,999,999,999")
    TrCell():New(oSection2, "DIFERENCA",,,"@E 999,999,999,999,999")

    TRFunction():New(oSection2:Cell("QDT_VEICULO")        , Nil, "SUM", Nil, "QDT_VEICULO"        , "@E 999,999,999.99", NIL, .T., .F., .F.)
    TRFunction():New(oSection2:Cell("QDT_DESCARREGAMENTO"), NIl, "SUM", NIL, "QDT_DESCARREGAMENTO", "@E 999,999,999.99", NIL, .T., .F., .F.)
    TRFunction():New(oSection2:Cell("DIFERENCA")          , Nil, "SUM", NIL, "DIFERENCA"          , "@E 999,999,999.99", NIL, .T., .F., .F.)

    oSection2:SetTotalInLine(.F.)
Return

Static Function PrintReport()

	Local cAlias := GetNextAlias()

	oSection:BeginQuery()
	BeginSql Alias cAlias

            SELECT   ZLC_DTCOLE ,ZLC_VEICUL ,ZL4_PLACA 
                    ,SUM(ZLC_QTDVEI ) AS QDT_VEICULO
                    ,SUM(ZLC_QTDPRD) AS QDT_DESCARREGAMENTO
                    ,SUM(ZLC_QTDDIF) AS DIFERENCA
                FROM %TABLE:ZLC%  ZLC 
                INNER JOIN %TABLE:ZL4% ZL4 ON ZL4_COD = ZLC_VEICUL 
                WHERE ZLC.%notdel%
                    AND ZLC_DTCOLE BETWEEN %EXP:MV_PAR01% AND %EXP:MV_PAR02%
            GROUP BY ZLC_DTCOLE, ZLC_VEICUL, ZL4_PLACA
            ORDER BY ZLC_DTCOLE, ZL4_PLACA

	ENDSQL

	oSection:EndQuery()
    oSection2:SetParentQuery()
	oSection2:SetParentFilter({|dData|(cAlias)->ZLC_DTCOLE = dData},{||(cAlias)->ZLC_DTCOLE})
	oSection:Print()

	(cAlias)->(DbCloseArea())

Return
