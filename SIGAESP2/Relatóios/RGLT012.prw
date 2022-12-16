#INCLUDE "TOTVS.CH"
#INCLUDE "REPORT.CH"
#include "protheus.ch"


// #########################################################################################
// Projeto: Gest�o do Leite
// Modulo : Gest�o do Leite
// Fonte  : RGLT012
// ---------+-------------------+-----------------------------------------------------------
// Data     | Autor             | Descricao
// ---------+-------------------+-----------------------------------------------------------
// 03/03/21 | Guilherme Fran�a  | Relat�rio de an�lises da qualidade
// ---------+-------------------+-----------------------------------------------------------


User Function RGLT012()

Private cPerg := "PRGLT012"

If !Pergunte(cPerg,.T.)
	Return
EndIf


oReport := ReportDef()
oReport:PrintDialog()

Return
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ReportDef �Autor  �Microsiga           � Data �  24/02/2016 ���
�������������������������������������������������������������������������͹��
���Desc.     � Defini��o do lay-out do relatorio.                         ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ReportDef()

Local oReport
Local oDetalhe
Private _lAcerto := .F.
Private cAliasFaixa := GetNextAlias()
Private cAliasFin := "FIN"
Private aOrd := {"Nome","Codigo+Loja"}

FaixasImp()//Gera lista das faixas que ir�o virar celulas do relatorio

cDtIni := DTOC(MV_PAR02)
cDtFIM := DTOC(MV_PAR03)


DEFINE REPORT oReport NAME "RGLT012" TITLE "Conferencia das An�lises - De "+cDtIni+" ate "+cDtFim PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)}

oReport:SetLandscape()
oReport:SetTotalInLine(.F.)
oReport:nFontBody := 8
oReport:nLineHeight	:= 35 // Define a altura da linha.

DEFINE SECTION oDetalhe OF oReport  TITLE "Detalhes"  TABLES "ZLB" ORDERS aOrd
oDetalhe:SetTotalInLine(.F.)

DEFINE CELL NAME "CODPRO" 		OF oDetalhe ALIAS "ZLB"	TITLE "C�digo" SIZE 08  		// 01
DEFINE CELL NAME "LOJA" 		OF oDetalhe ALIAS "ZLB" TITLE "Loja" SIZE 04 			// 02
DEFINE CELL NAME "NOME" 		OF oDetalhe ALIAS "ZLB" TITLE "Nome" SIZE 40  			// 03
DEFINE CELL NAME "DTANA" 		OF oDetalhe ALIAS "ZLB" TITLE "Dt.Analise" SIZE 10  			// 03
DEFINE CELL NAME "LAUDO" 		OF oDetalhe ALIAS "ZLB" TITLE "Laudo" SIZE 10  			// 03

//Celulas com as faixas
(cAliasFaixa)->(DbGoTop())
While !(cAliasFaixa)->(Eof())
	DEFINE CELL NAME Alltrim((cAliasFaixa)->TIPOFX)	OF oDetalhe ALIAS ""  	TITLE (cAliasFaixa)->DESCRIFX PICTURE "@E 99,999.99"  SIZE 10
    oDetalhe:Cell(Alltrim((cAliasFaixa)->TIPOFX)):SetHeaderAlign("CENTER")
	(cAliasFaixa)->(DbSkip())
EndDo

DEFINE CELL NAME "DESQUA" 		    OF oDetalhe ALIAS "ZLB" TITLE "Qualificado"
DEFINE CELL NAME "VALOR" 			OF oDetalhe ALIAS ""  	TITLE "Valor R$" PICTURE "@E 9,999.99"  SIZE 8

oDetalhe:Cell("DESQUA"):SetAlign("CENTER")

DEFINE FUNCTION FROM oDetalhe:Cell("VALOR" ) FUNCTION SUM

Return(oReport)
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PrintReport   �Autor  �Microsiga       � Data �  11/24/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function PrintReport(oReport)

Local _nReg  	:= 0
Local oDetalhe	:= oReport:Section(1)
Local _cRetiro	:= ""
Local _cLoja    := ""
Local _cDTana   := ""
Local _cLaudo := ""
Local _nVlrTot := 0
Local _nGrpAnaDesq := Alltrim(GetMv("LT_ANACCS"))+"/"+Alltrim(GetMv("LT_ANAEST"))
Private _cAlias := GetNextAlias()

CriaTab(_cAlias,oDetalhe)

dbSelectArea(_cAlias)
Count to _nReg

LimpaDet(@oDetalhe)

(_cAlias)->(dbGoTop())
oReport:SetMeter(RecCount())
oDetalhe:Init()

While !(_cAlias)->(Eof())

	oReport:IncMeter() //Incrementa r�gua

	If (Alltrim(_cRetiro+_cLoja) <> Alltrim((_cAlias)->CODPRO + (_cAlias)->LOJA)) .or. (_cDTana <> (_cAlias)->DTANA)  .or. (_cLaudo <> (_cAlias)->LAUDO)

		oDetalhe:Cell("CODPRO"):SetValue((_cAlias)->CODPRO)
		oDetalhe:Cell("LOJA"):SetValue((_cAlias)->LOJA)
		oDetalhe:Cell("NOME"):SetValue((_cAlias)->NOME)
        oDetalhe:Cell("DTANA"):SetValue(DTOC(STOD((_cAlias)->DTANA)))
		oDetalhe:Cell("LAUDO"):SetValue((_cAlias)->LAUDO)
		If Alltrim((_cAlias)->TIPOFX) $ _nGrpAnaDesq //Atualiza campo de desqualifica��o somente no CCS ou EST - Espec�fico COOPEAVI
        	oDetalhe:Cell("DESQUA"):SetValue( Iif((_cAlias)->DESQUA<>'S',"Sim","N�o"))
		EndIf

        _cRetiro := (_cAlias)->CODPRO
		_cLoja   := (_cAlias)->LOJA
        _cDTana := (_cAlias)->DTANA
		_cLaudo := (_cAlias)->LAUDO
		_nVlrTot := 0

	EndIf


	oDetalhe:Cell(Alltrim((_cAlias)->TIPOFX)):SetValue((_cAlias)->VLRANA )
    _nVlrTot += (_cAlias)->VALOR

	(_cAlias)->(dbSkip())

	If (Alltrim(_cRetiro+_cLoja) <> Alltrim((_cAlias)->CODPRO + (_cAlias)->LOJA)) .or. (_cDTana <> (_cAlias)->DTANA)

	    oDetalhe:Cell("VALOR"):SetValue(_nVlrTot)
		_nVlrTot := 0
		oDetalhe:PrintLine()

		LimpaDet(@oDetalhe)

	EndIf

EndDo

oDetalhe:Finish()

Return
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CriaTab �Autor  �Microsiga             � Data �  04/11/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Cria tabela tempor�ria para impress�o do relat�rio.        ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function CriaTab(_cAlias,oObj)

Local nOrdem := 1
Local cOrdem := ""
Local cQuery := ""
Local _cFiltro := FormatIn(SubStr(MV_PAR06,1,Len(Alltrim(MV_PAR06))-1),"/")


nOrdem := oObj:GetOrder()

If nOrdem == 1
	cOrdem := " ZLB_DCRRET,ZLB_RETIRO, ZLB_RETILJ, ZLB_DATA, ZLB_LAUDO, ZLB_TIPOFX  "
Else
	cOrdem := " ZLB_RETIRO, ZLB_RETILJ, ZLB_DATA, ZLB_LAUDO, ZLB_TIPOFX "
EndIf

cQuery := " SELECT ZLB_RETIRO AS CODPRO , ZLB_RETILJ AS LOJA , ZLB_DCRRET AS NOME, ZLB_LAUDO AS LAUDO, ZLB_DATA AS DTANA, "
cQuery += " ZLB_TIPOFX AS TIPOFX, ZLB_VLRANA AS VLRANA, ZLB_VLRDIN AS VALOR, ZLB_DESQUA AS DESQUA "
cQuery += " FROM " + RetSqlName("ZLB") + " ZLB "
cQuery += " WHERE "
cQuery += " ZLB_FILIAL = '"+xFilial("ZLB")+"'  "
cQuery += " AND ZLB_SETOR = '"+MV_PAR01+"'  "
cQuery += " AND ZLB_DATA BETWEEN '"+DTOS(MV_PAR02)+"' AND '"+DTOS(MV_PAR03)+"'   "
cQuery += " AND ZLB_RETIRO BETWEEN '"+MV_PAR04+"' AND '"+MV_PAR05+"'   "
cQuery += " AND ZLB_TIPOFX IN  "+_cFiltro+" "
If !Empty(MV_PAR07)
    cQuery += " AND ZLB_LAUDO =  "+MV_PAR07+" "
EndIf
If MV_PAR08 == 1 //somente qualificadas
    cQuery += " AND ZLB_DESQUA <> 'S' "
ElseIf MV_PAR08 == 2 //somente desqualificadas
    cQuery += " AND ZLB_DESQUA = 'S' "
EndIf

cQuery += " AND D_E_L_E_T_ = ' ' "
cQuery += " ORDER BY "+cOrdem

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), _cAlias, .T., .F. )

DbSelectArea(_cAlias)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  FaixasImp   �Autor  �Microsiga           � Data �  22/08/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function FaixasImp()

Local _cFiltro := FormatIn(SubStr(MV_PAR06,1,Len(MV_PAR06)-1),"/")
Local cQuery := ""

If Select(cAliasFaixa) <> 0
	(cAliasFaixa)->(DbCloseArea())
EndIf

cQuery := " SELECT ZLB_TIPOFX AS TIPOFX, ZLB_DCRTPF AS DESCRIFX "
cQuery += " FROM " + RetSqlName("ZLB") + " ZLB "
cQuery += " WHERE "
cQuery += " ZLB_FILIAL = '"+xFilial("ZLB")+"'  "
cQuery += " AND ZLB_SETOR = '"+MV_PAR01+"'  "
cQuery += " AND ZLB_DATA BETWEEN '"+DTOS(MV_PAR02)+"' AND '"+DTOS(MV_PAR03)+"'   "
cQuery += " AND ZLB_RETIRO BETWEEN '"+MV_PAR04+"' AND '"+MV_PAR05+"'   "
cQuery += " AND ZLB_TIPOFX IN  "+_cFiltro+" "
If !Empty(MV_PAR07)
    cQuery += " AND ZLB_LAUDO =  "+MV_PAR07+" "
EndIf
If MV_PAR08 == 1 //somente qualificadas
    cQuery += " AND ZLB_DESQUA <> 'S' "
ElseIf MV_PAR08 == 2 //somente desqualificadas
    cQuery += " AND ZLB_DESQUA = 'S' "
EndIf
cQuery += " AND D_E_L_E_T_ = ' ' "
cQuery += " GROUP BY ZLB_TIPOFX, ZLB_DCRTPF "
cQuery += " ORDER BY 1,2 "

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasFaixa, .T., .F. )

DbSelectArea(cAliasFaixa)

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �LimpaDet  �Autor  �Microsiga           � Data �  04/11/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Limpa c�lulas da sess�o oDetalhe.                          ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function LimpaDet(oDetalhe)

Local nTamanho := Len(oDetalhe:aCell)
Local _iCol	   := 0
// Limpa os dados das c�lulas do relat�rio.
For _iCol := 1 to nTamanho
 If oDetalhe:Cell(_iCol):cType == "D"
  oDetalhe:Cell(_iCol):SetValue(CtoD("  /  /  "))
 ElseIf oDetalhe:Cell(_iCol):cType == "C"
  oDetalhe:Cell(_iCol):SetValue("")
 Else
  oDetalhe:Cell(_iCol):SetValue(0)
 EndIf
Next _iCol

Return