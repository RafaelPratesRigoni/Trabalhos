#INCLUDE "TOTVS.CH"
#INCLUDE "REPORT.CH"
#include "protheus.ch"


// #########################################################################################
// Projeto: Gest�o do Leite
// Modulo : Gest�o do Leite
// Fonte  : RGLT071
// ---------+-------------------+-----------------------------------------------------------
// Data     | Autor             | Descricao
// ---------+-------------------+-----------------------------------------------------------
// 03/03/21 | Guilherme Fran�a  | Relat�rio de ranking dos maiores produtores
// ---------+-------------------+-----------------------------------------------------------


User Function RGLT071()

Private cPerg := "PRGLT071"

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
Local _cQtdPrd := "0"



cDtIni := DTOC(MV_PAR02)
cDtFIM := DTOC(MV_PAR03)
_cQtdPrd := cValToChar(MV_PAR01)

DEFINE REPORT oReport NAME "RGLT071" TITLE "Ranking dos "+_cQtdPrd+" maiores produtores - De "+cDtIni+" ate "+cDtFim PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)}

oReport:SetPortrait()
oReport:SetTotalInLine(.F.)
oReport:nFontBody := 10
oReport:nLineHeight	:= 35 // Define a altura da linha.
oReport:lEndReport := .f.

DEFINE SECTION oDetalhe OF oReport  TITLE "Detalhes"  TABLES "SA2"
oDetalhe:SetTotalInLine(.F.)

DEFINE CELL NAME "POSICAO" 	OF oDetalhe ALIAS ""	TITLE "Posi��o" SIZE 08  		// 01
DEFINE CELL NAME "CODPRO" 	OF oDetalhe ALIAS ""	TITLE "C�digo" SIZE 08  		// 01
DEFINE CELL NAME "NOME" 	OF oDetalhe ALIAS "" TITLE "Nome" SIZE 60  			// 03
DEFINE CELL NAME "GRUPO" 	OF oDetalhe ALIAS ""	TITLE "Grp.Pre�o" SIZE 12  		// 01
DEFINE CELL NAME "SETOR" 	OF oDetalhe ALIAS ""	TITLE "Setor" SIZE 12  		// 01
DEFINE CELL NAME "VOLUME"	OF oDetalhe ALIAS ""  	TITLE "Qtd.Leite" PICTURE "@E 99,999,999"  SIZE 16


DEFINE FUNCTION FROM oDetalhe:Cell("VOLUME" ) FUNCTION SUM

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
Local _cSetor := ""
Local oDetalhe	:= oReport:Section(1)
Local _aRegis := U_MAIORPROD(MV_PAR01,"R",MV_PAR02,MV_PAR03) //Usa mesma fun��o usada no evento de maiores produtores, dentro de MGLT002
Local ix := 0

_nReg := Len(_aRegis)

LimpaDet(@oDetalhe)

oReport:SetMeter(RecCount())

oDetalhe:Init()


For ix := 1 to _nReg

	oReport:IncMeter() //Incrementa r�gua

	oDetalhe:Cell("POSICAO"):SetValue(StrZero(ix,3))
	oDetalhe:Cell("VOLUME"):SetValue(_aRegis[ix][3])

	If _aRegis[ix][2] == "P"
        DbSelectArea("SA2")
        DbSetOrder(1)
        MsSeek(xFilial("SA2")+_aRegis[ix][1],.T.)

		oDetalhe:Cell("CODPRO"):SetValue(SA2->A2_COD)
		oDetalhe:Cell("NOME"):SetValue(SA2->A2_NOME)
		oDetalhe:Cell("GRUPO"):SetValue(SA2->A2_L_LI_RO)
		_cSetor := GetAdvFVal("ZL3","ZL3_SETOR",xFILIAL("ZL3")+SA2->A2_L_LI_RO,1,"")
		oDetalhe:Cell("SETOR"):SetValue(_cSetor)
	Else
        DbSelectArea("ZL5")
        DbSetOrder(1)
        MsSeek(xFilial("ZL5")+_aRegis[ix][1])

		oDetalhe:Cell("CODPRO"):SetValue(_aRegis[ix][2])
		oDetalhe:Cell("NOME"):SetValue("GRUPO "+ZL5->ZL5_DESCRI)

	EndIf

	oDetalhe:PrintLine()

	LimpaDet(@oDetalhe)

Next ix

oDetalhe:Finish()

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
Local _iCol := 0
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