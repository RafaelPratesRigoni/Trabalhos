#INCLUDE "PROTHEUS.CH"
#DEFINE LINHAS 999
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ AGLT019  º Autor ³ TOTVS                 º Data da Criacao  ³ 31/10/2008                						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina desenvolvida para possibilitar visualizar os Eventos dos produtores.                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Visualiza Eventos por produtor.			                                                                    º±±
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
User Function AGLT019()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define Variaveis Local                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local aQuery     := {}
	Local cCondicao  := " A2_L_TPFOR $ 'P/G/T'"
	Local bFiltraBrw := {|| NIL }

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define Variaveis Private                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Private aRotina    := MenuDef()
	Private cCadastro  := OemToAnsi("Eventos por Produtor")
	Private cAlias     := "SA2"
	Private bVisualiza := {|| GLTVisual('SA2',SA2->(Recno()),1)}
	Private bImprime   := {|| GLTImprime()}
	Private cPerg      := "AGLT019"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Chama a tela para preenchimento dos parametros.                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Pergunte(cPerg,.T.)
		Return()
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona no cadastro do MIX.                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea("ZLE")
	DbSetOrder(1)
	If DbSeek(xFILIAL("ZLE")+MV_PAR01)
		DbSelectArea("ZLF")
		DbSetOrder(1)
		DbSeek(xFILIAL("ZLF")+ZLE->ZLE_COD,.T.)
	Else
		MsgAlert("Codigo de MIX não encontrado!","Alerta")
		Return
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se o Arquivo Esta Vazio                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !ChkVazio(cAlias)
		Return( NIL )
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Realiza o Filtro                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	bFiltraBrw := {|| FilBrowse(cAlias,@aQuery,@cCondicao) }
	Eval(bFiltraBrw)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Endereca a funcao de BROWSE                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea(cAlias)
	mBrowse( 6, 1,22,75,cAlias,,"A2_MSBLQL=='1'",,,,)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Encerra o filtro da tabela.                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	EndFilBrw(cAlias,aQuery)

Return( NIL )

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
±±³ Uso      ³ AGLT001()                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MenuDef()

	Private aRotina	:=  {{OemToAnsi("Pesquisar"),"AxPesqui", 0,1,0,.F.},;
	{OemToAnsi("Visualizar"),'Eval(bVisualiza)' , 0 , 2,0,nil},;
	{OemToAnsi("Imprimir"),'Eval(bImprime)' , 0 , 6,,,.F.}}

Return (aRotina)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³GLTVisual ³ Autor ³Microsiga              ³ Data ³ 00.00.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Funcao para Visualizar os eventos do produtor.             ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ AGLT001()                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GLTVisual(cAlias,nReg,nOpc)

	Local cTitulo    := "Eventos por Produtor"
	Local aObjects 	 := {}
	Local aPosObj    := {}
	Local aSize    	 := MsAdvSize()
	Local aInfo    	 := {aSize[1],aSize[2],aSize[3],aSize[4],3,3}
	Local nOffSet    := 0
	Local _ni		:= 0
	Local nI		:= 0
	Local aSX3		:= {}
	Private cSeek     := xFilial("ZLF")+MV_PAR01+SA2->A2_COD+SA2->A2_LOJA
	Private cMIX      := ZLE->ZLE_COD
	Private dDataIni  := ZLE->ZLE_DTINI
	Private dDataFim  := ZLE->ZLE_DTFIM
	Private cSetor	  := ZLF->ZLF_SETOR
	Private cDescSet  := ZLF->ZLF_DCRSET
	Private cLinRot	  := ZLF->ZLF_LINROT
	Private cDcrLR    := ZLF->ZLF_DCRLIN
	Private cTipoLR   := ZLF->ZLF_TP_RL
	Private cProdutor := ZLF->ZLF_RETIRO
	Private cLoja	  := ZLF->ZLF_RETILJ
	Private cNome	  := ZLF->ZLF_DCRRET
	Private nQtdBom   := ZLF->ZLF_QTDBOM
	Private nVlrLtr   := ZLF->ZLF_VLRLTR
	Private nVlrTot   := ZLF->ZLF_QTDBOM*ZLF->ZLF_VLRLTR
	Private nVlrCre   := 0
	Private nVlrDeb   := 0
	Private nSldLiq   := 0
	Private bVldLin	  := {|| GLTlinOK()}
	Private bVldTela  := {|| GLTtudoOk()}
	Private lFlat     := .F.
	Private aButtons  := If(Type("aButtons") == "U", {}, aButtons)
	Private nPosRetiro,nPosLoja,nPosProdu,nPosLocal,nPosQtdBom,nPosQtdAcid,nPosNomRet
	Private oDlg,oLteBom,oLteAci,oSetor,oLinRota,oDif
	Private aHeader[0]
	Private aCols[0]

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria aHeader.                                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nUsado:=0
	aSX3 := FwSX3Util():GetAllFields("ZLF")

	For nI := 1 To Len(aSX3)
		If aSX3[nI] $ "ZLF_EVENTO#ZLF_DCREVE#ZLF_DEBCRE#ZLF_TOTAL"
			nUsado++

			aAdd(aHeader, {							;
				GetSX3Cache(aSX3[nI], "X3_TITULO")	,;
				aSX3[nI]							,;
				GetSX3Cache(aSX3[nI], "X3_PICTURE")	,;
				GetSX3Cache(aSX3[nI], "X3_TAMANHO")	,;
				GetSX3Cache(aSX3[nI], "X3_DECIMAL")	,;
				GetSX3Cache(aSX3[nI], "X3_VALID")	,;
				GetSX3Cache(aSX3[nI], "X3_USADO")	,;
				GetSX3Cache(aSX3[nI], "X3_TIPO")	,;
				GetSX3Cache(aSX3[nI], "X3_ARQUIVO")	,;
				GetSX3Cache(aSX3[nI], "X3_CONTEXT")	,;
				GetSX3Cache(aSX3[nI], "X3_RELACAO")	,;
				GetSX3Cache(aSX3[nI], "X3_RESERV")	;
			})

			wVar  := "M->"+aSX3[nI]
			&wVar := CriaVar(aSX3[nI])
		EndIf
	Next nI

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria aCols.                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aCols:={}
	DbSelectArea("ZLF")
	DbSetOrder(1)
	DbSeek(cSeek,.T.)
	While ZLF->(!Eof()) .And. ZLF->ZLF_FILIAL==xFilial("ZLF");
		.And. ZLF->ZLF_CODZLE == MV_PAR01;
		.And. ZLF->ZLF_RETIRO == SA2->A2_COD;
		.And. ZLF->ZLF_RETILJ == SA2->A2_LOJA

		AADD(aCols,Array(nUsado+1))
		For _ni:=1 to nUsado
			aCols[Len(aCols),_ni] := If(aHeader[_ni,10] # "V",FieldGet(FieldPos(aHeader[_ni,2])),CriaVar(aHeader[_ni,2]))
		Next
		aCols[Len(aCols),nUsado+1]:=.F.

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Calcula o valor liquido a pagar para o produtor. ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ZLF->ZLF_DEBCRED == "C"
			nVlrCre += ZLF->ZLF_TOTAL
		Else
			nVlrDeb += ZLF->ZLF_TOTAL
		EndIf
		ZLF->(DbSkip())
	EndDo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ordena o Acols por Credito + Debitos.            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aSort(aCols,,,{|x,y| x[3] < y[3] })

	AADD(aObjects,{100,055,.T.,.F.,.T.})
	AADD(aObjects,{100,100,.T.,.T.})
	AADD(aObjects,{100,002,.T.,.F.})

	nPosRetiro	:= ascan(aHeader,{|x| alltrim(x[2]) == "ZLF_RETIRO"})
	nPosLoja	:= ascan(aHeader,{|x| alltrim(x[2]) == "ZLF_RETILJ"})
	nPosQtdBom 	:= ascan(aHeader,{|x| alltrim(x[2]) == "ZLF_QTDBOM"})
	nPosQtdAcid	:= ascan(aHeader,{|x| alltrim(x[2]) == "ZLF_QTDACI"})
	nPosNomRet	:= ascan(aHeader,{|x| alltrim(x[2]) == "ZLF_DCRRET"})
	aPosObj     := MsObjSize(aInfo,aObjects)
	nSldLiq     := nVlrCre - nVlrDeb

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Tratamento para tema "Flat"³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If "P10" $ oApp:cVersion
		If (Alltrim(GetTheme()) == "FLAT") .Or. SetMdiChild()
			lFlat := .T.
			nOffSet := 7
		EndIf
	EndIf

	DEFINE MSDIALOG oDlg TITLE cTitulo OF oMainWnd PIXEL FROM aSize[7],0 TO aSize[6],aSize[5]

	@ 1.6,00.7 SAY "MIX"
	@ 1.5,04.7 MSGET cMIX Picture PesqPict("ZLE","ZLE_COD") Valid CheckSX3("ZLE_COD") .And.  VldUser('ZLE_COD') WHEN .F.
	@ 1.6,09.5 SAY "Data Inicio"
	@ 1.5,13.2 MSGET dDataIni Valid CheckSX3("ZLE_DTINI") .And. VldUser('ZLE_DTINI') WHEN .F.
	@ 1.6,20.0 SAY "Data Fim"
	@ 1.5,23.5 MSGET dDataFim Valid CheckSX3("ZLE_DTFIM") .And. VldUser('ZLE_DTFIM') WHEN .F.

	@ 2.6,00.7 SAY "Produtor"
	@ 2.5,04.7 MSGET cProdutor Valid CheckSX3("ZLF_RETIRO") .And.  VldUser('ZLF_RETIRO') WHEN .F.
	@ 2.5,07.5 MSGET cLoja     Valid CheckSX3("ZLF_RETILJ") .And.  VldUser('ZLF_RETILJ') WHEN .F.
	@ 2.5,13.2 MSGET cNome WHEN .F.

	@ 3.6,00.7 SAY "Linha/Rota"
	@ 3.5,04.7 MSGET oLinRota var cLinRot WHEN .F.
	@ 3.5,09.4 MSGET cDcrLR WHEN .F.
	@ 3.6,40.7 SAY "Tipo"
	@ 3.5,44.0 MSGET cTipoLR WHEN .F.

	@ 4.6,00.5 SAY "Setor"
	@ 4.5,04.7 MSGET oSetor var cSetor  WHEN .F.
	@ 4.5,09.4 MSGET cDescSet  WHEN .F.

	@ aPosObj[3,1]-nOffSet,005 SAY "Leite Bom" OF oDlg PIXEL
	@ aPosObj[3,1]-nOffSet,030 	MSGET nQtdBom Picture "@E 999,999" WHEN .F. SIZE 50,7 OF oDlg PIXEL
	@ aPosObj[3,1]-nOffSet,090 SAY "Vlr. Litro" OF oDlg PIXEL
	@ aPosObj[3,1]-nOffSet,120 MSGET nVlrLtr Picture "@E 999,999.9999" WHEN .F. SIZE 50,7 OF oDlg PIXEL
	@ aPosObj[3,1]-nOffSet,175 SAY "Total Leite" OF oDlg PIXEL
	@ aPosObj[3,1]-nOffSet,200 MSGET nVlrTot Picture "@E 999,999.99" WHEN .F. SIZE 50,7 OF oDlg PIXEL
	@ aPosObj[3,1]-nOffSet,260 SAY "Creditos" OF oDlg PIXEL
	@ aPosObj[3,1]-nOffSet,290 MSGET nVlrCre Picture "@E 999,999.99" WHEN .F. SIZE 50,7 OF oDlg PIXEL
	@ aPosObj[3,1]-nOffSet,375 SAY "Debitos" OF oDlg PIXEL
	@ aPosObj[3,1]-nOffSet,405 MSGET nVlrDeb Picture "@E 999,999.99" WHEN .F. SIZE 50,7 OF oDlg PIXEL
	@ aPosObj[3,1]-nOffSet,490 SAY "Saldo" OF oDlg PIXEL
	@ aPosObj[3,1]-nOffSet,520 MSGET nSldLiq Picture "@E 999,999.99" WHEN .F. SIZE 50,7 OF oDlg PIXEL

	oGet := MSGetDados():New(aPosObj[2,1]+20,aPosObj[2,2],aPosObj[2,3]-10,aPosObj[2,4],nOpc,"Eval(bVldLin)","Eval(bVldTela)","",.T.,NIL,NIL,NIL,LINHAS)

	ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{|| .T.,oDlg:End()},{||oDlg:End()},,aButtons)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³GLTlinOK  ³ Autor ³Microsiga              ³ Data ³ 00.00.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Funcao para validacao da linha do Acols.                   ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ AGLT001()                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GLTlinOK()
	Local lRet := .T.
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³GLTtudoOk ³ Autor ³Microsiga              ³ Data ³ 00.00.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Funcao para validacao da tela.                             ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ AGLT001()                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GLTtudoOk()
	Local lRet := .T.
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³GLTImprime³ Autor ³Microsiga              ³ Data ³ 00.00.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Funcao para Imprimir os eventos do produtor.               ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ AGLT001()                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GLTImprime()
Return