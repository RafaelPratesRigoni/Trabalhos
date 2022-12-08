#INCLUDE "Totvs.ch"
#INCLUDE "Protheus.ch"
#INCLUDE "Topconn.ch"

User Function FISRY017()

	Private oReport := NIL
	Private oSection := NIL
	Private oSection1 := Nil
	Private oSection2 := Nil
	Private oSection3 := Nil

	Private cPerg     := "FISRY017"

	Pergunte(cPerg, .T.)
	ReportDef()
	oReport:PrintDialog()

Return

Static Function ReportDef()

	IF MV_PAR04 = 1

		oReport := TReport():New("FISRY017","MAPA PRODUÇAO OVO",cPerg,{|oReport| PrintReport(oReport)},;
			"MAPA DE PRODUÇÃO")

		oReport:SetLandScape(.T.)
		oReport:lParamPage:= .F.
		oReport:oPage:SetPaperSize(9)
		oReport:SetPortrait()

                // Sessão NÚMERO DE PRODUTORES ATIVOS
		oSection := TRSection():New(oReport,"PRODUTORES ATIVOS")
		TrCell():New(oSection,"QTD_FORNECE",,"PRODUTORES ATIVOS"  ,"@E 999,999,999",12)
		oSection:SetTotalInLine(.F.)

                // Sessão NÚMERO DE MUNICÍPIOS ABRANGIDOS
		oSection1 := TRSection():New(oReport,"MUNICIPIO ABRANGIDOS")
		TrCell():New(oSection1,"QTD_MUNICIPIO",,"NÚMERO DE MUNICÍPIOS ABRANGIDOS","@E 999,999,999",12)
		oSection1:SetTotalInLine(.F.)

                //Sessão DESCRIÇÃO DA PRODUÇÃO
		oSection2 := TRSection():New(oReport,"PRODUÇÃO")
		TrCell():New(oSection2,"UNIDADE"        ,,"UNIDADE")
		TrCell():New(oSection2,"QUANTIDADE"     ,,"PRODUCAO","@E 999,999,999",12)
		TrCell():New(oSection2,"PRODUTOS"       ,,"PRODUTO"   ,,20)
		TrCell():New(oSection2,"COD_PRODUTO"    ,,"CODIGO PRODUTO")
		oSection2:SetTotalInLine(.F.)

		// TOTALIZADORES
		TRFunction():New(oSection2:Cell("QUANTIDADE")   , Nil,  "SUM"     , Nil,  "QUANTIDADE"       , "@E 999,999,999"     , NIL, .T., .F., .F.)
		//TRFunction():New(oSection2:Cell("PRODUTOS")     , Nil,  "COUNT"   , Nil,  "TOTAL PRODUTOS"   , "@E 999,999,999   "  , NIL, .T., .F., .F.)


                // Sessao PRODUÇAO POR MUNICIPIO
		oSection3 := TRSection():New(oReport,"MUNICIPIOS")
		TrCell():New(oSection3,"MUNICIPIO"      ,,"MUNICIPIO",,20)
		TrCell():New(oSection3,"COD_MUNICIPIO"  ,,"IBGE")
		TrCell():New(oSection3,"PRODUCAO"       ,,"PRODUÇÃO")
		TrCell():New(oSection3,"VALOR"          ,,"VALOR"   ,"@E 999,999,999,999.99",12)
		oSection3:SetTotalInLine(.F.)
		//TOTALIZADORES
		TRFunction():New(oSection3:Cell("PRODUCAO"), Nil,  "SUM"     , Nil,  "PRODUCAO"       , "@E 999,999,999"        , NIL, .T., .F., .F.)
		TRFunction():New(oSection3:Cell("VALOR")   , Nil,  "SUM"     , Nil,  "VALOR TOTAL"    , "@E 999,999,999.99"     , NIL, .T., .F., .F.)

	ELSE
                oReport := TReport():New("FISRY017","MAPA PRODUÇAO OVO",cPerg,{|oReport| PrintReport(oReport)},;
			"MAPA DE PRODUÇÃO")

		oReport:SetLandScape(.F.)
		oReport:lParamPage:= .F.
		oReport:oPage:SetPaperSize(9)
		oReport:SetPortrait()

                oSection:=TRSection():New(oReport,"ANALITICO")
                TrCell():New(oSection,"MUNICIPIO"               ,,"MUNICIPIO",,20)
                TrCell():New(oSection,"COD_MUNICIPIO")
                TrCell():New(oSection,"CODIGO")
                TrCell():New(oSection,"LOJA")
                TrCell():New(oSection,"DESCRICAO"               ,,"DESCRIÇÃO",,20)
                TrCell():New(oSection,"NOTA"                    ,,"NF-e"     ,,9)
                TrCell():New(oSection,"SERIE")
                Trcell():New(oSection,"EMISSAO")
                TrCell():New(oSection,"PRODUCAO"                ,,"PRODUÇÃO"    ,"@E 999,999,999")
                Trcell():New(oSection,"VALOR"                   ,,"    VALOR"   ,"@E 999,999,999,999.99",12)
                TrCell():New(oSection,"VLR_ICM")
                TrCell():New(oSection,"ALIQ_ICM")
                TrCell():New(oSection,"BASE_ICM")
                TrCell():New(oSection,"TES")
                TrCell():New(oSection,"PEDIDO")


	ENDIF
Return

Static Function PrintReport()

	Local cAlias    := GetNextAlias()
	Local cAlias1   := GetNextAlias()
	Local cAlias2   := GetNextAlias()
	Local cAlias3   := GetNextAlias()
        Local cAlias4   := GetNextAlias()

IF MV_PAR04 = 1
	oSection:BeginQuery()
	BeginSql Alias cAlias
                SELECT COUNT(FORNECEDOR) AS QTD_FORNECE
                FROM   (SELECT  SD1.D1_FORNECE    AS FORNECEDOR,
                                SD1.D1_LOJA       AS LOJA,
                                SA2.A2_MUN        AS MUNICIPIO,
                                SA2.A2_COD_MUN    AS COD_MUNICIPIO,
                                SUM(SD1.D1_QUANT) AS PRODUCAO,
                                SUM(SD1.D1_TOTAL) AS VALOR
                        FROM   %TABLE:SD1% SD1
                        INNER JOIN %TABLE:SA2% SA2
                                        ON ( SA2.A2_COD = SD1.D1_FORNECE
                                                AND SA2.A2_LOJA = SD1.D1_LOJA
                                                AND SA2.%NOTDEL% )
                        WHERE   SD1.D1_FILIAL    = %EXP:MV_PAR01%
                                AND SD1.D1_SERIE = '14'
                                AND SD1.D1_EMISSAO BETWEEN %EXP:MV_PAR02% AND %EXP:MV_PAR03%
                                AND SD1.D1_COD IN ( '035809', '008163' )
                                AND SD1.%NOTDEL%
                        GROUP  BY SD1.D1_FORNECE,
                                SD1.D1_LOJA,
                                SA2.A2_MUN,
                                SA2.A2_COD_MUN
                        ORDER  BY SA2.A2_MUN,
                                SD1.D1_FORNECE)
	EndSql

	oSection:EndQuery()
	oSection:Print()
	(cAlias)->(DbCloseArea())

	oSection1:BeginQuery()
	BeginSql Alias cAlias1

                SELECT COUNT(MUNICIPIO) AS QTD_MUNICIPIO
                FROM   (SELECT  SA2.A2_MUN        AS MUNICIPIO,
                                SA2.A2_COD_MUN    AS COD_MUNICIPIO,
                                SUM(SD1.D1_QUANT) AS PRODUCAO,
                                SUM(SD1.D1_TOTAL) AS VALOR
                FROM   %TABLE:SD1% SD1
                        INNER JOIN %TABLE:SA2% SA2
                                ON ( SA2.A2_COD = SD1.D1_FORNECE
                                        AND SA2.A2_LOJA = SD1.D1_LOJA
                                        AND SA2.%NOTDEL% )
                WHERE   SD1.D1_FILIAL    = %EXP:MV_PAR01%
                        AND SD1.D1_SERIE = '14'
                        AND SD1.D1_EMISSAO BETWEEN %EXP:MV_PAR02% AND %EXP:MV_PAR03%
                        AND SD1.D1_COD IN ( '035809', '008163' )
                        AND SD1.%NOTDEL%
                GROUP  BY SA2.A2_MUN,
                        SA2.A2_COD_MUN
                ORDER  BY SA2.A2_MUN)
	EndSql

	oSection1:EndQuery()
	oSection1:Print()
	(cAlias1)->(DbCloseArea())

	oSection2:BeginQuery()
	BeginSql Alias cAlias2
                SELECT  SD1.D1_UM         AS UNIDADE,
                        SUM(SD1.D1_QUANT) AS QUANTIDADE,
                        SD1.D1_YDESC      AS PRODUTOS,
                        SD1.D1_COD        AS COD_PRODUTO
                FROM   %TABLE:SD1% SD1
                WHERE   SD1.D1_FILIAL = %EXP:MV_PAR01%
                        AND SD1.D1_SERIE = '14'
                        AND SD1.D1_EMISSAO BETWEEN %EXP:MV_PAR02% AND %EXP:MV_PAR03%
                        AND SD1.D1_COD IN ( '035809', '008163' )
                        AND SD1.%NOTDEL%
                GROUP  BY SD1.D1_UM,
                        SD1.D1_COD,
                        SD1.D1_YDESC
                ORDER  BY 1
	EndSql

	oSection2:EndQuery()
	oSection2:Print()
	(cAlias2)->(DbCloseArea())

	oSection3:BeginQuery()
	BeginSql Alias cAlias3

                SELECT  SA2.A2_MUN        AS MUNICIPIO,
                        SA2.A2_COD_MUN    AS COD_MUNICIPIO,
                        SUM(SD1.D1_QUANT) AS PRODUCAO,
                        SUM(SD1.D1_TOTAL) AS VALOR
                FROM    %TABLE:SD1% SD1
                        JOIN %TABLE:SA2% SA2
                                ON ( SA2.A2_COD = SD1.D1_FORNECE
                                AND SA2.A2_LOJA = SD1.D1_LOJA
                                AND SA2.%NOTDEL% )
                WHERE   SD1.D1_FILIAL    = %EXP:MV_PAR01%
                        AND SD1.D1_SERIE = '14'
                        AND SD1.D1_EMISSAO BETWEEN %EXP:MV_PAR02% AND %EXP:MV_PAR03%'
                        AND SD1.D1_COD IN ( '035809', '008163' )
                        AND SD1.%NOTDEL%
                GROUP  BY SA2.A2_MUN,
                        SA2.A2_COD_MUN
                ORDER  BY SA2.A2_MUN

        EndSql

	oSection3:EndQuery()
	oSection3:Print()
	(cAlias3)->(DbCloseArea())
ELSE 
        oSection:BeginQuery()
        BeginSql Alias cAlias4

                SELECT  SA2.A2_MUN        AS MUNICIPIO,
                        SA2.A2_COD_MUN    AS COD_MUNICIPIO,
                        SD1.D1_FORNECE    AS CODIGO,
                        SD1.D1_LOJA       AS LOJA,
                        SA2.A2_NOME       AS DESCRICAO,
                        SD1.D1_DOC        AS NOTA,
                        SD1.D1_SERIE      AS SERIE,
                        SD1.D1_EMISSAO    AS EMISSAO,
                        SUM(SD1.D1_QUANT) AS PRODUCAO,
                        SUM(SD1.D1_TOTAL) AS VALOR,
                        SD1.D1_VALICM     AS VLR_ICM,
                        SD1.D1_PICM       AS ALIQ_ICM,
                        SD1.D1_BASEICM    AS BASE_ICM,
                        SD1.D1_TES        AS TES,
                        SD1.D1_PEDIDO     AS PEDIDO
                FROM    %TABLE:SD1% SD1
                        JOIN %TABLE:SA2% SA2
                                ON ( SA2.A2_COD = SD1.D1_FORNECE
                                AND SA2.A2_LOJA = SD1.D1_LOJA
                                AND SA2.D_E_L_E_T_ = ' ' )
                WHERE   SD1.D1_FILIAL    = %EXP:MV_PAR01%
                        AND SD1.D1_SERIE = '14'
                        AND SD1.D1_EMISSAO BETWEEN %EXP:MV_PAR02% AND %EXP:MV_PAR03%
                        AND SD1.D1_COD IN ( '035809', '008163' )
                        AND SD1.%NOTDEL%
                GROUP BY SA2.A2_MUN, SA2.A2_COD_MUN, SD1.D1_FORNECE, SD1.D1_LOJA,SA2.A2_NOME, SD1.D1_DOC, 
                         SD1.D1_SERIE,SD1.D1_EMISSAO, SD1.D1_VALICM, SD1.D1_PICM, SD1.D1_BASEICM, SD1.D1_TES, 
                         SD1.D1_PEDIDO 
                ORDER  BY SA2.A2_MUN,SD1.D1_DOC, SD1.D1_SERIE
        EndSql
        oSection:EndQuery()
        oSection:Print()
        (cAlias4)->(DbCloseArea())
ENDIF

Return







