#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "protheus.ch"
#Include 'TopConn.ch'


//=================================================================
// Rotina para impressão de código de barras do Produtor -
// DIGICERTO
//=================================================================
// Totvs Triangulo Mineiro
// Analista - José Rogério do Prado Jr
//================================================================

user function RGLT100()
	Local lFinal	:= .T.
 
	If ValidPerg()
		MsAguarde({|| ImpEtiq() },"Impressão de etiqueta","Aguarde...")
	EndIf
 
Return
 
Static Function ImpEtiq()
	Local cQuery	:= ""
	Local cProdDe	:= MV_PAR01
	Local cProdAte	:= MV_PAR02
	Local nQuant	:= MV_PAR03
	Local cImpress  := ""
	Local cLogo 	:= "\system\lgmid01.png"
	Local oFont16	:= TFont():New('Arial',16,16,,.F.,,,,.T.,.F.,.F.)
	Local oFont16N	:= TFont():New('Arial',16,16,,.T.,,,,.T.,.F.,.F.)
	Local oFont24N	:= TFont():New('Arial',24,24,,.T.,,,,.T.,.F.,.F.)
 
	Local lAdjustToLegacy 	:= .F.
	Local lDisableSetup  	:= .T.
 
	Local nLin		:= 0
	Local nCol		:= 0
	Local nLinC		:= 0
	Local nColC		:= 0
	Local nWidth	:= 0
	Local nHeigth   := 0
	Local lBanner	:= .T.		//Se imprime a linha com o código embaixo da barra. Default .T.
	Local nPFWidth	:= 0
	Local nPFHeigth	:= 0
	Local lCmtr2Pix	:= .T.		//Utiliza o método Cmtr2Pix() do objeto Printer.Default .T.
 
	MsProcTxt("Identificando a impressora...")
 
	//Private oPrinter := FWMSPrinter():New("produtor"+Alltrim(__cUserID)+".etq",IMP_SPOOL,lAdjustToLegacy,"/spool/",lDisableSetup,,,Alltrim(cImpress) /*parametro que recebe a impressora*/)
	
	Private oPrinter := FWMSPrinter():New("CodBarras.pdf",6,.T.)
		
	cQuery := " SELECT A2_COD, A2_LOJA, A2_NOME "
	cQuery += " FROM " + RetSqlName("SA2") + " SA2 " 
	cQuery += " WHERE A2_L_TPFOR = 'P' AND A2_MSBLQL <> '1' AND SA2.D_E_L_E_T_ = '' " 
	cQuery += " AND A2_COD >= '"+MV_PAR01+"' AND A2_COD <= '"+MV_PAR02+"' "
 
	TcQuery cQuery New Alias "QRYTMP"
	QRYTMP->(DbGoTop())
 
	oPrinter:SetMargin(001,001,001,001)
 
	oPrinter:StartPage()

	nLin := 200
	nCol := 100

	nLinC	:= 15		//Linha que será impresso o Código de Barra
	nColC	:= 5		//Coluna que será impresso o Código de Barra

	While QRYTMP->(!Eof())
		For nR := 1 to nQuant
 
			MsProcTxt("Imprimindo "+alltrim(QRYTMP->A2_COD) + " - " + alltrim(QRYTMP->A2_NOME)+"...")
 
			oPrinter:SayBitmap(nLin-100,nCol,cLogo,400,450)
 
			nLin+=300
			
			//cCodPrd := Substr(AllTrim(QRYTMP->A2_COD),2,5)
			//cCodPrd := Strzero(Val(cCodPrd),10)
			cCodPrd := PADR(SubStr(QRYTMP->A2_COD,2,5)+Alltrim(QRYTMP->A2_LOJA),10,"0")
			If Len(AllTrim(QRYTMP->A2_NOME)) >= 30 
				//oPrinter:Say(nLin,750,QRYTMP->A2_NOME,oFont24N)
				oPrinter:SayAlign(nLin,650,AllTrim(QRYTMP->A2_NOME),oFont24N,1400, 200, , 0, 2 )
			
			ElseIf Len(AllTrim(QRYTMP->A2_NOME)) <= 25
				//oPrinter:Say(nLin,750,QRYTMP->A2_NOME,oFont24N)
				oPrinter:SayAlign(nLin,850,AllTrim(QRYTMP->A2_NOME),oFont24N,1400, 200, , 0, 2 )
				
			Else
				//oPrinter:Say(nLin,750,QRYTMP->A2_NOME,oFont24N)
			    oPrinter:SayAlign(nLin,750,AllTrim(QRYTMP->A2_NOME),oFont24N,1400, 200, , 0, 2 )
			
			Endif
			
			nLin+= 200
 
			//nLinC		:= 50//4.95		//Linha que será impresso o Código de Barra
			//nColC		:= 5//1.6		//Coluna que será impresso o Código de Barra
			nWidth	 	:= 0.0164      //0.0164	//Numero do Tamanho da barra. Default 0.025 limite de largura da etiqueta é 0.0164
			nHeigth   	:= 0.3 //0.7		//Numero da Altura da barra. Default 1.5 --- limite de altura é 0.3
			lBanner		:= .T.		//Se imprime a linha com o código embaixo da barra. Default .T.
			nPFWidth	:= 0.7//0.8		//Número do índice de ajuste da largura da fonte. Default 1
			nPFHeigth	:= 0.9		//Número do índice de ajuste da altura da fonte. Default 1
			lCmtr2Pix	:= .T.		//Utiliza o método Cmtr2Pix() do objeto Printer.Default .T.
			
            //oPrinter:FWMSBAR("CODE3_9" ,nLinC, 15, cCodPrd, oPrinter,/*lCheck*/,/*Color*/,/*lHorz*/, nWidth, nHeigth,lBanner,"Arial"/*cFont*/,/*cMode*/,.F./*lPrint*/,nPFWidth,nPFHeigth,lCmtr2Pix)
              
              oPrinter:FWMSBAR("CODE3_9" /*cTypeBar*/,nLinC/*nRow*/ ,20/*nCol*/, alltrim(cCodPrd) /*cCode*/,oPrinter/*oPrint*/,.F. /*lCheck*/,/*Color*/,/*lHorz*/,/*nWidth*/,1.5/*nHeigth*/,/*lBanner*/,"ARIAL"/*cFont*/,/*cMode*/,.F./*lPrint*/,/*nPFWidth*/,/*nPFHeigth*/,/*lCmtr2Pix*/)  
                                								   //15																											 //1        
            nLinC	+= 28 //22
 
			nLin+= 300
			
			oPrinter:Say(nLin,nCol+900,"*"+cCodPrd+"*",oFont24N)
 
			nLin += 450 //200
			
		Next
		oPrinter:EndPage()
		
		nLin := 200
		nCol := 100
		nLinC	:= 15		//Linha que será impresso o Código de Barra
		nColC	:= 5		//Coluna que será impresso o Código de Barra
		oPrinter:StartPage()
		
		QRYTMP->(DbSkip())
	EndDo
	oPrinter:Print()
	QRYTMP->(DbCloseArea())
 
Return
 
/*Montagem da tela de perguntas*/
Static Function ValidPerg()
	Local aRet 		:= {}
	Local aParamBox	:= {}
	Local lRet 		:= .F.
	Local aOpcoes	:= {}
	Local cProdDe	:= ""
	Local cProdAte	:= ""
	Local cLocal	:= Space(99)
 
	aOpcoes := {"PDFCreator"}
	cProdDe := space(TamSX3("B1_COD")[1])
	cProdAte:= REPLICATE("Z",TAMSX3("B1_COD")[1])
 
	aAdd(aParamBox,{01,"Produtor de"	  			,cProdDe 	,""					,"","SA2_L4"	,"", 60,.F.})	// MV_PAR01
	aAdd(aParamBox,{01,"Produtor ate"	    		,cProdAte	,""					,"","SA2_L4"	,"", 60,.T.})	// MV_PAR02
	aAdd(aParamBox,{01,"Quantidade Etiqueta"		,1			,"@E 9999"			,"",""		,"", 60,.F.})	// MV_PAR03
	//aadd(aParamBox,{02,"Imprimir em"				,Space(50)	,aOpcoes			,100,".T.",.T.,".T."})		// MV_PAR04
 
	If ParamBox(aParamBox,"Etiqueta Produto",/*aRet*/,/*bOk*/,/*aButtons*/,.T.,,,,FUNNAME(),.T.,.T.)
 
		//If ValType(MV_PAR04) == "N" //Algumas vezes ocorre um erro de ao invés de selecionar o conteúdo, seleciona a ordem, então verifico se é numerico, se for, eu me posiciono na impressora desejada para pegar o seu nome
		//	MV_PAR04 := aOpcoes[MV_PAR04]
		//EndIf
 
		lRet := .T.
	EndIf
Return lRet
