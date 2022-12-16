#INCLUDE "TOTVS.CH"
/*/

�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  � RGLT009  � Autor � Guilherme Fran�a      � Data da Criacao  � 05/12/2018                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Recibo de conv�nios. Emitido na tela de lan�amento do conv�nio j� filtrando o fornecedor posicionado.     ���
���          �                   												                               				���
���������������������������������������������������������������������������������������������������������������������������͹��
���Uso       �                                                                   						                    ���
���������������������������������������������������������������������������������������������������������������������������͹��
���Parametros� Cliente, Data de Emissao, Forma de Ordenacao  			                               						���
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

User Function RGLT009()

Private _cPerg := "RGLT007"
Private _aArea := GetArea()
Private _cFornece := ZLK->ZLK_CONVEN //Codigo do fornecedor do convenio
Private _cCod	:= ZLK->ZLK_COD // Codigo
Private _cAssoci	:= ""

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
���Programa  �RGLT009   �Autor  �Microsiga           � Data �  08/05/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao que retorna o report montado com as configuraoes     ���
���          �do relatorio                                                ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ReportDef()

Private oReport


oReport := TReport():NEW("RGLT009" ,"Recibo de Conv�nios" ,_cPerg,{|oReport|PrintReport(oReport)} ,"")

oReport:nLineHeight	:= 50            // Define a altura da linha.
oReport:lParamPage		:= .F.
oReport:SetPortrait(.T.)
oReport:GetOrientation(1)
oReport:SetTotalInLine(.F.)


Return oReport

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RGLT009   �Autor  �Microsiga           � Data �  08/05/14   ���
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

Local _cFiltro := ""

Local _nTaxa := 0 // Taxa descontada do conveniado
Local _nTotConv := 0 //Total a receber do convenio
Local _nTotPagar := 0
Local _nTotOri := 0
Local _nTotFim := 0
Local _nTotTax := 0
Local _cTexto := ""
Private _cAlias := GetNextAlias()
Private _cCodConv := ""
Private oFont12 		:= TFont():New("COURIER NEW",12,12,,.F.,,,,.T.,.F.)
Private oFont12N		:= TFont():New("COURIER NEW",12,12,,.T.,,,,.T.,.F.)
Private oFont14N		:= TFont():New("COURIER NEW",14,14,,.T.,,,,.T.,.F.)
Private oFont16N		:= TFont():New("COURIER NEW",16,16,,.T.,,,,.T.,.F.)

_cFiltro := "% AND ZLL_COD = '"+_cCod+"' "
_cFiltro += " AND ZLL_CONVEN = '"+_cFornece+"' "
_cFiltro += " ORDER BY ZLL_COD, A1_NOME%"

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
		   A1_NOME AS NOME,
		   ZLL_VALOR AS VALOR,
		   ZLL_PARCEL AS PARCELA,
		   ZLL_VLRPAR AS VLRPAR,
		   ZLL_VLRTOT AS TOTAL
	FROM  %table:ZLL% ZLL
	JOIN  %table:SA1% A1 ON ZLL.ZLL_RETIRO = A1.A1_COD  AND ZLL.ZLL_RETILJ = A1.A1_LOJA AND A1.%NotDel%
	WHERE ZLL.%NotDel%
	%Exp:_cFiltro%

EndSql

If (_cAlias)->(Eof())
	Alert("N�o existem dados para este conveniado no periodo informado!")
	Return
EndIf

_cAssoci	:= (_cAlias)->RETIRO

While !(_cAlias)->(Eof()) .and. (_cAlias)->RETIRO == _cAssoci//((_cAlias)->FORNECE == _cFornece)
	PrintCabec(1)
	_cCodConv := (_cAlias)->CODIGO
	While!(_cAlias)->(Eof()) .and. (_cCodConv == (_cAlias)->CODIGO) .and. ((_cAlias)->RETIRO == _cAssoci)

		If oReport:Row() >= oReport:PageHeight() - 80
			oReport:EndPage()
			oReport:StartPage()
			PrintCabec(2)
		EndIf
		oReport:Say(oReport:Row(),oReport:PageWidth() * 0.01,(_cAlias)->SEQ	,oFont12)
		oReport:Say(oReport:Row(),oReport:PageWidth() * 0.04,(_cAlias)->RETIRO		,oFont12)
		oReport:Say(oReport:Row(),oReport:PageWidth() * 0.13,(_cAlias)->NOME		,oFont12)
		oReport:Say(oReport:Row(),oReport:PageWidth() * 0.44,Transform((_cAlias)->VALOR,"@E 9,999,999.99") ,oFont12)
		oReport:SkipLine(1)
		_nTotConv += (_cAlias)->VALOR
		_nTotPagar += (_cAlias)->TOTAL
		_nTaxa :=  (_cAlias)->TAXA

		(_cAlias)->(DbSkip())
	EndDo
	_cAssoci	:= (_cAlias)->RETIRO
	oReport:SkipLine(1)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.01,"Total Lan�amento: "+_cCodConv,oFont12)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.41,"R$"+Transform(_nTotConv,"@E 99,999,999.99") ,oFont12N)
	oReport:SkipLine(1)
	oReport:ThinLine()
	oReport:SkipLine(2)

	_nTotOri += _nTotConv
	_nTotFim += _nTotPagar
	_nTotTax += _nTaxa

	_nTotConv := 0
	_nTotPagar := 0
	_nTaxa := 0

	If oReport:Row() >= oReport:PageHeight() - 85
		oReport:EndPage()
		oReport:StartPage()
	EndIf

	_cTexto := "Levamos a seu conhecimento que fizemos o seguinte lancamento em seu Conta Corrente, nesta data."
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.01,_cTexto,oFont12N)
	oReport:SkipLine(3)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.24,"Assinatura: _________________________________________________" ,oFont12)
	oReport:SkipLine(2)
	oReport:ThinLine()

	_nTotOri := 0
	_nTotFim := 0
	_nTotTax := 0


	oReport:EndPage()

EndDo

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PrintCabec�Autor  �Microsiga           � Data �  08/05/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Imprime o cabe�alho do relatorio.                          ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function PrintCabec(_nOpc)

Local _cNomFor := Posicione("SA2",1,xFilial("SA2")+_cFornece+(_cAlias)->LJFORN,"A2_NOME")

If _nOpc == 1
	oReport:StartPage()
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.01	, "Conveniado: "	,oFont12)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.13	, _cFornece +" "+ _cNomFor	,oFont12N)
	oReport:SkipLine(1)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.01	, "C�digo Lcto:  "  		,oFont12)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.13	, (_cAlias)->CODIGO 		,oFont12N)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.25	, "Dt.Lan�amento: " ,oFont12)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.37	, DTOC(STOD((_cAlias)->EMISSAO))  ,oFont12N)
	oReport:SkipLine(1)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.01	, "Observa��o: "	,oFont12)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.13	, (_cAlias)->OBS	,oFont12N)


	oReport:SkipLine(1)
	oReport:ThinLine()
	oReport:SkipLine(1)
	PrintCabec(2)
EndIf

If _nOpc == 2
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.01,"Seq."			,oFont12N)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.04,"Matr�cula"		,oFont12N)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.13,"Associado"		,oFont12N)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.44,"Vlr.D�bito"	,oFont12N)
	oReport:SkipLine(1)
EndIf

If _nOpc == 3
	oReport:SkipLine(1)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.01,"Parcelas do Conveniado:"			,oFont12N)
	oReport:SkipLine(1)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.01,"Parcela"			,oFont12N)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.10,"Vencimento"		,oFont12N)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.32,"Valor"		,oFont12N)
	oReport:SkipLine(1)
EndIf


Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ParcelasForn�Autor  �Microsiga           � Data �  08/05/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Imprime o cabe�alho do relatorio.                          ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function ParcelasForn()


Local lCabec := .t.

If Select("PRC")<>0
	PRC->(DbClosearea())
EndIf

BeginSql alias "PRC"
	SELECT E2_PARCELA AS PARCELA, E2_VENCREA AS VENCTO, (E2_VALOR+E2_ACRESC-E2_DECRESC) AS VALOR
	FROM %Table:SE2% AS E2
	WHERE E2_FILIAL = %XFILIAL:SE2%
	AND E2_NUM = %Exp:_cCodConv+'000'%
	AND E2_FORNECE = %Exp:_cFornece%
	AND E2.%NotDel%
EndSql

DbSelectArea("PRC")

While !PRC->(Eof())

	If lCabec
		PrintCabec(3)
		lCabec := .f.
	EndIf

	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.01,PRC->PARCELA	,oFont12)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.10,DTOC(STOD(PRC->VENCTO)),oFont12)
	oReport:Say(oReport:Row(),oReport:PageWidth() * 0.28,Transform(PRC->VALOR,"@E 9,999,999.99"),oFont12)
	oReport:SkipLine(1)
	PRC->(DbSkip())
EndDo

Return