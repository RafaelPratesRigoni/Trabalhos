#include 'Protheus.ch'
#include 'Topconn.ch'


/*/{Protheus.doc} User Function GLESPY200()
    (RELAT�RIO N�O CONFORMIDADE REPEC��O LEITE X QUALIDADE.
    Tem como finalidade verifica  dentro de um per�odo se existe produtores que enviaram leite e que 
    faltam lan�ar o resultado da analise de qualidade enviada pela Clinica do Leite.  
    @type  Function
    @author Rafael Rigoni
    @since 19/04/2021
        /*/

User Function GLESPY200()

	Private oReport   := Nil
	Private oSection1 := Nil
	Private oSection2 := Nil
	Private cPerg     := "PRGLT080"


	Pergunte(cPerg,.T.)

	ReportDef()
	oReport:PrintDialog()

Return


Static Function ReportDef()

	oReport := TReport():New("GLESP","RELAT�RIO N�O CONFORMIDADE REPEC��O LEITE X QUALIDADE",cPerg,{|oReport| PrintReport(oReport)},;
		"N�O CONFORMIDADE REPEC��O LEITE X QUALIDADE")

	oReport:lParamPage := .F.
	oReport:oPage:SetPaperSize(9)
	oReport:SetLandscape(.T.)

	oSection1 := TRSection():New(oReport,"RECEP��O LEITE")

	//TrCell():New(oSection1, "ZLD_DTCOLE", "ZLD", "DATA COLETA")
	TrCell():New(oSection1, "ZLD_SETOR" , "ZLD", " SETOR")
	TrCell():New(oSection1, "ZLD_RETIRO", "ZLD", "PROTUDOR")
	TrCell():New(oSection1, "ZLD_RETILJ", "ZLD", "LOJA")
	TrCell():New(oSection1, "ZLD_DCRRET", "ZLD", "FORNCEDOR/COOPERADO")

	oBreak := TRBreak():New(oSection1,oSection1:Cell("ZLD_RETIRO"),"Sub Total REPEC��O LEITE")
	TRFunction():New(oSection1:Cell("ZLD_RETIRO"),,"COUNT")

Return

Static Function PrintReport(oReport)

	Local cAliasZLD := GetNextAlias()
    /*
    Query que tem a fun��o de verificar se existe alguma entrada de Leite via Recep��o, que n�o tem An�lise de qualidade lan�ada.
    */
	oSection1:BeginQuery()
	BeginSql Alias cAliasZLD
        SELECT ZLD_SETOR, ZLD_RETIRO, ZLD_RETILJ, ZLD_DCRRET 
            FROM %table:ZLD% ZLD 
            WHERE ZLD_DTCOLE BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04%
            AND ZLD_LINROT BETWEEN %exp:MV_PAR01%   AND %exp:MV_PAR02%
			AND ZLD.%notdel% 
            AND NOT EXISTS (SELECT ZLB_RETIRO 
                            FROM %table:ZLB% ZLB
                            WHERE ZLD.ZLD_RETIRO = ZLB.ZLB_RETIRO
                            AND ZLD.ZLD_RETILJ = ZLB.ZLB_RETILJ
							AND ZLB_DATA  BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04%
                             )
			GROUP BY ZLD.ZLD_SETOR, ZLD.ZLD_RETIRO, ZLD.ZLD_RETILJ, ZLD.ZLD_DCRRET 
            ORDER BY 1
	ENDSQL

	oSection1:EndQuery()
	oSection1:Print()
	(cAliasZLD)->(DbCloseArea())


Return
