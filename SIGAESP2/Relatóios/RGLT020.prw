#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"

#DEFINE _ENTER Chr(13)+Chr(10)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RGLT020   º Autor ³ Guilherme França    	º Data da Criacao  ³ 22/12/2014                						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio Titulos a Receber Personalizado                                                           			º±±
±±º          ³ Demonstra todos os titulos a receber em aberto, calculando juros e multas para atrasos de acordo com as      º±±
±±º			 ³ regras da cooperativa.                                                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Setor Financeiro                      																º±±
±±º			 ³					                                                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³                                                                                         						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³                                                      	                                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUsuario   ³                                                                                          					º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºSetor     ³                                                                                         						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL                   						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor     ³ Data     ³ Motivo da Alteracao  				               ³Usuario(Filial+Matricula+Nome)    ³Setor        º±±
±±ºÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄº±±
±±º----------³----------³--------------------------------------------------³----------------------------------³-------------º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User function RGLT020()

Private cPerg	:= "PRGLT020"
Private _cAno	:= ""
Private _cMes	:= ""
Private _dEmiIni	:= ""
Private _dEmiFim	:= ""
Private _dVencIni	:= ""
Private _dVencFim	:= ""
Private nOrdem := 1 //oSec1:GetOrder()

If !Pergunte(cPerg,.T.)
	Return
EndIf

oReport := ReportDef()

oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef ºAutor  ³Microsiga           º Data ³  11/24/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Private oReport
Private oSec1
Private oSec2
Private oSec3
Private aTam := {}
Private cParam := ""
Private aOrd := {"Nome","Codigo","Grupo Preco","Vencimento"}


oReport := TReport():NEW("RGLT020" ,"Relação Titulos a descontar GLT - Vencto:"+DTOC(MV_PAR07)+" a "+DTOC(MV_PAR08)+"" ,;
			cPerg,{|oReport|PrintReport(oReport)} ,"Este relatório imprime os titulos a receber personalizado.")

oReport:nFontBody	:= 9// Define o tamanho da fonte.
oReport:nLineHeight	:= 50 // Define a altura da linha.
oReport:CFONTBODY:="Courier New" //Nome da Fonte
oReport:GetOrientation(2)
oReport:SetLandscape(.T.)
oReport:SetTotalInLine(.F.)




oSec1 := TRSection():new(oReport,"Cliente",{""},aOrd)
TRCELL():NEW(oSec1,"A1_COD")//			,,"Matricula"								,	,15	,,,"LEFT",	,"LEFT",,,,,,.F.)
TRCELL():NEW(oSec1,"A1_LOJA")//			,,"Matricula"								,	,15	,,,"LEFT",	,"LEFT",,,,,,.F.)
TRCELL():NEW(oSec1,"A1_NOME")//		,,"Nome"  							,	,50	,,,"LEFT",	,"LEFT",,,,,,.F.)
TRCELL():NEW(oSec1,"GRUPO"	,,"Grupo Preço"  							,	,50	,,,"LEFT",	,"LEFT",,,,,,.F.)

oSec2 := TRSection():new(oReport,"Titulos",{""})
TRCELL():NEW(oSec2,"E1_FILIAL")//		,,"Documento."								,	,30	,,,"LEFT",	,"LEFT",,,,,,.F.)
TRCELL():NEW(oSec2,"E1_PREFIXO")//		,,"Documento."								,	,30	,,,"LEFT",	,"LEFT",,,,,,.F.)
TRCELL():NEW(oSec2,"E1_NUM"		,,"Documento/Prc"						,	,25	,,,"LEFT",	,"LEFT",,,,,,.F.)
TRCELL():NEW(oSec2,"E1_TIPO"		,,"Tipo"								,	,15	,,,"LEFT",	,"LEFT",,,,,,.F.)
TRCELL():NEW(oSec2,"E1_EMISSAO"	,,"Emissao"		,	,25	,,,"LEFT",	,"LEFT" ,,,,,,.F.)
TRCELL():NEW(oSec2,"E1_VENCTO"	,,"Vencimento"		,	,25	,,,"LEFT",	,"LEFT" ,,,,,,.F.)
TRCELL():NEW(oSec2,"E1_VALOR")//  		,,"Valor"						,	,20	,,,"RIGHT",	,"RIGHT",,,,,,.F.)
TRCELL():NEW(oSec2,"E1_SALDO")//  		,,"Valor"						,	,20	,,,"RIGHT",	,"RIGHT",,,,,,.F.)
TRCELL():NEW(oSec2,"VLRATU"  		,,"Vlr.Atual"						,"@E 999,999,999.99",25	,,,"RIGHT",	,"RIGHT",,,,,,.F.)
TRCELL():NEW(oSec2,"E1_NATUREZ"		,,"Natureza"						,	,20	,,,"RIGHT",	,"RIGHT",,,,,,.F.)
TRCELL():NEW(oSec2,"E1_HIST" 		,,"Historico"						,	,30	,,,"RIGHT",	,"RIGHT",,,,,,.F.)
TRCELL():NEW(oSec2,"EVENTO"		,,"Evento Leite"						,	,30	,,,"RIGHT",	,"RIGHT",,,,,,.F.)

oSec2:Cell("VLRATU"):SetType("N")

nOrdem := oSec1:GetOrder()
If nOrdem == 1 .or. nOrdem == 2
//Cria quebra por nome
	oBreak := TRBreak():New(oSec1,oSec1:Cell("A1_NOME"),"Sub-Total --->")
ElseIf nOrdem == 3
	oBreak := TRBreak():New(oSec1,oSec1:Cell("GRUPO"),"Sub-Total --->")
Else
	oBreak := TRBreak():New(oSec2,oSec2:Cell("E1_VENCTO"),"Sub-Total --->")
EndIf

oBreak:nFontBody	:= 11// Define o tamanho da fonte.
oBreak:lBold:= .t.


//Cria totalizadores relacionando com o objeto da quebra
oSumValor := TRFunction():New(oSec2:Cell("E1_VALOR"),NIL,"SUM",oBreak)
oSumSaldo := TRFunction():New(oSec2:Cell("E1_SALDO"),NIL,"SUM",oBreak)
oSumVlratu := TRFunction():New(oSec2:Cell("VLRATU"),NIL,"SUM",oBreak)

//Inibe a apresentação dos totalizadores no final da secao
oSumValor:SetEndSection(.F.)
oSumSaldo:SetEndSection(.F.)
oSumVlratu:SetEndSection(.F.)


Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RGLT020   ºAutor  ³Microsiga           º Data ³  11/24/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport)

Local _cCodCli := ""
Local _nSaldo	:= 0
Local _nValor	:= 0
Local _nVlrFim	:= 0
Local _nJuros	:= 0
Local _nMulta	:= 0
Local _nAtraso	:= 0
Local _nSSaldo	:= 0
Local _nSValor	:= 0
Local _nSVlrFim	:= 0
Local _nSJuros	:= 0
Local _nSMulta	:= 0
Local _nTSaldo	:= 0
Local _nTValor	:= 0
Local _nTVlrFim	:= 0
Local _nTJuros	:= 0
Local _nTMulta	:= 0
Local _lSaltaPag := MV_PAR11==1
Private oSec1			:= oReport:Section(1)
Private oSec2			:= oReport:Section(2)
Private cQuery			:= ""
Private nTotBrut		:= 0

nOrdem := oSec1:GetOrder()

oSec1:SetLeftMargin(2)

MontaTRB() // Query para montagem do relatório


TRB->(dbGoTop())


While TRB->(!Eof())

	If (oReport:Row() >= oReport:PageHeight() - 100) .or. ((_cCodCli != TRB->CLI) .and. _lSaltaPag)
		oReport:EndPage()
		oReport:StartPage()
	EndIf
	_cCodCli := TRB->CLI
	oSec1:Init()

	oSec1:Cell("A1_COD"):SetValue(TRB->CLI)
	oSec1:Cell("A1_LOJA"):SetValue(Alltrim(TRB->LOJA))
	oSec1:Cell("A1_NOME"):SetValue(Alltrim(TRB->NOME))
	oSec1:Cell("GRUPO"):SetValue(Alltrim(Posicione("ZL3",1,xFilial("ZL3")+TRB->GRUPO,"ZL3_DESCRI")))
	oSec1:PrintLine()

	While TRB->(!Eof()) .and. (_cCodCli == TRB->CLI)

		oReport:IncMeter() //Incrementa régua
		If oReport:Row() >= oReport:PageHeight() - 100
			oReport:EndPage()
			oReport:StartPage()
		EndIf

		_nAtraso := DDATABASE - STOD(TRB->VENCTO)
       	_nValor := TRB->VLR
       	_nSaldo := TRB->SALDO
		If  _nAtraso > 0
			_nJuros		:=	0
			_nMulta		:=  0

		EndIf
		_nVlrFim	:= _nSaldo + _nJuros + _nMulta

        If TRB->TIPO $ 'NCC/RA'
	       	_nValor := _nValor * -1
	       	_nSaldo := _nSaldo * -1
			_nJuros		:= 0
			_nMulta		:= 0
			_nVlrFim	:= _nSaldo
		EndIf

		oSec2:Init()
		oSec2:Cell("E1_FILIAL"):SetValue(TRB->FIL)
		oSec2:Cell("E1_PREFIXO"):SetValue(TRB->PREF)
		oSec2:Cell("E1_NUM"):SetValue(TRB->NUM+"/"+TRB->PRC)
		oSec2:Cell("E1_TIPO"):SetValue(TRB->TIPO)
		oSec2:Cell("E1_EMISSAO"):SetValue(DTOC(STOD(TRB->EMISSAO)))
		oSec2:Cell("E1_VENCTO"):SetValue(DTOC(STOD(TRB->VENCTO)))
		oSec2:Cell("E1_VALOR"):SetValue(_nValor)
		oSec2:Cell("E1_SALDO"):SetValue(_nSaldo)
		oSec2:Cell("VLRATU"):SetValue(_nVlrFim)
		oSec2:Cell("E1_NATUREZ"):SetValue(TRB->NATUREZA)
		oSec2:Cell("E1_HIST"):SetValue(TRB->HIST)
		oSec2:Cell("EVENTO"):SetValue(Posicione("ZL8",1,xFilial("ZL8")+TRB->EVENTO,"ZL8_NREDUZ"))
		oSec2:PrintLine()

        //Soma os sub-totais
       	_nSValor += _nValor
       	_nSSaldo += _nSaldo
		_nSJuros += _nJuros
		_nSMulta += _nMulta
		_nSVlrFim += _nVlrFim


		TRB->(DbSkip())
	EndDo

	oSec1:Finish()
	oSec2:Finish()
    //Soma totalizador geral
   	_nTValor += _nSValor
   	_nTSaldo += _nSSaldo
	_nTJuros += _nSJuros
	_nTMulta += _nSMulta
	_nTVlrFim += _nSVlrFim


	//Zera Sub-totais
   	_nSValor := 0
   	_nSSaldo := 0
	_nSJuros := 0
	_nSMulta := 0
	_nSVlrFim := 0

EndDo

TRB->(dbCloseArea())

oSec1:Finish()

oReport:EndPage()

Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MontaTRB  ºAutor  ³Guilherme França    º Data ³  25/11/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Consulta SQL para geraçao do exrato conta-corrente.        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function MontaTRB()

//mv_par01	Do Cliente
//mv_par02 	Ao Cliente
//mv_par03	Do Loja Cliente
//mv_par04	Ao Loja Cliente
//mv_par05	Da Emissao
//mv_par06	Ate Emissao
//mv_par07	Do Vencimento
//mv_par08	Ate Vencimento
//mv_par09	Do Evento
//mv_par10	Ate Evento

//Variaveis dos filtros da Query
Local _cCodCli := "% '"+MV_PAR01+"' AND '"+MV_PAR02+"' %"
Local _cFEmissao := "% '"+DTOS(MV_PAR05)+"' AND '"+DTOS(MV_PAR06)+"' %"
Local _cFVencto := "% '"+DTOS(MV_PAR07)+"' AND '"+DTOS(MV_PAR08)+"' %"
Local _cFEvento	:= "% '"+MV_PAR09+"' AND '"+MV_PAR10+"' %"
Local _cFBaixa	:= "% '"+DTOS(MV_PAR13)+"' AND '"+DTOS(MV_PAR14)+"' %"
Local _cOrdem := ""
Local _cFiltro := "% %"
If nOrdem == 1
	_cOrdem := "% NOME, GRUPO, CLI, LOJA, VENCTO, EMISSAO  %"
ElseIf nOrdem == 2
	_cOrdem := "% CLI, LOJA, NOME, GRUPO,  VENCTO, EMISSAO %"
ElseIf nOrdem == 3
	_cOrdem := "% GRUPO, NOME, CLI, LOJA, VENCTO, EMISSAO %"
ElseIf nOrdem == 4
	_cOrdem := "%  VENCTO  %"
EndIf

If MV_PAR12 == 2 //tit baixados
	_cFiltro := "% AND E1.E1_SALDO = 0 %"
Else // tit aberto
	_cFiltro := "% AND E1.E1_SALDO > 0 %"
	_cFBaixa	:= "% '        ' AND '20491231' %"
EndIf

If Select("TRB") > 0
	DbSelectArea("TRB")
	("TRB")->(DbCloseArea())
EndIf

BeginSql alias "TRB"
	SELECT   A1.A1_COD	      CLI,
	         A1.A1_LOJA       LOJA,
	         A1.A1_NOME       NOME,
	         A2.A2_L_LI_RO	  GRUPO,
	         E1.E1_FILIAL     FIL,
	         E1.E1_PREFIXO    PREF,
	         E1.E1_NUM        NUM,
	         E1.E1_PARCELA    PRC,
	         E1.E1_TIPO       TIPO,
	         E1.E1_EMISSAO    EMISSAO,
	         E1.E1_HIST       HIST,
	         E1.E1_VALOR+E1_ACRESC      VLR,
	         E1.E1_SALDO+E1_SDACRES      SALDO,
	         E1.E1_VENCTO     VENCTO,
	         E1.E1_NATUREZ    NATUREZA,
	         E1.E1_L_EVENT    EVENTO
	FROM     %TABLE:SE1% E1
		JOIN %TABLE:SA1% A1 ON A1.A1_FILIAL = %XFILIAL:SA1%  AND A1.A1_COD = E1.E1_CLIENTE AND A1.A1_LOJA = E1.E1_LOJA AND A1.%NOTDEL%
		JOIN %TABLE:SA2% A2 ON A2.A2_FILIAL = %XFILIAL:SA2%  AND A2.A2_COD = E1.E1_CLIENTE AND A2.A2_LOJA = E1.E1_LOJA AND A2.%NOTDEL%
   	WHERE E1.E1_FILIAL BETWEEN ' ' AND 'ZZZZ'
	AND	E1.E1_CLIENTE BETWEEN %Exp:_cCodCli%
	AND E1.E1_EMISSAO BETWEEN %Exp:_cFEmissao%
	AND E1.E1_VENCTO BETWEEN %Exp:_cFVencto%
	AND E1.E1_BAIXA BETWEEN %Exp:_cFBaixa%
	AND E1.E1_L_EVENT BETWEEN %Exp:_cFEvento%

	AND E1.E1_L_EVENT <> ' '
	AND E1.%NOTDEL%
	%Exp:_cFiltro%

	ORDER BY %Exp:_cOrdem%

EndSql

Return