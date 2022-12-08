#Include 'Protheus.ch'
#Include 'Topconn.ch'

User Function GLEPY214()

	Private oReport   := Nil
	Private oSection1 := Nil
	Private cPerg     := "PRGLT206"

	Pergunte(cPerg, .T.)
	ReportDef()
	oReport:PrintDialog()

Return

Static Function ReportDef()

	oReport :=TReport():New("GLEPY214","RELATORIO VOLUME POR MUNICIPIO SGQ",cPerg,{|oReport| PrintReport(oReport)},;
							"RELATORIO VOLUME POR MUNICIPIO SGQ")
	oReport:SetTotalInLine(.F.)
	oReport:lParamPage := .F.
	oReport:oPage:SetPaperSize(9) //Folha A4
	oReport:SetPortrait()


	oSection1:= TRSection():New(oReport,"LEITE POR MUNICIPIO SGQ")

	TrCell():New(oSection1, "CIDADE" ,,"CIDADE",/*Picture*/,40, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TrCell():New(oSection1, "TANQUE")
	TrCell():New(oSection1, "T_LEITE", , "TOTAL LEITE")

    TRFunction():New(oSection1:Cell("T_LEITE"), Nil, "SUM")
	

Return

Static Function PrintReport(oReport)

	Local cAlias    :=GetNextAlias()

	oSection1:BeginQuery()

	BeginSql Alias cAlias

        SELECT CIDADE, COUNT(TANQUE) TANQUE, SUM(TOTAL)T_LEITE
            FROM (
                SELECT DISTINCT
                     A.A2_MUN AS CIDADE
                    ,A.A2_L_TANQ AS TANQUE
                    ,SUM(D.ZLD_QTDBOM)TOTAL
                FROM %TABLE:ZLD% D
                INNER JOIN %TABLE:SA2% A ON A.A2_COD = D.ZLD_RETIRO AND A.A2_LOJA = D.ZLD_RETILJ AND A.%Notdel%
                WHERE D.ZLD_DTCOLE BETWEEN %EXP:MV_PAR01% AND %EXP:MV_PAR02%
                AND D.%Notdel%
                GROUP BY A.A2_MUN, A.A2_L_TANQ 
                ORDER BY TANQUE)
            GROUP BY CIDADE
            ORDER By CIDADE

        ENDSQL
  
	oSection1:EndQuery()
	oSection1:Print()
	(cAlias)->(DbCloseArea())


Return
