#include "report.ch"

/*/
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  �RGLT046   � Autor � Jeovane            	� Data da Criacao  � 24/08/2010                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Relatorio Total Fornecimento Analitico (Entrada de leite) - busca dados do mix (zlf)                         ���
���          � 															                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Uso       � Tem por objetivo: 																							���
���			 �					*Imprimir a relacao total do volume de leite por produtor quebrando por linha               ���
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


user function RGLT046
private oReport
private oZLF
private QRYZLF
private cPerg := "RGLT046"
private nTotAux := 0
private nLinha := 1

pergunte(cPerg,.F.)

DEFINE REPORT oReport NAME "RGLT046" TITLE "Total Fornecimento Analitico" PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)}

//Seta Padrao de impressao Paisagem.
//oReport:SetLandscape()
oReport:SetTotalInLine(.F.)




//�������������������������������������������������8�
//�Define secoes para primeira ordem - Fornecedores �
//�������������������������������������������������8�

DEFINE SECTION oZLF OF oReport TITLE "Dados" TABLES "SA2"
DEFINE CELL NAME "ZLF_LINROT"	    OF oZLF ALIAS "ZLF"
DEFINE CELL NAME "ZLF_DCRLIN"	    OF oZLF ALIAS "ZLF"

DEFINE SECTION oZLF_1 OF oZLF TITLE "Frete" TABLES "ZLF"
DEFINE CELL NAME "ZLF_A2COD"	    OF oZLF_1 ALIAS "ZLF"
DEFINE CELL NAME "ZLF_A2LOJA"	    OF oZLF_1 ALIAS "ZLF"
DEFINE CELL NAME "ZLF_A2NOME"	    OF oZLF_1 ALIAS "ZLF"
DEFINE CELL NAME "DIAS"	            OF oZLF_1 ALIAS "" BLOCK {|| getDias(QRYZLF->ZLF_A2COD,QRYZLF->ZLF_A2LOJA)}
DEFINE CELL NAME "ZLF_QTDBOM"       OF oZLF_1 ALIAS "ZLF"
DEFINE CELL NAME "ZLF_TOTAL"	    OF oZLF_1 ALIAS "ZLF"


nLinha := 1
nCorPad := oZLF:Cell("ZLF_LINROT"):ClrBack()
nCorCinza := 205205205

oZLF:OnPrintLine({||nLinha := 1  }) //Retorna variavel nLinha para um para sempre comecar com cor padrao a cada nova quebra da secao

oZLF_1:OnPrintLine({|| if(nLinha % 2 == 0,	setCor(nCorCinza),setCor(nCorPad)), nLinha++  })
oZLF_1:SetTotalInLine(.F.)
oZLF_1:SetTotalText("SubTotal Linha")


oSumSaldo := TRFunction():New(oZLF_1:Cell("ZLF_QTDBOM"),NIL,"SUM",NIL)
oSumJuros := TRFunction():New(oZLF_1:Cell("ZLF_TOTAL"),NIL,"SUM",NIL)



//oReport:cFontBody := 'Courier New'
oReport:nFontBody := 10
oReport:nLineHeight	:= 50 // Define a altura da linha.


oReport:PrintDialog()

return




/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RGLT046   �Autor  �Microsiga           � Data �  09/09/10   ���
�������������������������������������������������������������������������͹��
���Desc.     � Funcao responsavel por gerar relatorio                     ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


static Function PrintReport(oReport)
Local cFiltro := "%"


//Filtra codigo do mix
if !empty(mv_par01)
	cFiltro += " AND ZLF.ZLF_CODZLE = '" + mv_par01 + "' "
endif

//Filtra Linha Rota
if !empty(mv_par02) .and. !empty(mv_par03)
	cFiltro += " AND ZLF.ZLF_LINROT  BETWEEN '" + mv_par02 + "' AND '" + mv_par03 + "' "
endif


//Filtra Produtor
if !empty(mv_par04) .and. !empty(mv_par06)
	cFiltro += " AND ZLF.ZLF_A2COD  BETWEEN '" + mv_par04 + "' AND '" + mv_par06 + "' "
endif

//Filtra Loja Produtor
if !empty(mv_par05) .and. !empty(mv_par07)
	cFiltro += " AND ZLF.ZLF_A2LOJA  BETWEEN '" + mv_par05 + "' AND '" + mv_par07 + "' "
endif

//Filtra Filial de entrega
if !empty(mv_par08)
	cFiltro += " AND ZLF.ZLF_FILENT = '" + mv_par08 + "' "
endif

cEvento := getMV("LT_EVELTE") //busca codigo do evento do leite cru
cFiltro += " AND ZLF.ZLF_EVENTO = '" + cEvento + "' "
cFiltro += "%"



//Define query para ordem Supervisor
BEGIN REPORT QUERY oZLF
	BeginSql alias "QRYZLF"
	   	SELECT
		     ZLF.ZLF_LINROT,ZLF.ZLF_A2COD,ZLF.ZLF_A2NOME,ZLF.ZLF_DCRLIN,ZLF.ZLF_A2LOJA,
		     ZLF.ZLF_QTDBOM,ZLF.ZLF_VLRLTR,ZLF.ZLF_TOTAL
		FROM
			%table:ZLF% ZLF
		WHERE
			ZLF.%notDel%  AND ZLF.ZLF_FILIAL = %xFilial:ZLF%
		    %exp:cFiltro%
		ORDER BY
		     ZLF.ZLF_LINROT
	EndSql
END REPORT QUERY oZLF

oZLF_1:SetParentQuery()
oZLF_1:SetParentFilter({|cParam| QRYZLF->ZLF_LINROT == cParam},{|| QRYZLF->ZLF_LINROT})


oZLF:Print(.T.)

return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RGLT046   �Autor  �Microsiga           � Data �  09/15/10   ���
�������������������������������������������������������������������������͹��
���Desc.     � Altera cor de fundo das celular para report ficar zebrado  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

static function setCor(nCor)

oZLF_1:Cell("ZLF_QTDBOM"):SetClrBack(nCor)
oZLF_1:Cell("ZLF_TOTAL"):SetClrBack(nCor)
oZLF_1:Cell("ZLF_A2COD"):SetClrBack(nCor)
oZLF_1:Cell("ZLF_A2LOJA"):SetClrBack(nCor)
oZLF_1:Cell("ZLF_A2NOME"):SetClrBack(nCor)


return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RGLT046   �Autor  �Microsiga           � Data �  09/17/10   ���
�������������������������������������������������������������������������͹��
���Desc.     � Retorna dias de fornecimento de leite, busca dados da zld  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

static function getDias(cCod,cLoja)
local nRet := 0
local cAlias := "TRBCOUNT"
local cFiltro := "% "

if !empty(mv_par01)
	//Posiciona na ZLE para buscar mix
	dbSelectArea("ZLE")
	dbSetOrder(1)
	dbSeek(xFilial("ZLE")+mv_par01)
	cFiltro += " AND ZLD.ZLD_DTCOLE BETWEEN '" + dtos(ZLE->ZLE_DTINI) + "' AND '" + dtos(ZLE->ZLE_DTFIM) + "' "
endif


cFiltro += " AND ZLD_RETIRO = '" + cCod + "' "
cFiltro += " AND ZLD_RETILJ = '" + cLoja + "' "
cFiltro += "%"

if Select(cAlias) > 0
	dbSelectArea(cAlias)
	cAlias->(dbCloseArea())
endif

BeginSql alias cAlias
      SELECT
      	COUNT(DISTINCT ZLD.ZLD_DTCOLE) AS DIAS
      FROM
      	%table:ZLD%   ZLD
      WHERE
      	ZLD.%notDel% AND ZLD.ZLD_FILIAL = %xFilial:ZLD%
      	%exp:cFiltro%
EndSql


nRet := TRBCOUNT->DIAS


return nRet


