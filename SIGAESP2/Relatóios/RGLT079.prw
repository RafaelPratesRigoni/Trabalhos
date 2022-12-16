#INCLUDE "TOTVS.CH"
#INCLUDE "REPORT.CH"
/*/
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  � RGLT079  � Autor � Guilherme Fran�a                 � Data da Criacao  � 31/01/2018     						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Relat�rio volume sint�tico por produtor					                            						���
���          � 															                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Uso       �                                                                   											���
���          � 	 							                                                                                ���
���������������������������������������������������������������������������������������������������������������������������͹��
���Parametros�                                                                                      						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Retorno   � Nenhum					                                                                                  	���
���������������������������������������������������������������������������������������������������������������������������͹��
���Usuario   �															                             						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Setor     � Gest�o do Leite                                                                         						���
���������������������������������������������������������������������������������������������������������������������������͹��
���            						ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Autor     � Data     � Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor        ���
���������������������������������������������������������������������������������������������������������������������������Ĺ��
���          �          �                    							   �                                  � 			���
���������������������������������������������������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
*/
User Function RGLT079()

Private cPerg := "PRGLT079"

Pergunte(cPerg,.T.,'Rela��o Produtores')

oReport := ReportDef()
oReport:PrintDialog()

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ReportDef �Autor  �Microsiga           � Data �  11/26/15   ���
�������������������������������������������������������������������������͹��
���Desc.     � Defini��o do lay-out do relatorio.                         ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ReportDef()

Local oReport
Local oProdutor
Local cAlias := GetNextAlias()
Private _nQtd := 0

CriaTab(@cAlias)

DEFINE REPORT oReport NAME "RGLT079" TITLE "Volume Sint�tico por Produtor - Coleta: "+DTOC(MV_PAR07)+" a "+DTOC(MV_PAR08) PARAMETER cPerg ACTION {|oReport| PrintReport(oReport, cAlias)}

oReport:SetTotalInLine(.F.)

DEFINE SECTION oProdutor OF oReport  TITLE "Produtores" TABLES "ZLD"
oProdutor:SetPageBreak(.T.)
oProdutor:SetTotalInLine(.F.)

DEFINE CELL NAME "ZLD_RETIRO"		OF oProdutor ALIAS "ZLD"	BLOCK {|| (cAlias)->ZLD_RETIRO }
DEFINE CELL NAME "ZLD_RETILJ"		OF oProdutor ALIAS "ZLD"	BLOCK {|| (cAlias)->ZLD_RETILJ }
DEFINE CELL NAME "A2_NOME"			OF oProdutor ALIAS "SA2"	BLOCK {|| (cAlias)->A2_NOME }
DEFINE CELL NAME "A2_END"			OF oProdutor ALIAS "SA2"	BLOCK {|| (cAlias)->A2_END }
DEFINE CELL NAME "VOLUME" 			OF oProdutor ALIAS "   " TITLE "Vol. Coleta" PICTURE PesqPict("ZLD","ZLD_TOTBOM") SIZE 30 BLOCK {|| (cAlias)->VOLUME }
DEFINE CELL NAME "A2_L_ADICI"		OF oProdutor ALIAS "SA2" TITLE "Pre�o Negociado" PICTURE PesqPict("SA2","A2_L_ADICI") SIZE 25	BLOCK {|| (cAlias)->PRECO }

oProdutor:Cell("VOLUME"):SetHeaderAlign("RIGH")
DEFINE FUNCTION FROM oProdutor:Cell("VOLUME") FUNCTION SUM

Return(oReport)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RGLT079   �Autor  �Microsiga           � Data �  11/24/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function PrintReport(oReport, cAlias)

Local _nReg  := 0
Local oProdutor := oReport:Section(1)

dbSelectArea(cAlias)
Count to _nReg

oReport:SetMeter(_nReg)

(cAlias)->(dbGoTop())
While !(cAlias)->(Eof())

	If !((cAlias)->VOLUME > 0)
		(cAlias)->(dbSkip())
	EndIf

	If oReport:Cancel()
		Exit
	EndIf
	oProdutor:Init()

	oProdutor:PrintLine()

   	(cAlias)->(dbSkip())

EndDo
oProdutor:Finish()

(cAlias)->(dbCloseArea())

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CriaTab�Autor  �Microsiga           � Data �  11/26/15   ���
�������������������������������������������������������������������������͹��
���Desc.     � Cria tabela tempor�ria para impress�o do relat�rio.        ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function CriaTab(cAlias)

Local _cSetores := AllTrim(MV_PAR09)

_cSetores := "% ("+ U_AjustSet(_cSetores) + ") %"

BeginSql Alias cAlias

	SELECT ZLD_RETIRO, ZLD_RETILJ,A2_NOME,A2_END, A2_L_ADICI AS PRECO,SUM(ZLD_QTDBOM) AS VOLUME
    FROM %Table:ZLD% ZLD
    	JOIN %Table:SA2% A2 ON A2_COD = ZLD_RETIRO AND A2_LOJA = ZLD_RETILJ
    	AND A2_L_LI_RO BETWEEN %Exp:MV_PAR05% AND %Exp:MV_PAR06%
    	AND A2.%NotDel%
		JOIN %Table:ZL3% ZL3 ON ZL3_FILIAL = %xFilial:ZL3% AND ZL3_COD = A2.A2_L_LI_RO
		AND ZL3_SETOR IN %Exp:_cSetores%
    WHERE ZLD_FILIAL = %xFilial:ZLD%
    AND ZLD_RETIRO BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02%
    AND ZLD_RETILJ BETWEEN %Exp:MV_PAR03% AND %Exp:MV_PAR04%
    AND ZLD_DTCOLE BETWEEN  %Exp:DTOS(MV_PAR07)% AND %Exp:DTOS(MV_PAR08)%
    AND ZLD.%NotDel%
    GROUP BY ZLD_RETIRO, ZLD_RETILJ,A2_NOME,A2_END, A2_L_ADICI
    ORDER BY A2_NOME


EndSql

Return