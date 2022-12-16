#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'
#INCLUDE "TOPCONN.CH"
#include 'TOTVS.ch'
/*
===============================================================================================================================
Programa----------: AGLT105
Autor-------------: GUILHERME FRANÇA
Data da Criacao---: 29/09/2020
===============================================================================================================================
Descricao---------: Cadastro de Grupos de Preços/Linha
===============================================================================================================================
Uso---------------: Amarração de produtores ao grupo de preços, e alteração dos preços negociados.
===============================================================================================================================
Parametros--------: 
===============================================================================================================================
Retorno-----------: Nenhum
===============================================================================================================================
Chamado(SPS)------:
===============================================================================================================================
Setor-------------: Faturamento
===============================================================================================================================
*/
User function AGLT105()


	Local oBrowse
	Local ix         := 0
	Local _cFiltro   := U_FilSetor("ZL3_SETOR") + " .and. ZL3_FILIAL == '"+xFilial("ZL3")+"' "
	Private _aCampos :={'A2_L_ADICI', 'A2_L_LTECE', 'A2_L_MAIOR', 'A2_L_DTECE', 'A2_L_FIDEL', 'A2_L_EXTRA', 'A2_L_CREFX', 'A2_L_DISTA', 'A2_L_NUTRI'} //Informar quais campos do SA2 serão editados pela tela do grupo de preços
	Private _aCpoSA2 := {}
	Private _cCpoSA2 := ""

	For ix := 1 to Len(_aCampos)
		If SA2->(FieldPos(_aCampos[ix])) > 0 //Tratamento para entrar somente campos existentes no dicionário.
			AADD(_aCpoSA2,_aCampos[ix])
			_cCpoSA2 += _aCampos[ix]+"/"
		EndIf
	Next ix
	_cCpoSA2 := SubStr(_cCpoSA2,1,Len(_cCpoSA2)-1)

	oBrowse := FWmBrowse():New()
	oBrowse:SetAlias("ZL3")

//oBrowse:SetTemporary(.T.)
//oBrowse:SetFields(aBrowse)

//Descricao da Parte Superior Esquerda do Browse
	oBrowse:SetDescripton("Grupo de Preços/Linha")

	oBrowse:SetFilterDefault( _cFiltro )	

//Habilita os Botões Ambiente e WalkThru
	oBrowse:SetAmbiente(.F.)
	oBrowse:SetWalkThru(.F.)

//Adiciona legendas
/*
oBrowse:AddLegend( "ZF0_DTINI > DDATABASE .AND. ZF0_DTFIM  >= DDATABASE ", "BLUE", "Aguardando Vigencia"	)
oBrowse:AddLegend( "ZF0_DTINI <= DDATABASE .AND. ZF0_DTFIM  >= DDATABASE ", "GREEN", "Ativo"	)
oBrowse:AddLegend( "ZF0_DTFIM  < DDATABASE ", "RED"	, "Fora Vigencia"	)
*/
//Desabilita os Detalhes da parte inferior do Browse
	oBrowse:DisableDetails()

//Ativa o Browse
	oBrowse:Activate()



return
/*
===============================================================================================================================
Programa----------: MenuDef
Autor-------------: GUILHERME FRANcA
Data da Criacao---: 29/09/2020
===============================================================================================================================
Descricao---------: Opções do menu.
===============================================================================================================================
Uso---------------: Programa principal
===============================================================================================================================
*/
Static Function MenuDef()

	Local aRotina := {}

	ADD OPTION aRotina Title 'Pesquisar'  	Action 'PesqBrw'         	OPERATION 1 ACCESS 0
	ADD OPTION aRotina Title 'Visualizar'	Action 'VIEWDEF.AGLT105' 	OPERATION 2 ACCESS 0
	ADD OPTION aRotina Title 'Incluir'   	Action 'VIEWDEF.AGLT105'	OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE 'Alterar'    	ACTION 'VIEWDEF.AGLT105' 	OPERATION 4 ACCESS 0
	ADD OPTION aRotina Title 'Excluir'    	Action 'VIEWDEF.AGLT105'	OPERATION 5 ACCESS 0

Return aRotina

/*
===============================================================================================================================
Programa----------: ModelDef
Autor-------------: GUILHERME FRANcA
Data da Criacao---: 29/09/2020
===============================================================================================================================
Descricao---------: Modelo de dados.
===============================================================================================================================
Uso---------------: Programa principal
===============================================================================================================================
*/
Static Function ModelDef()

	Local oStruZL3  :=  FWFormStruct(1,'ZL3') //Retorna a Estrutura do Alias passado como Parametro (1=Model,2=View)
	Local oStruSA2  :=  FWFormStruct( 1, 'SA2' , { |x| ALLTRIM(x) $ "A2_COD/ A2_LOJA/ A2_NOME / A2_L_TANQ /A2_L_LI_RO"+_cCpoSA2 } )
	Local oModel



//Instancia do Objeto de Modelo de Dados
	oModel	:=	MpFormModel():New('MAGLT105',/*Pre-Validacao*/,{ |oModel| GravaOk(oModel)}/* Pos-Validacao*/,/*Commit*/,/*Commit*/,/*Cancel*/)

//CriaCampos("M",oStruSA2,oStruTR1,oStruTR2,oStruTR3,oStruTR4)

// validações campos
	oStruSA2:SetProperty( 'A2_COD'	, MODEL_FIELD_WHEN,{|| .T.} )
	oStruSA2:SetProperty( 'A2_COD'	, MODEL_FIELD_VALID,{|| VldCampos('A2_COD') } )
	oStruSA2:SetProperty( 'A2_LOJA'	, MODEL_FIELD_VALID,{|| VldCampos('A2_LOJA') } )

	If SA2->(FieldPos('A2_L_PRCEP')) > 0
		oStruSA2:SetProperty( 'A2_L_PRCEP'	, MODEL_FIELD_VALID,{|| VldCampos('A2_L_PRCEP') } )
		oStruSA2:SetProperty( 'A2_L_VLCEP'	, MODEL_FIELD_VALID,{|| VldCampos('A2_L_VLCEP') } )
	EndIf

//Adiciona um modelo de Formulario de Cadastro Similar à Enchoice ou Msmget
	oModel:AddFields('ZL3MASTER', /*cOwner*/, oStruZL3, /*bPreValidacao*/, /*bPosValidacao*/, /*bCarga*/ )
	oModel:AddGrid('SA2DETAIL', 'ZL3MASTER', oStruSA2, /*bLinePre*/, /* { || ValidDatas("2")} bLinePost*/, /*bPreVal*/,/*bPosVal*/, /*BLoad*/ )


	oModel:AddCalc( 'CPOCALC1', 'ZL3MASTER', 'SA2DETAIL', 'A2_COD', 'A2_COD', 'COUNT'  , , ,'Qtd.Produtores' )
	oModel:AddCalc( 'CPOCALC1', 'ZL3MASTER', 'SA2DETAIL', 'A2_L_ADICI', 'A2_L_ADICI', 'AVERAGE'  , , ,'Média '+AllTrim(GetSx3Cache("A2_L_ADICI","X3_TITULO")) )

/*
//Gera gatilhos
aAdd(aTrigger, FwStruTrigger('A2_COD'   ,'A2_NOME'	,'SA2->A2_NOME'	,.F.))
aAdd(aTrigger, FwStruTrigger('R1PRECO' ,'R1TOTAL'	,'M->R1QTD * M->R1PRECO'	,.F.))
	For _i := 1 to Len(aTrigger)
	oStruSA2:AddTrigger(aTrigger[_i][1] ,aTrigger[_i][2] ,aTrigger[_i][3] ,aTrigger[_i][4] )
	Next _i
*/

// Adiciona a descricao do Componente do Modelo de Dados
	oModel:SetDescripton("Grupo de Preços/Linha")
	oModel:GetModel( 'ZL3MASTER' ):SetDescription( 'Grupo' )
	oModel:GetModel( 'SA2DETAIL' ):SetDescription( 'Produtores' )


//Informa que os dados dos model não serão gravados ao confirmar a tela
	oModel:GetModel( 'SA2DETAIL' ):SetOnlyQuery(.T.)

// Indica que é opcional ter dados informados na Grid
	oModel:GetModel( 'SA2DETAIL' ):SetOptional(.F.)


// Faz relaciomaneto entre os compomentes do model
	oModel:SetRelation( 'SA2DETAIL', { { 'A2_FILIAL', 'xFilial( "SA2" )' }, { 'A2_L_LI_RO', 'ZL3_COD' } }, SA2->( IndexKey( 1 ) ) )

// Liga o controle de nao repeticao de linha
	oModel:GetModel( 'SA2DETAIL' ):SetUniqueLine( { "A2_COD","A2_LOJA" } )

//Define chave primária do modelo de dados.
	oModel:SetPrimaryKey({"ZL3_FILIAL","ZL3_COD"})


Return(oModel)

/*
===============================================================================================================================
Programa----------: ViewDef
Autor-------------: GUILHERME FRANcA
Data da Criacao---: 29/09/2020
===============================================================================================================================
Descricao---------: Modelo de dados.
===============================================================================================================================
Uso---------------: Programa principal
===============================================================================================================================
*/
Static Function ViewDef()

	Local oView
// Cria um objeto de Modelo de Dados baseado no ModelDef do fonte informado
	Local oModel   	:= FWLoadModel( 'AGLT105' )
// Cria a estrutura a ser usada na View
	Local oStruZL3	:= FWFormStruct( 2, 'ZL3' )
	Local oStruSA2  :=  FWFormStruct( 2, 'SA2' , { |x| ALLTRIM(x) $ "A2_COD/ A2_LOJA/ A2_NOME/ A2_L_TANQ / A2_L_LI_RO"+_cCpoSA2 } )
	Local oStruCal	:= FWCalcStruct( oModel:GetModel('CPOCALC1') )
	Local ix := 1
//CriaStruct('V','SA200') //Retorna a Estrutura do Alias passado como Parametro (1=Model,2=View)


	oStruSA2:RemoveField( 'A2_L_LI_RO' )

// Cria o objeto de View
	oView := FWFormView():New()

//CriaCampos("V",oStruSA2,oStruTR1,oStruTR2,oStruTR3,oStruTR4)

	oView:SetDescripton("Grupo de Preços/Linha")

// Define propriedades para os campos
//SetProp("V",oStruSA2,oStruTR1,oStruTR2,oStruTR3,oStruTR4,oStruZL3)
	oStruSA2:SetProperty( 'A2_COD'	, MVC_VIEW_LOOKUP,"SA2_L4" )
	oStruSA2:SetProperty( 'A2_NOME'	, MVC_VIEW_TITULO,"Nome do Produtor" )

	oStruSA2:SetProperty( 'A2_COD'	, MVC_VIEW_CANCHANGE, .T. )
	oStruSA2:SetProperty( 'A2_NOME'	, MVC_VIEW_CANCHANGE, .F. )
	oStruSA2:SetProperty( 'A2_L_TANQ', MVC_VIEW_CANCHANGE, .F. )

	For ix := 1 to Len(_aCpoSA2)
		oStruSA2:SetProperty( _aCpoSA2[ix]	, MVC_VIEW_CANCHANGE, .T. )
	Next ix'


// Define qual o Modelo de dados ser utilizado
	oView:SetModel( oModel )

//Adiciona no nosso View um controle do tipo FormFields(antiga enchoice)
	oView:AddField( 'VIEW_ZL3', oStruZL3, 'ZL3MASTER' )

//Adiciona no nosso View um controle do tipo FormGrid(antiga newgetdados)
	oView:AddGrid(  'VIEW_SA2', oStruSA2, 'SA2DETAIL' )

	oView:AddField('CALC', oStruCal,'CPOCALC1')


// Cria um "box" horizontal para receber cada elemento da view
	oView:CreateHorizontalBox( 'SUPERIOR', 22 )
// box centro
	oView:CreateHorizontalBox( 'CENTRO', 68 )
// box inferior contadores
	oView:CreateHorizontalBox( 'INFERIOR', 10 )

	oView:CreateVerticalBox( 'SUPERIORESQ', 70, 'SUPERIOR' )
	oView:CreateVerticalBox( 'SUPERIORDIR', 30, 'SUPERIOR' )

/*
oView:CreateVerticalBox( 'INFERIORESQ', 35, 'INFERIOR' )
oView:CreateVerticalBox( 'INFERIORMEI', 35, 'INFERIOR' ) 
oView:CreateVerticalBox( 'INFERIORDIR', 30, 'INFERIOR' ) 
*/
// Relaciona o ID da View com o "box" para exibicao
	oView:SetOwnerView( 'VIEW_ZL3'	, 'SUPERIORESQ' )

	oView:SetOwnerView( 'VIEW_SA2'	, 'CENTRO' )

	oView:SetOwnerView( 'CALC', 'INFERIOR' )
//oView:SetOwnerView( 'CALC2', 'INFERIORMEI' )
// Define campos que terao Auto Incremento
//oView:AddIncrementField( 'VIEW_ZL3', 'ZL3_ITEM' ) 


// Criar novo botao na barra de botoes
//oView:AddUserButton( 'Inclui Autor', 'CLIPS', { |oView| COMP021BUT() } )

	oView:AddOtherObject("BUTTON_PANEL", {|oPanel| COMPBUT(oPanel,oModel)})
// Associa ao box que ira exibir os outros objetos
	oView:SetOwnerView("BUTTON_PANEL",'SUPERIORDIR')


// Liga a identificacao do componente
//oView:EnableTitleView('VIEW_ZL3','Grupo')
	oView:EnableTitleView('VIEW_SA2','Produtores')


Return oView

//-------------------------------------------------------------------
Static Function COMPBUT( oPanel, oModel )

	Local oFont := TFont():New("Arial",,016,,.T.,,,,,.F.,.F.)

// Ancoramos os objetos no oPanel passado
	@ 10, 10 Button 'Alterar Valores' Size 80, 25 Message 'Alteração de Valores em lote' FONT oFont Pixel Action EditPreco(oModel) of oPanel

Return NIL

//#######################################
// FUNCAO PARA EDIÇÃO DE TODOS OS PREÇOS
//#######################################
Static Function EditPreco(oModel)

	Local _nOpc      := oModel:GetOperation()
	Local oDlg1
	Local oCombo1
	Local cCombo1    := ""
	Local ix         := 0
	Local oSay
	Private _nVlr    := 0
	Private _nMaior  := 0
	Private _nMenor  := 0
	Private aItens1  := {}
	Private _aOrdSA2 := {}
	Private oFont1   := TFont():New("Arial", , 019, , .T., , , , , .F., .F.)
	Private oFont2   := TFont():New("Arial", , 018, , .F., , , , , .F., .F.)

	If !(_nOpc == 3 .or. _nOpc == 4)
		Help(,,"INDISPONIVEL",,"Opção disponivel somente na inclusão ou alteração!", 1, 0,,,,,, {""})
		Return
	EndIf


	For ix := 1 to Len(_aCpoSA2)
		If GetSx3Cache(_aCpoSA2[ix],"X3_TIPO") == "N"
			AADD(aItens1,StrZero(ix,2)+" "+AllTrim(GetSx3Cache(_aCpoSA2[ix],"X3_TITULO")))
			AADD(_aOrdSA2,ix)
		EndIf
	Next ix



	Define MSDialog oDlg1 Title "EDIÇÃO DOS VALORES EM LOTE" From 0,0 TO 270,420 Pixel
	@ 005,015 Say "Campo a editar:" FONT oFont1 PIXEL OF oDlg1

	cCombo1:= IIf(Empty(cCombo1),aItens1[1],cCombo1)
	oCombo1 := TComboBox():New(003,080,{|u|if(PCount()>0,cCombo1:=u,cCombo1)},aItens1,80,20,oDlg1,,/*{||Alert('Mudou item da combo')}*/,,,,.T.,,,,,,,,,'cCombo1')

	@ 027,030 Say "Valor a somar (+ ou -):"  PIXEL OF oDlg1
	@ 025,085 Get _nVlr Size 40,15  Picture "@E 99.9999" when .T. PIXEL OF oDlg1
	@ 046,055 Say "-- Filtros para alteração --" FONT oFont1  PIXEL OF oDlg1
	@ 063,040 Say "Maior ou igual a:"  PIXEL OF oDlg1
	@ 062,085 Get _nMaior Size 40,10  Picture "@E 99.9999" when .T. PIXEL OF oDlg1
	@ 079,040 Say "Menor ou igual a:"  PIXEL OF oDlg1
	@ 078,085 Get _nMenor Size 40,10  Picture "@E 99.9999" when .T. PIXEL OF oDlg1
//@ 100,050 Button "&Confirmar" SIZE 45,18 FONT oFont1 ACTION {|| _lExec:= .t.,oDlg1:End()} PIXEL OF oDlg1
	@ 100,020 Button "&Alterar" SIZE 50,18 FONT oFont2 ACTION FWMsgRun(, {|oSay| ExecAlter(oSay,cCombo1),oDlg1:End() },'Aguarde', 'Alterando registros...') PIXEL OF oDlg1
	@ 100,080 Button "Fixar &Valor" SIZE 50,18 FONT oFont2 ACTION FWMsgRun(, {|oSay| ExecAlter(oSay,cCombo1,"F"),oDlg1:End() },'Aguarde', 'Alterando registros...') PIXEL OF oDlg1
	@ 100,140 Button "&Fechar" SIZE 50,18 FONT oFont2 ACTION oDlg1:End() PIXEL OF oDlg1
	ACTIVATE DIALOG oDlg1 CENTERED

Return

Static Function ExecAlter(oSay,cCombo1,xOP)

	Local oModel   := FWModelActive()
	Local oView    := FWViewActive()
	Local oStruSA2 := oModel:GetModel( 'SA2DETAIL' )
	Local _nQtdLin := oStruSA2:GetQTDLine()
	Local _nInd    := 0
	Local _nVlrCpo := 0
	Local _cCampo  := ""
	Local _nCont   := 0
	Local yx       := 0
	DEFAULT xOP    := "A"

	If xOP =="F" .and. _nVlr<0
		If !MsgYesNo("Foi digitado valor NEGATIVO, confirma preenchimento assim mesmo?","VALOR NEGATIVO")
			Return
		EndIf
	EndIf

	_nInd := Val(SubStr(cCombo1,1,2)) //indice para o nome do campo no array _aCpoSA2
	_cCampo := _aCpoSA2[_aOrdSA2[_nInd]]
	For yx :=1 To _nQtdLin

		oSay:cCaption := "Alterando linha: "+cValToChar(yx)
		ProcessMessages()

		oStruSA2:GoLine(yx)
		IF !oStruSA2:IsDeleted(yx)
			_nVlrCpo := oStruSA2:GetValue(_cCampo)
			If _nVlrCpo >= _nMaior .and. _nVlrCpo <= _nMenor
				If xOP == "A" //Altera valores
					_nVlrCpo += _nVlr
					_nVlrCpo := IIF(_nVlrCpo<0,0,_nVlrCpo)
					oStruSA2:SetValue(_cCampo,_nVlrCpo)
				Else //Fixa valor digitado
					oStruSA2:SetValue(_cCampo,_nVlr)
				EndIf
				_nCont++
			EndIf
		EndIf
	Next yx
	oStruSA2:GoLine(1)
	oView:Refresh()
	If _nCont > 0
		MsgInfo(Alltrim(cValToChar(_nCont))+" registro(s) alterado(s)!","Confirmação")
	EndIf


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

	Local oModel   := FWModelActive()
	Local oView    := FWViewActive()
	Local oStruSA2 := oModel:GetModel( 'SA2DETAIL' )
	Local _lRet    := .t.
	Local _cCampo  := xcCampo //Alltrim(SubStr(ReadVar(),4,10))
	Local _cAliSA2 := ""
	Local ix       := 0

	If _cCampo $ 'A2_COD/A2_LOJA'
		_cProdut := Alltrim(oStruSA2:GetValue("A2_COD"))
		_cLoja := Alltrim(oStruSA2:GetValue("A2_LOJA"))
		_cLoja := IIF(Empty(_cLoja),StrZero(1,TamSx3("A2_LOJA")[1]),_cLoja)
		If Len(_cProdut) < TamSx3("A2_COD")[1]
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
				If _cCampo == 'A2_LOJA'
					If !Empty(SA2->A2_L_LI_RO)
						If MsgYesNo("O produtor já pertence ao grupo "+SA2->A2_L_LI_RO+". Deseja continuar e alterar o grupo do produtor?","Grupo Preenchido")
							oStruSA2:LoadValue("A2_COD",SA2->A2_COD)
							oStruSA2:LoadValue("A2_LOJA",SA2->A2_LOJA)
							oStruSA2:LoadValue("A2_NOME",SA2->A2_NOME)
							oStruSA2:LoadValue("A2_L_TANQ",SA2->A2_L_TANQ)
							For ix := 1 to Len(_aCpoSA2)
								oStruSA2:SetValue(_aCpoSA2[ix],SA2->&(_aCpoSA2[ix]))
							Next ix


						Else
							_lRet := .f.
						EndIf
					Else
						oStruSA2:LoadValue("A2_COD",SA2->A2_COD)
						oStruSA2:LoadValue("A2_LOJA",SA2->A2_LOJA)
						oStruSA2:LoadValue("A2_NOME",SA2->A2_NOME)
						oStruSA2:LoadValue("A2_L_TANQ",SA2->A2_L_TANQ)
						For ix := 1 to Len(_aCpoSA2)
							oStruSA2:SetValue(_aCpoSA2[ix],SA2->&(_aCpoSA2[ix]))
						Next ix


					EndIf
				EndIf
			EndIf
		Else
			Help(,,"Produtor",,"Cadastro não localizado!", 1, 0,,,,,, {"Informe um cadastro do tipo 'P' válido."})
			_lRet := .f.
		EndIf
	EndIf

	If SA2->(FieldPos('A2_L_PRCEP')) > 0
		If _cCampo $ 'A2_L_PRCEP'
			If oStruSA2:GetValue("A2_L_VLCEP") <> 0
				Help(,,"% CEPEA",,"Campo só pode ser informado se o Vlr. CEPEA estiver zerado!", 1, 0,,,,,, {"Informe zero no campo Vlr. CEPEA"})
				_lRet := .f.
			EndIf
		EndIf
		If _cCampo $ 'A2_L_VLCEP'
			If oStruSA2:GetValue("A2_L_PRCEP") > 0
				Help(,,"Vlr. CEPEA",,"Campo só pode ser informado se o % CEPEA estiver zerado!", 1, 0,,,,,, {"Informe zero no campo % CEPEA"})
				_lRet := .f.
			EndIf
		EndIf
	EndIf


	If (oView <> NIL)
		oView:Refresh()
	EndIf

Return _lRet

/*
===============================================================================================================================
Programa----------: GravaOK
Autor-------------: GUILHERME FRANcA
Data da Criacao---: 29/09/2020
===============================================================================================================================
Descricao---------: Gravação grupos na SA2
===============================================================================================================================
Uso---------------: Programa principal
===============================================================================================================================
*/
Static Function GravaOK(oModel)

	Local oSay

	FWMsgRun(, {|oSay|GravacaoSA2(oModel,oSay) },'Aguarde', 'Salvando dados...')

Return .t.

Static Function GravacaoSA2(oModel,oSay)

	Local oStruSA2 := oModel:GetModel( 'SA2DETAIL' )
	Local oStruZL3 := oModel:GetModel( 'ZL3MASTER' )
	Local _cGrupo  := oStruZL3:GetValue("ZL3_COD")
	Local _nOpc    := oModel:GetOperation()
	Local _nQtdLin := oStruSA2:GetQTDLine()
	Local nX       := 0
	Local ix       := 0
	Local _nX      := 0


	//Semaforo para pemitir a gravação de mais de um usuário por vez
	While !LockByName("AGLT105",.T.,.F. )
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


	DBSelectArea("SA2")
	DBSetOrder(1)

	If _nOpc == 3 .or. _nOpc == 4

		For nX:=1 To _nQtdLin

			oSay:cCaption := "Gravando alterações..."
			ProcessMessages()

			oStruSA2:GoLine(nX)
			SA2->(MsSeek(xFilial("SA2")+oStruSA2:GetValue("A2_COD")+oStruSA2:GetValue("A2_LOJA")))
			IF !oStruSA2:IsDeleted(nX)
				RecLock("SA2",.F.)
				SA2->A2_L_LI_RO := _cGrupo
				For ix := 1 to Len(_aCpoSA2)
					SA2->&(_aCpoSA2[ix]) := oStruSA2:GetValue(_aCpoSA2[ix])
				Next ix

				SA2->(MsUnLock())
			Else
				If SA2->A2_L_LI_RO == _cGrupo //so limpa grupo se produtor já pertencesse a este
					RecLock("SA2",.F.)
					SA2->A2_L_LI_RO := ""
					SA2->(MsUnLock())
				EndIf
			EndIf
		Next nX
	ElseIf _nOpc == 5

		For nX:=1 To _nQtdLin

			oStruSA2:GoLine(nX)
			SA2->(MsSeek(xFilial("SA2")+oStruSA2:GetValue("A2_COD")+oStruSA2:GetValue("A2_LOJA")))
			If SA2->A2_L_LI_RO == _cGrupo //so limpa grupo se produtor já pertencesse a este
				RecLock("SA2",.F.)
				SA2->A2_L_LI_RO := ""
				SA2->(MsUnLock())
			EndIf
		Next nX

	EndIf

	UnLockByName("AGLT105",.T.,.F.)     
	FreeUsedCode()  //libera codigos de correlativos reservados pela MayIUseCode()

Return .t.
