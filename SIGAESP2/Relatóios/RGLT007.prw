#INCLUDE "TOTVS.CH"
/*/
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"
#include "report.ch"
#INCLUDE "TOTVS.CH"
#include "rwmake.ch"
#INCLUDE "RPTDEF.CH"

ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ RGLT007  º Autor ³ Guilherme França      º Data da Criacao  ³ 05/08/2014                						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatório de convênios. Emitido na tela de lançamento do convênio já filtrando o fornecedor posicionado.     º±±
±±º          ³                   												                               				º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                                   						                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ Cliente, Data de Emissao, Forma de Ordenacao  			                               						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ Nenhum						  							                               						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUsuario   ³ Microsiga                                                                                					º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºSetor     ³ Financeiro                                                                           						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                   						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor     ³ Data     ³ Motivo da Alteracao  				               ³Usuario(Filial+Matricula+Nome)    ³Setor        º±±
±±ºÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄº±±
±±º          ³          ³                                			       ³00-000000 -                       ³ TI	        º±±
±±º----------³----------³--------------------------------------------------³----------------------------------³-------------º±±
±±º          ³          ³                    							   ³                                  ³ 			º±±
±±º----------³----------³--------------------------------------------------³----------------------------------³-------------º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function RGLT007()

Private _cPerg := "RGLT007"
Private _aArea := GetArea()
Private _cFornece := ZLK->ZLK_CONVEN //Codigo do fornecedor do convenio

Pergunte(_cPerg,.F.) //Preenche os parametros para sugestão.
MV_PAR01 := ZLK->ZLK_DATA
MV_PAR02 := ZLK->ZLK_DATA

Pergunte(_cPerg,.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Funcao que retorna o report montado com as configuraoes do relatorio ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef()
oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RGLT007   ºAutor  ³Microsiga           º Data ³  08/05/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao que retorna o report montado com as configuraoes     º±±
±±º          ³do relatorio                                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Private oReport


oReport := TReport():NEW("RGLT007" ,"Relatorio de Convênios" ,_cPerg,{|oReport|PrintReport(oReport)} ,"")

oReport:nLineHeight	:= 50            // Define a altura da linha.
oReport:lParamPage		:= .F.
oReport:SetPortrait(.T.)
oReport:GetOrientation(1)
oReport:SetTotalInLine(.F.)


Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RGLT007   ºAutor  ³Microsiga           º Data ³  08/05/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao que executa impressao do relatorio                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport)

Local _cFiltro := ""
Local _cCodConv := ""
Local _nTaxa := 0 // Taxa descontada do conveniado
Local _nTotConv := 0 //Total a receber do convenio
Local _nTotPagar := 0
Local _nTotPago := 0
Local _nTotOri := 0
Local _nTotFim := 0
Local _nTotTax := 0
Private _cAlias := GetNextAlias()
Private oFont12 		:= TFont():New("COURIER NEW",12,12,,.F.,,,,.T.,.F.)
Private oFont12N		:= TFont():New("COURIER NEW",12,12,,.T.,,,,.T.,.F.)
Private oFont14N		:= TFont():New("COURIER NEW",14,14,,.T.,,,,.T.,.F.)
Private oFont16N		:= TFont():New("COURIER NEW",16,16,,.T.,,,,.T.,.F.)


_cFiltro := "% AND ZLL_DATA BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"' "
_cFiltro += " AND ZLL_CONVEN = '"+_cFornece+"' "
_cFiltro += " ORDER BY ZLL_COD, ZLL_SEQ%"

BeginSql Alias _cAlias

	SELECT ZLL_COD AS CODIGO,
		   ZLL_SEQ AS SEQ,
	       ZLL_CONVEN AS FORNECE,
	       ZLL_LJCONV AS LJFORN,
		   ZLL_DATA AS EMISSAO,
		   ZLL_VENCON AS VENCTO,
		   ZLL_OBSERV AS OBS,
		   ZLL_EVENTO AS EVENTO,
		   ZLL_TXADM AS TAXA,
		   ZLL_RETIRO AS RETIRO,
		   ZLL_RETILJ AS LOJA,
		   A2_NOME AS NOME,
		   ZLL_VALOR AS VALOR,
		   ZLL_PARCEL AS PARCELA,
		   ZLL_VLRPAR AS VLRPAR,
		   ZLL_VLRPAG AS VLRPAG,
		   ZLL_VLRTOT AS TOTAL
	FROM  %table:ZLL% ZLL,  %table:SA2% A2
	WHERE ZLL.%NotDel%
	AND A2.%NotDel%
	AND ZLL.ZLL_RETIRO = A2.A2_COD
	AND ZLL.ZLL_RETILJ = A2.A2_LOJA
	%Exp:_cFiltro%

EndSql

If (_cAlias)->(Eof())
	Alert("Não existem dados para este conveniado no periodo informado!")
	Return
EndIf

While !(_cAlias)->(Eof()) .and. ((_cAlias)->FORNECE == _cFornece)
	PrintCabec(1)
	_cCodConv := (_cAlias)->CODIGO
	While!(_cAlias)->(Eof()) .and. (_cCodConv == (_cAlias)->CODIGO)

		If oReport:Row() >= oReport:PageHeight() - 80
			oReport:EndPage()
			oReport:StartPage()
			PrintCabec(2)
		EndIf
		oReport:Say(oReport:Row(),oReport:PageWidth() * 0.01,(_cAlias)->SEQ	,oFont12)
		oReport:Say(oReport:Row(),oReport:PageWidth() * 0.04,(_cAlias)->RETIRO		,oFont12)
		oReport:Say(oReport:Row(),oReport:PageWidth() * 0.13,(_cAlias)->NOME		,oFont12)
		oReport:Say(oReport:Row(),oReport:PageWidth() * 0.44,Transform((_cAlias)->VALOR,"@E 9,999,999.99") ,oFont12)
		oReport:Say(oReport:Row(),oReport:PageWidth() * 0.59,StrZero((_cAlias)->PARCELA,2)		,oFont12)
		oReport:Say(oReport:Row(),oReport:PageWidth() * 0.68,Transform((_cAlias)->TOTAL,"@E 999,999.99")		,oFont12)
		oReport:Say(oReport:Row(),oReport:PageWidth() * 0.80,Transform((_cAlias)->VLRPAG,"@E 9,999,999.99")	,oFont12)
		oReport:SkipLine(1)
		_nTotConv += (_cAlias)->VALOR
		_nTotPagar += (_cAlias)->TOTAL
		_nTotPago += (_cAlias)->VLRPAG
		_nTaxa :=  (_cAlias)->TAXA

		(_cAlias)->(DbSkip())
	EndDo
	oReport:SkipLine(1)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.01,"Total Lançamento: "+_cCodConv,oFont12)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.41,"R$"+Transform(_nTotConv,"@E 99,999,999.99") ,oFont12)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.69,"R$"+Transform(_nTotPagar,"@E 9,999,999.99")	,oFont12)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.79,"R$"+Transform(_nTotPago,"@E 9,999,999.99")	,oFont12)
	oReport:SkipLine(1)
	oReport:ThinLine()
	oReport:SkipLine(2)

	_nTotOri += _nTotConv
	_nTotFim += _nTotPagar
	_nTotTax += _nTaxa

	_nTotConv := 0
	_nTotPagar := 0
	_nTaxa := 0

EndDo

If oReport:Row() >= oReport:PageHeight() - 85
	oReport:EndPage()
	oReport:StartPage()
EndIf
oReport:Say(oReport:Row(),oReport:PageWidth() * 0.01,"Resumo dos Lançamentos:",oFont12N)
oReport:SkipLine(1)
oReport:Say(oReport:Row(),oReport:PageWidth() * 0.01,"Valor Lançado: " ,oFont12)
oReport:Say(oReport:Row(),oReport:PageWidth() * 0.24,"R$"+Transform(_nTotOri,"@E 9,999,999.99") ,oFont12N)
oReport:SkipLine(1)
oReport:Say(oReport:Row(),oReport:PageWidth() * 0.01,"Valor a cobrar do Associado:"	,oFont12)
oReport:Say(oReport:Row(),oReport:PageWidth() * 0.24,"R$"+Transform(_nTotFim,"@E 9,999,999.99")	,oFont12N)
oReport:SkipLine(1)
oReport:Say(oReport:Row(),oReport:PageWidth() * 0.01,"Valor da taxa Adm:" ,oFont12)
oReport:Say(oReport:Row(),oReport:PageWidth() * 0.24,"R$"+Transform(_nTotTax,"@E 9,999,999.99") ,oFont12N)
oReport:SkipLine(1)
oReport:Say(oReport:Row(),oReport:PageWidth() * 0.01,"Valor líquido do Conveniado:" ,oFont12)
oReport:Say(oReport:Row(),oReport:PageWidth() * 0.24,"R$"+Transform(_nTotFim-_nTotTax,"@E 9,999,999.99") ,oFont12N)
oReport:SkipLine(1)

_nTotOri := 0
_nTotFim := 0
_nTotTax := 0


oReport:EndPage()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PrintCabecºAutor  ³Microsiga           º Data ³  08/05/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Imprime o cabeçalho do relatorio.                          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintCabec(_nOpc)

Local _cNomFor := Posicione("SA2",1,xFilial("SA2")+_cFornece+(_cAlias)->LJFORN,"A2_NOME")

If _nOpc == 1
	oReport:StartPage()
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.01	, "Conveniado: "	,oFont12)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.13	, _cFornece +" "+ _cNomFor	,oFont12N)
	oReport:SkipLine(1)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.01	, "Código Lcto:  "  		,oFont12)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.13	, (_cAlias)->CODIGO 		,oFont12N)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.25	, "Dt.Lançamento: " ,oFont12)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.37	, DTOC(STOD((_cAlias)->EMISSAO))  ,oFont12N)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.52	, "Vencimento: ",oFont12)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.62	, DTOC(STOD((_cAlias)->VENCTO))	,oFont12N)
	oReport:SkipLine(1)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.01	, "Observação: "	,oFont12)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.13	, (_cAlias)->OBS	,oFont12N)


	oReport:SkipLine(1)
	oReport:ThinLine()
	oReport:SkipLine(1)
	PrintCabec(2)
EndIf

If _nOpc == 2
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.01,"Seq."			,oFont12N)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.04,"Matrícula"		,oFont12N)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.13,"Associado"		,oFont12N)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.44,"Vlr.Original"	,oFont12N)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.67,"Vlr.Total"		,oFont12N)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.82,"Vlr.Pago"		,oFont12N)
	oReport:SkipLine(1)
EndIf


Return