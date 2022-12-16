#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'TOTVS.CH'

#DEFINE _ENTER CHR(13)+CHR(10)
/*
===============================================================================================================================
Programa----------: AGLT103
Autor-------------: GUILHERME FRANÇA
Data da Criacao---: 14/08/2020
===============================================================================================================================
Descricao---------: Tela de lançamento da recepção do leite.
                    Fonte desenvolvido para substituir a função original AGLT003 que era modelo 2 somente com a tabela ZLD.
                    Foi adicionado o cabeçalho com a tabela ZLC e desenvolvida a função em MVC.
===============================================================================================================================
Uso---------------: Gestão do Leite
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
User Function AGLT103(xRotAuto,nOpc)

	Local oBrowse
	Local _cFiltro := U_FilSetor("ZLC_SETOR") + " .and. ZLC_FILIAL == "+FWxFilial("ZLC")
	Private _aNumPed	:= {}

	oBrowse := FWmBrowse():New()
	oBrowse:SetAlias( 'ZLC' )
	oBrowse:SetDescription( 'Recepção de Leite' )

	oBrowse:SetFilterDefault( _cFiltro )

	oBrowse:AddLegend( "ZLC_STATUS == 'A'", "GREEN", "Em Aberto")
	oBrowse:AddLegend( "ZLC_STATUS == 'F'" , "RED", "Mix Fechado")


	oBrowse:Activate()

Return NIL

//-------------------------------------------------------------------
Static Function MenuDef()
	Local aRotina := {}

	ADD OPTION aRotina Title 'Pesquisar' 		Action 'PesqBrw' 			OPERATION 1 ACCESS 0
	ADD OPTION aRotina Title 'Visualizar'		Action 'VIEWDEF.AGLT103' 	OPERATION 2 ACCESS 0
	ADD OPTION aRotina Title 'Incluir' 			Action 'U_GLTMNU103("I")' 	OPERATION 3 ACCESS 0
	ADD OPTION aRotina Title 'Alterar' 			Action 'U_GLTMNU103("A")' 	OPERATION 4 ACCESS 0
	ADD OPTION aRotina Title 'Imprime Ticket' 	Action 'U_RGLT023()' 		OPERATION 4 ACCESS 0
	ADD OPTION aRotina Title 'Excluir' 			Action 'U_GLTMNU103("E")' 	OPERATION 5 ACCESS 0

Return aRotina
/*
===============================================================================================================================
Programa----------: GLTMNU103
Autor-------------: GUILHERME FRANÇA
Data da Criacao---: 14/08/2020
===============================================================================================================================
Descricao---------: Validações do menu
==============================================================================================================================*/
USER Function GLTMNU103(_cTipo)

	Local _lPermissao :=  (GetAdvFVal("ZLU","ZLU_RECEPC",xFilial("ZLU")+cUserName,1,"N") == "S")

	If !_lPermissao
		Help( ,,1,"Permissão","Usuário sem permissão para incluir/editar recepção de leite", 1, 0 )
		Return
	EndIf

	IF _cTipo	= "I"
		lOk := ( FWExecView('Validação de Inclusao','AGLT103', MODEL_OPERATION_INSERT,, ,  ) == 0 )
			//Indica se para este setor será impresso cupom do ticket.
			If ZL2->(FieldPos("ZL2_IMPCUP")) > 0
				If ZL2->ZL2_IMPCUP == "S"
					U_RGLT008()
				EndIf
			EndIf

	ELSEIF _cTipo	= "A"
		IF ZLC->ZLC_STATUS <> "F"
			lOk := ( FWExecView('Validação de Alteração','AGLT103', MODEL_OPERATION_UPDATE,, ,  ) == 0 )
		ELSE
			Help( ,,1,"MIX FECHADO","NÃO é permitido ALTERAR este movimento pois o MIX já está fechado!", 1, 0 )
		ENDIF
	ELSEIF _cTipo = 'E'
		IF ZLC->ZLC_STATUS <> "F"
			lOk := ( FWExecView('Validação de Exclusão','AGLT103', MODEL_OPERATION_DELETE,, ,  ) == 0 )
		ELSE
			Help( ,,1,"MIX FECHADO","NÃO é permitido EXCLUIR este movimento pois o MIX já está fechado!", 1, 0 )
		ENDIF
	ENDIF

RETURN


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ModelDef º Autor ³ Guilherme França   º Data ³ 11/08/2015  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Construção da View Def                                     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ModelDef()
	// Cria a estrutura a ser usada no Modelo de Dados
	Local oStruZLC	:= FWFormStruct( 1, 'ZLC', /*bAvalCampo*/, /*lViewUsado*/ )
	Local oStruZLD	:= FWFormStruct( 1, 'ZLD', /*bAvalCampo*/, /*lViewUsado*/ )
	Local oModel

	// Cria o objeto do Modelo de Dados
	oModel := 	MPFormModel():New( 'AGLT103M', /*bPreValidacao*/, { |oModel| TudoOk(oModel)} /*bPosValidacao*/,/*{ |oMdl| GrvZLD( oMdl ) } bCommit*/, /*bCancel*/ )

	//Ajusta propriedades dos campos
	SetPropM(oStruZLC, oStruZLD)

	// Adiciona ao modelo uma estrutura de formulário de edição por campo
	oModel:AddFields( 'ZLCMASTER', /*cOwner*/, oStruZLC )

	// Adiciona ao modelo uma estrutura de formulário de edição por grid
	oModel:AddGrid( 'ZLDDETAIL', 'ZLCMASTER', oStruZLD, { |oModelGrid, nLine,cAction, cField| VldDelLin(oModelGrid, nLine, cAction, cField) }/*bLinePre*/, /*bLinePost*/, /*bPreVal*/,/*{ || ValidaLin(1) } /*bPosVal*/, /*BLoad*/ )

	// Adiciona a descricao do Componente do Modelo de Dados
	oModel:SetDescription('Recepção de Leite')
	oModel:GetModel( 'ZLCMASTER' ):SetDescription( 'Dados do Ticket' )
	oModel:GetModel( 'ZLDDETAIL' ):SetDescription( 'Produtores' )

	// Faz relaciomaneto entre os compomentes do model
	oModel:SetRelation( 'ZLDDETAIL', { { 'ZLD_FILIAL', 'xFilial( "ZLD" )' }, { 'ZLD_TICKET', 'ZLC_TICKET' },;
	{ 'ZLD_SETOR', 'ZLC_SETOR' },;
	{ 'ZLD_DTCOLE', 'ZLC_DTCOLE' },{ 'ZLD_DTLANC', 'ZLC_DTLANC' },;
	{ 'ZLD_FRETIS', 'ZLC_FRETIS' },{ 'ZLD_LJFRET', 'ZLC_LJFRET' },;
	{ 'ZLD_TOTBOM', 'ZLC_QTDVEI' }, { 'ZLD_ROTCAB', 'ZLC_ROTCAB' } }, ZLD->( IndexKey( 1 ) ) )

	// Liga o controle de nao repeticao de linha
	oModel:GetModel( 'ZLDDETAIL' ):SetUniqueLine( { 'ZLD_RETIRO','ZLD_RETILJ' } )

	// Indica que é opcional ter dados informados na Grid
	oModel:GetModel( 'ZLDDETAIL' ):SetOptional(.F.)

	oModel:SetPrimaryKey({'ZLC_TICKET'})

Return oModel

/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
	±±ºPrograma  ³ ViewDef  º Autor ³ Guilherme França º Data ³ 11/06/2015  º±±
	±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
	±±ºDescri‡„o ³ Construção da View Def                                     º±±
	±±º          ³                                                            º±±
	±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
	±±ºUso       ³                                                            º±±
	±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ViewDef()
	// Cria um objeto de Modelo de Dados baseado no ModelDef do fonte informado
	Local oStruZLC 	:= FWFormStruct( 2, 'ZLC' )
	Local oStruZLD	:= FWFormStruct( 2, 'ZLD' )

	// Cria a estrutura a ser usada na View
	Local oModel   	:= FWLoadModel( 'AGLT103' )
	Local oView

	RemovFV(oStruZLC,oStruZLD) //Remove campos da view

	// Cria o objeto de View
	oView := FWFormView():New()

	// Define qual o Modelo de dados será utilizado
	oView:SetModel( oModel )

	//Adiciona no nosso View um controle do tipo FormFields(antiga enchoice)
	oView:AddField( 'VIEW_ZLC', oStruZLC, 'ZLCMASTER' )

	//Adiciona no nosso View um controle do tipo FormGrid(antiga newgetdados)
	oView:AddGrid(  'VIEW_ZLD', oStruZLD, 'ZLDDETAIL' )


	// Criar um "box" horizontal para receber algum elemento da view
	oView:CreateHorizontalBox( 'SUPERIOR'	, 50 )
	oView:CreateHorizontalBox( 'INFERIOR' 	, 50 )

	// Relaciona o ID da View com o "box" para exibicao
	oView:SetOwnerView( 'VIEW_ZLC'	, 'SUPERIOR' )
	oView:SetOwnerView( 'VIEW_ZLD'	, 'INFERIOR' )

	// Define campos que terao Auto Incremento
	oView:AddIncrementField( 'VIEW_ZLD', 'ZLD_ITEM' )

	// Criar novo botao na barra de botoes
	oView:AddUserButton( 'Importar Coletas', 'CLIPS', { |oView| IMPORTCSV() } )
	oView:AddUserButton( 'Coletas SQ', 'CLIPS', { |oView| FWMsgRun(, {|oSay| IMPORTSQ(oSay) },'Aguarde', 'Lendo Smartquestion...') } )

Return oView


/*
===============================================================================================================================
Programa----------: RemovFV
Autor-------------: GUILHERME FRANÇA
Data da Criacao---: 21/08/2020
===============================================================================================================================
Descricao---------: remove campos da view
==============================================================================================================================*/
Static Function RemovFV(oStruZLC, oStruZLD)

	Local _aZLD := {'ZLD_TICKET','ZLD_DTCOLE','ZLD_DTLANC','ZLD_SETOR' ,'ZLD_FRETIS','ZLD_LJFRET',;
					'ZLD_TOTBOM','ZLD_KM' ,'ZLD_ROTCAB','ZLD_DESCAB','ZLD_STATUS','ZLD_QTDH2O','ZLD_DESH2O'}
	Local ix := 0

	oStruZLC:RemoveField( 'ZLC_STATUS' )
	oStruZLC:RemoveField( 'ZLC_TIKMED' )
	oStruZLC:RemoveField( 'ZLC_LOTE' )
	oStruZLC:RemoveField( 'ZLC_TKPESO' )

	//varios campos foram mantidos na ZLD para compatibilização com rotinas/relatórios antigos
	For ix := 1 to Len(_aZLD)
		oStruZLD:RemoveField( _aZLD[ix] )
	Next ix

Return
/*
===============================================================================================================================
Programa----------: SetPropM
Autor-------------: GUILHERME FRANÇA
Data da Criacao---: 21/08/2020
===============================================================================================================================
Descricao---------: Define propriedades no MODEL
==============================================================================================================================*/

Static Function SetPropM(oStruZLC, oStruZLD)

	//Inicializações
	oStruZLC:SetProperty( 'ZLC_TICKET'	, MODEL_FIELD_INIT, {|| U_getCodN("ZLC_TICKET")} )
	oStruZLC:SetProperty( 'ZLC_SETOR'	, MODEL_FIELD_INIT,{|| '000001'} )
	oStruZLC:SetProperty( 'ZLC_STATUS'	, MODEL_FIELD_INIT,{|| 'A'} )

	//Validações de campos do cabeçalho
	oStruZLC:SetProperty( 'ZLC_DTCOLE'	, MODEL_FIELD_VALID,{|| VldCampos('ZLC_DTCOLE') } )
	oStruZLC:SetProperty( 'ZLC_FRETIS'	, MODEL_FIELD_VALID,{|| VldCampos('ZLC_FRETIS') } )
	oStruZLC:SetProperty( 'ZLC_ROTCAB'	, MODEL_FIELD_VALID,{|| VldCampos('ZLC_ROTCAB') } )
	oStruZLC:SetProperty( 'ZLC_HORDES'	, MODEL_FIELD_VALID,{|| VldCampos('ZLC_HORDES') } )
	oStruZLC:SetProperty( 'ZLC_QTDVEI'	, MODEL_FIELD_VALID,{|| VldCampos('ZLC_QTDVEI') } )
	oStruZLC:SetProperty( 'ZLC_VEICUL'	, MODEL_FIELD_VALID,{|| VldCampos('ZLC_VEICUL') } )

	//Validações de campos dos itens
	oStruZLD:SetProperty( 'ZLD_RETIRO'	, MODEL_FIELD_VALID,{|| VldCampos('ZLD_RETIRO') } )
	oStruZLD:SetProperty( 'ZLD_QTDBOM'	, MODEL_FIELD_VALID,{|| VldCampos('ZLD_QTDBOM') } )
	oStruZLD:SetProperty( 'ZLD_HORA'	, MODEL_FIELD_VALID,{|| VldCampos('ZLD_HORA') } )

	//Permite edição do campo
	oStruZLD:SetProperty( 'ZLD_USER'	, MODEL_FIELD_WHEN,{|| .F. } )

Return

/*
===============================================================================================================================
Programa----------: VldCampos
Autor-------------: GUILHERME FRANÇA
Data da Criacao---: 14/08/2020
===============================================================================================================================
Descricao---------: Validações dos campos
==============================================================================================================================*/

Static Function VldCampos(xcCampo)

	Local oModel 	:= FWModelActive()
	Local oView 	:= FWViewActive()
	Local oStruZLC	:= oModel:GetModel('ZLCMASTER')
	Local oStruZLD	:= oModel:GetModel('ZLDDETAIL')
	Local _lRet := .t.
	Local _cCampo := xcCampo //Alltrim(SubStr(ReadVar(),4,10))
	Local _dDtCole := DTOS(oStruZLC:GetValue("ZLC_DTCOLE"))
	Local _cAliZLW := ""
	Local _cAliSA2 := ""
	Local ix := 0
	Local _nLinAtu := 0

	If _cCampo == 'ZLC_DTCOLE'
		If _dDtCole > DTOS(DDATABASE)
			_lRet := .f.
			Help(,,"Data Coleta",,"Data coleta inválida!", 1, 0,,,,,, {"Informe data menor ou igual a data base."})
		EndIf

		If _lRet
			BeginSql alias 'TZLE'
			SELECT ZLE_FILIAL, ZLE_COD AS MIX, ZLE_STATUS AS STATUS
			FROM %Table:ZLE% ZLE
			WHERE %Exp:_dDtCole% BETWEEN ZLE_DTINI AND ZLE_DTFIM
			AND ZLE.%NotDel%
			EndSql

			If !TZLE->(Eof())
				If xFilial("ZLC") = TZLE->ZLE_FILIAL .AND. TZLE->STATUS $ 'F/P'
					_lRet := .f.
					Help(,,"DTCOLETA",,"Data coleta inválida! Mix do período já fechado ou preparado.", 1, 0,,,,,, {"Informe data válida."})
				Endif
			EndIf
			TZLE->(dbCloseArea())
		EndIf
	EndIf

	If _cCampo == 'ZLC_HORDES
		_lRet := AtVldHora(oStruZLC:GetValue("ZLC_HORDES"))
	EndIf

	If _cCampo == 'ZLD_HORA'
		_lRet := AtVldHora(oStruZLD:GetValue("ZLD_HORA"))
	EndIf

	If _cCampo == 'ZLC_QTDVEI'
		If oStruZLC:GetValue("ZLC_QTDPRD") > 0
			oStruZLC:LoadValue("ZLC_QTDDIF",oStruZLC:GetValue("ZLC_QTDVEI") - oStruZLC:GetValue("ZLC_QTDPRD"))
		EndIf
	EndIf

	If _cCampo == 'ZLC_VEICUL'
		DBSelectArea("ZL4")
		ZL4->(DBSetOrder(1))
		If ZL4->(MsSeek(xFilial("ZL4")+oStruZLC:GetValue("ZLC_VEICUL")))
			oStruZLC:LoadValue("ZLC_MOTOR",ZL4->ZL4_MOTORI)
		EndIf
	EndIf

	If _cCampo == 'ZLC_ROTCAB'
		_cRota := oStruZLC:GetValue("ZLC_ROTCAB")
		_cAliZLW := GetNextAlias()
		BeginSql alias _cAliZLW
		SELECT ZLW_COD , ZLW_DESCRI, MAX(ZLW_VERSAO) ZLW_VERSAO, ZLW_KM, ZLW_KMTERR,
				ZLW_FRETIS, ZLW_FRETLJ, ZLW_SETOR, ZLW_VEICUL, A2_NOME
		FROM %TABLE:ZLW% ZLW
			JOIN %TABLE:SA2% SA2 ON A2_COD = ZLW_FRETIS AND A2_LOJA = ZLW_FRETLJ AND SA2.%NotDel%
		WHERE  ZLW.ZLW_COD  = %EXP:_cRota%
		AND ZLW.ZLW_MSBLQL <> '1'
		AND ZLW.%NotDel%
		GROUP BY ZLW_COD , ZLW_DESCRI, ZLW_KM, ZLW_KMTERR, ZLW_FRETIS, ZLW_FRETLJ, ZLW_SETOR, ZLW_VEICUL, A2_NOME
		EndSql

		If !(_cAliZLW)->(Eof())
			oStruZLC:LoadValue("ZLC_DESCAB" ,(_cAliZLW)->ZLW_DESCRI)
			oStruZLC:LoadValue("ZLC_KM"		,(_cAliZLW)->ZLW_KM)
			oStruZLC:LoadValue("ZLC_KMTERR" ,(_cAliZLW)->ZLW_KMTERR)
			oStruZLC:LoadValue("ZLC_SETOR" ,(_cAliZLW)->ZLW_SETOR)

			oStruZLC:LoadValue("ZLC_VEICUL" ,(_cAliZLW)->ZLW_VEICUL)
			oStruZLC:LoadValue("ZLC_FRETIS",(_cAliZLW)->ZLW_FRETIS)
			oStruZLC:LoadValue("ZLC_LJFRET",(_cAliZLW)->ZLW_FRETLJ)
			oStruZLC:LoadValue("ZLC_NOMETR",(_cAliZLW)->A2_NOME)
			DBSelectArea("ZL4")
			ZL4->(DBSetOrder(1))
			If ZL4->(MsSeek(xFilial("ZL4")+(_cAliZLW)->ZLW_VEICUL))
				oStruZLC:LoadValue("ZLC_VEICUL",ZL4->ZL4_COD)
				oStruZLC:LoadValue("ZLC_MOTOR",ZL4->ZL4_MOTORI)
			EndIf
			If (oView <> NIL) //Se for via sigaauto não faz a pergunta.
				If MsgYesNo("Deseja preencher a grid com os produtores da rota selecionada?","Preenchimento Automatico")
					Processa( {|| GERAGRID(_cRota,(_cAliZLW)->ZLW_VERSAO) }, "Aguarde...", "Buscando produtores da rota...",.F.)
				EndIf
			EndIf
		Else
			Help(,,"CODROTA",,"Código de rota invalido ou bloqueado!", 1, 0,,,,,, {"Informe uma rota válida para prosseguir com o lançamento."})
			_lRet := .f.
		EndIf
		(_cAliZLW)->(DbCloseArea())

	EndIf

	If _cCampo $ 'ZLC_FRETIS/ZLC_LJFRET'
		_cTransp := oStruZLC:GetValue("ZLC_FRETIS")
		_cLjTran := oStruZLC:GetValue("ZLC_LJFRET")
		_cLjTran := IIF(Empty(_cLjTran),StrZero(1,TamSx3("A2_LOJA")[1]),_cLjTran)
		If SubStr(_cTransp,1,1) <> 'T'
			Help(,,"FRETISTA",,"Código inválido para esta operação.", 1, 0,,,,,, {"Informe um cadastro iniciado com a letra T."})
			_lRet := .f.
		Else
			dbSelectArea("SA2")
			SA2->(dbSetOrder(1))
			If SA2->(MsSeek(xFILIAL("SA2") + _cTransp + _cLjTran))
				If SA2->A2_MSBLQL <> '1'
					oStruZLC:LoadValue("ZLC_LJFRET",SA2->A2_LOJA)
					oStruZLC:LoadValue("ZLC_NOMETR",SA2->A2_NOME)
				Else
					Help(,,"FRETISTA",,"Código bloqueado para uso.", 1, 0,,,,,, {"Informe um cadastro iniciado com a letra T válido."})
					_lRet := .f.
				EndIf
			Else
				Help(,,"FRETISTA",,"Código não encontrato.", 1, 0,,,,,, {"Informe um cadastro iniciado com a letra T."})
				_lRet := .f.
			EndIf
		EndIf
	EndIf


	If _cCampo $ 'ZLD_RETIRO/ZLD_RETILJ'
		_cProdut := Alltrim(oStruZLD:GetValue("ZLD_RETIRO"))
		_cLoja   := Alltrim(oStruZLD:GetValue("ZLD_RETILJ"))
		_cLoja   := IIF(Empty(_cLoja), StrZero(1,TamSx3("ZLD_RETILJ")[1]),_cLoja)

		If Len(_cProdut) < TamSx3("ZLD_RETIRO")[1]
			//Completa código digitado reduzido
			_cProdut := "% A2_COD LIKE '%"+_cProdut+"%'  %"
			_cAliSA2 := GetNextAlias()
			BeginSql alias _cAliSA2
			SELECT MIN(A2_COD) A2_COD, MIN(A2_LOJA) A2_LOJA
			FROM %Table:SA2% SA2
			WHERE A2_L_TPFOR = 'P' AND %Exp:_cProdut%
			AND A2_MSBLQL <> '1' AND SA2.%NotDel%
			EndSql
			If !(_cAliSA2)->(Eof())
				_cProdut := (_cAliSA2)->A2_COD
				_cLoja := (_cAliSA2)->A2_LOJA
			EndIf
			(_cAliSA2)->(DbCloseArea())
		EndIf

		DBSelectArea("SA2")
		DBSetOrder(1)
		If SA2->(MsSeek(xFilial("SA2")+_cProdut+_cLoja))
			If SA2->A2_L_TPFOR <> 'P' .or. SA2->A2_MSBLQL == '1'
				Help(,,"Produtor",,"Cadastro não é de produtor ou está bloqueado!", 1, 0,,,,,, {"Informe um cadastro do tipo 'P' válido."})
				_lRet := .f.
			Else
				oStruZLD:LoadValue("ZLD_RETIRO",SA2->A2_COD)
				oStruZLD:LoadValue("ZLD_RETILJ",SA2->A2_LOJA)
				oStruZLD:LoadValue("ZLD_DCRRET",SubStr(SA2->A2_NOME,1,TamSx3("ZLD_DCRRET")[1]))
				oStruZLD:LoadValue("ZLD_GRPRC",SA2->A2_L_LI_RO)
				_aRota := GatilhoRota(_cProdut,_cLoja)
				oStruZLD:LoadValue("ZLD_LINROT",_aRota[1])
				oStruZLD:LoadValue("ZLD_VERSAO",_aRota[2])
				oStruZLD:LoadValue("ZLD_DESLIN",_aRota[3])
			EndIf
		Else
			Help(,,"Produtor",,"Cadastro não localizado!", 1, 0,,,,,, {"Informe um cadastro do tipo 'P' válido."})
			_lRet := .f.
		EndIf
	EndIf


	If _cCampo $ 'ZLD_QTDBOM'
		_nLinAtu := oStruZLD:nLine
		_nTotProd := 0
		For ix:=1 To oStruZLD:Length()
			oStruZLD:GoLine(ix)
			If !oStruZLD:IsDeleted()
				_nTotProd += oStruZLD:GetValue("ZLD_QTDBOM")
			EndIf
		Next ix
		oStruZLC:LoadValue("ZLC_QTDPRD",_nTotProd)
		oStruZLC:LoadValue("ZLC_QTDDIF",oStruZLC:GetValue("ZLC_QTDVEI") - _nTotProd)
		oStruZLD:GoLine(_nLinAtu)
	EndIf

	If (oView <> NIL)
		oView:Refresh()
	EndIf

Return _lRet

/*
===============================================================================================================================
Programa----------: VldDelLin()
Autor-------------: GUILHERME FRANÇA
Data da Criacao---: 01/09/2020
===============================================================================================================================
Descricao---------: Validação de deleção da linha.
==============================================================================================================================*/

Static Function VldDelLin( oModelGrid, nLinha, cAcao, cCampo )

	Local _lRet := .T.
	Local oModel := oModelGrid:GetModel()
	Local oStruZLC	:= oModel:GetModel('ZLCMASTER')
	Local oStruZLD	:= oModel:GetModel('ZLDDETAIL')
	Local oView 	:= FWViewActive()

	If cAcao == 'DELETE'
		oStruZLC:LoadValue("ZLC_QTDPRD",oStruZLC:GetValue("ZLC_QTDPRD") - oStruZLD:GetValue("ZLD_QTDBOM"))
	ElseIf cAcao == 'UNDELETE'
		oStruZLC:LoadValue("ZLC_QTDPRD",oStruZLC:GetValue("ZLC_QTDPRD") + oStruZLD:GetValue("ZLD_QTDBOM"))
	EndIf

	If cAcao != 'SETVALUE'
		oStruZLC:LoadValue("ZLC_QTDDIF",oStruZLC:GetValue("ZLC_QTDVEI") - oStruZLC:GetValue("ZLC_QTDPRD"))
		oStruZLD:GoLine(nLinha)
		oView:Refresh()
	EndIf

Return _lRet

/*
===============================================================================================================================
Programa----------: ValidaLin
Autor-------------: GUILHERME FRANÇA
Data da Criacao---: 21/08/2020
===============================================================================================================================
Descricao---------: Validações na troca da linha.
==============================================================================================================================*/

// NÃO ESTÁ SENDO USADA.

Static Function ValidaLin()

	Local oModel 	:= FWModelActive()
	Local nOperation	:=	oModel:GetOperation()
	Local oStruZLC	:= oModel:GetModel('ZLCMASTER')
	Local oStruZLD	:= oModel:GetModel('ZLDDETAIL')
	Local _nQtdMix	:= oStruZLC:GetValue("ZLC_TOTMIX")
	Local _nSaldo 	:= _nQtdMix //oStruZLC:GetValue("ZLC_SALDO")
	Local _nQtd 	:= oStruZLD:GetValue("ZLD_QTD")
	Local _nLin		:= oStruZLD:GetQTDLine()
	Local _lDel	:=	IIf(xOpc==1,.t.,.f.)
	Local nL	:=	0
	//Se a linha foi deletada, retorna o saldo do produtor origem
	If nOperation == 3 .or. nOperation == 4
		For nL := 1 TO _nLin
			oStruZLD:GoLine(nL)
			_nQtd 	:= oStruZLD:GetValue("ZLD_QTD")

			IF !oStruZLD:IsDeleted(nL) .and. _nQtd>0
				_nSaldo	-= _nQtd
				_nTransf += _nQtd
			ENDIF

			If _lDel .and. _nQtd == 0
				oStruZLD:DeleteLine()
			EndIf

		Next nL

		oStruZLC:LoadValue("ZLC_SALDO",_nSaldo)
	EndIf

Return .t.


/*
===============================================================================================================================
Programa----------: GERAGRID
Autor-------------: GUILHERME FRANÇA
Data da Criacao---: 14/08/2020
===============================================================================================================================
Descricao---------: Preenche grid com produtores da rota selecionada.
==============================================================================================================================*/
Static Function GERAGRID(xcRota,xcVersao)

	Local oModel 	:= FWModelActive()
	Local oStruZLC	:= oModel:GetModel('ZLCMASTER')
	Local oStruZLD	:= oModel:GetModel('ZLDDETAIL')
	Local _cTicket := oStruZLC:GetValue("ZLC_TICKET")
	Local _cAlias := GetNextAlias()
	Local _nItem	:= 1
	Local _nQtdLin := oStruZLD:GetQTDLine()
	Local _nLinha	:= 1
	Local xi := 0

	If _nQtdLin > 1
		FOR xi := 1 TO _nQtdLin
		oStruZLD:GoLine(xi)
		oStruZLD:DeleteLine()
		NEXT
	EndIf

	IncProc("Localizando Produtores...")


	BeginSql Alias _cAlias

	SELECT	ZLZ_CODPRO as ZLD_RETIRO,
	ZLZ_LJPROD as ZLD_RETILJ,
	A2_L_LI_RO as ZLD_GRPRC,
	A2_NOME    as ZLD_DCRRET,
	ZLZ_ROTA   as ZLD_LINROT,
	ZLW_VERSAO AS ZLD_VERSAO,
	ZLW_DESCRI as ZLD_DESLIN,
	ZLZ_FILIAL, ZLZ_ROTA, ZLZ_VERSAO, ZLZ_ITEM

	FROM %Table:ZLZ% ZLZ

	JOIN %Table:SA2% SA2
	ON A2_FILIAL = %xFilial:SA2% AND A2_COD = ZLZ_CODPRO AND A2_LOJA = ZLZ_LJPROD
	AND SA2.%NotDel%

	JOIN %Table:ZLW% ZLW ON ZLW_FILIAL = %xFilial:ZLW% AND ZLW_COD = ZLZ_ROTA
	AND ZLW_VERSAO = %Exp:xcVersao%  AND ZLW.%NotDel%

	WHERE ZLZ_FILIAL = %xFilial:ZLZ%
	AND ZLZ.ZLZ_ROTA = %Exp:xcRota%
	AND   ZLZ.%NotDel%

	ORDER BY ZLZ_FILIAL, ZLZ_ROTA, ZLZ_VERSAO, ZLZ_ITEM, A2_NOME

	EndSql

	If !(_cAlias)->(Eof())
		While !(_cAlias)->(Eof())

			IF _nLinha <= _nQtdLin
				oStruZLD:GoLine(_nLinha)
				IF oStruZLD:IsDeleted(_nLinha)
					oStruZLD:UnDeleteLine()
				ENDIF
			ELSE
				oStruZLD:AddLine()
			ENDIF

			oStruZLD:LoadValue("ZLD_TICKET",_cTicket)
			oStruZLD:LoadValue("ZLD_ITEM",StrZero(_nItem,TamSx3("ZLD_ITEM")[1]))
			oStruZLD:LoadValue("ZLD_RETIRO",(_cAlias)->ZLD_RETIRO)
			oStruZLD:LoadValue("ZLD_RETILJ",(_cAlias)->ZLD_RETILJ)
			oStruZLD:LoadValue("ZLD_DCRRET",(_cAlias)->ZLD_DCRRET)
			oStruZLD:LoadValue("ZLD_GRPRC",(_cAlias)->ZLD_GRPRC)
			oStruZLD:LoadValue("ZLD_LINROT",(_cAlias)->ZLD_LINROT)
			oStruZLD:LoadValue("ZLD_VERSAO",(_cAlias)->ZLD_VERSAO)
			oStruZLD:LoadValue("ZLD_DESLIN",(_cAlias)->ZLD_DESLIN)

			(_cAlias)->(DbSkip())
			_nItem++
			_nLinha++
		EndDo
		oStruZLD:GoLine(1)
	Else
		MsgInfo("Não foram encontrados produtores amarrados a rota: "+xcRota)
	Endif

	(_cAlias)->(DBCLOSEAREA())

Return .T.

/*
===============================================================================================================================
Programa----------: GatilhoRota
Autor-------------: GUILHERME FRANÇA
Data da Criacao---: 14/08/2020
===============================================================================================================================
Descricao---------: Localiza e retorna rota ativa do produtor
==============================================================================================================================*/
Static Function  GatilhoRota(xcCod,xcLoja)

	Local _cAlias := GetNextAlias()
	Local _aRet := {"","",""}

	BeginSql alias _cAlias
		SELECT LZ.ZLZ_ROTA ROTA, MAX(LZ.ZLZ_VERSAO) VERSAO, LW.ZLW_DESCRI DESCRI , MAX(LW.ZLW_VERSAO) VERSAOLW
		FROM %TABLE:ZLZ% LZ
		JOIN %TABLE:ZLW% LW ON LW.ZLW_COD = ZLZ_ROTA
				AND LW.ZLW_MSBLQL <> '1' AND LW.%NotDel%
		WHERE LZ.ZLZ_CODPRO = %EXP:xcCod% AND ZLZ_LJPROD = %EXP:xcLoja% AND LZ.%NotDel%
		GROUP BY ZLZ_ROTA, ZLW_DESCRI
	EndSql

	If !(_cAlias)->(Eof())
		_aRet[1] := (_cAlias)->ROTA
		_aRet[2] := (_cAlias)->VERSAOLW
		_aRet[3] := (_cAlias)->DESCRI
	EndIf

	(_cAlias)->(DbCloseArea())

Return _aRet


/*
===============================================================================================================================
Programa----------: TudoOk
Autor-------------: GUILHERME FRANÇA
Data da Criacao---: 14/08/2020
===============================================================================================================================
Descricao---------: Valida confirmação da tela.
==============================================================================================================================*/

Static Function TudoOk(oModel)

	Local _aArea    := GetArea()
	Local _lRet 	:= .T.
	Local oStruZLC 	:= oModel:GetModel("ZLCMASTER")
	Local oStruZLD  := oModel:GetModel("ZLDDETAIL")
	Local _cSetor   := oStruZLC:GetValue("ZLC_SETOR")
	Local _nQtdPrd  := oStruZLC:GetValue("ZLC_QTDPRD")
	Local _nQtdVei  := oStruZLC:GetValue("ZLC_QTDVEI")
	Local _dDtLanc  := oStruZLC:GetValue("ZLC_DTLANC")
	Local _nQtdSD3 	:= 0
	Local _cTicket  := oStruZLC:GetValue("ZLC_TICKET")
	Local aAutoSD3 	:= {}
	Local _lCusto 	:= .F.
	Local _cCustoD3 := 0
	Local _lRastro  := GetMv("MV_RASTRO") == "S"  //Verifica se o sistema efetuara o controle de rastreabilidade
	Local _nModBkp  := nModulo
	Local _cModBkp	:= cModulo
	Local ix 		:= 0
	Local _nOpc     := oModel:GetOperation()
	Local _lDelete  := _nOpc == 5
	Local _lInclui  := _nOpc == 3
	Local _lAltera  := _nOpc == 4
	Local _lEstOK 	:= .t.
	Local _nPrcDif 	:= 0
	Private	lMsHelpAuto := .T.
	Private	lMsErroAuto := .F.

	//Semaforo para pemitir a gravação de mais de um usuário por vez
	While !LockByName("AGLT103",.T.,.F. )
		MsAguarde({|| Sleep(2000) }, "Semaforo de processamento...", "Aguarde, salvando registros")
		If _nX > 60
			If !MsgYesNo("O processo está preso por outro usuário. Deseja continuar aguardando?"+_ENTER;
				+"Caso você clique em NAO, os dados digitados serão perdidos!!")
				FreeUsedCode()  //libera codigos de correlativos reservados pela MayIUseCode()
				Return
			EndIf
			_nX := 0
		EndIf
		_nX++
	EndDo

	For ix:=1 To oStruZLD:Length()
		oStruZLD:GoLine(ix)
		If !oStruZLD:IsDeleted()
			If Empty(oStruZLD:GetValue("ZLD_RETIRO")) .or. Empty(oStruZLD:GetValue("ZLD_GRPRC")) ;
				.or. Empty(oStruZLD:GetValue("ZLD_LINROT")) .or. (oStruZLD:GetValue("ZLD_QTDBOM") < 1)
				_lRet := .f.
			EndIf
		EndIf
	Next ix

	If !_lRet
		Help(,,"VALIDAGRID",,"Existem campos obrigatorios não preenchidos na grid!", 1, 0,,,,,,;
		{"Verifique os campos: Produtor/Quantidade/Rota/Grupo Preço!"})
	Else
		//Posiciona no setor para pegar parâmetros
		DBSelectArea("ZL2")
		DBSetOrder(1)
		MsSeek(xFilial("ZL2")+_cSetor)

		If !_lDelete
			oStruZLC:LoadValue("ZLC_QTDDIF",_nQtdVei - _nQtdPrd)

			//Validação da diferença entre coleta e veículo, necessário criar o campo na ZL2_PRCDIF ZL2
			If FieldPos("ZL2_PRCDIF") > 0
				_nPrcDif := ZL2->ZL2_PRCDIF / 100
				If (ABS(_nQtdVei - _nQtdPrd) / _nQtdVei ) > _nPrcDif
					Help(,,"VALIDADIF",,"Diferença entre veículo e coleta acima do percentual permitido! "+Transform(ZL2->ZL2_PRCDIF,PesPict("ZL2_PRCDIF"))+"%", 1, 0,,,,,,;
					{"Confira os volumes apontados!"})
					_lRet := .f.
				EndIf
			EndIf
		EndIf


		If _lRet .and. ZL2->ZL2_ESTOQU == '1' //Verifica se deve gerar movimentação de estoque.
			_nQtdSD3 := IIF(ZL2->ZL2_ESTORI == "V",_nQtdVei,_nQtdPrd) //Verifica se o estoque será gerado pelo volume do veículo ou coleta na fazenda

			_cCustoD3 := _nQtdSD3 * IIF(ZL2->ZL2_ULTMIX>0,ZL2->ZL2_ULTMIX,1)

			//Posiciona no de Tipos de Movimentos
			dbSelectArea("SF5")
			dbSetOrder(1)
			If !dbSeek(xFILIAL("SF5") + ZL2->ZL2_TM)
				Help(,,"Movimento Estoque",,"O codigo de Movimento Interno (SF5) " + ZL2->ZL2_TM + " não foi encontrado.", 1, 0,,,,,, {"Preencha corretamente no cadastro de SETOR antes de prosseguir!"})
				Return(.F.)
			EndIf
			_lCusto := (SF5->F5_VAL == 'S')


			//Posiciona cadastro de produto
			dbSelectArea("SB1")
			dbSetOrder(1)
			MsSeek(xFILIAL("SB1") + ZL2->ZL2_PRODUT)

			dbSelectArea("SB2")
			SB2->(dbSetOrder(1))
			If !SB2->(MsSeek(xFILIAL("SB2") + SB1->B1_COD + ZL2->ZL2_LOCAL))
				CriaSB2(SB1->B1_COD,ZL2->ZL2_LOCAL) //cria saldo inicial caso não exista
			EndIf

			/*****************************************************************************
			* Em caso de alteração, é necessário estornar o movimento e incluir um novo. *
			*
			****************************************************************************/
			If _lAltera .or. _lDelete
				_cAliD3 :=GetNextAlias()
				BeginSql alias _cAliD3
					SELECT D3_NUMSEQ, D3_CHAVE, D3_COD, D3_QUANT
					FROM %Table:SD3% SD3
					WHERE
					D3_FILIAL = %xFilial:SD3%
					AND D3_TM = %Exp:ZL2->ZL2_TM%
					AND D3_ESTORNO <> 'S'
					AND D3_L_ORIG  = %Exp:_cTicket%
					AND D3_L_SETOR = %Exp:_cSetor%
					AND SD3.%NotDel%
				EndSql
				If !(_cAliD3)->(Eof())
					If _lAltera .and. (_cAliD3)->D3_QUANT = _nQtdSD3
						_lEstOK := .f. // Só estorna e inclui novo movimento se a quantidade estiver sido alterada.
					EndIf

					If _lEstOK
						aAutoSD3    := {}
						aadd(aAutoSD3, {"D3_FILIAL", xFilial("SD3")      , Nil}) // Filial
						aadd(aAutoSD3, {"D3_NUMSEQ", (_cAliD3)->D3_NUMSEQ, Nil}) // Nro sequencial do movimento
						aadd(aAutoSD3, {"D3_CHAVE" , (_cAliD3)->D3_CHAVE , Nil}) // Chave de busca do registro
						aadd(aAutoSD3, {"D3_COD"   , (_cAliD3)->D3_COD   , Nil}) // Codigo do Produto
						aadd(aAutoSD3, {"INDEX"    , 4                   , Nil}) // Indice
						//Estorna movimento interno
						nModulo     := 4
						cModulo     := "EST"
						Pergunte("MTA240",.F.) // Chama perguntas da rotina para evitar erros no Sigaauto
						MSExecAuto({|x,y| MATA240(x,y)},aAutoSD3,5)
						(_cAliD3)->(DbCloseArea())
						If lMsErroAuto
							Help(,,"SigaAuto - MATA240",,"Não foi possivel executar o SigaAuto de Exclusão de Movimento Interno.", 1, 0,,,,,, {"Após confirmar esta mensagem, verifique os detalhes no Log do SigaAuto."})
							MostraErro()
							Return .F.
						EndIf
					EndIf
				EndIf
			EndIf
			If _lInclui .or. (_lAltera .and. _lEstOK)
				aAutoSD3    := {}
				AAdd( aAutoSD3,{"D3_FILIAL"     , xFilial("SD3")			, Nil } )// Codigo da Filial
				AAdd( aAutoSD3,{"D3_TM"		    , ZL2->ZL2_TM		        , Nil } )// Tipo do Movimento Interno
				AAdd( aAutoSD3,{"D3_COD"		, SB1->B1_COD  	            , Nil } )// Codigo do Produto
				AAdd( aAutoSD3,{"D3_UM"		    , SB1->B1_UM		        , Nil } )// Unidade de Medida
				AAdd( aAutoSD3,{"D3_QUANT"	    , _nQtdSD3		    	, Nil } )// Quantidade de Leite -- nTotCodRec = soma das coletas dos produtores
				AAdd( aAutoSD3,{"D3_LOCAL"	    , ZL2->ZL2_LOCAL	 , Nil } )// Almoxarifado
				AAdd( aAutoSD3,{"D3_EMISSAO"	, _dDtLanc		     , Nil } )// Data de Emissao
				AAdd( aAutoSD3,{"D3_DOC"	    , "GLT"+_cTicket	 , Nil } )// Documento  //GetSxeNum("SD3","D3_DOC")
				If _lCusto
					AAdd( aAutoSD3,{"D3_CUSTO1"	    , _cCustoD3 		, Nil } )// Custo (na Moeda 1)
				EndIf
				//Verifica se o parametro MV_RASTRO esta configurado para gerar rastreabilidade
				//e se o produto foi configurado  para rastrear por sub-lote ou lote.
				If _lRastro .And. SB1->B1_RASTRO $ ('S','L')
					_cLote:= Alltrim(xFilial("SF2"))+_cTicket
					_nDias := IIF(SB1->B1_PRVALID>0,SB1->B1_PRVALID,10)
					AAdd( aAutoSD3,{"D3_LOTECTL"	, _cLote			    , Nil } )	// Lote
					AAdd( aAutoSD3,{"D3_DTVALID"	, _dDtLanc + _nDias   	, Nil } )	// Data de validade do lote
				Endif
				AAdd( aAutoSD3,{"D3_L_ORIG"	    , _cTicket			    , Nil } )// Origem do documento - Ticket
				AAdd( aAutoSD3,{"D3_L_SETOR"	, _cSetor 		        , Nil } )// Setor do documento

				nModulo     := 4
				cModulo     := "EST"
				lMsHelpAuto := .T.
				lMsErroAuto := .F.

				Pergunte("MTA240",.F.) // Chama perguntas da rotina para evitar erros no Sigaauto
				MSExecAuto({|x,y| MATA240(x,y)},aAutoSD3,3)
				If lMsErroAuto
					Help(,,"SigaAuto - MATA240",,"Não foi possivel executar o SigaAuto de Inclusão de Movimento Interno.", 1, 0,,,,,, {"Após confirmar esta mensagem, verifique os detalhes no Log do SigaAuto."})
					MostraErro()
					_lRet := .F.
				EndIf
			EndIf

			nModulo := _nModBkp
			cModulo := _cModBkp
		EndIf
	EndIf



	//Atualizaçaõ tabela das coletas SmartQuestion ZML
	If _lRet .and.  (_lInclui .or. _lAltera )
		For ix:=1 To oStruZLD:Length()
			oStruZLD:GoLine(ix)
			If !Empty(oStruZLD:GetValue("ZLD_NROZML"))
				DbSelectArea("ZML")
				DbSetOrder(1)
				If ZML->(MsSeek(oStruZLD:GetValue("ZLD_NROZML")))
					Reclock("ZML",.F.)
					ZML->ZML_TICKET := Iif((_lDelete .or. oStruZLD:IsDeleted())," ",_cTicket)
					ZML->(MsUnLock())
				EndIf
			EndIf
		Next ix
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se houve alguma falha, desfaz todas as transacoes.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !_lRet
		DisarmTransaction()
		UnLockByName("AGLT103",.T.,.F.)
		FreeUsedCode()  //libera codigos de correlativos reservados pela MayIUseCode()
		Help( ,, 'ERROGRV',," Ocorreram erros durante a gravação dos lançamentos que impedem a continuidade do processo!", 1, 0 )
	Else

		UnLockByName("AGLT103",.T.,.F.)
		FreeUsedCode()  //libera codigos de correlativos reservados pela MayIUseCode()
	EndIf

	RestArea(_aArea)

Return(_lRet)

/*
===============================================================================================================================
Programa----------: RECEPAUTO
Autor-------------: GUILHERME FRANÇA
Data da Criacao---: 14/08/2020
===============================================================================================================================
Descricao---------: Excecauto da recepção do leite, para integração com coletores de dados.
==============================================================================================================================*/
User Function RECEPAUTO(xaCabec, xaItens)

	Local oModel  := FwLoadModel("AGLT103")
	Local oStruZLC	:= oModel:GetModel('ZLCMASTER')
	Local oStruZLD	:= oModel:GetModel('ZLDDETAIL')
	Local oStruct
	Local _aCpoZLC := {}
	Local _aCpoZLD := {}
	Local _lRet := .t.
	Local _iCab   := 0
	Local _iItem := 0
	Local ix      := 0
	Local nPos := 0

	oModel:SetOperation(3) // inclusão.

	oModel:Activate() // Ativa o modelo.

	// Obtemos a estrutura de dados do cabeçalho
	oStruct := oStruZLC:GetStruct()
	_aCpoZLC := oStruct:GetFields()
	//Preenche cabeçalho da recepção.
	For _iCab := 1 to Len(xaCabec)
		// Verifica se os campos passados existem na estrutura do cabeçalho
		If ( nPos := aScan( _aCpoZLC, { |x| AllTrim( x[3] ) == AllTrim(xaCabec[_iCab][1] ) } ) ) > 0
			// Caso a atribuição não possa ser feita, por algum motivo o método SetValue retorna .F.
			If !oStruZLC:SetValue(xaCabec[_iCab][1]	, xaCabec[_iCab][2] )
				_lRet := .F.
				Exit
			EndIf
		EndIf
	Next _iCab

	If _lRet
		// Obtemos a estrutura de dados dos itens
		oStruct := oStruZLD:GetStruct()
		_aCpoZLD := oStruct:GetFields()

		//Preenche grid dos produtores.
		For _iItem := 1 to Len(xaItens)

			If _iItem > 1
				oStruZLD:AddLine()
			EndIf
			For ix := 1 to Len(xaItens[_iItem])
				// Verifica se os campos passados existem na estrutura do cabeçalho
				If ( nPos := aScan( _aCpoZLD, { |x| AllTrim( x[3] ) == AllTrim(xaItens[_iItem][ix][1] ) } ) ) > 0
					// Caso a atribuição não possa ser feita, por algum motivo o método SetValue retorna .F.
					If !oStruZLD:SetValue(xaItens[_iItem][ix][1], xaItens[_iItem][ix][2] )
						_lRet := .F.
						Exit
					EndIf
				EndIf
				oStruZLD:LoadValue("ZLD_IMPORT","I" )
			Next ix
		Next _iItem
	EndIf

	If _lRet .and. Len(xaItens) > 0

		oStruZLC:LoadValue("ZLC_IMPORT","I" )

		If oModel:VldData()
			oModel:CommitData()
		Else

			_lExecAuto := .F.

			aErro := oModel:GetErrorMessage()

			AutoGrLog( "Id do formulário de origem:"	+ ' [' + AllToChar( aErro[1] ) + ']' )
			AutoGrLog( "Id do campo de origem: " 		+ ' [' + AllToChar( aErro[2] ) + ']' )
			AutoGrLog( "Id do formulário de erro: " 	+ ' [' + AllToChar( aErro[3] ) + ']' )
			AutoGrLog( "Id do campo de erro:  " 		+ ' [' + AllToChar( aErro[4] ) + ']' )
			AutoGrLog( "Id do erro: " 					+ ' [' + AllToChar( aErro[5] ) + ']' )
			AutoGrLog( "Mensagem do erro: " 			+ ' [' + AllToChar( aErro[6] ) + ']' )
			AutoGrLog( "Mensagem da solução: " 			+ ' [' + AllToChar( aErro[7] ) + ']' )
			AutoGrLog( "Valor atribuído: " 				+ ' [' + AllToChar( aErro[8] ) + ']' )
			AutoGrLog( "Valor anterior: " 				+ ' [' + AllToChar( aErro[9] ) + ']' )

			MostraErro()

		EndIf

	EndIf

	oModel:DeActivate()

Return

/********************************************************
* TESTE DO EXCECAUTO
*********************************************************/
User Function TSTGLTRL()

	Local _aCab  := {}
	Local _aItem := {}
	Local _aAux := {}

	aAdd(_aCab, {'ZLC_DTCOLE', dDataBase })
	aAdd(_aCab, {'ZLC_HORDES', "07:30" })
	aAdd(_aCab, {'ZLC_ROTCAB', "000001"})
	aAdd(_aCab, {'ZLC_SETOR', "000001"})
	aAdd(_aCab, {'ZLC_FRETIS', "T00001"})
	aAdd(_aCab, {'ZLC_LJFRET', "01"})
	aAdd(_aCab, {'ZLC_MOTOR', "000001"})
	aAdd(_aCab, {'ZLC_VEICUL', "000001"})
	aAdd(_aCab, {'ZLC_TEMPCA', 7})
	aAdd(_aCab, {'ZLC_KM', 325})
	aAdd(_aCab, {'ZLC_KMTERR', 0})
	aAdd(_aCab, {'ZLC_QTDVEI', 3500})

	aAdd( _aAux, {'ZLD_ITEM', StrZero(1,3) })
	aAdd( _aAux, {'ZLD_RETIRO', "P00002" })
	aAdd( _aAux, {'ZLD_RETILJ', "01" })
	aAdd( _aAux, {'ZLD_QTDBOM', 800 })
	aAdd( _aAux, {'ZLD_HORA', "05:00" })
	aAdd( _aAux, {'ZLD_TEMP', 4.5 })
	aAdd( _aAux, {'ZLD_REGUA', 8 })
	aAdd( _aAux, {'ZLD_BOCA', "1" })
	aAdd(_aItem, aClone(_aAux))

	_aAux := {}
	aAdd( _aAux, {'ZLD_ITEM', StrZero(2,3) })
	aAdd( _aAux, {'ZLD_RETIRO', "P00003" })
	aAdd( _aAux, {'ZLD_RETILJ', "01" })
	aAdd( _aAux, {'ZLD_QTDBOM', 600 })
	aAdd( _aAux, {'ZLD_HORA', "05:30" })
	aAdd( _aAux, {'ZLD_TEMP', 4.5 })
	aAdd( _aAux, {'ZLD_REGUA', 8 })
	aAdd( _aAux, {'ZLD_BOCA', "2" })
	aAdd(_aItem, aClone(_aAux))

	_aAux := {}
	aAdd( _aAux, {'ZLD_ITEM', StrZero(3,3) })
	aAdd( _aAux, {'ZLD_RETIRO', "P00005" })
	aAdd( _aAux, {'ZLD_RETILJ', "01" })
	aAdd( _aAux, {'ZLD_QTDBOM', 350 })
	aAdd( _aAux, {'ZLD_HORA', "05:45" })
	aAdd( _aAux, {'ZLD_TEMP', 4.8 })
	aAdd( _aAux, {'ZLD_REGUA', 6 })
	aAdd( _aAux, {'ZLD_BOCA', "2" })
	aAdd(_aItem, aClone(_aAux))

	_aAux := {}
	aAdd( _aAux, {'ZLD_ITEM', StrZero(4,3) })
	aAdd( _aAux, {'ZLD_RETIRO', "P00006" })
	aAdd( _aAux, {'ZLD_RETILJ', "01" })
	aAdd( _aAux, {'ZLD_QTDBOM', 750 })
	aAdd( _aAux, {'ZLD_HORA', "06:30" })
	aAdd( _aAux, {'ZLD_TEMP', 5 })
	aAdd( _aAux, {'ZLD_REGUA', 7 })
	aAdd( _aAux, {'ZLD_BOCA', "1" })
	aAdd(_aItem, aClone(_aAux))

	U_RECEPAUTO(_aCab, _aItem)

Return


/*
===============================================================================================================================
Programa----------: IMPORTCSV
Autor-------------: GUILHERME FRANÇA
Data da Criacao---: 14/08/2020
===============================================================================================================================
Descricao---------: Importação de arquivo CSV para preenchimento dos itens
==============================================================================================================================*/
Static Function IMPORTCSV()

	Local _cTexto := ""
	Local _nOpc := 0
	Local oSay

	_cTexto := "Esta opção permite a importação de um arquivo no formato .CSV para o"+_ENTER
	_cTexto += "preenchimento dos itens deste lançamento." +_ENTER +_ENTER
	_cTexto += "O arquivo deverá conter as colunas separadas por ponto e vírgula contendo:" +_ENTER +_ENTER
	_cTexto += "CÓDIGO;LOJA;VOLUME;TEMPERATURA;REGUA."

	_nOpc := AVISO("Importação .csv", _cTexto, { "Continuar","Fechar"}, 2)

	If _nOpc == 2
		Return
	EndIf

	FWMsgRun(, {|oSay| LerArqCsv(oSay) },'Aguarde', 'Processando arquivo...')

Return

Static Function LerArqCsv(oSay)

	Local _cArquivo		:= ""
	Local _aDados := {}
	Local _cLin		:= ""
	Local _cAux			:= ""
	Local _aCodLj := ""
	Local xi := 0
	Local oModel 	:= FWModelActive()
	Local oStruZLD  := oModel:GetModel("ZLDDETAIL")
	Local _nQtdLin 	:= oStruZLD:GetQTDLine()
	Local _nItem	:= 1
	Local _nLinha	:= 1
	Local _cErro := ""

	//Recebe o Arquivo CSV
	_cArquivo := cGetFile( "Arquivo CSV (*.CSV) | *.CSV", "Selecione o arquivo para importação",,'C:\',.F., )

	If !File(_cArquivo)
		MsgStop("O arquivo " + _cArquivo + " não foi encontrado. A importação será abortada!","Atenção")
	Else

		//Se retornou arquivo processa
		If !Empty(_cArquivo)

			FT_FUSE(_cArquivo)
			ProcRegua(FT_FLASTREC())
			FT_FGOTOP()

			oSay:cCaption := "Lendo arquivo..."
			ProcessMessages()

			//Quebra as Colunas e Linhas da Planilha e alimenta array
			Do While !FT_FEOF()

				IncProc("Lendo arquivo...")
				_cLin := FT_FREADLN()
				If Len(_cLin) > 1
					aAdd(_aDados,Separa(_cLin,";",.T.))  //CÓDIGO;LOJA;VOLUME;TEMPERATURA;REGUA
				EndIf
			 	FT_FSKIP()
			EndDo

			FT_FUSE()

			oSay:cCaption := "Ajustando dados para importação..."
			ProcessMessages()


			For xi := 1 To Len(_aDados)
			    //Retira Caracteres Especiais do CPF no Array

				If !Empty([xi,1])
					_cAux			:= StrTran(_aDados[xi,1],"-","")
					_cAux			:= StrTran(_cAux,".","")
					_cAux			:= StrTran(_cAux,"/","")
					_aDados[xi,1]		:= _cAux

					_cAux			:= Val(_aDados[xi,2])
					_aDados[xi,2]		:= StrZero(_cAux,TamSx3("ZLD_RETILJ")[1])


					//Retira espaços e pontos da temperatura e regua e altera a virgula para ponto para poder ser convertido de forma correta de caracter para numérico
					_cAux 			:= AllTrim(_aDados[xi,3])
					_cAux			:= StrTran(_cAux,".","")
					_cAux			:= StrTran(_cAux,",",".")
					_aDados[xi,3]		:= Val(_cAux)

					If Len(_aDados) > 3
						_cAux 			:= AllTrim(_aDados[xi,4])
						_cAux			:= StrTran(_cAux,".","")
						_cAux			:= StrTran(_cAux,",",".")
						_aDados[xi,4]		:= Val(_cAux)
					EndIf
					If Len(_aDados) > 3
						_cAux 			:= AllTrim(_aDados[xi,5])
						_cAux			:= StrTran(_cAux,".","")
						_cAux			:= StrTran(_cAux,",",".")
						_aDados[xi,5]		:= Val(_cAux)
					EndIf
				EndIf
			Next i


			If Len(_aDados) == 0
				MsgStop("Nenhum registro a ser importado!","Atenção")
			Else
				oSay:cCaption := "Preenchendo grid..."
				ProcessMessages()

				For xi := 1 To Len(_aDados)

					_aCodLj := RetCodLj(_aDados[xi,1],_aDados[xi,2])
					If !Empty(_aCodLj[1])
						IF _nLinha <= _nQtdLin
							oStruZLD:GoLine(_nLinha)
							IF oStruZLD:IsDeleted(_nLinha)
								oStruZLD:UnDeleteLine()
							ENDIF
						ELSE
							oStruZLD:AddLine()
						ENDIF

						oStruZLD:LoadValue("ZLD_ITEM",StrZero(_nItem,3))
						oStruZLD:SetValue("ZLD_RETIRO",_aCodLj[1])
						oStruZLD:SetValue("ZLD_RETILJ",_aCodLj[2])
						//oStruZLD:LoadValue("ZLD_DCRRET",SubStr(_aCodLj[3],1,TamSx3("ZLD_DCRRET")[1]))
						oStruZLD:SetValue("ZLD_QTDBOM",_aDados[xi,3])
						If Len(_aDados) > 3
							oStruZLD:LoadValue("ZLD_TEMP",_aDados[xi,4])
						EndIf
						If Len(_aDados) > 4
							oStruZLD:LoadValue("ZLD_REGUA",_aDados[xi,5])
						EndIf
						oStruZLD:LoadValue("ZLD_IMPORT","I")
						_nItem++
						_nLinha++
					Else
						_cErro += _aDados[xi,1]+" Volume: "+TransForm(_aDados[xi,3],"@E 999,999") + _ENTER
					EndIf
				Next xi
				oStruZLD:GoLine(1)


				If !Empty(_cErro)
					xMagHelpFis("Sem Codigo","Os códigos abaixo não foram encontrados no cadastro de produtores e não serão importados.",_cErro)
				EndIf
			EndIf

		EndIf

	EndIf

Return Nil


Static Function RetCodLj(xcCodigo,xcLoja)

	Local _aRet := {"","",xcCodigo+" NÃO ENCONTRADO"}
	Local _cAliCod := GetNextAlias()


	BeginSql alias _cAliCod
		SELECT A2_COD, A2_LOJA, A2_NOME
		FROM %Table:SA2% SA2
		WHERE A2_COD = %Exp:xcCodigo%
		AND A2_LOJA = %Exp:xcLoja%
		AND A2_L_TPFOR IN ('P','T')
		AND A2_MSBLQL <> "1"
		AND SA2.%NotDel%
	EndSql

	If !(_cAliCod)->(Eof())
		_aRet[1] := (_cAliCod)->A2_COD
		_aRet[2] := (_cAliCod)->A2_LOJA
		_aRet[3] := (_cAliCod)->A2_NOME
	EndIf

	(_cAliCod)->(DbCloseArea())

Return _aRet

/*
===============================================================================================================================
Programa----------: IMPORTSQ
Autor-------------: CLAUDIO GONCALVES
Data da Criacao---: 25/04/2021
===============================================================================================================================
Descricao---------: Importação de arquivo CSV para preenchimento dos itens
==============================================================================================================================*/
Static Function IMPORTSQ(oSay)

	Local _aRetCod := {}
	Local _cFilCod := ""
	Local oModel     := FWModelActive()
	Local oView      := FWViewActive()
	Local oStruZLD   := oModel:GetModel("ZLDDETAIL")
	Local oStruZLC   := oModel:GetModel( 'ZLCMASTER' )
	Local _nQtdLin   := oStruZLD:GetQTDLine()
	Local _nLinha    := 1
	Local _nItem     := 1
	Local _nQtdVei   := oStruZLC:GetValue("ZLC_QTDVEI")
	Local ix         := 0
	Private _cSetor  := oStruZLC:GetValue("ZLC_SETOR")
	Private _dDataC  := oStruZLC:GetValue("ZLC_DTCOLE")
	Private _cTicket := oStruZLC:GetValue("ZLC_TICKET")

	If empty(_cSetor)
		MsgInfo("Setor não informado","Info")
		Return
	Endif

	If empty(_dDataC)
		MsgInfo("Data não informada","Info")
		Return
	Endif

	_aRetCod := TelaSelec(_nQtdVei)

	If Len(_aRetCod) == 0
		MsgInfo("Nenhum registro foi selecionado!","Info")
		Return
	Endif

	For ix := 1 to Len(_aRetCod)
		_cFilCod += "'"+_aRetCod[ix]+"',"
	Next ix
	_cFilCod := "% ("+SubStr(_cFilCod,1,Len(_cFilCod)-1)+") %"

	BeginSql alias 'TZML'
		SELECT *
		FROM %Table:ZML% ZML
		WHERE ZML_DATACO = %Exp:_dDataC%
		AND ZML_SETOR = %Exp:_cSetor%
		AND SUBSTR(ZML_NROATE,1,6) IN %Exp:_cFilCod%
		AND ZML_TICKET = ' '
		AND ZML.%NotDel%
		ORDER BY ZML_NROATE
	EndSql

	If !TZML->(Eof())

		If _nQtdLin = 1
			oStruZLD:GoLine(1)
			oStruZLD:DeleteLine()
		EndIf

		While !TZML->(Eof())

			oSay:cCaption := "Preenchendo grid..."
			ProcessMessages()

			IF _nLinha <= _nQtdLin
				oStruZLD:GoLine(_nLinha)
				IF oStruZLD:IsDeleted(_nLinha)
					oStruZLD:UnDeleteLine()
				ENDIF
			ELSE
				oStruZLD:AddLine()
			ENDIF

			oStruZLD:LoadValue("ZLD_TICKET",_cTicket)
			oStruZLD:LoadValue("ZLD_ITEM",StrZero(_nItem,TamSx3("ZLD_ITEM")[1]))
			oStruZLD:SetValue("ZLD_RETILJ",TZML->ZML_RETILJ)
			oStruZLD:SetValue("ZLD_RETIRO",TZML->ZML_RETIRO)
			oStruZLD:SetValue("ZLD_QTDBOM",TZML->ZML_QTDBOM)
			oStruZLD:SetValue("ZLD_HORA",TZML->ZML_HORACO)
			oStruZLD:SetValue("ZLD_TEMP",TZML->ZML_TEMP)
			oStruZLD:SetValue("ZLD_REGUA",TZML->ZML_REGUA)
			oStruZLD:SetValue("ZLD_KM",TZML->ZML_KM)
			oStruZLD:SetValue("ZLD_BOCA",alltrim(TZML->ZML_BOCA))
			oStruZLD:LoadValue("ZLD_NROZML",TZML->ZML_NROATE)

			TZML->(DbSkip())
			_nItem++
			_nLinha++
		EndDo
		oStruZLD:GoLine(1)
	Endif

	If (oView <> NIL)
		oView:Refresh()
	EndIf

	TZML->(dbCloseArea())

Return


/*
===============================================================================================================================
Programa----------: TelaSelec
Autor-------------: GUILHERME FRANÇA
Data da Criacao---: 03/05/2021
===============================================================================================================================
Descricao---------: Tela para seleção dos registros ZML a importar para ZLD
===============================================================================================================================
*/
Static Function TelaSelec(xnQtdVei)

	Local _aStru :={}
	Local aCpoBro := {}
	Local _cAliZML := GetNextAlias()
	Local _aRetZML := {}
	Local oTempTable	:= Nil
	Private oDlg
	Private oVlrSel
	Private onQtdSel
	Private oQtdVei
	Private onQtdVei

	Private _nQtdSel := 0
	Private cMark   := GetMark()
	Private lInverte	:= .F.
	Private oMark

	//Cria um arquivo de Apoio
	AADD(_aStru,{"OK"			,"C"	,2		,0		})
	AADD(_aStru,{"NUMSQ"		,"C"	,6		,0		})
	AADD(_aStru,{"USERSQ"		,"C"	,20		,0		})
	AADD(_aStru,{"ROTA"			,"C"	,6		,0		})
	AADD(_aStru,{"QTDE"			,"N"	,12		,0		})
	AADD(_aStru,{"DATACOL"		,"D"	,8		,0		})
	AADD(_aStru,{"PLACA"		,"C"	,8		,0		})

	oTempTable := FwTemporaryTable():New("TTRB", _aStru)
	oTempTable:Create()

	BeginSql alias _cAliZML
		SELECT SUBSTR(ZML_NROATE,1,6) AS NUMSQ, MAX(ZML_ROTA) AS ROTA, MAX(ZML_PLACA) AS PLACA, ZML_USERSQ AS USERSQ, ZML_DATACO AS DATACOL, SUM(ZML_QTDBOM)  AS QTDE
		FROM %Table:ZML% ZML
		WHERE ZML_DATACO = %Exp:_dDataC%
		AND ZML_SETOR = %Exp:_cSetor%
		AND ZML_TICKET = ' '
		AND ZML.%NotDel%
		GROUP BY SUBSTR(ZML_NROATE,1,6), ZML_USERSQ , ZML_DATACO
		ORDER BY 1
	EndSql

	DbSelectArea("TTRB")
	While !(_cAliZML)->(Eof())
		RecLock("TTRB",.T.)
		TTRB->OK 		:= 	""
		TTRB->NUMSQ		:= 	(_cAliZML)->NUMSQ
		TTRB->USERSQ	:= 	(_cAliZML)->USERSQ
		TTRB->ROTA		:= 	(_cAliZML)->ROTA
		TTRB->QTDE 		:= 	(_cAliZML)->QTDE
		TTRB->DATACOL	:= 	STOD((_cAliZML)->DATACOL)
		TTRB->PLACA		:= 	(_cAliZML)->PLACA
		(_cAliZML)->(DbSkip())
	EndDo
	(_cAliZML)->(DbCloseArea())

	TTRB->(MsUnLock())
	DbSelectArea("TTRB")
	TTRB->(DBGOTOP())

	aCpoBro	:= {{ "OK"			,," "			,"@!"	},;
	{ "NUMSQ"  	,, "Nro.SQ"		,"@!"					},;
	{ "USERSQ"	,, "Usuário"	,"@!"				},;
	{ "ROTA"   	,, "Rota"		,"@!"				},;
	{ "QTDE"	,, "Quantidade"	,"@E 999,999,999"	},;
	{ "DATACOL"	,, "Data Coleta","@!"				},;
	{ "PLACA"	,, "Placa"		,"@!"				}}


	DEFINE MSDIALOG oDlg TITLE "Selecione os registros para importar" From 00,00 TO 300,800 PIXEL
	//Cria a MsSelect -- Grid com os titulos
	oMark := MsSelect():New("TTRB","OK","",aCpoBro,@lInverte,@cMark,{7,7,110,400},,,,,)
	oMark:bMark := {| | AtuValores()}
	@ 120, 010 SAY oVlrSel PROMPT "Qtde. Selecionada:" SIZE 050, 007 OF oDlg  PIXEL
	@ 128, 010 MSGET onQtdSel VAR _nQtdSel SIZE 060, 010 OF oDlg PICTURE "@E 999,999,999"  READONLY PIXEL
	@ 120, 080 SAY oQtdVei PROMPT "Qtde.Veículo:" SIZE 040, 007 OF oDlg  PIXEL
	@ 128, 080 MSGET onQtdVei VAR xnQtdVei SIZE 060, 010 OF oDlg PICTURE "@E 999,999,999"  READONLY PIXEL

	@ 124, 300 BUTTON "Confirmar"	SIZE 60,17 ACTION Processa( {|| oDlg:End() }, "Aguarde...","Preenchendo Grid" ) PIXEL OF oDlg
	ACTIVATE MSDIALOG oDlg CENTERED

	TTRB->(dbGoTop())
	While TTRB->(!EOF())
		IF TTRB->OK = cMark
			AADD(_aRetZML ,TTRB->NUMSQ)
		EndIF
		TTRB->(DBSkip())
	EndDo

	TTRB->(dbCloseArea())
	oTempTable:Delete()

Return _aRetZML

Static Function AtuValores()

	_nQtdSel	:= 0

	RecLock("TTRB",.F.)
	If Marked("OK")
		TTRB->OK := cMark
	Else
		TTRB->OK := ""
	Endif
	TTRB->(MSUNLOCK())

	TTRB->(DbGoTop())
	While TTRB->(!Eof())
		If TTRB->OK == cMark
			_nQtdSel += TTRB->QTDE
		Endif
		TTRB->(DbSkip())
	EndDo
	TTRB->(DbGoTop())

	oMark:oBrowse:Refresh()
	onQtdSel:Refresh()
	oDlg:Refresh()

Return()
