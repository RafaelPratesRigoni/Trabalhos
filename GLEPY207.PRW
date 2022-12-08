#include 'Protheus.ch'
#include 'Topconn.ch'
#include 'Totvs.ch'

User Function GLEPY207()

Private oReport  := Nil
Private oSection := Nil
Private cPerg    := "PRGLT206"

Pergunte(cPerg,.T.)
ReportDef()
oReport:PrintDialog()

Return 

Static Function ReportDef()

oReport := TReport():New("GLEPY207","Relatório Conferencia Funrural",cPerg,{|oReport| PrintReport(oReport)},;
"Relatório Conferencia Funrural")

oReport:SetLandScape(.T.)
oReport:lParamPage := .F.
oReport:oPage:SetPaperSize(9)

oSection := TRSection():New(oReport,"CONFERENCIA FUNRURAL")

TrCell():New(oSection,"E2_FORNECE","SE2","FORNECEDOR"  ,,,,,,,,,,,,,.F.)
TrCell():New(oSection,"E2_LOJA"   ,"SE2","LOJA"        ,,,,,,,,,,,,,.F.)
TrCell():New(oSection,"A2_NOME"   ,"SA2","RAZAO SOCIAL",,,,,,,,,,,,,.F.)
TrCell():New(oSection,"VALOR_NOTA")
TrCell():New(oSection,"FUNRURAL_CALCULADO")
TrCell():New(oSection,"FUNRURAL_TITULO")

oSection:SetTotalInLine(.F.)


TRFunction():New(oSection:Cell("VALOR_NOTA"),"VALOR_NOTA","SUM")
TRFunction():New(oSection:Cell("FUNRURAL_CALCULADO"),,"SUM")
TRFunction():New(oSection:Cell("FUNRURAL_TITULO")   ,,"SUM")


 Return 

Static Function PrintReport()

Local cAlias := GetNextAlias()

oSection:BeginQuery()
BeginSql Alias cAlias 
    SELECT YY.E2_FORNECE, YY.E2_LOJA, YY.A2_NOME, YY.VALOR_NOTA, YY.FUNRURAL_CALCULADO, XX.E2_VALOR AS FUNRURAL_TITULO
    FROM
        (
        SELECT E2_FORNECE, E2_LOJA, A2_NOME, SUM(E2_VALOR) AS VALOR_NOTA, ROUND(SUM(E2_VALOR) * 0.015,2) AS FUNRURAL_CALCULADO
        FROM
            (
            SELECT E2_FORNECE, E2_LOJA, E2_VALOR, A2_NOME
            FROM %Table:SE2% SE2
            JOIN %Table:SA2% SA2 ON A2_COD = E2_FORNECE AND A2_LOJA = E2_LOJA AND SA2.%NotDel% AND A2_L_DINSS = 'S'
            WHERE SE2.%NotDel% 
            AND E2_FILIAL = '47' 
            AND E2_EMISSAO BETWEEN %EXP:MV_PAR01% AND %EXP:MV_PAR02% 
            AND E2_PREFIXO IN ('100','GDF')
            ) 
        GROUP BY E2_FORNECE, E2_LOJA, A2_NOME
        ) YY
    LEFT JOIN %Table:SE2% XX ON XX.E2_L_EVENT = '090001' AND XX.D_E_L_E_T_ = ' ' AND XX.E2_FILIAL = '47' AND XX.E2_EMISSAO BETWEEN %EXP:MV_PAR01% AND %EXP:MV_PAR02% AND XX.E2_FORNECE = YY.E2_FORNECE AND XX.E2_LOJA = YY.E2_LOJA
    ORDER BY 1,2 

    ENDSQL
oSection:EndQuery()
oSection:Print()
(cAlias)->(DbCloseArea())

 Return 

