#INCLUDE "Protheus.ch"
#INCLUDE "Report.ch"
#INCLUDE "TopConn.ch"
#INCLUDE "RwMake.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ RGLT033  º Autor ³ TOTVS                 º Data da Criacao  ³ 27/01/2009                						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de movimento do produtor.                                                                          º±±
±±º          ³ 															                               						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                          															  		º±±
±±º          ³ 															                               						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ Nenhum						   							                               						º±±
±±º			 ³														                                   						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ Nenhum													                               						º±±
±±º			 ³														                                   						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUsuario   ³															                             						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºSetor     ³ Gestao do Leite                                                                      						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º            						ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL                   						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor     ³ Data     ³ Motivo da Alteracao  				               ³Usuario(Filial+Matricula+Nome)    ³Setor        º±±
±±ÌÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄ¹±±
±±º          ³          ³                    							   ³                                  ³ 			º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function RGLT033()

Local oReport
Local oSA2
Private cPerg := "RGLT033   "
Private oBreak
Private cAlias:=GetNextAlias()
Private aOrd := {"Produtor+Linha","Produtor+Ticket" }

If !Pergunte(cPerg,.T.)
	Return
EndIf

DEFINE REPORT oReport NAME "RGLT033" TITLE "Movimento dos Produtores" PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)}

DEFINE SECTION oSA2 OF oReport TITLE "Produtor" TABLES "SA2" ORDERS aOrd

DEFINE CELL NAME "A2_COD" 		OF oSA2 ALIAS "SA2"
DEFINE CELL NAME "A2_NOME" 		OF oSA2 ALIAS "SA2"

DEFINE SECTION oZLD OF oSA2 TITLE "Movimento" TABLE "ZLD"

DEFINE CELL NAME "ZLD_TICKET" OF oZLD ALIAS "ZLD"
DEFINE CELL NAME "ZLD_DTCOLE" OF oZLD ALIAS "ZLD"
DEFINE CELL NAME "ZLD_LINROT" OF oZLD ALIAS "ZLD"
DEFINE CELL NAME "NOMELINHA"  OF oZLD ALIAS "" TITLE "Descrição" BLOCK {|| POSICIONE("ZLW",1,XFILIAL("ZLW")+(cAlias)->ZLD_LINROT,"ZLW_DESCRI") }
DEFINE CELL NAME "ZLD_QTDBOM" OF oZLD ALIAS "ZLD" TITLE "Qtd.Leite"
DEFINE CELL NAME "ZLD_QTDH2O" OF oZLD ALIAS "ZLD" TITLE "Qtd.Agua"
DEFINE CELL NAME "ZLD_DESH2O" OF oZLD ALIAS "ZLD" TITLE "Qtd.Desconto"
DEFINE CELL NAME "PENALIDADE" OF oZLD ALIAS "" TITLE "% Penalidade" BLOCK {|| Round((cAlias)->ZLD_DESH2O/(cAlias)->ZLD_QTDH2O,0)*100 }
DEFINE CELL NAME "QTDPAG"	  OF oZLD ALIAS "" PICTURE "@E 99,999,999" TITLE "Qtd.Pagar" BLOCK {|| (cAlias)->ZLD_QTDBOM - (cAlias)->ZLD_DESH2O }



oZLD:SetTotalInLine(.F.)

DEFINE FUNCTION FROM oZLD:Cell("ZLD_TICKET") OF oSA2 FUNCTION COUNT TITLE "Tickets"
DEFINE FUNCTION FROM oZLD:Cell("ZLD_QTDBOM") OF oSA2 FUNCTION SUM
DEFINE FUNCTION FROM oZLD:Cell("ZLD_QTDH2O") OF oSA2 FUNCTION SUM



oReport:PrintDialog()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RGLT033   ºAutor  ³Microsiga           º Data ³  01/05/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport)

Private _cFiltro:=""
Private _cOrdem:=""
Private nOrdem:=oReport:Section(1):GetOrder()

_cFiltro:="%"
_cFiltro+=" AND ZLD.ZLD_SETOR = '"+mv_par01+"' "
_cFiltro+=" AND ZLD.ZLD_LINROT BETWEEN '"+mv_par02+"' AND '"+mv_par03+"' "
_cFiltro+=" AND ZLD.ZLD_RETIRO BETWEEN '"+mv_par04+"' AND '"+mv_par06+"' "
_cFiltro+=" AND ZLD.ZLD_RETILJ BETWEEN '"+mv_par05+"' AND '"+mv_par07+"' "
_cFiltro+=" AND ZLD.ZLD_DTCOLE BETWEEN '"+dtos(mv_par08)+"' AND '"+dtos(mv_par09)+"' "
_cFiltro+="%"

if nOrdem==1 // Produtor+Linha
	_cOrdem:="%A2_COD,A2_LOJA,ZLD_LINROT,ZLD_DTCOLE%"

	DEFINE BREAK oBreak OF oZLD WHEN oZLD:Cell("ZLD_LINROT") TITLE "Total da Linha"
	DEFINE FUNCTION FROM oZLD:Cell("ZLD_QTDBOM") FUNCTION SUM BREAK oBreak
	DEFINE FUNCTION FROM oZLD:Cell("ZLD_QTDH2O") FUNCTION SUM BREAK oBreak
	DEFINE FUNCTION FROM oZLD:Cell("ZLD_DESH2O") FUNCTION SUM BREAK oBreak
	DEFINE FUNCTION FROM oZLD:Cell("QTDPAG") FUNCTION SUM BREAK oBreak


elseif nOrdem==2 // Produtor+Ticket
	_cOrdem:="%A2_COD,A2_LOJA,ZLD_TICKET,ZLD_DTCOLE%"
endif

#IFDEF TOP

	MakeSqlExp("REPORT")

	BEGIN REPORT QUERY oReport:Section(1)

	BeginSql alias cAlias
		SELECT A2_COD,A2_LOJA,A2_NOME,
				ZLD_RETIRO,ZLD_RETILJ,ZLD_TICKET,ZLD_QTDBOM,ZLD_DTCOLE,ZLD_LINROT,ZLD_QTDH2O,ZLD_DESH2O

		FROM %table:SA2% SA2, %table:ZLD% ZLD

		WHERE A2_FILIAL = %xfilial:SA2% AND SA2.%notDel%
			AND ZLD_FILIAL = %xfilial:ZLD% AND ZLD.%notDel%
			AND ZLD.ZLD_RETIRO = SA2.A2_COD
			AND ZLD.ZLD_RETILJ = SA2.A2_LOJA
	    	%exp:_cFiltro%

		ORDER BY %exp:_cOrdem%

	EndSql
	END REPORT QUERY oReport:Section(1)

	oZLD:SetParentQuery()
	oZLD:SetParentFilter({|aParam| (cAlias)->ZLD_RETIRO == aParam[1] .and. (cAlias)->ZLD_RETILJ == aParam[2] },{|| {(cAlias)->A2_COD,(cAlias)->A2_LOJA} } )

	oReport:Section(1):Print()

#ENDIF
Return