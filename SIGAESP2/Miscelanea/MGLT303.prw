#INCLUDE "PROTHEUS.CH"

#DEFINE _ENTER CHR(13)+CHR(10)
/*/
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  � MGLT303  � Autor � TOTVS                 � Data da Criacao  � 01/06/2016                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Rec�lculo do custo do leite na tabela SD3.                                                                   ���
���          �                     												                               				���
���������������������������������������������������������������������������������������������������������������������������͹��
���Uso       � Gestao do Leite                 						                                                        ���
���������������������������������������������������������������������������������������������������������������������������͹��
���Parametros� Nenhum						   							                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Retorno   � Nenhum						  							                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Usuario   � Microsiga                                                                                					���
���������������������������������������������������������������������������������������������������������������������������͹��
���Setor     � Gestao do Leite.                                                                        						���
���������������������������������������������������������������������������������������������������������������������������͹��
���            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Autor     � Data     � Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor        ���
���������������������������������������������������������������������������������������������������������������������������ĺ��
���          �00/00/0000�                               				   �00-000000 -                       � TI	        ���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���          �          �                    							   �                                  � 			���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���������������������������������������������������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
/*/

User Function MGLT303()

Local _cPerg  := "MGLT303"
Local _bProcess := {|oSelf| Recalculo(oSelf) }

Private _cDtIni := ""
Private _cDtFim	:= ""
Private _cMix	:= ""

cTexto := "Esta rotina tem o objetivo de refazer o custo das movimenta��es do leite "+_ENTER
cTexto += "lan�adas pela rotina de recep��o do leite. "+_ENTER
cTexto += "Cada ticket lan�ado gera um movimento de entrada valorizado na tabela SD3, "+_ENTER
cTexto += "este movimento ser� recalculado baseado no pre�o pago aos produtores de cada"+_ENTER
cTexto += "ticket. A rotina deve ser executada antes do fechamento do estoque, portanto "+_ENTER
cTexto += "a data inicial do MIX informado nos parametros deve ser maior que o MV_ULMES. "+_ENTER
cTexto += " "+_ENTER

If Pergunte(_cPerg, .T.)
	DbSelectArea("ZLE")
	DbSetOrder(1)
	DbSeek(xFilial("ZLE")+MV_PAR01)
	_cDtIni := DTOS(ZLE->ZLE_DTINI)
	_cDtFim	:= DTOS(ZLE->ZLE_DTFIM)
	_cMix	:= MV_PAR01


	If ZLE->ZLE_DTINI <= GetMv("MV_ULMES")
		MsgStop("Data inicial tem que ser maior que a data do �ltimo fechamento de m�s.")
	Else
		_oTProces := tNewProcess():New("MGLT303","Recalculando custo do leite...",_bProcess,cTexto,_cPerg)
	EndIf
EndIf

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Recalculo �Autor  �Microsiga           � Data �  10/27/15   ���
�������������������������������������������������������������������������͹��
���Desc.     � Processamento do rec�lculo do custo do leite.              ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function Recalculo(oObj)

Local _cAlias := GetNextAlias()
Local _cAlias2 := "X"+GetNextAlias()
Local _cCustoLt := 0
Local _nCont := 1
Private _cFilter := ""
Private _cTicket := ""
Private _nVlrFrete := 0
Private _nQtdTkt := 0
Private _nQtdSD1 := 0
Private _cEveInss := AllTrim(GETMV("LT_EVEINSS"))

BeginSql Alias _cAlias

	SELECT ZLD_TICKET, ZLD_FRETIS,ZLD_LJFRET,
	SUM(ZLD_QTDBOM) AS QTD

	FROM %Table:ZLD% ZLD


	WHERE ZLD_FILIAL = %xFilial:ZLD%
	AND ZLD_DTCOLE BETWEEN %Exp:_cDtIni% AND %Exp:_cDtFim%
	AND ZLD.%NotDel%

	GROUP BY ZLD_TICKET,ZLD_FRETIS,ZLD_LJFRET

EndSql

dbSelectArea(_cAlias)
(_cAlias)->(dbGoTop())
Count To _nReg
(_cAlias)->(DbGoTop())

While !(_cAlias)->(Eof())

	_cTicket := (_cAlias)->ZLD_TICKET
	_nQtdTkt := (_cAlias)->QTD

	BeginSql alias _cAlias2

		SELECT LF.ZLF_F1SEEK, LD.ZLD_QTDBOM AS QTD
		FROM %Table:ZLF% LF
			JOIN %Table:ZLD% LD ON ZLD_FILIAL = %xFilial:ZLD%  AND LD.ZLD_RETIRO = LF.ZLF_A2COD AND LD.ZLD_RETILJ = LF.ZLF_A2LOJA
			AND LD.ZLD_TICKET = %Exp:_cTicket% AND LD.%NotDel%
		WHERE ZLF_FILIAL = %xFilial:ZLF% //Alterado para considerar filial - Godinho
		AND ZLF_CODZLE = %Exp:_cMix%
		AND ZLF_SEQ = '001'
		AND ZLF_ORIGEM = 'M'
		AND LF.%NotDel%

	EndSql

	DbSelectArea(_cAlias2)
	(_cAlias2)->(DbGoTop())
	Count To _nReg
	(_cAlias2)->(DbGoTop())

	_cCustoLt := 0

	While !(_cAlias2)->(Eof())
		DbSelectArea("SD1")
		SD1->(DbSetOrder(1)) //D1_FILIAL, D1_DOC, D1_SERIE, D1_FORNECE, D1_LOJA, D1_COD, D1_ITEM, R_E_C_N_O_, D_E_L_E_T_
		If SD1->(DbSeek(SubStr((_cAlias2)->ZLF_F1SEEK,1,24))) //0102000006258002P0000301N
			_cCustoLt += (SD1->D1_CUSTO / SD1->D1_QUANT) * (_cAlias2)->QTD
			_nQtdSD1 += SD1->D1_QUANT
		EndIf
		(_cAlias2)->(DbSkip())
	EndDo

	(_cAlias2)->(DbCloseArea())

	//Busca custo do frete lan�ado na tabela ZLP
	_nVlrFrete := 0

	oObj:IncRegua1("Processando "+AllTrim(Str(_nCont))+" de "+AllTrim(Str(_nReg))+" ("+AllTrim(str( round((_nCont/_nReg)*100,0) ))+"%) - Ticket: " + _cTicket)
	_nCont++
	Begin Transaction

	MsgRun("Aguarde... Calculando custo do leite. ticket : " + (_cAlias)->ZLD_TICKET ,,{||CursorWait(), SD3Recalc((_cAlias)->ZLD_TICKET, _cCustoLt) , CursorArrow()})

	End Transaction

	(_cAlias)->(dbSkip())

EndDo

dbSelectArea(_cAlias)
(_cAlias)->(dbCloseArea())

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AGLT301   �Autor  �Microsiga           � Data �  10/27/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static function SD3Recalc(_pcTicket, _pnCusto)

Local _aArea     	:= GetArea()
Local _cAliasSD3	:= GetNextAlias()
Local _cTicket   	:= 'GLT'+_pcTicket
Local _cTm       	:= ALLTRIM(GetMv("LT_ENTTM"))

BeginSql Alias _cAliasSD3

	SELECT
	D3_FILIAL, D3_TM, D3_COD, D3_UM, D3_QUANT, D3_LOCAL, D3_EMISSAO, D3_DOC, D3_LOTECTL,
	D3_DTVALID, D3_L_ORIG, D3_L_SETOR, D3_CUSTO1,
	D3_NUMSEQ, D3_CHAVE, D3_CF, R_E_C_N_O_ AS NUMREC

	FROM %Table:SD3% SD3

	WHERE D3_FILIAL = %xFilial:SD3%
	AND   D3_TM = %Exp:_cTm%
	AND   D3_DOC = %Exp:_cTicket%
	AND   D3_ESTORNO <> 'S'
	AND   SD3.%NotDel%

EndSql

dbSelectArea(_cAliasSD3)
(_cAliasSD3)->(dbGoTop())

While !(_cAliasSD3)->(Eof())


	DbSelectArea("SD3")
	SD3->(DbGoto((_cAliasSD3)->NUMREC))
    RecLock("SD3",.F.)
    SD3->D3_CUSTO1 := _pnCusto
    SD3->(MsUnlock())


	(_cAliasSD3)->(dbSkip())

EndDo

dbSelectArea(_cAliasSD3)
(_cAliasSD3)->(dbCloseArea())

RestArea(_aArea)

Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CustoFrete�Autor  �Microsiga           � Data �  12/06/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �  Retorna o custo do frete lan�ado na tabela ZLP            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CustoFrete(xcCod,xcLoja)

Local _nRet := 0

If Select("FRET") <> 0
	FRET->(dbCloseArea())
EndIf

BeginSql alias "FRET"
	SELECT ZM1_FILIAL AS FILIAL, ZM0_MIX, ZM0_CODSA2, ZM0_LOJSA2, ZM0_TOTPRD,
	SUM(CASE WHEN ZM1_DEBCRE = 'C' THEN ZM1_VLRTOT ELSE -ZM1_VLRTOT END) AS VALOR,
    SUM(CASE WHEN ZM1_DEBCRE = 'C' THEN ZM1_VLRTOT ELSE -ZM1_VLRTOT END)/ ZM0_TOTPRD AS CUSTO
	FROM %Table:ZM1% ZM1
		JOIN %Table:ZM0% ZM0 ON ZM0_FILIAL = ZM1_FILIAL AND ZM0_MIX = ZM1_MIX AND ZM0_CODSA2 = ZM1_CODSA2
			AND ZM0_LOJSA2 = ZM1_LOJSA2 AND ZM0.%NotDel%
	WHERE ZM1_MIX = %Exp:_cMix%
	AND ZM1_CODSA2 = %Exp:xcCod%
	AND ZM1_LOJSA2 = %Exp:xcLoja%
	AND ZM1.%NotDel%
	GROUP BY ZM1_FILIAL, ZM0_MIX, ZM0_CODSA2, ZM0_LOJSA2, ZM0_TOTPRD
EndSql

DbSelectArea("FRET")
FRET->(DbGoTop())

If !FRET->(Eof())
	_nRet := FRET->CUSTO
EndIf

Return _nRet

