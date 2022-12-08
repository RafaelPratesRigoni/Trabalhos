#include 'Protheus.ch'
#include 'Totvs.ch'


/*/{Protheus.doc} GLEPY205
Relatório - Produção Por Tanque. 
Tem como Objetivo atender uma solicitação da Clinica do Leite onde 
deve conter o total de produção de leite no mês, essa produção deve ser 
atribuida apenas ao Dono do Tanque. 
@type function
@version  
@author Rafael.Rigoni
@since 14/07/2021
@return variant, return_description
/*/
User Function GLEPY205()

	Private oReport   := Nil
	Private oSection1 := Nil
	//Private cPerg     := "PRGLT"

	Pergunte(cPerg,.T.)
	ReportDef()
	oRepor:PrintDialog()

Return

Static Function ReportDef()

	oReport           := TReport():Nel("GLEPY205","PRODUÇÃO POR TANQUE",/* cPerg*/,{|oReport| PrintReport(oReport)},;
		                                "PRODUÇÃO POR TANQUE")

	oReport              :lParamPage := .F.
	oReport:oPage        :SetPaperSize(9)
    
	oReport              :SetLandscape(.T.)

	oSection1:TrSection():New(oReport  , "PRODUÇÃO MENSAL POR TANQUE")

    TrCell()             :New(oSection1, "ZLD_SETOR"  , "ZLD"  , "SETOR")
    TrCell()             :New(oSection1, "ZLD_RETIRO" , "ZLD"  , "PROTUDOR")
	TrCell()             :New(oSection1, "ZLD_RETILJ" , "ZLD"  , "LOJA")
    TrCell()             :New(oSection1, "ZLD_DCRRET" , "ZLD"  , "FORNCEDOR/COOPERADO")
    TrCell()             :New(oSection1, "ZLT_COD"    , "ZLT"  , "TANQUE")
    TrCell()             :New(oSection1, "ZLT_TITULA" , "ZLT"  , "TITULAR")
    TrCell()             :New(oSection1, "TOTAL_LEITE", "TOTAL")
	
	oBreak := TRBreak():New(oSection,oSection1:Cell(""))

Return

Static Function PrintReport()

	Local cAlias := GetNextAlias()

	oSection1:BeginQuery()

	BeginSql Alias cAlias

        SELECT  DISTINCT
                ZLD_SETOR ,ZLD_RETIRO ,ZLD_RETILJ ,ZLD_DCRRET, ZLT_COD AS TANQUE
                ,(
                    SELECT SUM(ZLD_QTDBOM)
                    FROM PROTHEUS.ZLD010 x 
                        INNER JOIN PROTHEUS.ZLT010 Y ON y.ZLT_SA2COD = x.zld_retiro AND y.ZLT_SA2LJ = x.zld_retilj AND y.D_E_L_E_T_ =' ' 
                    WHERE 
                         x.D_E_L_E_T_ =' '
                        AND Y.ZLT_COD = ZLT.ZLT_COD 
                        AND X.ZLD_DTCOLE BETWEEN '20210401' AND '20210430'
                ) TOTAL_LEITE
                ,ZLT_TITULA 
            FROM PROTHEUS.ZLD010 ZLD 
                INNER JOIN PROTHEUS.ZLT010 ZLT ON ZLT.ZLT_SA2COD = zld.zld_retiro AND ZLT.ZLT_SA2LJ = zld.zld_retilj AND ZLT.D_E_L_E_T_ =' ' 
            WHERE 
                    ZLD_DTCOLE BETWEEN '20210401' AND '20210430'
                    AND ZLD.D_E_L_E_T_ =' ' 
                    AND ZLT_TITULA = 'S'
            ORDER BY zlt.ZLT_COD

        ENDSQL

	oSection1:EndQuery()
	oSection1:Print()
	(cAlias)->(DbCloseArea())

Return
