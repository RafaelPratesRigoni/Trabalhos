#INCLUDE 'TOTVS.ch'
#INCLUDE 'FWMVCDEF.ch'
#INCLUDE "TOPCONN.CH"
#Include 'Protheus.ch'
#INCLUDE "FWMBROWSE.CH"

Static cTitulo := "Etiquetas Produção Leite"


/*/{Protheus.doc} PCPAY011
@type function
@description Rotina para Geração e impressão de etiquetas na rastreabilidade de ovos no entreposto
@author Alexandre Fortunato Ribeiro
@since 06/05/2020
@version 1.0
/*/



/*/{Protheus.doc} PCPAY11P
//Tela para geração de Etiquetas
@author Mark dos Santos Gonçalves
@since 06/01/2021
@return 
@type function
/*/
User Function AGLT200()

	Local oButton1
	Local oButton2
	Local oSay1
	Local oSay2
	Local oSay3
	Local oSay4
	Local oSay5
	Local oSay6
	Local oSay7
	Local oSay8
	Local oSay9
	Local oSay10
	Local oSay11
	Local oSay12

	Private cImprime := .T.

	Static oDlg
	Static oPanel1
	Static oPanel2
	Static oGet1
	Static cCodTanque := Space(6)
	Static oGet2
	Static cDescTanque := Space(40)
	Static oGet3
	Static cCodPart := Space(6)
	Static oGet2
	Static cDescPart := Space(40)
	Static oGet3

	DEFINE FONT oBold NAME "Arial" SIZE 08, 17 BOLD


	Private lInverte := .F.
	Private cMark   := GetMark()
	Private oMark


	DEFINE MSDIALOG oDlg TITLE "Imprimir Etiqueta" FROM 000, 000  TO 100, 800 COLORS 0, 16777215 PIXEL

	//oDlg:lMaximized := .T.

	@ 002, 002 MSPANEL oPanel1 SIZE 400, 050 OF oDlg COLORS 0, 16777215 RAISED

	@ 005, 004 SAY oSay1 PROMPT "Cod. Tanque" SIZE 040, 007 OF oPanel1 COLORS 0, 16777215 PIXEL
	@ 004, 047 MSGET oGet1 VAR cCodTanque Valid(fValTanque()) SIZE 025, 010 OF oPanel1 COLORS 0, 16777215 PIXEL
	@ 005, 075 SAY oSay2 PROMPT "Descrição" SIZE 045, 007 OF oPanel1 COLORS 0, 16777215 PIXEL
	@ 004, 115 MSGET oGet2 VAR cDescTanque When .F. SIZE 155, 010 OF oPanel1 COLORS 0, 16777215 PIXEL

	@ 021, 004 SAY oSay1 PROMPT "Cod. Participante" SIZE 040, 007 OF oPanel1 COLORS 0, 16777215 PIXEL
	@ 020, 047 MSGET oGet1 VAR cCodPart SIZE 025, 010 OF oPanel1 COLORS 0, 16777215 PIXEL
	@ 021, 075 SAY oSay2 PROMPT "Descrição" SIZE 045, 007 OF oPanel1 COLORS 0, 16777215 PIXEL
	@ 020, 115 MSGET oGet2 VAR cDescPart When .F. SIZE 155, 010 OF oPanel1 COLORS 0, 16777215 PIXEL

	@ 005, 330 BUTTON oButton1 PROMPT "Imprimir" SIZE 030, 030 OF oPanel1 PIXEL
	@ 005, 365 BUTTON oButton2 PROMPT "Cancelar" SIZE 030, 030 OF oPanel1 PIXEL

	oButton2:bAction    := {|| oDlg:End() }
	oButton1:bAction    := {|| FwMsgRun(,{ || AGLT200A(cCodTanque, cCodPart) }, 'Aguarde', 'Imprimindo Etiquetas...') }

	//fMSNewGe1()

	ACTIVATE MSDIALOG oDlg CENTERED

Return

/*/{Protheus.doc} AGLT200A
//Função para geração de etiquetas
@author Mark dos Santos Gonçalves
@since 06/01/2021
@return 
@type function
/*/
Static Function AGLT200A(cCodTanque, cCodParticipante)

	Local cAliasS1	:= GetNextAlias()

	BeginSQL Alias cAliasS1
		SELECT ZLS_FILIAL, ZLS_COD, ZLS_DESCRI, ZLT_SA2COD, ZLT_SA2LJ, ZLT_SA2NOM
		FROM %Table:ZLS% ZLS
		JOIN %Table:ZLT% ZLT
			ON	ZLT.%NotDel%
			AND	ZLT.ZLT_COD = ZLS.ZLS_COD
            //AND (%Exp:cCodParticipante% = %Exp:""% OR ZLT.ZLT_SA2COD = %Exp:cCodParticipante%  )
            //AND (%Exp:cCodProdutor% = %Exp:""% OR (ZLT.ZLT_SA2COD = %Exp:cCodProdutor%  AND ZLT.ZLT_SA2LJ = %Exp:cCodProdutor% ))
		WHERE	ZLS.%NotDel%
			AND ZLS.ZLS_COD = %Exp:cCodTanque% 
			AND ZLS.ZLS_FILIAL = %Exp:FwFilial("ZLS")%
	EndSQL

	AGLT200B(cAliasS1)
Return

/*/{Protheus.doc} PCPAY11J
//Inicia ou termina a impressão
@author Mark dos Santos Gonçalves
@since 10/07/2020
@return 
@type function
/*/
Static Function AGLT200B(cAliasS1)

	Local aArea    		:= GetArea()
	Local cTit			:= "COOP .AGROP. CENTRO SERRANA"
	Local nBorda		:= 40 //65
	Local nBorda2		:= 535 //635
	Local nBorda3		:= 600 //700
	Local nSalto		:= 60

	//	Private oPrint		:= Nil
	Private nLin		:= 0030
	Private nLinha      := 0
	Private oFont05     := TFont():New("Arial"	,,05,,.F.,,,,.T.,.F.)
	Private oFont08     := TFont():New("Arial"	,,08,,.F.,,,,.T.,.F.)
	Private oFont08N    := TFont():New("Arial"	,,08,,.T.,,,,.T.,.F.)
	Private oFont09     := TFont():New("Verdana",,09,,.F.,,,,.T.,.F.)
	Private oFont10     := TFont():New("Verdana",,10,,.F.,,,,.T.,.F.)
	Private oFont10N    := TFont():New("Verdana",,10,,.T.,,,,.T.,.F.)
	Private oFont12N    := TFont():New("Verdana",,12,,.T.,,,,.T.,.F.)
	Private oFont12     := TFont():New("Verdana",,12,,.F.,,,,.T.,.F.)
	Private oFont13N    := TFont():New("Verdana",,13,,.T.,,,,.T.,.F.)
	Private oFont13     := TFont():New("Verdana",,13,,.F.,,,,.T.,.F.)
	Private oFont14N    := TFont():New("Verdana",,14,,.T.,,,,.T.,.F.)
	Private oFont14     := TFont():New("Verdana",,14,,.F.,,,,.T.,.F.)
	Private oFont16     := TFont():New("Verdana",,16,,.T.,,,,.T.,.F.)

	If	!cImprime
		Return cAliasS1
	EndIf

	cDefPrint := GetProfString(GetPrinterSession(), "DEFAULT", "", .T.)
	WriteProfString(GetPrinterSession(),"DEFAULT", cDefPrint, .T.)

	oPrint := FwMsPrinter():New( "Etiq_LEITE" )
	oPrint:SetPortrait()


	(cAliasS1)->(DbGoTop())
	//DbSelectArea("cAliasS1")
	//DbGotop()
	While (cAliasS1)->(!Eof())
		nLin := 0030
		// If	Alltrim(yTabEtiq->cCor) == "BRANCO"
		// 	cImgOvo	:= cOvoBR
		// Else
		// 	cImgOvo	:= cOvoVR
		// EndIf
		oPrint:StartPage()

        cTanque := (cAliasS1)->ZLS_COD
        cParticipante := (cAliasS1)->ZLT_SA2COD+(cAliasS1)->ZLT_SA2LJ

		//oPrint:Say  (nLin+=10 	,nBorda	,yTabEtiq->cCodPro + "  " + yTabEtiq->cDesPro	,oFont10N)
		oPrint:Say  (nLin+=50 		,nBorda	    ,"TANQUE"	        ,oFont16)
		oPrint:Say  (nLin 		    ,nBorda2	,"PARTICIPANTE"	    ,oFont16)

        oPrint:QrCode(nLin+=450     ,nBorda     ,cCodTanque         , 100 )
        oPrint:QrCode(nLin-30       ,nBorda2    ,cParticipante      , 80 )



		oPrint:Say  (nLin+=50 		,nBorda	    ,Alltrim((cAliasS1)->ZLS_COD) + " " + (cAliasS1)->ZLS_DESCRI	,oFont13N)
		oPrint:Say  (nLin    		,nBorda2	,Alltrim((cAliasS1)->ZLT_SA2NOM)	,oFont13N)

/*
		oPrint:Say  (nLin+= (nSalto/2)+10,nBorda, Space(7) +"CAIXA C/" + STRZERO(yTabEtiq->cQtEm2,2) + " " + Alltrim(yTabEtiq->cEmb2) + " X " +  STRZERO(yTabEtiq->cQtEm3,2) + " " + Alltrim(yTabEtiq->cEmb3)	,oFont13N)

		oPrint:Say  (nLin+= nSalto	,nBorda		,"TIPO : " + yTabEtiq->cTipo  ,oFont12N)
		oPrint:Say  (nLin			,nBorda2	,"COR  : " + yTabEtiq->cCor   ,oFont12N)

		oPrint:Say  (nLin+= nSalto	,nBorda		,"APRESENTAÇÃO: " + yTabEtiq->cApres	,oFont12N)
		oPrint:Say  (nLin			,nBorda2	,"FORMA: " + yTabEtiq->cForma ,oFont12N)

		oPrint:Say  (nLin+= nSalto	,nBorda		,"MARCA: " + yTabEtiq->cMarca	,oFont12N)
		oPrint:Say  (nLin			,nBorda2	,"LINHA: " + yTabEtiq->cLinha ,oFont12N)

		nLinha := nLin+40
		//           1     2    3      4    5      6      7     8      9      10     11      12    13     14    15       16
		//MSBAR3(cTypeBar,nRow,nCol,cCode,oPrint,lCheck,Color,lHorz,nWidth,nHeigth,lBanner,cFont,cMode,lPrint,nPFWidth,nPFHeigth)
		If	!Empty(yTabEtiq->cCodbar)
			cTypeBar  := "CODE128"       // Código do tipo do código de barras: "EAN13", "EAN8", "UPCA" , "SUP5" , "CODE128"
			nRow      := 7               // Posição relativa ao topo
			nCol      := 13              // Posição relativa à esquerda
			cCodeBar  := Alltrim(yTabEtiq->cCodBar) // Texto a ser transformado em código de barra
			lCheck    := .T.             // Se calcula o digito de controle. Defautl .T.
			cColor    := CLR_BLACK       // Numero da Cor, utilize a "color.ch". Default CLR_BLACK
			lHorz     := .T.             // Se imprime na Horizontal. Default .T.
			nWidth    := 0.030           // Numero do Tamanho da barra. Default 0.025
			nHeigth   := 1.4             // Numero da Altura da barra. Default 1.5
			lBanner   := .F.             // Se imprime a linha com o código embaixo da barra. Default .T.
			cFont     := "Arial"         // Nome do Fonte a ser utilizado. Defautl "Arial"
			cMode     := ""              // Modo do codigo de barras CO. Default ""
			lPrint    := .T.             // Se executa o método Print() de oPrinter pela MsBar. Default .T.
			nPFWidth  := 1               // Número do índice de ajuste da largura da fonte. Default 1
			nPFHeigth := 1               // Número do índice de ajuste da altura da fonte. Default 1
			lCmtr2Pix := .T.             // Utiliza o método Cmtr2Pix() do objeto Printer.Default .T.
			oPrint:Say  (nLin+= (nSalto*4)+15,nBorda3	, yTabEtiq->cCodbar ,oFont12N)
		EndIf

		If	!Empty(yTabEtiq->cGtin)
			cTypeBar  := "EAN13"         // Código do tipo do código de barras: "EAN13", "EAN8", "UPCA" , "SUP5" , "CODE128"
			nRow      := 7               // Posição relativa ao topo
			nCol      := 2               // Posição relativa à esquerda
			cCodeBar  := Alltrim(yTabEtiq->cGtin) // Texto a ser transformado em código de barra
			lCheck    := .T.             // Se calcula o digito de controle. Defautl .T.
			cColor    := CLR_BLACK       // Numero da Cor, utilize a "color.ch". Default CLR_BLACK
			lHorz     := .T.             // Se imprime na Horizontal. Default .T.
			nWidth    := 0.030           // Numero do Tamanho da barra. Default 0.025
			nHeigth   := 1.5             // Numero da Altura da barra. Default 1.5
			lBanner   := .T.             // Se imprime a linha com o código embaixo da barra. Default .T.
			cFont     := "Arial"         // Nome do Fonte a ser utilizado. Defautl "Arial"
			cMode     := ""              // Modo do codigo de barras CO. Default ""
			lPrint    := .T.             // Se executa o método Print() de oPrinter pela MsBar. Default .T.
			nPFWidth  := 1               // Número do índice de ajuste da largura da fonte. Default 1
			nPFHeigth := 1               // Número do índice de ajuste da altura da fonte. Default 1
			lCmtr2Pix := .T.             // Utiliza o método Cmtr2Pix() do objeto Printer.Default .T.
		EndIf

		//oPrint:SayBitmap( 150,1025,cImgOvo,150,150 )
		oPrint:SayBitmap( 150,950,cImgOvo,150,150 )
//*/
		oPrint:EndPage()

/*
		dbSelectArea("ZDY")
		ZDY->(DbSetOrder(1))

		If ZDY->(Dbseek(xFilial("ZDY")+PADR(yTabEtiq->cCodPro,6)+yTabEtiq->cSequen))
			RecLock('ZDY', .F.)
			If Empty(ZDY->ZDY_DTIMPR)
				ZDY->ZDY_DTIMPR := Date()
			Endif
			ZDY->(MsUnlock())
		Endif
        //*/
		//dbSelectArea("yTabEtiq")
		//dbSkip()
		(cAliasS1)->(DbSkip())
		loop
	Enddo
	(cAliasS1)->(DbCloseArea())

	oPrint:Print()
	//oPrint:End()

	RestArea(aArea)
	Sleep(500)

Return cAliasS1


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  fValTanque ºAutor  ³Mark S. Gonçalves  º Data ³ 08/10/2015   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para validacao do Tanque  		 				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ COMPRAS - COOPEAVI - PROCESSO LEITE                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function fValTanque()

	Local _aAreaZLS		:= ZLS->(GetArea())
	Local _lRet	   		:= .T.

	If _lRet .And. !(Empty(AllTrim(cCodTanque)))
		ZLS->(DbSetOrder(1))
		If ZLS->(DBSeek(xFilial("ZLS")+cCodTanque))
			cDescTanque	:= AllTrim(ZLS->ZLS_DESCRI)
		Else
			ShowHelpDlg("UNNAOENCONTRADO",{"Tanque não encontrado!"},5,{"Tanque não enontrado."},5)
			_lRet		:= .F.
			cDescTanque	:= ""
		EndIf
	EndIf

	RestArea(_aAreaZLS)

Return
