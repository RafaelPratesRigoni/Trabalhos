#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "SHELL.CH"
#include "report.ch"
#INCLUDE "TOTVS.CH"
#include "rwmake.ch"
#INCLUDE "RPTDEF.CH"
/*/
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  � RGLT068  � Autor � Guilherme Fran�a      � Data da Criacao  � 12/07/2016                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Relatorio de emissao das etiquetas para envelopes do fechamento do leite baseado nas notas fiscais.         ���
���          �                   												                               				���
���������������������������������������������������������������������������������������������������������������������������͹��
���Uso       �                                                                   						                    ���
���������������������������������������������������������������������������������������������������������������������������͹��
���Parametros� MIX                                           			                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Retorno   � Nenhum						  							                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Usuario   � Microsiga                                                                                					���
���������������������������������������������������������������������������������������������������������������������������͹��
���Setor     � Financeiro                                                                           						���
���������������������������������������������������������������������������������������������������������������������������͹��
���            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Autor     � Data     � Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor        ���
���������������������������������������������������������������������������������������������������������������������������ĺ��
���          �          �                                			       �00-000000 -                       � TI	        ���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���          �          �                    							   �                                  � 			���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���������������������������������������������������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
/*/

User Function RGLT068()

Private _cPerg := "RGLT068"


//����������������������������������������������������������������������Ŀ
//� Ajusta pergunta de parametros                                        �
//������������������������������������������������������������������������
If !Pergunte(_cPerg,.T.)
	Return
EndIf

//����������������������������������������������������������������������Ŀ
//� Funcao que retorna o report montado com as configuraoes do relatorio �
//������������������������������������������������������������������������
oReport := ReportDef()
oReport:PrintDialog()

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RGLT068NEW�Autor  �Microsiga           � Data �  08/05/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao que retorna o report montado com as configuraoes do relatorio ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ReportDef()

Private oReport


oReport := TReport():NEW("RGLT068" ,"Relatorio de Etiquetas" ,_cPerg,{|oReport|PrintReport(oReport)} ,"")

oReport:nLineHeight	:= 45            // Define a altura da linha.
oReport:lParamPage		:= .F.
oReport:lHeaderVisible 	:= .F.
oReport:lFooterVisible 	:= .F.
oReport:SetPortrait(.T.)
oReport:lParamPage := .F.
oReport:GetOrientation(1)
oReport:SetTotalInLine(.F.)

Return oReport


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RGLT068NEW�Autor  �Microsiga           � Data �  08/05/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Funcao que executa impressao do relatorio                  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function PrintReport(oReport)

Local _cAlias := GetNextAlias()
Local _cMix := MV_PAR01
Local oFont10 		:= TFont():New("COURIER NEW",10,11,,.F.,,,,.T.,.F.)
Local oFont10N		:= TFont():New("COURIER NEW",10,11,,.T.,,,,.T.,.F.)
Local _nCont := 1
Local _nCol := 0
Local _nLin := 12
Local _cCol1 := ""
Local _cCol2 := ""
Local _cCol3 := ""


BeginSql Alias _cAlias

	SELECT F1_DOC, F1.F1_FORNECE+'-'+F1.F1_LOJA AS CODIGO,
		A2.A2_NOME AS NOME,
		CASE WHEN A2.A2_L_TPPAG = 'C' THEN 'CHEQUE' ELSE 'BANCO' END AS PGTO,
		A2.A2_END AS ENDERECO,
		A2.A2_MUN AS MUNICIPIO,
		A2.A2_CEP AS CEP,
		L3.ZL3_DESCRI AS LINHA
	FROM %Table:SF1% F1
		JOIN %Table:SA2% A2 ON A2_COD = F1_FORNECE AND A2.A2_LOJA = F1.F1_LOJA AND A2.D_E_L_E_T_ = ' '
		JOIN %Table:ZL3% L3 ON L3.ZL3_COD = A2.A2_L_LI_RO AND L3.D_E_L_E_T_ = ' '
	WHERE F1_FILIAL = %Exp:xFilial("SF1")% AND F1_L_MIX = %Exp:_cMix% AND F1.%NotDel%
	ORDER BY F1_DOC

EndSql

oReport:StartPage()

While !(_cAlias)->(Eof())

	If _nCont == 31 //oReport:Row() >= oReport:PageHeight() - 80
		oReport:EndPage()
		oReport:StartPage()
		_nLin := 12//100
		_nCont := 1
	EndIf

	_cCol1 := "01/04/07/10/13/16/19/22/25/28"
	_cCol2 := "02/05/08/11/14/17/20/23/26/29"
	_cCol3 := "03/06/09/12/15/18/21/24/27/30"

	If StrZero(_nCont,2) $ _cCol1
		_nCol := 0.03
		_nLin += 100
	ElseIf StrZero(_nCont,2) $ _cCol2
		_nCol := 0.40
		_nLin -= 200
	ElseIf StrZero(_nCont,2) $ _cCol3
		_nCol := 0.78
		_nLin -= 200
	EndIf

	oReport:Say(_nLin ,oReport:PageWidth() * _nCol	, "Codigo: "+(_cAlias)->CODIGO,oFont10)
	_nLin += 50
	oReport:Say(_nLin ,oReport:PageWidth() * _nCol	, SubStr(Alltrim((_cAlias)->NOME),1,28),oFont10N)
	_nLin += 50
	oReport:Say(_nLin ,oReport:PageWidth() * _nCol	, Alltrim((_cAlias)->ENDERECO),oFont10)
	_nLin += 50
	oReport:Say(oReport:Row() + _nLin ,oReport:PageWidth() * _nCol	, Alltrim((_cAlias)->MUNICIPIO)+"  CEP: "+ Transform((_cAlias)->CEP,"@r 99999-999") ,oFont10)
	_nLin += 50

	_nCont++

	(_cAlias)->(DbSkip())
EndDo

oReport:EndPage()

Return