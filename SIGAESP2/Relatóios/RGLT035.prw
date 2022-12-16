#include "protheus.ch"
#include "report.ch"

/*/
������������������������������������������������������������������������������������������������������������������������������
������������������������������������������������������������������������������������������������������������������������������?
���������������������������������������������������������������������������������������������������������������������������ͻ�?
���Programa  ?RGLT035  ?Autor ?TOTVS                 ?Data da Criacao  ?13/10/2009                						��?
���������������������������������������������������������������������������������������������������������������������������͹�?
���Descricao ?Relacao de Producao por Municipio                     														��?
��?         ?															                               						��?
���������������������������������������������������������������������������������������������������������������������������͹�?
���Uso       ?															                               						��?
��?         ?															                               						��?
���������������������������������������������������������������������������������������������������������������������������͹�?
��?		 ?													                                   						��?
���������������������������������������������������������������������������������������������������������������������������͹�?
���Retorno   ?Nenhum						  							                               						��?
��?		 ?													                                   						��?
��?		 ?													                                   						��?
���������������������������������������������������������������������������������������������������������������������������͹�?
���Usuario   ?Totvs / Microsiga											                             					��?
���������������������������������������������������������������������������������������������������������������������������͹�?
���Setor     ?Gestao do Leite                                                                          					��?
���������������������������������������������������������������������������������������������������������������������������͹�?
��?           			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL                   						��?
���������������������������������������������������������������������������������������������������������������������������͹�?
���Autor     ?Data     ?Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor        ��?
���������������������������������������������������������������������������������������������������������������������������ĺ�?
��?         ?         ?                  							   ?                                 ? 	        ��?
��?---------?---------?-------------------------------------------------?---------------------------------?------------��?
��?         ?         ?                   							   ?                                 ?			��?
��?---------?---------?-------------------------------------------------?---------------------------------?------------��?
���������������������������������������������������������������������������������������������������������������������������ͼ�?
������������������������������������������������������������������������������������������������������������������������������?
������������������������������������������������������������������������������������������������������������������������������?
*/
User Function RGLT035()

Local cDesc1			:= "Este programa tem como objetivo imprimir relatorio "
Local cDesc2			:= "de acordo com os parametros informados pelo usuario."
Local cDesc3			:= "Producao por Municipio"
Local titulo			:= "Producao por Municipio"
Local nLin				:= 80
Local Cabec1			:= "EST MUNICIPIO     						QTD PRD.      VOLUME"
Local Cabec2			:= ""
Local aOrd				:= {}
Private lEnd			:= .F.
Private lAbortPrint		:= .F.
Private CbTxt			:= ""
Private limite			:= 80
Private tamanho			:= "P"
Private nomeprog		:= "RGLT035" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo			:= 18
Private aReturn			:= { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey		:= 0
Private cbcont			:= 00
Private CONTFL			:= 01
Private m_pag			:= 01
Private wnrel			:= "RGLT035" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cPerg			:= "RGLT035   "
Private cString			:= "ZLD"

pergunte(cPerg,.F.)

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)
If nLastKey == 27
	Return
EndIf
SetDefault(aReturn,cString)
If nLastKey == 27
	Return
EndIf
nTipo := If(aReturn[4]==1,15,18)
RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
������������������������������������������������������������������������������������������������������������������������������?
������������������������������������������������������������������������������������������������������������������������������?
���������������������������������������������������������������������������������������������������������������������������ͻ�?
���Programa  ?RUNREPORT   ?Autor ?Abrahao P. Santos     ?Data da Criacao  ?09/12/2008             						��?
���������������������������������������������������������������������������������������������������������������������������͹�?
���Descricao ?uncao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS monta a janela com a regua de processamento.		��?
��?		 ?													                                   						��?
��?         ?															                               						��?
���������������������������������������������������������������������������������������������������������������������������͹�?
���Uso       ?	Programa principal										                               						��?
��?         ?															                               						��?
��?         ?															                               						��?
���������������������������������������������������������������������������������������������������������������������������͹�?
���Parametros?	Nenhum																										��?
��?		 ?											   					                       						��?
��?		 ?																											��?
��?		 ?													                                   						��?
���������������������������������������������������������������������������������������������������������������������������͹�?
���Retorno   ?Nenhum						  							                               						��?
��?		 ?													                                   						��?
��?		 ?													                                   						��?
���������������������������������������������������������������������������������������������������������������������������͹�?
���Usuario   ?Totvs / Microsiga											                             					��?
���������������������������������������������������������������������������������������������������������������������������͹�?
���Setor     ?Gestao do Leite                                                                          					��?
���������������������������������������������������������������������������������������������������������������������������͹�?
��?           			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL                   						��?
���������������������������������������������������������������������������������������������������������������������������͹�?
���Autor     ?Data     ?Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor        ��?
���������������������������������������������������������������������������������������������������������������������������ĺ�?
��?         ?         ?                  							   ?                                 ? 	        ��?
��?---------?---------?-------------------------------------------------?---------------------------------?------------��?
��?         ?         ?                   							   ?                                 ?			��?
��?---------?---------?-------------------------------------------------?---------------------------------?------------��?
���������������������������������������������������������������������������������������������������������������������������ͼ�?
������������������������������������������������������������������������������������������������������������������������������?
������������������������������������������������������������������������������������������������������������������������������?
/*/
Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
Local nQtd:=0
Local nQtdTot:=0
Local nVolTot:=0

cQuery1 := " SELECT A2_EST,A2_COD_MUN,COUNT(*) AS QTD ,SUM(ZLD_QTDBOM) AS VOLUME "
cQuery1 += " FROM " + RetSqlName("ZLD") + " ZLD, "+RETSQLNAME("SA2")+" SA2 "
cQuery1 += " WHERE ZLD.D_E_L_E_T_ = ' ' AND SA2.D_E_L_E_T_ = ' ' "
cQuery1 += " AND ZLD.ZLD_FILIAL = '" + XFILIAL("ZLD") + "' "
cQuery1 += " AND SA2.A2_FILIAL = '" + XFILIAL("SA2") + "' "
cQuery1 += " AND ZLD.ZLD_SETOR = '" + mv_par01 + "' "
cQuery1 += " AND ZLD.ZLD_DTCOLE BETWEEN '" + dtos(mv_par02) + "' AND  '" + dtos(mv_par03) + "' "
cQuery1 += " AND SA2.A2_COD = ZLD.ZLD_RETIRO "
cQuery1 += " AND SA2.A2_LOJA = ZLD.ZLD_RETILJ "
cQuery1 += " GROUP BY A2_EST,SA2.A2_COD_MUN "
cQuery1 += " HAVING (SUM(ZLD_QTDBOM) > 0) ""


If Select("TRL") > 0
	dbSelectArea("TRL")
	("TRL")->(dbCloseArea())
EndIf
dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery1), "TRL", .T., .F. )

COUNT TO nqtdregs
setRegua(nqtdregs)

TRL->(dbgotop())

while TRL->(!eof())

	incregua()

    if nLin >= 50
   		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
   		nLin := 9
	endif


	// MOSTRA PRODUTOR E SEUS RESPECTIVOS VALORES
	@nLin,000 PSAY transform(alltrim(TRL->A2_EST),"@!")
	@nLin,004 PSAY transform(alltrim(TRL->A2_COD_MUN),"@!")
	@nLin,010 PSAY transform(alltrim(POSICIONE("CC2",1,XFILIAL("CC2")+TRL->A2_EST+TRL->A2_COD_MUN,"CC2_MUN")),"@!")

	nQtd := getQtd(TRL->A2_EST,TRL->A2_COD_MUN)
	@nLin,048 PSAY transform(nQtd,"@E 9999")
	@nLin,055 PSAY transform(TRL->VOLUME,"@E 999,999,999")
 	nLin++

	nQtdTot+=nQtd
	nVolTot+=TRL->VOLUME

	TRL->(DBSKIP())
enddo
TRL->(dbclosearea())

nLin++
@nLin,000 PSAY "Total ---------------> "
@nLin,048 PSAY transform(nQtdTot,"@E 9999")
@nLin,055 PSAY transform(nVolTot,"@E 999,999,999")


SET DEVICE TO SCREEN
If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
EndIf
MS_FLUSH()
Return

/*
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
�������������������������������������������������������������������������ͻ�?
���Programa  �getQtd    �Autor  �Abrahao P. Santos   ?Data ? 10/13/09   ��?
�������������������������������������������������������������������������͹�?
���Desc.     ?Obtem qtd de produtores que movimentaram                   ��?
��?         ?                                                           ��?
�������������������������������������������������������������������������͹�?
���Uso       ?AP                                                        ��?
�������������������������������������������������������������������������ͼ�?
����������������������������������������������������������������������������?
����������������������������������������������������������������������������?
*/
Static Function getQtd(cEst,cMun)
Local oAlias:=GetNextAlias()
Local nRet:=0

cQuery1 := " SELECT SA2.A2_COD,SA2.A2_LOJA "
cQuery1 += " FROM " + RetSqlName("ZLD") + " ZLD, "+RETSQLNAME("SA2")+" SA2 "
cQuery1 += " WHERE ZLD.D_E_L_E_T_ = ' ' AND SA2.D_E_L_E_T_ = ' ' "
cQuery1 += " AND ZLD.ZLD_FILIAL = '" + XFILIAL("ZLD") + "' "
cQuery1 += " AND SA2.A2_FILIAL = '" + XFILIAL("SA2") + "' "
cQuery1 += " AND ZLD.ZLD_SETOR = '" + mv_par01 + "' "
cQuery1 += " AND ZLD.ZLD_DTCOLE BETWEEN '" + dtos(mv_par02) + "' AND  '" + dtos(mv_par03) + "' "
cQuery1 += " AND SA2.A2_EST   = '" + cEst + "' "
cQuery1 += " AND SA2.A2_COD_MUN = '" + cMun + "' "
cQuery1 += " AND SA2.A2_COD = ZLD.ZLD_RETIRO "
cQuery1 += " AND SA2.A2_LOJA = ZLD.ZLD_RETILJ "
cQuery1 += " GROUP BY SA2.A2_COD,SA2.A2_LOJA "
dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery1), oAlias, .T., .F. )

Count to nRet

(oAlias)->(DbCloseArea())

return nRet
