#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'
#INCLUDE "TOPCONN.CH"
#include 'TOTVS.ch'
/*
===============================================================================================================================
Programa----------: AGLT032
Autor-------------: GUILHERME FRAN«A
Data da Criacao---: 29/09/2020
===============================================================================================================================
Descricao---------: Cadastro de Grupos de Volume
===============================================================================================================================
Uso---------------: AmarraÁ„o de produtores ao grupo de volume
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
User function AGLT032()


Local oBrowse

oBrowse := FWmBrowse():New()
oBrowse:SetAlias("ZL5")

//oBrowse:SetTemporary(.T.)
//oBrowse:SetFields(aBrowse)

//Descricao da Parte Superior Esquerda do Browse
oBrowse:SetDescripton("Grupo de Volume")

//Habilita os Botıes Ambiente e WalkThru
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
Descricao---------: OpÁıes do menu.
===============================================================================================================================
Uso---------------: Programa principal
===============================================================================================================================
*/
Static Function MenuDef()

Local aRotina := {}

ADD OPTION aRotina Title 'Pesquisar'  	Action 'PesqBrw'         	OPERATION 1 ACCESS 0
ADD OPTION aRotina Title 'Visualizar'	Action 'VIEWDEF.AGLT032' 	OPERATION 2 ACCESS 0
ADD OPTION aRotina Title 'Incluir'   	Action 'VIEWDEF.AGLT032'	OPERATION 3 ACCESS 0
ADD OPTION aRotina TITLE 'Alterar'    	ACTION 'VIEWDEF.AGLT032' 	OPERATION 4 ACCESS 0
ADD OPTION aRotina Title 'Excluir'    	Action 'VIEWDEF.AGLT032'	OPERATION 5 ACCESS 0

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

Local oStruZL5  :=  FWFormStruct(1,'ZL5') //Retorna a Estrutura do Alias passado como Parametro (1=Model,2=View)
Local oStruSA2  :=  FWFormStruct( 1, 'SA2' , { |x| ALLTRIM(x) $ "A2_COD/ A2_LOJA/ A2_NOME / A2_END / A2_MUN / A2_L_TANQ / A2_L_LI_RO /A2_L_GRUPO" } )
Local oModel
Local _aZL5Relation := {}


//Instancia do Objeto de Modelo de Dados
oModel	:=	MpFormModel():New('MAGLT032',/*Pre-Validacao*/,{ |oModel| GravaOk(oModel)}/* Pos-Validacao*/,/*Commit*/,/*Commit*/,/*Cancel*/)

//CriaCampos("M",oStruSA2,oStruTR1,oStruTR2,oStruTR3,oStruTR4)

// validaÁıes campos
oStruSA2:SetProperty( 'A2_COD'	, MODEL_FIELD_WHEN,{|| .T.} )
oStruSA2:SetProperty( 'A2_COD'	, MODEL_FIELD_VALID,{|| VldCampos('A2_COD') } )
oStruSA2:SetProperty( 'A2_LOJA'	, MODEL_FIELD_VALID,{|| VldCampos('A2_LOJA') } )


//Adiciona um modelo de Formulario de Cadastro Similar ‡ Enchoice ou Msmget
oModel:AddFields('ZL5MASTER', /*cOwner*/, oStruZL5, /*bPreValidacao*/, /*bPosValidacao*/, /*bCarga*/ )
oModel:AddGrid('SA2DETAIL', 'ZL5MASTER', oStruSA2, /*bLinePre*/, /* { || ValidDatas("2")} bLinePost*/, /*bPreVal*/,/*bPosVal*/, /*BLoad*/ )

/*
//Gera gatilhos
aAdd(aTrigger, FwStruTrigger('A2_COD'   ,'A2_NOME'	,'SA2->A2_NOME'	,.F.))
aAdd(aTrigger, FwStruTrigger('R1PRECO' ,'R1TOTAL'	,'M->R1QTD * M->R1PRECO'	,.F.))
For _i := 1 to Len(aTrigger)
	oStruSA2:AddTrigger(aTrigger[_i][1] ,aTrigger[_i][2] ,aTrigger[_i][3] ,aTrigger[_i][4] )
Next _i
*/

// Adiciona a descricao do Componente do Modelo de Dados
oModel:SetDescripton("Grupo de Volume")
oModel:GetModel( 'ZL5MASTER' ):SetDescription( 'Grupo' )
oModel:GetModel( 'SA2DETAIL' ):SetDescription( 'Produtores' )


//Informa que os dados dos model n„o ser„o gravados ao confirmar a tela
oModel:GetModel( 'SA2DETAIL' ):SetOnlyQuery(.T.)

// Indica que È opcional ter dados informados na Grid
oModel:GetModel( 'SA2DETAIL' ):SetOptional(.F.)


// Faz relaciomaneto entre os compomentes do model
oModel:SetRelation( 'SA2DETAIL', { { 'A2_FILIAL', 'xFilial( "SA2" )' }, { 'A2_L_GRUPO', 'ZL5_COD' } }, SA2->( IndexKey( 1 ) ) )

// Liga o controle de nao repeticao de linha
oModel:GetModel( 'SA2DETAIL' ):SetUniqueLine( { "A2_COD","A2_LOJA" } )

//Define chave prim·ria do modelo de dados.
oModel:SetPrimaryKey({"ZL5_FILIAL","ZL5_COD"})


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
Local oModel   	:= FWLoadModel( 'AGLT032' ) 
// Cria a estrutura a ser usada na View
Local oStruZL5	:= FWFormStruct( 2, 'ZL5' )
Local oStruSA2  :=  FWFormStruct( 2, 'SA2' , { |x| ALLTRIM(x) $ "A2_COD/ A2_LOJA/ A2_NOME/ A2_END / A2_MUN / A2_L_TANQ /A2_L_LI_RO / A2_L_GRUPO" } )
//CriaStruct('V','SA200') //Retorna a Estrutura do Alias passado como Parametro (1=Model,2=View)


oStruSA2:RemoveField( 'A2_L_GRUPO' )

// Cria o objeto de View
oView := FWFormView():New()

//CriaCampos("V",oStruSA2,oStruTR1,oStruTR2,oStruTR3,oStruTR4)

oView:SetDescripton("Grupo de Volume")

// Define propriedades para os campos
//SetProp("V",oStruSA2,oStruTR1,oStruTR2,oStruTR3,oStruTR4,oStruZL5)
oStruSA2:SetProperty( 'A2_COD'	, MVC_VIEW_LOOKUP,"SA2_L8" )
oStruSA2:SetProperty( 'A2_NOME'	, MVC_VIEW_TITULO,"Nome do Produtor" )

oStruSA2:SetProperty( 'A2_COD'	, MVC_VIEW_CANCHANGE, .T. )
oStruSA2:SetProperty( 'A2_NOME'	, MVC_VIEW_CANCHANGE, .F. )
oStruSA2:SetProperty( 'A2_END'	, MVC_VIEW_CANCHANGE, .F. )
oStruSA2:SetProperty( 'A2_MUN'	, MVC_VIEW_CANCHANGE, .F. )
oStruSA2:SetProperty( 'A2_L_TANQ', MVC_VIEW_CANCHANGE, .F. )
oStruSA2:SetProperty( 'A2_L_LI_RO', MVC_VIEW_CANCHANGE, .F. )



// Define qual o Modelo de dados serù utilizado
oView:SetModel( oModel )

//Adiciona no nosso View um controle do tipo FormFields(antiga enchoice)
oView:AddField( 'VIEW_ZL5', oStruZL5, 'ZL5MASTER' )

//Adiciona no nosso View um controle do tipo FormGrid(antiga newgetdados)
oView:AddGrid(  'VIEW_SA2', oStruSA2, 'SA2DETAIL' )  

// Cria um "box" horizontal para receber cada elemento da view
oView:CreateHorizontalBox( 'SUPERIOR', 20 )
// box inferior
oView:CreateHorizontalBox( 'INFERIOR', 80 )

// Relaciona o ID da View com o "box" para exibicao
oView:SetOwnerView( 'VIEW_ZL5'	, 'SUPERIOR' )

oView:SetOwnerView( 'VIEW_SA2'	, 'INFERIOR' )

// Define campos que terao Auto Incremento
//oView:AddIncrementField( 'VIEW_ZL5', 'ZL5_ITEM' ) 


// Criar novo botao na barra de botoes
//oView:AddUserButton( 'Inclui Autor', 'CLIPS', { |oView| COMP021BUT() } )

// Liga a identificacao do componente
//oView:EnableTitleView('VIEW_ZL5','Grupo')
oView:EnableTitleView('VIEW_SA2','Produtores')


Return oView

/*
===============================================================================================================================
Programa----------: VldCampos
Autor-------------: GUILHERME FRAN«A
Data da Criacao---: 14/08/2020
===============================================================================================================================
Descricao---------: ValidaÁıes dos campos
==============================================================================================================================*/

Static Function VldCampos(xcCampo)

Local oModel 	:= FWModelActive()
Local oView 	:= FWViewActive()   
Local oStruSA2	:= oModel:GetModel('SA2DETAIL')
Local _lRet := .t.
Local _cCampo := xcCampo //Alltrim(SubStr(ReadVar(),4,10))
Local _cAliSA2 := ""
Local ix := 0
Local _nLinAtu := 0


	If _cCampo $ 'A2_COD/A2_LOJA'
		_cProdut := Alltrim(oStruSA2:GetValue("A2_COD"))
		_cLoja := Alltrim(oStruSA2:GetValue("A2_LOJA"))
		_cLoja := IIF(Empty(_cLoja),StrZero(1,TamSx3("A2_LOJA")[1]),_cLoja)
		If Len(_cProdut) < TamSx3("A2_COD")[1]
			//Completa cÛdigo digitado reduzido
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
				Help(,,"Produtor",,"Cadastro n„o È de produtor ou est· bloqueado!", 1, 0,,,,,, {"Informe um cadastro do tipo 'P' v·lido."})
				_lRet := .f.
			Else
				If !Empty(SA2->A2_L_GRUPO)
					If MsgYesNo("O produtor j· pertence ao grupo "+SA2->A2_L_GRUPO+". Deseja continuar e alterar o grupo do produtor?","Grupo Preenchido")
						oStruSA2:LoadValue("A2_COD",SA2->A2_COD)
						oStruSA2:LoadValue("A2_LOJA",SA2->A2_LOJA)
						oStruSA2:LoadValue("A2_NOME",SA2->A2_NOME)
						oStruSA2:LoadValue("A2_END",SA2->A2_END)
						oStruSA2:LoadValue("A2_MUN",SA2->A2_MUN)
						oStruSA2:LoadValue("A2_L_TANQ",SA2->A2_L_TANQ)
						oStruSA2:LoadValue("A2_L_LI_RO",SA2->A2_L_LI_RO)
					Else
						_lRet := .f.
					EndIf
				Else
					oStruSA2:LoadValue("A2_COD",SA2->A2_COD)
					oStruSA2:LoadValue("A2_LOJA",SA2->A2_LOJA)
					oStruSA2:LoadValue("A2_NOME",SA2->A2_NOME)
					oStruSA2:LoadValue("A2_END",SA2->A2_END)
					oStruSA2:LoadValue("A2_MUN",SA2->A2_MUN)
					oStruSA2:LoadValue("A2_L_TANQ",SA2->A2_L_TANQ)
					oStruSA2:LoadValue("A2_L_LI_RO",SA2->A2_L_LI_RO)
				EndIf
			EndIf
		Else
			Help(,,"Produtor",,"Cadastro n„o localizado!", 1, 0,,,,,, {"Informe um cadastro do tipo 'P' v·lido."})
			_lRet := .f.
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
Descricao---------: GravaÁ„o grupos na SA2
===============================================================================================================================
Uso---------------: Programa principal
===============================================================================================================================
*/
Static Function GravaOK(oModel)

Local oStruSA2 	:= oModel:GetModel('SA2DETAIL')
Local oStruZL5 	:= oModel:GetModel('ZL5MASTER')
Local _cGrupo := oStruZL5:GetValue("ZL5_COD")
Local _nOpc      := oModel:GetOperation()
Local _nQtdLin 	:= oStruSA2:GetQTDLine()
Local _cMaior := "" //variavel para campo ZL5_MAIOR usado para flegar os produtores que participam do evento de maiores produtores.
Local nX := 0

//Se existir o campo, atualiza
If FieldPos("ZL5_MAIOR") > 0
	_cMaior := oStruZL5:GetValue("ZL5_MAIOR")
EndIf

DBSelectArea("SA2")
DBSetOrder(1)

If _nOpc == 3 .or. _nOpc == 4
	For nX:=1 To _nQtdLin
		oStruSA2:GoLine(nX)
		SA2->(MsSeek(xFilial("SA2")+oStruSA2:GetValue("A2_COD")+oStruSA2:GetValue("A2_LOJA")))
		IF !oStruSA2:IsDeleted(nX)
			RecLock("SA2",.F.)
			SA2->A2_L_GRUPO := _cGrupo
			If FieldPos("ZL5_MAIOR") > 0
				SA2->A2_L_MAIOR := _cMaior
			EndIf
			SA2->(MsUnLock())
		Else
			RecLock("SA2",.F.)
			SA2->A2_L_GRUPO := ""
			If FieldPos("ZL5_MAIOR") > 0
				SA2->A2_L_MAIOR := "N"
			EndIf
			SA2->(MsUnLock())
		EndIf
	Next nX
ElseIf _nOpc == 5

	For nX:=1 To _nQtdLin

		oStruSA2:GoLine(nX)
		SA2->(MsSeek(xFilial("SA2")+oStruSA2:GetValue("A2_COD")+oStruSA2:GetValue("A2_LOJA")))
		RecLock("SA2",.F.)
		SA2->A2_L_GRUPO := ""
		If FieldPos("ZL5_MAIOR") > 0
			SA2->A2_L_MAIOR := "N"
		EndIf
		SA2->(MsUnLock())


	Next nX

EndIf

Return .t.
