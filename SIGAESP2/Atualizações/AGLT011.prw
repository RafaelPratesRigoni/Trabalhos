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

//Vari�veis Est�ticas
Static cTitulo := "Lan�amento Cr�ditos"

/*
===============================================================================================================================
Programa----------: AGLT011
Autor-------------: Guilherme Fran�a
Data da Criacao---: 18/02/2021
===============================================================================================================================
Descri��o---------: Lan�amento de cr�ditos financeiros para o produtor
===============================================================================================================================
Uso---------------: Gest�o do Leite
===============================================================================================================================
Parametros--------:
===============================================================================================================================
Retorno-----------: Retornos esperados da fun��o
===============================================================================================================================
Setor-------------: Gest�o do Leite
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
Autor-------------: Guilherme Fran�a
Data da Criacao---: 18/02/2021
===============================================================================================================================
Descri��o---------: MenuDef
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
Autor-------------: GUILHERME FRAN�A
Data da Criacao---: 14/08/2020
===============================================================================================================================
Descricao---------: Valida��es do menu
==============================================================================================================================*/
USER Function GLTMNU011(_cTipo)

	Local _lPermissao :=  (GetAdvFVal("ZLU","ZLU_CREDIT",xFilial("ZLU")+cUserName,1,"N") == "S")
	Local _aArea := GetArea()
	Local _cStatus := ""

	If !_lPermissao
		Help( ,,1,"Permiss�o","Usu�rio sem permiss�o para incluir/editar cr�ditos", 1, 0 )
		Return
	EndIf

	dbSelectArea("ZLE")
	ZLE->(dbSetOrder(1))
	If ZLE->(MsSeek(xFilial("ZLE")+ZLG->ZLG_CODMIX))
		_cStatus := ZLE->ZLE_STATUS
	EndIf

	IF _cTipo	= "I"
		lOk := ( FWExecView('Valida��o de Inclusao','AGLT011', MODEL_OPERATION_INSERT,, ,  ) == 0 )
		If lOk
			U_RGLT037()
		EndIf
	ELSEIF _cTipo	= "A"
		IF _cStatus <> "F"
			lOk := ( FWExecView('Valida��o de Altera��o','AGLT011', MODEL_OPERATION_UPDATE,, ,  ) == 0 )
		ELSE
			Help( ,,1,"MIX FECHADO","N�O � permitido ALTERAR este movimento pois o MIX j� est� fechado!", 1, 0 )
		ENDIF
	ELSEIF _cTipo = 'E'
		IF _cStatus <> "F"
			lOk := ( FWExecView('Valida��o de Exclus�o','AGLT011', MODEL_OPERATION_DELETE,, ,  ) == 0 )
		ELSE
			Help( ,,1,"MIX FECHADO","N�O � permitido EXCLUIR este movimento pois o MIX j� est� fechado!", 1, 0 )
		ENDIF
	ENDIF

	RestArea(_aArea)

RETURN


/*
===============================================================================================================================
Programa----------: ModelDef
Autor-------------: Guilherme Fran�a
Data da Criacao---: 18/02/2021
===============================================================================================================================
Descri��o---------: ModelDef
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

    //Monta o modelo de dados, e na P�s Valida��o, informa a fun��o fValidGrid
    oModel := MPFormModel():New('AGLT011_MVC', /*bPreValidacao*/,{ |oModel| GravaTit(oModel) } /*{ |oModel| TudoOk(oModel)} */,/*bPosValidacao*/,/*bCommit*/, /*bCancel*/ )

    //Agora, define no modelo de dados, que ter� um Cabe�alho e uma Grid apontando para estruturas acima
    oModel:AddFields('ZLGMASTER', NIL, oStruCab)
    oModel:AddGrid('ZLGGRID', 'ZLGMASTER', oStruGrid,{ || ValidaLin() } /*bLinePre*/, /*bLinePost*/, /*bPreVal*/, /*bPosVal*/, /*BLoad*/ )

    oModel:AddCalc( 'CPOCALC', 'ZLGMASTER', 'ZLGGRID', 'ZLG_VALOR', 'ZLG_VALOR', 'SUM'  , , ,'Valor Total Lcto.' )


    aAdd(aTrigger, FwStruTrigger('ZLG_CODSA2'   ,'ZLG_NOME'   ,'SA2->A2_NOME',.T.,'SA2',1,'xFilial("SA2")+M->ZLG_CODSA2+M->ZLG_LOJSA2'))
    aAdd(aTrigger, FwStruTrigger('ZLG_LOJSA2'   ,'ZLG_NOME'   ,'SA2->A2_NOME',.T.,'SA2',1,'xFilial("SA2")+M->ZLG_CODSA2+M->ZLG_LOJSA2'))
	For xi := 1 to Len(aTrigger)
    	oStruGrid:AddTrigger(aTrigger[xi][1] ,aTrigger[xi][2] ,aTrigger[xi][3] ,aTrigger[xi][4] )
	Next xi


    //Monta o relacionamento entre Grid e Cabe�alho, as express�es da Esquerda representam o campo da Grid e da direita do Cabe�alho
    oModel:SetRelation('ZLGGRID', {;
            {"ZLG_FILIAL", "xFilial('ZLG')"},;
            {"ZLG_CODIGO",  "ZLG_CODIGO"},;
            {"ZLG_CODMIX", "ZLG_CODMIX"},;
            {"ZLG_DTLANC",  "ZLG_DTLANC"},;
            {"ZLG_EVENTO",  "ZLG_EVENTO"},;
            {"ZLG_DESEVE",  "ZLG_DESEVE"};
        }, ZLG->(IndexKey(1)))

    //Definindo outras informa��es do Modelo e da Grid
    oModel:GetModel("ZLGGRID"):SetMaxLine(999)
    oModel:SetDescription(cTitulo)
    oModel:SetPrimaryKey({"ZLG_FILIAL", "ZLG_CODIGO", "ZLG_ITEM", "ZLG_CODSA2" , "ZLG_LOJSA2"})

Return oModel

 /*
===============================================================================================================================
Programa----------: ViewDef
Autor-------------: Guilherme Fran�a
Data da Criacao---: 18/02/2021
===============================================================================================================================
Descri��o---------: ViewDef
===============================================================================================================================
Parametros--------:
===============================================================================================================================
Retorno-----------:
===============================================================================================================================
*/
Static Function ViewDef()

    //Na montagem da estrutura da visualiza��o de dados, vamos chamar o modelo criado anteriormente, no cabe�alho vamos mostrar somente 3 campos, e na grid vamos carregar conforme a fun��o fViewStruct
    Local oView        := NIL
	Local _cCpoGrid := "ZLG_ITEM;ZLG_CODSA2;ZLG_LOJSA2;ZLG_NOME;ZLG_VALOR"
    Local oModel    := FWLoadModel('AGLT011')
    Local oStruCab  := FWFormStruct(2, "ZLG", {|cCampo| AllTRim(cCampo) $ "ZLG_FILIAL;ZLG_CODIGO;ZLG_CODMIX;ZLG_DTLANC;ZLG_EVENTO;ZLG_DESEVE;ZLG_VENCTO"})
    Local oStruGRID :=  FWFormStruct(2, 'ZLG', {|cCampo| AllTRim(cCampo) $ _cCpoGrid})
    Local oStruTOT	:= FWCalcStruct( oModel:GetModel('CPOCALC') )
    //Define que no cabe�alho n�o ter� separa��o de abas (SXA)
    oStruCab:SetNoFolder()

    //Cria o View
    oView:= FWFormView():New()
    oView:SetModel(oModel)

    //Cria uma �rea de Field vinculando a estrutura do cabe�alho com MDFieldZAF, e uma Grid vinculando com MdGridZAF
    oView:AddField('VIEW_ZLG', oStruCab, 'ZLGMASTER')
    oView:AddGrid ('GRID_ZLG', oStruGRID, 'ZLGGRID' )
    oView:AddField('CALC1', oStruTOT,'CPOCALC')

	oView:SetViewProperty("GRID_ZLG", "GRIDDOUBLECLICK", {{|oFormulario,cFieldName,nLineGrid,nLineModel| Iif(Alltrim(cFieldName) $ _cCpoGrid ,ConsTitulo(),.t.)}})

    //O cabe�alho (MAIN) ter� 25% de tamanho, e o restante de 75% ir� para a GRID
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
Autor-------------: Guilherme Fran�a
Data da Criacao---: 18/02/2021
===============================================================================================================================
Descri��o---------: SetPropM
===============================================================================================================================
Parametros--------:
===============================================================================================================================
Retorno-----------:
===============================================================================================================================
*/
Static Function SetPropM(oStruCab, oStruGrid)

   // Ajuste de campos obrigat�rios na grid
    oStruGrid:SetProperty("*", MODEL_FIELD_OBRIGAT, .T.)

	//Valida��es de campos do cabe�alho
	oStruCab:SetProperty( 'ZLG_CODMIX'	, MODEL_FIELD_VALID,{|| VldCampos('ZLG_CODMIX') } )
	oStruCab:SetProperty( 'ZLG_EVENTO'	, MODEL_FIELD_VALID,{|| VldCampos('ZLG_EVENTO') } )
	oStruCab:SetProperty( 'ZLG_VENCTO'	, MODEL_FIELD_VALID,{|| VldCampos('ZLG_VENCTO') } )

	oStruGrid:SetProperty( 'ZLG_CODSA2'	, MODEL_FIELD_VALID,{|| VldCampos('ZLG_CODSA2') } )

Return
/*
===============================================================================================================================
Programa----------: ConsTitulo
Autor-------------: GUILHERME FRAN�A
Data da Criacao---: 21/07/2020
===============================================================================================================================
Descricao---------: Fun��o que mostra detalhes do t�tulo gerado pela parcela.
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
		Help( ,,1,"TITULO","T�tulo n�o localizado no financeiro! Consulte departamento.", 1, 0 )
	EndIf

Return()


/*
===============================================================================================================================
Programa----------: VldCampos
Autor-------------: GUILHERME FRAN�A
Data da Criacao---: 18/02/2021
===============================================================================================================================
Descricao---------: Valida��es dos campos
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
				Help( ,,1,"MIX FECHADO","N�O � permitido INCLUIR este movimento pois este MIX j� est� fechado!", 1, 0 )
				_lRet := .f.
			EndIf
		Else
			Help( ,,1,"MIX INVALIDO","C�digo de MIX n�o encontrado!", 1, 0 )
			_lRet := .f.
		EndIf
	ElseIf _cCampo == 'ZLG_EVENTO'
		dbSelectArea("ZL8")
		dbSetOrder(1)
		If dbSeek(xFILIAL("ZL8")+oModelMain:GetValue("ZLG_EVENTO"))
			If ZL8->ZL8_TPEVEN != "F" .Or. ZL8->ZL8_PREFIX == "" .Or. ZL8->ZL8_DEBCRE != "C"
				xMagHelpFis("Evento Incorreto","O Evento precisa ser Financeiro e de Cr�dito com Prefixo para ser utilizado!","Selecione um evento tipo Financeiro tipo Cr�dito com Prefixo!")
				_lRet := .f.
			Else
				oModelMain:LoadValue("ZLG_DESEVE",ZL8->ZL8_DESCRI)
			EndIf

		Else
			Help( ,,1,"EVENTO","C�digo inexistente no cadastro de eventos!", 1, 0 )
			_lRet := .f.
		EndIf
	ElseIf _cCampo == "ZLG_CODSA2"
		If nOperation <> 3
			Help(,,"CODSA2",,"C�digo n�o pode ser alterado!", 1, 0,,,,,, {"Delete a linha e inclua uma nova com c�digo desejado."})
			_lRet := .f.
		EndIf
	ElseIf _cCampo == "ZLG_VENCTO"
		If (oModelMain:GetValue("ZLG_VENCTO") > MonthSum(ZLE->ZLE_DTFIM,1)) .or. ;
			(oModelMain:GetValue("ZLG_VENCTO") < DaySum(ZLE->ZLE_DTFIM,1)) .or. (oModelMain:GetValue("ZLG_VENCTO") < dDataBase)
			Help(,,"DTPGTO",,"Data inv�lida para pagamento!", 1, 0,,,,,, {"A data de pagamento deve ser dentro do m�s subsequente ao mix escolhido."})
			_lRet := .f.
		EndIf
	EndIf

Return _lRet

/*
===============================================================================================================================
Programa----------: ValidaLin
Autor-------------: GUILHERME FRAN�A
Data da Criacao---: 18/02/2021
===============================================================================================================================
Descricao---------: Valida��es da linha
==============================================================================================================================*/

Static Function ValidaLin(xcCampo)

	Local oModel 	:= FWModelActive()
	Local oModelGRID := oModel:GetModel('ZLGGRID')
	Local oModelMain := oModel:GetModel('ZLGMASTER')
	Local _lRet := .t.
	Local nOperation	:=	oModel:GetOperation()

	If nOperation == 3 .or. nOperation == 4
		//For�a preenchimento dos campos
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
Autor-------------: GUILHERME FRAN�A
Data da Criacao---: 18/02/2021
===============================================================================================================================
Descricao---------: Grava��o dos t�tulos a pagar no financeiro.
==============================================================================================================================*/

Static Function GravaTit(oModel)

	Local _lRetorno := .t.
	Local _nOpc      := oModel:GetOperation()
	Local _cTexto := ""
	Private oProcess  := NIL

	If _nOpc == 3
		_cTexto := "Gravando titulos de cr�dito..."
	ElseIf _nOpc == 4
		_cTexto := "Alterando  titulos de cr�dito..."
	ElseIf _nOpc == 5
		_cTexto := "Excluindo  titulos de cr�dito..."
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
		//Semaforo para pemitir a grava��o de mais de um usu�rio por vez
		While !LockByName("AGLT011",.T.,.F. )
			MsAguarde({|| Sleep(2000) }, "Semaforo de processamento...", "Aguarde, salvando registros")
			If _nX > 60
				If !MsgYesNo("O processo est� preso por outro usu�rio. Deseja continuar aguardando?"+_ENTER;
				+"Caso voc� clique em NAO, os dados digitados ser�o perdidos!!")
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

				oSay:cCaption := "Excluindo t�tulos do financeiro..."
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

				//���������������������������������������������������Ŀ
				//� Se houve alguma falha, desfaz todas as transacoes.�
				//�����������������������������������������������������
				If !_lRetorno
					DisarmTransaction()
					UnLockByName("AGLT011",.T.,.F.)
					FreeUsedCode()  //libera codigos de correlativos reservados pela MayIUseCode()

					Help( ,, 'ERROFIN',," Ocorreram erros durante a exclus�o dos t�tulos no financeiro que impedem a continuidade do processo!", 1, 0 )
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

				IF _lAltera .and. oModelGRID:IsDeleted(nX) // Se a linha est� deletada, deleta o t�tulo

					DbSelectArea("SE2")
					DbSetOrder(1) //E1_FILIAL, E1_CLIENTE, E1_LOJA, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, R_E_C_N_O_, D_E_L_E_T_
					If SE2->(MsSeek(xFilial("SE2")+_cPrefixo+_cCodZLG+_cItem+_cParcela+_cTipoTit+_cCodSA2+_cLoja))
						oSay:cCaption := "Excluindo t�tulos das linhas deletadas..."
						ProcessMessages()

						If !U_ExcluSE2(_cPrefixo,_cCodZLG+_cItem,_cParcela,_cTipoTit,_cCodSA2,_cLoja)
							_lRetorno := .F.
						EndIf
					EndIf
				ElseIf _lAltera

					oSay:cCaption := "Gravando altera��o de titulos alterados..."
					ProcessMessages()

					DbSelectArea("SE2")
					DbSetOrder(1) //E1_FILIAL, E1_CLIENTE, E1_LOJA, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, R_E_C_N_O_, D_E_L_E_T_
					If SE2->(MsSeek(xFilial("SE2")+_cPrefixo+_cCodZLG+_cItem+_cParcela+_cTipoTit+_cCodSA2+_cLoja))
						If (SE2->E2_VALOR <> _nVlrSE2) //Se teve altera��o de valor, o t�tulo � excluido e incluido novamente.
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
					oSay:cCaption := "Incluindo t�tulos no financeiro..."
					ProcessMessages()

					If !U_IncluSE2(_cPrefixo,_cCodZLG+_cItem,_cParcela,_cTipoTit,_cCodSA2,_cLoja,_cNatureza, dDataBase,_dVencto,_nVlrSE2,0,0,"",_cHist,0,_cEvento,"AGLT011",,,_cCodMix)
						_lRetorno := .F.
					EndIf
				EndIf
				//���������������������������������������������������Ŀ
				//� Se houve alguma falha, desfaz todas as transacoes.�
				//�����������������������������������������������������
				If !_lRetorno
					DisarmTransaction()
					UnLockByName("AGLT011",.T.,.F.)
					FreeUsedCode()  //libera codigos de correlativos reservados pela MayIUseCode()

					Help( ,, 'ERROFIN',," Ocorreram erros durante a grava��o dos t�tulos no financeiro que impedem a continuidade do processo!", 1, 0 )
					Exit
				EndIf

			Next nX

		EndIf

	End Transaction

	UnLockByName("AGLT011",.T.,.F.)
	FreeUsedCode()  //libera codigos de correlativos reservados pela MayIUseCode()

	RestArea(_aArea)

Return _lRetorno
