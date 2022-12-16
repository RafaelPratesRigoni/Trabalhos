#INCLUDE "RWMAKE.CH"
#INCLUDE "SHELL.CH"
#INCLUDE "Protheus.ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "RPTDEF.CH"
#INCLUDE "TOPCONN.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ RGLT036  บ Autor ณ Guilherme Fran็a      บ Data da Criacao  ณ 31/01/2019              						บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Informe de rendimentos para imposto de renda													  				บฑฑ
ฑฑบ          ณ 																											    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ  				             						                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 														 		บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ Num้rico														                             					บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUsuario   ณ Microsiga                                                                                					บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบSetor     ณ Gestใo do Leite		                                                                  						บฑฑ
ฑฑฬออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                   						บฑฑ
ฑฑฬออออออออออัออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออัออออออออออออออออออออออออออออออออออัอออออออออออออนฑฑ
ฑฑบAutor     ณ Data     ณ Motivo da Alteracao  				               ณUsuario(Filial+Matricula+Nome)    ณSetor        บฑฑ
ฑฑบฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤบฑฑ
ฑฑบ          ณ          ณ                                			       ณ                                  ณ   	        บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑบ          ณ          ณ                    							   ณ                                  ณ 			บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑศออออออออออฯออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออออออออออออออออออออออออออออออฯอออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function RGLT036()


Private cPerg 		:= "PRGLT36"
Private _cLogo 		:= GetSrvProfString("Startpath","") + "DANFE0101.bmp"//"lgrl01.bmp" //"DANFE01.bmp"
Private oPrinter
Private cNomePDF	:= 'RGLT036'

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCriacao das fontes.                                                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
PRIVATE oFontTit
PRIVATE oFontRod
PRIVATE oFont10
PRIVATE oFont10N
PRIVATE oFont14N
PRIVATE oFont14
PRIVATE oFont12
PRIVATE oFont12N
PRIVATE oFontA16N

If !Pergunte(cPerg,.T.)
	Return
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInicializacao do objeto grafico                                         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cNomePDF := 'informe_ir_'//+Alltrim(MV_PAR01)+'_'+Alltrim(MV_PAR02)

oPrinter := GetPrint(cNomePDF)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCriacao das fontes.                                                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oFontTit 	:= TFontEx():New(oPrinter,"Times New Roman",,016,,.T.,,,,,.F.,.F.)
oFontRod 	:= TFontEx():New(oPrinter,"Times New Roman",,015,,.T.,,,,,.F.,.F.)
oFont10  	:= TFontEx():New(oPrinter,"Arial",08,08,.F.,.T.,.F.)
oFont10N  	:= TFontEx():New(oPrinter,"Arial",08,08,.T.,.T.,.F.)
oFont14N 	:= TFontEx():New(oPrinter,"Arial",13,13,.T.,.T.,.F.)
oFont14  	:= TFontEx():New(oPrinter,"Arial",13,13,.F.,.T.,.F.)
oFont12 	:= TFontEx():New(oPrinter,"Arial",12,12,.F.,.T.,.F.)
oFont12N	:= TFontEx():New(oPrinter,"Arial",12,12,.T.,.T.,.F.)
oFontA16N 	:= TFontEx():New(oPrinter,"Arial",,015,,.T.,,,,,.F.,.F.)

Processa({|| PrintRel() },"Aguarde a abertura do relatorio...",)


Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPrintRel  บAutor  ณGuilherme Fran็a    บ Data ณ  23/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Impressao do relatorio.                                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function GetPrint(_pcFileName,_plAdjustToLegacy,cPathInServer,lDisabeSetup)
Local oPrinter
DEFAULT _pcFileName := "informe_ir_"
DEFAULT _plAdjustToLegacy := .f.
DEFAULT cPathInServer := GetTempPath()	// define local padrao para gerar arquivo
DEFAULT lDisabeSetup := .T. 			// .t. desabilita a tela de configura็ใo de impressao

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCriacao do objeto.                                                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

oPrinter := FWMSPrinter():New(_pcFileName+"_" + DtoS(Date())+ "_"+StrTran(Time(),':','-'), IMP_SPOOL, _plAdjustToLegacy,cPathInServer,lDisabeSetup)

oPrinter:SetDevice(IMP_SPOOL) //IMP_SPOOL=IMPRESSORA, IMP_PDF=PDF
oPrinter:SetPortrait() // Formato Retrato
oPrinter:SetPaperSize(9) // Papel A4
oPrinter:SetPaperSize(DMPAPER_A4) // Papel A4
oPrinter:SetMargin(10,10,10,10) // Margem
oPrinter:Setup()


Return oPrinter

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPrintRel  บAutor  ณGuilherme Fran็a    บ Data ณ  23/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Impressao do relatorio.                                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PrintRel()


Local _nTotAno := 0
Local _cMes := ""
Local _nSoma := 80
Private _nLinMax := 750 //800
Private _cCPF := ""
Private _nLin := 20
Private _cAlias1 := ""
Private _cAlias2 := ""
Private _cAlias3 := ""
Private _nCol01	:= 010
Private _nCol02 := 070
Private _nCol03 := _nCol02 + _nSoma
Private _nCol04 := _nCol03 + _nSoma
Private _nCol05 := _nCol04 + _nSoma
Private _nCol06 := _nCol05 + _nSoma
Private _nCol07 := _nCol06 + _nSoma
Private _nPag	:= 0
Private _dDtIni := ""
Private _dDtFim := ""
Private _aTotNF := {0,0,0,0,0,0}

_cAlias1 := QueryTRB("1") //Seleciona dados da NF

DbSelectArea(_cAlias1)
(_cAlias1)->(DbGoTop())

While !(_cAlias1)->(Eof())

	_cCPF := (_cAlias1)->CPF
	_nPag	:= 0

	Cabec()

	_nLin+= 15

	oPrinter:Say(_nLin,020,"FORNECIMENTO DE LEITE",oFont12N:oFont)
	_nLin+= 5
	_nLinMax := _nLin + 155
    oPrinter:Line( _nLin, _nCol02-10, _nLinMax, _nCol02-10)
    oPrinter:Line( _nLin, _nCol03-10, _nLinMax, _nCol03-10)
    oPrinter:Line( _nLin, _nCol04-10, _nLinMax, _nCol04-10)
    oPrinter:Line( _nLin, _nCol05-10, _nLinMax, _nCol05-10)
    oPrinter:Line( _nLin, _nCol06-10, _nLinMax, _nCol06-10)
    oPrinter:Line( _nLin, _nCol07-10, _nLinMax, _nCol07-10)

    _nLin+= 10
    oPrinter:Say(_nLin,_nCol01,"PERIODO",oFont10N:oFont)
    oPrinter:Say(_nLin,_nCol02,"VOLUME",oFont10N:oFont)
    oPrinter:Say(_nLin,_nCol03,"VLR.BRUTO",oFont10N:oFont)
    oPrinter:Say(_nLin,_nCol04,"(-)INSS",oFont10N:oFont)
    oPrinter:Say(_nLin,_nCol05,"(-)GILRAT",oFont10N:oFont)
    oPrinter:Say(_nLin,_nCol06,"(-)SENAR",oFont10N:oFont)
    oPrinter:Say(_nLin,_nCol07,"VLR.LIQUIDO",oFont10N:oFont)
    _nLin+= 10
    While !(_cAlias1)->(Eof()) .and. _cCPF == (_cAlias1)->CPF

		oPrinter:SayAlign( _nLin,_nCol01,StrZero((_cAlias1)->MES,2)+"/"+mv_par01,oFont10:oFont,50,10,,0,1 )
		oPrinter:SayAlign( _nLin,_nCol02,TRANSFORM((_cAlias1)->VOLUME,"@E 999,999,999"),oFont10:oFont,40,10,,1,1 )
		oPrinter:SayAlign( _nLin,_nCol03,TRANSFORM((_cAlias1)->VALOR ,"@E 999,999,999.99"),oFont10:oFont,60,10,,1,1 )
	    oPrinter:SayAlign( _nLin,_nCol04,TRANSFORM((_cAlias1)->INSS,"@E 999,999,999.99"),oFont10:oFont,60,10,,1,1 )
	    oPrinter:SayAlign( _nLin,_nCol05,TRANSFORM((_cAlias1)->GILRAT,"@E 999,999,999.99"),oFont10:oFont,60,10,,1,1 )
	    oPrinter:SayAlign( _nLin,_nCol06,TRANSFORM((_cAlias1)->SENAR,"@E 999,999,999.99"),oFont10:oFont,60,10,,1,1 )
		_nVlrLiq := (_cAlias1)->VALOR - (_cAlias1)->INSS - (_cAlias1)->GILRAT - (_cAlias1)->SENAR
	    oPrinter:SayAlign( _nLin,_nCol07,TRANSFORM(_nVlrLiq,"@E 999,999,999.99"),oFont10:oFont,60,10,,1,1 )
	    //Soma Totais
	    _aTotNF[1] += (_cAlias1)->VOLUME
	    _aTotNF[2] += (_cAlias1)->VALOR
	    _aTotNF[3] += (_cAlias1)->INSS
	    _aTotNF[4] += (_cAlias1)->GILRAT
	    _aTotNF[5] += (_cAlias1)->SENAR
	    _aTotNF[6] +=  _nVlrLiq
		_nLin+= 10
		(_cAlias1)->(DbSkip())
	EndDo
	_nLin+= 10
	//Imprime totais
	oPrinter:SayAlign( _nLin,_nCol01,"TOTAIS",oFont10:oFont,50,10,,0,1 )
	oPrinter:SayAlign( _nLin,_nCol02,TRANSFORM(_aTotNF[1],"@E 999,999,999"),oFont10:oFont,40,10,,1,1 )
	oPrinter:SayAlign( _nLin,_nCol03,TRANSFORM(_aTotNF[2] ,"@E 999,999,999.99"),oFont10:oFont,60,10,,1,1 )
    oPrinter:SayAlign( _nLin,_nCol04,TRANSFORM(_aTotNF[3],"@E 999,999,999.99"),oFont10:oFont,60,10,,1,1 )
    oPrinter:SayAlign( _nLin,_nCol05,TRANSFORM(_aTotNF[4],"@E 999,999,999.99"),oFont10:oFont,60,10,,1,1 )
    oPrinter:SayAlign( _nLin,_nCol06,TRANSFORM(_aTotNF[5],"@E 999,999,999.99"),oFont10:oFont,60,10,,1,1 )
    oPrinter:SayAlign( _nLin,_nCol07,TRANSFORM(_aTotNF[6],"@E 999,999,999.99"),oFont10:oFont,60,10,,1,1 )
	_aTotNF := {0,0,0,0,0,0}
    oPrinter:Line( _nLinMax+10, 005, _nLinMax+10,590)

    _nLin := _nLinMax + 30

    _cAlias2 := QueryTRB("2") //COMPRAS POR PERIODO

	oPrinter:Say(_nLin,020,"TOTAL DE COMPRAS POR PERอODO",oFont12N:oFont)
	_nLin+= 5
	_nLinMax := _nLin + 50
    oPrinter:Line( _nLin, _nCol03-10, _nLinMax, _nCol03-10)
    oPrinter:Line( _nLin, _nCol05-10, _nLinMax, _nCol05-10)
    _nLin+= 5

    oPrinter:SayAlign( _nLin,_nCol01,"JANEIRO...:",oFont10:oFont,50,10,,0,1 )
    oPrinter:SayAlign( _nLin,_nCol03,"FEVEREIRO.:",oFont10:oFont,50,10,,0,1 )
    oPrinter:SayAlign( _nLin,_nCol05,"MARวO.....:",oFont10:oFont,50,10,,0,1 )
    _nL01 := _nLin
    _nLin += 10
    oPrinter:SayAlign( _nLin,_nCol01,"ABRIL.....:",oFont10:oFont,50,10,,0,1 )
    oPrinter:SayAlign( _nLin,_nCol03,"MAIO......:",oFont10:oFont,50,10,,0,1 )
    oPrinter:SayAlign( _nLin,_nCol05,"JUNHO.....:",oFont10:oFont,50,10,,0,1 )
    _nL02 := _nLin
    _nLin += 10
    oPrinter:SayAlign( _nLin,_nCol01,"JULHO.....:",oFont10:oFont,50,10,,0,1 )
    oPrinter:SayAlign( _nLin,_nCol03,"AGOSTO....:",oFont10:oFont,50,10,,0,1 )
    oPrinter:SayAlign( _nLin,_nCol05,"SETEMBRO..:",oFont10:oFont,50,10,,0,1 )
    _nL03 := _nLin
    _nLin += 10
    oPrinter:SayAlign( _nLin,_nCol01,"OUTUBRO...:",oFont10:oFont,50,10,,0,1 )
    oPrinter:SayAlign( _nLin,_nCol03,"NOVEMBRO..:",oFont10:oFont,50,10,,0,1 )
    oPrinter:SayAlign( _nLin,_nCol05,"DEZEMBRO..:",oFont10:oFont,50,10,,0,1 )
    _nL04 := _nLin

	_nTotAno := 0

	While !(_cAlias2)->(Eof())

    	_cMes := StrZero((_cAlias2)->MES,2)
        //colunas
    	If _cMes $ '01/04/07/10'
    	 	_nCol := _nCol01+40
    	EndIf
    	If _cMes $ '02/05/08/11'
    	 	_nCol := _nCol03+40
    	EndIf
    	If _cMes $ '03/06/09/12'
    	 	_nCol := _nCol05+40
    	EndIf
    	//linhas
    	If _cMes $ '01/02/03'
    	 	_nLin := _nL01
    	EndIf
    	If _cMes $ '04/05/06'
    	 	_nLin := _nL02
    	EndIf
    	If _cMes $ '07/08/09'
    	 	_nLin := _nL03
    	EndIf
    	If _cMes $ '10/11/12'
    	 	_nLin := _nL04
    	EndIf

    	oPrinter:SayAlign( _nLin,_nCol,TRANSFORM((_cAlias2)->VALOR ,"@E 9,999,999.99"),oFont10:oFont,60,10,,1,1 )
    	_nTotAno +=  (_cAlias2)->VALOR

    	(_cAlias2)->(DbSkip())
    EndDo

    _nLin += 15
    oPrinter:SayAlign( _nLin,_nCol01,"TOTAL "+mv_par01,oFont10:oFont,50,10,,0,1 )
   	oPrinter:SayAlign( _nLin,_nCol01+40,TRANSFORM(_nTotAno ,"@E 99,999,999.99"),oFont10:oFont,60,10,,1,1 )

    (_cAlias2)->(DbCloseArea())

    _nLinMax+= 10

    oPrinter:Line( _nLin, 005, _nLin,590)


	oPrinter:EndPage()


ENDDO

(_cAlias1)->(DbCloseArea())

oPrinter:Preview()

oPrinter := Nil

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQueryTRB  บAutor  ณMicrosiga           บ Data ณ  09/02/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function QueryTRB(xOP)

Private _cCodPr		:= Alltrim(GetMv("LT_PRTRIBU")) //Codigo Produto
Private _cAlias := GetNextAlias()

If xOP == "1" //Levantamento das notas fiscais

	BeginSql alias _cAlias
		SELECT A2.A2_CGC AS CPF,
			ISNULL(MONTH(F1_EMISSAO),1) AS MES,
			ISNULL(SUM(CASE WHEN D1.D1_COD = %Exp:_cCodPr% THEN D1.D1_QUANT ELSE 0 END),0) AS VOLUME,
			ISNULL(SUM(D1.D1_TOTAL + D1.D1_VLINCMG),0) AS VALOR,
			ISNULL(SUM(D1_VALFUN),0) AS GILRAT,
			ISNULL(SUM(D1_VALINS),0) AS INSS,
			ISNULL(SUM(D1_VLSENAR),0) AS SENAR
		FROM %Table:SA2% A2
			LEFT JOIN %Table:SF1% F1 ON LEFT(F1_EMISSAO,4) =  %Exp:MV_PAR01%
						 AND A2.A2_COD = F1.F1_FORNECE
						 AND A2_LOJA = F1.F1_LOJA
						 AND F1_L_MIX <> ' '
						 AND F1.%NotDel%

			LEFT JOIN %Table:SD1% D1 ON D1.D1_FILIAL = F1.F1_FILIAL AND D1.D1_SERIE = F1.F1_SERIE
							   AND D1.D1_DOC = F1.F1_DOC AND D1.D1_FORNECE = F1.F1_FORNECE
							   AND D1.D1_LOJA = F1.F1_LOJA

							   AND D1.%NotDel%
		WHERE A2_COD BETWEEN %Exp:MV_PAR02% AND %Exp:MV_PAR03%
			  AND A2.%NotDel%
		GROUP BY A2.A2_CGC, MONTH(F1_EMISSAO)
		ORDER BY 1, 2
	EndSql



ElseIf xOP == "2" //Compras por perํodo

	BeginSql alias _cAlias
		SELECT A1.A1_CGC,
			MONTH(D2_EMISSAO) AS MES,
			SUM(D2.D2_TOTAL) AS VALOR
		FROM %Table:SD2% D2
			JOIN %Table:SA1% A1 ON A1_COD = D2.D2_CLIENTE AND A1_LOJA = D2.D2_LOJA
				AND A1.A1_CGC = %Exp:_cCPF%
				AND A1.%NotDel%
			JOIN %Table:SF4% F4 ON F4.F4_CODIGO = D2.D2_TES AND F4.F4_DUPLIC = 'S' AND F4.%NotDel%
		WHERE LEFT(D2_EMISSAO,4) = %Exp:MV_PAR01% AND  D2.%NotDel%
		GROUP BY A1.A1_CGC, MONTH(D2_EMISSAO)
		ORDER BY 1, 2
	EndSql

ElseIf xOP == "3" //pagamentos por perํodo

	BeginSql alias _cAlias
		SELECT A1.A1_CGC,
			MONTH(E5_DATA) AS MES,
			SUM(E5_VALOR) AS VALOR
		FROM %Table:SE5% E5
			JOIN %Table:SA1% A1 ON A1_COD = E5.E5_CLIFOR AND A1_LOJA = E5.E5_LOJA
			AND A1.A1_CGC = %Exp:_cCPF%
			AND A1.%NotDel%
		WHERE LEFT(E5_DATA,4) = %Exp:MV_PAR01%
		AND E5.E5_SITUACA = ' '
		AND E5.E5_RECPAG = 'R'
		AND E5.E5_MOTBX IN ('GLT','NOR','DEB','CMP')
		AND E5.E5_TIPODOC IN ('BA','VL','LJ')
		AND  E5.%NotDel%
		GROUP BY A1.A1_CGC, MONTH(E5_DATA)
		ORDER BY 1, 2
	EndSql
EndIf


Return _cAlias

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCabec()  บAutor  ณMicrosiga           บ Data ณ  09/02/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Cabec()

	_nPag++

	oPrinter:StartPage()

	oPrinter:Box(005,005,_nLinMax,590)
	oPrinter:SayBitmap(015,015,_cLogo,135,75)
	oPrinter:Line( 005, 170, 110, 170)
	oPrinter:Say(025,200,"INFORME DE RENDIMENTOS",oFontTit:oFont)
	oPrinter:Say(040,180,"Exercํcio: "+STR(val(mv_par01)+1,4)+Space(10)+"Ano Base: "+mv_par01,oFontTit:oFont)
	oPrinter:Line( 005, 495, 045, 495) // separador Data
	oPrinter:Say(020,505,"Emissใo: "+DTOC(dDataBase) 	,oFont10:oFont)
	oPrinter:Say(030,505,"Hora   :  "+Time() 	,oFont10:oFont)
	oPrinter:Line( 045, 170, 045, 590)
	oPrinter:Say(060,180,Alltrim(SM0->M0_NOMECOM) 	,oFontRod:oFont)
	oPrinter:Say(075,180,Alltrim(SM0->M0_ENDCOB)+" - "+Alltrim(SM0->M0_BAIRCOB) 	,oFont12:oFont)
	oPrinter:Say(090,180,"CEP: "+Transform(SM0->M0_CEPCOB,"@r 99999-999")+" - "+Alltrim(SM0->M0_CIDCOB)	,oFont12:oFont)
	oPrinter:Say(105,180,"CNPJ:"+Transform(SM0->M0_CGC,"@r 99.999.999/9999-99")+Space(5)+"IE: "+Alltrim(SM0->M0_INSC)	,oFont12:oFont)

	oPrinter:Line( 110, 005, 110, 590)

	DbSelectArea("SA2")
	DbSetOrder(3)
	MsSeek(xFilial("SA2")+_cCPF)

    oPrinter:Say(125,020,"Produtor:"	,oFont12N:oFont)
    oPrinter:Say(125,100,SA2->A2_COD+" - "+SA2->A2_NOME			,oFont12:oFont)
	oPrinter:Say(140,020,"Endere็o :"	,oFont12N:oFont)
	oPrinter:Say(140,100,SA2->A2_END	,oFont12:oFont)
	oPrinter:Say(155,020,"Bairro   :"	,oFont12N:oFont)
	oPrinter:Say(155,100,SA2->A2_BAIRRO	,oFont12:oFont)
	oPrinter:Say(170,020,"Municipio:",oFont12N:oFont)
	oPrinter:Say(170,100,SA2->A2_CEP+" - "+Alltrim(SA2->A2_MUN)+"-"+SA2->A2_EST,oFont12:oFont)
	If SA2->A2_TIPO = 'J'
		oPrinter:Say(185,020,"CNPJ      :"			,oFont12N:oFont)
		oPrinter:Say(185,100,Transform(SA2->A2_CGC,"@r 99.999.999/9999-99")			,oFont12:oFont)
	Else
		oPrinter:Say(185,020,"CPF       :"			,oFont12N:oFont)
		oPrinter:Say(185,100,Transform(SA2->A2_CGC,"@r 999.999.999-99")			,oFont12:oFont)
	EndIf
	oPrinter:Say(185,330,"INSC.EST.: "+SA2->A2_INSCR			,oFont12:oFont)

	_nLin := 190
	oPrinter:Line( _nLin, 005, _nLin, 590)



Return