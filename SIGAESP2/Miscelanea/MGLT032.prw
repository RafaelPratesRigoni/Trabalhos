#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#include "rwmake.ch"
#INCLUDE "MSGRAPHI.ch"

#DEFINE _ENTER CHR(13)+CHR(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ MGLT032  บ Autor ณ TOTVS                 บ Data da Criacao  ณ 17/07/2014                						บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina de acerto financeiro dos Produtores. Realiza baixa dos debitos compensando com o credito do leite.    บฑฑ
ฑฑบ          ณ                        									                               				        บฑฑ
ฑฑบ          ณ                        									                               				        บฑฑ
ฑฑบ          ณ                        									                               				        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Fechamento do Leite.            						                                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ Nenhum						   							                               						บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ Nenhum						  							                               						บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUsuario   ณ Microsiga                                                                                					บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบSetor     ณ Gestao do Leite.                                                                        						บฑฑ
ฑฑฬออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                   						บฑฑ
ฑฑฬออออออออออัออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออัออออออออออออออออออออออออออออออออออัอออออออออออออนฑฑ
ฑฑบAutor     ณ Data     ณ Motivo da Alteracao  				               ณUsuario(Filial+Matricula+Nome)    ณSetor        บฑฑ
ฑฑบฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤบฑฑ
ฑฑบ          ณ          ณ                                                  ณ                                  ณ   	        บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑบ          ณ          ณ                    							   ณ                                  ณ 			บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑศออออออออออฯออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออออออออออออออออออออออออออออออฯอออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function MGLT032(xCodMIX,xProd,xLoja,xObj)

	Local _bProcess		:= {|oSelf| FechFin(oSelf)}
	Local cTexto
	Private _cPerg		:= "MGLT032"
	Private cGLTalias 		:= GetNextAlias() //"GLT"
	Private cHoraInicial 	:= TIME()
	Private _lAuto := .f.
	Private _nTotDebito := 0
	Private _cLojaaut := ""
	Private _lGeraFin := SuperGetMV("LT_CONVFIN",,.T.) //Indica se o conv๊nio jแ deve gerar os tํtulos no financeiro, ou se isso ocorrerแ no Acerto do Leite, apenas com valor que o produtor pode pagar no m๊s, controlando pelo campo ZLL_VLRPAG.
	Private _cTipoTit := PADR(Alltrim(GetMv("LT_CONVTIP")),3)
	DEFAULT xCodMIX := ""

	If !Empty(xCodMIX)

		Pergunte(_cPerg,.F.)
		MV_PAR01 := xCodMIX
		mv_par02 := xProd
		mv_par03 := xProd
		mv_par04 := "      "
		mv_par05 := "ZZZZZZ"
		_cLojaaut := xLoja
		_lAuto := .t.
	EndIf
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Chama a tela para preenchimento dos parametros.                     ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If !_lAuto
		If !Pergunte(_cPerg,.T.)
			Return()
		EndIf
	EndIf
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Verifica se o usuario tem permissao para executar a rotina de Eventos.ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If Posicione("ZLU",1,xFilial("ZLU")+Padr(cUserName,25),"ZLU_ACERTO") != "S"
		xMagHelpFis("Permissao","Voce nao tem permissao para acessar essa rotina!","Comunique ao Suporte!")
		Return
	EndIf

	cTexto := "Esta rotina tem o objetivo de efetuar o Fechamento Financeiro dos Produtores."+_ENTER
	cTexto += "Por favor preencha os parยmetros da rotina antes de executar."+_ENTER
	cTexto += " "+_ENTER

	If !_lAuto
		_oTProces := tNewProcess():New("MGLT032","Fechamento Financeiro dos Produtores",_bProcess,cTexto,_cPerg)
	Else
		FechFin(xObj)
	EndIf

Return _nTotDebito


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณ FechFin  ณ Autor ณMicrosiga              ณ Data ณ 00.00.00 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ Funcao para realizar o Acerto dos Eventos Avulsos.         ณฑฑ
ฑฑณ          ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ 									                  		  ณฑฑ
ฑฑณ          ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ MGLT029()                                                  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FechFin(oObj)

	Local cFunc 	 := "1"
	Local cArqTmp  := cGLTalias+cFunc
	Local nCont    := 1
	Local cxForn
	Local cxLoja
	Local aStruct := {}
	Local _nTamFil    := TamSx3("A2_FILIAL")[1]
	Local _nTamFor    := TamSx3("A2_COD")[1]
	Local _nTamLoj    := TamSx3("A2_LOJA")[1]
	Local _lAglutina := SuperGetMV("LT_AGLUTINA",,.F.) //Parametro que indica se o sistema devera gerar titulos aglutinados de creditos e debitos
	Local nProd
	Local oTempTable	:= Nil
	Private _cMotBaixa := AllTrim(GETMV("LT_MOTBX"))  //Motivo de baixa utilizado para a rotina do Leite
	Private _cEveCred := AllTrim(SuperGETMV("LT_EVECRED",,"300001")) //Evento utilizado no titulo aglutinado de credito
	Private _cEveDeb := AllTrim(SuperGETMV("LT_EVEDEB",,"300002")) //Evento utilizado no titulo aglutinado de debito
	Private lContinue 	:= .T.
	Private lDeuErro	:= .F.
	Private _cEveFunr := AllTrim(GetMv("LT_EVEINSS")) //Codigo do evento de INSS (Funrural)
	Private _cMes := ""
	Private _cAno := ""
	Private _nReg
	Private _cVencto  	:= "" //Dia de vencimento dos titulos
	Private cCodMIX := MV_PAR01
	Private _cProdDe  	:= mv_par02
	Private _cProdAte 	:= mv_par03
	Private _cGrpDe  	:= mv_par04
	Private _cGrpAte 	:= mv_par05
	Private _cLojaDe 	:= mv_par06
	Private _cLojaAte 	:= mv_par06
	Private _cSetor := ""
	Private _dDtBaixa := dDataBase
	Private _cMaxEmis	:= ""//DTOS(LASTDAY(ADDMES(DDATABASE,-1)))
	Private _aCred := {}
	Private _lGrvCred := .T.
	Private _lGrvDeb := .T.
	Private _cNumTit := ""
	Private _dBkpDtBa := dDataBase

	dbSelectArea("ZLE")
	ZLE->(dbSetOrder(1))
	If ZLE->(dbSeek(xFilial("ZLE")+cCodMIX))

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Verifica se a database do sistema esta com o ultimo dia do mes. ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		//If LastDay(ZLE->ZLE_DTFIM) != dDataBase
		If ZLE->ZLE_DTFIM != dDataBase
			xMagHelpFis("NAO CONFORMIDADE 02 - DATABASE INVALIDA",;
			"A data do sistema("+DTOC(dDataBase)+") nao esta no ultimo dia do mes!",;
			"Altere a data do sistema para "+DTOC(LastDay(ZLE->ZLE_DTFIM)) )
			Return()
		EndIf

		_cMes := Month2Str(ZLE->ZLE_DTFIM) //Retorna o mes no formato MM
		_cAno := Year2Str(ZLE->ZLE_DTFIM) //Retorna o ano no formado AAAA
		_cMaxEmis	:=	DTOS(ZLE->ZLE_DTFIM	)


	Else
		xMagHelpFis("NAO CONFORMIDADE 09 - MIX nao encontrado.",;
		"O MIX informado nos parใmetros nใo foi encontrado!",;
		"Escolha um c๓digo de MIX que exista.")
		Return()
	EndIf

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Cria Tabela temporaria para relacao        ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If Select("TRF") <> 0
		TRF->(dbCloseArea())
	EndIf

	AAdd(aStruct,{"TRF_FILIA"  ,"C",_nTamFil, 0})
	AAdd(aStruct,{"TRF_FORN"   ,"C",_nTamFor, 0})
	AAdd(aStruct,{"TRF_LOJA"   ,"C",_nTamLoj, 0})
	AAdd(aStruct,{"TRF_VALOR"  ,"N",14,2})

	oTempTable := FwTemporaryTable():New("TRF", aStruct)
	oTempTable:AddIndex("IDX1", {"TRF_FILIA", "TRF_FORN", "TRF_LOJA"})
	oTempTable:Create()

	MGLTQRY(cFunc)
	nProd	:=	_nReg

	//*********************************
	// Grava dados da SA2 na TRF
	//*********************************
	dbSelectArea(cArqTmp)
	dbGoTop()
	While (cArqTmp)->(!Eof())
		dbSelectArea("TRF")
		RecLock("TRF",.T.)

		TRF->TRF_FILIA := xFilial("ZLF")
		TRF->TRF_FORN  := (cArqTmp)->A2_COD
		TRF->TRF_LOJA  := (cArqTmp)->A2_LOJA
		TRF->TRF_VALOR := 0

		MsUnlock()

		(cArqTmp)->(dbSkip())
	EndDo
	(cArqTmp)->(dbCloseArea())

	dbSelectArea("TRF")
	TRF->(dbGoTop())

	oObj:SetRegua1(nProd)

	PutMV("MV_ANTCRED","T") //Utilizada para permitir baixa de titulo a receber com data de cr้dito menor que data de emissีo.

	While TRF->(!Eof())

		cxForn  := TRF->TRF_FORN
		cxLoja	:= TRF->TRF_LOJA

		_cNumTit :=	GeraNumTit(cxForn,cxLoja)//IIF(Alltrim((cArqTmp1)->ORIGEM) == "MATA100",(cArqTmp1)->NUM,_cNumTit)
		Begin Transaction

		dbSelectArea("SA2")
		SA2->(dbSetOrder(1))
		If SA2->(dbSeek(xFilial("SA2")+cxForn+cxLoja))

			If Empty(SA2->A2_L_LI_RO)
				xMagHelpFis("NAO CONFORMIDADE - Grupo Pre็o",;
				"O produtor nใo estแ configurado em nenhum grupo de pre็o.",;
				"Preencha o grupo de pre็o no cadastro do produtor antes de continuar.")
				lDeuErro := .T.
			Else
				DbSelectArea("ZL3")
				DbSetOrder(1)
				DbSeek(xFilial("ZL3")+SA2->A2_L_LI_RO)
				_cSetor := ZL3->ZL3_SETOR
				DbSelectArea("ZL2")
				ZL2->(DbSetOrder(1))
				ZL2->(MsSeek(xFILIAL("ZL2") + _cSetor))

				_cVencto := MonthSum(ZLE->ZLE_DTFIM,1) //Solicitado na Coopeavi, pegar todos os tํtulos com vencimento no m๊s de pagamento do leite
				_cVencto := DTOS(_cVencto)
				_dDtBaixa :=  SubStr(_cVencto,1,6)+StrZero(Val(ZL2->ZL2_DIABX),2)//ZLE->ZLE_DTFIM //DataValida(Condicao(1000,ZL2->ZL2_CONDPG)[1][1])
				_dDtBaixa := STOD(_dDtBaixa)

				If oObj <> Nil  .and. !_lAuto
					oObj:IncRegua1("Produtor "+AllTrim(Str(nCont))+" de "+AllTrim(Str(nProd))+" ("+AllTrim(str( round((nCont/nProd)*100,0) ))+"%) - " + SA2->A2_COD +"/"+SA2->A2_LOJA +" - "+SA2->A2_NOME)
				Else
					oObj:IncRegua1("Fechamento Financeiro: " + SA2->A2_COD +"/"+SA2->A2_LOJA +" - "+SA2->A2_NOME)
				EndIf

				_lGrvCred := .T.
				_lGrvDeb := .T.

				If !lDeuErro
					ActFin(oObj)
				EndIf

				If _lAglutina //Se for aglutinar debitos e creditos executa as funcoes
					If !lDeuErro
						AglutinaCred(oObj) //Aglutina creditos (Baixa os titulos NF do SE2, NCC do SE1 e gera um tํtulo unico de credito)
					EndIf
				EndIf

				If !lDeuErro
					FlagZLF(oObj)  // Grava o campo ZLF_FINOK como "S" indicando que o fechamento financeiro foi executado.
				EndIf

				If !lDeuErro
					FlagSE5()  // Grava o campo E5_L_SEEK com c๓digo do mix, indicando que foi baixado por este fechamento
				EndIf

				If !lDeuErro .and. !_lAuto
					AtualizaSld(oObj) //Grava dados do fechamento na tabela ZLV
				EndIf
			EndIf

		Else //Seek na SA2
			xMagHelpFis("NAO CONFORMIDADE 01 - Nao existe Produtor",;
			"Produtor "+AllTrim(cxForn+cxLoja)+" nใo existe no cadastro!",;
			"Nao sera gerado Acerto para esse produtor. Verifique o c๓digo do produtor no o cadastro!","Alerta")

			_lDeuErro := .T.
		EndIf //Seek na SA2

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Se houve alguma falha, desfaz todas as transacoes.ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If lDeuErro
			lContinue := .F.
			DisarmTransaction()
			lDeuErro := .F.
		EndIf

		End Transaction

		If !lContinue
			If MsgYesNo("Ocorreram nใo conformidades no processo. Deseja continuar a rotina?")
				lContinue:=.T.
			Else
				exit
			EndIf
		EndIf

		TRF->(dbSkip())
		nCont++

	EndDo

	PutMV("MV_ANTCRED","F") //Utilizada para permitir baixa de titulo a receber com data de cr้dito menor que data de emissีo.

	oTempTable:Delete()

	If !_lAuto
		oObj:SaveLog("FIM - Fechamento Financeiro")
		MsgInfo("Tempo gasto no processamento:"+ELAPTIME(cHoraInicial,TIME()))
	Else
		Return lContinue
	EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณActFin    ณ Autor ณMicrosiga              ณ Data ณ 00.00.00 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ Funcao para realizar Acerto Financeiro.				      ณฑฑ
ฑฑณ          ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ ExpO01 - Objeto da Regua de processamento.                 ณฑฑ
ฑฑณ          ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ MGLT032()                                                  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ActFin(oObj)

	Local cFunc := "2"
	Local cFunc2 := "3"
	Local cArqTmp1 := cGLTalias+cFunc
	Local cArqTmp2 := cGLTalias+cFunc2
	Local _aArea   := {}
	Local _aAlias  := {}
	Local nTotReg  := 0
	Local nCont    := 1
	Local _cHistBaixa := ""
	Local nJurTit := 0
	Local nSldTit := 0
	Local _nSldCred := 0
	Local _nVlrZLL := 0
	Local nVlrBx := 0
	Local nTotBai := 0
	Local _dBkpDtBa := dDataBase
	Local lRetorno := .T.
	Local _nMulta := 0

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ  Salva a area. ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	CtrlArea(1,@_aArea,@_aAlias,{"SA2","SB1","SX1"})

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Atualiza o log de processamento   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oObj:SaveLog("INICIO - Busca Creditos - "+SA2->A2_COD +"/"+SA2->A2_LOJA)

	MGLTQRY(cFunc)

	MGLTQRY(cFunc2)

	dbSelectArea(cArqTmp1)
	(cArqTmp1)->(dbGoTop())


	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Atualiza a regua de processamento.ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If oObj <> Nil
		nTotReg := _nReg
		nCont   := 1
		oObj:SetRegua2(nTotReg)
	EndIf

	dbSelectArea(cArqTmp2)
	dbGoTop()


	While (cArqTmp1)->(!Eof()) .and. !lDeuErro

		//Busca saldo do cr้dito a baixar.
		_nSldCred := (cArqTmp1)->SALDO + (cArqTmp1)->SDACRES - (cArqTmp1)->SDDECRE

		_cHistBaixa := "GLT "+_cMes+"/"+_cAno+" "+(cArqTmp1)->PREFIXO + (cArqTmp1)->NUM + (cArqTmp1)->PARCELA


		While (cArqTmp2)->(!Eof()) .and. _nSldCred > 0

			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Atualiza a regua de processamento.ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			If oObj <> Nil
				oObj:IncRegua2("Financeiro - Tarefa "+AllTrim(Str(nCont))+" de "+AllTrim(Str(nTotReg)))
				nCont++
			EndIf

			If !_lGeraFin //Se nใo gera tํtulo ao lan็ar conv๊nio

				If (cArqTmp2)->TIPOTIT == "ZLL"

					dbSelectArea("ZL8")
					ZL8->(dbSetOrder(1))
					ZL8->(dbSeek(xFilial("ZL8")+(cArqTmp2)->EVENTO)) //Posiciona no evento

					If ZL8->ZL8_TPDESC ==  "2" //Gera tํtulo somente do saldo que o produtor tem de cr้dito
						_nVlrZLL := IIF(_nSldCred > (cArqTmp2)->SALDO, (cArqTmp2)->SALDO , _nSldCred) //Gera tํtulo no valor que o produtor puder pagar.
					Else // Gera tํtulo no total da dํvida.
						_nVlrZLL := (cArqTmp2)->SALDO //Gera tํtulo no valor total
					EndIf


					If !U_IncluSE1((cArqTmp2)->PREFIXO, (cArqTmp2)->NUM,(cArqTmp2)->PARCELA, (cArqTmp2)->TIPO ,(cArqTmp2)->A2COD,(cArqTmp2)->A2LOJA,ZL8->ZL8_NATPRD,STOD(_cMaxEmis),STOD((cArqTmp2)->VENCTO),_nVlrZLL,0,0,"",(cArqTmp2)->HIST,0,ZL8->ZL8_COD,"MGLT032",_cAno+_cMes,xFilial("SF2"),cCodMix)
						xMagHelpFis("NAO CONFORMIDADE GERA TITULO",;
						"Nใo foi possํvel incluir o titulo de conv๊nio do produtor "+_ENTER+SA2->A2_COD+" "+SA2->A2_NOME,;
						"Conv๊nio "+(cArqTmp2)->NUM+" "+(cArqTmp2)->HIST + _ENTER + "R$ "+TransForm((cArqTmp2)->SALDO,"@E 999,999,999.99"))

						lDeuErro := .T.
					Else
						//Grava tํtulo gerado na ZLF
						cSeek := (cArqTmp2)->FILIAL+(cArqTmp2)->PREFIXO+(cArqTmp2)->NUM+(cArqTmp2)->PARCELA+(cArqTmp2)->TIPO+(cArqTmp2)->A2COD+(cArqTmp2)->A2LOJA+SA2->A2_LOJA

						U_GrvZLF(cCodMIX,(cArqTmp2)->EVENTO,(cArqTmp2)->SALDO,cSeek,"","","","D",(cArqTmp2)->SALDO,(cArqTmp2)->SALDO,(cArqTmp2)->VENCTO,;
						(cArqTmp2)->HIST,0,0,SA2->A2_COD,SA2->A2_LOJA,(cArqTmp2)->PREFIXO,(cArqTmp2)->NUM,(cArqTmp2)->PARCELA,(cArqTmp2)->TIPO,(cArqTmp2)->A2LOJA,.T.)

						//Atualiza no conv๊nio o valor que serแ pago do mesmo.
						DbSelectArea("ZLL")
						DbSetOrder(1)
						If MsSeek((cArqTmp2)->FILIAL+(cArqTmp2)->NUM)
							RecLock("ZLL",.F.)
							ZLL->ZLL_VLRPAG := _nVlrZLL
							If ZLL->ZLL_VALOR == _nVlrZLL
								ZLL->ZLL_STATUS := 'P'
							Else
								ZLL->ZLL_STATUS := 'S'
							ENDIF
							ZLL->(MsUnLock())
						EndIf
					EndIf
				EndIf
			EndIf

			dbSelectArea("SE1")
			SE1->(dbSetOrder(1))//E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
			If SE1->(dbSeek((cArqTmp2)->FILIAL + (cArqTmp2)->PREFIXO + (cArqTmp2)->NUM +(cArqTmp2)->PARCELA + (cArqTmp2)->TIPO ))
				Reclock("SE1", .F.)
				SE1->E1_DESCFIN := 0
				SE1->E1_DIADESC := 0
				SE1->(MsUnLock())

				nVlrBx  := 0
				nSldTit := 0
				nJurTit := 0
				_nMulta := 0

				If _nSldCred > 0
					IF  SE1->E1_FILIAL = '47' .AND. SE1->E1_PREFIXO = 'VEZ' .AND. SE1->E1_TIPO = 'INT'
						nJurTit := 0
						
					ELSE 
						If SE1->E1_VENCREA < _dDtBaixa //.and. SE1->E1_L_EVENT <> '100001' //Titulos com evento de Capital nใo podem ter cobran็a de juros.
							_dBkpDtBa := dDataBase
							dDataBase := _dDtBaixa
							nJurTit := fa070Juros()
							nJurTit := Round(nJurTit,2)

							nLJMULTA := MGLT32A("MV_LJMULTA", (cArqTmp2)->FILIAL)

							If nLJMULTA > 0 //Tratamento cแlculo automแtico de multa
								If SE1->E1_MULTA == 0
									_nMulta := SE1->E1_VALOR * (nLJMULTA / 100)
								EndIf
							EndIf
							dDataBase := _dBkpDtBa
						Endif
					ENDIF

					nSldTit := (SE1->E1_SALDO + nJurTit + SE1->E1_SDACRES) - SE1->E1_SDDECRE + _nMulta

					nVlrBx  := nSldTit

					_nTotDebito += nVlrBx


					If ( _nSldCred - nSldTit ) >= 0

						_nSldCred -= nSldTit

						_dBkpDtBa := dDataBase
						//Baixa o Dbito do Cooperado
						_lBaixou:= U_BaixaSE1(nVlrBx,SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_CLIENTE,SE1->E1_LOJA,_cMotBaixa,_cHistBaixa,SE1->E1_L_EVENT,"","","",.T.,SE1->E1_FILIAL,_dDtBaixa,cCodMix)

						dDataBase := _dBkpDtBa
						If _lBaixou  //Atualiza o valor pago no titulo na tabela ZLF
							_cSeek :=SE1->E1_FILIAL+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO+SE1->E1_CLIENTE+SE1->E1_LOJA+SA2->A2_LOJA
							U_GrvZLF(cCodMIX,SE1->E1_L_EVENT,nVlrBx,_cSeek,"","ActFin","","D",0,0,"","",nJurTit + SE1->E1_MULTA + SE1->E1_SDACRES,0,SA2->A2_COD,SA2->A2_LOJA,SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_LOJA)

						EndIf

						//Armazena Valor da Baixa do T’tulo Pai
						nTotBai += nVlrBx
					Else
						nVlrBx := _nSldCred

						_dBkpDtBa := dDataBase
						_lBaixou:= U_BaixaSE1(nVlrBx,SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_CLIENTE,SE1->E1_LOJA,_cMotBaixa,_cHistBaixa,SE1->E1_L_EVENT,"","","",.T.,SE1->E1_FILIAL,_dDtBaixa,cCodMix)
						dDataBase := _dBkpDtBa
						If _lBaixou  //Atualiza o valor pago no titulo na tabela ZLF
							_cSeek :=SE1->E1_FILIAL+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO+SE1->E1_CLIENTE+SE1->E1_LOJA+SA2->A2_LOJA
							U_GrvZLF(cCodMIX,SE1->E1_L_EVENT,nVlrBx,_cSeek,"","ActFin","","D",0,0,"","",nJurTit + SE1->E1_MULTA + SE1->E1_SDACRES,0,SA2->A2_COD,SA2->A2_LOJA,SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_LOJA)
						EndIf


						nTotBai += nVlrBx

						_nSldCred -= _nSldCred

						Exit // Sai do la็o dos debitos	sem pular o registro, para que seja baixado com outro credito.
					EndIf

				EndIf

			EndIf //Seek T’tulo SE1

			(cArqTmp2)->(DbSkip())

		EndDo

		If nTotBai > 0
			If (cArqTmp1)->TIPOTIT == "SE1"
				_dBkpDtBa := dDataBase
				_lBaixou:= U_BaixaSE1(nTotBai,(cArqTmp1)->PREFIXO,(cArqTmp1)->NUM,(cArqTmp1)->PARCELA,(cArqTmp1)->TIPO,(cArqTmp1)->A2COD,(cArqTmp1)->A2LOJA,_cMotBaixa,_cHistBaixa,(cArqTmp1)->EVENTO,"","","",.T.,(cArqTmp1)->FILIAL,_dDtBaixa,cCodMix)
				dDataBase := _dBkpDtBa

				If _lBaixou .AND. (!Empty((cArqTmp1)->EVENTO) .or. (cArqTmp1)->TIPO = "NCC") //Atualiza o valor pago no titulo na tabela ZLF
					_cSeek :=(cArqTmp1)->FILIAL+(cArqTmp1)->PREFIXO+(cArqTmp1)->NUM+(cArqTmp1)->PARCELA+(cArqTmp1)->TIPO+(cArqTmp1)->A2COD+(cArqTmp1)->A2LOJA+SA2->A2_LOJA
					U_GrvZLF(cCodMIX,(cArqTmp1)->EVENTO,nTotBai,_cSeek,"","ActFin","","C",0,0,"","",0,0,SA2->A2_COD,SA2->A2_LOJA,SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_LOJA)
				EndIf

			Else
				_dBkpDtBa := dDataBase
				_lBaixou:= U_BaixaSE2(nTotBai,(cArqTmp1)->PREFIXO,(cArqTmp1)->NUM,(cArqTmp1)->PARCELA,(cArqTmp1)->TIPO,(cArqTmp1)->A2COD,(cArqTmp1)->A2LOJA,_cMotBaixa,_cHistBaixa,"",(cArqTmp1)->FILIAL,_dDtBaixa,cCodMix)
				dDataBase := _dBkpDtBa
				If _lBaixou .AND. !Empty((cArqTmp1)->EVENTO) //Atualiza o valor pago no titulo na tabela ZLF
					_cSeek :=(cArqTmp1)->FILIAL+(cArqTmp1)->PREFIXO+(cArqTmp1)->NUM+(cArqTmp1)->PARCELA+(cArqTmp1)->TIPO+(cArqTmp1)->A2COD+(cArqTmp1)->A2LOJA+SA2->A2_LOJA

					U_GrvZLF(cCodMIX,(cArqTmp1)->EVENTO,nTotBai,_cSeek,"","ActFin","","C",0,0,"","",0,0,SA2->A2_COD,SA2->A2_LOJA,SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_LOJA)
				EndIf


			EndIf
		EndIf

		nTotBai := 0
		nSldTit := 0
		nVlrBx  := 0
		nJurTit := 0

		(cArqTmp1)->(DbSkip())

	EndDo


	//Executa la็o nos d้bitos nใo baixados para deletar da ZLF
	(cArqTmp2)->(DbGoTop())
	While (cArqTmp2)->(!Eof())
		If (cArqTmp2)->TIPOTIT == "SE1"
			dbSelectArea("SE1")
			SE1->(dbSetOrder(1))//E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
			If SE1->(dbSeek((cArqTmp2)->FILIAL + (cArqTmp2)->PREFIXO + (cArqTmp2)->NUM +(cArqTmp2)->PARCELA + (cArqTmp2)->TIPO ))
				If SE1->E1_SALDO>0
					//Se o saldo do cr้dito zerou, e ainda existem tํtulos em aberto, retira os tํtulos do demonstrativo.
					_cSeek :=SE1->E1_FILIAL+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO+SE1->E1_CLIENTE+SE1->E1_LOJA+SA2->A2_LOJA
					DbSelectArea("ZLF")
					DbSetOrder(4)
					If DbSeek(xFilial("ZLF")+cCodMIX+_cSeek)
						If ZLF->ZLF_VLRPAG == 0
							RecLock("ZLF",.F.)
							ZLF->(DbDelete())
							ZLF->(MsUnlock())
						EndIf
					EndIf
				EndIf
			EndIf
		ElseIf (cArqTmp2)->TIPOTIT == "ZLL"
			DbSelectArea("ZLL")
			DbSetOrder(1)
			If MsSeek((cArqTmp2)->FILIAL+(cArqTmp2)->NUM)
				If ZLF->ZLF_VLRPAG == 0
					RecLock("ZLL",.F.)
					ZLL->ZLL_STATUS := 'S' //Conv๊nios nใo pagos sใo gravados como suspensos.
					ZLL->(MsUnLock())
				EndIf
			EndIf
		EndIf
		(cArqTmp2)->(DbSkip())
	EndDo


	dbSelectArea(cArqTmp1)
	(cArqTmp1)->(dbCloseArea())

	dbSelectArea(cArqTmp2)
	(cArqTmp2)->(dbCloseArea())


	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Restaura a area. ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	CtrlArea(2,_aArea,_aAlias)

Return lRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณAglutinaCredณ Autor ณMicrosiga              ณ Data ณ 00.00.00 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ Aglutina os titulos de credito em um s๓.                   ณฑฑ
ฑฑณ          ณ Executa baixa dos titulos originais e inclui um novo.     ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ ExpO01 - Objeto da Regua de processamento.                 ณฑฑ
ฑฑณ          ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ MGLT033()                                                  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AglutinaCred(oObj)

	Local cFunc := "2"
	Local cArqTmp1 := cGLTalias+cFunc
	Local _aArea   := {}
	Local _aAlias  := {}
	Local nTotReg  := 0
	Local nCont    := 1
	Local _nSldCred := 0
	Local _dBkpData := dDatabase
	Local _cHist := "CREDITO LEITE: "+_cMes+"/"+_cAno
	Local _lBaixou := .f.
	Private lMsErroAuto := .F.
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ  Salva a area. ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	CtrlArea(1,@_aArea,@_aAlias,{"SA2","SE1","SE2","ZL8","SX1"})

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Atualiza o log de processamento   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oObj:SaveLog("INICIO - Aglutinando Cr้ditos - "+SA2->A2_COD +"/"+SA2->A2_LOJA)


	MGLTQRY(cFunc)

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Atualiza a regua de processamento.ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If oObj <> Nil
		nTotReg := _nReg
		nCont   := 1
		oObj:SetRegua2(nTotReg)
	EndIf

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณGera็ใo da fatura de cr้ditoณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	dbSelectArea("ZL8")
	ZL8->(dbSetOrder(1))
	ZL8->(dbSeek(xFilial("ZL8")+_cEveCred)) //Posiciona no evento da fatura de credito do cooperado

	_cHistBaixa := "GLT "+_cMes+"/"+_cAno+" "+ZL8->ZL8_PREFIX+_cNumTit

	dbSelectArea(cArqTmp1)
	dbGoTop()
	_nSldCred := 0
	//Baixa os titulos de credito localizados para o produtor
	While (cArqTmp1)->(!Eof())

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Atualiza a regua de processamento.ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If oObj <> Nil
			oObj:IncRegua2("Aglutinando Creditos - Titulo "+AllTrim(Str(nCont))+" de "+AllTrim(Str(nTotReg)))
		EndIf
		nCont++
		_dBkpDtBa := dDataBase
		If (cArqTmp1)->TIPOTIT == "SE1"
			_lBaixou:= U_BaixaSE1((cArqTmp1)->SALDO,(cArqTmp1)->PREFIXO,(cArqTmp1)->NUM,(cArqTmp1)->PARCELA,(cArqTmp1)->TIPO,(cArqTmp1)->A2COD,(cArqTmp1)->A2LOJA,ZL8->ZL8_PREFIX,_cHistBaixa,(cArqTmp1)->EVENTO,"","","",.T.,(cArqTmp1)->FILIAL,_dDtBaixa,cCodMix)
		Else
			_lBaixou:= U_BaixaSE2((cArqTmp1)->SALDO,(cArqTmp1)->PREFIXO,(cArqTmp1)->NUM,(cArqTmp1)->PARCELA,(cArqTmp1)->TIPO,(cArqTmp1)->A2COD,(cArqTmp1)->A2LOJA,ZL8->ZL8_PREFIX,_cHistBaixa,(cArqTmp1)->EVENTO,(cArqTmp1)->FILIAL,_dDtBaixa,cCodMix)
		EndIf
		dDataBase := _dBkpDtBa
		If _lBaixou
			_nSldCred += (cArqTmp1)->SALDO
		EndIf

		(cArqTmp1)->(DbSkip())
	EndDo


	//Inclui o Titulo de Cr้dito
	If _nSldCred > 0

		If !U_IncluSE2(ZL8->ZL8_PREFIX,_cNumTit," ",_cTipoTit,SA2->A2_COD,SA2->A2_LOJA,ZL8->ZL8_NATPRD,STOD(_cMaxEmis),STOD(_cVencto),_nSldCred,0,0,"",_cHist,0,ZL8->ZL8_COD,"MGLT032",_cAno+_cMes,"",cCodMix,xFilial("SF2"))

			xMagHelpFis("NAO CONFORMIDADE AGLUTINA CREDITO",;
			"Nใo foi possํvel incluir o titulo aglutinado com os creditos do produtor "+SA2->A2_COD,;
			"Nao sera gerado Acerto para esse produtor. Informe este erro ao Depto. de TI.")

			lDeuErro := .T.
		EndIf
	EndIf


	dDatabase := _dBkpData

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Atualiza o log de processamento   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oObj:SaveLog("FIM - Aglutina Creditos - "+SA2->A2_COD +"/"+SA2->A2_LOJA)

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Apaga arquivo temporario.         ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

	dbSelectArea(cArqTmp1)
	(cArqTmp1)->(dbCloseArea())

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Restaura a area. ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	CtrlArea(2,_aArea,_aAlias)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณAglutinaDebณ Autor ณMicrosiga              ณ Data ณ 00.00.00 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ Aglutina os titulos de debito em um s๓.                   ณฑฑ
ฑฑณ          ณ Executa baixa dos titulos originais e inclui um novo.     ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ ExpO01 - Objeto da Regua de processamento.                 ณฑฑ
ฑฑณ          ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ MGLT032()                                                  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AglutinaDeb(oObj)

	Local cFunc := "3"
	Local cArqTmp1 := cGLTalias+cFunc
	Local _aArea   := {}
	Local _aAlias  := {}
	Local nTotReg  := 0
	Local nCont    := 1
	Local _nSldDeb := 0
	Local _nAcres := 0
	Local _nTAcres := 0
	Local _dBkpData := dDatabase
	Local _cHist := "DEBITO LEITE: "+_cMes+"/"+_cAno
	Local _lBaixou := .f.
	Private lMsErroAuto := .F.
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ  Salva a area. ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	CtrlArea(1,@_aArea,@_aAlias,{"SA2","SE1","SE2","ZL8","SX1"})

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Atualiza o log de processamento   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oObj:SaveLog("INICIO - Aglutinando D้bitos - "+SA2->A2_COD +"/"+SA2->A2_LOJA)

	MGLTQRY(cFunc)

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Atualiza a regua de processamento.ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If oObj <> Nil
		nTotReg := _nReg
		nCont   := 1
		oObj:SetRegua2(nTotReg)
	EndIf


	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณGera็ใo da fatura de Debito ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	dbSelectArea("ZL8")
	ZL8->(dbSetOrder(1))
	ZL8->(dbSeek(xFilial("ZL8")+_cEveDeb)) //Posiciona no evento da fatura de debitos

	_cHistBaixa := "GLT "+_cMes+"/"+_cAno+" "+ZL8->ZL8_PREFIX+_cNumTit


	dbSelectArea(cArqTmp1)
	dbGoTop()
	_nSldDeb := 0
	//Baixa os titulos de debito localizados para o produtor
	While (cArqTmp1)->(!Eof())

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Atualiza a regua de processamento.ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If oObj <> Nil
			oObj:IncRegua2("Aglutinando Debitos - Titulo "+AllTrim(Str(nCont))+" de "+AllTrim(Str(nTotReg)))
		EndIf
		nCont++

		//Posiciona na SE1 para calcular os juros utilizando fun็ใo padrใo fa070Juros
		DbSelectArea("SE1")
		DbGoTo((cArqTmp1)->R_E_C_N_O_)

		nJurTit := fa070Juros()
		nJurTit := Round(nJurTit,2)

		nSldTit := (SE1->E1_SALDO + nJurTit + SE1->E1_SDACRES) - SE1->E1_SDDECRE

		_nAcres := nJurTit + SE1->E1_SDACRES //Acumula acrescimo para entrar no titulo aglutinado.
		_dBkpDtBa := dDataBase
		_lBaixou:= U_BaixaSE1(nSldTit,(cArqTmp1)->PREFIXO,(cArqTmp1)->NUM,(cArqTmp1)->PARCELA,(cArqTmp1)->TIPO,(cArqTmp1)->A2COD,(cArqTmp1)->A2LOJA,ZL8->ZL8_PREFIX/*_cMotBaixa*/,_cHistBaixa,(cArqTmp1)->EVENTO,"","","",.T.,(cArqTmp1)->FILIAL,_dDtBaixa,cCodMix)
		dDataBase := _dBkpDtBa
		If _lBaixou
			_nSldDeb += (cArqTmp1)->SALDO
			_nTAcres += _nAcres
		EndIf

		(cArqTmp1)->(DbSkip())
	EndDo


	//Inclui o Titulo de Debito
	If _nSldDeb > 0
		If !U_IncluSE1(ZL8->ZL8_PREFIX,_cNumTit," ",_cTipoTit,SA2->A2_COD,SA2->A2_LOJA,ZL8->ZL8_NATPRD,STOD(_cMaxEmis),STOD(_cVencto),_nSldDeb,_nTAcres,0,"",_cHist,0,ZL8->ZL8_COD,"MGLT032",_cAno+_cMes,xFilial("SF2"),cCodMix)
			xMagHelpFis("NAO CONFORMIDADE AGLUTINA DEBITO",;
			"Nใo foi possํvel incluir o titulo aglutinado com os debitos do produtor "+SA2->A2_COD,;
			"Nao sera gerado Acerto para esse produtor. Informe este erro ao Depto. de TI.")

			lDeuErro := .T.
		EndIf
	EndIf


	dDatabase := _dBkpData

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Atualiza o log de processamento   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oObj:SaveLog("FIM - Aglutina Debitos - "+SA2->A2_COD +"/"+SA2->A2_LOJA)

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Apaga arquivo temporario.         ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

	dbSelectArea(cArqTmp1)
	(cArqTmp1)->(dbCloseArea())

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Restaura a area. ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	CtrlArea(2,_aArea,_aAlias)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณMGLTQRY   ณ Autor ณMicrosiga              ณ Data ณ 00.00.00 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ Funcao para executar querys e gerar arquivo temporario com ณฑฑ
ฑฑณ          ณ o resultado da query.                                      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ ExpC01 - Caracter que identifica a query a ser chamada de  ณฑฑ
ฑฑณ          ณ          acordo com a rotina de Acerto em execucao.        ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ MGLT009()                                                  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MGLTQRY(cOpc,cPrefSE2)

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Declaracao de variavies locais. ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	Local cQry   := ""
	DEFAULT cPrefSE2 := ""

	Do Case

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Filtra os produtores 	          ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		Case cOpc == "1"
			cQry := "SELECT DISTINCT A2_COD,A2_LOJA,A2_L_LI_RO,A2_NREDUZ "
			cQry += " FROM " + RetSqlName("SA2")+ " A2 "
			cQry += " 	JOIN " + RetSqlName("ZLF")+ " LF ON LF.ZLF_FILIAL = '" + xFilial("ZLF") + "' AND LF.ZLF_CODZLE = '"+cCodMIX+"' AND LF.ZLF_RETIRO = A2.A2_COD AND LF.ZLF_RETILJ = A2.A2_LOJA "
			cQry += " 	 AND LF.ZLF_FINOK = ' ' "
			cQry += " 	 AND LF.D_E_L_E_T_ = ' ' "
			cQry += " WHERE A2.D_E_L_E_T_ = ' ' "
			cQry += " AND A2_FILIAL = '" + xFilial("SA2") + "'"
			cQry += " AND A2_L_TPFOR = 'P'" //Produtor Cooperado
			cQry += " AND A2_COD     BETWEEN '" + _cProdDe +"' AND '"+ _cProdAte +"'"
			cQry += " AND A2_LOJA    BETWEEN '" + _cLojaDe +"' AND '"+ _cLojaAte +"'"
			// If !Empty(_cLojaaut)
			// 	cQry += " AND A2_LOJA = '" + _cLojaaut +"' "
			// EndIf
			cQry += " AND A2_L_LI_RO BETWEEN '" + _cGrpDe + "' AND '" + _cGrpAte + "' "

			cQry += " ORDER BY A2_COD "
			TCQUERY cQry NEW ALIAS (cGLTalias+cOpc)
			dbSelectArea(cGLTalias+cOpc)
			Count To _nReg

			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Busca Crditos do Cooperado       ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		Case cOpc == "2"
			//Seleciona nota do leite
			cQry := "SELECT 'SE2' AS TIPOTIT,E2_FILIAL as FILIAL,E2_PREFIXO as PREFIXO,E2_NUM AS NUM,E2_PARCELA AS PARCELA,E2_TIPO AS TIPO,E2_FORNECE AS A2COD,E2_LOJA AS A2LOJA "
			cQry += ",E2_VENCTO AS VENCTO ,E2_VALOR AS VLRORI, E2_SALDO AS SALDO , E2_ACRESC AS ACRESC, E2_DECRESC AS DECRESC, E2_SDACRES AS SDACRES , E2_SDDECRE AS SDDECRE, E2_L_EVENT AS EVENTO, E2_HIST AS HIST, E2_ORIGEM AS ORIGEM "
			cQry += " FROM " + RetSqlName("SE2") + " SE2 "
			cQry += " 			JOIN " + RetSqlName("SA2") + " A2 ON A2.A2_COD = SE2.E2_FORNECE AND A2.A2_LOJA = SE2.E2_LOJA AND A2.D_E_L_E_T_ = ' ' "
			cQry += " 		AND A2.A2_COD = '" + SA2->A2_COD +"' AND A2.A2_LOJA = '" + SA2->A2_LOJA +"' "
			cQry += " WHERE  "
			cQry += " E2_FILIAL  = '" + xFilial("SE2") + "'"
			cQry += " AND E2_ORIGEM  = 'MATA100' "
			cQry += " AND E2_EMISSAO  = '" + _cMaxEmis + "' "
			cQry += " AND E2_TIPO = 'NF ' "
			cQry += " AND E2_L_EVENT = ' ' "
			cQry += " AND E2_SALDO > 0 "
			cQry += " AND SE2.D_E_L_E_T_ = ' ' "
			cQry += " UNION "
			//Seleciona outros creditos lan็ados no contas a pagar
			cQry += "SELECT 'SE2' AS TIPOTIT,E2_FILIAL as FILIAL,E2_PREFIXO as PREFIXO,E2_NUM AS NUM,E2_PARCELA AS PARCELA,E2_TIPO AS TIPO,E2_FORNECE AS A2COD,E2_LOJA AS A2LOJA "
			cQry += ",E2_VENCTO AS VENCTO ,E2_VALOR AS VLRORI,E2_SALDO AS SALDO , E2_ACRESC AS ACRESC, E2_DECRESC AS DECRESC, E2_SDACRES AS SDACRES , E2_SDDECRE AS SDDECRE, E2_L_EVENT AS EVENTO, E2_HIST AS HIST, E2_ORIGEM AS ORIGEM "
			cQry += " FROM " + RetSqlName("SE2") + " SE2 "
			cQry += " 			JOIN " + RetSqlName("SA2") + " A2 ON A2.A2_COD = SE2.E2_FORNECE AND A2.A2_LOJA = SE2.E2_LOJA AND A2.D_E_L_E_T_ = ' ' "
			cQry += " 		AND A2.A2_COD = '" + SA2->A2_COD +"' AND A2.A2_LOJA = '" + SA2->A2_LOJA +"' "
			cQry += " WHERE  "
			cQry += " E2_FILIAL  = '" + xFilial("SE2") + "'"
			cQry += " AND E2_EMISSAO BETWEEN '" + SubStr(_cMaxEmis,1,6) + "01'	AND  '" + _cVencto + "' " //Busca creditos lan็ados entre 01/05/2016 ate 20/06/2016
			cQry += " AND E2_VENCTO 	<= '" + _cVencto + "' "
			cQry += " AND E2_TIPO NOT IN ('PA','NDF') "
			cQry += " AND E2_L_EVENT <> ' ' "
			cQry += " AND E2_L_EVENT NOT IN ('110023','110024','110025') "
			cQry += " AND E2_SALDO > 0 "
			If (TcGetDB() == 'ORACLE')
				cQry += " AND (E2_PREFIXO||E2_NUM <> 'GL1"+_cNumTit+"') "
			Else
				cQry += " AND (E2_PREFIXO+E2_NUM <> 'GL1"+_cNumTit+"') "
			EndIf
			cQry += " AND SE2.D_E_L_E_T_ = ' ' "
			cQry += " ORDER BY SALDO DESC"
			TCQUERY cQry NEW ALIAS (cGLTalias+cOpc)
			dbSelectArea(cGLTalias+cOpc)
			Count To _nReg


			//Grava็ใo dos creditos na ZLF
			If _lGrvCred
				GravaZLF(cGLTalias+cOpc,"C")
				_lGrvCred := .F.
			EndIf

			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Busca Dbitos do Cooperado       ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		Case cOpc == "3"
			cQry := "SELECT 'SE1' AS TIPOTIT,E1_FILIAL as FILIAL,E1_PREFIXO as PREFIXO,E1_NUM AS NUM,E1_PARCELA AS PARCELA,E1_TIPO AS TIPO,E1_CLIENTE AS A2COD,E1_LOJA AS A2LOJA "
			cQry += ",E1_VENCTO AS VENCTO,E1_VALOR AS VLRORI, E1_SALDO AS SALDO , E1_ACRESC AS ACRESC, E1_DECRESC AS DECRESC, E1_SDACRES AS SDACRES , E1_SDDECRE AS SDDECRE,E1_L_EVENT AS EVENTO, E1_HIST AS HIST  "
			cQry += ", SE1.R_E_C_N_O_, ZL8.ZL8_PRIORI AS PRIORIDADE " //Inclusao de prioridade seguindo ordem definida no cadastro de eventos.
			cQry += " FROM " + RetSqlName("SE1") + " SE1 "
			cQry += "			JOIN " + RetSqlName("ZL8") + " ZL8 ON ZL8.ZL8_COD = SE1.E1_L_EVENT AND ZL8.D_E_L_E_T_ = ' ' "
			cQry += " 			JOIN " + RetSqlName("SA2") + " A2 ON A2.A2_COD = SE1.E1_CLIENTE AND A2.D_E_L_E_T_ = ' ' " //AND A2.A2_LOJA = SE1.E1_LOJA
			cQry += " WHERE "
			cQry += " E1_FILIAL  	BETWEEN '    ' AND 'ZZZZ'"
			cQry += " AND E1_CLIENTE  	=  '" + SA2->A2_COD +"' "
			cQry += " AND E1_LOJA    	=  '" + SA2->A2_LOJA +"' "
			cQry += " AND E1_VENCTO 	<= '"  + _cVencto  + "'"
			cQry += " AND E1_TIPO <> 'NCC' "
			cQry += " AND E1_SALDO 		> 0 "
			cQry += " AND E1_EMISSAO	<= '" + _cMaxEmis + "' "
			cQry += " AND E1_L_EVENT <> ' ' "
			If (TcGetDB() == 'ORACLE')
				cQry += " AND ( E1_PREFIXO||E1_NUM <> 'GL2"+_cNumTit+"') "
			Else
				cQry += " AND ( E1_PREFIXO+E1_NUM <> 'GL2"+_cNumTit+"') "
			EndIf
			cQry += " AND SE1.D_E_L_E_T_ = ' ' "


			If !_lGeraFin //Se nใo gerou financeiro nos conv๊nios, busca tabela ZLL para apurar d้bitos a descontar e gerar tํtulos no valor a descontar.

				cQry += " UNION "

				If (TcGetDB() == 'ORACLE')
					cQry += "SELECT 'ZLL' AS TIPOTIT,ZLL_FILIAL as FILIAL,ZL8_PREFIX as PREFIXO,ZLL_COD||ZLL_SEQ AS NUM, '  ' AS PARCELA, '"+_cTipoTit+"' AS TIPO, ZLL_RETIRO AS A2COD, ZLL_RETILJ AS A2LOJA "
				Else
					cQry += "SELECT 'ZLL' AS TIPOTIT,ZLL_FILIAL as FILIAL,ZL8_PREFIX as PREFIXO,ZLL_COD+ZLL_SEQ AS NUM, '  ' AS PARCELA, '"+_cTipoTit+"' AS TIPO, ZLL_RETIRO AS A2COD, ZLL_RETILJ AS A2LOJA "
				EndIf
				cQry += ",ZLL_VENCTO AS VENCTO,ZLL_VALOR AS VLRORI, ZLL_VALOR AS SALDO , 0 AS ACRESC, 0 AS DECRESC, 0 AS SDACRES , 0 AS SDDECRE,ZLL_EVENTO AS EVENTO, ZLL_OBSERV AS HIST  "
				cQry += ", ZLL.R_E_C_N_O_, ZL8.ZL8_PRIORI AS PRIORIDADE " //Inclusao de prioridade seguindo ordem definida no cadastro de eventos.
				cQry += " FROM " + RetSqlName("ZLL") + " ZLL "
				cQry += "	 JOIN " + RetSqlName("ZL8") + " ZL8 ON ZL8.ZL8_COD = ZLL.ZLL_EVENTO AND ZL8.D_E_L_E_T_ = ' ' "
				cQry += " AND ZLL_RETIRO  	=  '" + SA2->A2_COD +"' "
				cQry += " AND ZLL_RETILJ  	=  '" + SA2->A2_LOJA +"' "
				cQry += " AND ZLL_VENCTO 	<= '"  + _cVencto  + "'"
				cQry += " AND ZLL_STATUS	= 'A' "
				cQry += " AND ZLL_DATA	<= '" + _cMaxEmis + "' "
				cQry += " AND ZLL.D_E_L_E_T_ = ' ' "

			EndIf

			cQry += " ORDER BY PRIORIDADE, VENCTO  "



			TCQUERY cQry NEW ALIAS (cGLTalias+cOpc)
			dbSelectArea(cGLTalias+cOpc)
			Count To _nReg

			//Grava็ใo dos debitos na ZLF
			If _lGrvDeb
				GravaZLF(cGLTalias+cOpc,"D")
				_lGrvDeb := .F.
			EndIf

	EndCase

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMGLT032   บAutor  ณMicrosiga           บ Data ณ  05/19/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GravaZLF(xcAlias,xcDebCre)

	Local cSeek := ""

	DbSelectARea(xcAlias)
	(xcAlias)->(DbGoTop())

	While !(xcAlias)->(Eof())
		DbSelectArea("ZL8")
		DbSetOrder(1)
		DbSeek(xFilial("ZL8")+(xcAlias)->EVENTO)
		//Posiciona no evento, e nใo grava eventos automแticos pois estes jแ estarao gravados pelo fechamento do leite.
		If (!Empty((xcAlias)->EVENTO)  .OR. (xcAlias)->TIPO == "NCC") .and. (xcAlias)->TIPOTIT != "ZLL"
			cSeek := (xcAlias)->FILIAL+(xcAlias)->PREFIXO+(xcAlias)->NUM+(xcAlias)->PARCELA+(xcAlias)->TIPO+(xcAlias)->A2COD+(xcAlias)->A2LOJA+SA2->A2_LOJA

			U_GrvZLF(cCodMIX,(xcAlias)->EVENTO,(xcAlias)->SALDO,cSeek,"","","",xcDebCre,(xcAlias)->VLRORI,(xcAlias)->SALDO,(xcAlias)->VENCTO,;
			(xcAlias)->HIST,0,(xcAlias)->ACRESC,SA2->A2_COD,SA2->A2_LOJA,(xcAlias)->PREFIXO,(xcAlias)->NUM,(xcAlias)->PARCELA,(xcAlias)->TIPO,(xcAlias)->A2LOJA,.T.)
		EndIf
		(xcAlias)->(DbSkip())
	EndDo

Return
/*

ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑ…ีีีีีีีีีี—ีีีีีีีีีีภีีีีีีี—ีีีีีีีีีีีีีีีีีีีีภีีีีีี—ีีีีีีีีีีีีีชฑฑ
ฑฑ?Programa  = CtrlArea ? Autor = Microsiga          ? Data =  00/00/00   ?ฑฑ
ฑฑรีีีีีีีีีีÿีีีีีีีีีี ีีีีีีีีีีีีีีีีีีีีีีีีีีี ีีีีีีีีีีีีีีีีีีีpฑฑ
ฑฑ?Descricao = Static Function auxiliar no GetArea e ResArea retornando   ?ฑฑ
ฑฑ?          = o ponteiro nos Aliases descritos na chamada da Funcao.     ?ฑฑ
ฑฑ?          = Exemplo:                                                   ?ฑฑ
ฑฑ?          = Local _aArea  := {} // Array que contera o GetArea         ?ฑฑ
ฑฑ?          = Local _aAlias := {} // Array que contera o                 ?ฑฑ
ฑฑ?          =                     // Alias(), IndexOrd(), Recno()        ?ฑฑ
ฑฑ?          =                                                            ?ฑฑ
ฑฑ?          = // Chama a Funcao como GetArea                             ?ฑฑ
ฑฑ?          = P_CtrlArea(1,@_aArea,@_aAlias,{"SL1","SL2","SL4"})         ?ฑฑ
ฑฑ?          =                                                            ?ฑฑ
ฑฑ?          = // Chama a Funcao como RestArea                            ?ฑฑ
ฑฑ?          = P_CtrlArea(2,_aArea,_aAlias)                               ?ฑฑ
ฑฑรีีีีีีีีีีÿีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีpฑฑ
ฑฑ?Parametros= nTipo   = 1=GetArea / 2=RestArea                           ?ฑฑ
ฑฑ?          = _aArea  = Array passado por referencia que contera GetArea ?ฑฑ
ฑฑ?          = _aAlias = Array passado por referencia que contera         ?ฑฑ
ฑฑ?          =           {Alias(), IndexOrd(), Recno()}                   ?ฑฑ
ฑฑ?          = _aArqs  = Array com Aliases que se deseja Salvar o GetArea ?ฑฑ
ฑฑรีีีีีีีีีีÿีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีpฑฑ
ฑฑ?Uso       = GENERICO                                                   ?ฑฑ
ฑฑปีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีีบฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
?????????????????????????????????????????????????????????????????????????????
*/
Static Function CtrlArea(_nTipo,_aArea,_aAlias,_aArqs)

	Local _nN := 0

	// Tipo 1 = GetArea()
	If _nTipo == 1
		_aArea := GetArea()
		For _nN := 1 To Len(_aArqs)
			dbSelectArea(_aArqs[_nN])
			AAdd(_aAlias,{ _aArqs[_nN], IndexOrd(), Recno() })
		Next
		// Tipo 2 = RestArea()
	Else
		For _nN := 1 To Len(_aAlias)
			dbSelectArea(_aAlias[_nN,1])
			dbSetOrder(_aAlias[_nN,2])
			DbGoto(_aAlias[_nN,3])
		Next
		RestArea(_aArea)
	EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ GrvZLF	   บ Autor ณ TOTVS                 บ Data da Criacao  ณ 00/00/2000             						บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Grava ou altera registro na tabela ZLF.                                                						บฑฑ
ฑฑบ          ณ                                 							                               						บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MGLT032 - FECHAMENTO FINANCEIRO  - BEN ALIMENTOS                 											บฑฑ
ฑฑบ          ณ 	 							                                                                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                                                                                      						บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ Nenhum					                                                                                  	บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUsuario   ณ															                             						บฑฑ
ฑฑฬออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบSetor     ณ Gestao do Leite	                                                                       						บฑฑ
ฑฑฬออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ            						ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL                   						บฑฑ
ฑฑฬออออออออออัออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออัออออออออออออออออออออออออออออออออออัอออออออออออออนฑฑ
ฑฑบAutor     ณ Data     ณ Motivo da Alteracao  				               ณUsuario(Filial+Matricula+Nome)    ณSetor        บฑฑ
ฑฑฬฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤนฑฑ
ฑฑบ          ณ          ณ                    							   ณ                                  ณ 			บฑฑ
ฑฑศออออออออออฯออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออออออออออออออออออออออออออออออฯอออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GrvZLF(cCodMIX,cEvento,nValor,cSeek,_cSeq,cFunName,cLinha,;
			cDebCred,nSVLRORI,nSE1SLD,dSE1VEN,cSE1HIS,nSE1JUR,nSE1ACRES,;
			_cCodForn,_cLojForn,cPref,cNum,cParc,cTipo,_cLjSE2,_lInc)


	DEFAULT _lInc := .F. // Indica se a fun็ใo esta sendo chamada pela inclusao inicial dos titulos.

	DbSelectArea("ZLF")
	DbSetOrder(4)
	If DbSeek(xFilial("ZLF")+cCodMIX+cSeek)
		RecLock("ZLF",.F.)
		If Alltrim(cFunName) == "MGLT033"
			ZLF->(DbDelete())
		ElseIf !_lInc //-(nValor)
			ZLF->ZLF_SE1JUR += nSE1JUR
			ZLF->ZLF_VLRPAG += nValor
		EndIf
		ZLF->(MsUnlock())

	ElseIf Alltrim(cFunName) != "MGLT033"
		_cSeq:= U_GetSeqZLF(cCodMIX,cEvento,_cCodForn,_cLojForn)

		RecLock("ZLF", .T.)

		ZLF->ZLF_FILIAL := xFilial("ZLF")
		ZLF->ZLF_CODZLE := cCodMIX
		ZLF->ZLF_VERSAO := "1" //_cVersao
		ZLF->ZLF_SETOR  := _cSetor //ZL3->ZL3_SETOR
		ZLF->ZLF_LINROT := Posicione("SA2",1,xFILIAL("SA2")+_cCodForn+_cLojForn,"A2_L_LI_RO")
		ZLF->ZLF_RETIRO := _cCodForn
		ZLF->ZLF_RETILJ := _cLojForn
		ZLF->ZLF_A2COD  := _cCodForn
		ZLF->ZLF_A2LOJA := _cLojForn
		ZLF->ZLF_A2NOME := Posicione("SA2",1,xFILIAL("SA2")+_cCodForn+_cLojForn,"A2_NOME")
		ZLF->ZLF_EVENTO := cEvento
		ZLF->ZLF_DCREVE := Posicione("ZL8",1,xFILIAL("ZL8")+cEvento,"ZL8_DESCRI")
		ZLF->ZLF_ENTMIX := Posicione("ZL8",1,xFILIAL("ZL8")+cEvento,"ZL8_MIX")
		ZLF->ZLF_DEBCRED:= cDebCred
		ZLF->ZLF_DTINI  := Posicione("ZLE",1,xFILIAL("ZLE")+cCodMIX,"ZLE_DTINI")
		ZLF->ZLF_DTFIM  := Posicione("ZLE",1,xFILIAL("ZLE")+cCodMIX,"ZLE_DTFIM")
		ZLF->ZLF_ORIGEM := "F"
		ZLF->ZLF_QTDBOM := 0
		ZLF->ZLF_TOTAL  := nValor
		ZLF->ZLF_SE1VLR := nSVLRORI
		ZLF->ZLF_SE1SLD := nSE1SLD //If(!_lSaldoOk, nSE2VLR,  0)
		ZLF->ZLF_SE1JUR := nSE1JUR
		ZLF->ZLF_VLRPAG := 0 //nSVLRORI-nSE1SLD//If(_lSaldoOk, nSE2VLR,  nSE2VLR-nSE2SLD)
		ZLF->ZLF_VLRLTR := 0
		ZLF->ZLF_SE1ACR := nSE1ACRES
		ZLF->ZLF_ACERTO := "S"
		ZLF->ZLF_TP_MIX := "L"
		ZLF->ZLF_TIPO   := "L"
		ZLF->ZLF_STATUS := "F"
		ZLF->ZLF_SEQ	:= _cSeq
		ZLF->ZLF_DCRSET := POSICIONE("ZL2",1,xFilial("ZL2")+ZLF->ZLF_SETOR,"ZL2_DESCRI")//"BEN ALIMENTOS - RIALMA"
		ZLF->ZLF_DCREVE := Posicione("ZL8",1,xFILIAL("ZL8")+cEvento,"ZL8_NREDUZ")
		ZLF->ZLF_TRIBUT := Posicione("SA2",1,xFILIAL("SA2")+_cCodForn+_cLojForn,"A2_L_TRIBU") //_cTpTrib
		ZLF->ZLF_L_SEEK := cCodMIX + cSeek//xFilial("ZLF") + cCodMIX + _cVersao + _cCodForn + _cLojForn + cEvento + "NDF" +
		ZLF->ZLF_SE1PRE := cPref
		ZLF->ZLF_SE1NUM  := cNum
		ZLF->ZLF_SE1PAR := cParc
		ZLF->ZLF_SE1HIS := cSE1HIS
		ZLF->ZLF_SE1VEN := STOD(dSE1VEN)

		ZLF->(MsUnLock())

	EndIf

Return

*/
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCalcJuros บAutor  ณGuilherme Franca    บ Data ณ  10/04/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Realiza o calculo de juros dos titulos em atraso, e inclui บฑฑ
ฑฑบ          ณ um NDF com o valor apurado de acordo com regras da AGROVERDEฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CalcJuros(oObj)

	Local _cQry := ""
	Local _nTaxa := GetMV("LT_JUROS") //Busca taxa parametrizada.
	Local _cEveJur := "100039"
	Local _cNrotit := SubStr(SA2->A2_COD,2,5)+SubStr(ZLE->ZLE_COD,3,4)
	Local _cHistJr := "JUROS S/SLD DEV. "+SubStr(dtoc(ZLE->ZLE_DTFIM),4,7)

	_cQry := "SELECT SUM( E1_SALDO + E1_SDACRES -E1_SDDECRE ) AS SALDO"
	_cQry += " FROM "+RetSqlName("SE1")+" E1 "
	_cQry += " WHERE E1.D_E_L_E_T_ = ' '"
	_cQry += " AND E1.E1_SALDO   > 0"  //Somente titulos em aberto ou baixados parcialmente
	_cQry += " AND E1.E1_EMISSAO <= '" + DtoS(ZLE->ZLE_DTFIM) 	+ "'"
	_cQry += " AND E1.E1_VENCTO < '"  + DtoS(ZLE->ZLE_DTFIM)	+ "'" //Somente titulos em atraso
	_cQry += " AND E1.E1_CLIENTE = '"  + SA2->A2_COD 			+ "'"
	_cQry += " AND E1.E1_LOJA    = '"  + SA2->A2_LOJA			+ "'"
	_cQry += " AND E1.E1_L_EVENT <> ' ' "
	_cQry += " AND E1_L_JUROS = 'S' "

	If Select("TJUR") <> 0
		TJUR->(dbCloseArea())
	EndIf

	dbUseArea( .T., "TOPCONN", TcGenQry(,,_cQry), "TJUR", .T., .F. )

	TJUR->(DbGoTop())

	If !TJUR->(Eof())
		_nVlrJuros := TJUR->SALDO * _nTaxa
	EndIf

	If _nVlrJuros > 0
		DbSelectArea("ZL8")
		DbSetOrder(1)
		If DbSeek(xFilial("ZL8")+_cEveJur)
			U_IncluSE1(ZL8->ZL8_PREFIX,_cNrotit," ",_cTipoTit,SA2->A2_COD,SA2->A2_LOJA,ZL8->ZL8_NATPRD,STOD(_cMaxEmis),STOD(_cVencto),Round(_nVlrJuros,2),0,0,"",_cHistJr,0,ZL8->ZL8_COD,"MGLT032",_cAno+_cMes,xFilial("SF2"),cCodMix)
		EndIf
	EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGeraNumTitบAutor  ณGuilherme Fran็a    บ Data ณ  16/06/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gera numera็ใo automatica para ser utilizada nos titulos   บฑฑ
ฑฑบ          ณ aglutinadores GL1 e GL2.                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function GeraNumTit(xcCod,xcLoja)

	Local _cNum := Right(cCodMix,3)
	Local _cRet := ""

	If Select("NTIT")<>0
		NTIT->(DbCloseArea())
	EndIf

	BeginSql alias "NTIT"
		SELECT F1_DOC as NUM FROM %Table:SF1% F1
		WHERE F1_FILIAL = %Exp:cFilAnt%
		AND F1_L_MIX = %Exp:cCodMix%
		AND F1_FORNECE = %Exp:xcCod%
		AND F1_LOJA = %Exp:xcLoja%
		AND F1.%NotDel%
	EndSql


	If !NTIT->(Eof())
		If !Empty(NTIT->NUM)
			_cRet := NTIT->NUM
		EndIf
	EndIf

	If Empty(_cRet)
		_cRet := _cNum+SubStr(xcCod,2,5)+SubStr(xcLoja,2,1)
	EndIf

Return _cRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFlagZLF บAutor  ณGUILHERME FRANCA    บ Data ณ  21/04/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Grava o campo ZLF_FINOK indicando que o fechamento foi realizado.
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FlagZLF(oObj)

	Local cQry := ""

	cQry := "UPDATE "+RETSQLNAME("ZLF")
	cQry += " SET ZLF_FINOK = 'S', ZLF_ACERTO = 'S' "
	cQry += " WHERE D_E_L_E_T_ = ' '"
	cQry += " AND ZLF_FILIAL = '" + xFilial("ZLF") + "' "
	cQry += " AND ZLF_CODZLE = '"+cCodMIX+"' "
	cQry += " AND ZLF_RETIRO  = '" + SA2->A2_COD + "' "
	cQry += " AND ZLF_RETILJ = '" + SA2->A2_LOJA + "'"
	lSqlOk := !(TCSqlExec(cQry) < 0)

	If lSqlOk .and.  (TcGetDB() == 'ORACLE')
		lSqlOk := !(TCSqlExec(" COMMIT ") < 0)
	EndIf

	If !lSqlOk
		xMagHelpFis("NAO CONFORMIDADE 12 - NO UPDATE",;
		TcSqlError(),;
		"Verifique a Sintaxe da Query de UPDATE.")
		lDeuErro := .T.
	EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  FlagSE5 บAutor  ณGUILHERME FRANCA    บ Data ณ  21/04/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Grava o campo E5_L_SEEK indicando que o fechamento foi realizado.
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FlagSE5()

	Local _cAliE5 := GetNextAlias()
	Local _cMotbx := SubStr(_cMotBaixa,1,2)
	Local _cDtBx := DTOS(_dDtBaixa)

	BeginSql alias _cAliE5
		SELECT E5.R_E_C_N_O_ as RECSE5
		FROM %Table:SE5% E5
		WHERE E5_DATA = %Exp:_cDtBx%
		AND SUBSTR(E5_MOTBX,1,2) = %Exp:_cMotbx%
		AND E5_BANCO = ' '
		AND E5_L_SEEK = ' '
		AND E5_SITUACA = ' '
		AND E5.%NotDel%
	EndSql

	While !(_cAliE5)->(EOF())
		DbSelectArea("SE5")
		DbGoTo((_cAliE5)->RECSE5)
		RecLock("SE5",.F.)
		SE5->E5_L_SEEK := cCodMIX
		SE5->(MsUnLock())
		(_cAliE5)->(DbSkip())
	EndDo

	(_cAliE5)->(DbCloseArea())

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMGLT009   บAutor  ณMicrosiga           บ Data ณ  11/27/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ValidaBloqueio(_dDtIni,_dDtFim)

	Local _cMatriculas := ""

	BeginSql alias "BLQ"
	SELECT (LF.ZLF_RETIRO+"-"+LF.ZLF_RETILJ) MAT
	FROM %Table:ZLF% LF
		JOIN %Table:SA2% A2 ON A2.A2_COD = LF.ZLF_RETIRO AND A2.A2_LOJA = LF.ZLF_RETILJ AND A2.A2_MSBLQL = '1' AND A2.%NotDel%
	WHERE LF.ZLF_CODZLE = %Exp:cCodMIX%
	AND LF.ZLF_SEQ = '001'
	AND LF.%NotDel% = ' '
	EndSql

	BLQ->(DbGoTop())
	While !BLQ->(Eof())
		_cMatriculas := _cMatriculas + BLQ->MAT+"/ "
		BLQ->(DbSkip())
	EndDo

	BLQ->(DbCloseArea())

	If !Empty(_cMatriculas)
		xMagHelpFis("Bloqueio","Existem Produtores deste MIX com cadastro bloqueado!",;
		"Desbloqueie os cadastros abaixo antes de prosseguir com o fechamento:"+_ENTER;
		+_cMatriculas)
		Return .f.
	EndIf

Return .t.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ AtualizaSldบ Autor ณGuilherme Fran็a  บ Data ณ  00/00/00   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Atualiza os saldos na tabela ZLV.                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AtualizaSld(Obj)

	Local _cAno := Alltrim(Str(year(ZLE->ZLE_DTFIM)))
	Local _cMes := StrZero(Month(ZLE->ZLE_DTFIM),2)

	DbSelectArea("ZLV")
	DbSetOrder(1)
	If ZLV->(DbSeek(xFilial("ZLV")+_cAno+_cMes+SA2->A2_COD+SA2->A2_LOJA))
		RecLock("ZLV",.F.)
		ZLV->ZLV_DEBITO := _nTotDebito
		ZLV->ZLV_VLRLIQ := ZLV->ZLV_VLRNF - ZLV->ZLV_FUNRUR - ZLV->ZLV_SENAR - _nTotDebito - ZLV->ZLV_FUNDES

		ZLV->(MsUnlock())

	EndIf

Return

Static Function MGLT32A(cParam, cFilInf)

	Local cRetParam	:= ""

	cRetParam	:= SuperGetMV(cParam, .F., 0, cFilInf)

Return cRetParam
