#include 'Protheus.ch'
#include 'Topconn.ch'

/*/{Protheus.doc} User Function GLEPY2004()
    (RELATÓRIO NÃO CONFORMIDADE ANÁLISE CCS,CBT,EST".
    Tem como finalidade verifica  dentro de um período se existe produtores 
    que faltam algum tipo de Análise de qualdidade,  para a formação de preço.  
    @type  Function
    @author Rafael Rigoni
    @since 19/04/2021
        /*/

User Function GLEPY2004()

	Private oReport   := Nil
	Private oSection2 := Nil
	Private cPerg     := "PRGLT080"

    Pergunte(cPerg,.T.)

    ReportDef()

    oReport:PrintDialog()

Return

Static Function ReportDef()

	oReport :=TReport():New("GLESP","ANÁLISE CCS,CBT,EST",cPerg,{|oReport|PrintReport(oReport)},"Relatório Analise Qualidade")

	oReport:SetLandscape(.T.)

	oSection2 :=TRSection():New(oReport,"ANÁLISE CCS,CBT,EST")

	TrCell():New(oSection2,"ZLB_RETIRO","ZLB")
	TrCell():New(oSection2,"ZLB_RETILJ","ZLB")
	TrCell():New(oSection2,"ZLB_DCRRET","ZLB")
	TrCell():New(oSection2,"CBT","SUM(CBT)")
	TrCell():New(oSection2,"CCS","SUM(CCS)")
	TrCell():New(oSection2,"EST","SUM(EST)")

    oBreak := TRBreak():New(oSection2,oSection2:Cell("ZLB_RETIRO"),"TOTAL DE PRODUDORES")

	TRFunction():New(oSection2:Cell("ZLB_RETIRO"),,"COUNT")

Return

Static Function PrintReport()

	Local cAliasZLB := GetNextAlias()

	oSection2:BeginQuery()
	BeginSql Alias cAliasZLB
        SELECT * FROM 
                    (
                    SELECT ZLB_RETIRO, ZLB_RETILJ, ZLB_DCRRET, SUM(CBT) AS CBT, SUM(CCS) AS CCS, SUM(EST) AS EST
                        FROM
                        (
                        SELECT ZLB_RETIRO, ZLB_RETILJ,zlb_dcrret, 1 AS CBT, 0 AS CCS, 0 AS EST 
                            FROM %table:ZLB% ZLB
                            WHERE ZLB_DATA BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04%
                            and ZLB.%notdel% 
                            AND ZLB_DCRTPF = 'CBT'  

                        UNION   ALL           
                        SELECT ZLB_RETIRO, ZLB_RETILJ,zlb_dcrret, 0 AS CBT, 1 AS CCS, 0 AS EST 
                            FROM %table:ZLB% ZLB
                            WHERE ZLB_DATA BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04%
                            and ZLB.%notdel% 
                            AND ZLB_DCRTPF = 'CCS'

                        UNION ALL
                        SELECT ZLB_RETIRO, ZLB_RETILJ,zlb_dcrret, 0 AS CBT, 0 AS CCS, 1 AS EST 
                            FROM %table:ZLB% ZLB 
                            WHERE ZLB_DATA BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04%
                            and ZLB.%notdel%
                            AND ZLB_DCRTPF = 'EST'
                        )
                        GROUP BY ZLB_RETIRO, ZLB_RETILJ, ZLB_DCRRET
                    ) WHERE CBT ='0'  OR CCS ='0' OR EST ='0'
        ENDSQL

	oSection2:EndQuery()
	oSection2:Print()
	(cAliasZLB)->(DbCloseArea())

Return
