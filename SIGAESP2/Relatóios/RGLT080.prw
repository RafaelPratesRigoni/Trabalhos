#INCLUDE "TOTVS.CH"
#INCLUDE "REPORT.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ RGLT080  º Autor ³ Guilherme França                 º Data da Criacao  ³ 31/01/2018     						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatório produtores por rota                            						º±±
±±º          ³ 															                               						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                                   											º±±
±±º          ³ 	 							                                                                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³                                                                                      						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ Nenhum					                                                                                  	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUsuario   ³															                             						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºSetor     ³ Financeiro	                                                                          						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º            						ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL                   						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor     ³ Data     ³ Motivo da Alteracao  				               ³Usuario(Filial+Matricula+Nome)    ³Setor        º±±
±±ÌÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄ¹±±
±±º          ³          ³                    							   ³                                  ³ 			º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function RGLT080()

Private cPerg := "PRGLT080"

Pergunte(cPerg,.T.,'Produtores por Rota')

oReport := ReportDef()
oReport:PrintDialog()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef ºAutor  ³Microsiga           º Data ³  11/26/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Definição do lay-out do relatorio.                         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Local oReport
Local oRota, oProdutor
Local cAlias := GetNextAlias()
Private _nQtd := 0
Private _aVolProd := {0,0,0}

CriaTab(@cAlias)

DEFINE REPORT oReport NAME "RGLT080" TITLE "Relação de Produtores por Rota - Coleta: "+DTOC(MV_PAR03)+" a "+DTOC(MV_PAR04) PARAMETER cPerg ACTION {|oReport| PrintReport(oReport, cAlias)}

oReport:SetTotalInLine(.F.)

DEFINE SECTION oRota OF oReport  TITLE "Rotas" TABLES "ZLW"
oRota:SetPageBreak(.T.)
oRota:SetTotalInLine(.F.)

DEFINE CELL NAME "ZLW_COD"		OF oRota ALIAS "ZLW"	BLOCK {|| (cAlias)->ZLW_COD }
DEFINE CELL NAME "ZLW_DESCRI"	OF oRota ALIAS "ZLW"	BLOCK {|| (cAlias)->ZLW_DESCRI }
DEFINE CELL NAME "ZLW_FRETIS"	OF oRota ALIAS "ZLW"	BLOCK {|| (cAlias)->ZLW_FRETIS }
DEFINE CELL NAME "ZLW_FRETLJ"	OF oRota ALIAS "ZLW"	BLOCK {|| (cAlias)->ZLW_FRETLJ }
DEFINE CELL NAME "ZLW_NOMEFR"	OF oRota ALIAS "ZLW"	BLOCK {|| (cAlias)->ZLW_NOMEFR }
DEFINE CELL NAME "VOL_COL" 		OF oRota ALIAS "   " TITLE "Tot. Coleta" PICTURE "@E 9,999,999" SIZE 25 BLOCK {|| _aVolProd[1] }
DEFINE CELL NAME "VOL_VEIC" 	OF oRota ALIAS "   " TITLE "Tot. Veiculo" PICTURE "@E 9,999,999" SIZE 25 BLOCK {|| _aVolProd[2] }
DEFINE CELL NAME "DIFERENCA" 	OF oRota ALIAS "   " TITLE "Diferença Vol." PICTURE "@E 99,999" SIZE 20 BLOCK {|| _aVolProd[3] }


DEFINE SECTION oProdutor OF oRota  TITLE "Produtores"
oProdutor:SetTotalInLine(.F.)

DEFINE CELL NAME "ZLZ_CODPRO" OF oProdutor ALIAS "ZLZ"	BLOCK {|| (cAlias)->ZLZ_CODPRO }
DEFINE CELL NAME "ZLZ_LJPROD" OF oProdutor ALIAS "ZLZ"	BLOCK {|| (cAlias)->ZLZ_LJPROD }
DEFINE CELL NAME "A2_NOME"	  OF oProdutor ALIAS "SA2"	BLOCK {|| (cAlias)->A2_NOME }
DEFINE CELL NAME "VOL_COLETA" OF oProdutor ALIAS "   " TITLE "Vol. Coleta" PICTURE PesqPict("ZLD","ZLD_TOTBOM") SIZE 30 BLOCK {|| _nQtd } //Mesma função utilizada no MIX

oProdutor:Cell("VOL_COLETA"):SetHeaderAlign("RIGH")
DEFINE FUNCTION FROM oProdutor:Cell("VOL_COLETA") FUNCTION SUM

Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RGLT080   ºAutor  ³Microsiga           º Data ³  11/24/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function PrintReport(oReport, cAlias)

Local _nReg  := 0
Local oRota := oReport:Section(1)
Local oProdutor := oReport:Section(1):Section(1)
Local _cRota := ""

dbSelectArea(cAlias)
Count to _nReg

oReport:SetMeter(_nReg)

(cAlias)->(dbGoTop())
While !(cAlias)->(Eof())

	If oReport:Cancel()
		Exit
	EndIf
	_aVolProd := {0,0,0}
	_aVolProd := VolProd("T",(cAlias)->ZLW_COD,(cAlias)->ZLW_FRETIS,(cAlias)->ZLW_FRETLJ)

	oRota:Init()

	oRota:PrintLine()

	_cRota := (cAlias)->ZLW_COD

	oProdutor:Init()
	While !(cAlias)->(Eof()) .AND. Alltrim(_cRota) == Alltrim((cAlias)->ZLW_COD)

		_nQtd := VolProd("P",(cAlias)->ZLW_COD,(cAlias)->ZLZ_CODPRO,(cAlias)->ZLZ_LJPROD,(cAlias)->ZLW_FRETIS,(cAlias)->ZLW_FRETLJ)[1]
	    oProdutor:PrintLine()

		(cAlias)->(dbSkip())

	EndDo

	oProdutor:Finish()

	oRota:Finish()

EndDo

(cAlias)->(dbCloseArea())

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CriaTabºAutor  ³Microsiga           º Data ³  11/26/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Cria tabela temporária para impressão do relatório.        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CriaTab(cAlias)

Local _cSetores := AllTrim(MV_PAR05)
_cSetores := "% ("+ U_AjustSet(_cSetores) + ") %"

BeginSql Alias cAlias

    SELECT ZLW_COD, ZLW_DESCRI, ZLW_FRETIS,ZLW_FRETLJ,ZLW_NOMEFR, ZLZ_CODPRO, ZLZ_LJPROD, A2_NOME
    FROM %Table:ZLZ% LZ
        JOIN %Table:ZLW% LW ON ZLW_FILIAL = ZLZ_FILIAL AND ZLW_COD = ZLZ_ROTA  AND ZLW_VERSAO = ZLZ_VERSAO
		AND ZLW_SETOR IN %Exp:_cSetores% AND LW.%NotDel%
        JOIN %Table:SA2% A2 ON A2_COD = ZLZ_CODPRO AND A2_LOJA = ZLZ_LJPROD AND A2.%NotDel%
    WHERE ZLZ_FILIAL = %xFilial:ZLZ%
    AND ZLZ_ROTA BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02%
    AND LZ.%NotDel%
    ORDER BY ZLW_COD, A2_NOME

EndSql

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VolProd   ºAutor  ³Guilherme França    º Data ³  31/01/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna volume entregue pelo produtor no período parametrizadoº±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function VolProd(xcTipo,xcRota,xcCod,xcLoja,xcCodf,xcLojaf)

Local _cAlias := GetNextAlias()
Local _aRet := {0,0,0}

If xcTipo == "P"
	BeginSql Alias _cAlias
		SELECT SUM(ZLD_QTDBOM) TBOM
		FROM %Table:ZLD% ZLD
			WHERE ZLD_FILIAL = %xFilial:ZLD%
			AND ZLD_DTCOLE BETWEEN  %Exp:DTOS(MV_PAR03)% AND %Exp:DTOS(MV_PAR04)%
			AND ZLD_RETIRO = %Exp:xcCod% AND ZLD_RETILJ = %Exp:xcLoja%
			AND	ZLD_FRETIS = %Exp:xcCodF% AND ZLD_LJFRET = %Exp:xcLojaF%
			AND ZLD_ROTCAB = %Exp:xcRota%
			AND ZLD.%NotDel%
	EndSql
Else
	BeginSql Alias _cAlias
		SELECT SUM(TBOM) TBOM, SUM(VEIC) VEIC FROM (
			SELECT SUM(ZLD_QTDBOM) TBOM, ZLD_TOTBOM VEIC
			FROM %Table:ZLD% ZLD
				WHERE ZLD_FILIAL = %xFilial:ZLD%
				AND ZLD_DTCOLE BETWEEN  %Exp:DTOS(MV_PAR03)% AND %Exp:DTOS(MV_PAR04)%
				AND	ZLD_FRETIS = %Exp:xcCod% AND ZLD_LJFRET = %Exp:xcLoja%
				AND ZLD_ROTCAB = %Exp:xcRota%
				AND ZLD.%NotDel%
				GROUP BY ZLD_TOTBOM ) AS TOTAIS
	EndSql
Endif

If xcTipo == "P"
	If !(_cAlias)->(Eof())
		_aRet[1] := (_cAlias)->TBOM
	EndIf
else
	If !(_cAlias)->(Eof())
		_aRet[1] := (_cAlias)->TBOM
		_aRet[2] := (_cAlias)->VEIC
		_aRet[3] := ((_cAlias)->TBOM - (_cAlias)->VEIC)
		(_cAlias)->(DbSkip())
	EndIf
EndIf

(_cAlias)->(DbCloseArea())

Return _aRet