#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

#DEFINE _ENTER CHR(13)+CHR(10)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ AGLT015  º Autor ³ TOTVS                 º Data da Criacao  ³ 12/09/2008                						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina desenvolvida para possibilitar o cadastramento de Motoristas dos veiculos utilizados na coleta de     º±±
±±º          ³ leite nos retiros.  												                               				º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Cadastro de Veiculos.           						                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ Nenhum						   							                               						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ Nenhum						  							                               						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUsuario   ³ Microsiga                                                                                					º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºSetor     ³ Gestao do Leite.                                                                        						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL                   						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor     ³ Data     ³ Motivo da Alteracao  				               ³Usuario(Filial+Matricula+Nome)    ³Setor        º±±
±±ºÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄº±±
±±º          ³00/00/0000³                               				   ³00-000000 -                       ³ TI	        º±±
±±º----------³----------³--------------------------------------------------³----------------------------------³-------------º±±
±±º          ³          ³                    							   ³                                  ³ 			º±±
±±º----------³----------³--------------------------------------------------³----------------------------------³-------------º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function AGLT015

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Declaracao de Variaveis                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Private aRotina   := MenuDef()
	Private cCadastro := "Cadastro Analise da Qualidade"
	Private cAlias    := "ZLB"
	Private aCores      := GetCores()
	Private bLegenda	:= {|| legenda()  }

	mBrowse( 6, 1,22,75,cAlias,,,,,,aCores)

Return

Static Function Legenda(aCores)

	Local aLegenda := {}

	aAdd(aLegenda,{"BR_VERDE"   ,"Qualificada"}) //Sem Status
	aAdd(aLegenda,{"BR_VERMELHO"   ,"Desqualificada"}) //Sem Status
	BrwLegenda(cCadastro,"Legenda",aLegenda) //"Legenda"

Return

Static Function GetCores()
	Local aCores:= {;
	{ 'ZLB->ZLB_DESQUA=="N"', 'BR_VERDE'		},;
	{ 'ZLB->ZLB_DESQUA=="S"', 'BR_VERMELHO'		}}

Return aCores


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ MenuDef  ³ Autor ³ Microsiga             ³ Data ³00/00/0000³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Utilizacao de Menu Funcional                               ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Array com opcoes da rotina                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Array aRotina:                                              ³±±
±±³          ³                                                            ³±±
±±³          ³1. Nome a aparecer no cabecalho                             ³±±
±±³          ³2. Nome da Rotina associada                                 ³±±
±±³          ³3. Reservado                                                ³±±
±±³          ³4. Tipo de Transa‡„o a ser efetuada:                        ³±±
±±³          ³ 	  1 - Pesquisa e Posiciona em um Banco de Dados           ³±±
±±³          ³    2 - Simplesmente Mostra os Campos                       ³±±
±±³          ³    3 - Inclui registros no Bancos de Dados                 ³±±
±±³          ³    4 - Altera o registro corrente                          ³±±
±±³          ³    5 - Remove o registro corrente do Banco de Dados        ³±±
±±³          ³5. Nivel de acesso                                          ³±±
±±³          ³6. Habilita Menu Funcional                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ AGLT014()                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MenuDef()

	Private aRotina	:=  {{OemToAnsi("Pesquisar"),"AxPesqui", 0,1,0,.F.},;
	{OemToAnsi("Visualizar"),"AxVisual" , 0 , 2,0,nil},;
	{OemToAnsi("Incluir")   ,"AxInclui" , 0 , 3,0,nil},;
	{OemToAnsi("Alterar")   ,"AxAltera" , 0 , 4,0,.F.},;
	{OemToAnsi("Precificar Análise")   ,"U_AGLT15VL()" , 0 , 4,0,.F.},;
	{OemToAnsi("Desqualifica Análise")   ,"U_AGLT15DESC()" , 0 , 4,0,.F.},;
	{OemToAnsi("Excluir")   ,"AxDeleta" , 0 , 5,0,.F.},;
	{OemToAnsi("Excluir Laudo")   ,"U_EXCLAUDO()" , 0 , 4,0,.F.},;
	{OemToAnsi("Legenda")   ,"Eval(bLegenda)", 0 , 2 ,0 ,.F.} }//"Legenda"
Return (aRotina)

/*/{Protheus.doc} EXCLAUDO
@Description
@author
@since  	 11/02/2021
/*/

User Function EXCLAUDO()

	Local _cLaudo := ZLB->ZLB_LAUDO
	Local _cData := DTOS(ZLB->ZLB_DATA)
	Local _cSetor := ZLB->ZLB_SETOR
	Local _nCont := 0

	If MsgYesNo("Confirma exclusao de todas as analises do laudo: "+_cLaudo,"Exclusão Laudo")
		DbSelectArea("ZLB")
		DbSetOrder(2)
		MsSeek(FWxFilial("ZLB")+_cSetor+_cData+_cLaudo)
		While !ZLB->(Eof())
			If ZLB->ZLB_LAUDO == _cLaudo
				RecLock("ZLB",.F.)
				ZLB->(DBDelete())
				ZLB->(MsUnLock())
				_nCont++
			EndIf
			ZLB->(DbSkip())
		EndDo
		MsgInfo("Foram excluidos "+StrZero(_nCont,3)+" registros de análises!","Finalizado")

	EndIf

Return


/*/{Protheus.doc} AGLT15VL
@Description
@author
@since  	 11/02/2021
/*/
User Function AGLT15VL()

	Local _cTexto := ""
	Local _cPerg := "AGLT15VL"
	Local _nRet := 0

	_cTexto := " Este função irá processar as análises encontradas de acordo"+_ENTER
	_cTexto += " com os parâmetros e gravar seus respectivos valores financeiros"+_ENTER
	_cTexto += " baseados no Cadastro de Faixas atual. "+_ENTER

	If Pergunte(_cPerg,.T.)

		_nRet := AVISO("Precificação Qualidade", _cTexto, {"Executar","Fechar" }, 2)

		If _nRet == 1
			Processa({|| GravaVlr() },"Aguarde processando...")
		EndIf
	EndIf

Return

/*/{Protheus.doc} GravaVlr()
	(long_description)
	@type  Static Function
	@author user
	@since date
	@version version
	@param param, param_type, param_descr
	@return return, return_type, return_description
	@example
	(examples)
	@see (links_or_references)
	/*/
Static Function GravaVlr()

	Local _aArea := GetArea()
	Local cQuery := " "
	Local _cAlias := GetNextAlias()
	Local _nReg := 0
	Local _nCont := 0

	cQuery := " SELECT R_E_C_N_O_ AS RECZLB FROM " + RetSqlName("ZLB") + " ZLB "
	cQuery += " WHERE  "
	cQuery += " ZLB_FILIAL = '"+xFilial("ZLB")+"'  "
	cQuery += " AND ZLB_SETOR = '"+MV_PAR01+"'  "
	cQuery += " AND ZLB_DATA BETWEEN '"+DTOS(MV_PAR02)+"' AND '"+DTOS(MV_PAR03)+"'   "
	cQuery += " AND ZLB_RETIRO BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"'   "
	cQuery += " AND ZLB_TIPOFX BETWEEN '"+MV_PAR07+"' AND '"+MV_PAR08+"'   "
	If !Empty(MV_PAR04)
		cQuery += " AND ZLB_LAUDO = '"+MV_PAR04+"'  "
	EndIf
	cQuery += " AND D_E_L_E_T_ = ' ' "
	cQuery += " ORDER BY ZLB_DATA"

	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), _cAlias, .T., .F. )

	DbSelectArea(_cAlias)
	Count To _nReg
	ProcRegua(_nReg)

	(_cAlias)->(DbGoTop())

	While !(_cAlias)->(Eof())
		_nCont++

		IncProc("Processando análise : " + ALLTRIM(STR(_nCont)) + " de " + ALLTRIM(STR(_nReg)))

		DbSelectArea("ZLB")
		ZLB->(DbGoTo((_cAlias)->RECZLB))
		RecLock("ZLB",.F.)
		ZLB->ZLB_VLRDIN := u_getFaixa(xFILIAL("ZLA"),,ZLB->ZLB_TIPOFX,ZLB->ZLB_VLRANA)
		ZLB->(MsUnLock())

		(_cAlias)->(DbSkip())
	EndDo

	(_cAlias)->(DbCloseArea())

	MsgInfo("Foram precificados "+StrZero(_nCont,3)+" registros de análises!","Finalizado")

	RestArea(_aArea)

Return

/*/{Protheus.doc} AGLT15DESC
@Description
@author
@since  	 11/02/2021
/*/
User Function AGLT15DESC()

	Local _cTexto := ""
	Local _cPerg := "AGLT15DESC"
	Local _nRet := 0

	_cTexto := " Este função irá processar as análises encontradas de acordo"+_ENTER
	_cTexto += " com os parâmetros informados. "+_ENTER
	_cTexto += " Os produtores com mais de uma análise no período terão seus resultados "+_ENTER
	_cTexto += " comparados em valor financeiro, somando o valor das faixas informadas "+_ENTER
	_cTexto += " para agrupamento."
	_cTexto += " O laudo por produtor que obtiver o maior valor financeiro será mantido para o"+_ENTER
	_cTexto += " processo de pagamentos, e os demais serão marcados como desqualificados. "+_ENTER

	If Pergunte(_cPerg,.T.)
		_nRet := AVISO("Desqualifica Análises", _cTexto, {"Executar","Fechar" }, 2)

		If _nRet == 1
			Processa({|| Desqualifica() },"Aguarde processando...")
		EndIf
	EndIf

Return

/*/{Protheus.doc} Desqualifica()
	(long_description)
	@type  Static Function
	@author user
	@since date
	@version version
	@param param, param_type, param_descr
	@return return, return_type, return_description
	@example
	(examples)
	@see (links_or_references)
	/*/
Static Function Desqualifica()

	Local _aArea := GetArea()
	Local cQuery := " "
	Local _cAlias := GetNextAlias()
	Local _nReg := 0
	Local _nCont := 0
	Local _cFiltro := FormatIn(SubStr(MV_PAR06,1,Len(MV_PAR06)-1),"/")
	Local _cCodPro := ""
	Local _aCompara := {}
	Local ix := 0

	cQuery := " SELECT ZLB_RETIRO AS CODPRO , ZLB_RETILJ AS LOJA , ZLB_LAUDO AS LAUDO, SUM(ZLB_VLRDIN) AS VALOR "
	cQuery += " FROM " + RetSqlName("ZLB") + " ZLB "
	cQuery += " WHERE "
	cQuery += " ZLB_FILIAL = '"+xFilial("ZLB")+"'  "
	cQuery += " AND ZLB_SETOR = '"+MV_PAR01+"'  "
	cQuery += " AND ZLB_DATA BETWEEN '"+DTOS(MV_PAR02)+"' AND '"+DTOS(MV_PAR03)+"'   "
	cQuery += " AND ZLB_RETIRO BETWEEN '"+MV_PAR04+"' AND '"+MV_PAR05+"'   "
	cQuery += " AND ZLB_TIPOFX IN  "+_cFiltro+" "
	cQuery += " AND D_E_L_E_T_ = ' ' "
	cQuery += " GROUP BY ZLB_RETIRO , ZLB_RETILJ, ZLB_LAUDO "
	cQuery += " ORDER BY 1,2 "

	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), _cAlias, .T., .F. )

	DbSelectArea(_cAlias)
	Count To _nReg
	ProcRegua(_nReg)

	(_cAlias)->(DbGoTop())

	While !(_cAlias)->(Eof())

		_cCodPro := (_cAlias)->CODPRO+(_cAlias)->LOJA
		_aCompara := {}

		While !(_cAlias)->(Eof()) .AND. ( _cCodPro == (_cAlias)->CODPRO+(_cAlias)->LOJA )

			aadd(_aCompara,{(_cAlias)->LAUDO,(_cAlias)->CODPRO,(_cAlias)->LOJA,(_cAlias)->VALOR})

			(_cAlias)->(DbSkip())
		EndDo

		If Len(_aCompara) > 1
			aSort(_aCompara,,,{|x,y| x[4] > y[4] }) //Ordena pela coluna de valor, o maior valor
			_cChave := ""
			For ix := 2 to Len(_aCompara)
				_cChave := _aCompara[ix][1]+_aCompara[ix][2]+_aCompara[ix][3]
				DbSelectArea("ZLB")
				DbSetOrder(4)
				ZLB->(MSSeek(xFilial("ZLB")+_cChave))
				While !ZLB->(Eof()) .and. (_cChave == (ZLB->ZLB_LAUDO+ZLB->ZLB_RETIRO+ZLB->ZLB_RETILJ))
					If ZLB->ZLB_DATA >= MV_PAR02  .AND. ZLB->ZLB_DATA <= MV_PAR03

						_nCont++
						IncProc("Processando análise : " + ALLTRIM(STR(_nCont)) + " de " + ALLTRIM(STR(_nReg)))
						RecLock("ZLB",.F.)
						ZLB->ZLB_DESQUA := "S"
						ZLB->(MsUnLock())

						ZLB->(DbSkip())
					EndIf
				EndDo
			Next ix
		EndIf

	EndDo

	(_cAlias)->(DbCloseArea())

	MsgInfo("Foram desqualificadas "+Alltrim(Str(_nCont))+" registros de análises!","Finalizado")

	RestArea(_aArea)

Return