// #########################################################################################
// Projeto: Gestใo do Leite
// Modulo : Gestใo do Leite
// Fonte  : RGLT078
// ---------+-------------------+-----------------------------------------------------------
// Data     | Autor             | Descricao
// ---------+-------------------+-----------------------------------------------------------
// 16/04/14 | Guilherme Fran็a  | Lista de Cr้dito do Produtor
// ---------+-------------------+-----------------------------------------------------------
#include "protheus.ch"
#include "report.ch"

user function RGLT078()

Private oReport
Private oCab
Private oBreak
Private cPerg := "RGLT078"
Private _cAlias    := GetNextAlias()
Private _cFiltro01 := ""
Private _cFiltro02 := ""

If !Pergunte("RGLT078",.T.)
	Return
EndIf


DEFINE REPORT oReport NAME "RGLT078" TITLE "Lista de cr้ditos do produtor" /*PARAMETER "RFIN009"*/ ACTION {|oReport| PrintReport(oReport)}

oReport:nFontBody := 7 //Define o tamanho da fonte
oReport:lHeaderVisible	:= .T.
oReport:SetLandscape()
oReport:GetOrientation(2)



DEFINE SECTION oCab OF oReport TITLE "Lista de cr้ditos do produtor" TABLES "_cAlias"

  DEFINE CELL NAME "A2_COD"        	OF oCab ALIAS "_cAlias" SIZE 10
  DEFINE CELL NAME "A2_NOME" 		OF oCab ALIAS "_cAlias"
  DEFINE CELL NAME "A2_L_NOMFA"		OF oCab ALIAS "_cAlias" TITLE "Titular"
  DEFINE CELL NAME "A2_CGC" 		OF oCab ALIAS "_cAlias" TITLE "CPF" PICTURE "@r 999.999.999-99"
  DEFINE CELL NAME "A2_BANCO" 		OF oCab ALIAS "_cAlias"
  DEFINE CELL NAME "AGENCIA" 		OF oCab ALIAS "_cAlias" //SIZE 15 BLOCK {|| (_cAlias)->NUMAGE+"-"+(_cAlias)->DIGAGE }
  DEFINE CELL NAME "CONTA" 			OF oCab ALIAS "_cAlias" SIZE 15//SIZE 15 BLOCK {|| (_cAlias)->NUMCC+"-"+(_cAlias)->DIGCC }
  DEFINE CELL NAME "SALDO" 			OF oCab ALIAS "_cAlias"  TITLE "Liquido Pagar"   PICTURE "@E 999,999,999.99" SIZE 16


oReport:GetOrientation(2)

oBreak:= TRBreak():New(oCab,oCab:CELL("A2_BANCO"),"Total Banco: " ,.F.)
oBreak:setTotalText({|| "Total Banco: " })

TRFunction():New(oCab:Cell("SALDO"),NIL,"SUM",oBreak)

oCab:lAutoSize := .f.

oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPrintReportบAutor  ณMicrosiga           บ Data ณ  12/02/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PrintReport(oReport)

Local _cSetores := AllTrim(MV_PAR02)
_cSetores := "% ("+ U_AjustSet(_cSetores) + ") %"

Private _cFiltro := "%E2.E2_L_MIX = '"+mv_par01+"'  %"

 BEGIN REPORT QUERY oCab

 BeginSql alias _cAlias

		SELECT A2_COD, A2_LOJA, A2_NOME,
		CASE WHEN A2_L_CGCFA <> '' THEN A2_L_CGCFA ELSE A2_CGC END AS A2_CGC,
		A2.A2_L_NOMFA,A2.A2_BANCO,
		(RTRIM(A2.A2_AGENCIA)||A2.A2_DVAGE) AS AGENCIA,
		(RTRIM(A2.A2_NUMCON)||'-'||A2.A2_DVCTA) AS CONTA,
		SUM(E2.E2_SALDO) SALDO
		FROM %Table:SE2% E2
			JOIN %table:SA2% A2 ON A2_COD = E2.E2_FORNECE AND A2_LOJA = E2_LOJA AND A2.%NotDel%
			JOIN %table:ZL3% ZL3 ON ZL3_FILIAL = %xFilial:ZL3% AND ZL3_COD = A2_L_LI_RO AND ZL3_SETOR IN %Exp:_cSetores% AND ZL3.%NotDel%
		WHERE E2.E2_FILIAL = %xFilial:SE2%
		AND E2.%NotDel%
		AND %exp:_cFiltro%


		GROUP BY A2_COD, A2_LOJA, A2_NOME, A2_CGC, A2.A2_BANCO,A2.A2_AGENCIA,A2.A2_DVAGE, A2.A2_NUMCON,A2.A2_DVCTA,A2_L_CGCFA, A2_L_NOMFA
		ORDER BY A2_BANCO, A2_NOME
 EndSql
 End REPORT QUERY oCab

 oCab:Print(.T.)

Return