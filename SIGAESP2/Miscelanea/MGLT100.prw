
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "AP5MAIL.CH"
#INCLUDE "TBICONN.CH"

/*
=================================================================================
- Exporta��o de Cadastros para o sistema Digicerto 
- Produtores / Transportadores / Rotas e Veiculos
- Quatrelati - Gest�o do Leite
- Totvs Triangulo Mineiro - Jos� Rog�rio do Prado Jr. / Guilherme Fran�a
- 15/03/2018
=================================================================================
*/

User Function MGLT100()

Private cQuery  := ""
Private cSalvar := ""
Private cTexto  := ""
Private nHandle
Private aArea := GetArea()

cAviso := "ATEN��O!!"+chr(13)+chr(10)+chr(13)+chr(10)
cAviso += "Este programa ir� EXPORTAR registros de um arquivo TXT para DIGICERTO "
cAviso += " Confirma a execu��o da rotina?"+chr(13)+chr(10)

If Aviso("DIGICERTO",cAviso,{"Sim","N�o"},2) == 2
	MsgAlert("Execu��o Abortada pelo Usu�rio!!! ")
	Return()
Endif

Processa( {|lEnd| GeraArq(@lEnd)}, "Aguarde...","Gerando arquivo de exporta��o", .T. )

Return

Static Function GeraArq()

cSalvar := Alltrim(cGetFile("*.*","Salvar",1,"c:\",.F.,GETF_LOCALHARD + GETF_NETWORKDRIVE + GETF_RETDIRECTORY))
cSalvar := UPPER(cSalvar+"DIGICERTO.TXT")
nHandle := fCreate(cSalvar)

If nHandle == -1
    MsgAlert("O arquivo CSV nao pode ser executado!","Erro!")
	Return()
Else
/*
A primeira linha do arquivo deve conter a palavra REGISTROS
Item	Campo	Descri��o	Tamanho	Decimais	Observa��o
1	REGISTROS	Identificador do arquivo 	9		Deve preceder todos os registros.
2	Espa�o	Espa�o em branco	1		
3	Data	Data da gera��o do arquivo	10		dd/mm/aaaa
*/

	cTexto := "REGISTROS"
	cTexto += chr(13)+chr(10)
Endif

If fWrite(nHandle,cTexto,Len(cTexto)) != Len(cTexto)
	MsgAlert("Ocorreu um erro na gravacao do arquivo.","Erro!")
	fClose(nHandle)
	Return()
Endif

//============================================================
//  SELECIONA PRODUTORES PARA EXPORTA��O
//============================================================

cQuery := " SELECT A2_COD, A2_LOJA, A2_NOME, A2_L_FAZEN,  " //A2_XNUM , A2_L_VOLUM
cQuery += " A2_L_LATIT, A2_L_LONGI, A2_L_TANQ "
cQuery += " FROM "+retsqlname("SA2")+" SA2 "
cQuery += " WHERE SA2.A2_L_TPFOR = 'P' AND SA2.A2_L_DIGIC = 'S' AND SA2.D_E_L_E_T_ <> '*' "


If Select("TR1") > 0
	DbSelectArea("TR1") 
	DbCloseArea("TR1")
Endif

TCQUERY cQuery NEW ALIAS TR1

DbSelectArea("TR1")
ProcRegua(RecCount()) // Numero de registros a processar

TR1->(DbGotop())
While !TR1->(Eof())

/*
Registro PRODUTOR - Descri��o dos Campos :
Item	Campo		Descri��o							Tamanho	Decimais	Observa��o
1		PRODUTOR	Identificador do tipo de registro	8		Deve preceder os registros de produtor.
2		CodFornec	C�digo do produtor					10		C�digo do produtor.
3		NomeFornec	Nome do produtor					100		Nome do produtor.
4		CodCurral	C�digo do curral					10		C�digo do curral. Se n�o tiver informe 0
5		NomeFazenda	Nome da fazenda						100		Nome da fazenda (curral). Se n�o tiver informe nulo �;;�
6		VolumeMedio	Produ��o m�dia do produtor (L)		5		Valor inteiro da produ��o m�dia por coleta. Sen�o tiver informe 0.
7		Latitude	Latitude do ponto de coleta			11	7	Valor da latitude ex: -18.5841710. Se n�o tiver informe 0.
8		Longitude	Longitude do ponto de coleta		11	7	Valor da longitude ex: -46.514678. Se n�o tiver informe 0.
9		TipoTanque	Tipo de tanque						1		I � Produtor individual; C � Tanque coletivo; A � Associado de tanque.
10		CodTanque	C�digo do tanque coletivo			10		C�digo do tanque � utilizado para indicar a qual tanque o produtor est� associado, caso ele seja individual informar 0.
11		Mensagem	Mensagem para o produtor 			nx32	Mensagem individual para o produtor numa sequ�ncia de n linhas de 32 caracteres. Se n�o tiver informe nulo �;;�.

*/
			IncProc("Processando Produtor: "+ALLTRIM(TR1->A2_NOME))
			cTexto := "PRODUTOR"+";"
			cTexto += PADR(SubStr(TR1->A2_COD,2,5)+Alltrim(TR1->A2_LOJA),10,"0")+";"
			cTexto += ALLTRIM(TR1->A2_NOME)+";"
			cTexto += "0;" // CODIGO CURRAL
			cTexto += ALLTRIM(TR1->A2_L_FAZEN)+";"
			cTexto += "0;" //STRZERO(TR1->A2_L_VOLUM,5)+
			cTexto += "0"+";"
			cTexto += "0"+";"
			cTexto += "I"+";"
			cTexto += IIF(Empty(TR1->A2_L_TANQ),'0',TR1->A2_L_TANQ)+";;"
			cTexto += chr(13)+chr(10)

			dbSelectArea("SA2")
			dbSetOrder(1)
			/*
			If dbSeek(xFilial("SA2")+TR1->A2_COD+TR1->A2_LOJA)
				SA2->(RecLock("SA2",.F.))
					SA2->A2_L_DIGIC := "S"
			    SA2->(MsUnLock())
			Endif
            */
			dbSelectArea("TR1")
		
		If fWrite(nHandle,cTexto,Len(cTexto)) != Len(cTexto)
			MsgAlert("Ocorreu um erro na gravacao do arquivo.","Erro!")
			fClose(nHandle)
			Return()
		Endif
		
   	TR1->(DbSkip())
EndDo
/*
If fWrite(nHandle,cTexto,Len(cTexto)) != Len(cTexto)
	MsgAlert("Ocorreu um erro na gravacao do arquivo.","Erro!")
	fClose(nHandle)
	Return()
Endif
*/
//================================================================
//  SELECIONA VEICULOS PARA EXPORTA��O
//================================================================

cQuery := " SELECT * " //"ZL4_COD, ZL4_PLACA, ZL4_CAPACI "
cQuery += " FROM "+retsqlname("ZL4")+" ZL4 "
cQuery += " WHERE ZL4.D_E_L_E_T_ = '' "
cQuery += " AND ZL4.ZL4_DIGIC = 'S' "


If Select("TR1") > 0
	DbSelectArea("TR1") 
	DbCloseArea("TR1")
Endif

TCQUERY cQuery NEW ALIAS TR1

DbSelectArea("TR1")
ProcRegua(RecCount()) // Numero de registros a processar
TR1->(DbGotop())
While !TR1->(Eof())
/*
Registro VEICULO - Descri��o dos Campos :
Item	Campo		Descri��o							Tamanho	Decimais	Observa��o
1		VEICULO		Identificador do tipo de registro	7					Deve preceder os registros de ve�culos.
2		CodVeiculo	C�digo do ve�culo					10					C�digo do ve�culo.
3		Placa		Placa do ve�culo					10					Placa do ve�culo (pode usar o separador �-�).
4		QtdeBocas	Quantidade de bocas do caminh�o		1					Quantidade de bocas do caminh�o (1 a 4).
5		Boca1		Capacidade da boca 1 (L)			5					Capacidade da boca 1 do caminh�o.
6		Boca2		Capacidade da boca 2 (L)			5					Capacidade da boca 2 do caminh�o. Se o ve�culo n�o tiver essa boca informar 0.
7		Boca3		Capacidade da boca 3 (L)			5					Capacidade da boca 3 do caminh�o. Se o n�o tiver essa boca informar 0.
8		Boca4		Capacidade da boca 4 (L)			5					Capacidade da boca 4 do caminh�o. Se o ve�culo n�o tiver essa boca informar 0.

*/
			cTexto := "VEICULO"+";"
			cTexto += STRZERO(VAL(TR1->ZL4_COD),10)+";"
			cTexto += TR1->ZL4_PLACA+";"
			cTexto += TR1->ZL4_QTDDIV+";"
			cTexto += STRZERO(TR1->ZL4_BOCA1,5)+";"
			cTexto += STRZERO(TR1->ZL4_BOCA2,5)+";"
			cTexto += STRZERO(TR1->ZL4_BOCA3,5)+";"
			cTexto += STRZERO(TR1->ZL4_BOCA4,5)+";"
			cTexto += chr(13)+chr(10)
			
			If fWrite(nHandle,cTexto,Len(cTexto)) != Len(cTexto)
				MsgAlert("Ocorreu um erro na gravacao do arquivo.","Erro!")
				fClose(nHandle)
				Return()
			Endif

			dbSelectArea("ZL4")
			dbSetOrder(1)
            /*
			If dbSeek(xFilial("ZL4")+TR1->ZL4_COD)
				
				ZL4->(RecLock("ZL4",.F.))
					ZL4->ZL4_DIGIC := 'S'
				ZL4->(MsUnLock())
				
			Endif
			*/
			dbSelectArea("TR1")

   	TR1->(DbSkip())
EndDo
/*
If fWrite(nHandle,cTexto,Len(cTexto)) != Len(cTexto)
	MsgAlert("Ocorreu um erro na gravacao do arquivo.","Erro!")
	fClose(nHandle)
	Return()
Endif
*/

//=====================================================
// SELECIONA TRANSPORTADORES PARA EXPORTA��O
//=====================================================


cQuery := " SELECT A2_COD, A2_LOJA, A2_NOME" //, A2_L_ACESS 
cQuery += " FROM "+retsqlname("SA2")+" SA2 "
cQuery += " WHERE SA2.A2_L_TPFOR = 'T'  AND SA2.A2_L_DIGIC = 'S' AND SA2.D_E_L_E_T_ <> '*'  "


If Select("TR1") > 0
	DbSelectArea("TR1") 
	DbCloseArea("TR1")
Endif

TCQUERY cQuery NEW ALIAS TR1

DbSelectArea("TR1")
TR1->(DbGotop())
While !TR1->(Eof())

/*
Registro TRANSPORTADOR - Descri��o dos Campos :
Item	Campo				Descri��o										Tamanho	Decimais	Observa��o
1		TRANSPORTADOR		Identificador do tipo de registro				13					Deve preceder os registros de transportadores.
2		CodTransportador	C�digo do transportador							10					C�digo do transportador
3		NomeTransportador	Nome do transportador							100					Nome do transportador
4		DistanciaUsina		Dist�ncia do in�cio da coleta ate a usina (km)	5		1			Informa a dist�ncia entre o ponto onde o transportador vai iniciar a coleta (casa dele, por exemplo) e a usina onde a coleta ser� finalizada. Se iniciar da usina, informe 0.

*/
			cTexto := "TRANSPORTADOR"+";"
			cTexto += PADR(SubStr(TR1->A2_COD,2,5)+Alltrim(TR1->A2_LOJA),10,"0")+";"
			cTexto += ALLTRIM(TR1->A2_NOME)+";"
			cTexto += "000.0;" //ALLTRIM(TransForm(TR1->A2_L_ACESS, "999.9"))+
			cTexto += chr(13)+chr(10)

			dbSelectArea("SA2")
			dbSetOrder(1)
			/*
			If dbSeek(xFilial("SA2")+TR1->A2_COD+TR1->A2_LOJA)
				SA2->(RecLock("SA2",.F.))
					SA2->A2_L_DIGIC := "S"
			    SA2->(MsUnLock())
			Endif
            */ 
			dbSelectArea("TR1")
		
		If fWrite(nHandle,cTexto,Len(cTexto)) != Len(cTexto)
			MsgAlert("Ocorreu um erro na gravacao do arquivo.","Erro!")
			fClose(nHandle)
			Return()
		Endif

   	TR1->(DbSkip())
   	
EndDo


cTexto := "OCORRENCIA;1001;N;Reorganizar Rota;" + chr(13)+chr(10)
cTexto += "OCORRENCIA;1002;N;Leite Congelado;"  + chr(13)+chr(10)
cTexto += "OCORRENCIA;1003;N;Porteira Trancada;"+ chr(13)+chr(10) 
cTexto += "OCORRENCIA;1004;N;Ponte Caida;"      + chr(13)+chr(10)
cTexto += "OCORRENCIA;1005;N;Atoleiro;"         + chr(13)+chr(10)
cTexto += "OCORRENCIA;1006;C;Tanque Sujo;"      
cTexto += chr(13)+chr(10)

If fWrite(nHandle,cTexto,Len(cTexto)) != Len(cTexto)
	MsgAlert("Ocorreu um erro na gravacao do arquivo.","Erro!")
	fClose(nHandle)
	Return()
Endif



//=====================================================
// SELECIONA ROTAS PARA EXPORTA��O
//=====================================================
/*
cQuery := " SELECT ZLW_COD, ZLW_DESCRI "
cQuery += " FROM "+retsqlname("ZLW")+" ZLW "
cQuery += " WHERE ZLW.D_E_L_E_T_ <> '*' AND ZLW.ZLW_DIGIC = 'S' "
*/
cQuery := " SELECT ZLZ_ROTA as ROTA, ZLW_DESCRI AS DESCRI, ZLZ_CODPRO AS CODPRO, ZLZ_LJPROD AS LOJA, ZLZ_ITEM AS ITEM "
cQuery += " FROM "+retsqlname("ZLZ")+" LZ "
cQuery += " 	JOIN "+retsqlname("ZLW")+" LW ON ZLW_FILIAL = ZLZ_FILIAL "
cQuery += 	"	AND ZLW_COD = ZLZ_ROTA "
cQuery += 	"	AND ZLW_VERSAO = ZLZ_VERSAO "
cQuery += 	"	AND ZLW_DIGIC = 'S' "
cQuery += 	"	AND LW.D_E_L_E_T_ = ' ' "
cQuery += " WHERE LZ.D_E_L_E_T_ = ' '

If Select("TR1") > 0
	DbSelectArea("TR1") 
	DbCloseArea("TR1")
Endif

TCQUERY cQuery NEW ALIAS TR1

DbSelectArea("TR1")
TR1->(DbGotop())

nSeqX := 0

While !TR1->(Eof())

			nSeqX++

			cTexto := "ROTA"+";"
			cTexto += TR1->ROTA+";"
			cTexto += ALLTRIM(TR1->DESCRI)+";"
			cTexto += TR1->ROTA+";"
			cTexto += ALLTRIM(TR1->DESCRI)+";"
			cTexto += Alltrim(CVALTOCHAR(Val(TR1->ITEM)))+";"
			cTexto += PADR(SubStr(TR1->CODPRO,2,5)+Alltrim(TR1->LOJA),10,"0")+";"
			cTexto += "0;"
			cTexto += chr(13)+chr(10)

			dbSelectArea("ZLW")
			dbSetOrder(1)
			/*
			If dbSeek(xFilial("ZLW")+TR1->ZLW_COD)
				SA2->(RecLock("ZLW",.F.))
					ZLW->ZLW_DIGIC := "S"
			    SA2->(MsUnLock())
			Endif
            */
			dbSelectArea("TR1")
		
		If fWrite(nHandle,cTexto,Len(cTexto)) != Len(cTexto)
			MsgAlert("Ocorreu um erro na gravacao do arquivo.","Erro!")
			fClose(nHandle)
			Return()
		Endif

   	TR1->(DbSkip())
   	
EndDo 


fClose(nHandle)

If FRENAME(cSalvar,Upper(cSalvar)) == -1
		MsgAlert("N�o foi poss�vel renomear o arquivo: "+chr(13)+cSalvar)
EndIf

MsgAlert("Exporta��o Finalizada...")

Return()

	