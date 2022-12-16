#INCLUDE "REPORT.CH"
/*/
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  � RGLT045  � Autor � TOTVS            	    � Data da Criacao  � 20/05/2011                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Relatorio de Pagamento de frete - Busca dados do mix (ZLF).                                         			���
���          � 															                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Uso       � Tem por objetivo: 																							���
���			 �					*Imprimir o a relacao de total do volume de leite transportado X valor por litro por linha  ���
���������������������������������������������������������������������������������������������������������������������������͹��
���Parametros� Nenhum.                                                                                 						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Retorno   � Nenhum                                                 	                                                    ���
���������������������������������������������������������������������������������������������������������������������������͹��
���Usuario   �                                                                                          					���
���������������������������������������������������������������������������������������������������������������������������͹��
���Setor     � Leite                                                                                 						���
���������������������������������������������������������������������������������������������������������������������������͹��
���            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Autor     � Data     � Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor        ���
���������������������������������������������������������������������������������������������������������������������������ĺ��
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���������������������������������������������������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
/*/
User Function RGLT045

Private oReport
Private oZLF
Private QRYZLF  := ""
Private cPerg   := PADR("RGLT045",10)
Private nTotAux := 0
Private nLinha  := 1

Pergunte(cPerg,.F.)

DEFINE REPORT oReport NAME "RGLT045" TITLE "Pagamento de Frete" PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)}

//Seta Padrao de impressao Paisagem.
//oReport:SetLandscape()
oReport:SetTotalInLine(.F.)

//�������������������������������������������������8�
//�Define secoes para primeira ordem - Fornecedores �
//�������������������������������������������������8�
DEFINE SECTION oZLF OF oReport TITLE "Dados" TABLES "SA2"
DEFINE CELL NAME "ZLF_A2COD"	    OF oZLF ALIAS "ZLF"  TITLE "Cod"
DEFINE CELL NAME "ZLF_A2LOJA"	    OF oZLF ALIAS "ZLF"  TITLE "Loja"
DEFINE CELL NAME "ZLF_A2NOME"	    OF oZLF ALIAS "ZLF"  TITLE "Transportadora"


DEFINE SECTION oZLF_1 OF oZLF TITLE "Frete" TABLES "ZLF"
DEFINE CELL NAME "ZLF_LINROT"	    OF oZLF_1 ALIAS "ZLF" TITLE "Cod" SIZE 8
DEFINE CELL NAME "ZLF_DCRLIN"	    OF oZLF_1 ALIAS "ZLF" TITLE "Linha"
DEFINE CELL NAME "ZLF_DCREVE"	    OF oZLF_1 ALIAS "ZLF" TITLE "Tipo" SIZE 12
DEFINE CELL NAME "ZLF_QTDBOM"       OF oZLF_1 ALIAS "ZLF" TITLE "Quantidade"
DEFINE CELL NAME "ZLF_VLRLTR"	    OF oZLF_1 ALIAS "ZLF"
DEFINE CELL NAME "ZLF_TOTAL"	    OF oZLF_1 ALIAS "ZLF" BLOCK {|| If(QRYZLF->ZLF_EVENTO == GetMV("LT_EVEFALT"),QRYZLF->ZLF_TOTAL*-1,QRYZLF->ZLF_TOTAL )}

nLinha    := 1
nCorPad   := oZLF:Cell("ZLF_A2COD"):ClrBack()
nCorCinza := 205205205

oZLF:OnPrintLine({||nLinha := 1  }) //Retorna variavel nLinha para um para sempre comecar com cor padrao a cada nova quebra da secao

oZLF_1:OnPrintLine({|| If(nLinha % 2 == 0,	setCor(nCorCinza),setCor(nCorPad)), nLinha++  })
oZLF_1:SetTotalInLine(.F.)
oZLF_1:SetTotalText("SubTotal Transportadora")

oSumSaldo := TRFunction():New(oZLF_1:Cell("ZLF_QTDBOM"),NIL,"SUM",NIL)
oSumJuros := TRFunction():New(oZLF_1:Cell("ZLF_TOTAL"),NIL,"SUM",NIL)

//oReport:cFontBody := 'Courier New'
oReport:nFontBody := 10
oReport:nLineHeight	:= 50 // Define a altura da linha.

oReport:PrintDialog()

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RGLT045   �Autor  �Microsiga           � Data �  09/09/10   ���
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

If !Empty(MV_PAR02)
	cFiltro += " AND ZLF.ZLF_EVENTO IN " + FormatIn(MV_PAR02 + ";" + getMV("LT_EVEFALT"),";")
Else
	MsgAlert("Aten��o, c�digo do evento do frete n�o pode ser vazio, favor escolher o c�digo do evento referente ao frete.", "Aten��o!")
	Return
EndIf

cFiltro += " AND ZLF.ZLF_CODZLE = '" + MV_PAR01 + "' "
cFiltro += " AND ZLF.ZLF_LINROT BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
cFiltro += " AND ZLF.ZLF_A2COD  BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' "
cFiltro += " AND ZLF.ZLF_A2LOJA BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "' "
cFiltro += "%"

//Define query para ordem Supervisor
BEGIN REPORT QUERY oZLF
BeginSql alias "QRYZLF"
	SELECT
	ZLF.ZLF_LINROT,ZLF.ZLF_A2COD,ZLF.ZLF_A2NOME,ZLF.ZLF_DCRLIN,ZLF.ZLF_A2LOJA,
	ZLF.ZLF_QTDBOM,ZLF.ZLF_VLRLTR,ZLF.ZLF_TOTAL,ZLF.ZLF_EVENTO,ZLF.ZLF_DCREVE
	FROM
	%table:ZLF% ZLF
	WHERE
	ZLF.%notDel%  AND ZLF.ZLF_FILIAL = %xFilial:ZLF%
	%exp:cFiltro%
	ORDER BY
	ZLF.ZLF_A2COD,ZLF.ZLF_A2LOJA
EndSql
END REPORT QUERY oZLF

oZLF_1:SetParentQuery()
oZLF_1:SetParentFilter({|cParam| QRYZLF->ZLF_A2COD+QRYZLF->ZLF_A2LOJA == cParam},{|| QRYZLF->ZLF_A2COD+QRYZLF->ZLF_A2LOJA})

oZLF:Print(.T.)
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RGLT045   �Autor  �Microsiga           � Data �  09/15/10   ���
�������������������������������������������������������������������������͹��
���Desc.     � Altera cor de fundo das celular para report ficar zebrado  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function setCor(nCor)

oZLF_1:Cell("ZLF_LINROT"):SetClrBack(nCor)
oZLF_1:Cell("ZLF_DCRLIN"):SetClrBack(nCor)
oZLF_1:Cell("ZLF_QTDBOM"):SetClrBack(nCor)
oZLF_1:Cell("ZLF_VLRLTR"):SetClrBack(nCor)
oZLF_1:Cell("ZLF_TOTAL"):SetClrBack(nCor)

Return