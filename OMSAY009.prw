#include "Protheus.ch"

/*/{Protheus.doc} OMSAY009
Função em ADVPL Essa Rotina tem por finalidade permitir a Abertura ou Fechamento de um Carga 
os quais, teve seus processo Indevidamente  Finalizados.
@type function
@version  
@author Rafael.Rigoni
@since 04/05/2023
@return variant, return_description
/*/
User Function OMSAY009()

	Local oSay, oSay1
	Local oFont1 , oFont2
	Local oBotton1, oBotton2
	Local cTexto, cDados
	Private aCarga := {}

	cTexto :="Essa Rotina tem por finalidade permitir a Abertura ou Fechamento de um Carga "
	cTexto += + chr(10) + chr(13) + "             os quais, teve seus processo Indevidamente  Finalizados."

	cDados := "               Informalções: Filial -  "+ DAK_FILIAL + " Carga -  "+ DAK_COD

	oFont1 := TFont()  :New(   ,    , -12,    , .F.                  , , , , , .F.      , .F.)
	oFont2 := TFont()  :New(   ,    , -12,    , .T.                  , , , , , .F.      , .F.)
	oDlg1  := TDialog():New(180, 180, 350, 700, 'Reabertura/Fechametno de Carga', , , , , CLR_BLACK, CLR_WHITE, , , .T.)

	oSay              := TSay():Create(oDlg1)
	oSay:cCaption     := cTexto
	oSay:oFont        := oFont2
	oSay:nLeft        := 30
	oSay:nTop         := 20
	oSay:nWidth       := 500
	oSay:nHeight      := 60

	oSay1             := TSay():Create(oDlg1)
	oSay1:cCaption    := cDados
	oSay1:oFont       := oFont1
	oSay1:nLeft       := 30
	oSay1:nTop        := 65
	oSay1:nWidth      := 300
	oSay1:nHeight     := 30

	oBotton1          := TButton():Create(oDlg1)
	oBotton1:cCaption := "Abertura"
	oBotton1:nLeft    := 150
	oBotton1:nTop     := 100
	oBotton1:nHeight  := 25
	oBotton1:nWidth   := 100
	oBotton1:bAction  :={||OMSAY09A(DAK_FILIAL,DAK_COD)}

	oBotton2          := TButton():Create(oDlg1)
	oBotton2:cCaption := "Fechamento"
	oBotton2:nLeft    := 270
	oBotton2:nTop     := 100
	oBotton2:nHeight  := 25
	oBotton2:nWidth   := 100
	oBotton2:bAction  :={||OMSAY09B(DAK_FILIAL,DAK_COD)}

	oDlg1:ACTIVATE(,,,.T.)

Return

/*/{Protheus.doc} OMSAY09A
Função Utlizada para Realizar o Reabertura  da Carga
@type function
@version  
@author Rafael.Rigoni
@since 04/05/2023
@param _Filial, _Carga
/*/
Static Function OMSAY09A(_Filial,_Carga)

	OMSAY09C()

	If Len(aCarga) > 0
		DbSelectArea('DAK')
		DbSetOrder(1)
		If DAK->(DbSeek(xFilial("DAK")+ _Carga))
			If DAK->DAK_FEZNF = "2"
				MsgInfo("A Carga "+ _Carga+" ja Encontra-se Aberta!","ATENÇÃO")
			Else
				Reclock("DAK",.F.)
				DAK->DAK_FEZNF := "2"
				DAK->(MsUnlock())
				MsgInfo("Reabertura da Carga "+_Carga+" executada com Sucesso.","SUCESSO")
			EndIf
		EndIf
		oDlg1:End()
	Else
		MsgInfo("A Carga "+ _Carga+" não pode ser Aberta!"+chr(10)+chr(13) + "Não existem pedidos em Aberto para serem Faturados.","ATENÇÃO")
		oDlg1:End()
	EndIF

Return

/*/{Protheus.doc} OMSAY09B
Função Utlizada para Realizar o Fechamento da Carga
@type function
@version  
@author Rafael.Rigoni
@since 04/05/2023
@param _Filial, _Carga
/*/

Static Function OMSAY09B(_Filial,_Carga)

	Local cLog := "A Carga "+ _Carga+" não pode ser Fechada!"
	Local nx := 0
	Local cId 	     := StrZero(1,3)

	OMSAY09C()

	cLog += chr(10)+chr(13) + "Os pedidos Abaixo encontra-se em Aberto"

	If Len(aCarga)> 0
		For nx := 1 to len(aCarga)
			cLog += chr(10)+chr(13) + cId + "-" + aCarga[nx][1]+"-"+ aCarga[nx][3]
			cId:= Soma1(cId)
		Next
		cLog += + chr(10)+chr(13) + "Favor Realize o Faturamento."
		MsgInfo(cLog,"ATENÇÃO")
		oDlg1:End()
	Else
		DbSelectArea("DAK")
		DbSetOrder(1)
		If DAK->(DbSeek(xFilial("DAK")+ _Carga))
			RecLock("DAK",.F.)
			DAK->DAK_FEZNF ='1'
			DAK->(MsUnlock())
			MsgInfo("Fechamento da Carga "+ _Carga + " Realizado com Sucesso","SUCESSO")
		EndIf	
		oDlg1:End()
	EndIf


Return

/*/{Protheus.doc} OMSAY09C
Responsável pela execulçao da SQL Gravando as informações no Array aCarga
Onde sera itualizado como base para validações.
@type function
@version  
@author Rafael.Rigoni
@since 04/05/2023
/*/
Static Function OMSAY09C()

	Local cAliasCarg := GetNextAlias()

	BeginSQL Alias cAliasCarg

		SELECT
			DAI_FILPV,
			DAI_COD,
			DAI_PEDIDO
		FROM %Table:DAI% DAI
		WHERE 
			DAI_FILIAL = %Exp:xFilial("DAK")%
			AND DAI_COD =%Exp:DAK->DAK_COD%
			AND DAI_NFISCA =' '	
			AND DAI.%NotDel%
		ORDER BY DAI_PEDIDO
	ENDSQL

	While (cAliasCarg)->(!EOF( ))
		aAdd(aCarga,{(cAliasCarg)->DAI_FILPV,(cAliasCarg)->DAI_COD,(cAliasCarg)->DAI_PEDIDO})
		(cAliasCarg)->(DbSkip())
	Enddo
	(cAliasCarg)->(DBCloseArea())

Return
