#include "protheus.ch"

#DEFINE _ENTER CHR(13)+CHR(10)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ AGLT044  º Autor ³ Guilherme França      º Data da Criacao  ³ 12/09/2017									º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Rotina para alteração dos preços negociados direto pela tela do grupo de preços.                                                                   º±±
±±º          ³                                                 																º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Gestao do Leite  							                                                        		º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ Nenhum						   							                               						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ Nenhum						  							                               						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUsuario   ³ Microsiga                                                                                					º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºSetor     ³ Gestao do Leite                                                                        						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL                   						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor     ³ Data     ³ Motivo da Alteracao  				               ³Usuario(Filial+Matricula+Nome)    ³Setor    	º±±
±±ºÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄº±±
±±º          ³00/00/0000³                               				   ³00-000000 -                       ³ TI	    	º±±
±±º----------³----------³--------------------------------------------------³----------------------------------³-------------º±±
±±º          ³          ³                    							   ³                                  ³ 			º±±
±±º----------³----------³--------------------------------------------------³----------------------------------³-------------º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/

User Function AGLT044()

	Local nI
	Local oDlg
	Local oButton1
	Local oButton2
	Local oButton3
	Local oButton4
	Local _cPeriod := SubStr(DTOS(MonthSub(dDataBase,1)),1,6)
	Local _cDtCerta := DTOC(LastDay(MonthSub(dDataBase,1)))
	Local nUsado := 0
	Local aSize	:= MsAdvSize(.f.)
	Local aObjects := {}
	Local aEdita := {}
	Local aSX3	:= {}

	DbSelectArea("ZLV")
	DbSetOrder(1)
	Count to _nReg
	If _nReg > 0
		If !ZLV->(MsSeek(xfilial("ZLV")+_cPeriod,.T.))
			MsgAlert("Não existe referência para o período selecionado!"+_ENTER;
					+"Entre no sistema com a data "+_cDtCerta,"Data Base")
			Return
		EndIf
	EndIf

	Private oGetDados
	Private bFildok		:= {|| FIELDOK()}
	Private oFont := TFont():New("MS Sans Serif",,018,,.T.,,,,,.F.,.F.)
	Private oFont1 := TFont():New("Arial",,019,,.T.,,,,,.F.,.F.)
	Private oFont2 := TFont():New("Arial",,018,,.F.,,,,,.F.,.F.)
	Private oVlrAnt := Nil
	Private oVlrAtu := Nil
	Private _nVlrAnt := 0
	Private _nVlrAtu := 0
	Private _nTQtdAtu := 0
	Private aHeader := {}
	Private aCols := {}
	Private aRotina := {{"Pesquisar", "AxPesqui", 0, 1},;
						{"Visualizar", "AxVisual", 0, 2},;
						{"Incluir", "AxInclui", 0, 3},;
						{"Alterar", "AxAltera", 0, 4},;
						{"Excluir", "AxDeleta", 0, 5}}


	aSX3 := {"A2_COD", "A2_LOJA", "A2_NOME"}

	For nI := 1 To Len(aSX3)
		nUsado++

		aAdd(aHeader, {							;
			GetSX3Cache(aSX3[nI], "X3_TITULO")	,;
			aSX3[nI]							,;
			GetSX3Cache(aSX3[nI], "X3_PICTURE")	,;
			GetSX3Cache(aSX3[nI], "X3_TAMANHO")	,;
			GetSX3Cache(aSX3[nI], "X3_DECIMAL")	,;
			GetSX3Cache(aSX3[nI], "X3_VALID")	,;
			""									,;
			GetSX3Cache(aSX3[nI], "X3_TIPO")	,;
			""									,;
			""									;
		})
	Next nI

	nUsado++
	aAdd(aHeader, {								;
		"Qtd.Anterior"							,;
		"ZLV_QTD"								,;
		PesqPict("ZLD","ZLD_TOTBOM")			,;
		GetSX3Cache("ZLV_QTD", "X3_TAMANHO")	,;
		GetSX3Cache("ZLV_QTD", "X3_DECIMAL")	,;
		GetSX3Cache("ZLV_QTD", "X3_VALID")		,;
		""										,;
		GetSX3Cache("ZLV_QTD", "X3_TIPO")		,;
		""										,;
		""										;
	})

	nUsado++
	aAdd(aHeader, {								;
		"Preço Anterior"						,;
		"ZLV_PRECO"								,;
		PesqPict("SA2","A2_L_ADICI")			,;
		GetSX3Cache("ZLV_PRECO", "X3_TAMANHO")	,;
		GetSX3Cache("ZLV_PRECO", "X3_DECIMAL")	,;
		GetSX3Cache("ZLV_PRECO", "X3_VALID")	,;
		""										,;
		GetSX3Cache("ZLV_PRECO", "X3_TIPO")		,;
		""										,;
		""										;
	})

	nUsado++
	aAdd(aHeader, {								;
		"Qtd. Atual"							,;
		"ZLD_TOTBOM"							,;
		GetSX3Cache("ZLD_TOTBOM", "X3_PICTURE")	,;
		GetSX3Cache("ZLD_TOTBOM", "X3_TAMANHO")	,;
		GetSX3Cache("ZLD_TOTBOM", "X3_DECIMAL")	,;
		GetSX3Cache("ZLD_TOTBOM", "X3_VALID")	,;
		""										,;
		GetSX3Cache("ZLD_TOTBOM", "X3_TIPO")	,;
		""										,;
		""										;
	})

	nUsado++
	aAdd(aHeader, {								;
		"Preço Negociado"						,;
		"A2_L_ADICI"							,;
		GetSX3Cache("A2_L_ADICI", "X3_PICTURE")	,;
		GetSX3Cache("A2_L_ADICI", "X3_TAMANHO")	,;
		GetSX3Cache("A2_L_ADICI", "X3_DECIMAL")	,;
		GetSX3Cache("A2_L_ADICI", "X3_VALID")	,;
		""										,;
		GetSX3Cache("A2_L_ADICI", "X3_TIPO")	,;
		""										,;
		""										;
	})

	nUsado++
	aAdd(aHeader, {								;
		"Adic.Prç.Extra"						,;
		"A2_L_EXTRA"							,;
		GetSX3Cache("A2_L_EXTRA", "X3_PICTURE")	,;
		GetSX3Cache("A2_L_EXTRA", "X3_TAMANHO")	,;
		GetSX3Cache("A2_L_EXTRA", "X3_DECIMAL")	,;
		GetSX3Cache("A2_L_EXTRA", "X3_VALID")	,;
		""										,;
		GetSX3Cache("A2_L_EXTRA", "X3_TIPO")	,;
		""										,;
		""										;
	})

	Aadd(aCols,Array(nUsado+1))

	For nI := 1 To nUsado
		aCols[1][nI] := CriaVar(aHeader[nI][2])
	Next

	aEdita := {"A2_L_ADICI","A2_L_EXTRA"}


	For nI:=1 to Len(aSize)
		aSize[nI] := aSize[nI] * 0.7
	Next nI

	AAdd( aObjects, { 100, 100, .T., .T. } )
	AAdd( aObjects, { 100, 100, .T., .T. } )
	AAdd( aObjects, { 100, 015, .T., .F. } )
	aInfo   := {aSize[1],aSize[2],aSize[3],aSize[4],3,3}
	aPosObj := MsObjSize(aInfo,aObjects)

	aSize[6] := aSize[6]*1.3


	DEFINE MSDIALOG oDlg TITLE "Alteração Preço Negociado" FROM aSize[7],aSize[2] TO aSize[6],aSize[5] PIXEL


	@ 01,01 SAY "Grupo: " FONT oFont1
	@ 01,05 SAY ZL3->ZL3_COD FONT oFont2

	@ 01,10 SAY "Descrição: " FONT oFont1
	@ 01,16 SAY ZL3->ZL3_DESCRI  FONT oFont2

	@ 01,33 SAY "Preço Médio Anterior" FONT oFont1
	@ 02,35 MSGET oVlrAnt VAR _nVlrAnt Picture "@E 99.9999" WHEN .F.  FONT oFont1

	@ 01,45 SAY "Preço Médio Atual" FONT oFont1
	@ 02,47 MSGET oVlrAtu VAR _nVlrAtu Picture "@E 99.9999" WHEN .F.  FONT oFont1


	@ aPosObj[2,1]*0.33, aPosObj[2,2]+20 BUTTON oButton3 PROMPT "&Fixar Valor" SIZE 050, 014 OF oDlg FONT oFont2 ACTION {|| _lRet:=EditPreco("F"),IIf(_lRet,oDlg:End(),)} PIXEL
	@ aPosObj[2,1]*0.33, aPosObj[2,2]+90 BUTTON oButton4 PROMPT "&Alterar Valores" SIZE 050, 014 OF oDlg FONT oFont2 ACTION {|| _lRet:=EditPreco("A"),IIf(_lRet,oDlg:End(),)} PIXEL

	oGetDados := MsGetDados():New(aPosObj[2,1]*0.6,aPosObj[2,2],aPosObj[2,3]*1.2,aPosObj[2,4], 4,/*"Eval(bLinhaOK)"*/,/*"Eval(bTudoOK)"*/,/*campo incremento */,.F.,aEdita,,.F.,200,"Eval(bFildok)",/*"Eval(bSuperDel)"*/,,/*"Eval(bDelOK)"*/,oDlg)

	CriaGrid() //Carrega o aCols
	oGetDados:Refresh()

	@ aPosObj[2,3]*1.3, aPosObj[2,2]+20 BUTTON oButton2 PROMPT "&Confirmar" SIZE 048, 014 OF oDlg FONT oFont2 ACTION {|| _lRet:=Salvar(),IIf(_lRet,oDlg:End(),)} PIXEL

	@ aPosObj[2,3]*1.3, aPosObj[2,4]-80 BUTTON oButton1 PROMPT "&Fechar" SIZE 048, 014 OF oDlg FONT oFont2 ACTION {|| oDlg:End()} PIXEL


	ACTIVATE MSDIALOG oDlg CENTERED

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CriaGrid	 º Autor ³ TOTVS              º Data ³  00/00/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Preenche o aCols com os produtores do grupo de preço.         º±±
±±º          ³                                                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CriaGrid()

	Local _cAlias := GetNextAlias()
	Local i := 0
	Local _nFieldPos := 0
	Local _nItem := 1
	Local _cPeriod := SubStr(DTOS(MonthSub(dDataBase,1)),1,6)
	Local _nQtdAtu := ""
	Local _nDtIni := FirstDay(dDataBase)
	Local _nCont1 := 0
	Local _nCont2 := 0
	Local _nTQtdAnt := 0
	Local _nVlrTAnt := 0
	Local _nVlrTAtu := 0
	Local _lOk := .f.

	_nTQtdAtu := 0

	BeginSql alias _cAlias

		SELECT A2_COD, A2_LOJA, A2_NOME, A2_L_ADICI,A2_L_FIDEL, A2_L_EXTRA, coalesce(ZLV_QTD,0) AS ZLV_QTD, coalesce(ZLV_PRECO,0) AS ZLV_PRECO

		FROM %Table:SA2% A2
			LEFT JOIN %Table:ZLV% ZLV ON ZLV_FILIAL = %XFilial:ZLV% AND ZLV_PERIOD = %Exp:_cPeriod%
			AND ZLV_SA2COD = A2_COD AND ZLV_SA2LJ = A2_LOJA AND ZLV.%NotDel%
		WHERE A2_L_LI_RO = %Exp:ZL3->ZL3_COD% AND A2_MSBLQL <> '1' AND A2_L_TPFOR = 'P'
		AND A2.%NotDel%
		ORDER BY ZLV_QTD DESC

	EndSql


	While !(_cAlias)->(Eof())

		If _nItem > 1
			aAdd(aCols, aClone(aCols[_nItem-1])) //Cria linha a ser editada.
		EndIf
		_lOk := .t.
		For i := 1 to Len(aHeader)

			_nFieldPos := (_cAlias)->(FieldPos(aHeader[i][2]))
			If _nFieldPos > 0
				_nColPos := ascan(aHeader,{|x| ALLTRIM(x[2]) == Field(_nFieldPos)  })
				GDFieldPut((_cAlias)->(Field(_nFieldPos)), (_cAlias)->(FieldGet(_nFieldPos)), _nItem)
			Else
				If aHeader[i][2] == "ZLD_TOTBOM"
					_nQtdAtu := U_VolLeite(xFilial("ZLD"),_nDtIni,dDataBase,,,(_cAlias)->A2_COD,(_cAlias)->A2_LOJA)
					GDFieldPut( "ZLD_TOTBOM",_nQtdAtu, _nItem)
					_nTQtdAtu +=_nQtdAtu
				EndIf
			EndIf
			If Alltrim(aHeader[i][2]) == "ZLV_QTD"
				_nTQtdAnt += (_cAlias)->ZLV_QTD
			EndIf

		Next i

		If (_cAlias)->ZLV_PRECO > 0
			_nCont1++
			_nVlrAnt += (_cAlias)->ZLV_PRECO
		EndIf

		If (_cAlias)->A2_L_ADICI > 0
			_nCont2++
			_nVlrAtu += (_cAlias)->A2_L_ADICI
		EndIf
		_nVlrTAnt += ( (_cAlias)->ZLV_QTD * (_cAlias)->ZLV_PRECO )
		_nVlrTAtu += ( _nQtdAtu * (_cAlias)->A2_L_ADICI )


		_nItem++


		(_cAlias)->(DbSkip())
	EndDo

	If _lOk
		_nCont1 := IIF(_nCont1==0,1,_nCont1)
		_nVlrAnt := _nVlrTAnt /_nTQtdAnt //_nVlrAnt / _nCont1
		oVlrAnt:Refresh()

		_nCont2 := IIF(_nCont2==0,1,_nCont2)
		_nVlrAtu := _nVlrTAtu/_nTQtdAtu // _nVlrAtu / _nCont2
		oVlrAtu:Refresh()

		aAdd(aCols, aClone(aCols[_nItem-1])) //Cria linha a ser editada.
		GDFieldPut( "A2_COD"," ", _nItem)
		GDFieldPut( "A2_LOJA"," ", _nItem)
		GDFieldPut( "A2_NOME",Space(20)+" -- Totais e Médias --", _nItem)
		GDFieldPut( "ZLV_QTD",_nTQtdAnt, _nItem)
		GDFieldPut( "ZLD_TOTBOM",_nTQtdAtu, _nItem)
		GDFieldPut( "ZLV_PRECO",_nVlrAnt, _nItem)
		GDFieldPut( "A2_L_ADICI",_nVlrAtu, _nItem)
	Else
		MsgAlert("Não foram localizados produtores amarrados a este grupo de preços!","GrupoVazio")
	EndIf


	(_cAlias)->(DbCloseArea())

Return

//#######################################
// FUNCAO DE VALIDAÇÃO DO CAMPO DIGITADO
//#######################################
Static Function FIELDOK()

	Local _cCampo := SubStr(ReadVar(),4,10)

	If Alltrim(_cCampo) == "A2_L_ADICI"
		AtuMedias("FOK")
	EndIf

Return .t.


//#######################################
// FUNCAO PARA EDIÇÃO DE TODOS OS PREÇOS
//#######################################
Static Function EditPreco(xOP)

	Local oDlg1
	Local _cTexto  := ""
	Local _nCont   := 0
	Local _nVlr    := 0
	Local _nMaior  := 0
	Local _nMenor  := 0
	Local _lExec   := .f.
	Local _nPosAdi := ascan(aHeader,{|x| ALLTRIM(x[2]) == "A2_L_ADICI" })
	Local y        := 0

	If xOP == "F"
		_cTexto := "Informe o valor que será fixado em todos os cadastros"
		_cTexto += "           para preço negociado."
	Else
		_cTexto := "Informe o valor positivo para somar ou negativo "+_ENTER
		_cTexto += "           para subtrair do preço atual"
	EndIf

	Define MSDialog oDlg1 Title "Edição dos preços em lote" From 0,0 TO 240,400 Pixel
	@ 002,008 Say _cTexto FONT oFont1 PIXEL OF oDlg1
	@ 025,080 Get _nVlr Size 40,15  Picture "@E 99.9999" when .T. PIXEL OF oDlg1
	@ 046,055 Say "-- Filtros para alteração --" FONT oFont1  PIXEL OF oDlg1
	@ 063,040 Say "Maior ou igual a:"  PIXEL OF oDlg1
	@ 062,082 Get _nMaior Size 40,10  Picture "@E 99.9999" when .T. PIXEL OF oDlg1
	@ 079,040 Say "Menor ou igual a:"  PIXEL OF oDlg1
	@ 078,082 Get _nMenor Size 40,10  Picture "@E 99.9999" when .T. PIXEL OF oDlg1
	@ 100,050 Button "&Salvar" SIZE 30,13 ACTION {|| _lExec:= .t.,oDlg1:End()} PIXEL OF oDlg1
	@ 100,120 Button "&Cancelar" SIZE 30,13 ACTION oDlg1:End() PIXEL OF oDlg1
	ACTIVATE DIALOG oDlg1 CENTERED

	If _lExec
		For y := 1 to (Len(aCols)-1)
			If xOP == "F"
				If aCols[y][_nPosAdi] >= _nMaior .and. aCols[y][_nPosAdi] <= _nMenor
					aCols[y][_nPosAdi] := _nVlr
					_nCont++
				EndIf
			Else
				If aCols[y][_nPosAdi] >= _nMaior .and. aCols[y][_nPosAdi] <= _nMenor
					aCols[y][_nPosAdi] += _nVlr
					_nCont++
				EndIf
			EndIf
		Next y

		AtuMedias()

		oGetDados:Refresh()
		If _nCont > 0
			MsgInfo(Alltrim(cValToChar(_nCont))+" registro(s) alterado(s)!","Confirmação")
		EndIf
	EndIf

Return

Static Function AtuMedias(xOP)

	Local _nCont := 0
	Local ix := 0
	Local _nPosAdi := ascan(aHeader,{|x| ALLTRIM(x[2]) == "A2_L_ADICI" })
	Local _nPosQtd := ascan(aHeader,{|x| ALLTRIM(x[2]) == "ZLD_TOTBOM" })

	_nVlrAtu := 0

	If xOP == "FOK"
		_nResult := &(ReadVar())
		For ix := 1 to (Len(aCols) - 1)
			If aCols[ix][_nPosAdi] > 0 .and. ix <> N
				_nCont++
				_nVlrAtu += aCols[ix][_nPosAdi] * aCols[ix][_nPosQtd]
			EndIf
		Next ix
		_nCont++
		_nVlrAtu += _nResult * aCols[N][_nPosQtd]
	Else
		For ix := 1 to (Len(aCols) - 1)
			If aCols[ix][_nPosAdi] > 0
				_nCont++
				_nVlrAtu += aCols[ix][_nPosAdi] * aCols[ix][_nPosQtd]
			EndIf
		Next ix
	EndIf

	_nCont := IIF(_nCont==0,1,_nCont)
	_nVlrAtu := _nVlrAtu / _nTQtdAtu //_nVlrAtu / _nCont

	aCols[Len(aCols)][_nPosAdi] := _nVlrAtu

	oVlrAtu:Refresh()
	oGetDados:Refresh()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ Salvar	 º Autor ³ TOTVS              º Data ³  00/00/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Gravação dos dados alterados no cadastro do produtor         º±±
±±º          ³                                                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Salvar()

	Local y := 0
	Local _nCont := 0
	Local _nPosAdi := 0
	Local _nPosExt := 0

	If MsgYesNo("Confirma gravação dos valores alterados no cadastro dos produtores?","Confirmação")

		_nPosAdi := ascan(aHeader,{|x| ALLTRIM(x[2]) == "A2_L_ADICI" })
		_nPosExt := ascan(aHeader,{|x| ALLTRIM(x[2]) == "A2_L_EXTRA" })

		For y := 1 to (Len(aCols) - 1)
			DbSelectArea("SA2")
			SA2->(DbSetOrder(1))
			If SA2->(DbSeek(xFilial("SA2")+aCols[y][1]+aCols[y][2]))

				If (SA2->A2_L_ADICI <> aCols[y][_nPosAdi])  .or. (SA2->A2_L_EXTRA <> aCols[y][_nPosExt])
					_nCont++
				EndIf

				RecLock("SA2",.F.)
				If SA2->A2_L_ADICI <> aCols[y][_nPosAdi]
					SA2->A2_L_BKPAD := SA2->A2_L_ADICI
					SA2->A2_L_ADICI := aCols[y][_nPosAdi]
				EndIf


				If SA2->A2_L_EXTRA <> aCols[y][_nPosExt]
					SA2->A2_L_EXTRA := aCols[y][_nPosExt]
				EndIf

				MsUnLock()
			EndIf
		Next y
	EndIf

	If _nCont > 0
		MsgInfo("Alteração concluída! "+cValToChar(_nCont)+" registro(s) alterado(s)!","Confirmação")
	EndIf

Return