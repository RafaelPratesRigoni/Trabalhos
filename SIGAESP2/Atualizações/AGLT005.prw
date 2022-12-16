#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
/*/
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  � AGLT005  � Autor � TOTVS                 � Data da Criacao  � 16/09/2008                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Rotina desenvolvida para possibilitar o cadastramento de grupo de pre�os                                         ���
���          �                     												                               				���
���������������������������������������������������������������������������������������������������������������������������͹��
���Uso       � CADASTRO GRUPO DE PRE�OS               				                                                        ���
���������������������������������������������������������������������������������������������������������������������������͹��
���Parametros� Nenhum						   							                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Retorno   � Nenhum						  							                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Usuario   � Microsiga                                                                                					���
���������������������������������������������������������������������������������������������������������������������������͹��
���Setor     � Gestao do Leite.                                                                        						���
���������������������������������������������������������������������������������������������������������������������������͹��
���            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Autor     � Data     � Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor        ���
���������������������������������������������������������������������������������������������������������������������������ĺ��
���          �00/00/0000�                               				   �00-000000 -                       � TI	        ���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���          �          �                    							   �                                  � 			���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���������������������������������������������������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
/*/
User Function AGLT005()

	// Variaveis do Filtro
	Local aQuery		:= {}
	Local cCondicao		:= ""
	Local bFiltraBrw	:= {|| NIL }
	Private aRotina		:= MenuDef()
	Private cCadastro	:= "Cadastro Grupo de Pre�os - Gest�o Leite"
	Private cAlias		:= "ZL3"
	Private bExclui		:= {|| DelZL3() }
	Private bAltera		:= {|| AltZL3() }

	// Seta filtro
	cCondicao  := u_FilSetor("ZL3_SETOR") // retorna condicao
	bFiltraBrw := {|| FilBrowse(cAlias,@aQuery,@cCondicao) }
	Eval(bFiltraBrw)

	mBrowse( 6, 1,22,75,cAlias,,,,,,)

	//Finaliza o filtro
	EndFilBrw(cAlias,aQuery)

Return


/*/
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  �MenuDef   � Autor � Jeovane               � Data da Criacao  � 11/09/2008                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Funcao usada para criar menu da tela MBrowse de Recepcao de leite                                            ���
���          �                  												                               				���
���������������������������������������������������������������������������������������������������������������������������͹��
���Uso       � Implantacao das rotinas referente a Gestao do Leite.                						                    ���
���������������������������������������������������������������������������������������������������������������������������͹��
���Retorno   � Array com opcoes da rotina                                                                                   ���
���������������������������������������������������������������������������������������������������������������������������͹��
���Parametros�Parametros do array a Rotina:                               													���
���          �1. Nome a aparecer no cabecalho                             													���
���          �2. Nome da Rotina associada                                 													���
���          �3. Reservado                                                													���
���          �4. Tipo de Transa��o a ser efetuada:                        													���
���          � 	  1 - Pesquisa e Posiciona em um Banco de Dados           													���
���          �    2 - Simplesmente Mostra os Campos                       													���
���          �    3 - Inclui registros no Bancos de Dados                 													���
���          �    4 - Altera o registro corrente                         													���
���          �    5 - Remove o registro corrente do Banco de Dados        													���
���          �5. Nivel de acesso                                          													���
���          �6. Habilita Menu Funcional                                                                                    ���
���������������������������������������������������������������������������������������������������������������������������͹��
���Retorno   � Array com opcoes da rotina	  							                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Usuario   � Microsiga                                                                                					���
���������������������������������������������������������������������������������������������������������������������������͹��
���Setor     � Gestao do Leite.                                                                        						���
���������������������������������������������������������������������������������������������������������������������������͹��
���            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Autor     � Data     � Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor        ���
���������������������������������������������������������������������������������������������������������������������������ĺ��
���          �          �                               				   �                                  �   	        ���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���          �          �                    							   �                                  � 			���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���������������������������������������������������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
/*/
Static Function MenuDef()

	Private aRotina	:=  {;
		{OemToAnsi("Pesquisar"),"AxPesqui"  , 0 , 1,0,.F.},;
		{OemToAnsi("Visualizar"),"AxVisual", 0 , 2,0,nil},;
		{OemToAnsi("Atualiza Pre�os"),"U_AGLT044()", 0 , 4,0,.F.},; //Altera pre�o negociado dos produtores do grupo selecionado.
		{OemToAnsi("Incluir"),"AxInclui", 0 , 3,0,nil},;
		{OemToAnsi("Alterar"),"Eval(bAltera)", 0 , 4,0,.F.},; //{OemToAnsi("Alterar"),"AxAltera", 0 , 4,0,.F.},;
		{OemToAnsi("Excluir"),"Eval(bExclui)", 0 , 5,0,.F.}}

Return (aRotina)

/*/
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  �delZL3    � Autor � Jeovane               � Data da Criacao  � 11/09/2008                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Funcao usada para apagar registro da ZL3 - Verifica integridade com tabela ZLD - Recepacao de Leite          ���
���          �                  												                               				���
���������������������������������������������������������������������������������������������������������������������������͹��
���Uso       � Implantacao das rotinas referente a Gestao do Leite.                						                    ���
���������������������������������������������������������������������������������������������������������������������������͹��
���Parametros� Nenhum						   							                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Retorno   � Nenhum						  							                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Usuario   � Microsiga                                                                                					���
���������������������������������������������������������������������������������������������������������������������������͹��
���Setor     � Gestao do Leite.                                                                        						���
���������������������������������������������������������������������������������������������������������������������������͹��
���            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Autor     � Data     � Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor        ���
���������������������������������������������������������������������������������������������������������������������������ĺ��
���          �          �                               				   �                                  �   	        ���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���          �          �                    							   �                                  � 			���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���������������������������������������������������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
/*/
Static Function delZL3()

	Local aArea  := GetArea()

	//Verifica se existem Fornecedores e Recpecao de Leite relacionados a este setor
	If U_chkZLD("ZLD_GRPRC",ZL3->ZL3_COD)
		RecLock("ZL3",.F.)
		ZL3->(DbDelete())
		MsUnLock()
	EndIf

	RestArea(aArea)

Return

/*/
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  � AltZL3   � Autor � Jeovane               � Data da Criacao  � 11/09/2008                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Funcao usada para alterar registro da ZL3.                                                                   ���
���          �                  												                               				���
���������������������������������������������������������������������������������������������������������������������������͹��
���Uso       � Implantacao das rotinas referente a Gestao do Leite.                						                    ���
���������������������������������������������������������������������������������������������������������������������������͹��
���Parametros� Nenhum						   							                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Retorno   � Nenhum						  							                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Usuario   � Microsiga                                                                                					���
���������������������������������������������������������������������������������������������������������������������������͹��
���Setor     � Gestao do Leite.                                                                        						���
���������������������������������������������������������������������������������������������������������������������������͹��
���            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Autor     � Data     � Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor        ���
���������������������������������������������������������������������������������������������������������������������������ĺ��
���          �          �                               				   �                                  �   	        ���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���          �          �                    							   �                                  � 			���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���������������������������������������������������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
/*/

Static Function AltZL3()

	Local aArea  := GetArea()
	Local cAlias := "ZL3"
	Local nReg   := ZL3->(recno())
	Local nOpc   := 4
	Local nEsc   := 0 //Escolha
	Local cEntr1 := ZL3->ZL3_FILENT

	nEsc := AxAltera(cAlias,nReg,nOpc)

	//Se clicou em OK e a filial de entrega anterior eh diferente da atual
	If nEsc == 1 .And. cEntr1 <> ZL3->ZL3_FILENT
		GrvZLG(cEntr1)//Grava a nova filial de entrega
	EndIf

	RestArea(aArea)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � GrvZLG   � Autor � Microsiga          � Data �  28/09/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GrvZLG(cEntr2)

	Local aArea := GetArea()
	Local dVenc := CTOD("")
	Local nMes  := Val(SubStr(DTOS(dDataBase),5,2))-1
	Local nAno  := Val(SubStr(DTOS(dDataBase),1,4))

	// Pega data de 1 mes atras
	If nMes<=0
		nMes := 12
		nAno := Val(SubStr(DTOS(dDataBase),1,4))-1
	EndIf
	dVenc := LastDay(STOD(ALLTRIM(STR(nAno))+StrZero(nMes,2)+"01")) //Ultimo dia do mes anterior

	//Posiciona no Log de Linha versus Filial
	dbSelectArea("ZLG")
	dbSetOrder(1)//ZLG_FILIAL+ZLG_COD+ZLG_VENCTO
	If dbSeek(XFILIAL("ZLG")+ZL3->ZL3_COD+DTOS(dVenc))
		dbSelectArea("ZLG")
		RecLock("ZLG",.F.)
		ZLG->ZLG_FILENT := cEntr2//Pega do alias e nao da memoria para considerar a filial antiga
		MsUnLock()
	Else
		dbSelectArea("ZLG")
		RecLock("ZLG",.T.)
		ZLG->ZLG_FILIAL := xFILIAL("ZLG")
		ZLG->ZLG_COD    := ZL3->ZL3_COD
		ZLG->ZLG_DESCRI := ZL3->ZL3_DESCRI
		ZLG->ZLG_FILENT := cEntr2//Pega do alias e nao da memoria para considerar a filial antiga
		ZLG->ZLG_VENCTO	:= dVenc
		MsUnLock()
	EndIf

	RestArea(aArea)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � ValZLG   � Autor � Microsiga          � Data �  28/09/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function ValZLG()

	Local aArea := GetArea()
	Local lRet  := .T.
	Local cDt1  := SubStr(DTOS(dDataBase),1,6)+"01"//Pega o primeiro dia do mes
	Local cDt2  := DTOS(LastDay(STOD(cDt1))) //Pega ultimo dia do mes atual
	Local nReg  := 0

	cQuery := "SELECT COUNT(*) AS TOTAL FROM " + RetSqlName("ZLD")
	cQuery += " WHERE D_E_L_E_T_ = ' '"
	cQuery += " AND ZLD_FILIAL = '"+xFILIAL("ZLD")+"' "
	cQuery += " AND ZLD_DTCOLE BETWEEN '" + cDt1 + "' AND '" + cDt2 + "'"
	TCQUERY cQuery NEW ALIAS "TMP1"
	dbSelectArea("TMP1")

	If TMP1->(!Eof())
		nReg := TMP1->TOTAL
	EndIf

	TMP1->(dbCloseArea())

	//Se o dia for diferente do dia 01 de cada mes, nao deixa alterar
	If nReg > 0
		lRet := .F.
		xMagHelpFis("Dia Invalido",;
		"Na data atual, existe Recep��o de Leite lan�ada, consequentemente n�o � permitido mudar a Filial de entrega.",;
		"Para mudar a filial de entrega, voc� deve entrar com a data do sistema no m�s subsequente a �ltima recep��o de leite." )
	EndIf

	RestArea(aArea)

Return(lRet)


User function VINCPLI()

	Local aCampos1		:= {{"FLAG"   ,"C",2,0 },{"CODIGO"   ,"C",6,0 },{"LOJA"   ,"C",2,0 },{"NOME"   ,"C",40,0 },{"GRUPO"   ,"C",40,0}}
	Local oTempTable	:= Nil
	Private lInverte 	:= .F.
	Private cMarca   	:= Getmark()

	oTempTable := FwTemporaryTable():New("AD2", aCampos1)
	oTempTable:Create()

	_lvinc := .f.

	If msgyesno("Mostra somente vinculados?")
		_lvinc := .t.
	Endif

	cQuer4 := ""
	cQuer4 := "SELECT A2_COD,A2_LOJA,A2_NOME,A2_L_TANQ,A2_L_LI_RO FROM " + RetSqlName("SA2") + " SA2 "
	cQuer4 += " WHERE A2_FILIAL = '" + xfilial("SA2") + "'"
	If _lvinc
		cQuer4 += " AND A2_L_LI_RO = '" + ZL3->ZL3_COD +"'"
	Else
		cQuer4 += " AND (A2_L_LI_RO = ' ' OR A2_L_LI_RO = '"+ZL3->ZL3_COD+"')"
	Endif
	cQuer4 += " AND A2_MSBLQL <> '1' "
	cQuer4 += " AND (SA2.D_E_L_E_T_ = ' ')"

	cQuer4 += " AND A2_L_TPFOR = 'P' "
	cQuer4 += " ORDER BY A2_COD,A2_LOJA"

	If Select("TRAB5") <> 0
		TRAB5->(dbCloseArea())
	Endif

	TcQuery ChangeQuery(cQuer4) New Alias "TRAB5"

	dbSelectArea("TRAB5")
	TRAB5->(dbGoTop())
	While TRAB5->(!Eof())
		RecLock("AD2",.T.)

		If TRAB5->A2_L_LI_RO == ZL3->ZL3_COD
			AD2->FLAG := cMarca
		Endif

		AD2->CODIGO := TRAB5->A2_COD
		AD2->LOJA := TRAB5->A2_LOJA
		AD2->NOME := TRAB5->A2_NOME
		AD2->GRUPO := TRAB5->A2_L_LI_RO
		AD2->(MsUnlock())

		TRAB5->(dbSkip())
	Enddo

	TRAB5->(Dbclosearea())

	//monta tela de sele��o de empresa para replicar as contas
	DEFINE MSDIALOG oDlg TITLE 'LINHA: '+ZL3->ZL3_COD FROM 00,00 TO 360,600 PIXEL

	aCpoBro := {}
	AADD(aCpoBro, {"FLAG" ,""," "    , })
	AADD(aCpoBro, {"CODIGO" ,"","Codigo"    , })
	AADD(aCpoBro, {"LOJA" ,"","Loja"    , })
	AADD(aCpoBro, {"NOME" ,"","Nome"    , })
	AADD(aCpoBro, {"GRUPO" ,"","Grp.Pre�o"    , })

	Dbselectarea('AD2')
	AD2->(Dbgotop())

	oMark := MsSelect():New("AD2","FLAG","",aCpoBro,@lInverte,@cMarca,{15, 05, 180, 300})

	ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{||nopca:=1,oDlg:End(),atuavinc()},{||nOpca:=0,oDlg:End()}) CENTERED

	Dbselectarea("AD2")
	AD2->(dbCloseArea())
	oTempTable:Delete()

return

static function atuavinc()

	Dbselectarea('AD2')
	AD2->(Dbgotop())
	While AD2->(!Eof())
		dbSelectArea( "SA2" )
		If SA2->(dbseek(xfilial('SA2')+AD2->(CODIGO+LOJA)))
			RecLock("SA2",.F.)

			If empty(AD2->FLAG)
				SA2->A2_L_LI_RO := space(6)
			Else
				SA2->A2_L_LI_RO := ZL3->ZL3_COD
			Endif

			SA2->(MsUnlock())
		Endif
		dbSelectArea("AD2")
		AD2->(dbSkip())
	Enddo

return