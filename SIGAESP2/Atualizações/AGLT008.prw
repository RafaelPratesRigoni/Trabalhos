#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "topconn.ch"
/*/
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  � AGLT008  � Autor � TOTVS                 � Data da Criacao  � 15/09/2008                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Trata Inclusao/alteracao/exclusao da tabela tabela do Mix.                            						���
���          � 															                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Uso       �                                                                   											���
���          � 	 							                                                                                ���
���������������������������������������������������������������������������������������������������������������������������͹��
���Parametros�                                                                                      						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Retorno   � Nenhum					                                                                                  	���
���������������������������������������������������������������������������������������������������������������������������͹��
���Usuario   �															                             						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Setor     � Financeiro	                                                                          						���
���������������������������������������������������������������������������������������������������������������������������͹��
���            						ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Autor     � Data     � Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor        ���
���������������������������������������������������������������������������������������������������������������������������Ĺ��
���          �          �                    							   �                                  � 			���
���������������������������������������������������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
*/
User Function AGLT008

Local aCores :={{"ZLE_STATUS == 'A' ", "BR_VERDE"},; //Mix pronto para Fechamento
				{"ZLE_STATUS == 'F' ", "BR_VERMELHO"},; //Mix ja encerrado
				{"ZLE_STATUS == 'P' ", "BR_AMARELO" }} //Mix em manutencao

Private cCadastro := "Mix do Leite"
Private aRotina :={{"Pesquisar","AxPesqui",0,1} ,;
                  {"Incluir"                  , "U_AGLT020(1)" , 0, 3} ,;
                  {"Visualizar"               , "U_AGLT020(10)", 0, 10},;
                  {"Manuten��o"               , "U_AGLT020(2)" , 0, 4},;
                  {"Abrir Mix"                , "U_AGLT008A()" , 0, 4},;
                  {"Liberar Coleta"           , "U_AGLT008G()" , 0, 4},;
                  {"Fechar Mix"               , "U_AGLT008F()" , 0, 4},;
                  {"Exclus�o"                 , "U_AGLT020(5)" , 0, 5},;
                  {"Legenda"                  , "u_legenX()"   , 0, 8}}

Private cDelFunc := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock
Private cString := "ZLE"

dbSelectArea("ZLE")
dbSetOrder(1)

dbSelectArea(cString)
mBrowse(6,1,22,75,"ZLE",,,,,,aCores)

Return

/*/
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������������������������������������ͻ��
���Programa  � LegenX   � Autor � Renato de Morcerf     � Data da Criacao  � 15/09/2008                						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Descricao � Legenda do Mix.                                                                      						���
���          � 															                               						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Uso       �                                                                   											���
���          � 	 							                                                                                ���
���������������������������������������������������������������������������������������������������������������������������͹��
���Parametros�                                                                                      						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Retorno   � Nenhum					                                                                                  	���
���������������������������������������������������������������������������������������������������������������������������͹��
���Usuario   �															                             						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Setor     � Financeiro	                                                                          						���
���������������������������������������������������������������������������������������������������������������������������͹��
���            						ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL                   						���
���������������������������������������������������������������������������������������������������������������������������͹��
���Autor     � Data     � Motivo da Alteracao  				               �Usuario(Filial+Matricula+Nome)    �Setor        ���
���������������������������������������������������������������������������������������������������������������������������Ĺ��
���          �          �                    							   �                                  � 			���
���������������������������������������������������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������������������������������������������
*/
User Function LegenX()

aCores_ :=  {{ 'ENABLE'     , "Mix Aberto       "  },;
{  'BR_AMARELO' , "Mix Pendente     "  },;
{  'DISABLE'    , "Mix Fechado      "  }}

BrwLegenda(cCadastro,"Legenda",aCores_)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � AGLT020F �Autor  �Microsiga           � Data �  01/06/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function AGLT008F()

If POSICIONE("ZLU",1,XFILIAL("ZLU")+PADR(cUserName,25),"ZLU_APRMIX") == "S"
	
	If MsgYesNo("Tem certeza que deseja Fechar esse Mix?")
		RecLock("ZLE",.f.)
		ZLE->ZLE_STATUS := 'F'
		MsUnlock()
	EndIf
	
Else
	xmaghelpfis("Falha",;
	"Usuario sem permissao para efetuar essa operacao!",;
	"Consulte o Administrador do Sistema.")
EndIf

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � AGLT020A �Autor  �Microsiga           � Data �  01/06/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function AGLT008A()

If POSICIONE("ZLU",1,XFILIAL("ZLU")+PADR(cUserName,25),"ZLU_APRMIX") == "S"
	
	If MsgYesNo("Tem certeza que deseja Reabrir esse Mix?")
		RecLock("ZLE",.f.)
		ZLE->ZLE_STATUS := 'P'
		MsUnlock()
	EndIf
	
Else
	xmaghelpfis("Falha",;
	"Usuario sem permissao para efetuar essa operacao!",;
	"Consulte o Administrador do Sistema.")
EndIf

Return

User Function AGLT008G()

If POSICIONE("ZLU",1,XFILIAL("ZLU")+PADR(cUserName,25),"ZLU_APRMIX") == "S"
	
	If MsgYesNo("Tem certeza que deseja Liberar Lan�amentos para  esse Mix?")
		RecLock("ZLE",.f.)
		ZLE->ZLE_STATUS := 'A'
		MsUnlock()
	EndIf
	
Else
	xmaghelpfis("Falha",;
	"Usuario sem permissao para efetuar essa operacao!",;
	"Consulte o Administrador do Sistema.")
EndIf

Return
