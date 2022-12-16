/*
=====================================================================================================================================
         							ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL
=====================================================================================================================================
	Autor	|	Data	|										Motivo																|
------------:-----------:-----------------------------------------------------------------------------------------------------------:
            |           | 																											|
------------:-----------:-----------------------------------------------------------------------------------------------------------:
	        |			|																											|
=====================================================================================================================================
*/
//Bibliotecas
#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'

//Variáveis Estáticas
Static cTitulo := "Lançamento Créditos"

/*
===============================================================================================================================
Programa----------: AGLT011
Autor-------------: Guilherme França
Data da Criacao---: 18/02/2021
===============================================================================================================================
Descrição---------: Lançamento de créditos financeiros para o produtor
===============================================================================================================================
Uso---------------: Gestão do Leite
===============================================================================================================================
Parametros--------:
===============================================================================================================================
Retorno-----------: Retornos esperados da função
===============================================================================================================================
Setor-------------: Gestão do Leite
===============================================================================================================================
*/

User Function AGLT011()

    Local aArea   := GetArea()
    Local oBrowse

    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias("ZLG")
    oBrowse:SetDescription(cTitulo)
    oBrowse:Activate()

    RestArea(aArea)

Return Nil

/*
===============================================================================================================================
Programa----------: MenuDef
Autor-------------: Guilherme França
Data da Criacao---: 18/02/2021
===============================================================================================================================
Descrição---------: MenuDef
===============================================================================================================================
Parametros--------:
===============================================================================================================================
Retorno-----------:
===============================================================================================================================
*/

Static Function MenuDef()
	Local aRotina := {}

	ADD OPTION aRotina Title 'Pesquisar'  	Action 'PesqBrw'         	OPERATION 1 ACCESS 0
	ADD OPTION aRotina Title 'Visualizar'	Action 'VIEWDEF.AGLT011' 	OPERATION 2 ACCESS 0
	ADD OPTION aRotina Title 'Incluir'   	Action 'U_GLTMNU011("I")'	OPERATION 3 ACCESS 0
	ADD OPTION aRotina Title 'Imprime Lancto.'  	Action 'U_RGLT037()'		OPERATION 4 ACCESS 0
	ADD OPTION aRotina Title 'Alterar'    	Action 'U_GLTMNU011("A")'		OPERATION 4 ACCESS 0
	ADD OPTION aRotina Title 'Excluir'    	Action 'U_GLTMNU011("E")'		OPERATION 5 ACCESS 0

Return aRotina

/*
===============================================================================================================================
Programa----------: GLTMNU011
Autor-------------: GUILHERME FRANÇA
Data da Criacao---: 14/08/2020
===============================================================================================================================
Descricao---------: Validações do menu
==============================================================================================================================*/
USER Function GLTMNU011(_cTipo)

	Local _lPermissao :=  (GetAdvFVal("ZLU","ZLU_CREDIT",xFilial("ZLU")+cUserName,1,"N") == "S")
	Local _aArea := GetArea()
	Local _cStatus := ""

	If !_lPermissao
		Help( ,,1,"Permissão","Usuário sem permissão para incluir/editar créditos", 1, 0 )
		Return
	EndIf

	dbSelectArea("ZLE")
	ZLE->(dbSetOrder(1))
	If ZLE->(MsSeek(xFilial("ZLE")+ZLG->ZLG_CODMIX))
		_cStatus := ZLE->ZLE_STATUS
	EndIf

	IF _cTipo	= "I"
		lOk := ( FWExecView('Validação de Inclusao','AGLT011', MODEL_OPERATION_INSERT,, ,  ) == 0 )
		If lOk
			U_RGLT037()
		EndIf
	ELSEIF _cTipo	= "A"
		IF _cStatus <> "F"
			lOk := ( FWExecView('Validação de Alteração','AGLT011', MODEL_OPERATION_UPDATE,, ,  ) == 0 )
		ELSE
			Help( ,,1,"MIX FECHADO","NÃO é permitido ALTERAR este movimento pois o MIX já está fechado!", 1, 0 )
		ENDIF
	ELSEIF _cTipo = 'E'
		IF _cStatus <> "F"
			lOk := ( FWExecView('Validação de Exclusão','AGLT011', MODEL_OPERATION_DELETE,, ,  ) == 0 )
		ELSE
			Help( ,,1,"MIX FECHADO","NÃO é permitido EXCLUIR este movimento pois o MIX já está fechado!", 1, 0 )
		ENDIF
	ENDIF

	RestArea(_aArea)

RETURN


/*
===============================================================================================================================
Programa----------: ModelDef
Autor-------------: Guilherme França
Data da Criacao---: 18/02/2021
===============================================================================================================================
Descrição---------: ModelDef
===============================================================================================================================
Parametros--------:
===============================================================================================================================
Retorno-----------:
===============================================================================================================================
*/
Static Function ModelDef()

    Local oModel    := NIL
    Local oStruCab  := FWFormStruct(1, 'ZLG' , {|cCampo| AllTRim(cCampo) $ "ZLG_FILIAL;ZLG_CODIGO;ZLG_CODMIX;ZLG_DTLANC;ZLG_EVENTO;ZLG_DESEVE;ZLG_VENCTO"})
    Local oStruGrid := FWFormStruct(1, 'ZLG' )
    Local aTrigger  := {}
	Local xi        := 0
    //Ajusta propriedades dos campos
    SetPropM(oStruCab, oStruGrid)

    //Monta o modelo de dados, e na Pós Validação, informa a função fValidGrid
    oModel := MPFormModel():New('AGLT011_MVC', /*bPreValidacao*/,{ |oModel| GravaTit(oModel) } /*{ |oModel| TudoOk(oModel)} */,/*bPosValidacao*/,/*bCommit*/, /*bCancel*/ )

    //Agora, define no modelo de dados, que terá um Cabeçalho e uma Grid apontando para estruturas acima
    oModel:AddFields('ZLGMASTER', NIL, oStruCab)
    oModel:AddGrid('ZLGGRID', 'ZLGMASTER', oStruGrid,{ || ValidaLin() } /*bLinePre*/, /*bLinePost*/, /*bPreVal*/, /*bPosVal*/, /*BLoad*/ )

    oModel:AddCalc( 'CPOCALC', 'ZLGMASTER', 'ZLGGRID', 'ZLG_VALOR', 'ZLG_VALOR', 'SUM'  , , ,'Valor Total Lcto.' )


    aAdd(aTrigger, FwStruTrigger('ZLG_CODSA2'   ,'ZLG_NOME'   ,'SA2->A2_NOME',.T.,'SA2',1,'xFilial("SA2")+M->ZLG_CODSA2+M->ZLG_LOJSA2'))
    aAdd(aTrigger, FwStruTrigger('ZLG_LOJSA2'   ,'ZLG_NOME'   ,'SA2->A2_NOME',.T.,'SA2',1,'xFilial("SA2")+M->ZLG_CODSA2+M->ZLG_LOJSA2'))
	For xi := 1 to Len(aTrigger)
    	oStruGrid:AddTrigger(aTrigger[xi][1] ,aTrigger[xi][2] ,aTrigger[xi][3] ,aTrigger[xi][4] )
	Next xi


    //Monta o relacionamento entre Grid e Cabeçalho, as expressões da Esquerda representam o campo da Grid e da direita do Cabeçalho
    oModel:SetRelation('ZLGGRID', {;
            {"ZLG_FILIAL", "xFilial('ZLG')"},;
            {"ZLG_CODIGO",  "ZLG_CODIGO"},;
            {"ZLG_CODMIX", "ZLG_CODMIX"},;
            {"ZLG_DTLANC",  "ZLG_DTLANC"},;
            {"ZLG_EVENTO",  "ZLG_EVENTO"},;
            {"ZLG_DESEVE",  "ZLG_DESEVE"};
        }, ZLG->(IndexKey(1)))

    //Definindo outras informações do Modelo e da Grid
    oModel:GetModel("ZLGGRID"):SetMaxLine(999)
    oModel:SetDescription(cTitulo)
    oModel:SetPrimaryKey({"ZLG_FILIAL", "ZLG_CODIGO", "ZLG_ITEM", "ZLG_CODSA2" , "ZLG_LOJSA2"})

Return oModel

 /*
===============================================================================================================================
Programa----------: ViewDef
Autor-------------: Guilherme França
Data da Criacao---: 18/02/2021
===============================================================================================================================
Descrição---------: ViewDef
===============================================================================================================================
Parametros--------:
===============================================================================================================================
Retorno-----------:
===============================================================================================================================
*/
Static Function ViewDef()

    //Na montagem da estrutura da visualização de dados, vamos chamar o modelo criado anteriormente, no cabeçalho vamos mostrar somente 3 campos, e na grid vamos carregar conforme a função fViewStruct
    Local oView        := NIL
	Local _cCpoGrid := "ZLG_ITEM;ZLG_CODSA2;ZLG_LOJSA2;ZLG_NOME;ZLG_VALOR"
    Local oModel    := FWLoadModel('AGLT011')
    Local oStruCab  := FWFormStruct(2, "ZLG", {|cCampo| AllTRim(cCampo) $ "ZLG_FILIAL;ZLG_CODIGO;ZLG_CODMIX;ZLG_DTLANC;ZLG_EVENTO;ZLG_DESEVE;ZLG_VENCTO"})
    Local oStruGRID :=  FWFormStruct(2, 'ZLG', {|cCampo| AllTRim(cCampo) $ _cCpoGrid})
    Local oStruTOT	:= FWCalcStruct( oModel:GetModel('CPOCALC') )
    //Define que no cabeçalho não terá separação de abas (SXA)
    oStruCab:SetNoFolder()

    //Cria o View
    oView:= FWFormView():New()
    oView:SetModel(oModel)

    //Cria uma área de Field vinculando a estrutura do cabeçalho com MDFieldZAF, e uma Grid vinculando com MdGridZAF
    oView:AddField('VIEW_ZLG', oStruCab, 'ZLGMASTER')
    oView:AddGrid ('GRID_ZLG', oStruGRID, 'ZLGGRID' )
    oView:AddField('CALC1', oStruTOT,'CPOCALC')

	oView:SetViewProperty("GRID_ZLG", "GRIDDOUBLECLICK", {{|oFormulario,cFieldName,nLineGrid,nLineModel| Iif(Alltrim(cFieldName) $ _cCpoGrid ,ConsTitulo(),.t.)}})

    //O cabeçalho (MAIN) terá 25% de tamanho, e o restante de 75% irá para a GRID
    oView:CreateHorizontalBox("MAIN", 30)
    oView:CreateHorizontalBox("GRID", 60)
    oView:CreateHorizontalBox("TOTAL", 10)

    //Vincula o MAIN com a VIEW_ZAF e a GRID com a GRID_ZAF
    oView:SetOwnerView('VIEW_ZLG', 'MAIN')
    oView:SetOwnerView('GRID_ZLG', 'GRID')
    oView:SetOwnerView( 'CALC1', 'TOTAL' )

    oView:EnableControlBar(.T.)

    //Define o campo incremental da grid como o ZLG_ITEM
    oView:AddIncrementField('GRID_ZLG', 'ZLG_ITEM')
Return oView


/*
===============================================================================================================================
Programa----------: SetPropM
Autor-------------: Guilherme França
Data da Criacao---: 18/02/2021
===============================================================================================================================
Descrição---------: SetPropM
===============================================================================================================================
Parametros--------:
===============================================================================================================================
Retorno-----------:
===============================================================================================================================
*/
Static Function SetPropM(oStruCab, oStruGrid)

   // Ajuste de campos obrigatórios na grid
    oStruGrid:SetProperty("*", MODEL_FIELD_OBRIGAT, .T.)

	//Validações de campos do cabeçalho
	oStruCab:SetProperty( 'ZLG_CODMIX'	, MODEL_FIELD_VALID,{|| VldCampos('ZLG_CODMIX') } )
	oStruCab:SetProperty( 'ZLG_EVENTO'	, MODEL_FIELD_VALID,{|| VldCampos('ZLG_EVENTO') } )
	oStruCab:SetProperty( 'ZLG_VENCTO'	, MODEL_FIELD_VALID,{|| VldCampos('ZLG_VENCTO') } )

	oStruGrid:SetProperty( 'ZLG_CODSA2'	, MODEL_FIELD_VALID,{|| VldCampos('ZLG_CODSA2') } )

Return
/*
===============================================================================================================================
Programa----------: ConsTitulo
Autor-------------: GUILHERME FRANÇA
Data da Criacao---: 21/07/2020
===============================================================================================================================
Descricao---------: Função que mostra detalhes do título gerado pela parcela.
===============================================================================================================================
*/
Static Function ConsTitulo()

	Local oModel     	:= FWModelActive()
	Local oModelCAB := oModel:GetModel('ZLGMASTER')
	Local oModelGRID := oModel:GetModel('ZLGGRID')
	Local _cTipoTit := PADR(Alltrim(GetMv("LT_CONVTIP")),3)
	Local _cEvento      := oModelCAB:GetValue("ZLG_EVENTO")
	Local _cCodZLG      := oModelCAB:GetValue("ZLG_CODIGO")
	Local _cItem 	:= oModelGRID:GetValue("ZLG_ITEM")
	Local _cParcela  := StrZero(1,TamSX3("E2_PARCELA")[1])
	Local _cCodSA2 	:= oModelGRID:GetValue("ZLG_CODSA2")
	Local _cLoja := oModelGRID:GetValue("ZLG_LOJSA2")

	dbSelectArea('ZL8')
	ZL8->(MsSeek(xFILIAL("ZL8")+_cEvento))
	_cNatureza := ZL8->ZL8_NATFRT
	_cPrefixo := ZL8->ZL8_PREFIX


	DbSelectArea("SE2")
	DbSetOrder(1) //E1_FILIAL, E1_CLIENTE, E1_LOJA, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, R_E_C_N_O_, D_E_L_E_T_
	If SE2->(MsSeek(xFilial("SE2")+_cPrefixo+_cCodZLG+_cItem+_cParcela+_cTipoTit+_cCodSA2+_cLoja))
		Fc050Con()
	Else
		Help( ,,1,"TITULO","Título não localizado no financeiro! Consulte departamento.", 1, 0 )
	EndIf

Return()


/*
===============================================================================================================================
Programa----------: VldCampos
Autor-------------: GUILHERME FRANÇA
Data da Criacao---: 18/02/2021
===============================================================================================================================
Descricao---------: Validações dos campos
==============================================================================================================================*/

Static Function VldCampos(xcCampo)

	Local oModel 	:= FWModelActive()
	Local oModelMain := oModel:GetModel('ZLGMASTER')
	Local _lRet := .t.
	Local _cCampo := Alltrim(xcCampo) //Alltrim(SubStr(ReadVar(),4,10))
	Local nOperation :=	oModel:GetOperation()

	If _cCampo == 'ZLG_CODMIX'
		dbSelectArea("ZLE")
		ZLE->(dbSetOrder(1))
		If ZLE->(MsSeek(xFilial("ZLE")+oModelMain:GetValue("ZLG_CODMIX")))
			If ZLE->ZLE_STATUS == "F"
				Help( ,,1,"MIX FECHADO","NÃO é permitido INCLUIR este movimento pois este MIX já está fechado!", 1, 0 )
				_lRet := .f.
			EndIf
		Else
			Help( ,,1,"MIX INVALIDO","Código de MIX não encontrado!", 1, 0 )
			_lRet := .f.
		EndIf
	ElseIf _cCampo == 'ZLG_EVENTO'
		dbSelectArea("ZL8")
		dbSetOrder(1)
		If dbSeek(xFILIAL("ZL8")+oModelMain:GetValue("ZLG_EVENTO"))
			If ZL8->ZL8_TPEVEN != "F" .Or. ZL8->ZL8_PREFIX == "" .Or. ZL8->ZL8_DEBCRE != "C"
				xMagHelpFis("Evento Incorreto","O Evento precisa ser Financeiro e de Crédito com Prefixo para ser utilizado!","Selecione um evento tipo Financeiro tipo Crédito com Prefixo!")
				_lRet := .f.
			Else
				oModelMain:LoadValue("ZLG_DESEVE",ZL8->ZL8_DESCRI)
			EndIf

		Else
			Help( ,,1,"EVENTO","Código inexistente no cadastro de eventos!", 1, 0 )
			_lRet := .f.
		EndIf
	ElseIf _cCampo == "ZLG_CODSA2"
		If nOperation <> 3
			Help(,,"CODSA2",,"Código não pode ser alterado!", 1, 0,,,,,, {"Delete a linha e inclua uma nova com código desejado."})
			_lRet := .f.
		EndIf
	ElseIf _cCampo == "ZLG_VENCTO"
		If (oModelMain:GetValue("ZLG_VENCTO") > MonthSum(ZLE->ZLE_DTFIM,1)) .or. ;
			(oModelMain:GetValue("ZLG_VENCTO") < DaySum(ZLE->ZLE_DTFIM,1)) .or. (oModelMain:GetValue("ZLG_VENCTO") < dDataBase)
			Help(,,"DTPGTO",,"Data inválida para pagamento!", 1, 0,,,,,, {"A data de pagamento deve ser dentro do mês subsequente ao mix escolhido."})
			_lRet := .f.
		EndIf
	EndIf

Return _lRet

/*
===============================================================================================================================
Programa----------: ValidaLin
Autor-------------: GUILHERME FRANÇA
Data da Criacao---: 18/02/2021
===============================================================================================================================
Descricao---------: Validações da linha
==============================================================================================================================*/

Static Function ValidaLin(xcCampo)

	Local oModel 	:= FWModelActive()
	Local oModelGRID := oModel:GetModel('ZLGGRID')
	Local oModelMain := oModel:GetModel('ZLGMASTER')
	Local _lRet := .t.
	Local nOperation	:=	oModel:GetOperation()

	If nOperation == 3 .or. nOperation == 4
		//Força preenchimento dos campos
		IF !oModelGRID:IsDeleted(oModelGRID:nLine)
			oModelGRID:LoadValue("ZLG_FILIAL",xFilial("ZLG"))
			oModelGRID:LoadValue("ZLG_CODIGO",oModelMain:GetValue("ZLG_CODIGO"))
			oModelGRID:LoadValue("ZLG_CODMIX",oModelMain:GetValue("ZLG_CODMIX"))
			oModelGRID:LoadValue("ZLG_DTLANC",oModelMain:GetValue("ZLG_DTLANC"))
			oModelGRID:LoadValue("ZLG_EVENTO",oModelMain:GetValue("ZLG_EVENTO"))
			oModelGRID:LoadValue("ZLG_DESEVE",oModelMain:GetValue("ZLG_DESEVE"))
			oModelGRID:LoadValue("ZLG_VENCTO",oModelMain:GetValue("ZLG_VENCTO"))
		EndIf
	ENDiF

Return _lRet


/*
===============================================================================================================================
Programa----------: GravaTit
Autor-------------: GUILHERME FRANÇA
Data da Criacao---: 18/02/2021
===============================================================================================================================
Descricao---------: Gravação dos títulos a pagar no financeiro.
==============================================================================================================================*/

Static Function GravaTit(oModel)

	Local _lRetorno := .t.
	Local _nOpc      := oModel:GetOperation()
	Local _cTexto := ""
	Private oProcess  := NIL

	If _nOpc == 3
		_cTexto := "Gravando titulos de crédito..."
	ElseIf _nOpc == 4
		_cTexto := "Alterando  titulos de crédito..."
	ElseIf _nOpc == 5
		_cTexto := "Excluindo  titulos de crédito..."
	EndIf

	FWMsgRun(, {|oSay|  _lRetorno := GrvTit(oSay) },'Aguarde', 'Processando arquivo...')

Return _lRetorno

Static Function GrvTit(oSay)

	Local _aArea    := GetArea()
	Local _lRetorno := .T.
	Local oModel 	:= FWModelActive()
	Local oModelCAB := oModel:GetModel("ZLGMASTER")
	Local oModelGRID  := oModel:GetModel("ZLGGRID")
	Local _nOpc      := oModel:GetOperation()
	Local _nQtdLin 	:= oModelGRID:GetQTDLine()
	Local _lDelete   := _nOpc == 5
	Local _lInclui   := _nOpc == 3
	Local _lAltera   := _nOpc == 4
	Local nX        := 0
	Local _cPrefixo  := ""
	Local _cParcela  := StrZero(1,TamSX3("E2_PARCELA")[1])
	Local _cTipoTit := PADR(Alltrim(GetMv("LT_CONVTIP")),3)
	Local _cCodZLG      := oModelCAB:GetValue("ZLG_CODIGO")
	Local _cEvento	:= oModelCAB:GetValue("ZLG_EVENTO")
	Local _cHist := oModelGRID:GetValue("ZLG_DESEVE")
	Local _cCodMix := oModelCAB:GetValue("ZLG_CODMIX")
	Local _nVlrSE2	:= 0
	Local _nX := 0

	// ------------------------------------------------
	// Preenche a Natureza do titulo NF e o Prefixo
	// ------------------------------------------------
	dbSelectArea('ZL8')
	ZL8->(MsSeek(xFILIAL("ZL8")+_cEvento))
	_cNatureza := ZL8->ZL8_NATFRT
	_cPrefixo := ZL8->ZL8_PREFIX

	If !_lDelete
		//Semaforo para pemitir a gravação de mais de um usuário por vez
		While !LockByName("AGLT011",.T.,.F. )
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
	EndIf

	Begin Transaction

		If _lDelete

			For nX:=1 To _nQtdLin

				oSay:cCaption := "Excluindo títulos do financeiro..."
				ProcessMessages()

				oModelGRID:GoLine(nX)
				_cItem 	:= oModelGRID:GetValue("ZLG_ITEM")
				_cCodSA2 	:= oModelGRID:GetValue("ZLG_CODSA2")
				_cLoja := oModelGRID:GetValue("ZLG_LOJSA2")

				DbSelectArea("SE2")
				DbSetOrder(1) //E1_FILIAL, E1_CLIENTE, E1_LOJA, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, R_E_C_N_O_, D_E_L_E_T_
				If SE2->(MsSeek(xFilial("SE2")+_cPrefixo+_cCodZLG+_cItem+_cParcela+_cTipoTit+_cCodSA2+_cLoja))
					If !U_ExcluSE2(_cPrefixo,_cCodZLG+_cItem,_cParcela,_cTipoTit,_cCodSA2,_cLoja)
						_lRetorno := .F.
					EndIf
				EndIf

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Se houve alguma falha, desfaz todas as transacoes.³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !_lRetorno
					DisarmTransaction()
					UnLockByName("AGLT011",.T.,.F.)
					FreeUsedCode()  //libera codigos de correlativos reservados pela MayIUseCode()

					Help( ,, 'ERROFIN',," Ocorreram erros durante a exclusão dos títulos no financeiro que impedem a continuidade do processo!", 1, 0 )
					Exit
				EndIf

			Next nX
		EndIf


		If _lRetorno .AND. (_lAltera .or. _lInclui)

			For nX:=1 To _nQtdLin
				oModelGRID:GoLine(nX)

				_cItem 	:= oModelGRID:GetValue("ZLG_ITEM")
				_cCodSA2 	:= oModelGRID:GetValue("ZLG_CODSA2")
				_cLoja := oModelGRID:GetValue("ZLG_LOJSA2")
				_nVlrSE2 := oModelGRID:GetValue("ZLG_VALOR")
				_dVencto := oModelGRID:GetValue("ZLG_VENCTO")

				IF _lAltera .and. oModelGRID:IsDeleted(nX) // Se a linha está deletada, deleta o título

					DbSelectArea("SE2")
					DbSetOrder(1) //E1_FILIAL, E1_CLIENTE, E1_LOJA, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, R_E_C_N_O_, D_E_L_E_T_
					If SE2->(MsSeek(xFilial("SE2")+_cPrefixo+_cCodZLG+_cItem+_cParcela+_cTipoTit+_cCodSA2+_cLoja))
						oSay:cCaption := "Excluindo títulos das linhas deletadas..."
						ProcessMessages()

						If !U_ExcluSE2(_cPrefixo,_cCodZLG+_cItem,_cParcela,_cTipoTit,_cCodSA2,_cLoja)
							_lRetorno := .F.
						EndIf
					EndIf
				ElseIf _lAltera

					oSay:cCaption := "Gravando alteração de titulos alterados..."
					ProcessMessages()

					DbSelectArea("SE2")
					DbSetOrder(1) //E1_FILIAL, E1_CLIENTE, E1_LOJA, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, R_E_C_N_O_, D_E_L_E_T_
					If SE2->(MsSeek(xFilial("SE2")+_cPrefixo+_cCodZLG+_cItem+_cParcela+_cTipoTit+_cCodSA2+_cLoja))
						If (SE2->E2_VALOR <> _nVlrSE2) //Se teve alteração de valor, o título é excluido e incluido novamente.
							If !U_ExcluSE2(_cPrefixo,_cCodZLG+_cItem,_cParcela,_cTipoTit,_cCodSA2,_cLoja)
								_lRetorno := .F.
							Else
								If !U_IncluSE2(_cPrefixo,_cCodZLG+_cItem,_cParcela,_cTipoTit,_cCodSA2,_cLoja,_cNatureza, dDataBase,_dVencto,_nVlrSE2,0,0,"",_cHist,0,_cEvento,"AGLT011",,,_cCodMix)
									_lRetorno := .F.
								EndIf
							EndIf
						ElseIf (SE2->E2_VENCTO <> _dVencto)
							RecLock("SE2",.F.)
							SE2->E2_VENCTO := _dVencto
							SE2->E2_VENCREA := DataValida(_dVencto)
							SE2->(MsUnLock())
						EndIf
					EndIf

				EndIf

				If _lInclui
					oSay:cCaption := "Incluindo títulos no financeiro..."
					ProcessMessages()

					If !U_IncluSE2(_cPrefixo,_cCodZLG+_cItem,_cParcela,_cTipoTit,_cCodSA2,_cLoja,_cNatureza, dDataBase,_dVencto,_nVlrSE2,0,0,"",_cHist,0,_cEvento,"AGLT011",,,_cCodMix)
						_lRetorno := .F.
					EndIf
				EndIf
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Se houve alguma falha, desfaz todas as transacoes.³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !_lRetorno
					DisarmTransaction()
					UnLockByName("AGLT011",.T.,.F.)
					FreeUsedCode()  //libera codigos de correlativos reservados pela MayIUseCode()

					Help( ,, 'ERROFIN',," Ocorreram erros durante a gravação dos títulos no financeiro que impedem a continuidade do processo!", 1, 0 )
					Exit
				EndIf

			Next nX

		EndIf

	End Transaction

	UnLockByName("AGLT011",.T.,.F.)
	FreeUsedCode()  //libera codigos de correlativos reservados pela MayIUseCode()

	RestArea(_aArea)

Return _lRetorno
