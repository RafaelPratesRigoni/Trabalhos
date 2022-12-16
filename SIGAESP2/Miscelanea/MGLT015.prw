#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
/*/
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  � MGLT015  � Autor � TOTVS                 � Data da Criacao  � 11/02/2009                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Rotina desenvolvida para possibilitar a Baixa de Titulos, gerando os cheques de forma automatizada.          ���
���          �                        									                               				        ���
���          � Gera um cheque para cada produtor, mesmo sendo varios titulos do mesmo produtor.                             ���
���������������������������������������������������������������������������������������������������������������������������͹��
���Uso       � Baixa e gera os cheques dos produtores automaticamente.                                                      ���
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
���          �          �                                                  �                                  �   	        ���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���          �          �                    							   �                                  � 			���
���----------�----------�--------------------------------------------------�----------------------------------�-------------���
���������������������������������������������������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
/*/
User Function MGLT015

	//��������������������������������������Ŀ
	//� Declaracao de Variaveis.             �
	//����������������������������������������
	Private cMarca    := GetMark()
	Private lInverte  := .F.
	Private lDeuErro  := .F.
	Private cPerg     := PADR("MGLT015",10)
	Private cCadastro := "Geracao de Cheque para Produtor"
	Private aCampos   := {}
	Private bImprCh   := {|| FINR480()}
	Private cBanco    := ""
	Private cAgencia  := ""
	Private cConta    := ""
	Private cSeqChq	  := ""
	Private oTempTable	:= Nil

	//��������������������������������������Ŀ
	//� Atribuicao de Valores no aRotina.    �
	//����������������������������������������
	Private aRotina:={{"Gera Cheque",'Eval({|| GeraChq(cMarca)})',0,2,0},;
	{"Imprime Chq",'Eval(bImprCh)',0,2,0} }

	//���������������������������������������������������������������������Ŀ
	//� Chama a tela para preenchimento dos parametros.                     �
	//�����������������������������������������������������������������������
	If !Pergunte(cPerg,.T.)
		Return()
	EndIf

	//���������������������������������������������������������������������Ŀ
	//� Atualiza os valores das variaveis.                                  �
	//�����������������������������������������������������������������������
	cBanco   := MV_PAR01
	cAgencia := MV_PAR02
	cConta   := MV_PAR03
	cSeqChq	 := ALLTRIM(MV_PAR12)
	//�������������������������������������������������������������������
	//� Cria o arquivo Temporario para insercao dos dados selecionados. �
	//�������������������������������������������������������������������
	MsgRun("Aguarde.... Criando arquivo temporario...",,{||CursorWait(), GLTCRIA(), CursorArrow()})

	//���������������������������������������������������������������������Ŀ
	//� Chama funcao para selecao dos dados.                                �
	//�����������������������������������������������������������������������
	MsgRun("Aguarde.... Selecionando dados...",,{||CursorWait(), GLTSEL(), CursorArrow()})

	//���������������������������������������������������������������������Ŀ
	//� Chama funcao para criar a MarkBrowse.                               �
	//�����������������������������������������������������������������������
	GLTMOST()

	oTempTable:Delete()

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � GLTMOST  � Autor � Microsiga          � Data �  00/00/00   ���
�������������������������������������������������������������������������͹��
���Descricao � Define os campos a serem apresentados na MarkBrowse.       ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Programa Principal.                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GLTMost()

	aadd(acampos ,{"TRB_OK"     ,"  "              ,"   "})
	aadd(acampos ,{"TRB_FORNEC" ,"@!!!!!!"         ,"Prod/Fret"})
	aadd(acampos ,{"TRB_LOJA"   ,"@!!!!"           ,"Loja"})
	aadd(acampos ,{"TRB_NOME"   ,"@!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!","Nome"})
	aadd(acampos ,{"TRB_PREFIX" ,"@!!!"            ,"Prefixo"})
	aadd(acampos ,{"TRB_NUM"    ,"@!!!!!!!!!"      ,"Numero"})
	aadd(acampos ,{"TRB_PARCEL" ,"@!!"             ,"Parcela"})
	aadd(acampos ,{"TRB_TIPO"   ,"@!!!"            ,"Tipo"})
	aadd(acampos ,{"TRB_VALOR"  ,"","Valor",PesqPict("SE2","E2_VALOR",14,2) })
	aadd(acampos ,{"TRB_SALDO"  ,"","Saldo",PesqPict("SE2","E2_SALDO",14,2) })
	aadd(acampos ,{"TRB_SETOR"  ,"@!!!!!!"         ,"Setor"})
	aadd(acampos ,{"TRB_LINHA"  ,"@!!!!!!"         ,"Linha"})
	aadd(acampos ,{"TRB_MIX"    ,"@!!!!!!"         ,"Mix"})


	dbSelectArea("TRB")
	TRB->(DbGotop())

	MarkBrow("TRB","TRB_OK",,aCampos,.F.,cMarca,,,,,)

	dbSelectArea("TRB")
	DbCloseArea()

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � GeraChq  � Autor � Microsiga          � Data �  00/00/00   ���
�������������������������������������������������������������������������͹��
���Descricao � Gera o cheque do produtor.                                 ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Programa Principal.                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GeraChq()

	Local cChqIni  := cSeqChq
	Local cChqFim  := cSeqChq
	Local cNome    := ""
	Local nCont    := 0
	Local aTitulos := {}
	Local aProdutor:= {}
	Local nProc1   := 0
	Local nProc2   := 0

	//Verifica se o usuario deixou em branco o parametro
	//com o numero do cheque
	If Empty(cSeqChq)
		MsgInfo("Informe o nro do primeiro cheque nos parametros.")
		Return()
	EndIf

	//Verifica se o numero do cheque informado ja existe
	dbSelectArea("SEF")
	dbSetOrder(1)//EF_FILIAL+EF_BANCO+EF_AGENCIA+EF_CONTA+EF_NUM
	If dbSeek(xFilial("SEF")+cBanco+cAgencia+cConta+cChqFim)
		MsgInfo("Numero de cheque ja existe, informe outro nos parametros.")
		Return()
	EndIf

	//Verifica se o Banco existe
	dbSelectArea("SA6")
	dbSetOrder(1)//A6_FILIAL+A6_COD+A6_AGENCIA+A6_NUMCON
	If !dbSeek(xFilial("SA6")+cBanco+cAgencia+cConta)
		MsgInfo("Banco+Agencia+Conta nao encontrados! Informe corretamente os parametros.")
		Return()
	EndIf


	If MsgYesNo("Deseja gerar CHEQUE para os produtores marcados? Sendo o Primeiro formulario No."+cSeqChq)

		DbSelectArea("TRB")
		TRB->(DbGoTop())
		cNome := ALLTRIM(TRB->TRB_NOME)

		While TRB->(!Eof())

			If IsMark( 'TRB_OK', cMarca )

				nAcho := Ascan(aProdutor,{|x| x[1] == TRB->(TRB_SETOR+TRB_LINHA+TRB_FORNEC+TRB_LOJA) })
				If nAcho == 0
					AAdd(aProdutor,{TRB->(TRB_SETOR+TRB_LINHA+TRB_FORNEC+TRB_LOJA),TRB->TRB_FORNEC,TRB->TRB_LOJA,ALLTRIM(TRB->TRB_NOME)})
				EndIf

				//Contador de controle do nro do cheque
				//Sem ele o primeiro cheque seria incrementado
				//e a sequencia de nro de cheque ficaria incorreta
				If nCont > 0
					cChqFim := SOMA1(cChqFim)
				EndIf

				//Numeracao automatica de cheque usa um asterisco na frente do nro
				AAdd(aTitulos,{TRB->(TRB_SETOR+TRB_LINHA+TRB_FORNEC+TRB_LOJA),TRB->TRB_SALDO,TRB->TRB_PREFIXO,TRB->TRB_NUM,TRB->TRB_PARCELA,TRB->TRB_TIPO,cChqFim,TRB->(Recno()),ALLTRIM(TRB->TRB_NOME)})
			EndIf

			nCont++
			TRB->(DbSkip())
		EndDo

		//����������������������������������������������������������Ŀ
		//� Gera o cheque para cada produtor marcado no arquivo TRB. �
		//������������������������������������������������������������
		For nProc1 := 1 To Len(aTitulos)

			//������������������������������������������������������������Ŀ
			//�Posiciona no cadastro do Fornecedor.                        �
			//��������������������������������������������������������������
			DbSelectArea("SA2")
			DbSetOrder(1)
			DbSeek(xFILIAL("SA2")+aProdutor[nProc1][2]+aProdutor[nProc1][3])

			//���������������������������������Ŀ
			//� Inicia o controle de transacao. �
			//�����������������������������������
			Begin Transaction

			//�������������������������������������������������������������������������������������������������Ŀ
			//� Processa todos os titulos, mas roda o SigaAuto, somente para o produtor posicionado no momento. �
			//���������������������������������������������������������������������������������������������������
			For nProc2 := 1 To Len(aTitulos)
				If aProdutor[nProc1][1] == aTitulos[nProc2][1]
					//������������������������������������������������������������Ŀ
					//�Executa o SigaAuto de Baixa de Titulo.                      �
					//��������������������������������������������������������������
					MsgRun("Gerando cheque para: "+aTitulos[nProc2][9],,{||CursorWait(),;
					BaixaSE2(aTitulos[nProc2][2],aTitulos[nProc2][3],aTitulos[nProc2][4],aTitulos[nProc2][5],aTitulos[nProc2][6],aTitulos[nProc2][7]), CursorArrow()})

					//��������������������������������������������������������������Ŀ
					//�Deleta o registro temporario do Titulo que foi selecionado.   �
					//����������������������������������������������������������������
					If !lDeuErro
						DbSelectArea("TRB")
						TRB->(DbGoTo(aTitulos[nProc2][8]))
						RecLock( 'TRB', .F. )
						DbDelete()
						MsUnLock()
					EndIf
				EndIf
			Next nProc2

			//���������������������������������������������������Ŀ
			//� Se houve alguma falha, desfaz todas as transacoes.�
			//�����������������������������������������������������
			If lDeuErro
				DisarmTransaction()
				lDeuErro := .F.
			EndIf

			//����������������������������������������������������������Ŀ
			//� Finaliza o controle de transacao, caso nao hajam falhas. �
			//������������������������������������������������������������
			End Transaction
		Next nProc1

		Pergunte("FIN480", .F.)
		SetMVValue("FIN480", "MV_PAR01", cBanco)
		SetMVValue("FIN480", "MV_PAR02", cAgencia)
		SetMVValue("FIN480", "MV_PAR03", cConta)
		SetMVValue("FIN480", "MV_PAR04", cChqIni)
		SetMVValue("FIN480", "MV_PAR05", cChqFim)
		SetMVValue("FIN480", "MV_PAR06", 2)
		SetMVValue("FIN480", "MV_PAR07", " ")
		SetMVValue("FIN480", "MV_PAR08", DTOC(dDataBase))
		SetMVValue("FIN480", "MV_PAR09", DTOC(dDataBase))
		SetMVValue("FIN480", "MV_PAR10", 2)
		SetMVValue("FIN480", "MV_PAR11", 1)
		SetMVValue("FIN480", "MV_PAR12", " ")
		SetMVValue("FIN480", "MV_PAR13", " ")
		SetMVValue("FIN480", "MV_PAR14", " ")

		//���������������������������������������������������������������������Ŀ
		//� Chama a tela para preenchimento dos parametros.                     �
		//�����������������������������������������������������������������������
		If !Pergunte("FIN480",.T.)
			Return()
		Else
			//����������������������������������������������������������Ŀ
			//� Chama o programa de impressao de cheques.                �
			//������������������������������������������������������������
			FINR480()
		EndIf

		//���������������������������������������������������������������������Ŀ
		//� Atualiza a sequencia de numeracao do cheque nos parametros.         �
		//�����������������������������������������������������������������������
		Pergunte(cPerg,.F.)
		MV_PAR12 := SOMA1(cChqFim)

	EndIf

Return()

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � GLTCRIA  � Autor � Microsiga          � Data �  00/00/00   ���
�������������������������������������������������������������������������͹��
���Descricao � Cria um arquivo Temporario com os campos a serem apresen-  ���
���          � tados na MarkBrowse.                                       ���
�������������������������������������������������������������������������͹��
���Uso       � Programa Principal.                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GLTCria()

	Local aEstru := {}

	aadd(aEstru,{"TRB_OK"      ,'C',02,0})
	aadd(aEstru,{"TRB_FORNEC"  ,'C',06,0})
	aadd(aEstru,{"TRB_LOJA"    ,'C',04,0})
	aadd(aEstru,{"TRB_NOME"    ,'C',40,0})
	aadd(aEstru,{"TRB_PREFIX"  ,'C',03,0})
	aadd(aEstru,{"TRB_NUM"     ,'C',09,0})
	aadd(aEstru,{"TRB_PARCEL"  ,'C',TamSx3("E2_PARCELA")[1],0})
	aadd(aEstru,{"TRB_TIPO"    ,'C',03,0})
	aadd(aEstru,{"TRB_VALOR"   ,'N',14,2})
	aadd(aEstru,{"TRB_SALDO"   ,'N',14,2})
	aadd(aEstru,{"TRB_LINHA"   ,'C',06,0})
	aadd(aEstru,{"TRB_SETOR"     ,'C',06,0})
	aadd(aEstru,{"TRB_MIX"     ,'C',06,0})

	If Select("TRB") <> 0
		TRB->(dbCloseArea())
	EndIf

	oTempTable := FwTemporaryTable():New("TRB", aEstru)
	oTempTable:AddIndex("IDX1", {"TRB_SETOR", "TRB_LINHA", "TRB_FORNEC", "TRB_LOJA"})
	oTempTable:Create()

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � GLTSEL   � Autor � Microsiga          � Data �  00/00/00   ���
�������������������������������������������������������������������������͹��
���Descricao � Seleciona os dados a serem apresentados na MarkBrowse.     ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Programa Principal.                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GLTSel()

	Local cQuery  := ""

	//�������������������������������������������������������������������
	//� Query para Selecao dos dados.                                   �
	//�������������������������������������������������������������������
	cQuery := "SELECT SE2.E2_FORNECE,SE2.E2_LOJA,SE2.E2_PREFIXO,SE2.E2_NUM,SE2.E2_PARCELA,SE2.E2_TIPO,SE2.E2_VALOR,SE2.E2_SALDO,SE2.E2_L_MIX, SA2.A2_L_LI_RO "
	cQuery += "FROM "+RetSqlName("SE2")+" SE2 "
	cQuery += " JOIN "+RetSqlName("SA2")+" SA2 ON SE2.E2_FORNECE = SA2.A2_COD AND SE2.E2_LOJA = SA2.A2_LOJA  "
	If MV_PAR11 == 1 //Banco
		cQuery += "AND SA2.A2_L_TPPAG = 'B'"
	ElseIf MV_PAR11 == 2 //Cheque
		cQuery += "AND SA2.A2_L_TPPAG = 'C'"
	ElseIf MV_PAR11 == 3 //Dinheiro
		cQuery += "AND SA2.A2_L_TPPAG = 'D'"
	EndIf
	cQuery += "		AND SA2.A2_L_LI_RO BETWEEN '"+MV_PAR09+"' AND '"+MV_PAR10+"' "
	cQuery += "WHERE SE2.D_E_L_E_T_ = ' ' "
	cQuery += " AND SA2.D_E_L_E_T_ = ' '" //#LETRAS
	cQuery += "AND SE2.E2_FILIAL  = '"+xFILIAL("SE2")+"' "
	cQuery += " AND SA2.A2_FILIAL = '" + xFilial("SA2")	+ "'" //#LETRAS
	cQuery += "AND (SE2.E2_L_MIX   = '"+MV_PAR04+"' OR SE2.E2_L_MIX   = '')"

	cQuery += "AND SE2.E2_FORNECE BETWEEN '"+mv_par05+"' AND '"+MV_PAR06+"' "
	cQuery += "AND SE2.E2_LOJA    BETWEEN '"+MV_PAR07+"' AND '"+MV_PAR08+"' "
	cQuery += "AND SE2.E2_PREFIXO = 'GL1' "  //Somente titulos a pagar para o Produtor
	cQuery += "AND SE2.E2_TIPO = 'NF ' "  //Somente titulos a pagar para o Produtor
	cQuery += "AND SE2.E2_SALDO > 0 "    //Somente titulos em aberto ou baixados parcialmente



	If Select("TRA") > 0
		dbSelectArea("TRA")
		TRA->(dbCloseArea())
	endif

	dbUseArea(.T.,"TOPCONN",TCGenQry(,,ALLTRIM(Upper(cQuery))),'TRA',.F.,.T.)

	DbSelectArea("TRA")
	TRA->(DbGoTop())

	While TRA->(!EOF())

		DbSelectArea("TRB")
		TRB->(DbGoTop())

		RecLock("TRB",.T.)
		TRB->TRB_FORNEC  := TRA->E2_FORNECE
		TRB->TRB_LOJA    := TRA->E2_LOJA
		TRB->TRB_NOME    := POSICIONE("SA2",1,xFILIAL("SA2")+TRA->E2_FORNECE+TRA->E2_LOJA,"A2_NOME")
		TRB->TRB_PREFIX  := TRA->E2_PREFIXO
		TRB->TRB_NUM     := TRA->E2_NUM
		TRB->TRB_PARCEL  := TRA->E2_PARCELA
		TRB->TRB_TIPO    := TRA->E2_TIPO
		TRB->TRB_VALOR   := TRA->E2_VALOR
		TRB->TRB_SALDO   := TRA->E2_SALDO
		TRB->TRB_LINHA   := TRA->A2_L_LI_RO
		TRB->TRB_MIX     := TRA->E2_L_MIX
		TRB->TRB_SETOR   := "000001"
		MsUnlock("TRB")

		TRA->(DbSkip())
	EndDo

	DbSelectArea("TRA")
	TRA->(DbCloseArea())

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    � BaixaSE2 � Autor �Microsiga              � Data � 00.00.00 ���
�������������������������������������������������������������������������Ĵ��
���Descricao � Baixa titulo no contas a pagar via SigaAuto.               ���
�������������������������������������������������������������������������Ĵ��
���Parametros� ExpN01 - Valor a ser baixado no titulo.                    ���
���          � ExpC02 - Prefixo do titulo a ser baixado.                  ���
���          � ExpC03 - Numero do titulo a ser baixado.                   ���
���          � ExpC04 - Parcela do titulo a ser baixado.                  ���
���          � ExpC05 - Tipo do titulo a ser baixado.                     ���
���          � ExpC06 - Numero do Cheque.                                 ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � GENERICO                                                   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function BaixaSE2(nVlrBx,cPrefixo,cNroTit,cParcela,cTipo,cNroChq)

	Local nModAnt := nModulo
	Local cModAnt := cModulo
	Local aAreaTRB:= TRB->(GetArea())
	Local aAreaSA2:= SA2->(GetArea())
	Local cHistSE2:= "Pagto Produtor em Cheque" //#LETRAS
	Local _cBefenf	:= ""
	Private lMsErroAuto:= .F.
	Private lMsHelpAuto:= .T.

	//������������������������������������������������������������Ŀ
	//� Tratamento para liberar o titulo para baixa no financeiro. �
	//��������������������������������������������������������������
	DbSelectArea("SE2")
	DbSetOrder(1)
	If DbSeek(xFILIAL("SE2")+cPrefixo+cNroTit+cParcela+cTipo+SA2->A2_COD+SA2->A2_LOJA)
		If Empty(SE2->E2_DATALIB)//Se nao foi liberado ainda
			RecLock("SE2",.F.)
			SE2->E2_DATALIB := dDataBase
			SE2->E2_USUALIB := Alltrim(cUserName)
			MsUnLock()
		EndIf

		If SA2->(FieldPos("A2_L_FAVCH"))<>0
			If !EMPTY(SA2->A2_L_FAVCH)
				_cBefenf := Alltrim(SA2->A2_L_FAVCH)
			Else
				_cBefenf := Alltrim(SA2->A2_NOME)
			EndIf
		Else
			_cBefenf := Alltrim(SA2->A2_NOME)
		EndIf

		aTitulo := {;
		{"E2_PREFIXO"  ,cPrefixo	,Nil},;
		{"E2_NUM"	   ,cNroTit	      ,Nil},;
		{"E2_PARCELA"  ,cParcela      ,Nil},;
		{"E2_TIPO"	   ,cTipo         ,Nil},;
		{"E2_FORNECE"  ,SA2->A2_COD   ,Nil},;
		{"E2_LOJA"	   ,SA2->A2_LOJA  ,Nil},;
		{"AUTBANCO"    ,cBanco        ,Nil},;
		{"AUTAGENCIA"  ,cAgencia      ,Nil},;
		{"AUTCONTA"    ,cConta        ,Nil},;
		{"AUTCHEQUE"   ,cNroChq       ,Nil},;
		{"AUTMOTBX"	   ,"CHQ"         ,Nil},;
		{"AUTDTBAIXA"  ,dDataBase	  ,Nil},;
		{"AUTDTCREDITO",dDataBase 	  ,Nil},;
		{"AUTBENEF"    ,_cBefenf		,Nil},;
		{"AUTHIST"	   ,cHistSE2      ,Nil},;
		{"AUTVLRPG"    ,nVlrBx        ,Nil }}

		//���������������������������������������������������������������Ŀ
		//� Altera o modulo para Financeiro, senao o SigaAuto nao executa.�
		//�����������������������������������������������������������������
		nModulo := 6
		cModulo := "FIN"

		//��������������������������������������Ŀ
		//� SigaAuto de Baixa de Contas a Pagar. �
		//����������������������������������������
		MSExecAuto({|x,y| Fina080(x,y)},aTitulo,3)

		//���������������������������Ŀ
		//� Restaura o modulo em uso. �
		//�����������������������������
		nModulo := nModAnt
		cModulo := cModAnt

		//��������������������������������������������������������������Ŀ
		//� Verifica se houve erro no SigaAuto, caso haja mostra o erro. �
		//����������������������������������������������������������������
		If lMsErroAuto
			lDeuErro := .T.
			xMagHelpFis("SIGAAUTO BAIXA TITULO",;
			"Existe uma n�o conformidade no SigaAuto de Baixa de Contas a Pagar!",;
			xFilial("SE2")+cPrefixo+cNroTit+;
			cParcela+cTipo+SA2->A2_COD+SA2->A2_LOJA+;
			"     <-  Copie essas informa��es para voce pesquisar no Contas a Pagar o titulo que esta com n�o conformidade. "+;
			"Ap�s confirmar esta tela, sera apresentada a tela de N�o Conformidade do SigaAuto.")
			MostraErro()
		EndIf

	EndIf

	RestArea(aAreaSA2)
	RestArea(aAreaTRB)

Return