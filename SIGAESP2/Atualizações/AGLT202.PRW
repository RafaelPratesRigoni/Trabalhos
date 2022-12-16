#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} AGLT202
	Chama tela de parâmetros
	@type  User Function
	@author Ronilson Rodrigues
	@since 08/10/2021
	@version 12.1.27
	/*/
User Function AGLT202()

	Local aPergs	:= {}
	Private aRet	:= {}

	If RetCodUsr() $ GetMV("MV_YGRPRC")
		aAdd(aPergs, {1, "Data de "		, CToD("")						, '', '.T.', ''		, '.T.', 50,.T.})
		aAdd(aPergs, {1, "Data ate "	, CToD("")						, '', '.T.', ''		, '.T.', 50,.T.})
		aAdd(aPergs, {1, "Fornecedor"	, Space(TamSX3("A2_COD")[1])	, '', '.T.', 'SA2'	, '.T.', TAMSX3("A2_COD")[1],.F.})
		aAdd(aPergs, {1, "Loja"			, Space(TamSX3("A2_LOJA")[1])	, '', '.T.', ''		, '.T.', TAMSX3("A2_LOJA")[1],.F.})

		If ParamBox(aPergs , "Consultar Registros ", aRet)
			FWExecView("Correção de Grupo de Preço", "AGLT202", MODEL_OPERATION_UPDATE,, {|| .T.},, 50)
		EndIf
	Else
		FwAlertError("Sem permissão para acessar rotina.", "ACESSO EXCLUSIVO")
	EndIf

Return

/*/{Protheus.doc} ModelDef
	Constrói o modelo de dados
	@type  Static Function
	@author Ronilson Rodrigues
	@since 08/10/2021
	@version 12.1.27
	@return oModel, Object, Objeto do Modelo de Dados
/*/
Static Function ModelDef()

	Local oModel	:= Nil
	Local oStrCab	:= Nil
	Local oStrGrid	:= Nil

	oStrCab := FwFormModelStruct():New()
    oStrCab:AddTable('', { 'C_STRING1' }, "Produtos", {|| ''})
    oStrCab:AddField('String 01', 'Campo de texto', 'C_STRING1', 'C', 15)

	oStrGrid := FwFormModelStruct():New()
	oStrGrid:AddTable("", {"ZLD_DTCOLE"}, "GRID", {|| ""})
	oStrGrid:AddField(RetTitle("ZLD_DTCOLE")				, RetTitle("ZLD_DTCOLE")				, "ZLD_DTCOLE"	, "D", TamSX3("ZLD_DTCOLE")[1])
	oStrGrid:AddField(RetTitle("ZLD_RETIRO")				, RetTitle("ZLD_RETIRO")				, "ZLD_RETIRO"	, "C", TamSX3("ZLD_RETIRO")[1])
	oStrGrid:AddField(RetTitle("ZLD_RETILJ")				, RetTitle("ZLD_RETILJ")				, "ZLD_RETILJ"	, "C", TamSX3("ZLD_RETILJ")[1])
	oStrGrid:AddField(RetTitle("A2_NOME")					, RetTitle("A2_NOME")					, "A2_NOME"		, "C", TamSX3("A2_NOME")[1])
	oStrGrid:AddField(RetTitle("ZLD_GRPRC") + " Recebido"	, RetTitle("ZLD_GRPRC") + " Recebido"	, "ZLD_GRPRC"	, "C", TamSX3("ZLD_GRPRC")[1])
	oStrGrid:AddField(RetTitle("A2_L_LI_RO") + " Fornecedor", RetTitle("A2_L_LI_RO") + " Fornecedor", "A2_L_LI_RO"	, "C", TamSX3("A2_L_LI_RO")[1])
	oStrGrid:AddField(RetTitle("ZLD_QTDBOM")				, RetTitle("ZLD_QTDBOM")				, "ZLD_QTDBOM"	, "C", TamSX3("ZLD_QTDBOM")[1])
	oStrGrid:SetProperty("*"		, MODEL_FIELD_WHEN, {|| .F.})
	oStrGrid:SetProperty("ZLD_GRPRC", MODEL_FIELD_WHEN, {|| .T.})

	oModel := MPFormModel():New("MAGLT202")
	oModel:AddFields("CAB", , oStrCab,,, {|oModel| {""}})
	oModel:AddGrid("GRID", "CAB", oStrGrid, , , , , {|oModel| AGLT202A(oModel)})
	oModel:SetPrimaryKey({""})
	oModel:SetDescription("Dados da Recepção de Leite")
    oModel:SetActivate({|oModel| FwFldPut("C_STRING1", "FAKE", , oModel)})
	oModel:GetModel("GRID"):SetNoInsertLine(.T.)
	oModel:GetModel("GRID"):SetNoUpdateLine(.F.)
	oModel:GetModel("GRID"):SetNoDeleteLine(.T.)
	oModel:InstallEvent("CLSAGLT202", , CLSAGLT202():New())

	If !Empty(aRet[3])
		SetKey(VK_F4, {|| AGLT202B() })
	EndIf

Return oModel

/*/{Protheus.doc} ViewDef
	Constrói a visualização do modelo de dados
	@type  Static Function
	@author Ronilson Rodrigues
	@since 08/10/2021
	@version 12.1.27
	@return oView, Object, Objeto de Visualização do Modelo de Dados
/*/
Static Function ViewDef()

	Local oModel	:= FwLoadModel("AGLT202")
	Local oStrCab	:= FwFormViewStruct():New()
	Local oStrGrid	:= FwFormViewStruct():New()
	Local oView		:= FwFormView():New()

	oView:SetModel(oModel)

	oStrCab:AddField('C_STRING1', '01', 'String 01', 'Campo de texto',, 'C')

	oStrGrid:AddField("ZLD_DTCOLE"	, "01", RetTitle("ZLD_DTCOLE")					, RetTitle("ZLD_DTCOLE")				, , "D", PesqPict("ZLD", "ZLD_DTCOLE"))
	oStrGrid:AddField("ZLD_RETIRO"	, "02", RetTitle("ZLD_RETIRO")					, RetTitle("ZLD_RETIRO")				, , "C", PesqPict("ZLD", "ZLD_RETIRO"))
	oStrGrid:AddField("ZLD_RETILJ"	, "03", RetTitle("ZLD_RETILJ")					, RetTitle("ZLD_RETILJ")				, , "C", PesqPict("ZLD", "ZLD_RETILJ"))
	oStrGrid:AddField("A2_NOME"		, "04", RetTitle("A2_NOME")						, RetTitle("A2_NOME")					, , "C", PesqPict("SA2", "A2_NOME"))
	oStrGrid:AddField("ZLD_GRPRC"	, "05", RetTitle("ZLD_GRPRC") + " Recebido"		, RetTitle("ZLD_GRPRC") + " Recebido"	, , "C", PesqPict("ZLD", "ZLD_GRPRC"))
	oStrGrid:AddField("A2_L_LI_RO"	, "06", RetTitle("A2_L_LI_RO") + " Fornecedor"	, RetTitle("A2_L_LI_RO") + " Fornecedor", , "C", PesqPict("SA2", "A2_L_LI_RO"))
	oStrGrid:AddField("ZLD_QTDBOM"	, "07", RetTitle("ZLD_QTDBOM")					, RetTitle("ZLD_QTDBOM")				, , "C", PesqPict("ZLD", "ZLD_QTDBOM"))
	oStrGrid:SetProperty("*"		, MVC_VIEW_CANCHANGE, .F.)
	oStrGrid:SetProperty("ZLD_GRPRC", MVC_VIEW_CANCHANGE, .T.)
	oStrGrid:SetProperty("ZLD_GRPRC", MVC_VIEW_LOOKUP	, "ZL3_01")

	oView:AddField("VIEW_CAB", oStrCab	, "CAB")
	oView:AddGrid("VIEW_GRID", oStrGrid	, "GRID")
	oView:CreateHorizontalBox("BOX_CAB"	, 000)
	oView:CreateHorizontalBox("BOX_GRID", 100)
	oView:SetOwnerView("VIEW_CAB"	, "BOX_CAB")
	oView:SetOwnerView("VIEW_GRID"	, "BOX_GRID")
	oView:SetDescription("Dados da Recepção de Leite")
	oView:EnableTitleView("VIEW_GRID", "Dados de Recepção de Leite")

	If !Empty(aRet[3])
		oView:AddUserButton("Atualizar Grupo Preço", "S4WB010N", {|| AGLT202B()}, "Atualizar Grupo Preço")
	EndIf

Return oView

/*/{Protheus.doc} AGLT202A
	Recupera dados para carregamento da grid
	@type  Static Function
	@author Ronilson Rodrigues
	@since 08/10/2021
	@version 12.1.27
	@param oModel, Object, Objeto do Modelo de Dados
	@return aDados, Array, Lista de dados para preenchimento da grid
/*/
Static Function AGLT202A(oModel)

	Local aDados	:= {}
	Local cSQL		:= ""

	cSQL := "SELECT ZLD_DTCOLE, ZLD_RETIRO, ZLD_RETILJ, A2_NOME, ZLD_GRPRC, A2_L_LI_RO, ZLD_QTDBOM, ZLD.R_E_C_N_O_ AS RECNO"
	cSQL += " FROM " + RetSQLName("ZLD") + " ZLD"
	cSQL += " INNER JOIN " + RetSQLName("SA2") + " SA2"
	cSQL += "	ON	SA2.D_E_L_E_T_ = ' '"
	cSQL += "	AND A2_FILIAL = " + ValToSQL(FwFilial("SA2"))
	cSQL += "	AND A2_COD = ZLD_RETIRO"
	cSQL += "	AND A2_LOJA = ZLD_RETILJ"
	cSQL += " WHERE	ZLD.D_E_L_E_T_ = ' '"
	cSQL += "	AND ZLD_FILIAL = " + ValToSQL(FwFilial("ZLD"))
	cSQL += "	AND ZLD_DTCOLE BETWEEN " + ValToSQL(aRet[1]) + " AND " + ValToSQL(aRet[2])

	If Empty(aRet[3])
		cSQL += "	AND ZLD_GRPRC <> A2_L_LI_RO"
	Else
		cSQL += "	AND ZLD_RETIRO = " + ValToSQL(aRet[3])
		cSQL += "	AND ZLD_RETILJ = " + ValToSQL(aRet[4])
	EndIf

	cSQL += " ORDER BY ZLD_DTCOLE"

	TCQuery ChangeQuery(cSQL) New Alias qZLD

	qZLD->(dbGoTop())

	While !qZLD->(EOF())
		aAdd(aDados, {qZLD->RECNO,;
			{;
				SToD(qZLD->ZLD_DTCOLE),;
				qZLD->ZLD_RETIRO,;
				qZLD->ZLD_RETILJ,;
				qZLD->A2_NOME,;
				qZLD->ZLD_GRPRC,;
				qZLD->A2_L_LI_RO,;
				qZLD->ZLD_QTDBOM;
			}})

		qZLD->(dbSkip())
	EndDo

	qZLD->(dbCloseArea())

Return aDados

/*/{Protheus.doc} AGLT202B
	Atribuí a todos os registros o Grupo de Preço informado
	@type  Static Function
	@author Ronilson Rodrigues
	@since 08/10/2021
	@version 12.1.27
/*/
Static Function AGLT202B()

	Local oActive	:= FwModelActive()
	Local oGrid		:= oActive:GetModel("GRID")
	Local cGrPrc	:= ""
	Local nLine		:= oGrid:GetLine()
	Local nI		:= 0

	If FwMsgYesNo("Deseja inserir para todos os registros o mesmo Grupo Preço?", "Editar Todos")
		cGrPrc := FWInputBox("Informe o Novo Grupo Preço", "")

		If !Empty(cGrPrc)
			For nI := 1 To oGrid:Length()
				oGrid:GoLine(nI)

				If !oGrid:SetValue("ZLD_GRPRC", cGrPrc)
					aError := oActive:GetErrorMessage()
					Help(, , aError[5], , aError[6], 1, 0, , , , , , {aError[7]})
					Return
				EndIf
			Next nI

			oGrid:GoLine(nLine)
		EndIf
	EndIf

Return


/*/{Protheus.doc} CLSAGLT202
	Classe de eventos do modelo
	@author Ronilson Rodrigues
	@since 01/12/2022
	@version 12.1.33
	/*/
Class CLSAGLT202 From FwModelEvent

	Method New()
	Method GridLinePreVld(oModel, cIDModel, nLine, cAction, cIDField, xValue, xCurrValue)
	Method AfterTTS(oModel, cIDModel)

EndClass

/*/{Protheus.doc} New
	Método construtor da classe
	@author Ronilson Rodrigues
	@since 01/12/2022
	@version 12.1.33
	/*/
Method New() Class CLSAGLT202

Return

/*/{Protheus.doc} GridLinePreVld
	Pré-validação de linha da grid
	@author Ronilson Rodrigues
	@since 01/12/2022
	@version 12.1.33
	@param oModel, Object, Objeto do Modelo de Dados
	@param cIDModel, Character, ID do modelo
	@param nLine, Numeric, Linha posicionada
	@param cAction, Character, Ação em execução
	@param cIDField, Character, ID do campo que sofreu a ação
	@param xValue, Undefined, Valor que está sendo atribuído ao campo
	@param xCurrValue, Undefined, Valor atual do campo
	@return lRet, Logical, Retorno da validação
	/*/
Method GridLinePreVld(oModel, cIDModel, nLine, cAction, cIDField, xValue, xCurrValue) Class CLSAGLT202

	Local lRet		:= .T.
	Local cProblema	:= ""
	Local cSolucao	:= ""

	If cAction == "SETVALUE"
		If cIDField == "ZLD_GRPRC"
			If !Posicione("ZL3", 1, FwFilial("ZL3") + xValue, "FOUND()")
				cProblema	:= "Grupo Preço informado não está cadastrado."
				cSolucao	:= "Solicite o cadastro ou informe um cadastro existente."
				oModel:GetModel():SetErrorMessage(oModel:GetId(), cIDField, oModel:GetModel():GetId(), cIDField, "ERROR", cProblema, cSolucao)
			ElseIf xValue <> oModel:GetValue("A2_L_LI_RO")
				cProblema	:= "O Grupo de Preços informado na linha " + StrZero(nLine, 2) + " diverge do Grupo que está no cadastro do Fornecedor."
				cSolucao	:= "Reveja o cadastro de fornecedor se está correto."
				oModel:GetModel():SetErrorMessage(oModel:GetId(), cIDField, oModel:GetModel():GetId(), cIDField, "ERROR", cProblema, cSolucao)
			EndIf
		EndIf
	EndIf

	lRet := !oModel:GetModel():HasErrorMessage()

Return lRet

/*/{Protheus.doc} AfterTTS
	Método chamado durante o commit, após a transação
	@author Ronilson Rodrigues
	@since 01/12/2022
	@version 12.1.33
	@param oModel, Object, Objeto do Modelo de Dados
	@param cIDModel, Character, ID do Modelo de Dados
	/*/
Method AfterTTS(oModel, cIDModel) Class CLSAGLT202

	Local oGrid	:= oModel:GetModel("GRID")
	Local nI	:= 0

	dbSelectArea("ZLD")
	ZLD->(dbGoTop())
	For nI := 1 To oGrid:Length()
		oGrid:GoLine(nI)

		ZLD->(dbGoTo(oGrid:GetDataId()))

		If ZLD->ZLD_GRPRC <> oGrid:GetValue("ZLD_GRPRC")
			RecLock("ZLD", .F.)
			ZLD->ZLD_GRPRC := oGrid:GetValue("ZLD_GRPRC")
			ZLD->(MsUnlock())
		EndIf
	Next nI

Return