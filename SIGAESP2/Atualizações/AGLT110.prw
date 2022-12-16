
#INCLUDE 'FWMVCDEF.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'TOTVS.CH'

#DEFINE _ENTER CHR(13)+CHR(10)
/*/
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  � AGLT110  � Autor � Guilherme Fran�a      � Data da Criacao  � 11/08/2015  									���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Fun��o em MVC para montar a tela de Convenios entre produtores, para gerar creditos e debitos  ���
���          � no fechamento do leite.                                                                    					���
���������������������������������������������������������������������������������������������������������������������������͹��
���Uso       � 												                                                        		���ZLK
���������������������������������������������������������������������������������������������������������������������������͹��
���Parametros� Nenhum						   							                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Retorno   � Nenhum						  							                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Usuario   � Microsiga                                                                                					���
���������������������������������������������������������������������������������������������������������������������������͹��
���Setor     � Gest�o do Leite                                                                       						���
���������������������������������������������������������������������������������������������������������������������������͹��
���            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Autor     � Data     � Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor    	���
���������������������������������������������������������������������������������������������������������������������������ĺ��
���          �00/00/0000�                               				   �00-000000 -                       � TI	    	���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���          �          �                    							   �                                  � 			���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���������������������������������������������������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������������������������������������������������
*/

User Function AGLT110()


	Local oBrowse
	Local _cFiltro := U_FilSetor("ZLK_SETOR")
	Private _lPrcForn := .F.
	Private _lFiltra := .f.
	Private _aUser := PswRet() //Carrega dados do usuario logado
	Private _lUserRH	:= .F.
	Private OpcaoCred	:= 0
	Private	_nDiaVir	:= 32 //Val(Alltrim(POSICIONE("ZZC",1,XFILIAL("ZZC")+"000007"+"002","ZZC_CONTEU"))) //Dia da virada do conta-corrente
	Private nMesLcto  := Month(dDataBase)
	Private nMesVcto  := IIf(nMesLcto<12,nMesLcto+1,1) // mes de vencimento do debito
	Private nAno	  := IIF(nMesLcto<12,Year(dDataBase),Year(dDataBase)+1) //ano de vencimento do debito
	Private oDlgPrinc
	Private cCadastro := " Convenios "
	Private _lParcela := .f. //Campo para desabilitar valida��es e op��o de parcelamento
	Private _lGeraFin := SuperGetMV("LT_CONVFIN",,.T.) //Indica se o conv�nio j� deve gerar os t�tulos no financeiro, ou se isso ocorrer� no Acerto do Leite, apenas com valor que o produtor pode pagar no m�s, controlando pelo campo ZLL_VLRPAG.
	//Variaveis publicas utilizadas em filtros de consultas padr�es
	Public _cFiltroF3ZLL := " .t. "
	Public _FilSA2_L6	:= " .T. " //Variavel publica chamada na consulta padrao SA2_L6, usada para filtrar o tipo dos fornecedores a aparecer na consulta de retiro.

	oBrowse := FWmBrowse():New()
	oBrowse:SetAlias( 'ZLK' )
	oBrowse:SetDescription( 'Convenios' )

	//Adiciona legendas browse superior
	oBrowse:AddLegend( "ZLK_STATUS == 'A'", "GREEN"	, "Em Aberto"	)
	oBrowse:AddLegend( "ZLK_STATUS == 'P'", "BLUE"	, "Pago"	)
	oBrowse:AddLegend( "ZLK_STATUS == 'S'", "YELLOW", "Pago parcial"	)

	oBrowse:SetFilterDefault( _cFiltro )

	oBrowse:Activate()

Return NIL

//-------------------------------------------------------------------
Static Function MenuDef()
	Local aRotina := {}
	Local _lGerFin := SuperGetMV("LT_CONVFIN",,.T.) //Indica se o conv�nio j� deve gerar os t�tulos no financeiro, ou se isso ocorrer� no Acerto do Leite, apenas com valor que o produtor pode pagar no m�s, controlando pelo campo ZLL_VLRPAG.

	ADD OPTION aRotina Title 'Pesquisar'  	Action 'PesqBrw'         	OPERATION 1 ACCESS 0
	ADD OPTION aRotina Title 'Visualizar'	Action 'VIEWDEF.AGLT110' 	OPERATION 2 ACCESS 0
	ADD OPTION aRotina Title 'Incluir'   	Action 'VIEWDEF.AGLT110'	OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE 'Alterar'    	ACTION 'VIEWDEF.AGLT110' 	OPERATION 4 ACCESS 0
	ADD OPTION aRotina Title 'Relat�rio'   	Action 'U_RGLT007'			OPERATION 6 ACCESS 0
	ADD OPTION aRotina Title 'Recibo'   	Action 'U_RGLT009'			OPERATION 6 ACCESS 0
	ADD OPTION aRotina TITLE 'Excluir'    	ACTION 'VIEWDEF.AGLT110' 	OPERATION 5 ACCESS 0
	If !_lGerFin
		ADD OPTION aRotina TITLE 'Gera Titulo Pagar'    	ACTION 'U_GLT110TIT("I")' 	OPERATION 4 ACCESS 0
		ADD OPTION aRotina TITLE 'Estorna Titulo Pagar'    	ACTION 'U_GLT110TIT("E")' 	OPERATION 4 ACCESS 0
	EndIf

Return aRotina

/*/
	�����������������������������������������������������������������������������
	�����������������������������������������������������������������������������
	�������������������������������������������������������������������������ͻ��
	���Programa  � ModelDef � Autor � Guilherme Fran�a   � Data � 11/08/2015  ���
	�������������������������������������������������������������������������͹��
	���Descri��o � Constru��o da View Def                                     ���
	���          �                                                            ���
	�������������������������������������������������������������������������͹��
	���Uso       �                                                            ���
	�������������������������������������������������������������������������ͼ��
	�����������������������������������������������������������������������������
	�����������������������������������������������������������������������������
/*/
Static Function ModelDef()
	// Cria a estrutura a ser usada no Modelo de Dados
	Local oStruZLK	:= FWFormStruct( 1, 'ZLK', /*bAvalCampo*/, /*lViewUsado*/ )
	Local oStruZLL	:= FWFormStruct( 1, 'ZLL', /*bAvalCampo*/, /*lViewUsado*/ )
	Local aTrigger := {}
	Local oModel

	Local _i       := 0

	Local _lTudoOK := .t.

	// Cria o objeto do Modelo de Dados
	oModel := 	MPFormModel():New( 'AGLT110M', /*bPreValidacao*/,{ |oModel| _lTudoOK:=GravaTit(oModel) } /*{ |oModel| TudoOk(oModel)} */,/*bPosValidacao*/,/*bCommit*/, /*bCancel*/ )

	//Ajusta propriedades dos campos
	SetPropM(oStruZLK, oStruZLL)


	// criacao de triggers para o cadastro
	aAdd(aTrigger, FwStruTrigger('ZLK_EVENTO'   ,'ZLK_OBSERV'   ,'SubStr(ZL8->ZL8_DESCRI,1,TamSx3("ZLK_OBSERV")[1])',.T.,'ZL8',1,'xFilial("ZL8")+M->ZLK_EVENTO'))
	aAdd(aTrigger, FwStruTrigger('ZLK_CONVEN'   ,'ZLK_NOME'   ,'SUBSTR(SA2->A2_NOME,1,25)',.T.,'SA2',1,'xFilial("SA2")+M->ZLK_CONVEN'))
	aAdd(aTrigger, FwStruTrigger('ZLK_EVENTO'   ,'ZLK_SETOR'  ,'SubStr(ZLU->ZLU_SETOR,1,6)',.T.,'ZLU',1,'xFilial("ZLU")+PADR(cUserName,25)'))

	For _i := 1 to Len(aTrigger)
		oStruZLK:AddTrigger(aTrigger[_i][1] ,aTrigger[_i][2] ,aTrigger[_i][3] ,aTrigger[_i][4] )
	Next _i

	// Adiciona ao modelo uma estrutura de formul�rio de edi��o por campo
	oModel:AddFields( 'ZLKMASTER', /*cOwner*/, oStruZLK )

	// Adiciona ao modelo uma estrutura de formul�rio de edi��o por grid
	oModel:AddGrid( 'ZLLDETAIL', 'ZLKMASTER', oStruZLL, /*bLinePre*/,{ || ValidaLin() } /*bLinePost*/, /*bPreVal*/, /*bPosVal*/, /*BLoad*/ )

	// Adiciona a descricao do Componente do Modelo de Dados
	oModel:SetDescription('Convenios')
	oModel:GetModel( 'ZLKMASTER' ):SetDescription( 'Dados Convenio' )
	oModel:GetModel( 'ZLLDETAIL' ):SetDescription( 'Debitos' )

	// Faz relaciomaneto entre os compomentes do model
	oModel:SetRelation( 'ZLLDETAIL', { { 'ZLL_FILIAL', 'xFilial( "ZLK" )' }, { 'ZLL_COD', 'ZLK_COD' },;
		{ 'ZLL_DATA', 'ZLK_DATA  ' }, { 'ZLL_EVENTO', 'ZLK_EVENTO' },;
		{ 'ZLL_CONVEN', 'ZLK_CONVEN' }, { 'ZLL_LJCONV', 'ZLK_LJCONV' },;
		 { 'ZLL_VENCTO', 'ZLK_VENCTO' }, { 'ZLL_VENCON', 'ZLK_VENCON' }, ;
		{ 'ZLL_OBSERV', 'ZLK_OBSERV' },{ 'ZLL_SETOR', 'ZLK_SETOR ' } }, ZLL->( IndexKey( 3 ) ) )

	// Liga o controle de nao repeticao de linha
	oModel:GetModel( 'ZLLDETAIL' ):SetUniqueLine( { 'ZLL_RETIRO','ZLL_RETILJ' } ) //( { 'ZLL_SEQ','ZLL_RETIRO','ZLL_RETILJ' } )


	// Indica que � opcional ter dados informados na Grid
	oModel:GetModel( 'ZLLDETAIL' ):SetOptional(.F.)

	oModel:SetPrimaryKey({'ZLK_FILIAL','ZLK_COD','ZLK_CONVEN'})

Return oModel

/*/
	�����������������������������������������������������������������������������
	�����������������������������������������������������������������������������
	�������������������������������������������������������������������������ͻ��
	���Programa  � ViewDef  � Autor � Vin�cius Fernandes � Data � 11/06/2015  ���
	�������������������������������������������������������������������������͹��
	���Descri��o � Constru��o da View Def                                     ���
	���          �                                                            ���
	�������������������������������������������������������������������������͹��
	���Uso       �                                                            ���
	�������������������������������������������������������������������������ͼ��
	�����������������������������������������������������������������������������
	�����������������������������������������������������������������������������
/*/

Static Function ViewDef()
	// Cria um objeto de Modelo de Dados baseado no ModelDef do fonte informado
	Local oStruZLK 	:= FWFormStruct( 2, 'ZLK' )
	Local oStruZLL	:= FWFormStruct( 2, 'ZLL' )
	Local _cCpoGrid := "ZLL_SEQ;ZLL_RETIRO;ZLL_RETILJ;ZLL_VALOR"
	// Cria a estrutura a ser usada na View
	Local oModel   	:= FWLoadModel( 'AGLT110' )
	Local oView

	//Remove campos desnecess�rios da view
	RemoveFld(oStruZLK, oStruZLL)


	//Ajusta propriedades dos campos
	SetPropV(oStruZLK)

	// Cria o objeto de View
	oView := FWFormView():New()

	// Define qual o Modelo de dados ser� utilizado
	oView:SetModel( oModel )

	//Adiciona no nosso View um controle do tipo FormFields(antiga enchoice)
	oView:AddField( 'VIEW_ZLK', oStruZLK, 'ZLKMASTER' )

	//Adiciona no nosso View um controle do tipo FormGrid(antiga newgetdados)
	oView:AddGrid(  'VIEW_ZLL', oStruZLL, 'ZLLDETAIL' )

	If _lGeraFin
		oView:SetViewProperty("VIEW_ZLL", "GRIDDOUBLECLICK", {{|oFormulario,cFieldName,nLineGrid,nLineModel| Iif(Alltrim(cFieldName) $ _cCpoGrid ,ConsTitulo(),.t.)}})
	EndIf

	// Criar um "box" horizontal para receber algum elemento da view
	oView:CreateHorizontalBox( 'SUPERIOR'	, 40 )
	oView:CreateHorizontalBox( 'INFERIOR' 	, 60 )

	// Relaciona o ID da View com o "box" para exibicao
	oView:SetOwnerView( 'VIEW_ZLK'	, 'SUPERIOR' )
	oView:SetOwnerView( 'VIEW_ZLL'	, 'INFERIOR' )

	// Define campos que terao Auto Incremento
	oView:AddIncrementField( 'VIEW_ZLL', 'ZLL_SEQ' )

	// Criar novo botao na barra de botoes
	oView:AddUserButton( 'Importar Conv�nios', 'CLIPS', { |oView| IMPORTCSV() } )

Return oView

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �SetPropM   �Autor  �                           �  05/27/12   ���
����������������
���������������������������������������������������������͹��
���Desc.     �Define propriedades no MODEL                              ���
�������������������������������������������������������������������������͹��
���Uso       � Aula de MVC                                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function SetPropM(oStruZLK, oStruZLL)

	Local _aCodFor	:= {}
	Local _cEvento	:= ""
	Local _cConven	:= ""
	Local _cLJConv	:= ""
	Local _cNome	:= ""
	Local _cObs	:= ""
	Local _nTxCon	:= 0
	Local dVctoCv	:= ""
	Local _nDiaVcto  := SuperGetMV("LT_VENCONV",,20) //Parametro que indica o dia de vencimento da NDF a ser debitada do produtor
	Local _nDiaVctof  := SuperGetMV("LT_VENFUNC",,5)
	Local _nDiaFor	:= 1
	Local dVctoPr := ""

	If _lUserRH // Se for usuario do RH, o vencimento utilizado � do funcionario
		dVctoPr := CtoD(StrZero(_nDiaVctof,2) + "/" + StrZero(nMesVcto,2) + "/" + SubSTR(STR(nAno,4),3,2))
	Else
		dVctoPr := CtoD(StrZero(_nDiaVcto,2) + "/" + StrZero(nMesVcto,2) + "/" + SubSTR(STR(nAno,4),3,2))
	EndIf
	//Se o dia for igual ou maior que o dia da virada do conta corrente, soma 1 m�s no vencimento do cooperado e do conveniado
	If Day(dDataBase) >= _nDiaVir
		dVctoPr := MonthSum(dVctoPr,1)
		dVctoCv := IIf(!Empty(dVctoCv),MonthSum(dVctoCv,1),dVctoCv)
	EndIf

	oStruZLK:SetProperty( 'ZLK_COD'		, MODEL_FIELD_INIT, {|| AGLT110N()} )
	oStruZLK:SetProperty( 'ZLK_VENCTO'	, MODEL_FIELD_INIT,{|| dVctoPr} )
	oStruZLK:SetProperty( 'ZLK_VENCON'	, MODEL_FIELD_INIT,{|| dVctoPr} )

	oStruZLK:SetProperty( 'ZLK_VENCTO'	, MODEL_FIELD_VALID,{|| M->ZLK_VENCTO > dDataBase } )
	oStruZLK:SetProperty( 'ZLK_VENCON'	, MODEL_FIELD_VALID,{|| M->ZLK_VENCON >= dDataBase } )

	oStruZLK:SetProperty( 'ZLK_EVENTO'	, MODEL_FIELD_VALID,{|| vldEvento()} )
	oStruZLK:SetProperty( 'ZLK_CONVEN'	, MODEL_FIELD_VALID,{|| ValidForn(1)} )
	oStruZLK:SetProperty( 'ZLK_LJCONV'	, MODEL_FIELD_VALID,{|| ValidForn(1)} )

	oStruZLL:SetProperty( 'ZLL_VALOR'	, MODEL_FIELD_VALID,{|| AtuTotal()} )
	oStruZLL:SetProperty( 'ZLL_VALOR'	, MODEL_FIELD_VALID,{|| Positivo()} )
	oStruZLL:SetProperty( 'ZLL_RETILJ'	, MODEL_FIELD_VALID,{|| ValidForn(2)} )

	If _lFiltra
		_aCodFor := strtokarr(FiltraFornec(),"/")
		_cEvento := Posicione("SA2",1,xFilial("SA2")+_aCodFor[1],"A2_L_EVENT")
		_nTxCon := Posicione("SA2",1,xFilial("SA2")+_aCodFor[1],"A2_L_TXCON")
		If Len(_aCodFor) == 1
			_cConven := _aCodFor[1]
			_cLJConv := Posicione("SA2",1,xFilial("SA2")+_aCodFor[1],"A2_LOJA")
			_cNome := Posicione("SA2",1,xFilial("SA2")+_aCodFor[1],"A2_NOME")
		Else
			_cFiltroF3ZLL := " SA2->A2_COD $ '"+FiltraFornec()+"'"
		EndIf


		dbSelectArea('ZL8')
		ZL8->(MsSeek(xFILIAL("ZL8")+_cEvento))
		//Verifica data limite que o fornecedor poder� incluir convenios
		If Day(dDataBase) > ZL8->ZL8_LIMITE
			xMagHelpFis("Data Inv�lida","Data de inclus�o acima do limite permitido para este evento!",;
				"Os lan�amentos deste conv�nio s�o permitidos somente at� o dia "+cValToChar(ZL8->ZL8_LIMITE)+"!")
			Return
		EndIf

		If nMesLcto == 2 .and. ZL8->ZL8_PGTFOR >= 29
			_nDiaFor := 28
		Else
			_nDiaFor := ZL8->ZL8_PGTFOR
		EndIf

		If ZL8->ZL8_PGMES == 'S' //Indica se o convenio � pago dentro do mes de lan�amento para o fornecedor
			dVctoCv := CtoD(StrZero(_nDiaFor,2) + "/" + StrZero(nMesLcto,2) + "/" + SubSTR(STR(Year(dData),4),3,2))
		Else
			dVctoCv := CtoD(StrZero(_nDiaFor,2) + "/" + StrZero(nMesVcto,2) + "/" + SubSTR(STR(nAno,4),3,2))
		EndIf
		_cObs := "CONV�NIO "+Alltrim(ZL8->ZL8_NREDUZ)+(Space(TamSx3("E2_HIST")[1] - 9 - len(Alltrim(ZL8->ZL8_NREDUZ))))
		//Se o dia for igual ou maior que o dia da virada do conta corrente, soma 1 m�s no vencimento do cooperado e do conveniado
		If Day(dDataBase) >= _nDiaVir
			dVctoPr := MonthSum(dVctoPr,1)
			dVctoCv := IIf(!Empty(dVctoCv),MonthSum(dVctoCv,1),dVctoCv)
		EndIf

		oStruZLK:SetProperty( 'ZLK_EVENTO'	, MODEL_FIELD_INIT,{|| _cEvento} )
		oStruZLK:SetProperty( 'ZLK_CONVEN'	, MODEL_FIELD_INIT,{|| _cConven} )
		oStruZLK:SetProperty( 'ZLK_LJCONV'	, MODEL_FIELD_INIT,{|| _cLJConv} )
		oStruZLK:SetProperty( 'ZLK_NOME'	, MODEL_FIELD_INIT,{|| _cNome} )
		oStruZLK:SetProperty( 'ZLK_PTXADM'	, MODEL_FIELD_INIT,{|| _nTxCon} )
		oStruZLK:SetProperty( 'ZLK_VENCON'	, MODEL_FIELD_INIT,{|| dVctoCv} )
		oStruZLK:SetProperty( 'ZLK_OBSERV'	, MODEL_FIELD_INIT,{|| _cObs} )
	EndIf

	oStruZLK:SetProperty( 'ZLK_EVENTO'	, MODEL_FIELD_WHEN,{|| Empty(_cEvento) .and. INCLUI} )
	oStruZLK:SetProperty( 'ZLK_CONVEN'	, MODEL_FIELD_WHEN,{|| Empty(_cConven) .and. INCLUI} )
	oStruZLK:SetProperty( 'ZLK_LJCONV'	, MODEL_FIELD_WHEN,{|| Empty(_cLJConv) .and. INCLUI} )
	oStruZLK:SetProperty( 'ZLK_TXADM'	, MODEL_FIELD_WHEN,{|| .F.} )
	oStruZLK:SetProperty( 'ZLK_VENCTO'	, MODEL_FIELD_WHEN,{|| !_lFiltra } )
	oStruZLK:SetProperty( 'ZLK_VENCON'	, MODEL_FIELD_WHEN,{|| !_lFiltra } )
	oStruZLK:SetProperty( 'ZLK_STATUS'	, MODEL_FIELD_WHEN,{|| .F. } )


Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �SetPropV   �Autor  �                           �  05/27/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Define propriedades na VIEW                                 ���
�������������������������������������������������������������������������͹��
���Uso       � Aula de MVC                                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function SetPropV(oStruZLK)

	oStruZLK:SetProperty( 'ZLK_CONVEN'   , MVC_VIEW_LOOKUP    , 'SA2')

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RemoveFld  �Autor  �Microsiga           � Data �  07/20/15   ���
�������������������������������������������������������������������������͹��
���Desc.     � Remove campos da view.                                     ���
���          �                                                           ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function RemoveFld(oStruZLK, oStruZLL)

	Local _aRemZLK := {}
	Local _aRemZLL := {"ZLL_COD","ZLL_CONVEN","ZLL_LJCONV","ZLL_DATA","ZLL_OBSERV","ZLL_NATURE",;
		"ZLL_SETOR","ZLL_EVENTO","ZLL_ACRESC","ZLL_TXADM","ZLL_STATUS"}
	Local _iRem    := 0

	// Remove campos que n�o dever�o aparecer

	For _iRem := 1 to Len(_aRemZLK)
		oStruZLK:RemoveField( _aRemZLK[_iRem] )
	Next _iRem

	For _iRem := 1 to Len(_aRemZLL)
		oStruZLL:RemoveField( _aRemZLL[_iRem] )
	Next _iRem

	If !_lParcela
		_aRemZLL := {"ZLL_CARENC","ZLL_NCAREN","ZLL_PARCEL","ZLL_TXPARC","ZLL_VLRPAR","ZLL_VLRTOT"}
		For _iRem := 1 to Len(_aRemZLL)
			oStruZLL:RemoveField( _aRemZLL[_iRem] )
		Next _iRem
	EndIf

	If _lGeraFin
		oStruZLL:RemoveField("ZLL_VLRPAG")
	EndIf

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

	Local oModel    := FWModelActive()
	Local oStruZLK  := oModel:GetModel( 'ZLKMASTER' )
	Local oStruZLL  := oModel:GetModel( 'ZLLDETAIL' )
	Local _cEvento  := oStruZLK:GetValue("ZLK_EVENTO")
	Local _cTipoTit := PADR(Alltrim(GetMv("LT_CONVTIP")),3)
	Local _cCodZLK  := oStruZLK:GetValue("ZLK_COD")
	Local _cItem    := oStruZLL:GetValue("ZLL_SEQ")
	Local _cParcela := StrZero(1,TamSX3("E2_PARCELA")[1])
	Local _cCodSA1  := oStruZLL:GetValue("ZLL_RETIRO")
	Local _cLoja    := oStruZLL:GetValue("ZLL_RETILJ")

	dbSelectArea( 'ZL8' )
	ZL8->(MsSeek(xFILIAL("ZL8")+_cEvento))
	_cNatureza      := ZL8->ZL8_NATFRT
	_cPrefixo       := ZL8->ZL8_PREFIX

	DbSelectArea("SE1")
	DbSetOrder(2) //E1_FILIAL, E1_CLIENTE, E1_LOJA, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, R_E_C_N_O_, D_E_L_E_T_
	If SE1->(MsSeek(xFilial("SE1")+_cCodSA1+_cLoja+_cPrefixo+_cCodZLK+_cItem+_cParcela+_cTipoTit))
		Fc040Con()
	Else
		Help( ,,1,"TITULO","T�tulo n�o gerado no financeiro!", 1, 0 )
	EndIf

Return()


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �vldEvento �Autor  �Abrahao             � Data �  09/10/09   ���
�������������������������������������������������������������������������͹��
���Desc.     � Valida se evento e financeiro                              ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP10                                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function vldEvento()

	Local oModel   := FWModelActive()
	Local oStruZLK := oModel:GetModel( 'ZLKMASTER' )
	Local _cEvento := oStruZLK:GetValue("ZLK_EVENTO")
	Local _lRet    := .t.

	dbSelectArea("ZL8")
	dbSetOrder(1)
	If dbSeek(xFILIAL("ZL8")+_cEvento)
		If ZL8->ZL8_TPEVEN != "F" .Or. ZL8->ZL8_PREFIX == "" .Or. ZL8->ZL8_DEBCRE != "D"
			xMagHelpFis("Evento Incorreto","O Evento precisa ser Financeiro e de D�bito com Prefixo para ser utilizado!","Selecione um evento tipo Financeiro tipo D�bito com Prefixo!")
			_lRet := .f.
		EndIf
		If ZL8->ZL8_CONVEN != "S"
			xMagHelpFis("Evento Incorreto","O Evento precisa estar com campo Usado em convenio = Sim!","Selecione um evento de convenio ou corrija o cadastro de convenio!")
			_lRet := .f.
		EndIf
	Else
		Help( ,,1,"EVENTO","C�digo inexistente no cadastro de eventos!", 1, 0 )
		_lRet := .f.
	EndIf

Return _lRet

/*/
	�����������������������������������������������������������������������������
	�����������������������������������������������������������������������������
	�������������������������������������������������������������������������ͻ��
	���Programa  � ValidForn  �Autor  � Guilherme Fran�a   � Data �  00/00/0  ���
	�������������������������������������������������������������������������͹��
	���Descricao �  Rotina para validar o codigo do Fornecedor.               ���
	���          �                                                            ���
	�������������������������������������������������������������������������͹��
	���Uso       �                                                            ���
	�������������������������������������������������������������������������ͼ��
	�����������������������������������������������������������������������������
	�����������������������������������������������������������������������������
/*/
Static Function ValidForn(xnOP)

	Local oModel   := FWModelActive()
	Local oStruZLK := oModel:GetModel( 'ZLKMASTER' )
	Local oStruZLL := oModel:GetModel( 'ZLLDETAIL' )
	Local _cForn   := oStruZLK:GetValue("ZLK_CONVEN")
	Local _cLoja   := oStruZLK:GetValue("ZLK_LJCONV")
	Local _cEvento := oStruZLK:GetValue("ZLK_EVENTO")
	Local _cxTipo  := "F"
	Local _cObs    := ""

	If xnOP == 1
		// O evento 100010 � utilizado para transferir debitos de um cooperado para outro, portanto apresenta o tipo C na consulta padrao.

		If _cEvento == '100101'
			_cxTipo := "P"
		Else
			_cxTipo := "F"
		EndIf

		DbSelectArea("ZL8")
		DbSetOrder(1)
		MsSeek(xFilial("ZL8")+_cEvento)

		If ZL8->(FieldPos("ZL8_PRCFOR")) != 0
			_lPrcForn := IIF(ZL8->ZL8_PRCFOR=="S",.T.,.F.)    // Indica se o pagamento do fornecedor ser� parcelado
		EndIf

		dbSelectArea("SA2")
		dbSetOrder(1)
		If MsSeek(xFILIAL("SA2")+_cForn+ALLTRIM(_cLoja))
			If SA2->A2_L_TPFOR == _cxTipo .or. Empty(SA2->A2_L_TPFOR)
				If SA2->A2_MSBLQL <> '1'
					If _lFiltra
						If !&_cFiltroF3ZLL
							xMagHelpFis("Atencao","Convenio n�o encontrado ou inv�lido!","Informe um conv�nio existente e v�lido! Pressione F3 e selecione o conv�nio.")
							Return .F.
						Endif
					EndIf
					oStruZLK:SetValue("ZLK_NOME",SubStr(SA2->A2_NOME,1,40)) //cNome    := SA2->A2_NOME
					oStruZLK:SetValue("ZLK_LJCONV",SA2->A2_LOJA) //cLjConv  := SA2->A2_LOJA
					_cObs := Alltrim(ZL8->ZL8_DESCRI)+" "+Alltrim(SA2->A2_NREDUZ)
					oStruZLK:SetValue("ZLK_OBSERV",SubStr(_cObs,1,TamSx3("ZLK_OBSERV")[1]))
					If SA2->(FieldPos("A2_L_TXCON")) != 0
						oStruZLK:SetValue("ZLK_PTXADM",SA2->A2_L_TXCON) //nPAdm 	 := SA2->A2_L_TXCON
					EndIf
				Else
					xMagHelpFis("Atencao","Este Convenio/Fornecedor esta bloqueado!","InForme um Convenio/Fornecedor n�o bloqueado ou altere o Status de bloqueio.")
					Return .F.
				EndIf
			Else
				xMagHelpFis("Atencao","Produtores ou Fretistas n�o podem ser lojas conveniadas!","InForme um Convenio/Fornecedor valido.")
				Return .F.
			EndIf
		Else
			xMagHelpFis("Atencao","Convenio n�o encontrado ou inv�lido!","Informe um conv�nio existente e v�lido! Pressione F3 e selecione o conv�nio.")
			Return .F.
		EndIf
	Else
		dbSelectArea("SA1")
		dbSetOrder(1)
		If SA1->(MsSeek(xFILIAL("SA1")+oStruZLL:GetValue("ZLL_RETIRO")+oStruZLL:GetValue("ZLL_RETILJ")))
			If SA1->A1_MSBLQL == "1"
				Help( ,, 'BLOQUEADO',,"O cadastro selecionado est� bloqueado para uso!", 1, 0 )
				Return .f.
			EndIf
		Else
			Help( ,, 'INEXISTENTE',,"O c�digo+loja informado n�o existe!", 1, 0 )
			Return .f.
		EndIf
	EndIf
Return .T.

/*
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  � getNewNum� Autor � Abrahao P. Santos     � Data da Criacao  � 10/02/2009                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Retorna novo numero sequencial do ZLL_COD       		    	                           						���
���			 �														                                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Parametros� Nenhum                                              		                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Retorno   � Codigo do Convenio          	                               													���
���������������������������������������������������������������������������������������������������������������������������͹��
���Usuario   � TOTVS - Microsiga											                             					���
���������������������������������������������������������������������������������������������������������������������������͹��
���Setor     � Gestao do Leite                                                                          					���
���������������������������������������������������������������������������������������������������������������������������͹��
���            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Autor     � Data     � Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor        ���
���������������������������������������������������������������������������������������������������������������������������ĺ��
���          �          �                   							   �                                  �  	        ���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���          �          �                    							   �                                  � 			���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���������������������������������������������������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
*/
Static Function AGLT110N()

	Local _aArea := GetArea()
	Local cRet  := ""

	cQuery:=" SELECT MAX(ZLL_COD) AS ULTIMO "
	cQuery+=" FROM "+RetSqlName("ZLL")+" ZLL "
	cQuery+=" WHERE D_E_L_E_T_ = ' ' "
	cQuery+=" AND ZLL_FILIAL = '"+xFILIAL("ZLL")+"' "

	If Select("TRB") > 0
		TRB->(dbCloseArea())
	EndIf

	DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), "TRB", .F., .T.)


	If !TRB->(Eof())
		cRet := StrZero(Val(TRB->ULTIMO)+1,6)
		While !MayIUseCode("ZLL" + xFilial("ZLL") + cRet)  //verifica se esta na memoria, sendo usado
			cRet := Soma1(cRet)					           // busca o proximo numero disponivel
		EndDo
	EndIf
	TRB->(dbCloseArea())

	RestArea(_aArea)
Return cRet


/*
��������������������������������������������������������������������������������
��������������������������������������������������������������������������������
����������������������������������������������������������������������������ͻ��
���Programa  � FiltraFornec� Autor � GUILHERME FRAN�A   � Data �  00/00/00   ���
����������������������������������������������������������������������������͹��
���Desc.     � Realiza filtro na tela de lan�amento dos convenios para que   ���
���          � os fornecedores so enxerguem seus lan�amentos.                ���
���          � O campo A2_L_USER deve contar o codigo de usu�rio de sistema. ���
����������������������������������������������������������������������������͹��
���Uso       � Programa Principal.                                           ���
����������������������������������������������������������������������������ͼ��
��������������������������������������������������������������������������������
��������������������������������������������������������������������������������
*/
Static Function FiltraFornec()

	Local _cFiltro := "% AND A2_L_USER = '"+__CUSERID+"' %"
	Local _cRet := ""

	BeginSql alias "FORNEC"
		SELECT A2_COD
		FROM %Table:SA2% SA2
		WHERE SA2.%notDel%
		%exp:_cFiltro%
	EndSql

	DbSelectArea("FORNEC")
	FORNEC->(DbGoTop())

	While !FORNEC->(Eof())
		_cRet += FORNEC->A2_COD+"/"  //Incrementa os c�digos de fornecedor que est�o amarrados ao usu�rio logado.
		FORNEC->(Dbskip())
	EndDo

	FORNEC->(DbCloseArea())

	If Len(_cRet) < 3 // Verifica se foram adicionados codigos de fornecedor ao retorno.
		_cRet := "XXXXXX"
	EndIf

Return _cRet


/*/
	�����������������������������������������������������������������������������
	�����������������������������������������������������������������������������
	�������������������������������������������������������������������������ͻ��
	���Programa  � ValidaLin� Autor � Guilherme Fran�a   � Data � 11/08/2015  ���
	�������������������������������������������������������������������������͹��
	���Descri��o � Fun��o de valida��o de exclus�o da linha na inclus�o e     ���
	���          � altera��o.                                                 ���
	�������������������������������������������������������������������������͹��
	���Uso       �                                                            ���
	�������������������������������������������������������������������������ͼ��
	�����������������������������������������������������������������������������
	�����������������������������������������������������������������������������
/*/
Static Function ValidaLin()

	Local lRet        := .t.
	Local oModel      := FWModelActive()
	Local oStruZLK    := oModel:GetModel( 'ZLKMASTER' )
	Local oStruZLL    := oModel:GetModel( 'ZLLDETAIL' )
	Local nOperation  := oModel:GetOperation()
	Local _nLiAtu     := oStruZLL:nLine
	Local _cEvento    := oStruZLK:GetValue("ZLK_EVENTO")
	Local _lPrcForn   := .t.
	Local _aParcela   := {}
	Local _nValTot    := 0
	Local nL          := 0


	If nOperation == 3 .or. nOperation == 4
		dbSelectArea('ZL8')
		ZL8->(dbSeek(xFILIAL("ZL8")+_cEvento))
		If ZL8->(FieldPos("ZL8_PRCFOR")) != 0
			_lPrcForn := IIF(ZL8->ZL8_PRCFOR=="S",.T.,.F.)    // Indica se o pagamento do fornecedor ser� parcelado
		EndIf

		nL := _nLiAtu
		oStruZLL:GoLine(nL)

		If oStruZLL:GetValue("ZLL_STATUS")== "P"
			Help( ,, 'TITPAGO',," Convenio j� pago, altera��o n�o permitida!", 1, 0 )
			Return .f.
		EndIf

		IF !oStruZLL:IsDeleted(nL)

			If _lParcela .and. (oStruZLL:GetValue("ZLL_CARENC")== "N")  .AND. !(oStruZLL:GetValue("ZLL_TXPARC") > 0)
				xMagHelpFis("Valida��o","Pagamento sem car�ncia de juros dever� ter a taxa informada!","InForme taxa financeira para c�lculo dos juros!")
				lRet := .F.
			EndIf

			If oStruZLL:GetValue("ZLL_VALOR") == 0
				xMagHelpFis("Mensagem","Convenio zerado.","Informe o valor do convenio.")
				lRet := .F.
			EndIf

			oStruZLL:LoadValue("ZLL_CONVEN",oStruZLK:GetValue("ZLK_CONVEN"))
			oStruZLL:LoadValue("ZLL_LJCONV",oStruZLK:GetValue("ZLK_LJCONV"))
			oStruZLL:LoadValue("ZLL_DATA"  ,oStruZLK:GetValue("ZLK_DATA"))
			oStruZLL:LoadValue("ZLL_SETOR", oStruZLK:GetValue("ZLK_SETOR"))
			oStruZLL:LoadValue("ZLL_EVENTO",oStruZLK:GetValue("ZLK_EVENTO"))
			oStruZLL:LoadValue("ZLL_VENCTO",oStruZLK:GetValue("ZLK_VENCTO"))
			oStruZLL:LoadValue("ZLL_VENCON",oStruZLK:GetValue("ZLK_VENCON"))
			oStruZLL:LoadValue("ZLL_TXADM", oStruZLK:GetValue("ZLK_TXADM"))
			oStruZLL:LoadValue("ZLL_STATUS","A")

			// Atualiza campos ZLL_TXPARC, ZLL_VLRPAR, ZLL_VLRTOT
			If _lParcela
				_aParcela := CalculaJuros(nL)
				If Len(_aParcela) == 3 //.and. oStruZLL:GetValue("ZLL_TXPARC") > 0
					oStruZLL:LoadValue("ZLL_TXPARC",_aParcela[1])
					oStruZLL:SetValue("ZLL_VLRPAR",_aParcela[2])
					_nAux := IIF(_aParcela[3] > oStruZLL:GetValue("ZLL_VALOR"),_aParcela[3],oStruZLL:GetValue("ZLL_VALOR"))
					oStruZLL:SetValue("ZLL_VLRTOT",_nAux)
				EndIf
			EndIf

			If _lParcela
				dbSelectArea("SA2")
				dbSetOrder(1)
				SA2->(MsSeek(xFILIAL("SA2")+oStruZLL:GetValue("ZLL_RETIRO")+oStruZLL:GetValue("ZLL_RETILJ")))

				If lRet .And. SA2->A2_MSBLQL == "1"//Bloqueado
					xMagHelpFis("Mensagem","Cadastro "+SA2->A2_COD+"-"+SA2->A2_LOJA+" "+ALLTRIM(SA2->A2_NOME)+" bloqueado.","Desbloqueie o cadastro ou utilize outro.")
					lRet := .F.
				EndIf
				If ZL8->(FieldPos("ZL8_TIPOS")) != 0
					_cTipos := Alltrim(ZL8->ZL8_TIPOS)
				EndIf
				If lRet .And. _lUserRH // Se o usuario logado for do RH, somente podera lan�ar debitos para funcion�rios.
					_cTipos := "E"
				EndIf
				If lRet .And.  !(SA2->A2_L_TPFOR $ _cTipos)
					xMagHelpFis("Mensagem","N�o � permitida a inclusao de convenios para cadastros do tipo "+SA2->A2_L_TPFOR+" utilizando este c�digo de evento!",;
						"Selecione outro cadastro ou contato o suporte.")
					lRet := .F.
				EndIf
			EndIf
			_nValTot += oStruZLL:GetValue("ZLL_VALOR")
		EndIf
	EndIf
	_nValTot := 0
	For nL := 1 TO oStruZLL:Length()
		oStruZLL:GoLine(nL)
		IF !oStruZLL:IsDeleted(nL)
			_nValTot += oStruZLL:GetValue("ZLL_VALOR")
		EndIf
	Next nL

	//Atualiza campos do cabe�alho
	oStruZLK:LoadValue("ZLK_VLRTOT",_nValTot)

	_nTxAdm:=_nValTot*(oStruZLK:GetValue("ZLK_PTXADM")/100)
	oStruZLK:LoadValue("ZLK_TXADM",_nTxAdm)


Return lRet

/*
��������������������������������������������������������������������������������
��������������������������������������������������������������������������������
����������������������������������������������������������������������������ͻ��
���Programa  � CalculaJuros� Autor � GUILHERME FRAN�A   � Data �  00/00/00   ���
����������������������������������������������������������������������������͹��
���Desc.     � Realiza calculo dos juros compostos e aplica nas parcelas     ���
���          � caso seja informado mais de uma.                              ���
���          � Retorna array:	                            				    ���
���          � aReturn[1]: Taxa de juros                                     ���
���          � aReturn[2]: Valor da parcela                                  ���
���          � aReturn[3]: Total parcelado                                   ���
����������������������������������������������������������������������������͹��
���Uso       � Programa Principal.                                           ���
����������������������������������������������������������������������������ͼ��
��������������������������������������������������������������������������������
��������������������������������������������������������������������������������
*/
Static Function CalculaJuros(_nPos)

	Local oModel     := FWModelActive()
	Local oStruZLK   := oModel:GetModel( 'ZLKMASTER' )
	Local oStruZLL   := oModel:GetModel( 'ZLLDETAIL' )
	Local dVctoCv    := oStruZLK:GetValue("ZLK_VENCON")
	Local dVctoPr    := oStruZLK:GetValue("ZLK_VENCTO")
	Local _aReturn   := {}
	Local _nVlrAcum
	Local _nVlrPar   := 0
	Local _nVlrLiqu  := 0
	Local _nTxJuro   := 0
	Local _nQtdPar   := 0
	Local _nCarencia := 0
	Local _lUsrParc  := (Posicione("ZLU",1,xFilial("ZLU")+Padr(cUserName,25),"ZLU_PRCCON") == "S")

	Local _nDiasPZ :=  dVctoPr - dVctoCv

	oStruZLL:GoLine(_nPos)

	If oStruZLL:GetValue("ZLL_PARCEL") > 0


		If .F. //!(U_GLT_012Z(__CUSERID,"JUROS") ) // Se o usuario tiver permissao de alterar os juros, o preenchimento sera manual
			// Se o evento n�o tiver taxa inormada, busca taxa padr�o
			_nTxJuro := IIF(ZL8->ZL8_TAXA==0,U_BuscaTaxa("CON",Alltrim(ZL8->ZL8_GRUPO)),ZL8->ZL8_TAXA)
		Else
			_nTxJuro := oStruZLL:GetValue("ZLL_TXPARC")
		EndIf
		_nQtdPar := oStruZLL:GetValue("ZLL_PARCEL") //aCols[_nPos,GdFieldPos("ZLL_PARCEL")]
		_nVlrPar := oStruZLL:GetValue("ZLL_VLRPAR") //aCols[_nPos,GdFieldPos("ZLL_VLRPAR")]
		_nVlrAcum := oStruZLL:GetValue("ZLL_VALOR") //aCols[_nPos,GdFieldPos("ZLL_VALOR")]
		_nVlrLiqu := oStruZLL:GetValue("ZLL_VALLIQ") //aCols[_nPos,GdFieldPos("ZLL_VALLIQ")]


		If ZL8->(FieldPos("ZL8->ZL8_CARENC")) != 0 .and. ZL8->ZL8_CARENC > 0
			_nCarencia := ZL8->ZL8_CARENC

		Else
			_nCarencia := IIF( oStruZLL:GetValue("ZLL_CARENC") =="S",1,0)
		EndIf

		If ZL8->ZL8_CARENC > 0 .and. oStruZLL:GetValue("ZLL_CARENC") != "S"
			Alert("O evento "+ZL8->ZL8_COD+" est� configurado com car�ncia de "+cValToChar(ZL8->ZL8_CARENC)+" parcelas!")
			oStruZLL:LoadValue("ZLL_CARENC","S")
		EndIf

		oStruZLL:LoadValue("ZLL_NCAREN",_nCarencia)

		If !_lUsrParc .and. _nQtdPar > 1
			Alert("Usu�rio n�o possui permissao para parcelar conv�nios!","Acesso de Usu�rios GLT")
			oStruZLL:LoadValue("ZLL_PARCEL",1)
			_nQtdPar := 1
		EndIf

		// Se (a taxa for zero ou parcela igual a 1) e tiver carencia na parcela e evento diferente de 100112, n�o existe caculo de juros
		If (_nTxJuro == 0 .or. _nQtdPar == 1) .and. (_nCarencia >0) .and. ZL8->ZL8_COD <> "100112"
			oStruZLL:LoadValue("ZLL_VLRPAR",_nVlrLiqu / _nQtdPar)
			oStruZLL:LoadValue("ZLL_VLRTOT",oStruZLL:GetValue("ZLL_VALOR"))// aCols[_nPos,GdFieldPos("ZLL_VALOR")]
		else
			If _nQtdPar>1 //Se for mais de uma parcela, realiza o calculo do parcelamento
				_nVlrPar := U_CalcJuros("P",_nTxJuro,_nVlrLiqu,_nQtdPar,_nCarencia,"","")
			Else
				If _nDiasPZ>0 // Se a diferenca Venc Produtor - Venc Fornecedor for maior que zero, faz o calculo de juros apenas dos dias corridos de um pagamento a outro
					_nVlrPar := U_CalcJuros("J",_nTxJuro,_nVlrLiqu,0,0,dVctoCv,dVctoPr) //U_CalcJuros("P",_nTxJuro,_nVlrAcum,_nQtdPar,_nCarencia,"","")
				Else
					_nVlrPar := U_CalcJuros("P",_nTxJuro,_nVlrLiqu,_nQtdPar,_nCarencia,"","")
				EndIf
			EndIf

			_nVlrAcum := round(_nVlrPar*int(_nQtdPar),2)

			If _nVlrAcum < oStruZLL:GetValue("ZLL_VALOR") //aCols[_nPos,GdFieldPos("ZLL_VALOR")]
				_nVlrAcum := oStruZLL:GetValue("ZLL_VALOR") //aCols[_nPos,GdFieldPos("ZLL_VALOR")]
			EndIf

			//	AADD(_aReturn,Round(_nTxJuro*100,2))
			AADD(_aReturn,Round(_nTxJuro,2))
			AADD(_aReturn,_nVlrPar)
			AADD(_aReturn,_nVlrAcum)
		EndIf
	Else
		_nVlrAcum := oStruZLL:GetValue("ZLL_VALOR") //aCols[_nPos,GdFieldPos("ZLL_VALOR")]
		AADD(_aReturn,Round(0,2))
		AADD(_aReturn,_nVlrAcum)
		AADD(_aReturn,_nVlrAcum)

	EndIf

Return _aReturn

//==================================================================
// ATUALIZA VALOR TOTAL DO CONVENIO - CHAMADA VALIDA��O DO ZLL_VALOR
//==================================================================
Static Function AtuTotal()

	Local lRet       := .t.
	Local oModel     := FWModelActive()
	Local oStruZLK   := oModel:GetModel( 'ZLKMASTER' )
	Local oStruZLL   := oModel:GetModel( 'ZLLDETAIL' )
	Local nOperation := oModel:GetOperation()
	Local nL         := 0
	Local _nLin      := oStruZLL:GetQTDLine()
	Local _nVlrAtu   := oStruZLL:GetValue("ZLL_VALOR")
	Local _nValor    := 0
	Local _nTxAdm    := 0

	If nOperation == 3 .or. nOperation == 4

		lRet := _nVlrAtu > 0
		For nL := 1 TO _nLin
			oStruZLL:GoLine(nL)
			IF !oStruZLL:IsDeleted(nL)
				_nValor += oStruZLL:GetValue("ZLL_VLRPAG")
			EndIf
		Next nL

		//Atualiza campos do cabe�alho
		oStruZLK:LoadValue("ZLK_VLRTOT",_nValor)

		_nTxAdm	:=_nValor*(oStruZLK:GetValue("ZLK_PTXADM")/100)
		oStruZLK:LoadValue("ZLK_TXADM",_nTxAdm)
	EndIf

Return lRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GravaTit   �Autor  �Microsiga           � Data �  11/26/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GravaTit(oModel)

	Local _lRetorno := .t.
	Local _nOpc      := oModel:GetOperation()
	Local _cTexto := ""
	Private oProcess  := NIL

	If _nOpc == 3
		_cTexto := "Gravando conv�nio..."
	ElseIf _nOpc == 4
		_cTexto := "Alterando conv�nio..."
	ElseIf _nOpc == 5
		_cTexto := "Excluindo conv�nio..."
	EndIf

	oProcess := MsNewProcess():New( {|| _lRetorno := GrvTit(oModel)},_cTexto, "Aguarde, processando ...", .F. )
	oProcess:Activate()

Return _lRetorno

Static Function GrvTit(oModel)

	Local _aArea		:= GetArea()
	Local _lRetorno		:= .T.
	Local oStruZLK		:= oModel:GetModel("ZLKMASTER")
	Local oStruZLL		:= oModel:GetModel("ZLLDETAIL")
	Local _nOpc			:= oModel:GetOperation()
	Local _nQtdLin		:= oStruZLL:GetQTDLine()
	Local _lDelete		:= _nOpc == 5
	Local _lInclui		:= _nOpc == 3
	Local _lAltera		:= _nOpc == 4
	Local nX			:= 0
	Local cPrefixo		:= ""
	Local cCod			:= oStruZLK:GetValue("ZLK_COD")
	Local cConven		:= oStruZLK:GetValue("ZLK_CONVEN")
	Local cLjConv		:= oStruZLK:GetValue("ZLK_LJCONV")
	Local dVctoCv		:= oStruZLK:GetValue("ZLK_VENCON")
	Local dVctoPr		:= oStruZLK:GetValue("ZLK_VENCTO")
	Local cEvento		:= oStruZLK:GetValue("ZLK_EVENTO")
	Local _nTotConv		:= 0
	Local _nTxAdm		:= 0
	Local nPAdm			:= oStruZLK:GetValue("ZLK_PTXADM")
	Local cParcela		:= StrZero(1,TamSX3("E2_PARCELA")[1])
	Local _cPrc01		:= cParcela
	Local cObs			:= oStruZLK:GetValue("ZLK_OBSERV")
	Local dData			:= dDataBase
	Local _dDtEmiss		:= dData
	Local cNatNF		:= PADR(SUPERGETMV("LT_CONVNAT"),10) //Natureza do titulo NF
	Local _cTipoTit		:= PADR(Alltrim(GetMv("LT_CONVTIP")),3) //Tipo de t�tulos
	Local _lIncNF		:= .f.
	Local lIncSE2ok		:= .T.
	Local nVlrSE2		:= 0
	Local nAcrSE2		:= 0
	Local _nX			:= 0
	Local _aPrcForn		:= {}
	Local cCarencia		:= "N"
	Local nCarencia		:= 0
	Local nIVlrparc		:= 0
	Local nParcela		:= 1
	Local nIVlrtot		:= 0
	Local nTxPar		:= 0
	Local nL			:= 0
	Local _ag			:= 0
	Local nPrc			:= 0
	Local ix			:= 0

	If !_lDelete
		//Recalcula total da ZLK novamente para garantir
		_nValTot := 0
		For nL := 1 TO oStruZLL:Length() //_nLin
			oStruZLL:GoLine(nL)
			IF !oStruZLL:IsDeleted(nL)
				_nValTot += oStruZLL:GetValue("ZLL_VALOR")
			EndIf
		Next nL
		//Atualiza campos do cabe�alho
		oStruZLK:LoadValue("ZLK_VLRTOT",_nValTot)

		_nTxAdm:=_nValTot*(oStruZLK:GetValue("ZLK_PTXADM")/100)
		oStruZLK:LoadValue("ZLK_TXADM",_nTxAdm)
	EndIf

	If !_lGeraFin //Se o sistema estiver parametrizado para n�o gerar t�tulos financeiros, retorna sem processar t�tulos.
		Return _lRetorno
	EndIf

	oProcess:SetRegua1(_nQtdLin)

	// ------------------------------------------------
	// Preenche a Natureza do titulo NDF e o Prefixo
	// ------------------------------------------------
	dbSelectArea('ZL8')
	ZL8->(dbSeek(xFILIAL("ZL8")+cEvento))
	cNatNDF  := ZL8->ZL8_NATPRD
	cNatNF := ZL8->ZL8_NATFRT
	cPrefixo := ZL8->ZL8_PREFIX
	cGerNfCv := ZL8->ZL8_GERNFC//Define se gera Titulo NF do convenio

	If ZL8->(FieldPos("ZL8_PRCFOR")) != 0
		_lPrcForn := IIF(ZL8->ZL8_PRCFOR=="S",.T.,.F.)    // Indica se o pagamento do fornecedor ser� parcelado
	EndIf

	If !_lDelete
		//Semaforo para pemitir a grava��o de mais de um usu�rio por vez
		While !LockByName("AGLT110",.T.,.F. )
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


	// ----------------------------
	// EXCLUSAO - Deleta SE2
	// ----------------------------
	Begin Transaction
		If _lDelete

			For nX:=1 To _nQtdLin
				oStruZLL:GoLine(nX)

				cISeq 	:= oStruZLL:GetValue("ZLL_SEQ")
				cIPrd 	:= oStruZLL:GetValue("ZLL_RETIRO")
				cIPrdlj := oStruZLL:GetValue("ZLL_RETILJ")

				DbSelectArea("SE1")
				DbSetOrder(2) //E1_FILIAL, E1_CLIENTE, E1_LOJA, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, R_E_C_N_O_, D_E_L_E_T_
				If SE1->(MsSeek(xFilial("SE1")+cIPrd+cIPrdLj+cPrefixo+cCod+cISeq+cParcela+_cTipoTit))
					If dElse1(cPrefixo,cCod+cISeq,cParcela,_cTipoTit,cIPrd,cIPrdLj,cNatNDF)  //dElse2(cPrefixo,cCod+cISeq,cParcela,"NDF",cIPrd,cIPrdLj,cNatNDF)
						dElse2(cPrefixo,cCod+"000",cParcela,_cTipoTit,cConven,cLjConv,cNatNF)
					Else
						_lRetorno := .F.
						Exit
					EndIf
				EndIf
			Next nX

			If _lRetorno
				If !(dElse2(cPrefixo,cCod+"000",cParcela,_cTipoTit,cConven,cLjConv,cNatNF))
					_lRetorno := .F.
				EndIf
			EndIf

			//Varre todo SE2 pra garantir que n�o ficaram NDFs em aberto de registros deletados na ZLL
			For _ag := 1 to _nQtdLin
				dElse1(cPrefixo,cCod+StrZero(_ag,3),cParcela,_cTipoTit,cIPrd,cIPrdLj,cNatNDF)
			Next _ag

			//����������������������������������������������������������Ŀ
			//� Finaliza o controle de transacao, caso nao hajam falhas. �
			//������������������������������������������������������������
		EndIf

		// ----------------------------------------
		// Exclui titulo NF da loja conveniada
		// quando For alteracao ou exclusao
		// ----------------------------------------
		//Se alteracao
		If _lRetorno
			If _lAltera //.or. _lDelete

				_dDtEmiss	:= oStruZLK:GetValue("ZLK_DATA")
				For nX:=1 To _nQtdLin
					oStruZLL:GoLine(nX)
					IF !oStruZLL:IsDeleted(nX)
						_nTotConv += oStruZLL:GetValue("ZLL_VALOR")
					EndIf
				Next nX

				oStruZLK:LoadValue("ZLK_VLRTOT",_nTotConv)
				_nTxAdm:=_nTotConv*(oStruZLK:GetValue("ZLK_PTXADM")/100)
				oStruZLK:LoadValue("ZLK_TXADM",_nTxAdm)

				//Se gera o titulo NF do convenio igual a Sim
				If cGerNfCv == "S"
					DbSelectArea("SE2")
					DbSetOrder(1) //E2_FILIAL, E2_PREFIXO, E2_NUM, E2_PARCELA, E2_TIPO, E2_FORNECE, E2_LOJA, R_E_C_N_O_, D_E_L_E_T_
					SE2->(MsSeek(xFilial("SE2")+cPrefixo+cCod+"000"+_cPrc01+_cTipoTit+cConven+cLjConv))
					If (SE2->E2_VALOR <> _nTotConv) .or. (_nTxAdm <> SE2->E2_DECRESC) .or. (dVctoCv <> SE2->E2_VENCTO)
						If dElse2(cPrefixo,cCod+"000",_cPrc01,_cTipoTit,cConven,cLjConv,cNatNF) //Alterado para sempre apagar todas as parcelas
							lContinue := .T.
							_lIncNF := .T. //Registra se foi necess�rio apagar o NF da SE2
						Else
							_lRetorno := .F.
						EndIf
					EndIf
				Else
					lContinue:=.T.
				EndIf
			ElseIf _lInclui
				oStruZLK:LoadValue("ZLK_STATUS","A")
				//Verifica se o codigo esta ou nao duplicado
				//caso esteja duplicado incrementa o codigo
				dbSelectArea("ZLL")
				dbSetOrder(1)
				While ( dbSeek(xFILIAL("ZLL")+cCod+"001") .or. !MayIUseCode("ZLL" + xFilial("ZLL") + cCod) )
					//verifica se esta na memoria, sendo usado e busca o proximo numero disponivel
					cCod := SOMA1(cCod)
				EndDo
			EndIf

			If _lRetorno
				_nVlrRed := 0
				// ----------------
				// Trata os NDF's
				// ----------------
				If _lAltera .or. _lInclui
					_nTotConv := 0
					For nX:=1 To _nQtdLin
						oStruZLL:GoLine(nX)
						oProcess:IncRegua1("Gravando debitos item " +Alltrim(STR(nX))+" de "+Alltrim(STR(_nQtdLin)) )

						cISeq 	:= oStruZLL:GetValue("ZLL_SEQ") //aCols[nX,GdFieldPos("ZLL_SEQ")]
						cIPrd 	:= oStruZLL:GetValue("ZLL_RETIRO") //aCols[nX,GdFieldPos("ZLL_RETIRO")]
						cIPrdlj := oStruZLL:GetValue("ZLL_RETILJ") //aCols[nX,GdFieldPos("ZLL_RETILJ")]
						cIDescri:= oStruZLL:GetValue("ZLL_DCRRET") //aCols[nX,GdFieldPos("ZLL_DCRRET")]
						nIVlr 	:= oStruZLL:GetValue("ZLL_VALOR") //aCols[nX,GdFieldPos("ZLL_VALLIQ")]
						cIStat 	:= oStruZLL:GetValue("ZLL_STATUS") //IIf(GdFieldPos("ZLL_STATUS")==0,"A",aCols[nX,GdFieldPos("ZLL_STATUS")])
						If _lParcela
							cCarencia	:= oStruZLL:GetValue("ZLL_CARENC") //IIF(GdFieldPos("ZLL_CARENC")==0,"N",aCols[nX,GdFieldPos("ZLL_CARENC")])
							nCarencia	:= oStruZLL:GetValue("ZLL_NCAREN") //IIF(GdFieldPos("ZLL_NCAREN")==0,"N",aCols[nX,GdFieldPos("ZLL_NCAREN")])
							nIVlrparc 	:= oStruZLL:GetValue("ZLL_VLRPAR") //IIf(GdFieldPos("ZLL_VLRPAR")==0,aCols[nX,GdFieldPos("ZLL_VALOR")],aCols[nX,GdFieldPos("ZLL_VLRPAR")])
							nParcela 	:= oStruZLL:GetValue("ZLL_PARCEL") //IIF(GdFieldPos("ZLL_PARCEL")==0,1,aCols[nX,GdFieldPos("ZLL_PARCEL")])
							nIVlrtot 	:= oStruZLL:GetValue("ZLL_VLRTOT") //IIF(aCols[nX,GdFieldPos("ZLL_VLRTOT")]< nIVlr,nIVlr,aCols[nX,GdFieldPos("ZLL_VLRTOT")])
							nTxPar 	:= oStruZLL:GetValue("ZLL_TXPARC") //IIF(GdFieldPos("ZLL_TXPARC")==0,0,aCols[nX,GdFieldPos("ZLL_TXPARC")])
						EndIf
						lLinDeleted := oStruZLL:IsDeleted(nX) //aCols[nX,Len(aHeader)+1]


						If nIVlrparc == 0
							nIVlrparc := nIVlr
							nIVlrtot	:= nIVlr
						EndIf

						nVlrSE2 := Round(nIVlr / nParcela,2)		//Valor a ser gravano no E2_VALOR quando for NDF
						If _lParcela
							nAcrSE2	:= nIVlrparc - nVlrSE2	//Valor a ser gravado no E2_ACRESC quando for NDF
						Endif

						// ----------------------------
						// INCLUSAO - Gera SE2 e ZLL
						// ----------------------------
						If _lInclui
							// ----------------------------
							// Se a linha NAO foi deletada
							// ----------------------------

							If !lLinDeleted
								_nTotConv += oStruZLL:GetValue("ZLL_VALOR")

								_aVenctos := SomaMes(dVctoPr,nParcela)

								_nVlrRed := 0
								For nPrc:= 1 to nParcela
									//Tratamento para jogar diferen�a na ultima parcela
									_nVlrRed += nVlrSE2 + nAcrSE2
									If 	nPrc == nParcela
										If _nVlrRed < nIVlr
											nVlrSE2 +=  nIVlr - _nVlrRed
										EndIf
									EndIf

									If nParcela > 1
										oProcess:SetRegua2(nParcela)
										oProcess:IncRegua2("Parcela: " +Alltrim(STR(nPrc))+" de "+Alltrim(STR(nParcela)) )
									EndIf

									cParcela  := StrZero(nPrc,TamSX3("E2_PARCELA")[1])
									lIncSE2ok := U_IncluSE1(cPrefixo,cCod+cISeq,cParcela,"NF",cIPrd,cIPrdLj,cNatNDF,_dDtEmiss,_aVenctos[nPrc],nVlrSE2,nAcrSE2,0,cConven+cLjConv,cObs,NoRound(nTxPar/30,2),cEvento,"AGLT110")

									//Regra de parcelamento do fornecedor. Ser�o geradas parcelas de acordo com o pagamento dos produtores.
									If Len(_aPrcForn)>0
										If ascan(_aPrcForn,{|x| x[1] == _aVenctos[nPrc]}) > 0 //Identifica se o vencimento posicionado j� existe no array
											_aPrcForn[ascan(_aPrcForn,{|x| x[1] == _aVenctos[nPrc]})][2] += nVlrSE2 //Soma valor no vencimento j� existente
										Else
											AADD(_aPrcForn,{_aVenctos[nPrc],nVlrSE2}) //Cria nova parcela
										EndIf
									ELSE
										AADD(_aPrcForn,{_aVenctos[nPrc],nVlrSE2}) // Cria nova parcela
									EndIf

								Next nPrc
								cParcela  := StrZero(1,TamSX3("E2_PARCELA")[1])
								If !lIncSE2ok
									_lRetorno := .F.
									Exit
								EndIf
							EndIf
						EndIf

						// ----------------------------
						// ALTERACAO - Verifica mudancas
						// ----------------------------
						If _lAltera

							// ----------------------------
							// Se a linha NAO foi deletada
							// ----------------------------
							If !lLinDeleted
								_nTotConv += oStruZLL:GetValue("ZLL_VALOR")
								// -------------------------------------------------------------------------
								// Se a Linha foi alterada entao deleta SE2,ZLL e gera com novos valores
								// -------------------------------------------------------------------------
								If Alterado(cCod,cISeq,cIPrd,nIVlr,cIStat,nIVlrparc,nParcela,dVctoCv)
									//Alterado para deletar o titulo quando o mesmo For suspenso
									If dElse1(cPrefixo,cCod+cISeq,cParcela,_cTipoTit,ZLL->ZLL_RETIRO,ZLL->ZLL_RETILJ,cNatNDF) //dElse2(cPrefixo,cCod+cISeq,_cPrc01,"NDF",ZLL->ZLL_RETIRO,ZLL->ZLL_RETILJ,cNatNDF) //Alterado para sempre deletar todas as parcelas
										If cIStat <> "S" //Se status diferente de suspenso grava SE2 e ZLL
											_aVenctos := SomaMes(dVctoPr,nParcela)

											For nPrc:= 1 to nParcela
												cParcela := StrZero(nPrc,TamSX3("E2_PARCELA")[1])
												lIncSE2ok := U_IncluSE1(cPrefixo,cCod+cISeq,cParcela,"NF",cIPrd,cIPrdLj,cNatNDF,_dDtEmiss,_aVenctos[nPrc],nVlrSE2,nAcrSE2,0,cConven+cLjConv,cObs,NoRound(nTxPar/30,2),cEvento,"AGLT110")

												//Regra de parcelamento do fornecedor. Ser�o geradas parcelas de acordo com o pagamento dos produtores.
												If Len(_aPrcForn)>0
													If ascan(_aPrcForn,{|x| x[1] == _aVenctos[nPrc]}) > 0 //Identifica se o vencimento posicionado j� existe no array
														_aPrcForn[ascan(_aPrcForn,{|x| x[1] == _aVenctos[nPrc]})][2] += nVlrSE2 //Soma valor no vencimento j� existente
													Else
														AADD(_aPrcForn,{_aVenctos[nPrc],nVlrSE2}) //Cria nova parcela
													EndIf
												ELSE
													AADD(_aPrcForn,{_aVenctos[nPrc],nVlrSE2}) // Cria nova parcela
												EndIf


											Next nPrc
											cParcela  := StrZero(1,TamSX3("E2_PARCELA")[1])
											If !lIncSE2ok
												_lRetorno := .F.
												Exit
											EndIf
										EndIf
									Else
										_lRetorno := .F.
									EndIf
								Else
									cParcela  := StrZero(1,TamSX3("E2_PARCELA")[1])
									dbSelectArea("SE2")
									dbSetOrder(1)
									If !SE2->(MsSeek(xFILIAL("SE2")+cPrefixo+cCod+cISeq+cParcela+"NDF"+cIPrd+cIPrdLj))
										//Inclus�o de linha nova na altera��o do convenio
										_aVenctos := SomaMes(dVctoPr,nParcela)
										For nPrc:= 1 to nParcela
											cParcela  := StrZero(nPrc,TamSX3("E2_PARCELA")[1])
											lIncSE2ok := U_IncluSE1(cPrefixo,cCod+cISeq,cParcela,"NF",cIPrd,cIPrdLj,cNatNDF,_dDtEmiss,_aVenctos[nPrc],nVlrSE2,nAcrSE2,0,cConven+cLjConv,cObs,NoRound(nTxPar/30,2),cEvento,"AGLT110")
											//Regra de parcelamento do fornecedor. Ser�o geradas parcelas de acordo com o pagamento dos produtores.
											If Len(_aPrcForn)>0
												If ascan(_aPrcForn,{|x| x[1] == _aVenctos[nPrc]}) > 0 //Identifica se o vencimento posicionado j� existe no array
													_aPrcForn[ascan(_aPrcForn,{|x| x[1] == _aVenctos[nPrc]})][2] += nVlrSE2 //Soma valor no vencimento j� existente
												Else
													AADD(_aPrcForn,{_aVenctos[nPrc],nVlrSE2}) //Cria nova parcela
												EndIf
											ELSE
												AADD(_aPrcForn,{_aVenctos[nPrc],nVlrSE2}) // Cria nova parcela
											EndIf

										Next nPrc
										cParcela  := StrZero(1,TamSX3("E2_PARCELA")[1])
										If !lIncSE2ok
											_lRetorno := .F.
											Exit
										EndIf
									Else
										_aVenctos := SomaMes(dVctoPr,nParcela)
										For nPrc:= 1 to nParcela
											If Len(_aPrcForn)>0
												If ascan(_aPrcForn,{|x| x[1] == _aVenctos[nPrc]}) > 0 //Identifica se o vencimento posicionado j� existe no array
													_aPrcForn[ascan(_aPrcForn,{|x| x[1] == _aVenctos[nPrc]})][2] += nVlrSE2 //Soma valor no vencimento j� existente
												Else
													AADD(_aPrcForn,{_aVenctos[nPrc],nVlrSE2}) //Cria nova parcela
												EndIf
											ELSE
												AADD(_aPrcForn,{_aVenctos[nPrc],nVlrSE2}) // Cria nova parcela
											EndIf
										Next nPrc
									EndIf

								EndIf

								// ---------------------------------------------------------------------
								// Se a linha foi deletada, deleta no SE2 e ZLL
								// ---------------------------------------------------------------------
							Else
								cParcela  := StrZero(1,TamSX3("E2_PARCELA")[1])
								If !dElse1(cPrefixo,cCod+cISeq,cParcela,_cTipoTit,cIPrd,cIPrdLj,cNatNDF) //dElse2(cPrefixo,cCod+cISeq,cParcela,"NDF",cIPrd,cIPrdLj,cNatNDF)
									_lRetorno := .F.
									Exit
								EndIf
							EndIf
						EndIf
					Next nX
				EndIf

				// -------------------------------------
				// Trata o NF (titulo da loja conveniada)
				// -------------------------------------
				//Se inclusao e Gera Titulo NF de convenio igual a Sim
				If _lRetorno
					If _lInclui .and. cGerNfCv == 'S' .and. _lGeraFin //Se o sistema estiver parametrizado para  gerar t�tulos financeiros

						If !_lPrcForn //Indica se o pagamento do fornecedor sera parcelado
							oProcess:SetRegua2(1)
							oProcess:IncRegua2("Gerando t�tulo do fornecedor... ")

							If !U_Inc_SE2(cPrefixo,cCod+"000",cParcela,_cTipoTit,cConven,cLjConv,cNatNF,dData,dVctoCv,_nTotConv,0,_nTxAdm,"",cObs,0,cEvento)
								_lRetorno := .F.
							EndIf
						Else
							oProcess:SetRegua2(Len(_aPrcForn))
							For ix := 1 to Len(_aPrcForn)
								oProcess:IncRegua2("Gerando t�tulos do fornecedor. Titulo" +Alltrim(STR(iX))+" de "+Alltrim(STR(Len(_aPrcForn))) )
								cParcela:= StrZero(ix,TamSX3("E2_PARCELA")[1])
								If !U_Inc_SE2(cPrefixo,cCod+"000",cParcela,_cTipoTit,cConven,cLjConv,cNatNF,dData,MonthSum(dVctoCv,ix-1),_aPrcForn[ix][2],0,_aPrcForn[ix][2]*(nPAdm/100),"",cObs,0,cEvento)
									_lRetorno := .F.
									Exit
								EndIf
							Next ix
						EndIf

						//Se alteracao e Gera Titulo NF de convenio igual a Sim
					ElseIf _lAltera .and. cGerNfCv == 'S' .and. _lIncNF .and. _lGeraFin //Se o sistema estiver parametrizado para  gerar t�tulos financeiros
						If !_lPrcForn //Indica se o pagamento do fornecedor sera parcelado
							If !U_Inc_SE2(cPrefixo,cCod+"000",cParcela,_cTipoTit,cConven,cLjConv,cNatNF,dData,dVctoCv,_nTotConv,0,_nTxAdm,"",cObs,0,cEvento)
								//AtuTaxas()
								_lRetorno := .F.
							EndIf
						Else
							For ix := 1 to Len(_aPrcForn)
								cParcela:= StrZero(ix,TamSX3("E2_PARCELA")[1])
								If !U_Inc_SE2(cPrefixo,cCod+"000",cParcela,_cTipoTit,cConven,cLjConv,cNatNF,dData,MonthSum(dVctoCv,ix-1),_aPrcForn[ix][2],0,_aPrcForn[ix][2]*(nPAdm/100),"",cObs,0,cEvento)
									_lRetorno := .F.
									Exit
								EndIf
							Next ix
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf

		If !_lRetorno
			DisarmTransaction()
			Help( ,, 'ERROFIN',," Ocorreram erros durante a grava��o dos t�tulos no financeiro que impedem a continuidade do processo!", 1, 0 )
		EndIf

	End Transaction

	UnLockByName("AGLT110",.T.,.F.)
	FreeUsedCode()  //libera codigos de correlativos reservados pela MayIUseCode()
	RestArea(_aArea)

Return _lRetorno

/*
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  � Alterado � Autor � Abrahao P. Santos     � Data da Criacao  � 10/02/2009                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Verifica se o item foi alterado                 		    	                           						���
���			 �														                                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Parametros� Codigo,Sequencia,Fornecedor,Valor                   		                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Retorno   � Verdadeiro = se foi alterado	                               													���
���			 � Falso = se nao foi alterado										                     						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Usuario   � TOTVS - Microsiga											                             					���
���������������������������������������������������������������������������������������������������������������������������͹��
���Setor     � Gestao do Leite                                                                          					���
���������������������������������������������������������������������������������������������������������������������������͹��
���            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Autor     � Data     � Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor        ���
���������������������������������������������������������������������������������������������������������������������������ĺ��
���          �          �                   							   �                                  �  	        ���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���          �          �                    							   �                                  � 			���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���������������������������������������������������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
*/
Static Function Alterado(cCod,cSeq,nPrd,nVlr,cStat,nVlrparc,nParc,xdVctoCv)

	dbSelectArea("ZLL")
	dbSetOrder(1)
	If ZLL->(MsSeek(xFILIAL("ZLL")+cCod+cSeq))
		If ZLL->ZLL_RETIRO != nPrd .Or. ZLL->ZLL_VALOR != nVlr .Or. ZLL->ZLL_STATUS != cStat  .Or.;
				ZLL->ZLL_VLRPAR != nVlrparc  .Or. ZLL->ZLL_PARCEL != nParc .Or. ZLL->ZLL_VENCON != xdVctoCv
			Return .T.
		EndIf
	EndIf

Return(.F.)

/*
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  � dElse2   � Autor � Abrahao P. Santos     � Data da Criacao  � 10/02/2009                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Deleta titulo da SE2                            		    	                           						���
���			 �														                                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Parametros� Prefixo,Numero,Parcela,Tipo,Forn,Loja,Natureza																���
���������������������������������������������������������������������������������������������������������������������������͹��
���Retorno   � Verdadeiro = Se gravou corretamente							                         						���
���			 � Falso = Se ocorreu erro								                                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Usuario   � TOTVS - Microsiga											                             					���
���������������������������������������������������������������������������������������������������������������������������͹��
���Setor     � Gestao do Leite                                                                          					���
���������������������������������������������������������������������������������������������������������������������������͹��
���            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Autor     � Data     � Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor        ���
���������������������������������������������������������������������������������������������������������������������������ĺ��
���          �          �                   							   �                                  �  	        ���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���          �          �                    							   �                                  � 			���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���������������������������������������������������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
*/
Static Function dElse2(cpPrefixo,cpNum,cpParcela,cpTipo,cpForn,cpLoja,cpNatureza)

	Local _aAutoSE2 := {}
	Local lOk       := .T.

	Private lMsErroAuto := .F.

	nModulo := 6
	cModulo := "FIN"

	dbSelectArea("SE2")
	dbSetOrder(1)
	dbGoTop()
	Pergunte("FIN050",.F.) // Chama perguntas da rotina para evitar erros no Sigaauto
	While !SE2->(Eof()) .and. SE2->(MsSeek(xFILIAL("SE2")+cpPrefixo+cpNum))

		If SE2->(dbSeek(xFILIAL("SE2")+cpPrefixo+cpNum+cpParcela+cpTipo+cpForn+cpLoja))
			AAdd( _aAutoSE2, { "E2_PREFIXO"	, cpPrefixo, Nil } )
			AAdd( _aAutoSE2, { "E2_NUM"		, cpNum, Nil } )
			AAdd( _aAutoSE2, { "E2_PARCELA"	, cpParcela, Nil } )
			AAdd( _aAutoSE2, { "E2_TIPO"	, cpTipo, Nil } )
			AAdd( _aAutoSE2, { "E2_NATUREZ"	, cpNatureza, Nil } )
			AAdd( _aAutoSE2, { "E2_FORNECE"	, cpForn, Nil } )
			AAdd( _aAutoSE2, { "E2_LOJA"	, cpLoja, Nil } )
			If Found()

				MSExecAuto({|x,y,z| Fina050(x,y,z)},_aAutoSE2,,5)

				If lMsErroAuto
					lOk := .F.
					xMagHelpFis("Erro","Erro ao excluir o Titulo: "+cpPrefixo+cpNum+"-"+cpForn+", portanto os lan�amentos deste conv�nio n�o podem ser exclu�dos","Comunique ao Suporte!!!")
					mostraerro()
				EndIf
			Else
				xMagHelpFis("Erro - Exclusao ","O Titulo nao foi encontrado!","Comunique ao Suporte! Indice:"+cpPrefixo+cpNum+cpParcela+cpTipo+cpForn+cpLoja)
				If MsgYesNo("Tentar gerar o titulo NF assim mesmo? ")
					lOk := .T.
				Else
					lOk := .F.
				EndIf
			EndIf
			_aAutoSE2 := {}
		EndIf
		cpParcela := Soma1(cpParcela)
	EndDo

	nModulo := 2
	cModulo := "COM"

Return lOk

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Somames   �Autor  �Microsiga           � Data �  12/27/13   ���
�������������������������������������������������������������������������͹��
���Desc.     � Retorna array com vencimentos                              ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function SomaMes(dData,dParc)
	Local sdata
	Local firstDay := substr(dtos(dData),7,2)
	Local ret      := {}
	Local ax       := 0
	Local z        := 0

	For z:=1 To dParc
		aadd(ret, dData)
		sData := dtos(dData)
		ano   := substr(SData,1,4)
		mes   := substr(SData,5,2)
		dia   := firstDay

		mes   := strzero(val(mes)+1,2)
		If (mes=="13")
			mes := "01"
			ax:= val(ano)
			ax++
			ano := ALLTRIM(str(ax))
		EndIf

		dData := stod(ano+mes+dia)
		If Empty(dData)
			dData := lastday(stod(ano+mes+"01"))
		EndIf
	Next z

Return ret

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �dElse1    �Autor  �Microsiga           � Data �  03/24/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Delete titulo na tabela SE1                                 ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function dElse1(cpPrefixo,cpNum,cpParcela,cpTipo,cpForn,cpLoja,cpNatureza)


	Local nModAnt := nModulo
	Local cModAnt := cModulo
	Local _aAutoSE1 := {}

	Local lOk       := .T.

	Private lMsErroAuto := .F.

	nModulo := 6
	cModulo := "FIN"

	dbSelectArea("SE1")
	dbSetOrder(1) //E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
	dbGoTop()
	Pergunte("FIN040",.F.) // Chama perguntas da rotina para evitar erros no Sigaauto
	While dbSeek(xFILIAL("SE1")+cpPrefixo+cpNum+cpParcela+cpTipo) .and. !Eof()

		//������������������������������������������������������Ŀ
		//� Array com os dados a serem passados para o SigaAuto. �
		//��������������������������������������������������������
		_aAutoSE1:={{"E1_PREFIXO",SE1->E1_PREFIXO,Nil},;
			{"E1_NUM"    ,SE1->E1_NUM    ,Nil},;
			{"E1_TIPO"   ,SE1->E1_TIPO   ,Nil},;
			{"E1_PARCELA",SE1->E1_PARCELA,Nil},;
			{"E1_NATUREZ",SE1->E1_NATUREZ,Nil}}

		If Found()

			MSExecAuto({|x,y| FINA040(x,y)},_aAutoSE1,5)

			If lMsErroAuto
				lOk := .F.
				xMagHelpFis("Erro","Erro ao excluir o Titulo: "+cpPrefixo+cpNum+"-"+cpForn+", portanto os lan�amentos deste conv�nio n�o podem ser exclu�dos","Comunique ao Suporte!!!")
				mostraerro()
			EndIf
		Else
			xMagHelpFis("Erro - Exclusao ","O Titulo nao foi encontrado!","Comunique ao Suporte! Indice:"+cpPrefixo+cpNum+cpParcela+cpTipo+cpForn+cpLoja)
			If MsgYesNo("Tentar gerar o titulo NF assim mesmo? ")
				lOk := .T.
			Else
				lOk := .F.
			EndIf
		EndIf
		cpParcela := Soma1(cpParcela)
		_aAutoSE1 := {}
	EndDo

	nModulo := nModAnt
	cModulo := cModAnt

Return lOk

/*
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  � Inc_SE2  � Autor �TOTVS TM			       � Data da Criacao  � 10/02/2009                					���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Inclui titulo na SE2                            		    	                           						���
���			 �														                                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Parametros�   Prefixo,  Num,  Parcela,  Tipo,  Forn,  Loja,  Natureza,  Emissao,  Vencto,  Valor, Acrescimo, Decrescimo. ���
���			 �	 Codigo+Loja da Operadora do Conv�nio, Historico do Titulo SE2.                        						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Retorno   � Verdadeiro = Se gravou corretamente							                         						���
���			 � Falso = Se ocorreu erro								                                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Usuario   � TOTVS - Microsiga											                             					���
���������������������������������������������������������������������������������������������������������������������������͹��
���Setor     � Gestao do Leite                                                                          					���
���������������������������������������������������������������������������������������������������������������������������͹��
���            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Autor     � Data     � Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor        ���
���������������������������������������������������������������������������������������������������������������������������ĺ��
���          �          �                   							   �                                  �  	        ���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���          �          �                    							   �                                  � 			���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���������������������������������������������������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
ATENCAO - ESTA FUNCAO TAMBEM E UTILIZADA PELO FONTE MGLT025 (IMPORTACAO CONVENIO UNIMED)
*/
User Function Inc_SE2(cpPrefixo,cpNum,cpParcela,cpTipo,cpForn,cpLoja,cpNatureza,cpEmissao,cpVencto,npValor,npAcres,npDesc,cTitPai,cHist,nVlTxPer,cpEvento,_cnGuia)

	Local _aAutoSE2 :={}
	Local lOk       := .T.
	Local aArea     := GetArea()
	Local aAreaSA2  := SA2->(GetArea())
	Private lMsErroAuto := .F.

	DEFAULT nVlTxPer  := 0 //If(cpTipo=="NDF",Round((U_BUSCATAXA("BOL","BO")/30),4),0)//Se eh debito do produtor, grava valor da Taxa de Permanencia para cobrar juros.
	DEFAULT cTitPai := ""
	DEFAULT cHist   := "GLT-CONVENIO"


	dbSelectArea("SA2")
	dbSetOrder(1)
	dbSeek(xFILIAL("SA2")+cpForn+cpLoja)

	DbSelectArea("SE2")
	DbSetOrder(1)
	While MsSeek(xFILIAL("SE2")+cpPrefixo+cpNum+cpParcela+cpTipo+cpForn+cpLoja)
		cpNum := Soma1(cpNum)
	EndDo

	AAdd( _aAutoSE2, { "E2_PREFIXO"	, cpPrefixo , Nil } )
	AAdd( _aAutoSE2, { "E2_NUM"		, cpNum     , Nil } )
	AAdd( _aAutoSE2, { "E2_PARCELA"	, cpParcela , Nil } )
	AAdd( _aAutoSE2, { "E2_TIPO"	, cpTipo    , Nil } )
	AAdd( _aAutoSE2, { "E2_NATUREZ"	, cpNatureza, Nil } )
	AAdd( _aAutoSE2, { "E2_FORNECE"	, cpForn    , Nil } )
	AAdd( _aAutoSE2, { "E2_LOJA"	, cpLoja    , Nil } )
	AAdd( _aAutoSE2, { "E2_EMISSAO"	, cpEmissao , Nil } )
	AAdd( _aAutoSE2, { "E2_EMIS1"	, cpEmissao , Nil } )
	AAdd( _aAutoSE2, { "E2_VENCTO"	, cpVencto  , Nil } )//Data base do sistema
	AAdd( _aAutoSE2, { "E2_VENCREA"	, cpVencto  , Nil } )
	AAdd( _aAutoSE2, { "E2_VALOR"	, npValor   , Nil } )
	AAdd( _aAutoSE2, { "E2_PORCJUR" , nVlTxPer  , Nil } )
	AAdd( _aAutoSE2, { "E2_ACRESC"	, npAcres   , Nil } )
	AAdd( _aAutoSE2, { "E2_DECRESC"	, npDesc    , Nil } )
	AAdd( _aAutoSE2, { "E2_HIST"	, cHist     , Nil } )
	AAdd( _aAutoSE2, { "E2_DATALIB"	, cpEmissao , Nil } )
	AAdd( _aAutoSE2, { "E2_USUALIB"	, ALLTRIM(cUserName), Nil } )
	AAdd( _aAutoSE2, { "E2_L_PAICV"	, cTitPai   , Nil } )
	AAdd( _aAutoSE2, { "E2_L_EVENT"	, cpEvento    , Nil } )
	AAdd( _aAutoSE2, { "E2_ORIGEM"	, "AGLT110" , Nil } )
	nModulo := 6
	cModulo := "FIN"

	Pergunte("FIN050",.F.) // Chama perguntas da rotina para evitar erros no Sigaauto
	MSExecAuto({|x,y| Fina050(x,y)},_aAutoSE2,3) //Inclusao dos lancamentos do convenio no financeiro.
	If lMsErroAuto
		lOk := .F.
		xMagHelpFis("Erro","Erro ao incluir Titulo: "+cpPrefixo+cpNum+"-"+cpForn,"Comunique ao Suporte!!!")
		mostraerro()
	EndIf
	nModulo := 2
	cModulo := "COM"

	RestArea(aArea)
	RestArea(aAreaSA2)
Return lOk


/*
===============================================================================================================================
Programa----------: IMPORTCSV
Autor-------------: GUILHERME FRAN�A
Data da Criacao---: 14/08/2020
===============================================================================================================================
Descricao---------: Importa��o de arquivo CSV para preenchimento dos itens
==============================================================================================================================*/
Static Function IMPORTCSV()

	Local _cTexto := ""
	Local _nOpc := 0
	Local oSay

	_cTexto := "Esta op��o permite a importa��o de um arquivo no formato .CSV para o"+_ENTER
	_cTexto += "preenchimento dos itens deste lan�amento." +_ENTER +_ENTER
	_cTexto += "O arquivo dever� conter duas colunas separadas por ponto e v�rgula contendo:" +_ENTER +_ENTER
	_cTexto += "CPF/CNPJ;VALOR   ou   C�DIGO;VALOR."

	_nOpc := AVISO("Importa��o .csv", _cTexto, { "Continuar","Fechar"}, 2)

		If _nOpc == 2
		Return
		EndIf

	FWMsgRun(, {|oSay| LerArqCsv(oSay) },'Aguarde', 'Processando arquivo...')

Return

Static Function LerArqCsv(oSay)

	Local _cArquivo := ""
	Local _aDados   := {}
	Local _cLin     := ""
	Local _cAux     := ""
	Local _aCodLj   := ""
	Local xi        := 0
	Local oModel    := FWModelActive()
	Local oStruZLL  := oModel:GetModel("ZLLDETAIL")
	Local oStruZLK  := oModel:GetModel( 'ZLKMASTER' )
	Local _nQtdLin  := oStruZLL:GetQTDLine()
	Local _nItem    := 1
	Local _nLinha   := 1
	Local _nTxAdm   := 0
	Local _nVlrTot  := 0
	Local _cErro    := ""

	//Recebe o Arquivo CSV
	_cArquivo := cGetFile( "Arquivo CSV (*.CSV) | *.CSV", "Selecione o arquivo para importa��o",,'C:\',.F., )

	If !File(_cArquivo)
		MsgStop("O arquivo " + _cArquivo + " n�o foi encontrado. A importa��o ser� abortada!","Aten��o")
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
					aAdd(_aDados,Separa(_cLin,";",.T.))
				EndIf
			 	FT_FSKIP()
			EndDo

			FT_FUSE()

			oSay:cCaption := "Ajustando dados para importa��o..."
			ProcessMessages()


			For xi := 1 To Len(_aDados)
			    //Retira Caracteres Especiais do CPF no Array

				If !Empty([xi,1])
					_cAux         := StrTran(_aDados[xi,1],"-","")
					_cAux         := StrTran(_cAux,".","")
					_cAux         := StrTran(_cAux,"/","")
					_aDados[xi,1] := _cAux

					//Retira espa�os e pontos do valor e altera a virgula para ponto para poder ser convertido de forma correta de caracter para num�rico
					_cAux         := AllTrim(_aDados[xi,2])
					_cAux         := StrTran(_cAux,".","")
					_cAux         := StrTran(_cAux,",",".")
					_aDados[xi,2] := Val(_cAux)
				EndIf
			Next i


			If Len(_aDados) == 0
				MsgStop("Nenhum registro a ser importado!","Aten��o")
			Else
				oSay:cCaption := "Preenchendo grid..."
				ProcessMessages()

				For xi := 1 To Len(_aDados)

					_aCodLj := RetCodLj(_aDados[xi,1])
					If !Empty(_aCodLj[1])
						IF _nLinha <= _nQtdLin
							oStruZLL:GoLine(_nLinha)
							IF oStruZLL:IsDeleted(_nLinha)
								oStruZLL:UnDeleteLine()
							ENDIF
						ELSE
							oStruZLL:AddLine()
						ENDIF

						oStruZLL:LoadValue("ZLL_SEQ",StrZero(_nItem,3))
						oStruZLL:LoadValue("ZLL_RETIRO",_aCodLj[1])
						oStruZLL:LoadValue("ZLL_RETILJ",_aCodLj[2])
						oStruZLL:LoadValue("ZLL_DCRRET",SubStr(_aCodLj[3],1,TamSx3("ZLL_DCRRET")[1]))
						oStruZLL:LoadValue("ZLL_VALOR",_aDados[xi,2])
						_nVlrTot += _aDados[xi,2]
						_nItem++
						_nLinha++
					Else
						_cErro += _aDados[xi,1]+" Valor: "+TransForm(_aDados[xi,2],"@E 999,999.99") + _ENTER
					EndIf
				Next xi
				oStruZLL:GoLine(1)

				//Atualiza campos do cabe�alho
				oStruZLK:LoadValue("ZLK_VLRTOT",_nVlrTot)
				_nTxAdm	:=_nVlrTot*(oStruZLK:GetValue("ZLK_PTXADM")/100)
				oStruZLK:LoadValue("ZLK_TXADM",_nTxAdm)

				If !Empty(_cErro)
					xMagHelpFis("Sem Codigo","Os c�digos abaixo n�o foram encontrados no cadastro de clientes e n�o ser�o importados.",_cErro)
				EndIf
			EndIf

		EndIf

	EndIf

Return Nil


Static Function RetCodLj(xcCodigo)

	Local _aRet := {"","",xcCodigo+" N�O ENCONTRADO"}
	Local _cAliCod := GetNextAlias()

	If Len(xcCodigo) < 11
		BeginSql alias _cAliCod
		SELECT A1_COD, MIN(A1_LOJA) AS A1_LOJA, A1_NOME
		FROM %Table:SA1% SA1
		WHERE A1_COD = %Exp:xcCodigo%
		AND A1_L_TPCLI IN ('P','T')
		AND A1_MSBLQL <> "1"
		AND SA1.%NotDel%
		GROUP BY A1_COD, A1_NOME
		EndSql
	Else
		BeginSql alias _cAliCod
		SELECT A1_COD, MIN(A1_LOJA) AS A1_LOJA, A1_NOME
		FROM %Table:SA1% SA1
		WHERE A1_CGC = %Exp:xcCodigo%
		AND A1_L_TPCLI IN ('P','T')
		AND A1_MSBLQL <> "1"
		AND SA1.%NotDel%
		GROUP BY A1_COD, A1_NOME
		EndSql
	EndIf

	If !(_cAliCod)->(Eof())
		_aRet[1] := (_cAliCod)->A1_COD
		_aRet[2] := (_cAliCod)->A1_LOJA
		_aRet[3] := (_cAliCod)->A1_NOME
	EndIf

	(_cAliCod)->(DbCloseArea())

Return _aRet


/*/{Protheus.doc} User Function GLT110TIT
	Gera t�tulos a pagar para os conv�nios com evento contando ZL8_GERNF = S
	@type  Function
	@author Guilherme Fran�a
	@since 09/06/2021
	@version version

	@example
	(examples)
	@see (links_or_references)
	/*/
User Function GLT110TIT(xOP)

	Local _lRet     := .f.
	Local _aArea    := GetArea()
	Local _aPerg    := {}
	Local _aRet     := {}
	Local ix        := 0
	Local _cTipoTit := PADR(Alltrim(GetMv("LT_CONVTIP")),3)
	Private _nCont  := 0

	dbSelectArea('ZL8')
	ZL8->(MsSeek(xFILIAL("ZL8")+ZLK->ZLK_EVENTO))

	If xOP == "I"

	//Cria perguntas
		aadd(_aPerg, {1, "Gerar prefixo:", ZL8->ZL8_PREFIX, "@!",   , "ZL6_01", ".T.", 30 , .T.}) //01
		aadd(_aPerg, {1, "Gerar Tipo:"   , _cTipoTit      , "@!", "", "05"    , ".T.", 30 , .T.}) //02
		aadd(_aPerg, {1, "Da emiss�o: "  , ZLK->ZLK_DATA  , ""  ,   , ""      , ".T.", 100, .T.}) //03
		aadd(_aPerg, {1, "At� emiss�o: " , ZLK->ZLK_DATA  , ""  ,   , ""      , ".T.", 100, .T.}) //04
		aadd(_aPerg, {1, "Do Conv�nio:"  , ZLK->ZLK_COD   , "@!",   , ""      , ".T.", 50 , .T.}) //05
		aadd(_aPerg, {1, "At� Conv�nio:" , ZLK->ZLK_COD   , "@!", "", ""      , ".T.", 50 , .T.}) //06


		If ParamBox(_aPerg, "Dados para gera��o de t�tulos", _aRet)
			For ix := 1 to Len(_aRet)
				If Empty(_aRet[ix])
					MsgStop("Informe todos os par�metros para continuar!","Valida��o Par�metros")
					Return
				EndIf
			Next ix
		// Inclus�o do Filtro do convenior de ate e gera��o via filial logada Data da Altera��o 29/03/2022
			DbSelectArea("ZLK")
			DbSetOrder(1)
			While ZLK_FILIAL = xFilial("ZLK") .and.ZLK->ZLK_COD >= _aRet[5] .and. ZLK->ZLK_COD <= _aRet[6] .and. ZLK->ZLK_DATA >= _aRet[3] .AND. ZLK->ZLK_DATA <= _aRet[4]

				FWMsgRun(, {|oSay|  _lRet := IncZLKSE2(oSay,_aRet) },'Aguarde', 'Gerando Titulos...')

					If !_lRet
						MsgAlert("Ocorream problemas na gera��o dos t�tulos!","Erro")
					Else
						If _nCont > 0
							MsgInfo(Alltrim(str(_nCont))+" T�tulos gerados com sucesso!","Confirma��o")
						Else
							MsgAlert("Nenhum conv�nio apto para gera��o de t�tulos!","Finalizado")
						EndIf
					EndIf
				ZLK->(DbSkip())
			EndDo
		EndIf
	Else
		aadd(_aPerg, {1, "Do Conv�nio:" , ZLK->ZLK_COD , "@!",   , "", ".T.", 50 , .T.}) //01
		aadd(_aPerg, {1, "At� Conv�nio:", ZLK->ZLK_COD , "@!", "", "", ".T.", 50 , .T.}) //02
		aadd(_aPerg, {1, "Da emiss�o: " , ZLK->ZLK_DATA, ""  ,   , "", ".T.", 100, .T.}) //03
		aadd(_aPerg, {1, "At� emiss�o: ", ZLK->ZLK_DATA, ""  ,   , "", ".T.", 100, .T.}) //04

		If ParamBox(_aPerg, "Dados para gera��o de t�tulos", _aRet)
			For ix := 1 to Len(_aRet)
				If Empty(_aRet[ix])
					MsgStop("Informe todos os par�metros para continuar!","Valida��o Par�metros")
					Return
				EndIf
			Next ix

			DbSelectArea("ZLK")
			DbSetOrder(1)
			While ZLK->ZLK_COD >= _aRet[1] .and. ZLK->ZLK_COD <= _aRet[2] .and. ZLK->ZLK_DATA >= _aRet[3] .AND. ZLK->ZLK_DATA <= _aRet[4]

				If !Empty(ZLK->ZLK_TITSE2)
					DbSelectArea("SE2")
					DbSetOrder(1)
					If MsSeek(ZLK->ZLK_TITSE2)
						If SE2->E2_VALOR == SE2->E2_SALDO
							Processa({|| _lRet := dElse2(SE2->E2_PREFIXO,SE2->E2_NUM,SE2->E2_PARCELA,SE2->E2_TIPO,SE2->E2_FORNECE,SE2->E2_LOJA,SE2->E2_NATUREZ) },"Excluindo t�tulo: "+ZLK->ZLK_TITSE2)
						Else
							_lRet := .f.
							MsgStop("O conv�nio "+ZLK->ZLK_COD+" "+ZLK->ZLK_NOME+" R$"+Transform(SE2->E2_VALOR,"@E 999,999.99")+" j� foi pago, e n�o pode ser exclu�do!","TITULO PAGO")
						EndIf
					EndIf
					If _lRet
						_nCont++
						Reclock("ZLK",.F.)
						ZLK->ZLK_STATUS := "A"
						ZLK->ZLK_TITSE2 := ""
						ZLK->ZLK_VLRPAG := 0
						ZLK->(MsUnLock())
					EndIf
				EndIf
				ZLK->(DbSkip())
			EndDo
			If _nCont > 0
				MsgInfo(Alltrim(str(_nCont))+" T�tulos exclu�dos com sucesso!","Confirma��o Exclus�o")
			Else
				MsgAlert("Nenhum conv�nio apto para exclus�o de t�tulos!","Finalizado")
			EndIf
		EndIf
	EndIf
	RestArea(_aArea)
Return

/*/{Protheus.doc} IncZLKSE2
	(long_description)
	@type  Static Function
	@author user
	@since date
	/*/
Static Function IncZLKSE2(oSay,xaRet)

	Local _lRet := .t.
	Local _cDtIni := DTOS(xaRet[3])
	Local _cDtFim := DTOS(xaRet[4])
	Local _cCodDe := xaRet[5]
	Local _cCodAte:= xaRet[6]
	Local _cAlias := GetNextAlias()
	Local _lIncSE2 := .T.

	BeginSql alias _cAlias

		SELECT ZLK_FILIAL, ZLK_COD, ZLK_DATA, ZLK_VENCON, ZLK_CONVEN, ZLK_LJCONV, ZLK_EVENTO ,ZLK_OBSERV, ZLK_TXADM, SUM(ZL.ZLL_VLRPAG) AS VLRPAG
		FROM %Table:ZLK% ZK
			JOIN %Table:ZLL%  ZL ON ZL.ZLL_FILIAL = ZK.ZLK_FILIAL AND ZL.ZLL_COD = ZK.ZLK_COD AND ZLL_STATUS <> 'A' AND ZL.%NotDel%
			JOIN %Table:ZL8% L8 ON L8.ZL8_COD = ZK.ZLK_EVENTO AND L8.ZL8_GERNFC = 'S' AND L8.%NotDel%
		WHERE ZLK_STATUS = 'A' AND ZLK_DATA BETWEEN %Exp:_cDtIni% AND %Exp:_cDtFim%
		AND ZLK_COD BETWEEN %Exp:_cCodDe% AND %Exp:_cCodAte%
		AND ZK.%NotDel%
		GROUP BY ZLK_FILIAL, ZLK_COD,ZLK_DATA, ZLK_VENCON,ZLK_CONVEN, ZLK_LJCONV, ZLK_EVENTO ,ZLK_OBSERV,ZLK_TXADM
		ORDER BY 1
	EndSql

	Begin Transaction

		While !(_cAlias)->(EOF()) .and. _lRet
			oSay:cCaption := "Processando conv�nio: "+(_cAlias)->ZLK_COD
			ProcessMessages()
			// Valida se existe algum produtor no conv�nio que ainda n�o foi fechado.
			_lIncSE2 := .T.
			DbSelectArea("ZLL")
			DbSetOrder(3)
			MsSeek((_cAlias)->ZLK_FILIAL+(_cAlias)->ZLK_COD)
			While !ZLL->(EOF()) .AND. ZLL->ZLL_COD == (_cAlias)->ZLK_COD
				If ZLL->ZLL_STATUS == "A"
					_lIncSE2 := .F.
					Exit
				EndIf
				ZLL->(DbSkip())
			Enddo
			// fim valida status ZLL

			If _lIncSE2
				dbSelectArea('ZL8')
				ZL8->(MsSeek(xFILIAL("ZL8")+(_cAlias)->ZLK_EVENTO))


				If !U_Inc_SE2(xaRet[1],(_cAlias)->ZLK_COD+"000","",xaRet[2],(_cAlias)->ZLK_CONVEN,(_cAlias)->ZLK_LJCONV,ZL8->ZL8_NATFRT,STOD((_cAlias)->ZLK_DATA),STOD((_cAlias)->ZLK_VENCON),;
						(_cAlias)->VLRPAG,0,(_cAlias)->ZLK_TXADM,"",(_cAlias)->ZLK_OBSERV,0,(_cAlias)->ZLK_EVENTO)
					_lRet := .F.
					MsgAlert("Ocorreu um erro na inclus�o dos t�tulos e todo o processo ser� desfeito!","RollBack")
					DisarmTransaction()
				Else
					_nCont++
					DbSelectArea("ZLK")
					DbSetOrder(1)
					MsSeek((_cAlias)->ZLK_FILIAL+(_cAlias)->ZLK_COD)
					RecLock("ZLK",.F.)

					ZLK->ZLK_STATUS := IIF((_cAlias)->VLRPAG == ZLK->ZLK_VLRTOT,"P","S")
					ZLK->ZLK_TITSE2 := SE2->E2_FILIAL+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO+SE2->E2_FORNECE+SE2->E2_LOJA
					ZLK->ZLK_VLRPAG := SE2->E2_VALOR - SE2->E2_DECRESC

					ZLK->(MsUnLock())

				EndIf
			EndIf
			(_cAlias)->(DBSkip())
		EndDo
		(_cAlias)->(DbCloseArea())
	End Transaction

Return _lRet



USER FUNCTION UPDZLLZLK()

	RpcSetType(3) //Informa ao Server que a RPC n�o consumir� licen�as
	RpcSetEnv("01","47")

	DbSelectArea("ZLK")
	DbGoTop()

	While !ZLK->(Eof())
		DbSelectArea("ZLL")
		DbSetOrder(3)
		If MsSeek(xFilial("ZLL")+ZLK->ZLK_COD)
			While !ZLL->(Eof()) .AND. ZLL->ZLL_COD ==  ZLK->ZLK_COD
				RecLock("ZLL",.F.)
				ZLL->ZLL_OBSERV := ZLK->ZLK_OBSERV
				ZLL->(MsUnLock())

				ZLL->(DbSkip())
			EndDo
		EndIf
		ZLK->(Dbskip())
	EndDo

	RpcClearEnv()

Return
