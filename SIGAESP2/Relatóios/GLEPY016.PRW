#INCLUDE 'Protheus.ch'
#INCLUDE 'TOTVS.CH'
#INCLUDE 'Topconn.ch'


/*/{Protheus.doc} GLEPY016
RELATÓRIO PRODUTIVIDADE POR PRODUTOR PROJETO LEITE CERTO TEM POR FINALIDADE AUXILIAR 
O FILIPE TON A PRODUTIVIDADE DE CADA PRODUTOR QUE É ASSITIDO PELO PROJETO LEITE CERTO.
@type function
@version  
@author Rafael.Rigoni
@since 12/01/2022
@return variant, return_description
/*/
User Function GLEPY016()

	Private oReport     := NIL
	Private oSection    := NIL
	Private oSection1   := Nil
	Private cPerg       := "PRGLT41"

	Pergunte(cPerg, .T.)
	ReporDef()
	oReport:PrintDialog()

Return

Static Function ReporDef()

	oReport:= TReport():New("GLEPY016","RELATÓRIO PRODUTIVIDADE POR PRODUTOR PROJETO LEITE CERTO", cPerg,{|oReport| PrintReport(oReport)},;
		                    "RELATÓRIO PRODUTIVIDADE POR PRODUTOR PROJETO LEITE CERTO")

	oReport:SetLandScape(.T.)
    oReport:lParamPage:= .F.
	oReport:oPage:SetPaperSize(9)
    oReport:SetPortrait()	

	oSection:= TRSection():New(oReport,"TECNICO LEITE CERTO")
	TRcell():New(oSection,"COD_TEC_LT_CERTO",,"CÓDIGO TECNICO"  , ,    , , , , , , , , , , , .T.)    
	TRcell():New(oSection,"NOME_TEC_LEITE_CERTO",,"DESCRIÇÃO"   , , 40 , , , , , , , , , , , .T.)

	oSection1:= TRSection():New(oSection,"PRODUTORES")
	TRcell():New(oSection1,"CODIGO")
	TRcell():New(oSection1,"LOJA")
	TRcell():New(oSection1,"PRODUTOR"   ,,               , /*Picture*/, 40, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRcell():New(oSection1,"TOTAL_LEITE",,"VOLUME LEITE" ,"@E 999,999,999,999,999")
    
    oSection1:SetTotalInLine(.F.)

    //TOTALIZADORES
    TRFunction():New(oSection1:Cell("TOTAL_LEITE"), Nil,  "SUM"  , Nil, "VOLUME LEITE"     , "@E 999,999,999.99", NIL, .T., .F., .F.)
    TRFunction():New(oSection1:Cell("CODIGO")      , Nil, "COUNT", Nil, "TOTAL PRODUTORES",                    , NIL, .T., .F., .F.)
   
Return

Static Function PrintReport()

	Local cAlias := GetNextAlias()

	oSection:BeginQuery()

	BeginSql Alias cAlias
        SELECT * 
            FROM (
                    SELECT 
                         X.A2_COD           AS  CODIGO
                        ,X.A2_LOJA          AS  LOJA
                        ,X.A2_NOME          AS  PRODUTOR
                        ,X.A2_L_LTECE
                        ,X.A2_L_DTECE
                        ,X.A2_L_TECLC       AS COD_TEC_LT_CERTO
                        ,(SELECT DISTINCT  SA2.A2_NOME 
                        FROM %TABLE:SA2% SA2
                        WHERE   SA2.A2_COD  = X.A2_L_TECLC 
                            AND SA2.A2_LOJA = X.A2_LOJA)AS NOME_TEC_LEITE_CERTO
                        ,(SELECT ZLF.ZLF_QTDBOM FROM %TABLE:ZLF% ZLF
                                WHERE   ZLF.ZLF_RETIRO = X.A2_COD 
                                    AND ZLF.ZLF_RETILJ = X.A2_LOJA 
                                    AND ZLF.ZLF_CODZLE =%EXP:MV_PAR01%
                                    AND ZLF.ZLF_EVENTO ='010001'
                                    AND ZLF.%NOTDEL%) TOTAL_LEITE
                    FROM %TABLE:SA2% X
                        WHERE  X.A2_L_LTECE > '0'
                            OR X.A2_L_DTECE     = 'S'
                            AND X.D_E_L_E_T_    = ' '
                            AND X.A2_MSBLQL     = '2'
                    GROUP BY X.A2_COD, X.A2_LOJA, X.A2_NOME, X.A2_L_LTECE, X.A2_L_DTECE,X.A2_L_TECLC
                    ORDER BY X.A2_L_TECLC
                ) 
        ORDER BY COD_TEC_LT_CERTO

	ENDSQL

	oSection:EndQuery()
	oSection1:SetParentQuery()
    oSection1:SetParentFilter({|cTecnico|(cAlias)->COD_TEC_LT_CERTO  = cTecnico},{||(cAlias)->COD_TEC_LT_CERTO})
	oSection:Print()

	(cAlias)->(DbCloseArea())
Return
