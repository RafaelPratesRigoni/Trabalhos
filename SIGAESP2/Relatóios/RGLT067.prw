// #########################################################################################
// Projeto:
// Modulo :
// Fonte  : RGLT067
// ---------+-------------------+-----------------------------------------------------------
// Data     | Autor Cláudio Gonçalves| Relatorio Frequencia Anormal de Coleta de Leite
// ---------+-------------------+-----------------------------------------------------------
// 10/05/13 | TOTVS Developer Studio | Gerado pelo Assistente de Código
// ---------+-------------------+-----------------------------------------------------------

#include "rwmake.ch"

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} novo
Montagem da tela de processamento

Impressão do histórico do pedido com itens controlados
/*/
//------------------------------------------------------------------------------------------
user function RGLT099

	Private cPerg := "RGLT099"

	Pergunte(cPerg,.F.)

	oReport := ReportDef()

	oReport:PrintDialog()

Return

Static Function ReportDef()

	Private oReport
	Private oSec1
	Private aTam			:={}

	oReport := TReport():NEW("RGLT099" ,"Frequencia Anormal de Coleta de Leite" ,cPerg,{|oReport|PrintReport(oReport)} ,"Este relatorio imprime o historico de Frequencia Anormal de Coleta de Leite.")

	oReport:nFontBody	:= 8// Define o tamanho da fonte.
	oReport:nLineHeight	:= 45 // Define a altura da linha.
	oReport:CFONTBODY:="Courier New"

	oSec1 := TRSection():new(oReport,"Coletas",{""})
	TRCELL():NEW(oSec1,"CODIGO"			,,"Código"								,	,10	,,,"LEFT",	,"LEFT",,,,,,.F.)
	TRCELL():NEW(oSec1,"PRODUTOR"		,,"Produtor"  							,	,30	,,,"LEFT",	,"LEFT",,,,,,.F.)
	TRCELL():NEW(oSec1,"LOJA"			,,"Fazenda"  							,	,6	,,,"LEFT",	,"LEFT",,,,,,.F.)
	TRCELL():NEW(oSec1,"TIPO"			,,"Tipo	"  							,	,50	,,,"LEFT",	,"LEFT",,,,,,.F.)
	TRCELL():NEW(oSec1,"VOLUME"			,,"Volume (l)"						,	,50	,,,"LEFT",	,"LEFT",,,,,,.F.)
	TRCELL():NEW(oSec1,"COLETA"			,,"Coletado em"  						,	,50	,,,"LEFT",	,"LEFT",,,,,,.F.)
	TRCELL():NEW(oSec1,"TEMPO"			,,"Tempo desde coleta anterior"		,	,50	,,,"LEFT",	,"LEFT",,,,,,.F.)
	TRCELL():NEW(oSec1,"RESPONSAVEL"	,,"Responsável"  						,	,20	,,,"LEFT",	,"LEFT",,,,,,.F.)

	oReport:lParamPage := .F.
	oReport:GetOrientation(1)
	oReport:SetTotalInLine(.F.)

Return oReport

Static Function PrintReport(oReport)

	Private oSec1			:= oReport:Section(1)
	Private cQuery			:= ""

	cQuery := " SELECT  ZLD.ZLD_RETIRO, SA2.A2_NOME, ZLD.ZLD_RETILJ, ZLD_DTCOLE, ZLD_QTDBOM, ZLD_USER "
	cQuery += "  FROM "+RetSqlName("ZLD")+" ZLD, "
	cQuery += " WHERE ZLD_DTCOLE BETWEEN '"+dtos(mv_par01)+"' AND '"+dtos(mv_par02)+"' "
	cQuery += " AND ZLD.ZLD_RETIRO BETWEEN '"+mv_par03+"' AND '"+mv_par04+"' "
	cQuery += " AND ZLD.D_E_L_E_T_ = ' ' "
	cQuery += " ORDER BY ZLD.ZLD_RETIRO ASC, ZLD_DTCOLE DSC "

	// Verifica area aberta
	If Select("QRY") <> 0
		QRY->(DBCLOSEAREA())
	EndIF

	cQuery := ChangeQuery(cQuery)

	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),"QRY",.F.,.T.)

	QRY->(dbGoTop())

	cPedido := ""
	oSec1:Init()

	While QRY->(!Eof())

		oSec1:Cell("CODIGO"):SetValue(QRY->ZLD_RETIRO)
		cCli := Posicione("SA2",1,xFilial("SA2")+QRY->ZLD_RETIRO+QRY->ZLD_RETILJ,"A2_NOME")
		oSec1:Cell("PRODUTOR"):SetValue(cCli)
		oSec1:Cell("LOJA"):SetValue(QRY->ZLD_RETILJ)
		oSec1:Cell("VOLUME"):SetValue(cValToChar(QRY->ZLD_QTDBOM))
		oSec1:Cell("COLETA"):SetValue(stod(QRY->ZLD_DTCOLE))
		oSec1:Cell("RESPONSAVEL"):SetValue(RGLT99A(QRY->ZLD_USER))

	Enddo

	oSec1:Finish()
	QRY->(dbCloseArea())

Return oReport

Static Function RGLT99A(cCodUsr)

	Local cNomeUser	:= ""

	cNomeUser := UsrFullName(cCodUsr)

Return cNomeUser