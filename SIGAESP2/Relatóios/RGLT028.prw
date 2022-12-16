#INCLUDE "Protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE "RwMake.ch"
/*/
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  � RGLT028  � Autor � TOTVS                 � Data da Criacao  � 27/01/2009                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Relacao de convenios.                                                                                        ���
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
User Function RGLT028

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������
Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := ""
Local titulo       := "RELACAO DE CONVENIOS"
Local nLin         := 80
Local Cabec1       := "COD       FORNECEDOR                                        EMISSAO            VENCTO"
Local Cabec2       := "PRODUTOR/TRANSPORTADOR                            VLR.ORIG.  QTD.PARC.  VLR.PARCELA    VLR.TOTAL  1� VENCTO.   STATUS"
Local aOrd := {}
Static nTotal :=0
Static nGeral :=0
Static nTotalori :=0
Static nGeralori :=0
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite           := 132
Private tamanho          := "M"
Private nomeprog         := "RGLT028" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo            := 18
Private aReturn          := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey        := 0
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "RGLT028" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cPerg := "RGLT028   "

Private cString := "ZLL"

dbSelectArea("ZLL")
dbSetOrder(1)

if !Pergunte(cPerg)
	return
endif

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
Return

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

Local cUltCod := ""

cQuery1 := " SELECT * "
cQuery1 += " FROM " + RetSqlName("ZLL") + " ZLL "
cQuery1 += " WHERE D_E_L_E_T_ = ' ' "
cQuery1 += " AND ZLL.ZLL_FILIAL = '" + XFILIAL("ZLL") + "' "
cQuery1 += " AND ZLL.ZLL_SETOR = '" + AllTrim(MV_PAR01) + "' "
cQuery1 += " AND ZLL.ZLL_CONVEN BETWEEN '" + MV_PAR02 + "' AND '"+ MV_PAR04 +"' "
cQuery1 += " AND ZLL.ZLL_RETIRO BETWEEN '" + MV_PAR06 + "' AND '"+MV_PAR08+"' "
cQuery1 += " AND ZLL.ZLL_RETILJ BETWEEN '" + MV_PAR07 + "' AND '"+MV_PAR09+"' "
cQuery1 += " AND ZLL.ZLL_EVENTO BETWEEN '" + MV_PAR12 + "' AND '"+MV_PAR13+"' "
cQuery1 += " AND ZLL.ZLL_DATA   BETWEEN '" + dtos(MV_PAR10) + "' AND '"+dtos(MV_PAR11)+"' "
cQuery1 += " ORDER BY ZLL_COD,ZLL_DATA,ZLL_CONVEN "

If Select("TRB") > 0
	dbSelectArea("TRB")
	("TRB")->(dbCloseArea())
EndIf
dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery1), "TRB", .T., .F. )

COUNT TO nqtdregs
setRegua(nqtdregs)

TRB->(dbgotop())

while TRB->(!eof())

	incregua()

	if nLin >= 55
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 9
	endif

	if cUltCod != TRB->ZLL_COD

		if cUltCod != ""
			nLin++
			nLin:=showTotal(nLin)
		endif

		@nLin,000 psay TRB->ZLL_COD
		@nLin,010 psay TRB->ZLL_CONVEN+"-"+TRB->ZLL_LJCONV
		@nLin,022 psay left(POSICIONE("SA2",1,XFILIAL("SA2")+TRB->ZLL_CONVEN+TRB->ZLL_LJCONV,"A2_NOME"),35)
		@nLin,060 psay "Emissao:"+DTOC(STOD(TRB->ZLL_DATA))
		@nLin,080 psay "Vencto:"+DTOC(STOD(TRB->ZLL_VENCON))
		nLin++
		@nLin,000 psay TRB->ZLL_EVENTO + " - " + POSICIONE("ZL8",1,XFILIAL("ZL8")+TRB->ZLL_EVENTO,"ZL8_DESCRI")
		nLin+=2

	endif
	cUltCod:=TRB->ZLL_COD
//          [   10   ][   20   ][   30   ][   40   ][   50   ][   60   ][   70   ][   80   ][   90   ][   10   ][   11   ][
//[1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//"PRODUTOR/TRANSPORTADOR                            VLR.ORIG.  QTD.PARC.  VLR.PARCELA    VLR.TOTAL  1� VENCTO.   STATUS"

	@nLin,000 psay TRB->ZLL_RETIRO+"-"+TRB->ZLL_RETILJ
	@nLin,012 psay LEFT(TRB->ZLL_DCRRET,25)
	@nLin,047 psay transform(TRB->ZLL_VALOR,"@E 9,999,999.99")
	@nLin,064 psay transform(TRB->ZLL_PARCEL,"@E 999")
	@nLin,072 psay transform(TRB->ZLL_VLRPAR,"@E 9,999,999.99")
	@nLin,085 psay transform(TRB->ZLL_VLRTOT,"@E 9,999,999.99")
	@nLin,100 psay DTOC(STOD(TRB->ZLL_VENCTO))
	@nLin,115 psay TRB->ZLL_STATUS
	nLin++

	nTotalori+=TRB->ZLL_VALOR
	nGeralori+=TRB->ZLL_VALOR

	nTotal+=TRB->ZLL_VLRTOT
	nGeral+=TRB->ZLL_VLRTOT


	TRB->(dbskip())
enddo

nLin:=showTotal(nLin)

nLin++
@nLin,000 PSAY "Total Geral --->"
@nLin,047 PSAY transform(nGeralori,"@E 999,999,999.99")
@nLin,085 PSAY transform(nGeral,"@E 999,999,999.99")
nGeralori := 0
nGeral := 0


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
���Programa  �RGLT028   �Autor  �Microsiga           � Data �  01/05/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function showTotal(nLin)

@nLin,000 PSAY "Total---------->"
@nLin,047 PSAY transform(nTotalori,"@E 999,999,999.99")
@nLin,085 PSAY transform(nTotal,"@E 999,999,999.99")

nLin++

nTotal := 0
nTotalori := 0

@ nLin,000 PSay __PrtThinLine()
nLin++

return nLin