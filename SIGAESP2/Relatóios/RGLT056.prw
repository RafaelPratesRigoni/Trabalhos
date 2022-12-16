#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "TOPCONN.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ RGLT056     º Autor ³ TOTVS                 º Data da Criacao  ³ 12/09/2011             						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relacao de novos produtores, produtores que pararam e produtores que voltaram a fornecer leite.              º±±
±±º          ³ 	 							                                                                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Gestao do Leite                                                   											º±±
±±º          ³ 	 							                                                                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³                                                                                        						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ Nenhum					                                                                                  	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUsuario   ³															                             						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºSetor     ³ Gestao do Leite	                                                                       						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º            						ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                   						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor     ³ Data     ³ Motivo da Alteracao  				               ³Usuario(Filial+Matricula+Nome)    ³Setor        º±±
±±ÌÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄ¹±±
±±º          ³          ³                    							   ³                                  ³ 			º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function RGLT056

Private dAtuIni  := CTOD("")//Data Atual Inicial
Private dAtuFim  := CTOD("")//Data Atual Final
Private dAntIni  := CTOD("")//Data Anterior Inicial
Private dAntFim  := CTOD("")//Data Anterior Final
Private oCB
Private oReport
Private cPerg   := "RGLT056"
Private nQtdReg := 3
Private nCount  := 1

If !Pergunte(cPerg,.T.)
	Return
EndIf

DEFINE REPORT oReport NAME 'RGLT056' TITLE 'Rotatividade de Produtores' PARAMETER cPerg ACTION {|| RunRel()}

oReport:SetPortrait()// ou SetPortrait() - SetLandscape()
oReport:HideHeader() // Nao imprime cabecalho padrao do Protheus
oReport:HideFooter() // Nao imprime rodape padrao do Protheus
oReport:SetTotalInLine(.F.)

DEFINE SECTION OCB OF oReport TITLE "ROTATIVIDADE"

oReport:PrintDialog()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ RunRel   º Autor ³ Microsiga          º Data ³  00/00/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Processamento do relatorio.                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ RGLT056()                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RunRel()

Local nTab01  := 0100
Local nTab02  := 0250
Local nTab03  := 0350
Local nTab04  := 1100
Local nTab05  := 1300
Local nTab06  := 1600
Local nItens  := 0
Local nQtdPro := 0
Local nMedia  := 0 //Fornecimento Medio -> Qtde Leite dividido por 2 e dividido pela qtde de coleta.
Local nTotMed := 0
Local nQtdPar := 0 //Total de Produtores que pararam
Local nQtdVol := 0 //Total de Produtores que voltaram
Local nQtdNov := 0 //Total de Produtores novos
Local nMedPar := 0 //Media Total de Produtores que pararam
Local nMedVol := 0 //Media Total de Produtores que voltaram
Local nMedNov := 0 //Media Total de Produtores novos

Private nL := 0

oFontTitulo:=TFont():New("Arial",09,14,.T.,.T.,5,.T.,5,.T.,.F.)
oFontRotulo:=TFont():New("Arial",09,11,.T.,.T.,5,.T.,5,.T.,.F.)
oFontNormal:=TFont():New("Arial",09,11,.F.,.F.,5,.T.,5,.T.,.F.)
oFontDetCv1:=TFont():New("Courier New",09,11,.F.,.F.,5,.T.,5,.T.,.F.)
oFontDetCv2:=TFont():New("Courier New",09,11,.T.,.T.,5,.T.,5,.T.,.F.)

//Obtem data do MIX informado nos parametros
dbSelectArea("ZLE")
dbSetOrder(1)
dbSeek(xFilial("ZLE")+MV_PAR02)

dAtuIni := ZLE->ZLE_DTINI
dAtuFim := ZLE->ZLE_DTFIM

//Obtem data do MIX anterior ao informado nos parametros
dbSelectArea("ZLE")
dbSkip(-1)
If !ZLE->(Eof())
	dAntIni := ZLE->ZLE_DTINI
	dAntFim := ZLE->ZLE_DTFIM
EndIf

oReport:Section(1):Init()
oReport:SetMeter(nQtdReg)

While nCount <= nQtdReg .And. !oReport:Cancel()

	// Cabecalho
	oReport:IncMeter()
	nL     := 50
	nItens := 0
	nQtdPro:= 0
	nTotMed:= 0
	Cabec(1)

	// INICIO DOS EVENTOS DO PRODUTOR NA ZLF
	nL += 10
	oReport:Say(nL,nTab01,"Codigo"       ,oFontRotulo)
	oReport:Say(nL,nTab02,"Loja"         ,oFontRotulo)
	oReport:Say(nL,nTab03,"Nome"         ,oFontRotulo)
	oReport:Say(nL,nTab04,"Linha"        ,oFontRotulo)
	oReport:Say(nL,nTab05,"Bloqueado"    ,oFontRotulo)
	oReport:Say(nL,nTab06,"Forncto Medio",oFontRotulo)
	nL += 50
	oReport:FillRect({nL,2300,nL+1,100},TBrush():New("",0))

	nL += 10

	//QUERY PARA BUSCAR OS PRODUTORES VERSUS ROTATIVIDADE
	cQuery := "SELECT A2_COD,A2_LOJA,A2_NOME,A2_L_LI_RO,A2_MSBLQL "
	cQuery += "FROM "+RetSqlName("SA2")+" SA2 "
	cQuery += "WHERE SA2.D_E_L_E_T_ = ' ' "
	cQuery += "AND A2_FILIAL = '"+xFilial("SA2")+"' "
	cQuery += "AND SA2.A2_L_TPFOR  = 'P' "

	If MV_PAR03 == 2 //Lista Bloqueados == NAO
		cQuery += "AND A2_MSBLQL <> '1' "
	EndIf

	//PRODUTORES NOVOS
	If nCount == 1
		cQuery += "AND EXISTS( SELECT ZLD_DTCOLE "
		cQuery += "  FROM "+RetSqlName("ZLD")+" ZLD "
		cQuery += "  WHERE ZLD.D_E_L_E_T_ = ' ' "
		cQuery += "  AND ZLD_FILIAL = '"+xFilial("ZLD")+"' "
		cQuery += "  AND ZLD.ZLD_RETIRO = SA2.A2_COD AND ZLD.ZLD_RETILJ = SA2.A2_LOJA "
		cQuery += "  AND ZLD.ZLD_DTCOLE BETWEEN '"+DTOS(dAtuIni)+"' AND '"+DTOS(dAtuFim)+"' ) "

		cQuery += "AND NOT EXISTS( SELECT ZLD_DTCOLE "
		cQuery += "  FROM "+RetSqlName("ZLD")+" ZLD "
		cQuery += "  WHERE ZLD.D_E_L_E_T_ = ' ' "
		cQuery += "  AND ZLD_FILIAL = '"+xFilial("ZLD")+"' "
		cQuery += "  AND ZLD.ZLD_RETIRO = SA2.A2_COD AND ZLD.ZLD_RETILJ = SA2.A2_LOJA "
		cQuery += "  AND ZLD.ZLD_DTCOLE < '"+DTOS(dAtuIni)+"' ) "
	ElseIf nCount == 2
		//PRODUTORES QUE PARARAM
		cQuery += "AND EXISTS( SELECT ZLD_DTCOLE "
		cQuery += "  FROM "+RetSqlName("ZLD")+" ZLD "
		cQuery += "  WHERE ZLD.D_E_L_E_T_ = ' ' "
		cQuery += "  AND ZLD_FILIAL = '"+xFilial("ZLD")+"' "
		cQuery += "  AND ZLD.ZLD_RETIRO = SA2.A2_COD AND ZLD.ZLD_RETILJ = SA2.A2_LOJA "
		cQuery += "  AND ZLD.ZLD_DTCOLE BETWEEN '"+DTOS(dAntIni)+"' AND '"+DTOS(dAntFim)+"' ) "

		cQuery += "AND NOT EXISTS( SELECT ZLD_DTCOLE "
		cQuery += "  FROM "+RetSqlName("ZLD")+" ZLD "
		cQuery += "  WHERE ZLD.D_E_L_E_T_ = ' ' "
		cQuery += "  AND ZLD_FILIAL = '"+xFilial("ZLD")+"' "
		cQuery += "  AND ZLD.ZLD_RETIRO = SA2.A2_COD AND ZLD.ZLD_RETILJ = SA2.A2_LOJA "
		cQuery += "  AND ZLD.ZLD_DTCOLE BETWEEN '"+DTOS(dAtuIni)+"' AND '"+DTOS(dAtuFim)+"' ) "
	Else
		//PRODUTORES QUE VOLTARAM
		cQuery += "AND EXISTS( SELECT ZLD_DTCOLE "
		cQuery += "  FROM "+RetSqlName("ZLD")+" ZLD "
		cQuery += "  WHERE ZLD.D_E_L_E_T_ = ' ' "
		cQuery += "  AND ZLD_FILIAL = '"+xFilial("ZLD")+"' "
		cQuery += "  AND ZLD.ZLD_RETIRO = SA2.A2_COD AND ZLD.ZLD_RETILJ = SA2.A2_LOJA "
		cQuery += "  AND ZLD.ZLD_DTCOLE BETWEEN '"+DTOS(dAtuIni)+"' AND '"+DTOS(dAtuFim)+"' ) "

		cQuery += "AND NOT EXISTS( SELECT ZLD_DTCOLE "
		cQuery += "  FROM "+RetSqlName("ZLD")+" ZLD "
		cQuery += "  WHERE ZLD.D_E_L_E_T_ = ' ' "
		cQuery += "  AND ZLD_FILIAL = '"+xFilial("ZLD")+"' "
		cQuery += "  AND ZLD.ZLD_RETIRO = SA2.A2_COD AND ZLD.ZLD_RETILJ = SA2.A2_LOJA "
		cQuery += "  AND ZLD.ZLD_DTCOLE BETWEEN '"+DTOS(dAntIni)+"' AND '"+DTOS(dAntFim)+"' ) "

		cQuery += "AND EXISTS( SELECT ZLD_DTCOLE "
		cQuery += "  FROM "+RetSqlName("ZLD")+" ZLD "
		cQuery += "  WHERE ZLD.D_E_L_E_T_ = ' ' "
		cQuery += "  AND ZLD_FILIAL = '"+xFilial("ZLD")+"' "
		cQuery += "  AND ZLD.ZLD_RETIRO = SA2.A2_COD AND ZLD.ZLD_RETILJ = SA2.A2_LOJA "
		cQuery += "  AND ZLD.ZLD_DTCOLE < '"+DTOS(dAntIni)+"' ) "
	EndIf

	cQuery += "ORDER BY A2_NOME
	If Select("TRC1") <> 0
		TRC1->(dbCloseArea())
	EndIf
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRC1", .T., .F. )

	If !TRC1->(Eof())

		While !TRC1->(Eof()) .And. !oReport:Cancel()

			// para imprime em nova página caso ultrapasse o tamanho da pagina atual
			If nItens > 50
				nL+=20
				oReport:Say(nL,nTab03,"continua na próxima página...",oFontNormal)
				oReport:EndPage()
				nL     := 50
				nItens := 0
				cabec()
			EndIf

			//Chama funcao para calculo do Fornecimento Medio de leite
			If nCount == 2//PRODUTORES QUE PARARAM
				nMedia := FornMedio(TRC1->A2_COD,TRC1->A2_LOJA,dAntIni,dAntFim)
			Else
				nMedia := FornMedio(TRC1->A2_COD,TRC1->A2_LOJA,dAtuIni,dAtuFim)
			EndIf

			oReport:Say(nL,nTab01,TRC1->A2_COD,oFontNormal)
			oReport:Say(nL,nTab02,TRC1->A2_LOJA,oFontNormal)
			oReport:Say(nL,nTab03,TRC1->A2_NOME,oFontNormal)
			oReport:Say(nL,nTab04,TRC1->A2_L_LI_RO,oFontNormal)
			oReport:Say(nL,nTab05,If(TRC1->A2_MSBLQL=="1","Sim","Nao"),oFontNormal)
			oReport:Say(nL,nTab06,TransForm(nMedia,"@E 9,999,999"),oFontNormal)

			nL     += 50
			nItens += 1
			nQtdPro+= 1
			nTotMed+= nMedia

			If nCount == 1
				nQtdNov += 1 //Total de Produtores novos
				nMedNov += nMedia//Media Total de Produtores novos
			ElseIf nCount == 2
				nQtdPar += 1 //Total de Produtores que pararam
				nMedPar += nMedia//Media Total de Produtores que pararam
			Else
				nQtdVol += 1 //Total de Produtores que voltaram
				nMedVol += nMedia//Media Total de Produtores que voltaram
			EndIf

			TRC1->(dbSkip())
		EndDo
		nL += 50
		oReport:Say(nL,nTab01,"Total de Produtores: "+ALLTRIM(STR(nQtdPro)),oFontNormal)
		oReport:Say(nL,nTab06,TransForm(nTotMed,"@E 9,999,999")+"  Litros",oFontNormal)
		nL     += 50
		nItens += 1
	Else
		oReport:Say(nL,nTab01,"000000",oFontNormal)
		oReport:Say(nL,nTab02,"00"    ,oFontNormal)
		oReport:Say(nL,nTab03,"NAO EXISTE PRODUTOR NESSA SITUACAO",oFontNormal)
		oReport:Say(nL,nTab04,"000000",oFontNormal)
		oReport:Say(nL,nTab05,"XXX"   ,oFontNormal)

		nL     += 50
		nItens += 1
	EndIf

	nCount++
	TRC1->(dbCloseArea())
	oReport:EndPage()
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Impressao da pagina de RESUMO  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:IncMeter()
nL := 200
Cabec(2)

nL     += 10
nTab03 += 500
oReport:Say(nL,nTab01,"Descricao"         ,oFontRotulo)
oReport:Say(nL,nTab03,"Quantidade"        ,oFontRotulo)
oReport:Say(nL,nTab05,"Fornecimento Medio",oFontRotulo)
nL += 50
oReport:FillRect({nL,2300,nL+1,100},TBrush():New("",0))

nL += 100
oReport:Say(nL,nTab01,"Total de Produtores novos"             ,oFontRotulo)
oReport:Say(nL,nTab03,TransForm(nQtdNov,"@E 999,999")  +" (+)",oFontRotulo)
oReport:Say(nL,nTab05,TransForm(nMedNov,"@E 9,999,999")+" (+)",oFontRotulo)

nL += 100
oReport:Say(nL,nTab01,"Total de Produtores que voltaram"      ,oFontRotulo)
oReport:Say(nL,nTab03,TransForm(nQtdVol,"@E 999,999")  +" (+)",oFontRotulo)
oReport:Say(nL,nTab05,TransForm(nMedVol,"@E 9,999,999")+" (+)",oFontRotulo)

nL += 100
oReport:Say(nL,nTab01,"Total de Produtores que pararam"       ,oFontRotulo)
oReport:Say(nL,nTab03,TransForm(nQtdPar,"@E 999,999")  +" (-)",oFontRotulo)
oReport:Say(nL,nTab05,TransForm(nMedPar,"@E 9,999,999")+" (-)",oFontRotulo)

nL += 200
oReport:Say(nL,nTab01,"RESULTADO  ->"                                  ,oFontRotulo)
oReport:Say(nL,nTab03,TransForm(nQtdNov+nQtdVol-nQtdPar,"@E 999,999")  ,oFontRotulo)
oReport:Say(nL,nTab05,TransForm(nMedNov+nMedVol-nMedPar,"@E 9,999,999"),oFontRotulo)

oReport:EndPage()
oReport:Section(1):Finish()
Return(Nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ RGLT056  º Autor ³ Microsiga          º Data ³  00/00/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Monta o cabecalho do relatorio.                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Cabec(nOpc)

Local cRaizServer := If(IsSrvUnix(), "/", "\")

oReport:SayBitmap(nL,100,cRaizServer + "sigaadv/lgrl01.bmp",186,155)
nL += 50
oReport:Say(nL,900,"Rotatividade de Produtores em " + MesExtenso(STR(Month(dAtuIni)))+" - "+STR(YEAR(dAtuFim),4),oFontTitulo)

If nOpc == 1
	nL += 50
	If nCount == 1
		oReport:Say(nL,1200,"PRODUTORES NOVOS",oFontRotulo)
	ElseIf nCount == 2
		oReport:Say(nL,1100,"PRODUTORES QUE PARARAM",oFontRotulo)
	Else
		oReport:Say(nL,1100,"PRODUTORES QUE VOLTARAM",oFontRotulo)
	EndIf
Else
	nL += 50
	oReport:Say(nL,1200,"RESUMO",oFontRotulo)
EndIf

nL += 80
oReport:FillRect({nL,2300,nL+1,100},TBrush():New("",0))
nL += 10

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ FornMedioº Autor ³ Microsiga          º Data ³  01/03/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna o fornecimento medio de leite.                     º±±
±±º          ³                                                            º±±
±±º          ³ Pega-se a quantidade de litros entregue pelo produtor no   º±±
±±º          ³ período, divide-se por dois e divide-se pela quantidade    º±±
±±º          ³ de coletas que foram realizadas.                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ ExpC01 - Codigo do Produtor.                               º±±
±±º          ³ ExpC02 - Loja do Produtor.                                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ ExpN01 - Media de Fornecimento.                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ RGLT056()                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FornMedio(cCod,cLoj,dIni,dFim)

Local nRet   := 0
Local cQuery := ""

cQuery := "SELECT COUNT(*) AS DIAS,SUM(ZLD_QTDBOM) AS QTDE"
cQuery += " FROM "+RetSqlName("ZLD")
cQuery += " WHERE D_E_L_E_T_ = ' ' "
cQuery += " AND ZLD_QTDBOM > 0"
cQuery += " AND ZLD_FILIAL = '"+xFilial("ZLD")+"' "
cQuery += " AND ZLD_RETIRO = '"+cCod+"' "
cQuery += " AND ZLD_RETILJ = '"+cLoj+"' "
cQuery += " AND ZLD_DTCOLE BETWEEN '"+DTOS(dIni)+"' AND '"+DTOS(dFim)+"'"
If Select("TRC2") <> 0
	TRC2->(dbCloseArea())
EndIf
dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRC2", .T., .F. )

If TRC2->(!Eof()) .And. TRC2->QTDE > 0
    //Divide a quantidade de leite pelo nro de coletas
	nRet := TRC2->QTDE / TRC2->DIAS
	//Divide por dois, porque normalmente eh uma coleta a cadas dois dias
	nRet := INT(nRet/2)
EndIf

dbSelectArea("TRC2")
("TRC2")->(dbCloseArea())
Return(nRet)