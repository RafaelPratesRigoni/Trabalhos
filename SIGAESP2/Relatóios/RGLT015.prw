#Include "Protheus.ch"
#Include "Report.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºPrograma  ?RGLT015  ?Autor ?TOTVS                 ?Data da Criacao  ?09/12/2008                						º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDescricao ?Resumo de Pagamento do produtor                          										            º±?
±±?         ?															                               						º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?Lista os Produtores com seus eventos e respectivos valores totalizando o valor liquido a pagar.			    º±?
±±?         ?															                               						º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºParametros?Nenhum                     																			        º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºRetorno   ?Nenhum						  							                               						º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUsuario   ?Totvs / Microsiga											                             					º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºSetor     ?Gestao do Leite                                                                          					º±?
±±ÌÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±?           			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                   						º±?
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºAutor     ?Data     ?Motivo da Alteracao  				               ³Usuario(Filial+Matricula+Nome)    ³Setor        º±?
±±ºÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄº±?
±±?         ?         ?                  							   ?                                 ? 	        º±?
±±?---------?---------?-------------------------------------------------?---------------------------------?------------º±?
±±?         ?         ?                   							   ?                                 ?			º±?
±±?---------?---------?-------------------------------------------------?---------------------------------?------------º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/
User Function RGLT015()

Local cDesc1			:= "Este programa tem como objetivo imprimir relatorio "
Local cDesc2			:= "de acordo com os parametros informados pelo usuario."
Local cDesc3			:= "Resumo Pagamento Produtor"
Local titulo			:= "Resumo Pagamento Produtor"
Local nLin				:= 80
Local Cabec1			:= " "
Local Cabec2			:= ""
Local aOrd				:= {}
Private aStruct			:= {}
Private lEnd			:= .F.
Private lAbortPrint		:= .F.
Private CbTxt			:= ""
Private limite			:= 220
Private tamanho			:= "G"
Private nomeprog		:= "RGLT015" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo			:= 18
Private aReturn			:= { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey		:= 0
Private cbcont			:= 00
Private CONTFL			:= 01
Private m_pag			:= 01
Private wnrel			:= "RGLT015" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cPerg			:= "RGLT015   "
Private cString			:= "ZLF"

Pergunte(cPerg,.F.)

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)
If nLastKey == 27
	Return
EndIf
SetDefault(aReturn,cString)
If nLastKey == 27
	Return
EndIf
nTipo := If(aReturn[4]==1,15,18)
RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºPrograma  ?RUNREPORT   ?Autor ?Abrahao P. Santos     ?Data da Criacao  ?09/12/2008             						º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDescricao ?uncao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS monta a janela com a regua de processamento.		º±?
±±?		 ?													                                   						º±?
±±?         ?															                               						º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?	Programa principal										                               						º±?
±±?         ?															                               						º±?
±±?         ?															                               						º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºParametros?	Nenhum																										º±?
±±?		 ?											   					                       						º±?
±±?		 ?																											º±?
±±?		 ?													                                   						º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºRetorno   ?Nenhum						  							                               						º±?
±±?		 ?													                                   						º±?
±±?		 ?													                                   						º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUsuario   ?Totvs / Microsiga											                             					º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºSetor     ?Gestao do Leite                                                                          					º±?
±±ÌÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±?           			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL                   						º±?
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºAutor     ?Data     ?Motivo da Alteracao  				               ³Usuario(Filial+Matricula+Nome)    ³Setor        º±?
±±ºÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄº±?
±±?         ?         ?                  							   ?                                 ? 	        º±?
±±?---------?---------?-------------------------------------------------?---------------------------------?------------º±?
±±?         ?         ?                   							   ?                                 ?			º±?
±±?---------?---------?-------------------------------------------------?---------------------------------?------------º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
/*/
Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nTotDeb  := 0
Local nTotCre  := 0
Local nLiq     := 0
Local nMaxLin  := 60 // maximo de linhas
Local cUltLin  := ""
Local nqtdregs := 0
Local nPreco   := 0
Local nVolume  := 0
Local agrupa   := Iif(mv_par14==1,.T.,.F.)
Local lProdutor:= Iif(mv_par15==1,lProdutor:=.T.,lProdutor:=.F.)
Local i 	   := 0
Static nIniPos := 50
Static nMaxCol := 11 // maximo de colunas
Static nTamCmp := 11
Private nOutros    := 0
Private dt1,dt2    := CTOD("")
Private nSubVolume := 0
Private aSubtotal  := {}
Private aLin       := {}

// posiciona no Mix pra pegar datas
dbSelectArea("ZLE")
dbSetOrder(1)
dbseek(xfilial("ZLE")+mv_par02)

dt1:=ZLE->ZLE_DTINI
dt2:=ZLE->ZLE_DTFIM
("ZLE")->(dbCloseArea())

Cabec1 := "Setor: "+mv_par01+" Mix: "+mv_par02

nLin := nMaxLin

// obtem campos dinamicos (eventos)
aStruct := getStruct(mv_par01,mv_par02,agrupa)

// Monta cabecalho
// com os campos dinamicos (eventos)
Cabec2:=padr("CODIGO LOJA PRODUTOR",29)
Cabec2+=space(3)+"VOLUME"
Cabec2+=space(5)+"PRECO"



For i:=1 to len(aStruct)
	If i<=nMaxCol
		Cabec2 += strSpace(aStruct[i,2],nTamCmp)
	EndIf
	If i==len(aStruct) .and. i>nMaxCol
		Cabec2 += strSpace("OUTROS",nTamCmp)
	EndIf
	aAdd(aSubTotal,0) // subtotal das linhas
Next i
Cabec2+=strSpace("VLR LIQUIDO",12)


// leia linhas
cQuery1 := " SELECT ZLD_LINROT,ZLD_RETIRO,ZLD_RETILJ, ZLD_GRPRC "
cQuery1 += " FROM " + RetSqlName("ZLD") + " ZLD "
cQuery1 += " WHERE D_E_L_E_T_ = ' ' "
cQuery1 += " AND ZLD.ZLD_FILIAL = '" + XFILIAL("ZLD") + "' "
cQuery1 += " AND ZLD.ZLD_SETOR = '" + AllTrim(MV_PAR01) + "' "
cQuery1 += " AND ZLD.ZLD_DTCOLE BETWEEN '" + dtos(dt1) + "' AND '"+ dtos(dt2) +"' "
cQuery1 += " AND ZLD.ZLD_FRETIS BETWEEN '" + MV_PAR04 + "' AND '"+MV_PAR06+"' "
cQuery1 += " AND ZLD.ZLD_LJFRET BETWEEN '" + MV_PAR05 + "' AND '"+MV_PAR07+"' "
cQuery1 += " AND ZLD.ZLD_RETIRO BETWEEN '" + MV_PAR08 + "' AND '"+MV_PAR10+"' "
cQuery1 += " AND ZLD.ZLD_RETILJ BETWEEN '" + MV_PAR09 + "' AND '"+MV_PAR11+"' "
cQuery1 += " AND ZLD.ZLD_LINROT BETWEEN '" + MV_PAR12 + "' AND '"+MV_PAR13+"' "
cQuery1 += " AND ZLD.ZLD_RETIRO != ' ' "
cQuery1 += " GROUP BY ZLD_LINROT,ZLD_RETIRO,ZLD_RETILJ, ZLD_GRPRC "
cQuery1 += " ORDER BY ZLD_LINROT,ZLD_RETIRO,ZLD_RETILJ, ZLD_GRPRC "

If Select("TRL") > 0
	dbSelectArea("TRL")
	("TRL")->(dbCloseArea())
EndIf
dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery1), "TRL", .T., .F. )

COUNT TO nqtdregs
setRegua(nqtdregs)

TRL->(dbGoTop())

While TRL->(!Eof())

	incregua()

	If nLin >= nMaxLin
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 9
	EndIf

	// MOSTRA CABECALHO (LINHA E FRETISTA)
	If cUltLin != TRL->ZLD_LINROT

		// Mostra subtotal da linha
		If cUltLin != "" .And. mv_par16 == 2//imprime positivo e negativo
			nLin := showSubTotal(nLin)
			nSubVolume:=0
		EndIf

		// POSICIONA NA LINHA
		dbSelectArea("ZLW")
		dbSetOrder(1)
		dbGoTop()
		dbSeek(XFILIAL("ZLW")+TRL->ZLD_LINROT)

		@nLin,000 PSAY "Linha: "+TRL->ZLD_LINROT+"-"+ZLW->ZLW_DESCRI+"    Fretista: "+POSICIONE("SA2",1,XFILIAL("SA2")+ZLW->ZLW_FRETIS+ZLW->ZLW_FRETLJ,"A2_NOME")
		nLin++

		("ZLW")->(dbCloseArea())
		dbSelectArea("TRL")

	EndIf
	cUltLin := TRL->ZLD_LINROT

	// Obtem valores dos eventos do produtor corrente
	// e ja calcula valor liquido
	// Utiliza o array aLin para armazenar os valores de cada evento
	// para nao precisar buscar esses valores novamente
	aLin := {}
	For i:=1 to len(aStruct)
		If agrupa
			nVlrPrd := u_getTotGp(xfilial("ZLD"),aStruct[i,1],mv_par01,TRL->ZLD_GRPRC,ZLD_RETIRO,ZLD_RETILJ,MV_PAR02,"",mv_par03,"L")
		Else
			nVlrPrd := u_getTotEv(xfilial("ZLD"),aStruct[i,1],mv_par01,TRL->ZLD_GRPRC,ZLD_RETIRO,ZLD_RETILJ,MV_PAR02,mv_par03,"L")
		EndIf
		// Armazena total geral
		aStruct[i,3] += nVlrPrd

		// Armazena subtotal
		aSubTotal[i] += nVlrPrd

		aAdd(aLin,nVlrPrd)
		nLiq+=nVlrPrd
	Next i

	If lProdutor//Mostra os produtores linha a linha
		If mv_par16 == 1//somente negativos
			If nLiq < 0 //valor liquido menor que zero

				// MOSTRA PRODUTOR E SEUS RESPECTIVOS VALORES
				@nLin,000 PSAY TRL->ZLD_RETIRO + "-" +TRL->ZLD_RETILJ + " "+LEFT(POSICIONE("SA2",1,XFILIAL("SA2")+TRL->ZLD_RETIRO+TRL->ZLD_RETILJ,"A2_NOME"),15)

				// Obtem volume do produtor
				nVolume := U_VolLeite(xfilial("ZLD"),dt1,dt2,mv_par01,TRL->ZLD_GRPRC,TRL->ZLD_RETIRO,TRL->ZLD_RETILJ,"")

				// armazena volume para o subtotal
				nSubVolume += nVolume
				@nLin,030 PSAY nVolume Picture "@E 9,999,999"

				// Mostra o preco do leite
				nPreco := u_getTotCr(xfilial("ZLD"),mv_par01,TRL->ZLD_GRPRC,TRL->ZLD_RETIRO,TRL->ZLD_RETILJ,mv_par02,mv_par03)
				nPreco := nPreco/nVolume
				@nLin,040 PSAY nPreco Picture "@E 9999.9999"

				nPos1:=nIniPos
				For i:=1 to len(aStruct)
					nVlrPrd := aLin[i]
					If i<=nMaxCol
						@nLin,nPos1 PSAY nVlrPrd Picture "@E 99,999.99"
						nPos1 += nTamCmp
					Else
						nOutros += nVlrPrd
					EndIf
					If i==len(aStruct) //.and. nOutros <> 0
						@nLin,nPos1 PSAY nOutros Picture "@E 99,999.99"
						nPos1 += nTamCmp
					EndIf
				Next i

				// MOSTRA VLR LIQUIDO
				@nLin,nPos1 PSAY nLiq Picture "@E 99,999,999.99"

				nLin++
				nOutros:=0
			EndIf

		Else//NAO (imprime todos, negativos e positivos)

			// MOSTRA PRODUTOR E SEUS RESPECTIVOS VALORES
			@nLin,000 PSAY TRL->ZLD_RETIRO + "-" +TRL->ZLD_RETILJ + " "+LEFT(POSICIONE("SA2",1,XFILIAL("SA2")+TRL->ZLD_RETIRO+TRL->ZLD_RETILJ,"A2_NOME"),15)

			// Obtem volume do produtor
			nVolume := U_VolLeite(xfilial("ZLD"),dt1,dt2,mv_par01,TRL->ZLD_GRPRC,TRL->ZLD_RETIRO,TRL->ZLD_RETILJ,"")

			// armazena volume para o subtotal
			nSubVolume += nVolume
			@nLin,030 PSAY nVolume Picture "@E 9,999,999"

			// Mostra o preco do leite
			nPreco := u_getTotCr(xfilial("ZLD"),mv_par01,TRL->ZLD_GRPRC,TRL->ZLD_RETIRO,TRL->ZLD_RETILJ,mv_par02,mv_par03)
			nPreco := nPreco/nVolume
			@nLin,040 PSAY nPreco Picture "@E 99.9999"

			nPos1:=nIniPos
			For i:=1 to len(aStruct)
				nVlrPrd := aLin[i]
				If i<=nMaxCol
					@nLin,nPos1 PSAY nVlrPrd Picture "@E 999,999.99"
					nPos1 += nTamCmp
				Else
					nOutros += nVlrPrd
				EndIf
				If i==len(aStruct) .and. nOutros <> 0
					@nLin,nPos1 PSAY nOutros Picture "@E 999,999.99"
					nPos1 += nTamCmp
				EndIf
			Next i

			// MOSTRA VLR LIQUIDO
			@nLin,nPos1 PSAY nLiq Picture "@E 99,999,999.99"

			nLin++
			nOutros:=0
		EndIf
	EndIf

	nLiq:=0
	nOutros:=0

	TRL->(dbSkip())
EndDo
TRL->(dbCloseArea())

// -----------------------------------
// Mostra SubTotal da ultima linha
// -----------------------------------
If mv_par16 == 2//imprime positivo e negativo
	nLin := showSubTotal(nLin)
EndIf

//---------------------------------------------------
// Se nao mostra os Produtores linha a linha
//---------------------------------------------------
If !lProdutor .And. mv_par16 == 2//imprime positivo e negativo

	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	nLin := 9

	@nLin,000 PSAY "Resumo Geral"
	nLin += 2

	@nLin,000 PSAY "Codigo"
	@nLin,008 PSAY "Evento"
	@nLin,030 PSAY "Creditos"
	@nLin,050 PSAY "Debitos"
	nLin++

	@nLin,000 PSAY Replicate("-",60)
	nLin++
	For i:=1 to len(aStruct)
		@nLin,000 PSAY aStruct[i,1]
		@nLin,008 PSAY aStruct[i,2]
		If aStruct[i,3] >= 0
			@nLin,020 PSAY aStruct[i,3] Picture "@E 999,999,999,999.99"
			nTotCre+=aStruct[i,3]
		Else
			@nLin,040 PSAY aStruct[i,3] Picture "@E 999,999,999,999.99"
			nTotDeb+=aStruct[i,3]
		EndIf
		nLin++
	Next i
	@nLin,000 PSAY Replicate("-",60)
	nLin++
	@nLin,000 PSAY "Total"
	@nLin,020 PSAY nTotCre Picture "@E 999,999,999,999.99"
	@nLin,040 PSAY nTotDeb Picture "@E 999,999,999,999.99"
	nLin++
	@nLin,000 PSAY "Valor Liquido"
	If (nTotcre+ntotDeb) >= 0
		@nLin,020 PSAY (nTotcre+ntotDeb) Picture "@E 999,999,999,999.99"
	Else
		@nLin,040 PSAY (nTotcre+ntotDeb) Picture "@E 999,999,999,999.99"
	EndIf
	nLin++

	@ nLin,000 PSay __PrtThinLine()
	nLin++

EndIf

SET DEVICE TO SCREEN
If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
EndIf

MS_FLUSH()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºPrograma  ?getStruct   ?Autor ?Abrahao P. Santos     ?Data da Criacao  ?09/12/2008             						º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDescricao ?Retorna campos dinamicos que estao na ZLF                                               						º±?
±±?		 ?													                                   						º±?
±±?         ?															                               						º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?															                               						º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºParametros?	Nenhum																										º±?
±±?		 ?											   					                       						º±?
±±?		 ?																											º±?
±±?		 ?													                                   						º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºRetorno   ?Nenhum						  							                               						º±?
±±?		 ?													                                   						º±?
±±?		 ?													                                   						º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUsuario   ?Totvs / Microsiga											                             					º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºSetor     ?Gestao do Leite                                                                          					º±?
±±ÌÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±?           			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL                   						º±?
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºAutor     ?Data     ?Motivo da Alteracao  				               ³Usuario(Filial+Matricula+Nome)    ³Setor        º±?
±±ºÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄº±?
±±?         ?         ?                  							   ?                                 ? 	        º±?
±±?---------?---------?-------------------------------------------------?---------------------------------?------------º±?
±±?         ?         ?                   							   ?                                 ?			º±?
±±?---------?---------?-------------------------------------------------?---------------------------------?------------º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/
Static Function getStruct(cpSetor,cpMix,cpAgrupa)

Local aArea := GetArea()
Local aCampos := {}

If cpAgrupa
	dbSelectArea("ZL7")
	dbSetOrder(1)
	dbGoTop()
	While !Eof()
		aAdd(aCampos,{ZL7->ZL7_COD,LEFT(ZL7->ZL7_NREDUZ,8),0})
		dbSkip()
	EndDo
	("ZL7")->(dbCloseArea())
EndIf

If !cpAgrupa
	cQuery1 := " SELECT ZLF_EVENTO AS CODIGO,MAX(ZLF_DEBCRE) AS DEBCRE "
	cQuery1 += " FROM " + RetSqlName("ZLF") + " ZLF "
	cQuery1 += " WHERE ZLF.ZLF_FILIAL = '"+xFilial("ZLF")+" ' "
	cQuery1 += " AND ZLF.ZLF_SETOR = '" + AllTrim(cpSetor) + "' "
	cQuery1 += " AND ZLF.ZLF_CODZLE = '" + AllTrim(cpMix) + "' "
	cQuery1 += " AND ZLF.ZLF_TP_MIX = 'L' AND ZLF.D_E_L_E_T_ = ' ' ""
	cQuery1 += " GROUP BY ZLF_EVENTO ORDER BY ZLF_EVENTO "
	If Select("TRB") > 0
		dbSelectArea("TRB")
		("TRB")->(dbCloseArea())
	EndIf
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery1), "TRB", .T., .F. )
	While !TRB->(Eof())
		aAdd(aCampos,{TRB->CODIGO,POSICIONE("ZL8",1,XFILIAL("ZL8")+TRB->CODIGO,"ZL8_NREDUZ"),0})
		TRB->(dbSkip())
	EndDo
	TRB->(dbCloseArea())
EndIf

RestArea(aArea)
Return aCampos

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºPrograma  ?RGLT015  ?Autor ?Microsiga          ?Data ? 00/00/00   º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDesc.     ?                                                           º±?
±±?         ?                                                           º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?                                                           º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/
Static Function strSpace(cTexto,nQtd)
cTexto := space(nQtd-len(alltrim(cTexto)))+alltrim(cTexto)
Return cTexto

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±?
±±ºPrograma  ?RGLT015  ?Autor ?Microsiga          ?Data ? 00/00/00   º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºDesc.     ?                                                           º±?
±±?         ?                                                           º±?
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±?
±±ºUso       ?                                                           º±?
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±?
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±?
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß?
*/
Static Function showSubTotal(nLin)

Local nSubLiq := 0
Local i       := 0
Local u       := 0

@nLin,000 PSAY "SubTotal -------->"
@nLin,030 PSAY nSubVolume Picture "@E 99,999,999"
nOutros:= 0
nPos1:=nIniPos


For i:=1 to len(aStruct)
	nVlrPrd := aSubTotal[i]
	aSubTotal[i] := 0
	nSubLiq+=nVlrPrd
	If i<=nMaxCol
		@nLin,nPos1 PSAY nVlrPrd Picture "@E 999,999.99"
		nPos1 += nTamCmp
	Else
		nOutros += nVlrPrd
	EndIf
	If i==len(aStruct) //.and. nOutros <> 0
		@nLin,nPos1 PSAY nOutros Picture "@E 999,999.99"
		nPos1 += nTamCmp
	EndIf
Next i

For u:=1 to len(aSubTotal)
	aSubTotal[u] := 0
Next u

// MOSTRA VLR LIQUIDO
@nLin,nPos1 PSAY nSubLiq Picture "@E 99,999,999.99"
nLin++

@ nLin,000 PSay __PrtThinLine()
nLin++

nOutros:=0

Return nLin