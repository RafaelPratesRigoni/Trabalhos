#INCLUDE "REPORT.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณRGLT047   บ Autor ณ Jeovane            	บ Data da Criacao  ณ 24/08/2010                						บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio de Fornecedores                                                                         			บฑฑ
ฑฑบ          ณ 															                               						บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Tem por objetivo: 																							บฑฑ
ฑฑบ			 ณ					*Imprimir o a relacao de fornecedores                                                       บฑฑ
ฑฑบ			 ณ                   a)	Por Codigo           	                                     							บฑฑ
ฑฑบ			 ณ					 b)	Por Nome                                                                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ Nenhum.                                                                                 						บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ Nenhum                                                 	                                                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUsuario   ณ                                                                                          					บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบSetor     ณ Leite                                                                                 						บฑฑ
ฑฑฬออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL                   						บฑฑ
ฑฑฬออออออออออัออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออัออออออออออออออออออออออออออออออออออัอออออออออออออนฑฑ
ฑฑบAutor     ณ Data     ณ Motivo da Alteracao  				               ณUsuario(Filial+Matricula+Nome)    ณSetor        บฑฑ
ฑฑบฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤบฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑศออออออออออฯออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออออออออออออออออออออออออออออออฯอออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function RGLT047

Private oReport
Private oSA2
Private QRYSA2
Private aOrd := {"Nome","Codigo"}
Private cPerg := PADR("RGLT047",10)

Pergunte(cPerg,.F.)

DEFINE REPORT oReport NAME "RGLT047" TITLE "Rela็ใo de Fornecedores" PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)}

//Seta Padrao de impressao Paisagem.
oReport:SetLandscape()
oReport:GetOrientation(2)

oReport:nFontBody	:= 8.5
oReport:SetTotalInLine(.F.)

//Secao Supervisor
DEFINE SECTION oSA2 OF oReport  TITLE "Dados" TABLES "QRYSA2"  ORDERS aOrd
DEFINE CELL NAME "A2_COD"	    OF oSA2 ALIAS "SA2" TITLE "COD" SIZE 10
//DEFINE CELL NAME "ZL3_FILENT"	OF oSA2 ALIAS "SA2" TITLE "FIL" SIZE 4
DEFINE CELL NAME "A2_NOME"	    OF oSA2 ALIAS "SA2" TITLE "NOME" PICTURE "@S30" SIZE 40
DEFINE CELL NAME "A2_END"	    OF oSA2 ALIAS "SA2" TITLE "END"  PICTURE "@S50" SIZE 50
DEFINE CELL NAME "A2_MUN"	    OF oSA2 ALIAS "SA2" PICTURE "@S14" SIZE 30
DEFINE CELL NAME "A2_EST"	    OF oSA2 ALIAS "SA2" TITLE "EST"
DEFINE CELL NAME "A2_CGC"	    OF oSA2 ALIAS "SA2"
DEFINE CELL NAME "A2_PFISICA"   OF oSA2 ALIAS "SA2"  SIZE 20
DEFINE CELL NAME "A2_CEP"	    OF oSA2 ALIAS "SA2" SIZE 15

oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ PrintRep บ Autor ณ Microsiga          บ Data ณ  00/00/00   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PrintReport(oReport)

Local cFiltro := "%"

//Filtra Codigo de Produtores
If  !Empty(MV_PAR02)
	cFiltro += " AND SA2.A2_COD BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
endif

//Filtra Loja Fornecedor
If !Empty(MV_PAR04)
	cFiltro += " AND SA2.A2_LOJA BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
endif

//Filtra Linha
If !Empty(MV_PAR06)
	cFiltro += " AND SA2.A2_L_LI_RO BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' "
EndIf

If MV_PAR07 == 1 //Ativos ou Nao Bloqueados
	cFiltro += " AND SA2.A2_MSBLQL = '2' "
ElseIf MV_PAR07 == 2//Inativos ou Bloqueados
	cFiltro += " AND SA2.A2_MSBLQL = '1' "
EndIf

//Filtra Grupo
If !Empty(MV_PAR09)
	cFiltro += " AND SA2.A2_L_GRUPO BETWEEN '" + MV_PAR08 + "' AND '" + MV_PAR09 + "' "
EndIf


cFiltro += "%"

nOrdem := oSa2:GetOrder()

If nOrdem == 1
	cOrdem := "% SA2.A2_NOME %"
Else
	cOrdem := "% SA2.A2_COD %"
EndIf

//Define query para ordem Supervisor
//BEGIN REPORT QUERY oZL3
BEGIN REPORT QUERY oSA2
	BeginSql alias "QRYSA2"
	   	SELECT
	   		SA2.A2_COD,SA2.A2_NOME,SA2.A2_END,A2_MUN,A2_EST,A2_CGC,A2_PFISICA,
			A2_CEP,ZL3.ZL3_FILENT,SA2.A2_L_LI_RO,ZL3.ZL3_COD,ZL3.ZL3_DESCRI
		FROM
			%table:SA2% SA2
			JOIN %table:ZL3% ZL3 ON SA2.A2_L_LI_RO = ZL3.ZL3_COD 	AND ZL3.%notDel%  AND ZL3.ZL3_FILIAL = %xFilial:ZL3%
		WHERE
			SA2.%notDel%  AND SA2.A2_FILIAL = %xFilial:SA2%
			AND A2_L_TPFOR IN ('P','T')
		    %exp:cFiltro%
		ORDER BY
			%exp:cOrdem%
	EndSql
//END REPORT QUERY oZL3
END REPORT QUERY oSA2

oSA2:Print(.T.)

Return