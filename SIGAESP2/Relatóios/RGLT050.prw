#include "report.ch"

/*/
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  �RGLT050   � Autor � Jeovane            	� Data da Criacao  � 24/08/2010                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Relacao de Producao por municipio                                                                 			���
���          � 															                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Uso       � Tem por objetivo: 																							���
���			 �					*Imprimir a relacao de producao por municipio                                               ���
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


user function RGLT050
private oReport
private oZLD
private QRYZLD
private aOrd := {"Nome","Codigo"}
private cPerg := "RGLT050"

pergunte(cPerg,.F.)

DEFINE REPORT oReport NAME "RGLT050" TITLE "Rela��o de Producao por Municipio" PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)}

//Seta Padrao de impressao Paisagem.
//oReport:SetLandscape()
oReport:SetTotalInLine(.F.)


//Secao Dados
DEFINE SECTION oZLD OF oReport  TITLE "Dados" TABLES "ZLD"  ORDERS aOrd

DEFINE CELL NAME "TOTALLTE"     OF oZLD ALIAS ""    TITLE "Total Leite"       PICTURE "@E 999,999,999,999"     SIZE 18

DEFINE FUNCTION FROM oZLD:Cell("VOLUME")  OF oZLD FUNCTION SUM NO END SECTION


oZLD:Cell("VOLUME"):SetHeaderAlign("RIGHT")



oReport:PrintDialog()

return




/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RGLT050   �Autor  �Microsiga           � Data �  09/22/10   ���
�������������������������������������������������������������������������͹��
���Desc.     � Imprime relatorio                                          ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function PrintReport(oReport)
Local cFiltro := "%"

//Filtra Cod. Produtor
If !Empty(mv_par01) .And. !Empty(mv_par03)
	cFiltro += " AND ZLD.ZLD_RETIRO BETWEEN '" + mv_par01 + "' AND '" + mv_par03 + "' "
EndIf

//Filtra Lj Produtor
If !Empty(mv_par02) .And. !Empty(mv_par04)
	cFiltro += " AND ZLD.ZLD_RETILJ BETWEEN '" + mv_par02 + "' AND '" + mv_par04 + "' "
EndIf

//Filtra Mes
If !Empty(mv_par05) .And. !Empty(mv_par06)
	cFiltro += " AND ZLD.ZLD_DTCOLE BETWEEN '" + dtos(mv_par05) + "' AND '" + dtos(mv_par06) + "' "
EndIf
//Filtra Filial
If !Empty(mv_par07) .AND. !empty(mv_par08)
	cFiltro += " AND ZLD.ZLD_FILIAL BETWEEN '" + mv_par07 + "' AND '" + mv_par08 + "' "
EndIf




cFiltro += "%"

nOrdem := oZLD:GetOrder()

if nOrdem == 1
	cOrdem := "% SA2.A2_NOME %"
elseif nOrdem == 2
	cOrdem := "% SA2.A2_COD %"
endif


//Define query para ordem Supervisor
BEGIN REPORT QUERY oZLD
	BeginSql alias "QRYZLD"
	    SELECT
	    	A2_EST,A2_COD_MUN,COUNT(*) AS QTD ,SUM(ZLD_QTDBOM) AS VOLUME
		FROM
			%table:ZLD% ZLD
			JOIN %table:SA2% SA2 ON ZLD.ZLD_RETIRO = SA2.A2_COD AND ZLD.ZLD_RETILJ = SA2.A2_LOJA
		WHERE
			ZLD.%notDel%
			AND SA2.%notDel% AND SA2.A2_L_TPFOR IN ('P','T')
			%Exp:cFiltro%
		GROUP BY
			SA2.A2_EST,SA2.A2_COD_MUN
		ORDER BY
			%exp:cOrdem%
	EndSql
END REPORT QUERY oZLD


oZLD:Print(.T.)
return