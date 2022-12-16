
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "FILEIO.CH" 

/*
==========================================================================
= ROTINA PARA IMPORTAÇÃO DE RECEBIMENTO DE LEITE DO SISTEMA DIGICERTO
= EMPRESA - QUATRELATI - 15/03/2018
= TOTVS TRIANGULO - ANALISTA: José Rogério / Guilherme França
==========================================================================
*/

user function MGLT101()

Local cAviso := ""

Private aDados := {}
Private cFile  := ""
Private _cFile
Private cArqImp :=  ""
Private _nTotB  := 0
Private nTotBom := 0
Private _lGeraSD3 	:= SuperGetMv("LT_GERASD3",,.F.) //Parametro indica se será gerado movimento SD3 no ticket.
Private cSetor := ""
Private dDtColeta

cAviso := "ATENÇÃO!!"+chr(13)+chr(10)+chr(13)+chr(10)
cAviso += "Este programa irá importar registros de um arquivo CSV para RECEBIMENTO DE LEITE "
cAviso += " Confirma a execução da rotina?"+chr(13)+chr(10)

If Aviso("Atenção!!",cAviso,{"Sim","Não"}) == 1
	MGLT101A(@cFile)
Endif

Return()

//===========================//

Static Function MGLT101A(_cFile)

Local aArq 	   := {}
Local cUrlArq  := ""
Local cAviso   := ""
Private cNomeArq := ""

cAviso := "ATENÇÃO!!"+chr(13)+chr(10)+chr(13)+chr(10)
cAviso += "      1. Arquivo TXT separado por ; (ponto e virgula)"+chr(13)+chr(10)
cAviso += "Confirma a execução da rotina?"+chr(13)+chr(10)

//If Aviso("Atenção!!",cAviso,{"Sim","Não"}) == 2
//	Return()
//Endif

MsgInfo("Selecione o arquivo a ser importado!")
_cFile := Alltrim(cGetFile("*.txt","Abrir",1,"c:\",.T.,GETF_LOCALHARD + GETF_NETWORKDRIVE))

cArqImp := _cFile

If Empty(AllTrim(_cFile))
	MsgAlert("Nenhum arquivo selecinado!")
	Return()
Else
	aArq     := StrToKarr(_cFile, "\")
	cNomeArq := SubStr(_cFile, RAT( "\", _cFile )+1, LEN(_cFile))
	cUrlArq  := SubStr(_cFile, 1, RAT( "\", _cFile ))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida se o arquivo tem extensao IMP, ou seja, ja foi importado.      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If UPPER(Substr(cNomeArq,Len(AllTrim(cNomeArq))-2,3)) == "IMP"
		xmaghelpfis("Arquivo Inválido!!",;
		"O arquivo informado já foi importado anteriormente.")
	
		Return
	
	EndIf
	
	If MsgYesNo("Confirma o arquivo "+cNomeArq+" do diretório "+cUrlArq+" ?")
		Processa({|lEnd| MGLT101B() }, "Manipulando Arquivo .CSV", "Buscando Arquivo...",.T. )
	Endif
Endif
	
Return()


//===============================//

Static Function MGLT101B()

Local nCont := 1
Local cHandle
Local cLinha
Local nTotKM := 0
Local aLinha
Local dData
Local aLog := {}

cHandle	:= FT_Fuse(cFile, FO_READWRITE)
ProcRegua(0)
                             
if cHandle == -1
	MsgStop("Erro de abertura. Arquivo não encontrado!")
	IncProc("Arquivo informado não pode ser encontrato.")
	fClose(cHandle)
	Return()
else
	IncProc("Processando Arquivo...")

	While !FT_FEof()

		cLinha := FT_FReadln()
		aLinha := StrTokArr2( cLinha, ";", .T. )
							
			If Empty(Alltrim(aLinha[1]))
				MsgStop("Erro de dados: Conteudo da coluna 1 inválido!"+chr(10)+" Linha: "+Alltrim(Str(nCont)))
				fClose(cHandle)
				Return()
			Endif
		
			aadd(aDados,{Alltrim(aLinha[1]),;
								 Alltrim(aLinha[2]),;
								 Alltrim(aLinha[3]),;
								 Alltrim(aLinha[4]),;
								 Alltrim(aLinha[5]),;
								 Alltrim(aLinha[6]),;
								 Alltrim(aLinha[7]),;
								 Alltrim(aLinha[8]),;
								 Alltrim(aLinha[9]),;
								 Alltrim(aLinha[10]),;
								 Alltrim(aLinha[11]),;
								 Alltrim(aLinha[12]),;
								 Alltrim(aLinha[13]),;
								 Alltrim(aLinha[14]),;
								 Alltrim(aLinha[15]),;
								 Alltrim(aLinha[16]),;
								 Alltrim(aLinha[17]),;
								 Alltrim(aLinha[18]),;
								 Alltrim(aLinha[19]),;
								 Alltrim(aLinha[20]),;
								 Alltrim(aLinha[21]),;
								 Alltrim(aLinha[22]),;
								 Alltrim(aLinha[23]),;
								 Alltrim(aLinha[24]),;
								 Alltrim(aLinha[25]),;
								 Alltrim(aLinha[26]),;
								 Alltrim(aLinha[27])})
								 
								 //=============================================
								 // VERIFICAR CONSISTENCIA DO ARQUIVO IMPORTADO
								 //=============================================
								 _cCodPr := Val(aDados[nCont,5]) / 1000

								 _cCodPr := "P" + StrZero(_cCodPr,7)
								 _cCodTr := "T" + SubsTr(aDados[nCont,2],1,7)
								 //_cCodPr := "P" + aDados[nCont,5]
								 //_cCodTr := "T" + aDados[nCont,2]
								 
								 _nTotB  += Val(aDados[nCont,7])
								 cProdutor := GetAdvFVal("SA2","A2_NOME",xFilial("SA2")+_cCodPr,1,"NOME PROD") //Posicione("SA2",1,xFilial("SA2")+_cCodPr,'A2_NOME')
								 cTranspor := GetAdvFVal("SA2","A2_NOME",xFilial("SA2")+_cCodTr,1,"NOME TRANS") //Posicione("SA2",1,xFilial("SA2")+_cCodTr,'A2_NOME')
								 
								 If Empty(cProdutor) .OR. Empty(cTranspor)
								 
								 	cAviso := "ATENÇÃO!!"+chr(13)+chr(10)+chr(13)+chr(10)
								 	cAviso += "Produtor ou Transportador Encontrado: " + _cCodPr +chr(13)+chr(10)
								 	cAviso += " " + _cCodTr+ " CONTINUAR? " +chr(13)+chr(10)
		
									If Aviso("Atenção!!",cAviso,{"Sim","Não"}) == 2
										Return()
									Endif
								  
								 Endif
		
				ProcRegua(0)
				IncProc("Copiando dados do Arquivo... "+StrZero(nCont,9))
		
		FT_FSkip()
		nCont++
	Enddo
	FT_Fuse()
Endif

fClose(cHandle)

If Len(aDados) > 0
	Processa({|lEnd| MGLT101C() }, "Atualizando Registros", "Preparando atualização...",.T. )
Else
	MsgStop("Erro de leitura: nenhum registro importado, arquivo vazio!")
Endif

Return()

//==================================================
// ATUALIZA A TABELA ZLD - RECEBIMENTO DE LEITE
// QUATRELATI - 15/03/2018
// TOTVS TRIANGULO - José Rogério
//==================================================

Static Function MGLT101C()

Local lRet := .F. 
Local i := 0
Local _cRota := ""
Private _cTicket := U_MaxCodigo("ZLD_TICKET")
Private _cCodRec := _cTicket //GetNumRec()
_cTicket := StrZero(Val(_cTicket)+1,6)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄˆ
//³ Tratamento para evitar que dois usuarios cadastrem o mesmo codigo ao mesmo tempo. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄˆ
While !MayIUseCode("ZLD" +xFilial("ZLD")+_cTicket)  //verifica se esta na memoria, sendo usado
	_cTicket := StrZero(Val(_cTicket)+1,6)				   // busca o proximo numero disponivel
EndDo


ProcRegua(0)

For i := 1 to Len(aDados)

  If aDados[i,27] == "1"	
	
	DbSelectArea("ZLD")
	DbSetOrder(4)
	
	cdtCole := "20"+aDados[i,13]+aDados[i,12]+aDados[i,11]
	
	cCodPr := Val(aDados[i,5]) / 1000
	cCodPr := "P" + StrZero(cCodPr,7)
	cCodTr := "T" + SubsTr(aDados[i,2],1,5)	
	cTraLj := GetAdvFVal("SA2","A2_LOJA",xFilial("SA2")+cCodTr,1,"01")
	cCodTr := cCodTr+cTraLj  //Existem lojas com 2 e com 4 digitos, por isso foi feito este tratamento.

	If !dbSeek(xFilial("ZLD")+cCodPr+cdtCole)
	   lRet := .T.
	Endif

	IncProc("Gravando registro... "+StrZero(i,9))
	
	ZLD->(RECLOCK("ZLD",lRet))

	_cRota := StrZero(Val(aDados[i,4]),6)
	cSetor := GetAdvFVal("ZLW","ZLW_SETOR",xFilial("ZLW")+_cRota+"R",1," ")//'000001'

	ZLD->ZLD_FILIAL     := xFilial("ZLD")
	ZLD->ZLD_ITEM 		:= Strzero(Val(aDados[i,18]),3)
	ZLD->ZLD_TICKET		:= _cTicket //Strzero(Val(aDados[i,1]),6)
	ZLD->ZLD_DTCOLE		:= Stod("20"+aDados[i,13]+aDados[i,12]+aDados[i,11])
	ZLD->ZLD_DTLANC		:= dDatabase
	//ZLD->ZLD_CODREC		:= _cCodRec //_cTicket //Strzero(Val(aDados[i,1]),6)
	ZLD->ZLD_SETOR 		:= cSetor
	ZLD->ZLD_RETIRO		:= Left(cCodPr,6)
	
	dDtColeta := Stod("20"+aDados[i,13]+aDados[i,12]+aDados[i,11])
	cProdutor := GetAdvFVal("SA2","A2_NOME",xFilial("SA2")+cCodPr,1," ") //Posicione("SA2",1,xFilial("SA2")+cCodPr,'A2_NOME')
	ZLD->ZLD_DCRRET 	:= cProdutor
	ZLD->ZLD_QTDBOM		:= Val(aDados[i,7])
	ZLD->ZLD_HORA		:= aDados[i,9]+":"+aDados[i,10]
	ZLD->ZLD_TEMP		:= Val(aDados[i,8])
	//ZLD->ZLD_REGUA		:= Val(aDados[i,16])
	ZLD->ZLD_BOCA		:= aDados[i,17]	
	ZLD->ZLD_LINROT		:= _cRota
	ZLD->ZLD_VERSAO		:= "001"
	
	cLinha := GetAdvFVal("ZLW","ZLW_DESCRI",xFilial("ZLW")+_cRota+"R",1," ") //Posicione("ZLW",3,xFilial("ZLW")+cCodTr,'ZLW_DESCRI')
	nTotKM := GetAdvFVal("ZLW","ZLW_KM",xFilial("ZLW")+_cRota+"R",1," ")
	ZLD->ZLD_DESLIN		:= cLInha
	ZLD->ZLD_GRPRC		:= GetAdvFVal("SA2","A2_L_LI_RO",xFilial("SA2")+cCodPr,1," ")
	ZLD->ZLD_FRETIS		:= Left(cCodTr,6)
	ZLD->ZLD_USER		:= CUSERNAME //'Imp. Digicerto'
	ZLD->ZLD_KM			:= nTotKM //Val(aDados[i,24])
	
	cMotor := GetAdvFVal("ZL4","ZL4_MOTORI",xFilial("ZL4")+SubsTr(aDados[i,3],5,6),1," ") //Posicione("ZL0",1,xFilial("ZL0")+cCodTr,'ZL0_COD')
	
	ZLD->ZLD_MOTOR		:= cMotor
	ZLD->ZLD_VEICUL		:= SubsTr(aDados[i,3],5,6)
	ZLD->ZLD_LJFRET		:= cTraLj //Right(cCodTr,2)
	ZLD->ZLD_ROTCAB		:= _cRota //SubsTr(aDados[i,4],5,6)
	ZLD->ZLD_DESCAB		:= cLinha
	ZLD->ZLD_TRIBUT		:= 'I' //'T'
	ZLD->ZLD_DIGIC		:= 'S'
	ZLD->ZLD_RETILJ  	:= Right(cCodPr,2)
	ZLD->ZLD_TEMPCA		:= Val(aDados[i,8])
	ZLD->ZLD_TOTAL		:= ZLD->ZLD_TOTAL + Val(aDados[i,7])
	ZLD->ZLD_HORMED		:= aDados[i,9]+":"+aDados[i,10]
	ZLD->ZLD_TOTBOM		:= _nTotB
	ZLD->ZLD_HORDES		:= aDados[i,9]+":"+aDados[i,10]
	ZLD->ZLD_IMPORT		:= "I"
	ZLD->ZLD_LOTE		:= xFilial("ZLD") + _cTicket
	ZLD->(MsUnlock())
	
	nTotBom := Val(aDados[i,7])
	
	GeraSD3(_cCodRec,3,_cTicket)   // função que gera movimentação interna
	
  Endif	
Next i			

 MsgInfo("Dados gravados com sucesso!") 

If FRENAME(cArqImp,Substr(cArqImp,1,Len(cArqImp)-3)+"IMP") == -1
		MsgAlert("Não foi possível renomear o arquivo: "+chr(13)+cArqImp)
EndIf

Return()

//============================================================//

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GeraSD3   º Autor ³ TOTVS                 º Data da Criacao  ³ 07/10/2008                						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Funcao usada para gravar o movimento interno no estoque                                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Implantacao das rotinas referente a Gestao do Leite.                						                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ Nenhum                                                                               						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ Nenhum                                                                                						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUsuario   ³ Microsiga                                                                                					º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºSetor     ³ Gestao do Leite.                                                                        						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL                   						º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor     ³ Data     ³ Motivo da Alteracao  				               ³Usuario(Filial+Matricula+Nome)    ³Setor        º±±
±±ºÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄº±±
±±º          ³          ³                               				   ³                                  ³   	        º±±
±±º----------³----------³--------------------------------------------------³----------------------------------³-------------º±±
±±º          ³          ³                    							   ³                                  ³ 			º±±
±±º----------³----------³--------------------------------------------------³----------------------------------³-------------º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GeraSD3(cCod,nOption,xcTicket)

Local aAutoSD3  	:= {}
Local cTm       	:= ALLTRIM(GetMv("LT_ENTTM")) //Cod. do Tipo do Mov.Interno do Recto de Leite
Local cLocal    	:= ""
Local bRet      	:= .T.
Local nI        	:= 0
Local nModBkp   	:= nModulo
Local cModBkp   	:= cModulo
Local cFilBkp   	:= cFilAnt
Local aQtdFil   	:= {}

Local _aDadosSD3	:= {}

Local _cDadosSD3	:= ""

Local _lRastro      := GetMv("MV_RASTRO") == "S"  //Verifica se o sistema efetuara o controle de rastreabilidade
Local _cLote        := ""
Local F
Local _aArea        := GetArea()
Local _cCustoD3	:= 0
Local _lCusto	:= .f. //TM gera custo na SD3
Local _nDias := 4
Local cLeite := GetMv("LT_PRTRIBU")  // codigo do produto da movimentação interna
Private _cCCusto  := AllTrim(GetMv("LT_CCUSTO"))

If !_lGeraSD3
	Return .t. // Se não gera SD3 a função retorna positivo sem movimentar.
EndIf


Private lMsErroAuto := .F.
Private lMsHelpAuto := .T.

	//Posiciona no de Tipos de Movimentos
	dbSelectArea("SF5")
	dbSetOrder(1)
	If !dbSeek(xFILIAL("SF5") + cTm)
		xMagHelpFis("Parametro - SX6","O codigo de Movimento Interno (SF5) " + cTm + " não foi encontrado.","Preencha corretamente o parâmetro LT_ENTTM.")
		Return(.F.)
	EndIf
	_lCusto := (SF5->F5_AGREGCU == '1')
	//Posiciona no cadastro de Setor
	dbSelectArea("ZL2")
	dbSetOrder(1)//ZL2_FILIAL+ZL2_COD
	dbSeek(xFILIAL("ZL2") + cSetor)
	
	cLocal  := ZL2->ZL2_LOCAL
	nVlrMix := ZL2->ZL2_ULTMIX
	
	If nVlrMix <= 0
		xMagHelpFis("Vlr. MIX","O valor do custo do produto não foi preenchido no cadastro de Setor!","Preencha o valor do custo de entrada no estoque no cadastro de Setor.")
		Return(.F.)
	EndIf
		
		aAutoSD3    := {}
		lMsHelpAuto := .T.
		lMsErroAuto := .F.
		nModulo     := 4
		cModulo     := "EST"
		
		//Posiciona no cadastro de Produtos
		dbSelectArea("SB1")
		dbSetOrder(1)
		dbSeek(xFILIAL("SB1") + cLeite)
		
		//Posiciona na tabela de Saldos em Estoque
		//Se nao encontrar o produto na tabela de saldos,
		//inclui saldo inicial para o produto.
		//dbSelectArea("SB2")
		//SB2->(dbSetOrder(1))

		_cQuery := " SELECT Count(*) as COUNT "
		_cQuery += " FROM "+RetSqlName("SB2")+" SB2  "
		_cQuery += " WHERE " + RetSqlCond("SB2") + " "
		_cQuery += " AND B2_COD = '"+SB1->B1_COD+"' "
		_cQuery += " AND B2_LOCAL = '"+cLocal+"' "
		_cQuery += " AND SB2.D_E_L_E_T_ = ' '"
		If Select ("EST") <> 0
			EST->(dbCloseArea())
		EndIf
	
		dbUseArea(.T.,"TOPCONN",TCGenQry(,,_cQuery),"EST",.F.,.T.)
		
		EST->(dbGoTop())
		
		If EST->(Eof())
			CriaSB2(SB1->B1_COD,cLocal)
		EndIf
		
		EST->(DBCLOSEAREA())
		_cCustoD3	:= 0
		
		AAdd( aAutoSD3,{"D3_FILIAL"     , xFilial("SD3")			, Nil } )// Codigo da Filial
		AAdd( aAutoSD3,{"D3_TM"		    , cTm 				        , Nil } )// Tipo do Movimento Interno
		AAdd( aAutoSD3,{"D3_COD"		, SB1->B1_COD  	            , Nil } )// Codigo do Produto
		AAdd( aAutoSD3,{"D3_UM"		    , SB1->B1_UM		        , Nil } )// Unidade de Medida
		AAdd( aAutoSD3,{"D3_QUANT"	    , nTotBom		    	, Nil } )// Quantidade de Leite -- nTotCodRec = soma das coletas dos produtores
		_cCustoD3	:= nVlrMix*nTotBom
		AAdd( aAutoSD3,{"D3_LOCAL"	    , cLocal		 , Nil } )// Almoxarifado
		AAdd( aAutoSD3,{"D3_EMISSAO"	, dDtColeta			        , Nil } )// Data de Emissao
		AAdd( aAutoSD3,{"D3_DOC"	    , "GLT"+xcTicket	 , Nil } )// Documento  //GetSxeNum("SD3","D3_DOC")
		If _lCusto
			AAdd( aAutoSD3,{"D3_CUSTO1"	    , _cCustoD3 		, Nil } )// Custo (na Moeda 1)
		EndIf
		
		//------------ José Rogéro ---------- FJC
		
		AAdd( aAutoSD3,{"D3_CC"	, _cCCusto			        , Nil } )// CCUSTO
		AAdd( aAutoSD3,{"D3_ZDEST"	, 'E'			        , Nil } )// DESTINO
		
		//---------------------------------------
		
		
		/*
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Verifica se o parametro MV_RASTRO esta configurado para gerar rastreabilidade³
		//³e se o produto foi configurado  para rastrear por sub-lote ou lote.          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		*/
		If _lRastro .And. SB1->B1_RASTRO $ ('S','L')
			
			_cLote:= Alltrim(xFilial("SF2"))+xcTicket//U_SiglaFil(xFilial("SF2"))+xcTicket//pesqLote(dDtColeta,cTm)
			_nDias := IIF(SB1->B1_PRVALID>0,SB1->B1_PRVALID,4)
			AAdd( aAutoSD3,{"D3_LOTECTL"	, _cLote			    , Nil } )	// Lote
			AAdd( aAutoSD3,{"D3_DTVALID"	, dDtColeta + _nDias   	, Nil } )	// Data de validade do lote
			
		endif
		
		AAdd( aAutoSD3,{"D3_L_ORIG"	    , cCod   				    , Nil } )// Origem do documento - Ticket
		AAdd( aAutoSD3,{"D3_L_SETOR"	, cSetor  			        , Nil } )// Setor do documento
		
		Pergunte("MTA240",.F.) // Chama perguntas da rotina para evitar erros no Sigaauto
		MSExecAuto({|x,y| MATA240(x,y)},aAutoSD3,3)
		
		
		Pergunte("AGLT003",.F.) // Volta as perguntas do programa principal
		
		If lMsErroAuto
			xMagHelpFis("SigaAuto - MATA240","Não foi possivel executar o SigaAuto de Inclusão de Movimento Interno.","Após confirmar esta mensagem, verifique os detalhes no Log do SigaAuto.")
			MostraErro()
			bRet := .F.
		EndIf

nModulo := nModBkp
cModulo := cModBkp
cFilAnt := cFilBkp

restArea(_aArea)

Return(bRet)

Static Function GetNumRec()

Local cRet   := ""
Local cQuery := ""
Local aArea  := GetArea()

cQuery := "SELECT MAX(ZLD_TICKET) AS ULTIMO FROM "
cQuery += RetSqlName("ZLD") + " WHERE D_E_L_E_T_ = ' ' "
cQuery += "  AND ZLD_FILIAL = '" + xFILIAL("ZLD") + "'"

If Select("TRB") > 0
	dbSelectArea("TRB")
	TRB->(dbCloseArea())
EndIf

dbUseArea(.T.,"TOPCONN",TCGenQry(,,ALLTRIM(Upper(cQuery))),'TRB',.F.,.T.)

If TRB->(!Eof())
	cRet := soma1(TRB->ULTIMO)
EndIf

dbSelectArea("TRB")
TRB->(dbCloseArea())

While !MayIUseCode("ZLD_TICKET" + xFilial("ZLD") + cRet)  //verifica se esta na memoria, sendo usado
	cRet := Soma1(cRet)						           // busca o proximo numero disponivel
EndDo

RestArea(aArea)

Return cRet


