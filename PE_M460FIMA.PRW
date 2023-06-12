#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"


User Function M460FIMA(_Filial, _cDoc, _Serie, _cCliente, _cLoja)

	Local _cCond := SuperGetMV("LT_CPLEITE")

	//Se a condição de pagamento utilizada na NF estiver cadastrada para a forma de pagamento LT = Leite, ira gravar o campo E1_L_EVENT

	DbSelectArea("SF2")
	DbSetOrder(1)
	If DbSeek(xFilial("SF2")+_cDoc+_Serie+_cCliente+_cLoja)
		If SF2->F2_COND $ Alltrim(_cCond)

			DbSelectArea("SD2")
			DbSetOrder(3) //D2_FILIAL, D2_DOC, D2_SERIE, D2_CLIENTE, D2_LOJA, D2_COD, D2_ITEM, R_E_C_N_O_, D_E_L_E_T_
			SD2->(MsSeek(SF2->F2_FILIAL+SF2->F2_DOC+SF2->F2_SERIE+SF2->F2_CLIENTE))

			//Grava código de evento na tabela SE1
			SE1GrvEvent(SF2->F2_FILIAL, SF2->F2_SERIE, SF2->F2_DOC, SF2->F2_CLIENTE, SF2->F2_LOJA, SD2->D2_LOCAL)
		EndIf
	EndIf

Return

Static Function SE1GrvEvent(_cFilial, _cSerie, _cDoc, _cCliente, _cLoja, _cLocal)

	Local _aArea   := GetArea()
	Local _cEvento	:= "2000"+Alltrim(_cFilial)
	Local _cHist := ""
	Local _cAlias := GetNextAlias()
	Local _cAliasE1 := GetNextAlias()
	Local _cParc := ""
	Local _nParc := 0


	DbSelectArea("ZL8")
	DbSetOrder(1)
	If ZL8->(MsSeek(xFilial("ZL8")+_cEvento))
		_cHist := "COMPRA "+Alltrim(ZL8->ZL8_NREDUZ)+" PARCELA"

	Else
		MsgAlert("Não foi encontrato Evento com o código: "+_cEvento+" no cadastro de eventos do GLT!"+_ENTER;
		+"Esta venda NÃO será descontada no conta-corrente!"+_ENTER;
		+"Informe imediatamente ao setor de TI e setor Financeiro para que efetuem o cadastro!!!","### ATENÇÃO!!!")
		Return
	EndIf

	//Busca quantidade de parcelas para gravar no E1_HIST
	BeginSql alias _cAlias
		SELECT COUNT(E1_NUM) PARC FROM %Table:SE1% E1
		WHERE E1_FILIAL = %Exp:_cFilial%
		AND E1_PREFIXO = %Exp:_cSerie%
		AND E1_NUM = %Exp:_cDoc%
		AND E1_CLIENTE = %Exp:_cCliente%
		AND E1_LOJA = %Exp:_cLoja%
		AND E1.%NotDel%
	EndSql

	DbSelectArea(_cAlias)
	(_cAlias)->(DbGoTop())
	_nParc := (_cAlias)->PARC
	_cParc := StrZero(_nParc,2) //Numero maximo de parcelas

	(_cAlias)->(DbCloseArea())

	BeginSql alias _cAliasE1
		SELECT R_E_C_N_O_ AS RECSE1
		FROM %Table:SE1% E1
		WHERE E1_FILIAL = %Exp:_cFilial%
		AND E1_PREFIXO = %Exp:_cSerie%
		AND E1_NUM = %Exp:_cDoc%
		AND E1_CLIENTE = %Exp:_cCliente%
		AND E1_LOJA = %Exp:_cLoja%
		AND E1.%NotDel%
	EndSql


	While !(_cAliasE1)->(Eof())
		DbSelectArea("SE1")
		DbGoTo((_cAliasE1)->RECSE1)
		RecLock("SE1",.F.)
		SE1->E1_L_EVENT := _cEvento //Grava evento do leite para classificar o debito.
		SE1->E1_HIST	:= _cHist+" "+SE1->E1_PARCELA+"/"+_cParc
		SE1->(MsUnLock())
		(_cAliasE1)->(DbSkip())
	EndDo
	(_cAliasE1)->(DbCloseArea())

	RestArea(_aArea)

Return
