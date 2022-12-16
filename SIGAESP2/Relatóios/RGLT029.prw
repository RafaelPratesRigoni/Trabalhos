#INCLUDE "TopConn.ch"
//#INCLUDE "RwMake.ch"
#INCLUDE "PROTHEUS.CH"
/*/
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  � RGLT029  � Autor � TOTVS                 � Data da Criacao  � 23/06/2010                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Relatorio de Producao por Faixas.                                                                            ���
���          � 															                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Uso       �                                          															  		���
���          � 															                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Parametros� Nenhum						   							                               						���
���			 �														                                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Retorno   � Nenhum													                               						���
���			 �														                                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Usuario   �															                             						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Setor     � Gestao do Leite                                                                      						���
���������������������������������������������������������������������������������������������������������������������������͹��
���            						ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Autor     � Data     � Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor        ���
���������������������������������������������������������������������������������������������������������������������������Ĺ��
���          �          �                    							   �                                  � 			���
���������������������������������������������������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
/*/
User Function RGLT029()
	//���������������������������������������������������������������������Ŀ
	//� Declaracao de Variaveis                                             �
	//�����������������������������������������������������������������������
	Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
	Local cDesc2         := "de acordo com os parametros informados pelo usuario."
	Local cDesc3         := ""
	Local titulo       := "RELACAO DE PRODUCAO POR VOLUME"
	Local aOrd          := {}
	Private lEnd        := .F.
	Private lAbortPrint := .F.
	Private CbTxt       := ""
	Private limite      := 132
	Private tamanho     := "M"
	Private nomeprog    := "RGLT029" // Coloque aqui o nome do programa para impressao no cabecalho
	Private nTipo       := 18
	Private aReturn     := {"Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
	Private nLastKey    := 0
	Private cbcont      := 00
	Private CONTFL      := 01
	Private m_pag       := 01
	Private wnrel       := "RGLT029" // Coloque aqui o nome do arquivo usado para impressao em disco
	Private cPerg       := "RGLT029"
	Private cString     := "ZLA"
	Private Cabec1      := "" //"FAIXA                                       DIAS                VOLUME                 MEDIA"
	Private Cabec2      := "" //"CODIGO LOJA PRODUTOR                        COLETA              MENSAL                 (" + cValtoChar((mv_par04-mv_par03) +1) " DIAS)
	Private nLin        := 80

	dbSelectArea("ZLA")
	dbSetOrder(1)

	if !Pergunte(cPerg,.T.)
		return
	endif
	Cabec1       := "FAIXA                                                  DIAS                 VOLUME        MEDIA							PRE�O"
	Cabec2       := "CODIGO LOJA PRODUTOR                                   COLETA               MENSAL       (" + cValtoChar((mv_par04-mv_par03)+1) + " DIAS)

	titulo       := "RELACAO DE PRODUCAO POR VOLUME. DE " + dtoc(mv_par03) + " ATE " + dtoc(mv_par04) + " FAIXA: " + cValToChar(mv_par05) + " ATE " + cValToChar(mv_par06)

	//���������������������������������������������������������������������Ŀ
	//� Monta a interface padrao com o usuario...                           �
	//�����������������������������������������������������������������������

	wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

	If nLastKey == 27
		Return
	Endif

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Return
	Endif

	nTipo := If(aReturn[4]==1,15,18)

	//���������������������������������������������������������������������Ŀ
	//� Processamento. RPTSTATUS monta janela com a regua de processamento. �
	//�����������������������������������������������������������������������

	RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
return

//------------------------------------------------------------------//



/*/
	�����������������������������������������������������������������������������
	�����������������������������������������������������������������������������
	�������������������������������������������������������������������������ͻ��
	���Fun��o    �RUNREPORT � Autor � AP6 IDE            � Data �  09/04/09   ���
	�������������������������������������������������������������������������͹��
	���Descri��o � Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS ���
	���          � monta a janela com a regua de processamento.               ���
	�������������������������������������������������������������������������͹��
	���Uso       � Programa principal                                         ���
	�������������������������������������������������������������������������ͼ��
	�����������������������������������������������������������������������������
	�����������������������������������������������������������������������������
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

	Local aProds  := {}
	Local nQtd    := 0
	Local nTotVol := 0
	Local x       := 0

	// ---------------------------------------------------
	// Obtem array com Produtores e seu volume de leite
	// ordenado por volume de leite diario
	// 1-Volume Diario
	// 2-Codigo Produtor
	// 3-Loja
	// 4-Descricao
	// 5-Volume do Periodo
	// ---------------------------------------------------
	aProds := getPrds()

	cQuery1 := " SELECT * "
	cQuery1 += " FROM " + RetSqlName("ZLA") + " ZLA "
	cQuery1 += " WHERE D_E_L_E_T_ = ' ' "
	cQuery1 += " AND ZLA.ZLA_FILIAL = '" + XFILIAL("ZLA") + "' "
	cQuery1 += " AND ZLA.ZLA_COD    = '" + AllTrim(mv_par01) + "' "
	cQuery1 += " ORDER BY ZLA_COD "

	If Select("TRB") > 0
		dbSelectArea("TRB")
		("TRB")->(dbCloseArea())
	EndIf
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery1), "TRB", .T., .F. )

	COUNT TO nqtdregs
	setRegua(nqtdregs)

	TRB->(dbgotop())


	if nLin >= 65
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 9
	endif

	while TRB->(!eof())

		incregua()


		@nLin,000 PSAY "Do Volume "+ALLTRIM(str(TRB->ZLA_FXINI))+" ate "+ALLTRIM(str(TRB->ZLA_FXFIM))
		nLin++

		for x:=1 to len(aProds)

			if nLin >= 65
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			endif

			// Verifica se o volume diario do produtor enquadra na faixa corrente
			if aProds[x,1] >= TRB->ZLA_FXINI .AND. aProds[x,1] <= TRB->ZLA_FXFIM

				@nLin,000 PSAY transform(aProds[x,2]+"-"+aProds[x,3],"@!") // Codigo+Loja
				@nLin,012 PSAY transform(LEFT(aProds[x,4],30),"@!") // Descricao
				@nLin,050 PSAY transform(aProds[x,6],"@E 999,999,999") // Dias Coleta
				@nLin,070 PSAY transform(aProds[x,5],"@E 999,999,999") // volume total do periodo
				@nLin,085 PSAY transform(aProds[x,1],"@E 999,999,999") // Media
				@nLin,100 PSAY transform(aProds[x,7],"@E 999,999.99") // Pre�o

				nLin++
				nQtd++
				nTotVol += aProds[x,5]
			endif

		next x

		@nLin,000 PSAY ALLTRIM(str(nQtd)) + " Produtores    Total---->"
		@nLin,060 PSAY transform(nTotVol,"@E 999,999,999")
		nLin++

		nQtd:=0
		nTotVol:=0

		@nLin,000 PSAY __PrtThinLine()
		nLin++

		TRB->(dbskip())
	enddo

	TRB->(dbclosearea())


	//���������������������������������������������������������������������Ŀ
	//� Finaliza a execucao do relatorio...                                 �
	//�����������������������������������������������������������������������

	SET DEVICE TO SCREEN

	//���������������������������������������������������������������������Ŀ
	//� Se impressao em disco, chama o gerenciador de impressao...          �
	//�����������������������������������������������������������������������

	If aReturn[5]==1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif

	MS_FLUSH()

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RGLT029   �Autor  �Microsiga           � Data �  01/05/10   ���
�������������������������������������������������������������������������͹��
���Desc.     � Retorna Array com Produtores que movimentaram no periodo   ���
���          � Ordenado por Volume Diario.                                ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function getPrds()

	Local aDados := {}
	Local nDias := (mv_par04-mv_par03) + 1

	cQuery := " SELECT ZLD_FILIAL AS FILIAL,ZLD_RETIRO AS COD,ZLD_RETILJ AS LOJA, ZLD_DCRRET AS DESCRI, SUM(ZLD_QTDBOM) AS VOLUME,"
	cQuery += " SUM(ZLD_QTDBOM)/AVG(ZLD_QTDBOM) AS DIASCOLETA, ZLV_PRECO AS PRECO"
	cQuery += " FROM " + RetSqlName("ZLD") + " ZLD "
	cQuery += " LEFT JOIN PROTHEUS.ZLV010 ZLV ON (ZLV_FILIAL = ZLD_FILIAL AND ZLV_SA2COD = ZLD_RETIRO AND ZLV_SA2LJ = ZLD_RETILJ AND ZLV.D_E_L_E_T_ =' ')"
	cQuery += " WHERE ZLD.D_E_L_E_T_ = ' '"
	cQuery += " AND ZLD_FILIAL = '"+XFILIAL("ZLD")+"'  "
	cQuery += " AND ZLD_SETOR  = '"+mv_par02+"'  "
	cQuery += " AND ZLD_DTCOLE BETWEEN  '" + DTOS(mv_par03) + "' AND '" + DTOS(mv_par04) + "'"
	cQuery += " AND ZLV_DATA = '"+ DTOS(mv_par04) +"'"
	cQuery += " GROUP BY ZLD_FILIAL,ZLD_RETIRO,ZLD_RETILJ,ZLD_DCRRET, ZLV_PRECO"
	cQuery += " HAVING SUM(ZLD_QTDBOM) BETWEEN " + str(mv_par05) + " AND " + str(mv_par06)
	cQuery += " ORDER BY ZLD_RETIRO "

	If Select("TRX") > 0
		dbSelectArea("TRX")
		("TRX")->(dbCloseArea())
	EndIf
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRX", .T., .F. )

	while TRX->(!eof())
		Aadd(aDados,{(TRX->VOLUME/nDias),TRX->COD,TRX->LOJA,TRX->DESCRI,TRX->VOLUME,TRX->DIASCOLETA,TRX->PRECO})
		TRX->(dbskip())
	enddo
	TRX->(dbclosearea())

	aDados := ASORT(aDados,,, { |x, y| x[1] < y[1] })

return aDados