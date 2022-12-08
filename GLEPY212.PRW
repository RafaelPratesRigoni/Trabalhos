//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} GLEPY212
"Relatorio Clinica do Leite
@type function
@version  
@author Rafael.Rigoni
@since 27/08/2021
@return variant, return_description
/*/
User Function GLEPY212()
	Private oReport  := NIl
	Private oSectDad := NIl
	Private cPerg    := "PRGLT206"

	//Definições da pergunta

	Pergunte(cPerg,.T.)
	ReportDef()
	oReport:PrintDialog()

Return


Static Function ReportDef()

	//Criação do componente d impressão
	oReport := TReport():New(	"GLEPY212",;		//Nome do Relatório
	"Relatorio Clinica do Leite",;		//Título
	cPerg,;		//Pergunte ... Se eu defino a pergunta aqui, será impresso uma página com os parâmetros, conforme privilégio 101
	{|oReport| PrintReport(oReport)})

	oReport:SetTotalInLine(.F.)
	oReport:lParamPage := .F.
	oReport:oPage:SetPaperSize(9) //Folha A4
	oReport:SetPortrait()

	//Criando a seção de dados
	oSectDad := TRSection():New(oReport,"Dados")
	oSectDad:SetTotalInLine(.F.)  //Define se os totalizadores serão impressos em linha ou coluna. .F.=Coluna; .T.=Linha

	//Colunas do relatório
	TRCell():New(oSectDad, "ZLD_SETOR" , "ZLD" , "SETOR", /*Picture*/, 6, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "ZLD_RETIRO", "ZLD", "PRODUTOR", /*Picture*/, 6, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "ZLD_RETILJ", "ZLD", "LOJA", /*Picture*/, 2, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "ZLD_DCRRET", "ZLD", "NOME", /*Picture*/, 40, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "TANQUE"    ,      ,"TANQUE", /*Picture*/, 6, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "MUNICIPIO ",      , "MUNICIPIO", /*Picture*/, 20, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "TOTAL_LEITE",,"VOLUME LEITE", /*Picture*/, 15, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSectDad, "ZLT_TITULA","ZLT","TITULAR", /*Picture*/, 1, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)

Return

Static Function PrintReport()

	Local cAlias := GetNextAlias()

	oSectDad:BeginQuery()

	BeginSql Alias cAlias

		SELECT distinct
			 ZLD_SETOR 
			,ZLD_RETIRO
			,ZLD_RETILJ
			,ZLD_DCRRET
			,ZLT_COD AS TANQUE
			,SA2.A2_MUN AS MUNICIPIO
			,(
				SELECT SUM(ZLD_QTDBOM)
				FROM %TABLE:ZLD% x 
					INNER JOIN %TABLE:ZLT% Y ON y.ZLT_SA2COD = x.zld_retiro AND y.ZLT_SA2LJ = x.zld_retilj AND y.%Notdel% 
				WHERE 
						x.D_E_L_E_T_ =' '
						AND Y.ZLT_COD = ZLT.ZLT_COD
						AND X.ZLD_DTCOLE BETWEEN %exp:MV_PAR01% AND %exp:MV_PAR02%
			) TOTAL_LEITE
			,ZLT_TITULA
		FROM %TABLE:ZLD% ZLD 
			INNER JOIN %TABLE:ZLT% ZLT ON ZLT.ZLT_SA2COD = zld.zld_retiro AND ZLT.ZLT_SA2LJ = zld.zld_retilj AND ZLT.%Notdel% 
			INNER JOIN %TABLE:SA2% SA2 ON SA2.A2_COD = ZLD.ZLD_RETIRO AND SA2.A2_LOJA = ZLD.ZLD_RETILJ AND SA2.%Notdel% 
		WHERE 
				ZLD_DTCOLE BETWEEN %exp:MV_PAR01% AND %exp:MV_PAR02%
				AND ZLD.D_E_L_E_T_ =' ' 
				AND ZLT_TITULA = 'S'
		ORDER BY SA2.A2_MUN,zlt.ZLT_COD
	ENDSQL

	oSectDad:EndQuery()
	oSectDad:Print()
	(cAlias)->(DbCloseArea())

Return
