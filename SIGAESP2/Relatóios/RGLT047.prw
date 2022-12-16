#INCLUDE "REPORT.CH"
/*/
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  �RGLT047   � Autor � Jeovane            	� Data da Criacao  � 24/08/2010                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Relatorio de Fornecedores                                                                         			���
���          � 															                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Uso       � Tem por objetivo: 																							���
���			 �					*Imprimir o a relacao de fornecedores                                                       ���
���			 �                   a)	Por Codigo           	                                     							���
���			 �					 b)	Por Nome                                                                                ���
���������������������������������������������������������������������������������������������������������������������������͹��
���Parametros� Nenhum.                                                                                 						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Retorno   � Nenhum                                                 	                                                    ���
���������������������������������������������������������������������������������������������������������������������������͹��
���Usuario   �                                                                                          					���
���������������������������������������������������������������������������������������������������������������������������͹��
���Setor     � Leite                                                                                 						���
���������������������������������������������������������������������������������������������������������������������������͹��
���            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Autor     � Data     � Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor        ���
���������������������������������������������������������������������������������������������������������������������������ĺ��
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���������������������������������������������������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
/*/
User Function RGLT047

Private oReport
Private oSA2
Private QRYSA2
Private aOrd := {"Nome","Codigo"}
Private cPerg := PADR("RGLT047",10)

Pergunte(cPerg,.F.)

DEFINE REPORT oReport NAME "RGLT047" TITLE "Rela��o de Fornecedores" PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)}

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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � PrintRep � Autor � Microsiga          � Data �  00/00/00   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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