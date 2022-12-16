#INCLUDE "RWMAKE.ch"
#INCLUDE "TOPCONN.ch"
/*/
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  � MGLT021  � Autor � TOTVS                 � Data da Criacao  � 03/03/2009                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Cria arquivo com dados do mapa de recebimento de leite.                                                      ���
���          �                        									                               				        ���
���������������������������������������������������������������������������������������������������������������������������͹��
���Uso       � Enviar para A.F.                                                                                             ���
���������������������������������������������������������������������������������������������������������������������������͹��
���Parametros�                                                                                      						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Retorno   � Nenhum						  							                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Usuario   � Microsiga                                                                                					���
���������������������������������������������������������������������������������������������������������������������������͹��
���Setor     � Gestao do Leite.                                                                        						���
���������������������������������������������������������������������������������������������������������������������������͹��
���            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Autor     � Data     � Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor        ���
���������������������������������������������������������������������������������������������������������������������������ĺ��
���          �          �                                                  �                                  �   	        ���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���          �          �                    							   �                                  � 			���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���������������������������������������������������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
/*/
User Function MGLT021()

	Private cPerg := "MGLT021"
	Private oGera

	If !Pergunte(cPerg,.T.)
		Return
	EndIf

	//���������������������������������������������������������������������Ŀ
	//� Montagem da tela de processamento.                                  �
	//�����������������������������������������������������������������������
	@ 200,1 TO 380,380 DIALOG oGera TITLE OemToAnsi("Exportacao Mapa Recebimento")
	@ 02,10 TO 080,190
	@ 10,018 Say " Este programa fara a leitura das tabelas SF1,SD1 e SA2 para   "
	@ 18,018 Say " gerar os dados necessarios no arquivo de Exportacao do Mapa de"
	@ 26,018 Say " Recebimento de coleta do leite. Este arquivo deve ser entregue"
	@ 34,018 Say " na Administracao Fazendaria.                                  "

	@ 70,098 BMPBUTTON TYPE 05 ACTION Pergunte(cPerg,.T.)
	@ 70,128 BMPBUTTON TYPE 01 ACTION OkGera()
	@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oGera)

	Activate Dialog oGera Centered

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    � OkGera   � Autor � TOTVS              � Data �  00/00/00   ���
�������������������������������������������������������������������������͹��
���Descricao � Funcao chamada pelo botao OK na tela inicial de processamen���
���          � to. Executa a geracao do arquivo texto.                    ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function OkGera

	//���������������������������������������������������������������������Ŀ
	//� Inicializa a regua de processamento                                 �
	//�����������������������������������������������������������������������
	Processa( {|lEnd| Geratxt(@lEnd)},"Aguarde","Gerando arquivo texto.",.T.)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Geratxt   �Autor  �Microsiga           � Data �  03/04/10   ���
�������������������������������������������������������������������������͹��
���Desc.     � Funcao responsavel por gerar arquivo txt com informacoes da���
���          � notas fiscais emitidas para produtores                     ���
�������������������������������������������������������������������������͹��
���Uso       � Envio de arquivo para AF.                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function Geratxt(lEnd)

	Local cArq      := " "
	Local cTitulo   := "RELACAO DAS NOTAS FISCAIS EMITIDAS DE " + MV_PAR05 + "/" + MV_PAR07 + " ATE " + MV_PAR06 + "/" + MV_PAR08
	Private cEOL    := "CHR(13)+CHR(10)"

	cEOL := &cEOL
	cCep :=  " "

	//Verifica parametros para criar filtros
	cFiltro := "%"

	//Filtra Cod. Produtor
	If !Empty(MV_PAR01) .And. !Empty(MV_PAR03)
		cFiltro += " AND SF1.F1_FORNECE BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR03 + "' "
	EndIf

	//Filtra Lj Produtor
	If !Empty(MV_PAR02) .And. !Empty(MV_PAR04)
		cFiltro += " AND SF1.F1_LOJA BETWEEN '" + MV_PAR02 + "' AND '" + MV_PAR04 + "' "
	EndIf

	//Filtra Mes
	If !Empty(MV_PAR05) .And. !Empty(MV_PAR06)
		cFiltro += " AND SUBSTR(F1_EMISSAO,5,2) BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' "
	EndIf

	//Filtra Ano
	If !Empty(MV_PAR07) .And. !Empty(MV_PAR08)
		cFiltro += " AND SUBSTR(F1_EMISSAO,1,4) BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "' "
	EndIf

	//Filtra Filial
	If !Empty(MV_PAR09)
		cFiltro += " AND SF1.F1_FILIAL = '" + MV_PAR09 + "' "
	EndIf

	cFiltro += "%"
	cAlias  := "TRBNF"

	//Busca Notas Fiscais
	BeginSql alias cAlias
		SELECT
		SF1.F1_FORNECE,SF1.F1_LOJA,SA2.A2_NOME,SF1.F1_DOC,SF1.F1_SERIE,SF1.F1_EMISSAO,SA2.A2_CGC,SA2.A2_INSCR,SF1.F1_FILIAL,
		SUM(SD1.D1_TOTAL) AS D1_TOTAL,SF1.F1_VALICM,SA2.A2_CEP
		FROM
		%table:SF1% SF1
		JOIN %table:SA2% SA2 ON SF1.F1_FORNECE = SA2.A2_COD AND SF1.F1_LOJA = SA2.A2_LOJA
		JOIN %table:SD1% SD1 ON SD1.D1_DOC = SF1.F1_DOC AND SD1.D1_SERIE = SF1.F1_SERIE AND SD1.D1_FILIAL = SF1.F1_FILIAL
		WHERE
		SF1.%notDel%
		AND SA2.%notDel%
		AND SA2.A2_L_TPFOR IN ('P','G')  //#LETRAS
		%Exp:cFiltro%
		GROUP BY
		SF1.F1_FORNECE,SF1.F1_LOJA,SA2.A2_NOME,SF1.F1_DOC,SF1.F1_SERIE,SF1.F1_EMISSAO,SA2.A2_CGC,SA2.A2_INSCR,
		SF1.F1_FILIAL,SF1.F1_VALICM,SA2.A2_CEP
		ORDER BY
		SA2.A2_CEP
	EndSql

	dbSelectArea("TRBNF")
	nReg := 0
	Count To nReg
	ProcRegua(nReg)
	dbGoTop()

	//Grava Arquivo Txt
	nHandle := 0
	While TRBNF->(!Eof())
		//Verifica para saber se o cep � diferente e cria outro arquivo caso o mesmo for
		If cCep != TRBNF->A2_CEP
			fClose(nHandle) //Fecha arquivo atual

			cArq := ALLTRIM(MV_PAR10) + TRBNF->A2_CEP + "_"+  MV_PAR05 + MV_PAR06 + "-" + MV_PAR07 + MV_PAR08 + MV_PAR09 + ".TXT"
			nHandle := FCREATE(cArq, 1)
			cLinha := cTitulo + cEOL
			fWrite(nHandle, cLinha)
			cCabec1 := "Inscricao          Nome do Produtor                         Period. N Fis. Data              Valor          ICMS       Quantid.  %Red. ICMS Dev."
			cCabec2 := "-----------        ---------------------------------        ------- ------ ----------   ----------    ----------     ---------- ------ ---------"

			cLinha := cCabec1 + cEOL
			fWrite(nHandle, cLinha)
			cLinha := cCabec2 + cEOL
			fWrite(nHandle, cLinha)
			cCep := TRBNF->A2_CEP
		EndIf

		IncProc()
		//inscricao
		cLinha := TRBNF->A2_INSCR
		//Nome fornecedor
		cLinha += TRBNF->A2_NOME
		//Periodo
		cLinha += SubStr(TRBNF->F1_EMISSAO,5,2) + "/" + SubStr(TRBNF->F1_EMISSAO,1,4) + " "
		//Nf Entrada
		cLinha += ALLTRIM(TRBNF->F1_DOC) + " "
		//Emissao
		cLinha += ALLTRIM(TRBNF->F1_EMISSAO) + " "
		//Valor
		cLinha += TransForm(TRBNF->D1_TOTAL,"@E 999,999,999.99")
		//ICMS
		cLinha += TransForm(TRBNF->F1_VALICM,"@E 999,999,999.99")
		//Quantidade
		nQuant := Posicione("SD1",1,TRBNF->F1_FILIAL+TRBNF->F1_DOC+TRBNF->F1_SERIE+TRBNF->F1_FORNECE+TRBNF->F1_LOJA+ALLTRIM(MGLT21A("LT_ENTPRO", TRBNF->F1_FILIAL)),"D1_QUANT")
		cLinha += TransForm(nQuant,"@E 999,999,999.99")

		//quebra linha
		cLinha += cEOL

		//grava
		fWrite(nHandle, cLinha)

		TRBNF->(dbSkip())
	EndDo

	//Fecha Arquivo
	fClose(nHandle)
	Close(oGera)
Return

/*/{Protheus.doc} MGLT21A
	Recupera conte�do do par�metro da filial informados
	@type  Static Function
	@author Ronilson Rodrigues
	@since 16/09/2022
	@version 12.1.27
	@param cParam, Character, Nome do par�metro
	@param cFilInf, Character, Filail informada
	@return cContent, Character, Conte�do do par�metro informado
/*/
Static Function MGLT21A(cParam, cFilInf)

	Local cContent	:= ""

	cContent := SuperGetMV(cParam, .F., "", cFilInf)

Return cContent