#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "AP5MAIL.CH"
#include "topconn.ch"
#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"

/*/{Protheus.doc} User Function GLEPY215
	Reçatório de Mapa de produção de leite
	@type  Function
	@author José Neto
	@since 16/12/2021
	@version 1.0
	/*/

User Function GLEPY215()
	LOCAL cString		:= "ZLD"
	Local titulo 		:= ""
	LOCAL wnrel		 	:= "GLEPY215"
	LOCAL cDesc1	    := "Relatorio de Mapa de Recebimento de Leite"
	LOCAL cDesc2	    := "conforme parametro"
	PRIVATE cPerg	 	:= Padr("GLEPY215",10)
	PRIVATE aLinha		:= {}
	PRIVATE nomeProg 	:= "GLEPY215"
	PRIVATE lEnd        := .F.
	Private oPrint
	PRIVATE nSalto      := 50
	PRIVATE lFirstPage  := .T.
	Private oBrush  	:= TBrush():NEW("",CLR_HGRAY)
	Private oBrushG  	:= TBrush():NEW("",CLR_YELLOW)
	Private oPen		:= TPen():New(0,5,CLR_BLACK)
	PRIVATE oCouNew08	:= TFont():New("Courier New"	,08,08,,.F.,,,,.T.,.F.)
	PRIVATE oCouNew08N	:= TFont():New("Courier New"	,08,08,,.T.,,,,.F.,.F.)		// Negrito //oCouNew09N
	PRIVATE oCouNew09N	:= TFont():New("Courier New"	,09,09,,.T.,,,,.F.,.F.)		// Negrito //oCouNew09N
	PRIVATE oCouNew10N	:= TFont():New("Courier New"	,10,10,,.T.,,,,.F.,.F.)		// Negrito
	PRIVATE oCouNew12N	:= TFont():New("Courier New"	,12,12,,.T.,,,,.F.,.F.)		// Negrito
	PRIVATE oCouNew11N	:= TFont():New("Courier New"	,11,11,,.T.,,,,.F.,.F.)		// Negrito
	PRIVATE oCouNew11 	:= TFont():New("Courier New"	,11,11,,.F.,,,,.T.,.F.)
	PRIVATE oArial08N	:= TFont():New("Arial"			,08,08,,.T.,,,,.F.,.F.)		// Negrito
	PRIVATE oArial09N	:= TFont():New("Arial"			,11,11,,.T.,,,,.F.,.F.)		// Negrito
	PRIVATE oArial09	:= TFont():New("Arial"			,11,11,,.F.,,,,.F.,.F.)		// Negrito
	PRIVATE oArial10N	:= TFont():New("Arial"			,10,10,,.T.,,,,.F.,.F.)		// Negrito
	PRIVATE oArial11N	:= TFont():New("Arial"			,11,11,,.T.,,,,.F.,.F.)		// Negrito
	PRIVATE oArial12N	:= TFont():New("Arial"			,12,12,,.T.,,,,.F.,.F.)		// Negrito
	PRIVATE oArial12	:= TFont():New("Arial"			,12,12,,.F.,,,,.F.,.F.)
	PRIVATE oArial14N	:= TFont():New("Arial"			,14,14,,.T.,,,,.F.,.F.)		// Negrito
	PRIVATE oCouNew12S	:= TFont():New("Courier New",12,12,,.T.,,,,.F.,.F.)		// SubLinhado
	Private nReg 		:= 0

	Pergunte(cPerg,.f.)
	@ 096,042 TO 323,505 DIALOG oDlg TITLE OemToAnsi("MAPA DE RECEBIMENTO DE LEITE")
	@ 008,010 TO 084,222
	@ 018,020 SAY OemToAnsi(cDesc1)
	@ 030,020 SAY OemToAnsi(cDesc2)
	@ 095,120 BMPBUTTON TYPE 5 	ACTION Pergunte(cPerg,.T.)

	@ 095,155 BMPBUTTON TYPE 1  ACTION Eval( { || nOpcRel := 1, oDlg:End() } )
	@ 095,187 BMPBUTTON TYPE 2  ACTION Eval( { || nOpcRel := 0, oDlg:End() } )
	ACTIVATE DIALOG oDlg CENTERED

	IF nOpcRel == 1
		Processa({ |lEnd| COMR01Cfg("Impressao do Mapa de Recebimento de Leite")},"Imprimindo , aguarde...")
		Processa({|lEnd| C110PC(@lEnd,wnRel,cString,nReg)},titulo)
	Else
		Return .f.
	Endif

Return .T.


//Cria os objetos para relat. grafico.

Static Function COMR01Cfg(Titulo)
	Local cFilename := 'relestat'

	lAdjustToLegacy := .T.   //.F.
	lDisableSetup  := .T.
	oPrint := FWMSPrinter():New(cFilename, IMP_PDF, lAdjustToLegacy, , lDisableSetup)
	oPrint:SetResolution(78)
	oPrint:SetLandsCape()
	oPrint:SetPaperSize(DMPAPER_A4)
	oPrint:SetMargin(10,10,10,10) // nEsquerda, nSuperior, nDireita, nInferior
	oPrint:cPathPDF := "C:\TEMP\" // Caso seja utilizada impressão em IMP_PDF
	cDiretorio := oPrint:cPathPDF

	If	MAKEDIR('C:\TEMP')!= 0
		return nil
	EndIf

Return Nil

//Chama o relatório

Static Function C110PC(lEnd,WnRel,cString,nReg)
	Private cCGCPict, cCepPict

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Definir as pictures                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	cQueryCad := "	SELECT ZLD_RETIRO AS INSCRICAO, ZLD_RETILJ, SUM(d.zld_qtdbom) AS L_BOM, A.A2_MUN AS MUNICIPIO, d.zld_linrot AS LINHA, D.ZLD_DESLIN AS NOME_LINHA, D.ZLD_SETOR AS SETOR "
	cQueryCad += "  FROM " + RetSqlName("ZLD") + " D "
	cQueryCad += "  INNER JOIN " + RetSqlName("SA2") + " A ON A2_COD = ZLD_RETIRO AND A2_LOJA = ZLD_RETILJ  "
	cQueryCad += "  WHERE ZLD_DTCOLE  BETWEEN '" + DtoS(MV_PAR01) + "' AND '" + DtoS(MV_PAR02) + "' "
	cQueryCad += "  AND ZLD_SETOR = '000002'"
	cQueryCad += "  AND A.A2_EST ='MG' "
	cQueryCad += "  GROUP BY ZLD_LINROT, A2_MUN, ZLD_FILIAL, ZLD_RETIRO, ZLD_RETILJ, ZLD_DESLIN, ZLD_SETOR "
	cQueryCad += "  ORDER BY ZLD_LINROT,ZLD_RETIRO "

	TCQUERY cQueryCad NEW ALIAS "CADTMP"

	TcSetField('CADTMP','ZLD_DTCOLE','D')

	Count To nReg

	CADTMP->(dbGoTop())

	If Empty(nReg)
		MsgAlert("Atenção Não Foram Encontrados Dados no Filtro Gerado !","Atenção !")
		CADTMP->(dbCloseArea())
		Return .f.
	Endif

	li       	:= 5000
	nPg		 	:= 0
	nTotal  	:= 0
	nQtdReg		:= 0
	cLinha := CADTMP->LINHA

	ProcRegua(nReg,"Aguarde a Impressao")
	While CADTMP->(!Eof())
		IncProc()

		SA2->(dbSetOrder(1), dbSeek(xFilial("SA2")+CADTMP->INSCRICAO+CADTMP->ZLD_RETILJ))
		ZLD->(dbSetOrder(1), dbSeek(xFilial("ZLD")+CADTMP->INSCRICAO))

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se havera salto de formulario                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If li > 1900
			If Li <> 5000
				oPrint:EndPage()
			Endif

			nPg++
			ImpCabec()
			//cLinha := ""
		Endif

		If lEnd
			oPrint:Say(Li,030,"CANCELADO PELO OPERADOR",oArial12N)
			Goto Bottom
			Exit
		Endif

		If cLinha <> CADTMP->LINHA
			oPrint:FillRect({li-1,031,li-040,2499},oBrush)

			oPrint:Say(li,0300,'TOTAL: ',oArial12N,,,,1)

			oPrint:Say(li,0600,TransForm(nTotal,"999,999,999.99"),oArial12N,,,,1)
			oPrint:Say(li,1500,'QTD REGISTROS: '+TransForm(nQtdReg,"999"),oArial12N,,,,1)
			nTotal := 0
			nQtdReg := 0
			cLinha := CADTMP->LINHA
			li+=80

		EndIf

		oPrint:Say(li,0050,CADTMP->INSCRICAO,oArial12)
		oPrint:Say(li,0300,Capital(CADTMP->ZLD_RETILJ),oArial12)
		oPrint:Say(li,0500,TransForm((CADTMP->L_BOM),"999,999.99"),oArial12,,,,1)
		oPrint:Say(li,0800,Capital(CADTMP->MUNICIPIO),oArial12,,,,1)
		oPrint:Say(li,1500,CADTMP->LINHA,oArial12,,,,1)
		oPrint:Say(li,2000,CADTMP->NOME_LINHA,oArial12,,,,1)

		nTotal	+= Round(CADTMP->L_BOM,2)
		nQtdReg ++

		li+=50

		CADTMP->(DbSkip(1))

	EndDo

	If li <> 5000
		li+=080

		oPrint:FillRect({li-1,031,li-040,2499},oBrush)
		oPrint:Say(li,0300,'TOTAL: ',oArial09N,,,,1)
		oPrint:Say(li,0600,TransForm(nTotal,"999,999,999.99"),oArial09N,,,,1)
		oPrint:Say(li,1500,'QTD REGISTROS: '+TransForm(nQtdReg,"999"),oArial09N,,,,1)
		oPrint:EndPage()
		oPrint:Preview()  				// Visualiza antes de imprimir
	Endif

	CADTMP->(dbCloseArea())

Return .T.

//Imprime cabealho

Static Function ImpCabec()

	oPrint:StartPage() 		// Inicia uma nova pagina
	oPrint:Say(210,1600,dTos(dDataBase),oArial14N)
	oPrint:Say(0320,0050,"INSCRICAO",oArial09N)
	oPrint:Say(0320,0300,"LOJA",oArial09N)
	oPrint:Say(0320,0500,"L. BOM",oArial09N)
	oPrint:Say(0320,0800,"MUNICIPIO",oArial09N)
	oPrint:Say(0320,1500,"LINHA",oArial09N)
	oPrint:Say(0320,2000,"NOME LINHA",oArial09N)

	li := 420
Return