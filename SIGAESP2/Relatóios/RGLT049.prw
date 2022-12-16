#INCLUDE "REPORT.CH"
/*/
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  �RGLT049   � Autor � Jeovane            	� Data da Criacao  � 24/08/2010                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Relatorio de Saldo Devedor de Produtores  ----    Antes do fechamento                               			���
���          � 															                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Uso       � Tem por objetivo: 																							���
���			 �					*Imprimir o a relacao de saldos devedores dos fornecedores de leite                         ���
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
User Function RGLT049

Private oReport
Private oSA2,oSE2
Private QRYSE2
Private aOrd  := {"Nome","Codigo"}
Private cPerg := PADR("RGLT049",10)
Private nTotAux := 0
Private nLinha := 1

DEFINE REPORT oReport NAME "RGLT049" TITLE "Saldo Devedor - MIX" PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)}

//Seta Padrao de impressao Paisagem.
//oReport:SetLandscape()
oReport:SetTotalInLine(.F.)
nSldAux := 0

//�������������������������������������������������Ŀ
//�Define secoes para primeira ordem - Fornecedores �
//���������������������������������������������������
DEFINE SECTION oSA2 OF oReport TITLE "Dados" TABLES "SA2"  ORDERS aOrd
DEFINE CELL NAME "A2_COD"	    OF oSA2 ALIAS "ZLD"
DEFINE CELL NAME "A2_LOJA"	    OF oSA2 ALIAS "ZLD"
DEFINE CELL NAME "A2_NOME"	    OF oSA2 ALIAS "SA2"

DEFINE CELL NAME "SALDO"	    OF oSA2 ALIAS "SE2" BLOCK {||nSldAux } TITLE "Saldo" PICTURE "@E 999,999,999.99"  SIZE 18
oSA2:Cell("SALDO"):SetHeaderAlign("RIGHT")
oSumSaldo := TRFunction():New(oSA2:Cell("SALDO"),NIL,"SUM",NIL)
oSA2:SetTotalInLine(.F.)
oSumSaldo:SetEndSection(.F.)

oSA2:SetLineCondition({|| getSaldo(QRYSA2->A2_COD,QRYSA2->A2_LOJA) < 0 })

oReport:nFontBody := 10
oReport:nLineHeight	:= 50 // Define a altura da linha.


oReport:PrintDialog()

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RGLT049   �Autor  �Microsiga           � Data �  09/09/10   ���
�������������������������������������������������������������������������͹��
���Desc.     � Funcao responsavel por gerar relatorio                     ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function PrintReport(oReport)

Local cFiltro := "%"
Local cAlias  := "QRYSA2"

If !Empty(MV_PAR03) .and. !Empty(MV_PAR04)
	cFiltro += " AND SA2.A2_COD BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
EndIf

If !Empty(MV_PAR05) .and. !Empty(MV_PAR06)
	cFiltro += " AND SA2.A2_LOJA BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' "
EndIf

cFiltro += "%"

nOrdem := oSa2:GetOrder()

If nOrdem == 1
	cOrdem := "% SA2.A2_NOME %"
Else
	cOrdem := "% SA2.A2_COD %"
EndIf

//Query principal do relatorio
BEGIN REPORT QUERY oSA2
BeginSql alias cAlias
	SELECT
		SA2.A2_COD,SA2.A2_LOJA,SA2.A2_NOME
	FROM
		%table:SA2%  SA2
	WHERE
		SA2.%notDel% AND SA2.A2_FILIAL = %xFilial:SA2%
		AND A2_L_TPFOR IN ('P','T')
		%Exp:cFiltro%
	ORDER BY
		%exp:cOrdem%
EndSql
END REPORT QUERY oSA2

cFiltro += "%"

oSA2:Print(.T.)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RGLT049   �Autor  �Microsiga           � Data �  28/09/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �  Busca saldo por produtor/loja na ZLF - Itens do MIX       ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function getSaldo(cCod,cLoja)

Local cAlias  := "TRBSLD"
Local cFiltro := "%"

If Select(cAlias) > 0
	dbSelectArea(cAlias)
	cAlias->(dbCloseArea())
EndIf

cFiltro += " AND ZLF.ZLF_A2COD = '" + cCod + "' AND ZLF.ZLF_A2LOJA = '" + cLoja + "' "

If !Empty(MV_PAR01)
	cFiltro += " AND ZLF.ZLF_CODZLE = '" + MV_PAR01 + "' "
EndIf

If !Empty(MV_PAR02)
	cFiltro += " AND ZLF.ZLF_VERSAO = '" + MV_PAR02 + "' "
EndIf

cFiltro += "%"

//Busca dados via query
BeginSql alias cAlias
	SELECT
		//SUM((CASE ZLF_DEBCRE WHEN 'C' THEN ZLF_TOTAL WHEN 'D' THEN ZLF_TOTAL * -1 END)) AS SALDO
        SUM(Case WHEN ZLF_DEBCRE = 'C'
           THEN ZLF_TOTAL
             Else 0
        END) AS CREDITO,

	    SUM(Case WHEN ZLF_DEBCRE = 'D'
           THEN ZLF_TOTAL
              Else 0
        END) AS DEBITO

	FROM
		%table:ZLF%  ZLF
	WHERE
		ZLF.%notDel% AND ZLF.ZLF_FILIAL = %xFilial:ZLF%
		%exp:cFiltro%
EndSql

nSldAux := TRBSLD->CREDITO - TRBSLD->DEBITO

Return(nSldAux)