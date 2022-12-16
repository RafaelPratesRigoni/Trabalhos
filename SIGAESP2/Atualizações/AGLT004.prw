#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'
#INCLUDE "TOPCONN.CH"
#include 'TOTVS.ch'


#DEFINE _ENTER CHR(13)+CHR(10)

/*
===============================================================================================================================
Programa----------: AGLT004
Autor-------------: GUILHERME FRANÇA
Data da Criacao---: 09/06/2020
===============================================================================================================================
Descricao---------: Cadastro de setor e parametrizações do Gestão do Leite.
===============================================================================================================================
Uso---------------: Modulo Faturamento
===============================================================================================================================
Parametros--------:
===============================================================================================================================
Retorno-----------: Nenhum
===============================================================================================================================
Chamado(SPS)------:
===============================================================================================================================
Setor-------------: Gestão do Leite
===============================================================================================================================
*/

User function AGLT004()

	Local oBrowse

	oBrowse := FWmBrowse():New()
	oBrowse:SetAlias( 'ZL2' )

	//Descricao da Parte Superior Esquerda do Browse
	oBrowse:SetDescripton("Setor - Parametros Gestão do Leite")

	//Habilita os BotÃµes Ambiente e WalkThru
	oBrowse:SetAmbiente(.F.)
	oBrowse:SetWalkThru(.F.)

	//Ativa o Browse
	oBrowse:Activate()

return

Static Function MenuDef()

	Local aRotina := {}

	aAdd( aRotina, { 'Pesquisar'	, 'PesqBrw'        	  , 0, 1, 0, NIL } )
	aAdd( aRotina, { 'Visualizar'	, 'VIEWDEF.AGLT004', 0, 2, 0, NIL } )
	aAdd( aRotina, { 'Incluir' 		, 'U_MNUZL2("I")', 0, 3, 0, NIL } )
	aAdd( aRotina, { 'Alterar'		, 'U_MNUZL2("A")', 0, 4, 0, NIL } )
	aAdd( aRotina, { 'Excluir' 		, 'U_MNUZL2("E")', 0, 5, 0, NIL } )

Return aRotina

/**********************
* FUNÇÕES DO MENU     *
***********************/
User Function MNUZL2(xOpc)

	Local _lUser := (GetAdvFVal("ZLU","ZLU_ACERTO",xFilial("ZLU")+cUserName,1,"N") == "S")

	IF xOpc == "I"
		lOk := ( FWExecView('Inclusão parâmetros','AGLT004', MODEL_OPERATION_INSERT,, ,  ) == 0 )
	ElseIF xOpc == "A"
		If  !_lUser
			Help( ,,1,"Permissão","Usuário sem permissão para alterar parâmetros", 1, 0 )
			Return
		EndIf
		lOk := ( FWExecView('Alteração parâmetros','AGLT004', MODEL_OPERATION_UPDATE,, ,  ) == 0 )
	ElseIF xOpc == "E"
		If  !_lUser
			Help( ,,1,"Permissão","Usuário sem permissão para excluir parâmetros", 1, 0 )
			Return
		EndIf
		If (U_chkZLD("ZLD_SETOR",ZL2->ZL2_COD))
			lOk := ( FWExecView('Exclusão parâmetros','AGLT004', MODEL_OPERATION_UPDATE,, ,  ) == 0 )
		EndIf
	EndIf


Return

Static Function ModelDef()

	Local oStruZL2  :=  FWFormStruct(1,'ZL2') //Retorna a Estrutura do Alias passado como Parametro (1=Model,2=View)
	Local oModel
	Local _aTrigger := {}
	Local _iGat 	:= 0

	//Gatilho de atualização do custo real
	aAdd(_aTrigger	,FwStruTrigger('ZL2_ALQSEN' , 'ZL2_ALQFUN'   , "M->ZL2_ALQSEN + M->ZL2_ALQINS + M->ZL2_ALQRAT" , .F. ))
	aAdd(_aTrigger	,FwStruTrigger('ZL2_ALQINS' , 'ZL2_ALQFUN'   , "M->ZL2_ALQSEN + M->ZL2_ALQINS + M->ZL2_ALQRAT" , .F. ))
	aAdd(_aTrigger	,FwStruTrigger('ZL2_ALQRAT' , 'ZL2_ALQFUN'   , "M->ZL2_ALQSEN + M->ZL2_ALQINS + M->ZL2_ALQRAT" , .F. ))

	For _iGat := 1 to Len(_aTrigger)
		oStruZL2:AddTrigger( _aTrigger[_iGat][1], _aTrigger[_iGat][2], _aTrigger[_iGat][3], _aTrigger[_iGat][4] )
	Next _iGat

	//Instancia do Objeto de Modelo de Dados
	oModel	:=	MpFormModel():New('MCAD_ZL2', /*Pre-Validacao*/,{ |oModel| TudoOk()}/*Pos-Validacao*/,/*Commit*/,/*Commit*/,/*Cancel*/)

	//Adiciona um modelo de Formulario de Cadastro Similar Ã  Enchoice ou Msmget
	oModel:AddFields('ID_M_FLD_ZL2', /*cOwner*/, oStruZL2, /*bPreValidacao*/, /*bPosValidacao*/, /*bCarga*/ )
	oModel:SetDescripton("Setor - Parametros Gestão do Leite")

	//Define chave primÃ¡ria do modelo de dados.
	oModel:SetPrimaryKey({"ZL2_FILIAL","ZL2_COD"})

Return(oModel)

Static Function ViewDef()

	Local oStruZL2  :=  FWFormStruct(2,'ZL2') //Retorna a Estrutura do Alias passado como Parametro (1=Model,2=View)
	Local oModel    :=  FwLoadModel("AGLT004")
	Local oView		:=  FwFormView():New()      //Instancia do Objeto de VisualizaÃ§Ã£o

	//Organiza os grupos de campos para exibição.
	oStruZL2:AddGroup( 'GR0', ' ',	'', 2 )
	oStruZL2:AddGroup( 'GR1', 'Recepção Leite'	, '', 2 )
	oStruZL2:AddGroup( 'GR2', 'Funrural','', 2 )
	oStruZL2:AddGroup( 'GR3', 'Acerto do Leite','', 2 )
	oStruZL2:AddGroup( 'GR4', 'Outros',	'', 2 )

	oStruZL2:SetProperty( '*'	, MVC_VIEW_GROUP_NUMBER, 'GR4' )  //Todos os campos que não estão detalhados, vão para este grupo

	oStruZL2:SetProperty( 'ZL2_COD'		, MVC_VIEW_GROUP_NUMBER, 'GR0' )
	oStruZL2:SetProperty( 'ZL2_DESCRI'	, MVC_VIEW_GROUP_NUMBER, 'GR0' )
	oStruZL2:SetProperty( 'ZL2_PRODUT'	, MVC_VIEW_GROUP_NUMBER, 'GR0' )

	oStruZL2:SetProperty( 'ZL2_ESTOQU'	, MVC_VIEW_GROUP_NUMBER, 'GR1' )
	oStruZL2:SetProperty( 'ZL2_TM'		, MVC_VIEW_GROUP_NUMBER, 'GR1' )
	oStruZL2:SetProperty( 'ZL2_LOCAL'	, MVC_VIEW_GROUP_NUMBER, 'GR1' )
	oStruZL2:SetProperty( 'ZL2_ESTORI'	, MVC_VIEW_GROUP_NUMBER, 'GR1' )

	oStruZL2:SetProperty( 'ZL2_TPFUN'	, MVC_VIEW_GROUP_NUMBER, 'GR2' )
	oStruZL2:SetProperty( 'ZL2_ALQSEN'	, MVC_VIEW_GROUP_NUMBER, 'GR2' )
	oStruZL2:SetProperty( 'ZL2_ALQINS'	, MVC_VIEW_GROUP_NUMBER, 'GR2' )
	oStruZL2:SetProperty( 'ZL2_ALQRAT'	, MVC_VIEW_GROUP_NUMBER, 'GR2' )
	oStruZL2:SetProperty( 'ZL2_ALQFUN'	, MVC_VIEW_GROUP_NUMBER, 'GR2' )

	oStruZL2:SetProperty( 'ZL2_SERIE'	, MVC_VIEW_GROUP_NUMBER, 'GR3' )
	oStruZL2:SetProperty( 'ZL2_NATURE'	, MVC_VIEW_GROUP_NUMBER, 'GR3' )
	oStruZL2:SetProperty( 'ZL2_NATUPJ'	, MVC_VIEW_GROUP_NUMBER, 'GR3' )
	oStruZL2:SetProperty( 'ZL2_CONDPG'	, MVC_VIEW_GROUP_NUMBER, 'GR3' )
	oStruZL2:SetProperty( 'ZL2_TESTRI'	, MVC_VIEW_GROUP_NUMBER, 'GR3' )
	oStruZL2:SetProperty( 'ZL2_TESDIF'	, MVC_VIEW_GROUP_NUMBER, 'GR3' )
	oStruZL2:SetProperty( 'ZL2_DIABX'	, MVC_VIEW_GROUP_NUMBER, 'GR3' )

	oStruZL2:SetProperty( 'ZL2_TESISE'	, MVC_VIEW_GROUP_NUMBER, 'GR3' )
	oStruZL2:SetProperty( 'ZL2_TESDIS'	, MVC_VIEW_GROUP_NUMBER, 'GR3' )
	oStruZL2:SetProperty( 'ZL2_TESSEN'	, MVC_VIEW_GROUP_NUMBER, 'GR3' )
	oStruZL2:SetProperty( 'ZL2_TESCRP'	, MVC_VIEW_GROUP_NUMBER, 'GR3' )

	//Define o Modelo sobre qual a Visualizacao sera utilizada
	oView:SetModel(oModel)

	oView:SetDescripton("Setor - Parametros Gestão do Leite")


	//Vincula o Objeto visual de Cadastro com o modelo
	oView:AddField( 'ID_V_FLD_ZL2', oStruZL2, 'ID_M_FLD_ZL2')

Return(oView)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TudoOK  ºAutor  ³TOTVS               º Data ³  00/00/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ 			                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TudoOK()

	Local oModel 		:= FWModelActive()
	Local oModelZL2   	:= oModel:GetModel():GetModel('ID_M_FLD_ZL2')
	Local _lRet			:= .t.
	Local _cLog			:= oModelZL2:GetValue("ZL2_LOG")
	Local _lEstoque		:= (oModelZL2:GetValue("ZL2_ESTOQU") == "1")
	Local _cTM			:= oModelZL2:GetValue("ZL2_TM")
	Local _cTpFun		:= oModelZL2:GetValue("ZL2_TPFUN")
	Local _lInclui 		:= (oModel:GetOperation() == 3)
	Local _lAltera 		:= (oModel:GetOperation() == 4)
	Local _lGrava 		:= .f.
	Local _cTexto 		:= DTOC(Date())+" "+Time()+" "+cUserName + _ENTER
	Local _cCampo 		:= ""
	Local _lAltAli 		:= .f.
	Local nI			:= 0
	Local aSX3			:= {}

	If _lInclui .or. _lAltera
		If _lEstoque .and. Empty(_cTM)
			_lRet := .f.
			Help(NIL, NIL, "Movimento Estoque", NIL, "Para movimentação do estoque é obrigatório o preenchimento do campo 'Tipo Movimen' !", 1, 0,;
				NIL, NIL, NIL, NIL, NIL, {"Preencha o campo 'Tipo Movimen'"})
		EndIf
	EndIf

	If _lRet .and. _lAltera
		aSX3 := FwSX3Util():GetAllFields("ZL2")

		For nI := 1 To Len(aSX3)
			_cCampo := "ZL2->"+ aSX3[nI]
			If  aSX3[nI] <> "ZL2_LOG" .and. GetSX3Cache(aSX3[nI], "X3_CONTEXT") == 'R'
				if &_cCampo <> oModelZL2:GetValue(aSX3[nI])
					If GetSX3Cache(aSX3[nI], "X3_TIPO") == "N"
						_cTexto += "Alterado " + AllTrim(GetSX3Cache(aSX3[nI], "X3_TITULO")) + " de ";
							+ AllTrim(Transform(&_cCampo, GetSX3Cache(aSX3[nI], "X3_PICTURE"))) + " para ";
							+ AllTrim(Transform(oModelZL2:GetValue(aSX3[nI]),Alltrim(GetSX3Cache(aSX3[nI], "X3_PICTURE")))) + _ENTER
					else
						_cTexto += "Alterado " + AllTrim(GetSX3Cache(aSX3[nI], "X3_TITULO")) + " de ";
							+ AllTrim(&_cCampo) + " para " + AllTrim(oModelZL2:GetValue(aSX3[nI])) + _ENTER
					EndIf
					_lGrava := .t.

					If Alltrim(aSX3[nI]) $ 'ZL2_ALQSEN/ZL2_ALQINS/ZL2_ALQRAT' //Se foi alterado aliquotas
						_lAltAli := .t.
					EndIf
				ENDIF
			endIf
		Next nI
	EndIf

	If _lRet .and. _lGrava
		oModelZL2:LoadValue("ZL2_LOG",_cLog+_cTexto)
	EndIf

	If _lRet .and. _lAltAli
		_cAlqFun := AllTrim(cValToChar(oModelZL2:GetValue("ZL2_ALQSEN")+oModelZL2:GetValue("ZL2_ALQINS")+oModelZL2:GetValue("ZL2_ALQRAT")))

		If _cTpFun == "N" //Não separa o cálculo de funrural, portano o parâmetro MV_CONTSOC fica com alíquota total.
			PUTMV("MV_CONTSOC",_cAlqFun+"/"+_cAlqFun+"/"+_cAlqFun)
		Else //Caso separe o cálculo conforme padrão do Protheus, atualiza parâmetro, TES e natureza com as alíquotas
			_cAlqFun := AllTrim(cValToChar(oModelZL2:GetValue("ZL2_ALQRAT")))
			PUTMV("MV_CONTSOC",_cAlqFun+"/"+_cAlqFun+"/"+_cAlqFun)

			DbSelectArea("SF4")
			DbSetOrder(1)
			If SF4->(MsSeek(xFilial("SF4")+oModelZL2:GetValue("ZL2_TESTRI")))
				RecLock("SF4",.F.)
				SF4->F4_ALSENAR := oModelZL2:GetValue("ZL2_ALQSEN")
				SF4->(MsUnLock())
			EndIf
			If SF4->(MsSeek(xFilial("SF4")+oModelZL2:GetValue("ZL2_TESDIF")))
				RecLock("SF4",.F.)
				SF4->F4_ALSENAR := oModelZL2:GetValue("ZL2_ALQSEN")
				SF4->(MsUnLock())
			EndIf
			If SF4->(MsSeek(xFilial("SF4")+oModelZL2:GetValue("ZL2_TESISE")))
				RecLock("SF4",.F.)
				SF4->F4_ALSENAR := oModelZL2:GetValue("ZL2_ALQSEN")
				SF4->(MsUnLock())
			EndIf

			//Altera natureza
			DbSelectArea("SED")
			DbSetOrder(1)
			If SED->(MsSeek(xFilial("SED")+oModelZL2:GetValue("ZL2_NATURE")))
				If SED->ED_CALCINS == 'S'
					RecLock("SED",.F.)
						SED->ED_PERCINS := oModelZL2:GetValue("ZL2_ALQINS")
					SED->(MsUnLock())
				Endif
			EndIf
		EndIf

		//TES diferida de funrural sempre tem o senar preenchido.
		DbSelectArea("SF4")
		DbSetOrder(1)
		If SF4->(MsSeek(xFilial("SF4")+oModelZL2:GetValue("ZL2_TESDIS")))
			RecLock("SF4",.F.)
				SF4->F4_ALSENAR := oModelZL2:GetValue("ZL2_ALQSEN")
			SF4->(MsUnLock())
		EndIf

		If SF4->(MsSeek(xFilial("SF4")+oModelZL2:GetValue("ZL2_TESSEN")))
			RecLock("SF4",.F.)
			SF4->F4_ALSENAR := oModelZL2:GetValue("ZL2_ALQSEN")
			SF4->(MsUnLock())
		EndIf

		MsgInfo("As alíquotas foram alteradas nos cadastros de TES, Eventos e Parâmetros respectivos!","Alteração Aliquotas")
	EndIf

Return _lRet
