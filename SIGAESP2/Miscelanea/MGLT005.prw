#include "PROTHEUS.CH"
#include "RWMAKE.CH"
#include "TOPCONN.CH"

/*/
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  �MGLT005   � Autor � TOTVS                 � Data da Criacao  � 03/10/2008                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Essa rotina exporta os dados do Retiro e dos Tanques, para importacao no Sistema LQL.                        ���
���          � O sistema LQL emite as etiquetas para serem anexadas ao tubo de ensaio enviado para Analise da Qualidade.    ���
���������������������������������������������������������������������������������������������������������������������������͹��
���Uso       � Integracao Protheus X LQL.                						                                            ���
���������������������������������������������������������������������������������������������������������������������������͹��
���Parametros� Nenhum						   							                               						���
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
���          �          �                               				   �                                  �   	        ���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���          �          �                    							   �                                  � 			���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���������������������������������������������������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
/*/
User Function MGLT005

	//���������������������������������������������������������������������Ŀ
	//� Declaracao de Variaveis                                             �
	//�����������������������������������������������������������������������
	Local _nRet := 0
	Private oGeraCsv := Nil
	Private cString  := "SA2"
	Private cPerg    := "MGLT05P"

	//���������������������������������������������������������������������Ŀ
	//� Chama a tela para preenchimento dos parametros.                     �
	//�����������������������������������������������������������������������
	If !Pergunte(cPerg,.T.)
		Return()
	EndIf

	DbSelectArea(cString)
	DbSetOrder(1)

	_cTexto := " Este programa ira gerar um arquivo CSV, para ser importado no 		"
	_cTexto += " programa LQL, Cl�nica do Leite ou Laboratorio UFRS. O programa �    "
	_cTexto += " utilizado para impress�o das etiquetas, coladas nos tubos de ensaio "
	_cTexto += " enviados para analise com o Leite entregue pelos produtores, e tamb�m"
	_cTexto += " para que o retorno das analises venham padronizados.  "

	_nRet := AVISO("Exporta arquivo laborat�rio", _cTexto, {"Executar","Fechar" }, 2)
	If _nRet == 1
		Processa({|| OkGeraCsv() },"Aguarde processando...")
	EndIf

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    � OkGeraCsv� Autor � Microsiga          � Data �  00/00/00   ���
�������������������������������������������������������������������������͹��
���Descricao � Funcao chamada pelo botao OK na tela inicial de processamen���
���          � to. Executa a geracao do arquivo CSV.                      ���
�������������������������������������������������������������������������͹��
���Uso       � MGLT005()                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function OkGeraCsv

	//���������������������������������������������������������������������Ŀ
	//� Cria o arquivo texto                                                �
	//�����������������������������������������������������������������������
	Private cArqCsv := ALLTRIM(MV_PAR03)

	If Right(ALLTRIM(cArqCsv),1) <> "\"
		cArqCsv := cArqCsv + "\"
	EndIf
	cArqCsv := cArqCsv+"exp_cad_laboratorio_"+dtos(dDataBase)+".csv"

	Private nHdl    := fCreate(cArqCsv)
	Private cEOL    := "CHR(13)+CHR(10)"

	If Empty(cEOL)
		cEOL := CHR(13)+CHR(10)
	Else
		cEOL := Trim(cEOL)
		cEOL := &cEOL
	Endif

	If nHdl == -1
		xmaghelpfis("Mensagem","O arquivo de nome "+cArqCsv+" nao pode ser executado!","Verifique os parametros, ou se o arquivo existe")
		Return
	Endif

	//���������������������������������������������������������������������Ŀ
	//� Inicializa a regua de processamento                                 �
	//�����������������������������������������������������������������������
	Processa( {|lEnd| RunCont(@lEnd)}, "Aguarde...","Exportando cadastros..", .T. )

	fClose(cArqCsv)

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    � RunCont  � Autor � Microsiga          � Data �  00/00/00   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  ���
���          � monta a janela com a regua de processamento.               ���
�������������������������������������������������������������������������͹��
���Uso       � OkGeraCsv()                                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function RunCont(lEnd)
	Local cLin := "M�s;Nome;Cidade;Cep;CPF/CNPJ;Matr�cula;Litragem;NRP;NIRF;Rota;Endere�o;Latitude;Longitude;" + cEOL

	//��������������������������������������������Ŀ
	//� Chama funcao para criar tabela Temporaria. �
	//����������������������������������������������
	MsgRun("Aguarde.... Filtrando dados...",,{||CursorWait(), OkFilArq(), CursorArrow()})

	//�����������������������������������������Ŀ
	//� Gravacao do cabecalho no arquivo texto. �
	//�������������������������������������������
	If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
		If !MsgYesNo("Ocorreu um erro na gravacao do arquivo. Continua?","Atencao!")
			Return
		Endif
	Endif

	dbSelectArea("TMP1")
	ProcRegua(RecCount()) // Numero de registros a processar

	While TMP1->(!EOF())

		DbSelectArea(cString)
		DbSetOrder(1)
		DbSeek(xFILIAL("SA2")+TMP1->CODIGO+TMP1->LOJA)

		//�����������������������������Ŀ
		//� Somente exporta produtores. �
		//�������������������������������
		If !SA2->A2_L_TPFOR $ "P/G/T" //_cPLEITE //#LETRAS
			TMP1->(DbSkip())
			Loop
		EndIf

		//������������������������������������Ŀ
		//� Nao exporta produtores Bloqueados. �
		//��������������������������������������
		If SA2->A2_MSBLQL == "1"
			TMP1->(DbSkip())
			Loop
		EndIf

		//���������������������������������������������������������������������Ŀ
		//� Incrementa a regua                                                  �
		//�����������������������������������������������������������������������
		IncProc("Processando Produtor: "+ALLTRIM(SA2->A2_NOME))
		If lEnd
			MsgInfo("Processo cancelado pelo operador.")
			Exit
		Endif

		//��������������������������������������������������Ŀ
		//� Preenche a string com os dados a serem gravados. �
		//����������������������������������������������������

		cLin := SubStr( DTOc(MV_PAR01),4,7)+";"
		cLin += ALLTRIM(SA2->A2_NOME)+";"
		cLin += ALLTRIM(SA2->A2_MUN)+";"
		cLin += ALLTRIM(SA2->A2_CEP)+";"
		cLin += ALLTRIM(SA2->A2_CGC)+";"
		cLin += ALLTRIM(SA2->A2_COD+SA2->A2_LOJA)+";"
		cLin += ALLTRIM(Transform(TMP1->QTD,"@E 999,999"))+";"
		cLin += ALLTRIM(SA2->A2_L_SIGSI)+";"
		cLin += ALLTRIM(SA2->A2_L_NIRF)+";"
		cLin += Alltrim(BuscaZLZ(SA2->A2_COD,SA2->A2_LOJA))+";" //ALLTRIM(SA2->A2_L_LI_RO)+";"
		cLin += ALLTRIM(SA2->A2_END)+" BAIRRO: "+ALLTRIM(SA2->A2_BAIRRO)+" UF:"+ALLTRIM(SA2->A2_EST)+";"

		If SA2->(FieldPos("A2_L_LATIT")) <> 0
			cLin += ALLTRIM(SA2->A2_L_LATIT)+";"
			cLin += ALLTRIM(SA2->A2_L_LONGI)+";" + cEOL
		Else
			cLin += "0;0;" + cEOL
		EndIf

		//+cEOL
		//��������������������������������������������������������������Ŀ
		//� Gravacao do Item no arquivo texto. Testa por erros durante a �
		//� gravacao da linha montada.                                   �
		//����������������������������������������������������������������
		If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
			If !MsgYesNo("Ocorreu um erro na gravacao do arquivo. Continua?","Atencao!")
				Exit
			Endif
		Endif
		TMP1->(DbSkip())
	EndDo
	TMP1->(dbclosearea())

	//���������������������������������������������������������������������Ŀ
	//� O arquivo texto deve ser fechado, bem como o dialogo criado na fun- �
	//� cao anterior.                                                       �
	//�����������������������������������������������������������������������
	TMP1->(dbCloseArea())
	fClose(nHdl)

	MsgInfo("Exporta��o finalizada!")

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �BuscaZLZ�Autor  �Microsiga           � Data �  02/20/15   ���
�������������������������������������������������������������������������͹��
���Desc.     � Preenche rota, versao e descricao                          ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function BuscaZLZ(_xcCod,_xcLoja)

	Local _cAlias	:= GetNextAlias()
	Local _cRet := "1"

	If Select(_cAlias)>0
		(_cAlias)->(DbCloseArea())
	EndIf

	BeginSql alias _cAlias

		SELECT MAX(LZ.ZLZ_ROTA) ROTA, ZLW_DESCRI DESCRI
		FROM %TABLE:ZLZ% LZ
		JOIN %TABLE:ZLW% LW ON LW.ZLW_COD = ZLZ_ROTA //AND LW.ZLW_VERSAO = ZLZ_VERSAO
				AND LW.ZLW_MSBLQL <> '1' AND LW.%NotDel%
		WHERE LZ.ZLZ_CODPRO = %EXP:_xcCod% AND ZLZ_LJPROD = %EXP:_xcLoja% AND LZ.%NotDel%
		GROUP BY ZLW_DESCRI
	EndSql

	If !(_cAlias)->(Eof())
		_cRet := (_cAlias)->ROTA
	EndIf
Return _cRet


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    � OkFilArq � Autor � Microsiga          � Data �  00/00/00   ���
�������������������������������������������������������������������������͹��
���Descricao � Funcao chamada filtrar os dados a serem exportados para o  ���
���          � arquivo CSV.                                               ���
�������������������������������������������������������������������������͹��
���Uso       � MGLT005()                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function OkFilArq()

	Local cQry := ""

	cQry := "SELECT ZLD_RETIRO CODIGO,ZLD_RETILJ LOJA, SUM(ZLD_QTDBOM) AS QTD FROM "+RetSqlName("ZLD")
	cQry += " WHERE D_E_L_E_T_ = ' '"
	cQry += " AND ZLD_DTCOLE BETWEEN '" + DTOS(MV_PAR01) + "' AND '" + DTOS(MV_PAR02) + "'"
	cQry += " AND ZLD_SETOR = '" + mv_par04 + "' "
	cQry += " AND ZLD_LINROT BETWEEN '" + mv_par05 + "' AND '"+ mv_par06 +"' "
	cQry += " GROUP BY ZLD_RETIRO,ZLD_RETILJ"

	If mv_par07 == 1
		cQry += " UNION ALL "
		cQry += " SELECT A2_COD CODIGO, A2_LOJA LOJA, 0 AS QTD FROM "+RetSqlName("SA2")+" A2 "
		cQry += " JOIN "+RetSqlName("ZM3")+" M3 ON ZM3_CODIGO = A2.A2_L_CODAS AND ZM3_QUALID = 'S' AND M3.D_E_L_E_T_ = ' ' "
		cQry += " WHERE A2.D_E_L_E_T_ = ' ' "
	EndIf

	TCQUERY cQry NEW ALIAS "TMP1"

	dbSelectArea("TMP1")

Return