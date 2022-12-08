#Include 'Protheus.ch'
#Include 'Topconn.ch'

User Function GLEPY213()

	Private oReport   := Nil
	Private oSection1 := Nil
	Private cPerg     := "PRGLT200"

	Pergunte(cPerg, .T.)
	ReportDef()
	oReport:PrintDialog()

Return

Static Function ReportDef()

	oReport :=TReport():New("GLEPY2005","RELATORIO ATUALIZAÇAO SALDO COMPROCARD",cPerg,{|oReport| PrintReport(oReport)},;
							"RELATORIO ATUALIZAÇAO SALDO COMPROCARD")
	oReport:lParamPage := .F.
	oReport:oPage:SetPaperSize(9)
	oReport:SetLandScape(.T.)


	oSection1:= TRSection():New(oReport,"COMPROCAD")

	TrCell():New(oSection1,"F1_FORNECE" ,"SA1")
	TrCell():New(oSection1,"F1_LOJA"    ,"SA1")
	TrCell():New(oSection1,"A2_NOME"    ,"SA2")
	TrCell():New(oSection1,"A2_MUN"     ,"SA2")
	TrCell():New(oSection1,"A2_CGC"     ,"SA2")
	TrCell():New(oSection1,"A1_TEL"     ,"SA1")
	TrCell():New(oSection1,"A1_TELEX"   ,"SA1")	
	TrCell():New(oSection1,"F1_VALBRUT" ,"SF1")

	oBreak := TRBreak():New(oSection1,oSection1:Cell("F1_FORNECE"),"TOTAL DE FORNECEDORES")


Return

Static Function PrintReport(oReport)

	Local cAlias    :=GetNextAlias()

	oSection1:BeginQuery()

	BeginSql Alias cAlias

        SELECT  F1_FORNECE, F1_LOJA, A2_NOME, A2_MUN, A2_CGC, A1_TEL, A1_TELEX, F1_VALBRUT  
        FROM  %table:SF1% SF1
                INNER JOIN %table:SA2%  SA2 ON SA2.A2_COD = SF1.F1_FORNECE AND SA2.A2_LOJA = SF1.F1_LOJA AND SA2.%notdel%
                INNER JOIN %table:SA1%  SA1 ON SA1.A1_COD = SF1.F1_FORNECE AND SA1.A1_LOJA = SF1.F1_LOJA AND SA1.%notdel%
                WHERE SF1.F1_FILIAL 	 = '47'
                      AND SF1.F1_SERIE 	 = '100'
                      AND SF1.F1_EMISSAO =  %EXP:MV_PAR01%
                      AND SF1.%notdel%	  
                ORDER BY SA2.A2_MUN, SF1.F1_FORNECE, SF1.F1_LOJA, SA2.A2_NOME

        ENDSQL
  
	oSection1:EndQuery()
	oSection1:Print()
	(cAlias)->(DbCloseArea())


Return
