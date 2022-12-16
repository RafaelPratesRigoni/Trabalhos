#include "rwmake.ch"
#include "protheus.ch"
#include "report.ch"
/*
===============================================================================================================================
Programa----------: RGLT070
Autor-------------: GUILHERME FRANÇA
Data da Criacao---: 03/09/2018
===============================================================================================================================
Descricao---------: Relatório de conferência por evento parametrizado.
===============================================================================================================================
Uso---------------: Modulo Gestão do Leite
===============================================================================================================================
Parametros--------: MIX; EVENTO;
===============================================================================================================================
Retorno-----------: Nenhum
===============================================================================================================================
Chamado(SPS)------:
===============================================================================================================================
Setor-------------: Politica leiteira
===============================================================================================================================
*/

User Function RGLT070

Local _cTitulo := ""
Local _cPeriodo := ""
Private aOrd     := {"Nome","Codigo"}
Private cPerg := "PRGLT170"
Private oReport
Private oCab
Private oDet
Private _cTpEv := ""

If !Pergunte(cPerg,.T.)
	Return
EndIf


If !Empty(MV_PAR01)
	DbSelectArea("ZLE")
	DbSetOrder(1)
	DbSeek(xFilial("ZLE")+ MV_PAR01 )
	_cPeriodo := DTOC(ZLE->ZLE_DTINI)+" a "+DTOC(ZLE->ZLE_DTFIM)
Else
	Alert("Favor informar o mix nos parametros!")
	Return
EndIf


If !Empty(MV_PAR03)
	DbSelectArea("ZL8")
	DbSetOrder(1)
	DbSeek(xFilial("ZL8")+ MV_PAR02 )
	_cTitulo := MV_PAR02+" até "+MV_PAR03
	_cTpEv := ZL8->ZL8_TPEVEN
Else
	Alert("Favor informar um evento nos parametros!")
	Return
EndIf

DEFINE REPORT oReport NAME "RGLT070" TITLE "Detalhe evento "+ _cTitulo+" "+_cPeriodo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} // ORDERS aOrd

oReport:SetTotalInLine(.F.)
oReport:SetPortrait() // ou SetLandscape()
oReport:lEndReport := .F.


DEFINE SECTION oDetalhe OF oReport TITLE "Conferência Eventos" TABLE "ZLF" ORDERS aOrd


DEFINE CELL NAME "ZLF_SETOR"	OF oDetalhe TITLE "Setor" SIZE 10
DEFINE CELL NAME "ZLF_EVENTO"	OF oDetalhe TITLE "Evento" SIZE 10
DEFINE CELL NAME "ZLF_DCREVE"   OF oDetalhe TITLE "Desc.Evento" SIZE 20
DEFINE CELL NAME "ZLF_A2COD"    OF oDetalhe TITLE "Código/Lj" SIZE 12
DEFINE CELL NAME "ZLF_A2NOME"   OF oDetalhe TITLE "Nome"	SIZE 30

DEFINE CELL NAME "ZLF_QTDBOM"	OF oDetalhe TITLE "Quantidade"		PICTURE "@E 99,999,999"	SIZE 14 //BLOCK{|| IIF((_cAlias)->ORIGEM=="M",(_cAlias)->ZLF_QTDBOM,)}
DEFINE CELL NAME "ZLF_VLRLTR"	OF oDetalhe TITLE "Vlr.p/Litro(R$)"	PICTURE "@E 99.9999"		SIZE 8


DEFINE CELL NAME "ZLF_TOTAL"    OF oDetalhe TITLE "Vlr.Total(R$)"		PICTURE "@E 99,999,999.99"	SIZE 20


DEFINE CELL NAME "TITULO"    OF oDetalhe TITLE "Pre+Num+Parc."	SIZE 36
DEFINE CELL NAME "EMISSAO"   OF oDetalhe TITLE "Emissao"	SIZE 14 BLOCK{|| GetEmis((_cAlias)->E1SEEK)}
DEFINE CELL NAME "VENCTO"    OF oDetalhe TITLE "Vencimento"	SIZE 14 BLOCK{|| DTOC(SE1->E1_VENCTO)}



DEFINE BREAK oBreak OF oDetalhe WHEN oDetalhe:Cell("ZLF_A2COD") TITLE {|| "Total Produtor: "+Alltrim((_cAlias)->ZLF_A2NOME)}

DEFINE FUNCTION FROM oDetalhe:Cell("ZLF_VLRLTR") FUNCTION SUM BREAK oBreak
DEFINE FUNCTION FROM oDetalhe:Cell("ZLF_TOTAL") FUNCTION SUM BREAK oBreak

oDetalhe:SetTotalInLine(.F.)

oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PrintReportº Autor ³ 			             º Data da Criacao  ³ 				                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Printa o relatorio                                                                                             º±±
±±º          ³                     												                               			      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³RPCSAB	                        						                                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ Nenhum						   							                               					      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ Nenhum						  							                               					      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUsuario   ³ Microsiga                                                                                					  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºSetor     ³ Suprimentos	                                                                        						  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL                   						  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor     ³ Data     ³ Motivo da Alteracao  				               ³Usuario(Filial+Matricula+Nome)    ³Setor          º±±
±±ºÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄº±±
±±º          ³00/00/0000³                               				   ³00-000000 -                       ³ TI	          º±±
±±º----------³----------³--------------------------------------------------³----------------------------------³---------------º±±
±±º          ³          ³                    							   ³                                  ³ 			  º±±
±±º----------³----------³--------------------------------------------------³----------------------------------³---------------º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function PrintReport(oReport)


Local _cOrdem  := ""
Local _nOrdem := 0
Local _cQryTit := ""
Local _cQryCod := ""
Private _cAlias   := GetNextAlias()
_nOrdem := oReport:GetOrder()

If (TcGetDB() == 'ORACLE')
	_cQryTit :="% ZLF_SE1PRE || ' ' || ZLF_SE1NUM || ' ' || ZLF_SE1PAR %"
	_cQryCod := "% ZLF_A2COD || ' ' || ZLF_A2LOJA %"
Else
	_cQryTit :="% ZLF_SE1PRE+' '+ZLF_SE1NUM+' '+ZLF_SE1PAR %"
	_cQryCod := "% ZLF_A2COD + ' ' + ZLF_A2LOJA %"
EndIf

If _nOrdem == 1
	_cOrdem := "% ZLF_SETOR,ZLF_LINROT,ZLF_A2NOME,ZLF_RETIRO,ZLF_RETILJ, ORDEM  %"
Else
	_cOrdem := "% ZLF_SETOR,ZLF_LINROT,ZLF_RETIRO,ZLF_RETILJ ,ZLF_A2NOME, ORDEM  %"
EndIf


BEGIN REPORT QUERY oReport:Section(1)

BeginSql alias _cAlias

SELECT
	ZLF_SETOR, %Exp:_cQryCod% AS ZLF_A2COD, ZLF_A2NOME, ZLF_QTDBOM,
	(CASE WHEN ZLF_DEBCRE = 'D' THEN -ZLF_VLRLTR ELSE ZLF_VLRLTR END) AS ZLF_VLRLTR,
	(CASE WHEN ZLF_DEBCRE = 'D' THEN -ZLF_TOTAL ELSE ZLF_TOTAL END) AS ZLF_TOTAL,
	ZLF_DCREVE,
	%Exp:_cQryTit% AS TITULO,
	SUBSTRING(ZLF_L_SEEK,7,19) AS E1SEEK, ZLF_ORIGEM AS ORIGEM, ZLF_EVENTO,
		CASE WHEN ZL8_TPEVEN = 'L' THEN 1
				WHEN ZL8_TPEVEN = 'R' THEN 2
				WHEN ZL8_TPEVEN = 'A' THEN 3
				WHEN ZL8_TPEVEN = 'F' AND ZL8_DEBCRE = 'C' THEN 4
				WHEN ZL8_TPEVEN = 'F' AND ZL8_DEBCRE = 'D' THEN 5
				END AS ORDEM
FROM %Table:ZLF% ZLF
	JOIN %Table:ZL8% ZL8 ON ZL8_FILIAL = %xFilial:ZL8% AND ZL8_COD = ZLF_EVENTO AND ZL8.%NotDel%
	WHERE ZLF_FILIAL = %xfilial:ZLF%
	 AND ZLF_CODZLE = %Exp:MV_PAR01%
	 AND ZLF_EVENTO BETWEEN %Exp:MV_PAR02% AND %Exp:MV_PAR03%
	 AND ZLF_RETIRO BETWEEN %Exp:MV_PAR04% AND %Exp:MV_PAR06%
	 AND ZLF_RETILJ BETWEEN %Exp:MV_PAR05% AND %Exp:MV_PAR07%

	 AND ZLF.%NotDel%
ORDER BY %Exp:_cOrdem%

EndSql

END REPORT QUERY oReport:Section(1)

oReport:Section(1):Print()
Return



Static Function GetEmis(xcSeek)

DbSelectArea("SE1")
DbSetOrder(1)
SE1->(MsSeek(xcSeek))

Return DTOC(SE1->E1_EMISSAO)