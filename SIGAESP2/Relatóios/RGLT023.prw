#INCLUDE "PROTHEUS.ch"
#INCLUDE "TOPCONN.ch"
#INCLUDE "RWMAKE.ch"
/*/
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������       '
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  � RGLT023  � Autor � TOTVS                 � Data da Criacao  � 27/01/2009                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Relatorio de Tickets.				    		                          						            ���
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
���            						ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Autor     � Data     � Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor        ���
���������������������������������������������������������������������������������������������������������������������������Ĺ��
���          �          �                    							   �                                  � 			���
���������������������������������������������������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
/*/
User Function RGLT023

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������
Local cDesc1  := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2  := "de acordo com os parametros informados pelo usuario."
Local cDesc3  := "Relatorio de Recepcao"
Local titulo  := "Relatorio de Tickets"
Local nLin    := 80
Local Cabec1  := "PRODUTOR                                    DT COLETA       VOLUME   LINHA"+Space(58)+"   HORA   TEMP. REGUA"
Local Cabec2  := ""
Local aOrd    := {}
Private lEnd        := .F.
Private lAbortPrint := .F.
Private CbTxt       := ""
Private limite      := 120
Private tamanho     := "G"
Private nomeprog    := "RGLT023" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo       := 18
Private aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey    := 0
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private wnrel       := "RGLT023" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cPerg       := "RGLT023   "
Private cString     := "ZLD"

Pergunte(cPerg,.F.)

dbSelectArea("ZLD")
dbSetOrder(1)

//���������������������������������������������������������������������Ŀ
//� Monta a interface padrao com o usuario...                           �
//�����������������������������������������������������������������������
wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
EndIf

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
EndIf

nTipo := If(aReturn[4]==1,15,18)

//���������������������������������������������������������������������Ŀ
//� Processamento. RPTSTATUS monta janela com a regua de processamento. �
//�����������������������������������������������������������������������
RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �RUNREPORT � Autor � TOTVS              � Data �  23/01/09   ���
�������������������������������������������������������������������������͹��
���Descricao � Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS ���
���          � monta a janela com a regua de processamento.               ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nQtdReg := 0
Local cUltTicket:=""
Static nSubVol:=0
Static nSubCol:=0
Static nTotVol:=0
Static nTotCol:=0

_cDtColeta := "% '" + DTOS(MV_PAR01) + "' AND '" + DTOS(MV_PAR02) + "' %"

BeginSql alias "TRB"
	SELECT ZLC_TICKET, ZLC_DTCOLE, ZLC_HORDES, ZLC_FRETIS,ZLC_LJFRET, ZLC_KM, ZLC_KMTERR, ZLC_MOTOR, ZLC_VEICUL, ZLC_QTDVEI, ZLC_ROTCAB,
	ZLD_RETIRO, ZLD_RETILJ, ZLD_QTDBOM, ZLD_LINROT, ZLD_ITEM, ZLD_HORA, ZLD_TEMP, ZLD_REGUA, ZLD_LINROT
	FROM %Table:ZLC% ZLC
		JOIN %Table:ZLD% ZLD ON ZLD_FILIAL = ZLC_FILIAL AND ZLD_TICKET = ZLC_TICKET AND ZLD.%NotDel%
	WHERE ZLC_FILIAL = %xFilial:ZLC%
	AND ZLC_SETOR = %Exp:MV_PAR03%
	AND ZLC_DTCOLE BETWEEN %Exp:_cDtColeta%
	AND ZLC_TICKET BETWEEN %Exp:MV_PAR06%  AND %Exp:MV_PAR07%
	AND ZLC_ROTCAB BETWEEN %Exp:MV_PAR08%  AND %Exp:MV_PAR09%
	AND ZLC.%NotDel%
	ORDER BY ZLC_FILIAL,ZLC_TICKET, ZLD_ITEM
EndSql

COUNT TO nQtdReg

SetRegua(nQtdReg)

TRB->(dbGoTop())
While TRB->(!Eof())

	Incregua()

	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	EndIf

	//���������������������������������������������������������������������Ŀ
	//� Impressao do cabecalho do relatorio. . .                            �
	//�����������������������������������������������������������������������
	If nLin > 55 // Salto de P�gina. Neste caso o formulario tem 55 linhas...
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 8
	EndIf

	If cUltTicket != TRB->ZLC_TICKET

		nLin := showSubTot(nLin)

		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 8

		@nLin,000 PSAY "Ticket:" + TRB->ZLC_TICKET + "   Data : " + DtoC(StoD(TRB->ZLC_DTCOLE)) + "  Hora Recep��o : " + TRB->ZLC_HORDES
		nLin += 1

		cUltTicket := TRB->ZLC_TICKET

		nLin++
		@nLin,000 PSAY TRB->ZLC_FRETIS+"-"+TRB->ZLC_LJFRET
		@nLin,015 PSAY LEFT(POSICIONE("SA2",1,xFILIAL("SA2")+TRB->ZLC_FRETIS+TRB->ZLC_LJFRET,"A2_NOME"),20)
		@nLin,040 PSAY "Km Rodado:"+TransForm(TRB->ZLC_KM,"@E 999,999,999")
		nLin++

		// Posiciona na tabela de ve�culos
		dbSelectArea("ZL4")
		ZL4->(dbSetOrder(1))
		ZL4->(dbSeek(xFilial("ZL4")+TRB->ZLC_MOTOR))

		// Posiciona na tabela de motoristas
		dbSelectArea("ZL0")
		ZL0->(dbSetOrder(1))
		ZL0->(dbSeek(xFilial("ZL0") + TRB->ZLC_VEICUL))

		@ nLin, 000 PSAY "Placa : " + ZL4->ZL4_PLACA
		@ nLin, 020 PSAY "Motorista : " + Alltrim(ZL0->ZL0_NOME)

		nLin += 2
		nTotVol+=TRB->ZLC_QTDVEI
		nSubVol:=TRB->ZLC_QTDVEI
	EndIf


	@nLin,000 PSAY TRB->ZLD_RETIRO+"-"+TRB->ZLD_RETILJ
	@nLin,015 PSAY LEFT(POSICIONE("SA2",1,xFILIAL("SA2")+TRB->ZLD_RETIRO+TRB->ZLD_RETILJ,"A2_NOME"),25)
	@nLin,045 PSAY DTOC(STOD(TRB->ZLC_DTCOLE))
	@nLin,055 PSAY TransForm(TRB->ZLD_QTDBOM,"@E 999,999,999")
	@nLin,070 PSAY TRB->ZLD_LINROT
	@nLin,078 PSAY POSICIONE("ZLW",1,xFILIAL("ZLW")+TRB->ZLD_LINROT,"ZLW_DESCRI")
	@nLin,135 PSAY TRB->ZLD_HORA PICTURE "@R 99:99"
	@nLin,142 PSAY TRB->ZLD_TEMP PICTURE "@E 99.9"
	@nLin,148 PSAY TRB->ZLD_REGUA PICTURE "@E 999.9"

	nLin++


	nSubCol+=TRB->ZLD_QTDBOM

    nTotCol+=TRB->ZLD_QTDBOM

	TRB->(dbSkip()) // Avanca o ponteiro do registro no arquivo
EndDo

//���������������������������������������������������������������������Ŀ
//� Impressao do cabecalho do relatorio. . .                            �
//�����������������������������������������������������������������������
If nLin > 50 // Salto de P�gina. Neste caso o formulario tem 55 linhas...
	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	nLin := 8
EndIf

TRB->(dbCloseArea())
nLin := showSubTot(nLin)

@nLin,000 PSAY "TOTAL GERAL DOS TICKETS"
nLin++
@nLin,000 PSAY "Total da Coleta  "
@nLin,020 PSAY TransForm(nTotCol,"@E 999,999,999")
@nLin,035 PSAY "Volume no Veiculo:"+TransForm(nTotVol,"@E 999,999,999")
@nLin,070 PSAY "Diferen�a de volume:"+TransForm(nTotCol-nTotVol,"@E 999,999,999")
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
EndIf

MS_FLUSH()

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �showSubTot� Autor � Microsiga          � Data �  00/00/00   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function showSubTot(nLin)

@nLin,000 PSay __PrtThinLine()
nLin++

@nLin,000 PSAY "Total da Coleta  "
@nLin,020 PSAY TransForm(nSubCol,"@E 999,999,999")
@nLin,035 PSAY "Volume no Veiculo:"+TransForm(nSubVol,"@E 999,999,999")
@nLin,070 PSAY "Diferen�a de volume:"+TransForm(nSubCol-nSubVol,"@E 999,999,999")

nSubVol:=0
nSubCol:=0

nLin += 1

@nLin,000 PSay __PrtThinLine()
nLin++

Return nLin