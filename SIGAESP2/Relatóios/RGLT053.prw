#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ RGLT053  º Autor ³ TOTVS                 º Data da Criacao  ³ 07/01/2011                						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relacao de Emprestimo e Adiantamento.                           						                        º±±
±±º			 ³														                                   						º±±
±±º          ³ 															                               						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ 	Tabela ZLM				                               						                                º±±
±±º			 ³														                                   						º±±
±±º          ³ 															                               						º±±
±±º          ³ 															                               						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ 	MV_PAR01 = Entidade de:																						º±±
±±º			 ³	MV_PAR02 = Entidade ate:						   				                       						º±±
±±º			 ³	MV_PAR03 = Loja de:																							º±±
±±º			 ³	MV_PAR04 = Loja ate:														                                º±±
±±º			 ³	MV_PAR05 = Data de:																						    º±±
±±º			 ³	MV_PAR06 = Data ate:														                                º±±
±±º			 ³	MV_PAR07 = Tipo                             						                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ Nenhum						  							                               						º±±
±±º			 ³														                                   						º±±
±±º			 ³														                                   						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUsuario   ³ Totvs / Microsiga											                             					º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºSetor     ³ Gestao do Leite                                                                          					º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL                   						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor     ³ Data     ³ Motivo da Alteracao  				               ³Usuario(Filial+Matricula+Nome)    ³Setor        º±±
±±ºÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄº±±
±±º          ³          ³                   							   ³                                  ³  	        º±±
±±º----------³----------³--------------------------------------------------³----------------------------------³-------------º±±
±±º          ³          ³                    							   ³                                  ³ 			º±±
±±º----------³----------³--------------------------------------------------³----------------------------------³-------------º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function RGLT053()

Private oZLM
Private oReport
Private cPerg    := PadR("PRGLT053",10)
Private cMasc1   := "@E 999,999.99"
Private cMasc2   := "@E 999,999,999.99"
Private cAlias   := GetNextAlias()
Private aOrd     := {"Codigo","Produtor+Loja","Nome","Vlr.Parcela","Data"}
Private nParcPag := 0

If !Pergunte(cPerg,.T.)
	Return
EndIf

DEFINE REPORT oReport NAME "RGLT053" TITLE "RELACAO EMPRESTIMO/ADIANTAMENTO" PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)}

oReport:SetTotalInLine(.F.)
oReport:GetOrientation(2)
oReport:SetLandscape(.T.)// ou SetPortrait() - SetLandscape()
dbSelectArea("ZLM")
dbSetOrder(1)

DEFINE SECTION oZLM OF oReport TITLE "Emprestimo/Adiantamento" TABLES "ZLM" ORDERS aOrd
DEFINE CELL NAME "ZLM_COD" 		OF oZLM ALIAS "ZLM" TITLE "Codigo"     SIZE 10
DEFINE CELL NAME "ZLM_SA2COD"	OF oZLM ALIAS "ZLM" TITLE "Produtor"   SIZE 12
DEFINE CELL NAME "ZLM_SA2LJ" 	OF oZLM ALIAS "ZLM" TITLE "Lj"
DEFINE CELL NAME "ZLM_SA2NOM"	OF oZLM ALIAS "ZLM" TITLE "Nome"       SIZE 30
DEFINE CELL NAME "ZLM_VENCTO"	OF oZLM ALIAS "ZLM" TITLE "1o Vencto"
DEFINE CELL NAME "ZLM_VLRPAR" 	OF oZLM ALIAS "ZLM" TITLE "Vlr Parc"   PICTURE cMasc1
DEFINE CELL NAME "ZLM_PARC" 	OF oZLM ALIAS "ZLM" TITLE "Qtd Par"
DEFINE CELL NAME "PARCPAG" 	    OF oZLM ALIAS "ZLM" TITLE "Pagas"      PICTURE "@E 999" BLOCK {|| nParcPag }
DEFINE CELL NAME "PARCRES" 	    OF oZLM ALIAS "ZLM" TITLE "Restante"   PICTURE "@E 999" BLOCK {|| (cAlias)->ZLM_PARC - nParcPag }
DEFINE CELL NAME "ZLM_TOTAL"	OF oZLM ALIAS "ZLM" TITLE "Emprestado" PICTURE cMasc2
DEFINE CELL NAME "PAGOPARC" 	OF oZLM ALIAS "ZLM" TITLE "Recebido"   PICTURE cMasc2 BLOCK {|| (cAlias)->ZLM_VLRPAR * nParcPag }
DEFINE CELL NAME "SALDOPARC" 	OF oZLM ALIAS "ZLM" TITLE "A Receber"  PICTURE cMasc2 BLOCK {|| ((cAlias)->ZLM_PARC - nParcPag)*(cAlias)->ZLM_VLRPAR }
DEFINE CELL NAME "ZLM_TIPO" 	OF oZLM ALIAS "ZLM" TITLE "Tipo"
DEFINE CELL NAME "ZLM_STATUS" 	OF oZLM ALIAS "ZLM" TITLE "Status"


//Processa Linha e retorna se vai ou nao imprimir a mesma
oZLM:SetLineCondition({|| ProcLin((cAlias)->ZLM_COD) })

//DEFINE BREAK oBreak OF oZLM WHEN {|| (cAlias)->ZLM_TIPO }
DEFINE FUNCTION FROM oZLM:Cell("ZLM_VLRPAR") FUNCTION SUM
DEFINE FUNCTION FROM oZLM:Cell("ZLM_TOTAL" ) FUNCTION SUM
DEFINE FUNCTION FROM oZLM:Cell("PAGOPARC"  ) FUNCTION SUM
DEFINE FUNCTION FROM oZLM:Cell("SALDOPARC" ) FUNCTION SUM

oReport:PrintDialog()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PrintReport º Autor ³ TOTVS                 º Data da Criacao  ³ 29/09/2008             						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Funcao estatica que faz os filtros do relatorio.			                               						º±±
±±º			 ³														                                   						º±±
±±º          ³ 															                               						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ 	Tabela ZLM				                               						                                º±±
±±º			 ³														                                   						º±±
±±º          ³ 															                               						º±±
±±º          ³ 															                               						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ 	Objeto oReport																								º±±
±±º			 ³												   					                       						º±±
±±º			 ³																												º±±
±±º			 ³														                                   						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ Nenhum						  							                               						º±±
±±º			 ³														                                   						º±±
±±º			 ³														                                   						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUsuario   ³ Totvs / Microsiga											                             					º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºSetor     ³ Gestao do Leite                                                                          					º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL                   						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor     ³ Data     ³ Motivo da Alteracao  				               ³Usuario(Filial+Matricula+Nome)    ³Setor        º±±
±±ºÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄº±±
±±º          ³          ³                   							   ³                                  ³  	        º±±
±±º----------³----------³--------------------------------------------------³----------------------------------³-------------º±±
±±º          ³          ³                    							   ³                                  ³ 			º±±
±±º----------³----------³--------------------------------------------------³----------------------------------³-------------º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport)

Local _cFiltro := "%"
Local nOrdem   := 1
Local cOrdem   := ""

//Define o filtro de acordo com os parametros digitados
_cFiltro += " AND ZLM_SA2COD BETWEEN '"+ MV_PAR01 + "' AND '" + MV_PAR02 + "'"
_cFiltro += " AND ZLM_SA2LJ  BETWEEN '"+ MV_PAR03 + "' AND '" + MV_PAR04 + "'"
_cFiltro += " AND A2_L_LI_RO BETWEEN '"+ MV_PAR05 + "' AND '" + MV_PAR06 + "'"
_cFiltro += " AND ZLM_DATA   BETWEEN '"+ DtoS(MV_PAR07) + "' AND '" + DtoS(MV_PAR08) + "'"

If MV_PAR09 == 1//Adiantamento
	_cFiltro += " AND ZLM_TIPO = 'A'"
ElseIf MV_PAR09 == 2//Emprestimo
	_cFiltro += " AND ZLM_TIPO = 'E'"
EndIf

If MV_PAR10 == 1//Aberto
	_cFiltro += " AND ZLM_STATUS = '1'"
ElseIf MV_PAR10 == 2//Aprovado
	_cFiltro += " AND ZLM_STATUS = '2'"
ElseIf MV_PAR10 == 3//Reprovado
	_cFiltro += " AND ZLM_STATUS = '3'"
ElseIf MV_PAR10 == 4//Efetivado
	_cFiltro += " AND ZLM_STATUS = '4'"
EndIf


If Len(AllTrim(_cFiltro)) == 0
	_cFiltro := "%%"
Else
	_cFiltro += "%"
EndIf

//Tratamento para montar a ordem de impressao do relatorio
nOrdem := oZLM:GetOrder()

If nOrdem == 1//Codigo
	cOrdem := "%ZLM_FILIAL,ZLM_COD%"
ElseIf nOrdem == 2//Produtor+Loja
	cOrdem := "%ZLM_FILIAL,ZLM_SA2COD,ZLM_SA2LJ%"
ElseIf nOrdem == 3//Nome
	cOrdem := "%ZLM_FILIAL,ZLM_SA2NOM%"
ElseIf nOrdem == 4//Vlr.Parcela
	cOrdem := "%ZLM_FILIAL,ZLM_VLRPAR%"
Else//Data
	cOrdem := "%ZLM_FILIAL,ZLM_DATA%"
EndIf

BEGIN REPORT QUERY oReport:Section(1)
BeginSql alias cAlias
	SELECT
	ZLM_COD,ZLM_SA2COD,ZLM_SA2LJ,ZLM_SA2NOM,ZLM_VENCTO,ZLM_TOTAL,ZLM_PARC,ZLM_VLRPAR,ZLM_TIPO,ZLM_STATUS,A2_L_LI_RO
	FROM
	%table:ZLM% ZLM, %table:SA2% SA2
	WHERE
	ZLM_FILIAL = %xfilial:ZLM% AND ZLM.%notDel%
	AND A2_FILIAL = %xfilial:SA2% AND SA2.%notDel%
	AND A2_COD  = ZLM_SA2COD
	AND A2_LOJA = ZLM_SA2LJ
	%exp:_cFiltro%
	ORDER BY
	%exp:cOrdem%
EndSql
END REPORT QUERY oReport:Section(1)

oReport:Section(1):SetParentQuery()
oReport:Section(1):Print(.T.)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³ ProcLin  º Autor ³ Microsiga          º Data ³  00/00/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Funcao para processar os registros do relatorio, para cada º±±
±±º          ³ produtor impresso, esta funcao atualiza as variaveis de    º±±
±±º          ³ acordo com os dados do produtor em questao.                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal.                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ProcLin(cCodEmp)

Local cSeek    := ""

//Limpa a variavel
nParcPag := 0

//Posiciona no emprestimo
dbSelectArea("ZLM")
dbSetOrder(1)//ZLM_FILIAL+ZLM_COD
dbSeek(xFilial("ZLM")+cCodEmp)
If ZLM->ZLM_STATUS == "4"
	// -----------------------------------------
	// Obtendo Parametos dos EMPRESTIMOS
	// -----------------------------------------
	If ZLM->ZLM_TIPO == "E"
		cSeek := xFilial("SE1")+"GLE"+cCodEmp
	EndIf

	// -----------------------------------
	// Obtendo Parametos dos ADIANTAMENTOS
	// -----------------------------------
	If ZLM->ZLM_TIPO == "A"
		cSeek := xFilial("SE2")+"GLA"+cCodEmp
	EndIf

	dbSelectArea("SE1")
	dbSetOrder(1)
	dbSeek(cSeek,.T.)

	While SE1->(!Eof()) .And. cSeek == SE1->(E1_FILIAL+E1_PREFIXO+E1_NUM)

		If ZLM->(ZLM_SA2COD+ZLM_SA2LJ) == SE1->(E1_CLIENTE+E1_LOJA)
			If !Empty(SE1->E1_BAIXA)
				nParcPag++
			EndIf
		EndIf

		SE1->(dbSkip())
	EndDo
EndIf

Return(.T.)