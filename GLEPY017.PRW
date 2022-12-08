#include "Protheus.ch"
#include "Totvs.ch"
#include "Topconn.ch"

//---------------------------------------------------------------------------------
// Rotina | GLEPY017          | Autor | Rafael Prates Rigoni | Data |    21/01/2022			
//---------------------------------------------------------------------------------
// Descr. |Relatório Mapa de Produçao no atendimento a Requisiçao Fiscal																		
//---------------------------------------------------------------------------------
// Uso    | GESTÃO LEITE
//---------------------------------------------------------------------------------
// Versão | 1.3
//---------------------------------------------------------------------------------

User Function GLEPY017()

	Private oReport     := Nil
	Private oSection    := Nil 
	Private oSection1   := Nil 
    Private oSection2   := Nil 
    Private oSection3   := Nil // Sessão Mapa de Produção 
    Private oSection4   := Nil
	Private cPerg       := "GLEPY017"

	Pergunte(cPerg, .T.)
	ReportDef()
	oReport:PrintDialog()

Return

Static Function ReportDef()


IF MV_PAR04 = 1 // Sintético
	oReport:=TReport():New("GLEPY017","MAPA DE PRODUÇÃO LEITE",cPerg,{|oReport| PrintReport(oReport)},;
		                    "MAPA DE PRODUÇÃO LEITE")
	oReport:SetLandScape(.T.)      //
	oReport:lParampage := .F.      //.T. Lista os Prametros .F. Não Lista Parametros
	oReport:oPage:SetPaperSize(9)  // Orientação A4
	oReport:SetPortrait()


    // Sessão Total Linhas Ativas
	oSection:= TRSection():New(oReport,"LINHA")
	    Trcell():New(oSection,"LINHAS",,"LINHAS ATIVAS")

    // Sessão Total de Produtores Ativos
	oSection1:=TRSection():New(oReport,"PRODUTORES_ATIVOS")
        TrCell():New(oSection1,"FILIAL")
        TrCell():New(oSection1,"SETOR"      ,,"SETOR"    ,,6)
        TrCell():New(oSection1,"DESCRICAO"  ,,"DESCRIÇÃO",,20)
        TrCell():New(oSection1,"ATIVOS"     ,,"PRODUTORES ATIVOS")
    

    // Sessão Mapa  de Produção Sintético
    oSection2:= TRSection():New(oReport,"MAPA_SINTETICO")
        TrCell():New(oSection2,"MUNICIPIO"  ,,"MUNICIPIO",,20)
        TrCell():New(oSection2,"LEITE"      ,,"TOTAL LEITE"      ,"@E 999,999,999",12)
        TrCell():New(oSection2,"TOTAL"      ,,"VALOR TOTAL"      ,"@E 999,999,999,999.99",12)
    
    //TOTALIZADORES SESSÃO PRODUÇÃO SINTÉTICO
    oSection2:SetTotalInLine(.F.)
    TRFunction():New(oSection2:Cell("MUNICIPIO")    , Nil,  "COUNT" ,Nil, "MUNICIPIO"       , "@E 999,999,999"          , NIL, .T., .F., .F.)
	TRFunction():New(oSection2:Cell("LEITE")      	, Nil,  "SUM"   , Nil, "TOTAL LEITE"    , "@E 999,999,999   "       , NIL, .T., .F., .F.)
	TRFunction():New(oSection2:Cell("TOTAL")	    , Nil,  "SUM"   , Nil, "VALOR TOTAL"    , "@E 999,999,999,999.99"   , NIL, .T., .F., .F.)

ELSEIF MV_PAR04 = 2 // Municipio Litro
    oReport:=TReport():New("GLEPY017","MAPA DE PRODUÇÃO LEITE",cPerg,{|oReport| PrintReport(oReport)},;
		                    "MAPA DE PRODUÇÃO LEITE")
	oReport:SetLandScape(.T.)      //
	oReport:lParampage := .F.      //.T. Lista os Prametros .F. Não Lista Parametros
	oReport:oPage:SetPaperSize(9)  // Orientação A4
	oReport:SetPortrait()

    // Sessão Total Linhas Ativas
	oSection:= TRSection():New(oReport,"LINHA")
	    Trcell():New(oSection,"LINHAS",,"LINHAS ATIVAS")

    // Sessão Total de Produtores Ativos
	oSection1:=TRSection():New(oReport,"PRODUTORES_ATIVOS")
        TrCell():New(oSection1,"FILIAL")
        TrCell():New(oSection1,"SETOR"      ,,"SETOR"    ,,6)
        TrCell():New(oSection1,"DESCRICAO"  ,,"DESCRIÇÃO",,20)
        TrCell():New(oSection1,"ATIVOS"     ,,"PRODUTORES ATIVOS")

    //SESSÃO MAPRA_SINTÉTICO_PREÇO_MUNICIPIO
    oSection3:= TRSection():New(oReport,"MAPRA_SINTÉTICO_PREÇO_MUNICIPIO")
        TrCell():New(oSection3,"FOLHA"      ,,"FOLHA")
        TrCell():New(oSection3,"SETOR"      ,,"SETOR")
        TrCell():New(oSection3,"QTD_MUN"    ,,"QTD.MUNICIPIO")
        TrCell():New(oSection3,"MUNICIPIO"  ,,"MUNICIPIO"   ,,20)
        TrCell():New(oSection3,"QTD_LEITE"  ,,"VOLUME LEITE","@E 999,999,999"  ,12)
        TrCell():New(oSection3,"VLR_LT"     ,,"VALOR LITRO","@E 999,999,999.99",12)
        TrCell():New(oSection3,"TOTAL"      ,,"VALOR TOTAL","@E 999,999,999.99",12)
    
    //TOTALIZADORES SESSÃO  MAPA PRODUÇAO  PREÇO MUNICIPIO
    oSection3:SetTotalInLine(.F.)
    TRFunction():New(oSection3:Cell("QTD_LEITE")    , Nil,  "SUM"   ,Nil, "QTD_LEITE"       , "@E 999,999,999.99"       , NIL, .T., .F., .F.)
	TRFunction():New(oSection3:Cell("TOTAL")	    , Nil,  "SUM"   , Nil, "VALOR TOTAL"    , "@E 999,999,999,999.99"   , NIL, .T., .F., .F.)

ELSE // Analitico
    oReport:=TReport():New("GLEPY017","MAPA DE PRODUÇÃO LEITE",cPerg,{|oReport| PrintReport(oReport)},;
		                    "MAPA DE PRODUÇÃO LEITE")
	oReport:SetLandScape(.T.)      //
	oReport:lParampage := .F.      //.T. Lista os Prametros .F. Não Lista Parametros
	oReport:oPage:SetPaperSize(9)  // Orientação A4
	oReport:SetPortrait()


    // Sessão Total Linhas Ativas
	oSection:= TRSection():New(oReport,"LINHA")
	    Trcell():New(oSection,"LINHAS",,"LINHAS ATIVAS")

    // Sessão Total de Produtores Ativos
	oSection1:=TRSection():New(oReport,"PRODUTORES_ATIVOS")
        TrCell():New(oSection1,"FILIAL")
        TrCell():New(oSection1,"SETOR"      ,,"SETOR"    ,,6)
        TrCell():New(oSection1,"DESCRICAO"  ,,"DESCRIÇÃO",,20)
        TrCell():New(oSection1,"ATIVOS"     ,,"PRODUTORES ATIVOS")
    //FOLHA, SETOR, MUNICIPIO,CODIGO,LOJA, LEITE, CREDITO, DEBITO, VLR_LT, TOTAL
    oSection4:= TrSection():New(oReport,"MAPA PRODUÇÃO ANALITICO")
        TrCell():New(oSection4,"FOLHA"      ,,"FOLHA")
        TrCell():New(oSection4,"SETOR"      ,,"SETOR")
        TrCell():New(oSection4,"MUNICIPIO"  ,,"MUNICIPIO",,20)
        TrCell():New(oSection4,"CODIGO"     ,,"CODIGO")
        Trcell():New(oSection4,"LOJA"       ,,"LOJA")
        TrCell():New(oSection4,"LEITE"      ,,"VOL. LEITE")
        TrCell():New(oSection4,"CREDITO"    ,,"CREDITO")
        TrCell():New(oSection4,"DEBITO"     ,,"DEBITO")
        TrCell():New(oSection4,"VLR_LT"     ,,"VALOR LI")
        TrCell():New(oSection4,"TOTAL"      ,,"TOTAL","@E 999,999,999.99",12)

        oSection4:SetTotalInLine(.F.)
        //TOTALIZADORES SESSÃO ANALITICO
    TRFunction():New(oSection4:Cell("LEITE"), NIL,"SUM",Nil,"LEITE", "@E 999,999,999"          , NIL, .T., .F., .F.)
    TRFunction():New(oSection4:Cell("TOTAL"), NIL,"SUM",Nil,"TOTAL", "@E 999,999,999.99"       , NIL, .T., .F., .F.)
ENDIF
Return

Static Function PrintReport()

	Local cAlias  := GetNextAlias()
    Local cAlias1 := GetNextAlias()
    Local cAlias2 := GetNextAlias()
    Local cAlias3 := GetNextAlias()
    Local cAlias4 := GetNextAlias()

IF MV_PAR04 = 1
	oSection:BeginQuery()
	Beginsql Alias cAlias
        SELECT COUNT(ROTA) LINHAS
        FROM   (SELECT ZLZ.ZLZ_ROTA AS ROTA 
                FROM   PROTHEUS.ZLZ010 ZLZ
                WHERE  EXISTS (SELECT ZLF.ZLF_RETIRO
                               FROM   PROTHEUS.ZLF010 ZLF
                               WHERE  ZLF.ZLF_RETIRO = ZLZ.ZLZ_CODPRO
                                      AND ZLF.ZLF_FILIAL = %EXP:MV_PAR01%
                                      AND ZLF_DTINI = %EXP:MV_PAR02%
                                      AND ZLF_DTFIM = %EXP:MV_PAR03%)
                GROUP  BY ZLZ.ZLZ_ROTA
                ORDER  BY 1) 
	ENDSQL

	oSection:EndQuery()
	oSection:Print()
    (cAlias)->(DbCloseArea())

	oSection1:BeginQuery()
	BeginSql Alias cAlias1
        SELECT ZLF_FILIAL           AS FILIAL,
               ZLF_SETOR            AS SETOR,
               ZL2.ZL2_DESCRI       AS DESCRICAO,
               COUNT(ZLF_RETIRO
                    || ZLF_RETILJ)  ATIVOS
        FROM   PROTHEUS.ZLF010 ZLF
            JOIN PROTHEUS.ZL2010 ZL2
                ON ( ZL2_COD = ZLF_SETOR
                    AND ZL2.D_E_L_E_T_ = ' ' )
        WHERE   ZLF_FILIAL = %EXP:MV_PAR01%
            AND ZLF_DTINI  = %EXP:MV_PAR02%
            AND ZLF_DTFIM  = %EXP:MV_PAR03%
            AND ZLF_EVENTO = '010001'
            AND ZLF.D_E_L_E_T_ = ' '
        GROUP  BY ZLF_FILIAL,
                ZLF_SETOR,
                ZL2.ZL2_DESCRI
    ENDSQL
    oSection1:EndQuery()
    oSection1:Print()
    (cAlias1)->(DbCloseArea())


    oSection2:BeginQuery()
    BeginSql Alias cAlias2
        SELECT MUNICIPIO, SUM(LEITE)LEITE ,SUM(TOTAL)TOTAL
        FROM (SELECT  FOLHA, SETOR, MUNICIPIO, SUM(QTD_LEITE)LEITE, SUM(CREDITO)CREDITO, SUM(DEBITO)DEBITO, ROUND(CREDITO - DEBITO ,3)VLR_LT, ROUND(QTD_LEITE * CREDITO - DEBITO ,3)TOTAL
             FROM ( SELECT 
                        ZLF_CODZLE FOLHA
                        ,ZLF_SETOR SETOR
                        ,SA2.A2_MUN MUNICIPIO
                        ,ZLF_RETIRO CODIGO
                        ,ZLF_RETILJ LOJA
                        ,(SELECT Z.ZLF_QTDBOM 
                    FROM PROTHEUS.ZLF010 Z 
                    WHERE   Z.ZLF_CODZLE = ZLF.ZLF_CODZLE 
                            AND Z.ZLF_SETOR  = ZLF.ZLF_SETOR 
                            AND Z.ZLF_RETIRO = ZLF.ZLF_RETIRO
                            AND Z.ZLF_RETILJ = ZLF.ZLF_RETILJ
                            AND Z.ZLF_EVENTO = '010001'
                            AND Z.D_E_L_E_T_ = ' ')QTD_LEITE
                    ,COALESCE((SELECT SUM(X.ZLF_VLRLTR) 
                                FROM PROTHEUS.ZLF010 X 
                                WHERE  X.ZLF_CODZLE = ZLF.ZLF_CODZLE 
                                    AND X.ZLF_SETOR  = ZLF.ZLF_SETOR 
                                    AND X.ZLF_RETIRO = ZLF.ZLF_RETIRO
                                    AND X.ZLF_RETILJ = ZLF.ZLF_RETILJ
                                    AND X.ZLF_DEBCRE ='D'
                                    AND X.ZLF_EVENTO IN ('010001','010002','020001','020002','020003','020004','020005',
                                                   '020007','029997','040003','040004','040006','029998',
                                                   '050003','050004','050006')),
                    0)DEBITO
                    ,COALESCE((SELECT SUM(Y.ZLF_VLRLTR)
                                FROM PROTHEUS.ZLF010 Y
                                WHERE  Y.ZLF_CODZLE = ZLF.ZLF_CODZLE 
                                    AND Y.ZLF_SETOR  = ZLF.ZLF_SETOR 
                                    AND Y.ZLF_RETIRO = ZLF.ZLF_RETIRO
                                    AND Y.ZLF_RETILJ = ZLF.ZLF_RETILJ
                                    AND Y.ZLF_DEBCRE ='C'
                                    AND Y.ZLF_EVENTO IN  ('010001','010002','020001','020002','020003','020004','020005',
                                                   '020007','029997','040003','040004','040006','029998',
                                                   '050003','050004','050006')),
                    0)CREDITO
                    FROM PROTHEUS.ZLF010 ZLF 
                         JOIN PROTHEUS.SA2010 SA2 
                                ON(SA2.A2_COD = ZLF.ZLF_RETIRO 
                                AND SA2.A2_LOJA = ZLF.ZLF_RETILJ 
                                AND SA2.D_E_L_E_T_=' ')
                    WHERE       ZLF.ZLF_DTINI = %EXP:MV_PAR02%
                            AND ZLF.ZLF_DTFIM = %EXP:MV_PAR03%
                            AND ZLF.ZLF_FILIAL =%EXP:MV_PAR01%
                            AND zlf.d_e_l_e_t_ =' ' 
                    GROUP BY ZLF_CODZLE, ZLF_SETOR, SA2.A2_MUN, ZLF_RETIRO, ZLF_RETILJ) 
                GROUP BY FOLHA, SETOR, MUNICIPIO, CODIGO, LOJA, 
                         QTD_LEITE, CREDITO, DEBITO, ROUND(CREDITO - DEBITO ,3), 
                         ROUND(QTD_LEITE * CREDITO - DEBITO ,3)
        ORDER BY FOLHA, SETOR, MUNICIPIO) 
        GROUP BY MUNICIPIO
        
    ENDSQL
    oSection2:EndQuery()
    oSection2:Print()
    (cAlias2)->(DbCloseArea())
ELSEIF MV_PAR04 = 2
    // QUERY SESSÃO MAPRA_SINTÉTICO_PREÇO_MUNICIPIO
    oSection3:BeginQuery()
    BeginSql Alias cAlias3
        SELECT FOLHA, SETOR,SUM(QTD_MUN)QTD_MUN, MUNICIPIO,SUM(LEITE)QTD_LEITE ,VLR_LT,SUM(TOTAL)TOTAL
        FROM 
            (SELECT COUNT(MUNICIPIO)QTD_MUN, FOLHA, SETOR, MUNICIPIO, SUM(QTD_LEITE)LEITE, SUM(CREDITO)CREDITO, SUM(DEBITO)DEBITO, ROUND(CREDITO - DEBITO ,3)VLR_LT, ROUND(QTD_LEITE * CREDITO - DEBITO ,3)TOTAL
            FROM ( SELECT 
                    ZLF_CODZLE FOLHA
                    ,ZLF_SETOR SETOR
                    ,SA2.A2_MUN MUNICIPIO
                    ,ZLF_RETIRO CODIGO
                    ,ZLF_RETILJ LOJA
                    ,(SELECT Z.ZLF_QTDBOM 
                    FROM PROTHEUS.ZLF010 Z 
                    WHERE   Z.ZLF_CODZLE = ZLF.ZLF_CODZLE 
                        AND Z.ZLF_SETOR  = ZLF.ZLF_SETOR 
                        AND Z.ZLF_RETIRO = ZLF.ZLF_RETIRO
                        AND Z.ZLF_RETILJ = ZLF.ZLF_RETILJ
                        AND Z.ZLF_EVENTO = '010001'
                        AND Z.D_E_L_E_T_ = ' ')QTD_LEITE
                    ,COALESCE((SELECT SUM(X.ZLF_VLRLTR) 
                            FROM PROTHEUS.ZLF010 X 
                            WHERE  X.ZLF_CODZLE = ZLF.ZLF_CODZLE 
                                AND X.ZLF_SETOR  = ZLF.ZLF_SETOR 
                                AND X.ZLF_RETIRO = ZLF.ZLF_RETIRO
                                AND X.ZLF_RETILJ = ZLF.ZLF_RETILJ
                                AND X.ZLF_DEBCRE ='D'
                                AND X.ZLF_EVENTO IN ('010001','010002','020001','020002','020003','020004','020005',
                                                   '020007','029997','040003','040004','040006','029998',
                                                   '050003','050004','050006')),
                    0)DEBITO
                    ,COALESCE((SELECT SUM(Y.ZLF_VLRLTR)
                            FROM PROTHEUS.ZLF010 Y
                            WHERE  Y.ZLF_CODZLE = ZLF.ZLF_CODZLE 
                                AND Y.ZLF_SETOR  = ZLF.ZLF_SETOR 
                                AND Y.ZLF_RETIRO = ZLF.ZLF_RETIRO
                                AND Y.ZLF_RETILJ = ZLF.ZLF_RETILJ
                                AND Y.ZLF_DEBCRE ='C'
                                AND Y.ZLF_EVENTO IN  ('010001','010002','020001','020002','020003','020004','020005',
                                                   '020007','029997','040003','040004','040006','029998'
                                                     )),
                    0)CREDITO
                    FROM PROTHEUS.ZLF010 ZLF 
                        JOIN PROTHEUS.SA2010 SA2 
                            ON(SA2.A2_COD = ZLF.ZLF_RETIRO 
                            AND SA2.A2_LOJA = ZLF.ZLF_RETILJ 
                            AND SA2.D_E_L_E_T_=' ')
                    WHERE   ZLF.ZLF_FILIAL = %EXP:MV_PAR01%
                        AND ZLF.ZLF_DTINI  = %EXP:MV_PAR02%
                        AND ZLF.ZLF_DTFIM  = %EXP:MV_PAR03%
                        AND ZLF.D_E_L_E_T_ =' ' 
                    GROUP BY ZLF_CODZLE, ZLF_SETOR, SA2.A2_MUN, ZLF_RETIRO, ZLF_RETILJ) 
                    group by FOLHA, SETOR, MUNICIPIO, ROUND(CREDITO - DEBITO ,3), ROUND(QTD_LEITE * CREDITO - DEBITO ,3)                  
                    ORDER BY FOLHA, SETOR, MUNICIPIO) 
        GROUP BY FOLHA, SETOR, MUNICIPIO,VLR_LT
        ORDER BY FOLHA, SETOR,MUNICIPIO, VLR_LT
    ENDSQL

    oSection3:EndQuery()
    oSection3:Print()
    (cAlias3)->(DbCloseArea())
ELSE
    //QUERY SESSÃO MAPA ANALITICO 
    oSection4:BeginQuery()
    BeginSql Alias cAlias4
        SELECT  FOLHA, SETOR, MUNICIPIO,CODIGO,LOJA, SUM(QTD_LEITE)LEITE, SUM(CREDITO)CREDITO, SUM(DEBITO)DEBITO, ROUND(CREDITO - DEBITO ,3)VLR_LT, ROUND(QTD_LEITE * CREDITO - DEBITO ,3)TOTAL
            FROM ( SELECT 
                    ZLF_CODZLE FOLHA
                    ,ZLF_SETOR SETOR
                    ,SA2.A2_MUN MUNICIPIO
                    ,ZLF_RETIRO CODIGO
                    ,ZLF_RETILJ LOJA
                    ,(SELECT Z.ZLF_QTDBOM 
                    FROM PROTHEUS.ZLF010 Z 
                    WHERE   Z.ZLF_CODZLE = ZLF.ZLF_CODZLE 
                        AND Z.ZLF_SETOR  = ZLF.ZLF_SETOR 
                        AND Z.ZLF_RETIRO = ZLF.ZLF_RETIRO
                        AND Z.ZLF_RETILJ = ZLF.ZLF_RETILJ
                        AND Z.ZLF_EVENTO = '010001'
                        AND Z.D_E_L_E_T_ = ' ')QTD_LEITE
                    ,COALESCE((SELECT SUM(X.ZLF_VLRLTR) 
                            FROM PROTHEUS.ZLF010 X 
                            WHERE  X.ZLF_CODZLE = ZLF.ZLF_CODZLE 
                                AND X.ZLF_SETOR  = ZLF.ZLF_SETOR 
                                AND X.ZLF_RETIRO = ZLF.ZLF_RETIRO
                                AND X.ZLF_RETILJ = ZLF.ZLF_RETILJ
                                AND X.ZLF_DEBCRE ='D'
                                AND X.ZLF_EVENTO IN ('010001','010002','020001','020002','020003','020004','020005',
                                                   '020007','029997','040003','040004','040006','029998',
                                                   '050003','050004','050006')),
                    0)DEBITO
                    ,COALESCE((SELECT SUM(Y.ZLF_VLRLTR)
                            FROM PROTHEUS.ZLF010 Y
                            WHERE  Y.ZLF_CODZLE = ZLF.ZLF_CODZLE 
                                AND Y.ZLF_SETOR  = ZLF.ZLF_SETOR 
                                AND Y.ZLF_RETIRO = ZLF.ZLF_RETIRO
                                AND Y.ZLF_RETILJ = ZLF.ZLF_RETILJ
                                AND Y.ZLF_DEBCRE ='C'
                                AND Y.ZLF_EVENTO IN  ('010001','010002','020001','020002','020003','020004','020005',
                                                   '020007','029997','040003','040004','040006','029998'
                                                     )),
                    0)CREDITO
                    FROM PROTHEUS.ZLF010 ZLF 
                        JOIN PROTHEUS.SA2010 SA2 
                            ON(SA2.A2_COD = ZLF.ZLF_RETIRO 
                            AND SA2.A2_LOJA = ZLF.ZLF_RETILJ 
                            AND SA2.D_E_L_E_T_=' ')
                    WHERE   ZLF.ZLF_FILIAL = %EXP:MV_PAR01%
                        AND ZLF.ZLF_DTINI  = %EXP:MV_PAR02%
                        AND ZLF.ZLF_DTFIM  = %EXP:MV_PAR03%
                        AND ZLF.D_E_L_E_T_ =' ' 
                    GROUP BY ZLF_CODZLE, ZLF_SETOR, SA2.A2_MUN, ZLF_RETIRO, ZLF_RETILJ) 
        group by FOLHA, SETOR, MUNICIPIO, CODIGO, LOJA, 
                 ROUND(CREDITO - DEBITO ,3), ROUND(QTD_LEITE * CREDITO - DEBITO ,3)                                    
        ORDER BY FOLHA, SETOR, MUNICIPIO
    ENDSQL
    oSection4:EndQuery()
    oSection4:Print()
    (cAlias4)->(DbCloseArea())
ENDIF
Return 


