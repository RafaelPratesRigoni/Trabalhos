#include "report.ch"


/*/
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  �RGLT043   � Autor � Jeovane            	� Data da Criacao  � 24/08/2010                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Relatorio de Diferenca entre pesagens de caminhao e leite coletado                                  			���
���          � 															                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Uso       � Tem por objetivo: 																							���
���			 �					*Imprimir o a relacao de diferenca entre pesagens e leite recebido                          ���
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


user function RGLT043
private oReport
private oZLD
private QRYZL4
private aOrd := {"Nome","Codigo"}
private cPerg := "RGLT043"
private nTotAux := 0
private nLinha := 1
private nPeso := 0
private nRecepcao := 0
private lCalcDif := .T.

pergunte(cPerg,.F.)

DEFINE REPORT oReport NAME "RGLT043" TITLE "Diferen�a entre Peso X Leite Coletado" PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)}

//Seta Padrao de impressao Paisagem.
oReport:SetTotalInLine(.F.)




//�������������������������������������������������8�
//�Define secoes para primeira ordem - Fornecedores �
//�������������������������������������������������8�

DEFINE SECTION oZLD OF oReport TITLE "Dados" TABLES "ZLD"  ORDERS aOrd
DEFINE CELL NAME "ZLD_FRETIS"	    OF oZLD ALIAS "ZLD" TITLE "Transportadora"
DEFINE CELL NAME "ZLD_LJFRET"	    OF oZLD ALIAS "ZLD"
DEFINE CELL NAME "A2_NOME"	        OF oZLD ALIAS "SA2" BLOCK {|| Posicione("SA2",1,xFilial("SA2")+ QRYZL4->ZLD_FRETIS+ QRYZL4->ZLD_LJFRET,"A2_NOME") }

DEFINE SECTION oZLD_1 OF oZLD TITLE "Detalhes" TABLES "ZLD"

DEFINE CELL NAME "ZLD_VEICUL"	    OF oZLD_1 ALIAS "ZL4"  SIZE 12 TITLE "Veiculo"
DEFINE CELL NAME "ZL4_PLACA"	    OF oZLD_1 ALIAS "ZL4"  SIZE 14
DEFINE CELL NAME "ZL4_NOME"	        OF oZLD_1 ALIAS "ZL4"  SIZE 20
DEFINE CELL NAME "ZLD_QTDBOM"	    OF oZLD_1 ALIAS ""    TITLE "Recepcao"       PICTURE "@E 999,999,999.99"  SIZE 18
DEFINE CELL NAME "TOTPESADO"	    OF oZLD_1 ALIAS ""    TITLE "Pesado"         PICTURE "@E 999,999,999.99"  SIZE 18 BLOCK {|| nPeso}
DEFINE CELL NAME "TOTCOLETOR"	    OF oZLD_1 ALIAS ""    TITLE "Coletor"        PICTURE "@E 999,999,999.99"  SIZE 18 BLOCK{|| getTotColetor(QRYZL4->ZL4_CODZX8,QRYZL4->ZLD_FRETIS) }
DEFINE CELL NAME "DIFERENCA"	    OF oZLD_1 ALIAS ""    TITLE "Diferenca" 	 PICTURE "@E 999,999,999.99"  SIZE 18 BLOCK {|| if (lCalcDif,nPeso - QRYZL4->ZLD_QTDBOM,0)  }

oZLD_1:SetTotalInLine(.F.)
oZLD_1:SetLineCondition({|| nPeso := getTotPesado(QRYZL4->ZL4_CODZX8,QRYZL4->ZLD_FRETIS) ,lCalcDif := CalcDif(QRYZL4->ZL4_CODZX8,QRYZL4->ZLD_FRETIS), nPeso+QRYZL4->ZLD_QTDBOM > 0  })


oSumTotRecepcao   := TRFunction():New(oZLD_1:Cell("ZLD_QTDBOM"),NIL,"SUM",NIL)
oSumTotPesado     := TRFunction():New(oZLD_1:Cell("TOTPESADO"),NIL,"SUM",NIL)
oSumTotColetor    := TRFunction():New(oZLD_1:Cell("TOTCOLETOR"),NIL,"SUM",NIL)
oSumTotDiferenca  := TRFunction():New(oZLD_1:Cell("DIFERENCA"),NIL,"SUM",NIL)


oZLD_1:Cell("ZLD_QTDBOM"):SetHeaderAlign("RIGHT")
oZLD_1:Cell("TOTPESADO"):SetHeaderAlign("RIGHT")
oZLD_1:Cell("TOTCOLETOR"):SetHeaderAlign("RIGHT")
oZLD_1:Cell("DIFERENCA"):SetHeaderAlign("RIGHT")



oZLD_1:SetTotalText("SubTotal Transportadora: ")


//oReport:cFontBody := 'Courier New'
oReport:nFontBody := 10
oReport:nLineHeight	:= 50 // Define a altura da linha.


oReport:PrintDialog()

return




/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RGLT043   �Autor  �Microsiga           � Data �  09/09/10   ���
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


//Filtra data de recepcao
if !empty(mv_par01) .and. !empty(mv_par02)
	cFiltro += " AND ZLD.ZLD_DTCOLE BETWEEN '" + dtos(mv_par01) + "' AND '" + dtos(mv_par02) + "' "
endif




cFiltro += "%"

nOrdem := oZLD:GetOrder()

if nOrdem == 1
	//	cOrdem := "% ZLD.A2_NOME %"
else
	//	cOrdem := "% ZLD.A2_COD %"
endif

BEGIN REPORT QUERY oZLD
	BeginSql alias "QRYZL4"
		SELECT
			SUM(ZLD.ZLD_QTDBOM) AS ZLD_QTDBOM,
			ZLD.ZLD_FRETIS,ZLD.ZLD_LJFRET,ZLD.ZLD_VEICUL,
			ZL4.ZL4_NOME,ZL4_CODZX8,ZL4.ZL4_PLACA
		FROM
			%Table:ZLD% ZLD
			JOIN %Table:ZL4% ZL4 ON ZLD.ZLD_VEICUL = ZL4.ZL4_COD
		WHERE
			ZLD.%notDel% AND ZLD.ZLD_FILIAL = %xFilial:ZLD%
			AND ZL4.%notDel% AND ZL4.ZL4_FILIAL = %xFilial:ZL4%
			%exp:cFiltro%
		GROUP BY
			ZLD.ZLD_FRETIS,ZLD.ZLD_LJFRET,ZLD.ZLD_VEICUL,ZL4.ZL4_NOME,ZL4_CODZX8,ZL4.ZL4_PLACA
		ORDER BY
			ZLD.ZLD_FRETIS,ZLD.ZLD_LJFRET
	EndSql
END REPORT QUERY oZLD



oZLD_1:SetParentQuery()
oZLD_1:SetParentFilter({|cParam| QRYZL4->ZLD_FRETIS+QRYZL4->ZLD_LJFRET == cParam},{|| QRYZL4->ZLD_FRETIS+QRYZL4->ZLD_LJFRET})


oZLD:Print(.T.)

return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RGLT043   �Autor  �Microsiga           � Data �  09/15/10   ���
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
/*oZLD_1:Cell("ZLD_TICKET"):SetClrBack(nCor)
oZLD_1:Cell("ZLD_VEICUL"):SetClrBack(nCor)
oZLD_1:Cell("ZL4_PLACA"):SetClrBack(nCor)
oZLD_1:Cell("ZLD_MOTOR"):SetClrBack(nCor)
oZLD_1:Cell("ZL0_NOME"):SetClrBack(nCor)
oZLD_1:Cell("ZLD_DTCOLE"):SetClrBack(nCor)
oZLD_1:Cell("ZLD_TOTBOM"):SetClrBack(nCor)
oZLD_1:Cell("TOTCOLETOR"):SetClrBack(nCor)
oZLD_1:Cell("DIFERENCA"):SetClrBack(nCor)
*/

return


static function getTotColetor(cCaminhao,cFret)
local nRet := 0
local cAlias := "TRBTOTCOLETOR"

if Select(cAlias) > 0
	dbSelectArea(cAlias)
	cAlias->(dbCloseArea())
endif

//Verifica se caminhao eh realmente do transportador
cMotorista := Posicione("ZL4",4,xFilial("ZL4")+cCaminhao,"ZL4_MOTORI")
cFretista  := Posicione("ZL0",1,xFilial("ZLW")+cMotorista,"ZL0_FRETIS")

if cFretista != cFret
	return 0
endif



cFiltro := "% AND ZX1_CAMINH = '" + cCaminhao + "' "
cFiltro += " AND ZX1_DATA BETWEEN '" + Dtos(mv_par01) + "' AND '" + Dtos(mv_par02) + "' %"

BeginSql alias cAlias
	SELECT
	SUM(ZX1_QUANT) AS ZX1_QUANT
	FROM
	%table:ZX1%
	WHERE
	%notDel%
	%exp:cFiltro%
EndSql

nRet := TRBTOTCOLETOR->ZX1_QUANT

return nRet




static function getTotPesado(cCaminhao,cFret)
local nRet := 0
local cAlias := "TRBTOTPESADO"

if Select(cAlias) > 0
	dbSelectArea(cAlias)
	cAlias->(dbCloseArea())
endif

//Verifica se caminhao eh realmente do transportador
cMotorista := Posicione("ZL4",4,xFilial("ZL4")+cCaminhao,"ZL4_MOTORI")
cFretista  := Posicione("ZL0",1,xFilial("ZLW")+cMotorista,"ZL0_FRETIS")

if cFretista != cFret
	return 0
	lCalcDif := .F.
endif

lCalcDif := .T.

cFiltro := "% AND ZX7_CAMINH = '" + cCaminhao + "' "
cFiltro += " AND ZX7_DATA BETWEEN '" + Dtos(mv_par01) + "' AND '" + Dtos(mv_par02) + "' %"

BeginSql alias cAlias
	SELECT
	SUM(ZX7_PCHEIO) AS PCHEIO,SUM(ZX7_PVAZIO) AS PVAZIO
	FROM
	%table:ZX7%
	WHERE
	%notDel%
	%exp:cFiltro%
EndSql

nRet := INT((TRBTOTPESADO->PCHEIO - TRBTOTPESADO->PVAZIO)/1.03)

return nRet


static function getTotEstoque(cVeiculo)
local nRet := 0
local cAlias := "TRBTOTESTOQUE"

if Select(cAlias) > 0
	dbSelectArea(cAlias)
	cAlias->(dbCloseArea())
endif

cFiltro := "% AND ZLD_VEICUL = '" + cVeiculo + "' "
cFiltro += " AND ZLD_DTCOLE BETWEEN '" + Dtos(mv_par01) + "' AND '" + Dtos(mv_par02) + "' %"

BeginSql alias cAlias
	SELECT DISTINCT
	ZLD_TICKET,ZLD_TOTBOM
	FROM
	%table:ZLD%
	WHERE
	%notDel%
	%exp:cFiltro%
EndSql

dbSelectArea(cAlias)
TRBTOTESTOQUE->(dbGoTop())
while TRBTOTESTOQUE->(!eof())
	nRet += TRBTOTESTOQUE->ZLD_TOTBOM
	TRBTOTESTOQUE->(dbSkip())
enddo

return nRet




static function getTotRecepcao(cVeiculo,cFretista,cLjFret)
local nRet := 0
local cAlias := "TRBTOTRECEPCAO"

if Select(cAlias) > 0
	dbSelectArea(cAlias)
	cAlias->(dbCloseArea())
endif

cFiltro := "% AND ZLD_VEICUL = '" + cVeiculo + "' "
cFiltro += " AND ZLD_DTCOLE BETWEEN '" + Dtos(mv_par01) + "' AND '" + Dtos(mv_par02) + "' "
cFiltro += "  AND ZLD_FRETIS = '" + cFretista + "' AND ZLD_LJFRET = '" + cLjFret + "' %"

BeginSql alias cAlias
	SELECT
	SUM(ZLD_QTDBOM) AS TOTRECEPCAO
	FROM
	%table:ZLD%
	WHERE
	%notDel%
	%exp:cFiltro%
EndSql

nRet := TRBTOTRECEPCAO->TOTRECEPCAO


return nRet


static function CalcDif(cCaminhao,cFret)
local lRet := .T.

//Verifica se caminhao eh realmente do transportador
cMotorista := Posicione("ZL4",4,xFilial("ZL4")+cCaminhao,"ZL4_MOTORI")
cFretista  := Posicione("ZL0",1,xFilial("ZLW")+cMotorista,"ZL0_FRETIS")

lRet := cFretista == cFret

return lRet

