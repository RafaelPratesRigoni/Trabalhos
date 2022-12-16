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
Static cTitulo := "Cadastro Analise da Qualidade"
  
/*
===============================================================================================================================
Programa----------: AGLT115
Autor-------------: Cláudio Gonçalves
Data da Criacao---: 12/02/2021
===============================================================================================================================
Descrição---------: Lançamento de análise de qualidade em MVC - Evolução do AGLT015
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
 
User Function AGLT115()

    Local aArea   := GetArea()
    Local oBrowse
      
    //Cria um browse para a ZAF
    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias("ZLB")
    oBrowse:SetDescription(cTitulo)
    //Legenda
    oBrowse:AddLegend( "ZLB->ZLB_DESQUA <> 'S'", "GREEN", "Qualificada")
    oBrowse:AddLegend( "ZLB->ZLB_DESQUA == 'S'", "RED", "Desqualificada")

    oBrowse:Activate()
      
    RestArea(aArea)

Return Nil

/*
===============================================================================================================================
Programa----------: MenuDef
Autor-------------: Cláudio Gonçalves
Data da Criacao---: 12/02/2021
===============================================================================================================================
Descrição---------: MenuDef
===============================================================================================================================
Parametros--------: 
===============================================================================================================================
Retorno-----------: 
===============================================================================================================================
*/
 
Static Function MenuDef()
    Local aRot := {}
      
    //Adicionando opções
    ADD OPTION aRot TITLE 'Visualizar' ACTION 'VIEWDEF.AGLT115' OPERATION 1   ACCESS 0 //OPERATION 1
    ADD OPTION aRot TITLE 'Incluir'    ACTION 'VIEWDEF.AGLT115' OPERATION 3  ACCESS 0 //OPERATION 3
    ADD OPTION aRot TITLE 'Alterar'    ACTION 'VIEWDEF.AGLT115' OPERATION 4 ACCESS 0 //OPERATION 4
    ADD OPTION aRot TITLE 'Relatório Análises'    ACTION 'U_RGLT012()'   OPERATION 4 ACCESS 0 //OPERATION 4
    ADD OPTION aRot TITLE 'Excluir'    ACTION 'VIEWDEF.AGLT115' OPERATION 5 ACCESS 0 //OPERATION 5
    ADD OPTION aRot TITLE 'Rel.Previsao Pgto.'    ACTION 'U_RGLT013()'   OPERATION 4 ACCESS 0 //OPERATION 4
    ADD OPTION aRot TITLE 'Precificar Análise'      ACTION 'U_AGLT15VL()'   OPERATION 4 ACCESS 0 //OPERATION 4
    ADD OPTION aRot TITLE 'Desqualifica Análise'    ACTION 'U_AGLT15DESC()' OPERATION 4 ACCESS 0 //OPERATION 4
    ADD OPTION aRot TITLE 'Excluir Laudo'           ACTION 'U_EXCLAUDO()'   OPERATION 4 ACCESS 0 //OPERATION 4

Return aRot

/*
===============================================================================================================================
Programa----------: ModelDef
Autor-------------: Cláudio Gonçalves
Data da Criacao---: 12/02/2021
===============================================================================================================================
Descrição---------: ModelDef
===============================================================================================================================
Parametros--------: 
===============================================================================================================================
Retorno-----------: 
===============================================================================================================================
*/
Static Function ModelDef()
   
    Local oModel      := NIL
    Local oStruCab     := FWFormStruct(1, 'ZLB', {|cCampo| AllTRim(cCampo) $ "ZLB_FILIAL;ZLB_SETOR;ZLB_DCRSET;ZLB_DATA;ZLB_LAUDO;ZLB_HORA;ZLB_ETIQTA;ZLB_RETIRO;ZLB_RETILJ;ZLB_DCRRET;ZLB_CODTRF"})
    Local oStruGrid := fModStruct()

    //Ajusta propriedades dos campos
    SetPropM(oStruCab, oStruGrid)
 
    //Monta o modelo de dados, e na Pós Validação, informa a função fValidGrid
    oModel := MPFormModel():New('AGLT115_MVC', /*bPreValidacao*/, /*{|oModel| fValidGrid(oModel)}*/, /*bCommit*/, /*bCancel*/ )
 
    //Agora, define no modelo de dados, que terá um Cabeçalho e uma Grid apontando para estruturas acima
    oModel:AddFields('MdFieldZLB', NIL, oStruCab)
    oModel:AddGrid('MdGridZLB', 'MdFieldZLB', oStruGrid, , )
 ;;"
    //Monta o relacionamento entre Grid e Cabeçalho, as expressões da Esquerda representam o campo da Grid e da direita do Cabeçalho
    oModel:SetRelation('MdGridZLB', {;
            {'ZLB_FILIAL', 'xFilial("ZLB")'},;
            {"ZLB_SETOR",  "ZLB_SETOR"},;
            {"ZLB_DCRSET", "ZLB_DCRSET"},;
            {"ZLB_DATA",  "ZLB_DATA"},;
            {"ZLB_LAUDO",  "ZLB_LAUDO"},;
            {"ZLB_HORA",  "ZLB_HORA"},;
            {"ZLB_ETIQTA",  "ZLB_ETIQTA"},;
            {"ZLB_RETIRO",  "ZLB_RETIRO"},;
            {"ZLB_RETILJ",  "ZLB_RETILJ"},;
            {"ZLB_DCRRET",  "ZLB_DCRRET"};
        }, ZLB->(IndexKey(1)))
     
    //Definindo outras informações do Modelo e da Grid
    oModel:GetModel("MdGridZLB"):SetMaxLine(9999)
    oModel:SetDescription(cTitulo)
    oModel:SetPrimaryKey({"ZLB_FILIAL", "ZLB_RETIRO", "ZLB_RETILJ", "DTOS(ZLB_DATA)"})
 
Return oModel
 
 /*
===============================================================================================================================
Programa----------: ViewDef
Autor-------------: Cláudio Gonçalves
Data da Criacao---: 12/02/2021
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
    Local oModel    := FWLoadModel('AGLT115')
    Local oStruCab  := FWFormStruct(2, "ZLB", {|cCampo| AllTRim(cCampo) $ "ZLB_FILIAL;ZLB_SETOR;ZLB_DCRSET;ZLB_DATA;ZLB_LAUDO;ZLB_HORA;ZLB_ETIQTA;ZLB_RETIRO;ZLB_RETILJ;ZLB_DCRRET;ZLB_CODTRF"})
    Local oStruGRID := fViewStruct()
 
    //Define que no cabeçalho não terá separação de abas (SXA)
    oStruCab:SetNoFolder()
 
    //Cria o View
    oView:= FWFormView():New() 
    oView:SetModel(oModel)              
 
    //Cria uma área de Field vinculando a estrutura do cabeçalho com MDFieldZAF, e uma Grid vinculando com MdGridZAF
    oView:AddField('VIEW_ZLB', oStruCab, 'MdFieldZLB')
    oView:AddGrid ('GRID_ZLB', oStruGRID, 'MdGridZLB' )
 
    //O cabeçalho (MAIN) terá 25% de tamanho, e o restante de 75% irá para a GRID
    oView:CreateHorizontalBox("MAIN", 35)
    oView:CreateHorizontalBox("GRID", 65)
 
    //Vincula o MAIN com a VIEW_ZAF e a GRID com a GRID_ZAF
    oView:SetOwnerView('VIEW_ZLB', 'MAIN')
    oView:SetOwnerView('GRID_ZLB', 'GRID')
    oView:EnableControlBar(.T.)
 
    //Define o campo incremental da grid como o ZAF_ITEM
    //oView:AddIncrementField('GRID_ZLB', 'ZLB_ITEM')
Return oView
 
/*
===============================================================================================================================
Programa----------: fModStruct
Autor-------------: Cláudio Gonçalves
Data da Criacao---: 12/02/2021
===============================================================================================================================
Descrição---------: Função chamada para montar o modelo de dados da Grid
===============================================================================================================================
Parametros--------: 
===============================================================================================================================
Retorno-----------: 
===============================================================================================================================
*/

Static Function fModStruct()
    Local oStruct
    oStruct := FWFormStruct(1, 'ZLB')
Return oStruct

/*
===============================================================================================================================
Programa----------: fViewStruct
Autor-------------: Cláudio Gonçalves
Data da Criacao---: 12/02/2021
===============================================================================================================================
Descrição---------: Função chamada para montar a visualização de dados da Grid
===============================================================================================================================
Parametros--------: 
===============================================================================================================================
Retorno-----------: 
===============================================================================================================================
*/ 

Static Function fViewStruct()
    Local cCampoCom := "ZLB_TIPOFX;ZLB_DCRTPF;ZLB_VLRANA;ZLB_DESQUA;ZLB_FILENT;ZLB_CODLAB;ZLB_VLRDIN"
    Local oStruct
 
    //Irá filtrar, e trazer todos os campos, menos os que tiverem na variável cCampoCom
    oStruct := FWFormStruct(2, "ZLB", {|cCampo| (Alltrim(cCampo) $ cCampoCom)})
Return oStruct
 
/*
===============================================================================================================================
Programa----------: fValidGrid
Autor-------------: Cláudio Gonçalves
Data da Criacao---: 12/02/2021
===============================================================================================================================
Descrição---------: Função que faz a validação da grid
===============================================================================================================================
Parametros--------: 
===============================================================================================================================
Retorno-----------: 
===============================================================================================================================
*/ 

Static Function fValidGrid(oModel)
    Local lRet     := .T.
    Local nDeletados := 0
    Local nLinAtual :=0
    Local oModelGRID := oModel:GetModel('MdGridZLB')
    Local oModelMain := oModel:GetModel('MdFieldZLB')
    Local nValorMain := oModelMain:GetValue("ZAF_VALOR")
    Local nValorGrid := 0
    Local cPictVlr   := PesqPict('ZAF', 'ZAF_VALOR')
 
    //Percorrendo todos os itens da grid
    For nLinAtual := 1 To oModelGRID:Length() 
        //Posiciona na linha
        oModelGRID:GoLine(nLinAtual) 
         
        //Se a linha for excluida, incrementa a variável de deletados, senão irá incrementar o valor digitado em um campo na grid
        If oModelGRID:IsDeleted()
            nDeletados++
        Else
            nValorGrid += NoRound(oModelGRID:GetValue("ZAF_TCOMB"), 4)
        EndIf
    Next nLinAtual
 
    //Se o tamanho da Grid for igual ao número de itens deletados, acusa uma falha
    If oModelGRID:Length()==nDeletados
        lRet :=.F.
        Help( , , 'Dados Inválidos' , , 'A grid precisa ter pelo menos 1 linha sem ser excluida!', 1, 0, , , , , , {"Inclua uma linha válida!"})
    EndIf
 
    If lRet
        //Se o valor digitado no cabeçalho (valor da NF), não bater com o valor de todos os abastecimentos digitados (valor dos itens da Grid), irá mostrar uma mensagem alertando, porém irá permitir salvar (do contrário, seria necessário alterar lRet para falso)
        If nValorMain != nValorGrid
            //lRet := .F.
            MsgAlert("O valor do cabeçalho (" + Alltrim(Transform(nValorMain, cPictVlr)) + ") tem que ser igual o valor dos itens (" + Alltrim(Transform(nValorGrid, cPictVlr)) + ")!", "Atenção")
        EndIf
    EndIf
 
Return lRet

/*
===============================================================================================================================
Programa----------: SetPropM
Autor-------------: Cláudio Gonçalves
Data da Criacao---: 12/02/2021
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
    oStruGrid:SetProperty("*", MODEL_FIELD_OBRIGAT, .F.)
    //oStruGrid:SetProperty("ZLB_TIPOFX", MODEL_FIELD_OBRIGAT, .T.)
    //oStruGrid:SetProperty("ZLB_VLRANA", MODEL_FIELD_OBRIGAT, .T.)
	
	//Validações de campos do cabeçalho
	oStruCab:SetProperty( 'ZLB_RETIRO'	, MODEL_FIELD_VALID,{|| GERAGRID() } )

Return

/*
===============================================================================================================================
Programa----------: SetPropM
Autor-------------: Cláudio Gonçalves
Data da Criacao---: 12/02/2021
===============================================================================================================================
Descrição---------: Preenche grid com produtores da rota selecionada.
===============================================================================================================================
Parametros--------: 
===============================================================================================================================
Retorno-----------: 
===============================================================================================================================
*/ 

Static Function GERAGRID()

Local oModel 	:= FWModelActive() 
Local oModelGRID := oModel:GetModel('MdGridZLB')
Local oModelMain := oModel:GetModel('MdFieldZLB')
Local oView 	:= FWViewActive()               
Local _cAlias := GetNextAlias()
Local nLinAtu	:= 0
Local _nItem	:= 1	
Local _nQtdLin := oModelGRID:GetQTDLine()
Local _nLinha	:= 1
Local xi := 0

If _nQtdLin > 1
    FOR xi := 1 TO _nQtdLin
    oModelGRID:GoLine(xi)
    oModelGRID:DeleteLine()		
    NEXT
EndIf

IncProc("Localizando Faixas...")                                    


	BeginSql Alias _cAlias

    SELECT ZL9_COD, ZL9_DESCRI, ZL9_CODLAB
    FROM %Table:ZL9% ZL9
    WHERE ZL9.%NotDel%
    AND ZL9_MSBLQL <> '1'
    AND ZL9_TIPO = 'Q'
    ORDER BY ZL9_DESCRI
	
	EndSql

	If !(_cAlias)->(Eof())
		While !(_cAlias)->(Eof())

			IF _nLinha <= _nQtdLin
				oModelGRID:GoLine(_nLinha)
				IF oModelGRID:IsDeleted(_nLinha)
					oModelGRID:UnDeleteLine()
				ENDIF
			ELSE
				oModelGRID:AddLine()
			ENDIF

			oModelGRID:SetValue("ZLB_TIPOFX",(_cAlias)->ZL9_COD)
			oModelGRID:SetValue("ZLB_CODLAB",(_cAlias)->ZL9_CODLAB)            
			//oModelGRID:LoadValue("ZLB_DCRTPF",(_cAlias)->ZL9_DESCRI)

			(_cAlias)->(DbSkip())
			_nItem++
			_nLinha++
		EndDo
		oModelGRID:GoLine(1)
	Else
		MsgInfo("Não foram encontradas faixas ativas ")
	Endif

	(_cAlias)->(DBCLOSEAREA())

Return .T.
