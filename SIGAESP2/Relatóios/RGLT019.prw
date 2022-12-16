#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "TOPCONN.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณRGLT019      บ Autor ณ TOTVS                 บ Data da Criacao  ณ 24/01/2009             						บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Demonstrativo do Produtor                                                               						บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao do Leite                                                   											บฑฑ
ฑฑบ          ณ 	 							                                                                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                                                                                        						บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ Nenhum					                                                                                  	บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUsuario   ณ															                             						บฑฑ
ฑฑฬออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบSetor     ณ Gestao do Leite	                                                                       						บฑฑ
ฑฑฬออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ            						ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL                   						บฑฑ
ฑฑฬออออออออออัออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออัออออออออออออออออออออออออออออออออออัอออออออออออออนฑฑ
ฑฑบAutor     ณ Data     ณ Motivo da Alteracao  				               ณUsuario(Filial+Matricula+Nome)    ณSetor        บฑฑ
ฑฑฬฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤนฑฑ
ฑฑบ          ณ          ณ                    							   ณ                                  ณ 			บฑฑ
ฑฑศออออออออออฯออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออออออออออออออออออออออออออออออฯอออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function RGLT019

	Local cDesc   := "Este relatorio ira listar todos os debitos e creditos dos produtores, entrada de leite, analise da qualidade e convenios."
	Private cpMix    := ""
	Private cpSetor  := ""
	Private cpPrdIni := ""
	Private cpPrdFim := ""
	Private cpLjIni  := ""
	Private cpLjFim  := ""
	Private cpLinIni := ""
	Private cpLinFim := ""
	Private cpTnqIni := ""
	Private cpTnqFim := ""
	Private dpDtIni  := CTOD("")
	Private dpDtFim  := CTOD("")
	Private _lMostraPrc := .T.
	Private oCB
	Private oReport
	Private cPerg  := "RGLT019"
	Private dBaixa := dDataBase

	If !Pergunte(cPerg,.T.)
		Return
	EndIf

	DEFINE REPORT oReport NAME 'RGLT019' TITLE 'Demonstrativo do Produtor' PARAMETER cPerg ACTION {|oReport| RunRel()} DESCRIPTION cDesc

	oReport:SetPortrait()// ou SetPortrait() - SetLandscape()
	oReport:HideHeader() // Nao imprime cabecalho padrao do Protheus
	oReport:HideFooter() // Nao imprime rodape padrao do Protheus
	oReport:SetTotalInLine(.F.)

	DEFINE SECTION OCB OF oReport TITLE "DEMONSTRATIVO"

	oReport:PrintDialog()
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณRunRel       บ Autor ณ Abrahao P. Santos     บ Data da Criacao  ณ 24/01/2009             						บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ DemonSTRativo do Produtor                                                               						บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao do Leite                                                   											บฑฑ
ฑฑบ          ณ 	 							                                                                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                                                                                        						บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ Nenhum					                                                                                  	บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUsuario   ณ															                             						บฑฑ
ฑฑฬออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบSetor     ณ Gestao do Leite	                                                                       						บฑฑ
ฑฑฬออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ            						ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL                   						บฑฑ
ฑฑฬออออออออออัออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออัออออออออออออออออออออออออออออออออออัอออออออออออออนฑฑ
ฑฑบAutor     ณ Data     ณ Motivo da Alteracao  				               ณUsuario(Filial+Matricula+Nome)    ณSetor        บฑฑ
ฑฑฬฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤนฑฑ
ฑฑบ          ณ          ณ                    							   ณ                                  ณ 			บฑฑ
ฑฑศออออออออออฯออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออออออออออออออออออออออออออออออฯอออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RunRel()

	Local nCount  := 0
	Local nTab01  := 100
	Local nTab03  := 1000
	Local nTab04  := 1600
	Local nTab05  := 2050
	Local nTotCre := 0
	Local nTotDeb := 0
	Local nTotVol := 0
	Local nUltDia := 0
	Local nVolProd:= 0
	Local cMasc   := ""
	Local nRedut  := 0
	Local cCodLin := ""
	Local nItens  := 0
	Local cLT_GRPBON := Trim(GETMV("LT_GRPBON"))//000002
	Local cLT_EVEINSS := AllTrim(GETMV("LT_EVEINSS"))
	Local cEvetAdc := AllTrim(GetMv("LT_EVEADIC")) //Codigo do Evento de Adicional de Mercado
	Local _nVlrINSS := 0
	Local _nTotal	:= 0
	Local cMixStatus  := ""
	Local aDebito     := {}
	Local nConvenios := 0
	Local nConvJur   := 0
	Local nVlrOrig   := 0
	Local nConvPag   := 0
	Local nBonIf     := 0
	Local nRepasse   := 0
	Local aConvenios := {}
	Local aDeposito  := 0
	Local lAgrupa    := GETMV("LT_AGRUBON")//Agrupa as bonificacoes
	LOcal nCnt, n

	nL    := 0
	nPos1 := 100
	nPos2 := 350
	nPos3 := 1500
	nPos4 := 1800

	nTab11 := 100
	nTab12 := 400
	nTab13 := 700
	nTab14 := 1000
	nTab15 := 1300
	nTab16 := 1700
	nTab17 := 2100

	nColCv1 := 100
	nColCv2 := 800
	nColCv3 := nColCv2+300
	nColCv4 := nColCv3+300
	nColCv5 := nColCv4+300
	nColCv6 := nColCv5+300
	nColCv7 := nColCv6+300
	oFontTitulo:=TFont():New("Arial",09,14,.T.,.T.,5,.T.,5,.T.,.F.)
	oFontRotulo:=TFont():New("Arial",09,11,.T.,.T.,5,.T.,5,.T.,.F.)
	oFontNormal:=TFont():New("Arial",09,11,.F.,.F.,5,.T.,5,.T.,.F.)
	oFontDetCv1:=TFont():New("Courier New",09,11,.F.,.F.,5,.T.,5,.T.,.F.)
	oFontDetCv2:=TFont():New("Courier New",09,11,.T.,.T.,5,.T.,5,.T.,.F.)

	cRaizServer := If(IsSrvUnix(), "/", "\")

	// Obtem parametros
	cpMix	:= MV_PAR01
	cpSetor	:= MV_PAR02
	cpPrdIni:= MV_PAR03
	cpPrdFim:= MV_PAR04
	cpLjIni	:= MV_PAR05
	cpLjFim	:= MV_PAR06
	cpLinIni:= MV_PAR07
	cpLinFim:= MV_PAR08
	cpTnqIni:= MV_PAR09
	cpTnqFim:= MV_PAR10
	cGrupoIni:= MV_PAR11
	cGrupoFim:= MV_PAR12
	dpDtIni := POSICIONE("ZLE",1,xFILIAL("ZLE")+cpMix,"ZLE_DTINI")
	dpDtFim := POSICIONE("ZLE",1,xFILIAL("ZLE")+cpMix,"ZLE_DTFIM")
	_lMostraPrc := .T. //IIF(MV_PAR14==1,.T.,.F.)


	DbSelectArea("ZL2")
	ZL2->(DbSetOrder(1))
	ZL2->(MsSeek(xFILIAL("ZL2") + cpSetor))

	cDtSE2 := Condicao(1000,ZL2->ZL2_CONDPG)[1][1]// SubStr(DTOS(MonthSum(ZLE->ZLE_DTFIM,1)),1,6) + _cDia
	cDtSE2 := DTOS(cDtSE2)


	Private _aFunru := {0,""} //Dados do funrural
	Private _aFundesa := {0,""} //Dados do fundesa

	// Obtem dados de impressao
	cQuery := "SELECT A2_L_LI_RO AS LINHA,A2_COD AS FORNEC,A2_LOJA  AS LOJA"
	cQuery += " FROM "+RetSqlName("ZLF")+" ZLF, "+RetSqlName("SA2")+" SA2, "+RetSqlName("ZLT")+" ZLT "
	cQuery += " WHERE ZLF.D_E_L_E_T_ = ' ' AND SA2.D_E_L_E_T_ = ' ' AND ZLT.D_E_L_E_T_ = ' '"
	cQuery += " AND ZLF.ZLF_FILIAL = '"+xFILIAL("ZLF")+"' "
	cQuery += " AND SA2.A2_FILIAL = '"+xFILIAL("SA2")+"' "
	cQuery += " AND SA2.D_E_L_E_T_ = ' ' "
	cQuery += " AND ZLT.ZLT_FILIAL = '"+xFILIAL("ZLT")+"' "
	cQuery += " AND ZLF.ZLF_CODZLE = '"+cpMix+"' "
	if !empty(cpSetor)
		cQuery += " AND ZLF_SETOR = '"+cpSetor+"' "
	endif

	cQuery += " AND SA2.A2_L_TPFOR IN ('P','T') "
	cQuery += " AND ZLF.ZLF_LINROT BETWEEN '"+cpLinIni+"' AND '"+cpLinFim+"' "
	cQuery += " AND ZLF.ZLF_A2COD  BETWEEN '"+cpPrdIni+"' AND '"+cpPrdFim+"' "
	cQuery += " AND ZLF.ZLF_A2LOJA BETWEEN '"+cpLjIni+"' AND '"+cpLjFim+"' "
	cQuery += " AND ZLF.ZLF_A2COD  = SA2.A2_COD"
	cQuery += " AND ZLF.ZLF_A2LOJA = SA2.A2_LOJA"
	cQuery += " AND SA2.A2_L_GRUPO BETWEEN '"+cGrupoIni+"' AND '"+cGrupoFim+"' "
	cQuery += " AND ZLT.ZLT_COD BETWEEN '"+cpTnqIni+"' AND '"+cpTnqFim+"' "
	cQuery += " AND ZLT.ZLT_SA2COD = SA2.A2_COD
	cQuery += " AND ZLT.ZLT_SA2LJ  = SA2.A2_LOJA
	cQuery += " UNION"
	cQuery += " SELECT A2_L_LI_RO AS LINHA,A2_COD AS FORNEC,A2_LOJA AS LOJA"
	cQuery += " FROM "+RetSqlName("SE2")+" SE2, "+RetSqlName("SA2")+" SA2, "+RetSqlName("ZLT")+" ZLT "
	If (TcGetDB() == 'ORACLE')
		cQuery += " WHERE SUBSTR(SE2.E2_PREFIXO,1,2) = 'GL'"
	Else
		cQuery += " WHERE SUBSTRING(SE2.E2_PREFIXO,1,2) = 'GL'"
	EndIf
	cQuery += " AND SA2.A2_L_TPFOR IN ('P','T') "
	cQuery += " AND SE2.E2_SALDO > 0"
	cQuery += " AND SE2.E2_FILIAL = '"+xFILIAL("SE2")+"'"
	cQuery += " AND SA2.A2_FILIAL = '"+xFILIAL("SA2")+"'"
	cQuery += " AND ZLT.ZLT_FILIAL = '"+xFILIAL("ZLT")+"'"
	cQuery += " AND SE2.D_E_L_E_T_ = ' '"
	cQuery += " AND SA2.D_E_L_E_T_ = ' '"
	cQuery += " AND ZLT.D_E_L_E_T_ = ' '"
	cQuery += " AND SE2.E2_VENCTO < '"+cDtSE2+"'"
	cQuery += " AND SA2.A2_L_LI_RO BETWEEN '"+cpLinIni+"' AND '"+cpLinFim+"' "
	cQuery += " AND SA2.A2_L_GRUPO BETWEEN '"+cGrupoIni+"' AND '"+cGrupoFim+"' "
	cQuery += " AND SE2.E2_FORNECE BETWEEN '"+cpPrdIni+"' AND '"+cpPrdFim+"' "
	cQuery += " AND SE2.E2_LOJA    BETWEEN '"+cpLjIni+"' AND '"+cpLjFim+"' "
	cQuery += " AND SE2.E2_FORNECE = SA2.A2_COD"
	cQuery += " AND SE2.E2_LOJA    = SA2.A2_LOJA"
	cQuery += " AND ZLT.ZLT_COD BETWEEN '"+cpTnqIni+"' AND '"+cpTnqFim+"' "
	cQuery += " AND ZLT.ZLT_SA2COD = SA2.A2_COD
	cQuery += " AND ZLT.ZLT_SA2LJ  = SA2.A2_LOJA
	cQuery += " ORDER BY LINHA,FORNEC,LOJA"
	cQuery := ChangeQuery(cQuery)


	If Select("TRB") <> 0
		TRB->(dbCloseArea())
	EndIf

	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRB", .T., .F. )
	Count to nQtdReg

	oReport:Section(1):Init()
	oReport:SetMeter(nQtdReg)

	TRB->(dbGoTop())
	While !TRB->(Eof()) .And. !oReport:Cancel()

		// Cabecalho
		nCount++
		oReport:IncMeter()
		nL     := 50
		nItens := 0
		Cabec()

		// INICIO DOS EVENTOS DO PRODUTOR NA ZLF
		If _lMostraPrc

			nL += 10
			oReport:Say(nL,nTab01,"Eventos       ",oFontRotulo)
			oReport:Say(nL,nTab03,"Vlr do Litro (R$)",oFontRotulo)
			oReport:Say(nL,nTab04,"Creditos (R$)   ",oFontRotulo)
			oReport:Say(nL,nTab05,"D้bitos (R$)",oFontRotulo)
			nL += 50
			oReport:FillRect({nL,2300,nL+1,100},TBrush():New("",0))

			nL += 10

			// Obtem Eventos lancados ao produtor corrente
			cQuery := " SELECT ZLF_EVENTO AS EVENTO, "
			cQuery += " CASE WHEN ZLF_EVENTO = '"+cLT_EVEINSS+"' THEN 'D' ELSE ZLF_DEBCRE END AS DEBCRE,"
			cQuery += " MAX(ZLF_QTDBOM) AS QTDBOM,SUM(ZLF_TOTAL) AS TOTAL,SUM(ZLF_VLRPAG) AS VLRPAG "
			cQuery += " ,MAX(ZLF_DCREVE) as DCREVE,MAX(ZL8.ZL8_GRUPO) ZL8_GRUPO, MAX(ZL8_DESCRI) ZL8_DESCRI, ZL8_BASADI, ZL8_TPEVEN,"
			cQuery += " CASE WHEN ZLF_EVENTO = '"+cLT_EVEINSS+"' THEN '2' ELSE '1' END AS ORDEM "
			cQuery += " FROM "+RetSqlName("ZLF")+" ZLF "
			cQuery += " , "+RetSqlName("ZL8")+" ZL8 "
			cQuery += " WHERE ZL8.D_E_L_E_T_ = ' '  AND ZLF.D_E_L_E_T_ = ' '"
			cQuery += " AND ZLF.ZLF_EVENTO = ZL8.ZL8_COD "
			cQuery += " AND ZL8.ZL8_RECIBO = 'S' "
			cQuery += " AND ZL8.ZL8_TPEVEN IN ('L','A','R' )" //LEITE, AUTOMATICO, REDUTOR
			cQuery += " AND ZLF_FILIAL = '"+xFILIAL("ZLF")+"' "
			cQuery += " AND ZL8_FILIAL = '"+xFILIAL("ZL8")+"' "
			cQuery += " AND ZLF_CODZLE = '"+cpMix+"' "
			if !empty(cpSetor)
				cQuery += " AND ZLF_SETOR = '"+cpSetor+"' "
			endif
			cQuery += " AND ZLF_A2COD = '"+TRB->FORNEC+"' "
			cQuery += " AND ZLF_A2LOJA = '"+TRB->LOJA+"' "
			cQuery += " AND ZLF_TP_MIX = 'L' "
			cQuery += " GROUP BY ZLF_DEBCRE,ZL8_GRUPO,ZLF_EVENTO,ZLF_SEQ, ZL8_BASADI, ZL8_TPEVEN "
			cQuery += " ORDER BY ORDEM,ZL8_GRUPO,ZLF_DEBCRE,ZLF_EVENTO "
			If Select("TRC") <> 0
				TRC->(dbCloseArea())
			EndIf
			dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRC", .T., .F. )

			dbSelectArea("TRC")
			dbGoTop()
			While !TRC->(Eof()) .And. !oReport:Cancel()

				//Se agrupa as bonificacoes
				If lAgrupa
					While !TRC->(Eof()) .And. Trim(TRC->ZL8_GRUPO) == cLT_GRPBON
						nQTBom  := TRC->QTDBOM
						nBonIf  += TRC->TOTAL
						nTotCre += TRC->TOTAL
						TRC->(dbSkip())
					EndDo
				EndIf

				// IMPRIME BONIfICACOES AGRUPADAS
				If nBonIf > 0
					oReport:Say(nL,nTab01,"BONIfICAวีES",oFontRotulo)
					oReport:Say(nL,nTab03,TransForm(nBonIf/nQtBom,"@E 999,999,999.9999"),oFontNormal)
					oReport:Say(nL,nTab04,TransForm(nBonIf,"@E 999,999,999.99"),oFontNormal)
					nL += 50
					nBonIf := 0
					nItens += 1
				EndIf
				// FIM IMPRIME BONIfICACOES AGRUPADAS

				//Tratamento para nao imprimir uma linha em branco com valor zerado quando
				//o produtor nao tem nada de qualidade.
				If TRC->TOTAL > 0
					oReport:Say(nL,nTab01,TRC->ZL8_DESCRI,oFontRotulo)

					If TRC->DEBCRE == "C"
						If TRC->EVENTO == cEvetAdc
							_nTotal := TRC->TOTAL
						Else
							_nTotal := TRC->TOTAL
						EndIf

						//Tratamento para nao imprimir valor litro de Repasse
						If TRC->QTDBOM > 0
							oReport:Say(nL,nTab03,TransForm(_nTotal/TRC->QTDBOM,"@E 999,999,999.9999"),oFontNormal)
						EndIf
						oReport:Say(nL,nTab04,TransForm(_nTotal,"@E 999,999,999.99"),oFontNormal)
						nTotCre+=_nTotal
						nItens += 1
						_nTotal := 0
					Else
						If TRC->ZL8_TPEVEN $ "L/R" .and. TRC->EVENTO <> cLT_EVEINSS
							oReport:Say(nL,nTab03,TransForm( -(TRC->TOTAL/TRC->QTDBOM) ,"@E 999,999,999.9999"),oFontNormal)
							oReport:Say(nL,nTab04,TransForm( -TRC->TOTAL,"@E 999,999,999.99"),oFontNormal)
							nTotCre -= TRC->TOTAL
						Else
							oReport:Say(nL,nTab05,TransForm(TRC->TOTAL,"@E 999,999,999.99"),oFontNormal)
							nTotDeb+=TRC->TOTAL
						EndIf
						nItens += 1
					EndIf
					nL += 50
				EndIf

				TRC->(dbSkip())
			EndDo
		EndIf

		If _nVlrINSS == 0 //Caso nใo exista evento de funrural, utiliza valor da NF
			//Impresso funrural da NF - Guilherme Fran็a 30/08/2019
			VlrFunrural(cpMix,TRB->FORNEC,TRB->LOJA)
			If _aFunru[1] > 0
				oReport:Say(nL,nTab01,_aFunru[2],oFontRotulo)
				oReport:Say(nL,nTab05,Transform(_aFunru[1],"@E 999,999,999.99"),oFontNormal)
				nTotDeb += _aFunru[1]
				nL += 50
			EndIf
			If _aFundesa[1] > 0
				oReport:Say(nL,nTab01,_aFundesa[2],oFontRotulo)
				oReport:Say(nL,nTab05,Transform(_aFundesa[1],"@E 999,999,999.99"),oFontNormal)
				nTotDeb += _aFundesa[1]
				nL += 50
			EndIf
			_aFunru := {0,""}
			_aFundesa := {0,""}
			//final Funrural
		EndIf

		cMixStatus := POSICIONE("ZLF",1,XFILIAL("ZLF")+cpMix+'1'+TRB->FORNEC+TRB->LOJA,"ZLF_STATUS")


		If cMixStatus == 'F' // FECHADO  REGISTROS DO LEITE FICAM COM -S- E OS FINANCEIROS COMO -F-

			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Consulta os lancamentos gerados pelo MIX e fechamento de leite.  ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			cQuery := " SELECT ZLF_SETOR,ZLF_CODZLE,ZLF_DEBCRE,ZLF_TOTAL,ZLF_EVENTO, ZLF_SE1HIS,ZLF_VLRPAG,ZLF_SE1JUR,ZLF_SE1VLR "
			cQuery += " FROM "+RetSqlName("ZLF")+" ZLF"
			cQuery += " JOIN "+RetSqlName("ZL8")+" ZL8 ON ZL8_FILIAL = '" + xFILIAL("ZL8")+"' AND ZL8_COD = ZLF_EVENTO AND ZL8_TPEVEN = 'F' AND ZL8.D_E_L_E_T_ = ' '"
			cQuery += " WHERE ZLF.D_E_L_E_T_ = ' '"
			cQuery += " AND ZLF_FILIAL = '" + xFILIAL("ZLF")+"'"
			cQuery += " AND ZLF_DTINI >= '" + DTOS(dpDtIni) + "'"
			cQuery += " AND ZLF_DTFIM <= '" + DTOS(dpDtFim) + "'"
			cQuery += " AND ZLF_A2COD  = '" + TRB->FORNEC+"'"
			cQuery += " AND ZLF_A2LOJA = '" + TRB->LOJA+"'"
			cQuery += " AND ZLF_DEBCRE = 'D' "
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Verifica se o arquivo temporario ja existe, se sim, deleta-o.  ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			If Select("TRAB2") <> 0
				TRAB2->(dbCloseArea())
			EndIf

			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Cria o arquivo temporario com base no Select. ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			TCQUERY cQuery NEW ALIAS("TRAB2")

			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Posiciona no primeiro registro do arquivo temporario. ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			dbSelectArea("TRAB2")
			dbGoTop()
			While !TRAB2->(Eof())

				dbSelectArea("ZL8")
				dbSetOrder(1)
				dbSeek(xFILIAL("ZL8")+TRAB2->ZLF_EVENTO)

				AADD(aDebito,{TRAB2->ZLF_EVENTO,TRAB2->ZLF_TOTAL,TRAB2->ZLF_SE1HIS,TRAB2->ZLF_VLRPAG,TRAB2->ZLF_SE1JUR,TRAB2->ZLF_SE1VLR }) //ZL8->ZL8_DESCRI })

				// Passa para o proximo registro.
				TRAB2->(dbSkip())
			EndDo
			// Deleta o arquivo temporario.
			TRAB2->(dbCloseArea())

			//============FIM ALTERAวรO GUILHERME

			// IMPRIME CONVENIOS
		Else



			aConvenios := {}
		EndIf
		//======GUILHERME

		aDeposito  := {}

		IF !EMPTY(aDebito)
			For nCnt := 1 to len(aDebito)
				AADD(aConvenios,{aDebito[nCnt,3],aDebito[nCnt,2],aDebito[nCnt,1],aDebito[nCnt,4],aDebito[nCnt,5],aDebito[nCnt,6] })
			Next
		EndIf
		//======GUILHERME

		//Ordena pela coluna valor pago
		If .t.//Se nao agrupa o Saldo Devedor
			aSort(aConvenios,,, { |x,y| x[4] > y[4] })
		EndIf

		For nCnt := 1 To Len(aConvenios)
			nConvenios += aConvenios[nCnt,2]
			nConvPag   += aConvenios[nCnt,4]
			nVlrOrig   += aConvenios[nCnt,6]
		Next

		If nConvenios > 0
			oReport:Say(nL,nTab01,"CONVสNIOS",oFontRotulo)
			//Tratamento para imprimir o valor total do convenio,
			//nas situacoes onde ja foi realizado o fechamento definitivo ou previsao
			If nConvenios > 0
				oReport:Say(nL,nTab05,Transform(nConvenios+nConvJur,"@E 999,999,999.99"),oFontNormal)
				nTotDeb += nConvenios+nConvJur
			Else
				oReport:Say(nL,nTab05,Transform(nConvPag,"@E 999,999,999.99"),oFontNormal)
				nTotDeb += nConvPag
			EndIf
			nL += 50
		EndIf
		// FIM IMPRIME CONVENIOS AGRUPADOS
		oReport:FillRect({nL,2300,nL+1,100},TBrush():New("",0))

		nL += 10

		//Calcula o valor do desconto de redutor de qualidade.
		//O valor litro deve ser calculado, subtraindo-se o redutor de qualidade
		cCodLin := POSICIONE("SA2",1,xFILIAL("SA2")+TRB->FORNEC+TRB->LOJA,"A2_L_LI_RO")
		nRedut  := U_GetRedut(cpMix,TRB->FORNEC,TRB->LOJA,cpSetor," "," ")

		nVolProd:=U_VolLeite(xFILIAL("ZLF"),dpDtIni,dpDtFim,cpSetor,,TRB->FORNEC,TRB->LOJA)
		oReport:Say(nL,nTab03,TransForm(( nTotCre/nVolProd ),"@E 999,999,999.9999"),oFontRotulo)
		oReport:Say(nL,nTab04,TransForm(nTotCre,"@E 999,999,999.99"),oFontRotulo)
		oReport:Say(nL,nTab05,TransForm(nTotDeb,"@E 999,999,999.99"),oFontRotulo)

		If ( nTotCre>=nTotDeb )
			oReport:Say(nL,nTab01,"LIQUIDO CREDOR: " + Trim(TransForm(nTotCre-nTotDeb,"@E 999,999,999.99")),oFontRotulo)
		Else
			oReport:Say(nL,nTab01,"LIQUIDO DEVEDOR: " + Trim(TransForm(nTotCre-nTotDeb,"@E 999,999,999.99")),oFontRotulo)
		EndIf

		// INICIO DA RECEPCAO DIARIA DO LEITE
		nL += 100
		oReport:Say(nL,900,"VOLUME DE LEITE FORNECIDO",oFontRotulo)
		nL += 50
		oReport:FillRect({nL,2300,nL+1,100},TBrush():New("",0))
		nL += 10

		// do dia 1 a 10
		oReport:Say(nL,nPos1,"Dia",oFontRotulo)
		For n:=1 to 10
			oReport:Say(nL,90+(n*190),Space(11-Len(ALLTrim(STR(n))))+ALLTrim(STR(n)),oFontRotulo)
		Next n
		nL += 50
		oReport:Say(nL,nPos1,"Volume",oFontRotulo)
		For n:=1 to 10
			nAux:=u_getVolDay(TRB->FORNEC,TRB->LOJA,SubStr(DTOS(dpDtIni),1,6)+STRZero(n,2))
			oReport:Say(nL,110+(n*190),TransForm(nAux,"@E 999,999"),oFontNormal)
			nTotVol+=nAux
		Next n
		nL += 50
		oReport:FillRect({nL,2300,nL+1,100},TBrush():New("",0))

		// do dia 11 a 20
		oReport:Say(nL,nPos1,"Dia",oFontRotulo)
		For n:=11 to 20
			oReport:Say(nL,90+((n-10)*190),Space(11-Len(ALLTrim(STR(n))))+ALLTrim(STR(n)),oFontRotulo)
		Next n
		nL += 50
		oReport:Say(nL,nPos1,"Volume",oFontRotulo)
		For n:=11 to 20
			nAux:=u_getVolDay(TRB->FORNEC,TRB->LOJA,SubStr(DTOS(dpDtIni),1,6)+STRZero(n,2))
			oReport:Say(nL,110+((n-10)*190),TransForm(nAux,"@E 999,999"),oFontNormal)
			nTotVol+=nAux
		Next n
		nL += 50
		oReport:FillRect({nL,2300,nL+1,100},TBrush():New("",0))

		// do dia 21 a 30
		oReport:Say(nL,nPos1,"Dia",oFontRotulo)
		nUltDia:=val(SubStr(DTOS(dpDtFim),7,2)) // ultimo dia do mes
		For n:=21 to nUltDia
			oReport:Say(nL,90+((n-20)*190),Space(11-Len(ALLTrim(STR(n))))+ALLTrim(STR(n)),oFontRotulo)
		Next n
		nL += 50
		oReport:Say(nL,nPos1,"Volume",oFontRotulo)
		For n:=21 to nUltDia
			nAux:=u_getVolDay(TRB->FORNEC,TRB->LOJA,SubStr(DTOS(dpDtIni),1,6)+STRZero(n,2))
			oReport:Say(nL,110+((n-20)*190),TransForm(nAux,"@E 999,999"),oFontNormal)
			nTotVol+=nAux
		Next n
		nL += 50
		oReport:FillRect({nL,2300,nL+1,100},TBrush():New("",0))
		nL += 10
		oReport:Say(nL,nPos1,"Total:",oFontRotulo)
		oReport:Say(nL,nPos2,TransForm(nTotVol,"@E 999,999,999")+" Litros",oFontNormal)
		oReport:Say(nL,nPos3,"Media Diแria:",oFontRotulo)
		oReport:Say(nL,nPos4,TransForm(nTotVol/nUltDia,"@E 999,999,999")+" Litros",oFontNormal)

		nTotVol:=0
		// FIM DA RECEPCAO

		// INICIO DO PAGTO POR QUALIDADE
		nL += 100
		oReport:Say(nL,900,"RESULTADO DE ANALISES",oFontRotulo)
		nL += 50
		oReport:FillRect({nL,2300,nL+1,100},TBrush():New("",0))
		nL += 10
		oReport:Say(nL,nTab12,"Anแlise",oFontRotulo)
		oReport:Say(nL,nTab13,"Referencia",oFontRotulo)
		oReport:Say(nL,nTab14,'1ช Analise',oFontRotulo)
		oReport:Say(nL,nTab15,'2ช Analise',oFontRotulo)
		oReport:Say(nL,nTab16,"Media Aritm้tica",oFontRotulo)
		nL += 50
		oReport:FillRect({nL,2300,nL+1,100},TBrush():New("",0))
		nL += 10

		dbSelectArea("ZL9")
		dbSetOrder(1)
		dbSeek(xFILIAL("ZL9"))
		While !Eof() .And. xFILIAL("ZL9")==ZL9->ZL9_FILIAL .And. !oReport:Cancel()
			If ZL9->ZL9_TIPO = "Q"
				oReport:Say(nL,nTab12,ZL9->ZL9_DESCRI,oFontNormal)
				oReport:Say(nL,nTab13,ZL9->ZL9_REFERE,oFontNormal)

				cMasc := Iif(ZL9->ZL9_COD $ "010003#010004","@E 9,999,999","@E 99,999.99")

				// Obtem valor da primeira analise
				nAux := U_GetIndice(xFILIAL("ZL8"),cpSetor,TRB->FORNEC,TRB->LOJA,ZL9->ZL9_COD,ZL9->ZL9_MEDIA,dpDtFim,'1')

				oReport:Say(nL,nTab14,TransForm(nAux,cMasc),oFontNormal)

				// Obtem valor da segunda analise
				nAux := U_GetIndice(xFILIAL("ZL8"),cpSetor,TRB->FORNEC,TRB->LOJA,ZL9->ZL9_COD,ZL9->ZL9_MEDIA,dpDtFim,'2')
				oReport:Say(nL,nTab15,TransForm(nAux,cMasc),oFontNormal)

				// Media
				nAux := U_GetIndice(xFILIAL("ZL8"),cpSetor,TRB->FORNEC,TRB->LOJA,ZL9->ZL9_COD,ZL9->ZL9_MEDIA,dpDtFim,'M')
				oReport:Say(nL,nTab16,TransForm(nAux,cMasc),oFontNormal)

				nL += 50
			EndIf
			dbSkip()
		EndDo
		oReport:FillRect({nL,2300,nL+1,100},TBrush():New("",0))
		nL += 50
		// FIM DA QUALIDADE

		// DETALHAMENTO CONVENIO - alterar para mudar de pagina
		If Len(aConvenios) > 0
			oReport:Say(nL,900,"DETALHAMENTO CONVสNIO",oFontRotulo)
			nL += 50
			oReport:FillRect({nL,2300,nL+1,100},TBrush():New("",0))
			nL += 10
			oReport:Say(nL,nColCv5,"Vlr. Orig" ,oFontRotulo)
			oReport:Say(nL,nColCv6,"Vlr. Pag." ,oFontRotulo)

			nL += 50

			For nCnt := 1 To Len(aConvenios)
				// para imprime em nova pแgina caso ultrapasse o tamanho da pagina atual
				If nCnt == ( 33 - nItens )
					nL+=20
					oReport:Say(nL,nTab03,"continua na pr๓xima pแgina...",oFontNormal)
					oReport:EndPage()
					nL := 50
					cabec()
				EndIf

				If aConvenios[nCnt,3] != cLT_EVEINSS

						If (aConvenios[nCnt,2]+aConvenios[nCnt,4]+aConvenios[nCnt,5]+aConvenios[nCnt,6]) > 0
							oReport:Say(nL,nColCv1,SubStr(aConvenios[nCnt,1],1,35),oFontNormal)//Descricao do convenio
							oReport:Say(nL,nColCv5,Transform(aConvenios[nCnt,6],"@E 999,999.99"),oFontNormal)//Vlr. Orig
							oReport:Say(nL,nColCv6,Transform(aConvenios[nCnt,4],"@E 999,999.99"),oFontNormal)//Vlr. Pag.

						EndIf

				EndIf
				nL += 50
			Next
			oReport:FillRect({nL,2300,nL+1,100},TBrush():New("",0))
			nL += 10

			oReport:Say(nL,nColCv1,Space(10)+"TOTAL",oFontRotulo)
			oReport:Say(nL,(nColCv5),Transform(nVlrOrig  ,"@E 999,999.99"),oFontNormal)
			oReport:Say(nL,(nColCv6),Transform(nConvPag  ,"@E 999,999.99"),oFontNormal)

			//Inicio da impressao dos dados do recibo
			nL += 50
			oReport:FillRect({nL,2300,nL+1,100},TBrush():New("",0))
			nL += 20

			oReport:Say(nL,900,"RECIBO",oFontRotulo)
			nL += 40
			If ( nTotCre <> nTotDeb )
				If ( nTotCre>=nTotDeb )
					oReport:Say(nL,nTab01,"Declaro haver recebido da "+Alltrim(SM0->M0_NOMECOM)+" a importโncia de R$ " + AllTrim(Transform(nTotCre-nTotDeb,"@E 999,999.99")),oFontRotulo)
				Else
					oReport:Say(nL,nTab01,"Declaro meu saldo devedor para com a "+Alltrim(SM0->M0_NOMECOM)+" na importโncia de R$ " + AllTrim(Transform(nTotCre-nTotDeb,"@E 9,999,999.99")),oFontRotulo)
				EndIf
			EndIf

			nL += 120
			oReport:FillRect({nL,900,nL+1,100},TBrush():New("",0))
			nL += 10
			oReport:Say(nL,nTab01,ALLTRIM(SA2->A2_NOME),oFontRotulo)

			nTotDeb :=0
			nTotCre :=0
			nRepasse:=0
			nL += 100
		Else
			If _lMostraPrc
				//Inicio da impressao dos dados do recibo
				nL += 50
				oReport:FillRect({nL,2300,nL+1,100},TBrush():New("",0))
				nL += 10
				oReport:Say(nL,900,"RECIBO",oFontRotulo)
				nL += 40
				If ( nTotCre>=nTotDeb )
					oReport:Say(nL,nTab01,"Declaro haver recebido da "+Alltrim(SM0->M0_NOMECOM)+" a importโncia de R$ " + AllTrim(Transform(nTotCre-nTotDeb,"@E 999,999.99")),oFontRotulo)
				Else
					oReport:Say(nL,nTab01,"Declaro meu saldo devedor para com a "+Alltrim(SM0->M0_NOMECOM)+" na importโncia de R$ " + AllTrim(Transform(nTotCre-nTotDeb,"@E 9,999,999.99")),oFontRotulo)
				EndIf
				nL += 120
				oReport:FillRect({nL,900,nL+1,100},TBrush():New("",0))
				nL += 10
				oReport:Say(nL,nTab01,ALLTRIM(SA2->A2_NOME),oFontRotulo)
			EndIf
			nTotDeb :=0
			nTotCre :=0
			nRepasse:=0
			nL += 100
		EndIf
		// FIM DETALHAMENTO CONVENIO

		//Zera as variaveis para o proximo produtor
		aConvenios	:= {}
		aDebito		:= {}
		nConvenios := 0
		nConvJur   := 0
		nConvPag   := 0
		nVlrOrig   := 0
		nTotDeb    := 0
		nTotCre    := 0

		oReport:EndPage()
		TRB->(dbSkip())
	EndDo

	TRB->(dbCloseArea())
	oReport:Section(1):Finish()
Return(Nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ GetTanq  บ Autor ณ Microsiga          บ Data ณ  00/00/00   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetTanq(cpTpTq)

	Local cList := ""
	Local cRet  := ""
	Local x

	If !Empty(FwSX3Util():GetDescription("A2_L_CLASS"))
		cList:=GetSX3Cache("A2_L_CLASS", "X3_BOX")
		aList:=STRtokarr(cList,";")

		For x:=1 To Len(aList)
			If SubStr(aList[x],1,1)==cpTpTq
				cRet:=aList[x]
			EndIf
		Next x
	EndIf

Return(cRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ GetSA2   บ Autor ณ Microsiga          บ Data ณ  00/00/00   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetSA2(cpCodFor,cLojaPrd,cpCmp)

	Local aArea := GetArea()
	Local cRet

	cRet:=POSICIONE("SA2",1,xFILIAL("SA2")+cpCodFor,cpCmp)

	RestArea(aArea)
Return(cRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRGLT019   บAutor  ณMicrosiga           บ Data ณ  10/19/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Cabec

	Local cLogo := GetSrvProfString("Startpath","") + "dielat.bmp"
	Local _cGrupo := ""

	If MV_PAR02 == '000002'
		cLogo := GetSrvProfString("Startpath","") + "unibom.bmp"
	EndIf

	oReport:SayBitmap(nL,100,cLogo,186,155)

	nL += 50
	oReport:Say(nL,900,"Demonstrativo do Produtor" + Space(30) + MesExtenso(STR(Month(dpDtIni)))+" - "+STR(YEAR(dpDtFim),4),oFontTitulo)

	nL += 130
	oReport:FillRect({nL,2300,nL+1,100},TBrush():New("",0))
	nL += 10
	// FIM DO CABECALHO

	// INICIO DOS DADOS DO PRODUTOR

	// Posiciona no Produtor
	dbSelectArea("SA2")
	dbSetOrder(1)
	dbSeek(xFILIAL("SA2")+TRB->FORNEC+TRB->LOJA)

	_cGrupo := SA2->A2_L_GRUPO+" - "+Posicione("ZL5",1,XFILIAL("ZL5")+SA2->A2_L_GRUPO,"ZL5_DESCRI")
	//nL += 50
	oReport:Say(nL,nPos1,"PRODUTOR:",oFontRotulo)
	oReport:Say(nL,nPos2,SA2->A2_COD+ " " + SA2->A2_LOJA + " - " + SA2->A2_NOME,oFontNormal)

	If SA2->A2_TIPO == 'J'
		oReport:Say(nL,nPos3,"CNPJ:",oFontRotulo)
		oReport:Say(nL,nPos4,TransForm(SA2->A2_CGC,"@R 99.999.999/9999-99"),oFontNormal)
	Else
		oReport:Say(nL,nPos3,"CPF:",oFontRotulo)
		oReport:Say(nL,nPos4,TransForm(SA2->A2_CGC,"@R 999.999.999-99"),oFontNormal)
	EndIf
	nL += 50
	oReport:Say(nL,nPos1,"FAZENDA:",oFontRotulo)
	oReport:Say(nL,nPos2,Trim(SA2->A2_END)+Iif(SA2->A2_L_ENTDC=="T","",Space(5)+"-"+Space(5) + SA2->A2_L_ENTDC),oFontNormal)
	oReport:Say(nL,nPos3,"INSCRICAO:",oFontRotulo)
	oReport:Say(nL,nPos4,SA2->A2_INSCR,oFontNormal)

	nL += 50
	oReport:Say(nL,nPos1,"MUNICIPIO:",oFontRotulo)
	oReport:Say(nL,nPos2,AllTrim(Posicione("CC2",1,xFilial("CC2")+SA2->A2_EST+SA2->A2_COD_MUN,"CC2_MUN")) + " - " + SA2->A2_EST,oFontNormal)

	oReport:Say(nL,nPos3,"ROTA:",oFontRotulo)
	oReport:Say(nL,nPos4,SA2->A2_L_LI_RO+" - "+POSICIONE("ZL3",1,xFILIAL("ZL3")+SA2->A2_L_LI_RO,"ZL3_DESCRI"),oFontNormal)

	If !Empty(SA2->A2_BANCO)
		nL += 50
		oReport:Say(nL,nPos1,"BANCO: ",oFontRotulo)
		oReport:Say(nL,nPos2,SA2->A2_BANCO,oFontNormal)
		oReport:Say(nL,nTab13,"AGENCIA: ",oFontRotulo)
		oReport:Say(nL,nTab13+250,SA2->A2_AGENCIA,oFontNormal)
		oReport:Say(nL,nPos3,"CONTA: ",oFontRotulo)
		oReport:Say(nL,nPos4,SA2->A2_NUMCON,oFontNormal)
	EndIf

	If !Empty(SA2->A2_L_GRUPO)
		nL += 50
		oReport:Say(nL,nPos1,"ASSOCIAวรO: ",oFontRotulo)
		oReport:Say(nL,nPos2,_cGrupo,oFontNormal)
	EndIf

	nL += 50
	oReport:FillRect({nL,2300,nL+1,100},TBrush():New("",0))

	// FIM DOS DADOS DO PRODUTOR
Return

/*
===============================================================================================================================
Programa----------: VlrFunrural
Autor-------------: GUILHERME FRANวA
Data da Criacao---: 30/08/2019
===============================================================================================================================
Descricao---------: Retorna valor do funrural calculado na NF

===============================================================================================================================
Uso---------------: Modulo Gestao do Leite
===============================================================================================================================
*/
Static Function VlrFunrural(xcMix,xcCod,xcLoja)

	BeginSql alias "TNFL"

		SELECT F1_FORNECE, F1_LOJA, SUM(F1_VLSENAR) AS F1_VLSENAR, SUM(F1_INSS + F1_CONTSOC) AS F1_INSS, SUM(F1_VALFUND) AS F1_VALFUND,
		SUM(F1_VLSENAR+ F1_CONTSOC + F1_INSS) AS VLRTOT
		FROM %Table:SF1%  F1
		WHERE F1.F1_FORNECE = %Exp:xcCod%
		AND F1.F1_LOJA = %Exp:xcLoja%
		AND F1.F1_L_MIX = %Exp:xcMix%
		AND F1.%NotDel%
		GROUP BY F1_FORNECE, F1_LOJA
	EndSql

	DbSelectArea("TNFL")

	If TNFL->F1_INSS > 0
		_aFunru[1] :=  TNFL->VLRTOT
		_aFunru[2] := "FUNRURAL"
	ElseIf TNFL->F1_VLSENAR > 0
		_aFunru[1] :=  TNFL->F1_VLSENAR
		_aFunru[2] := "SENAR"
	EndIf

	If TNFL->F1_VALFUND > 0
		_aFundesa[1] := TNFL->F1_VALFUND
		_aFundesa[2] := "FUNDESA"
	EndIf

	TNFL->(DbCloseArea())

Return