#INCLUDE "PROTHEUS.ch"
#INCLUDE "RWMAKE.ch"
#INCLUDE "TOPCONN.ch"

#DEFINE _ENTER CHR(13)+CHR(10)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ MGLT003  บ Autor ณ TOTVS                 บ Data da Criacao  ณ 26/09/2008                						บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Essa rotina importa dados de analise de leite a partir de um arquivo enviado pelo laboratorio e grava na     บฑฑ
ฑฑบ          ณ tabela de analises											                               			    	บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Implantacao das rotinas referente a Gestao do Leite.                						                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ Nenhum						   							                               						บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ Nenhum						  							                               						บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUsuario   ณ Microsiga                                                                                					บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบSetor     ณ Gestao do Leite.                                                                        						บฑฑ
ฑฑฬออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL                   						บฑฑ
ฑฑฬออออออออออัออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออัออออออออออออออออออออออออออออออออออัอออออออออออออนฑฑ
ฑฑบAutor     ณ Data     ณ Motivo da Alteracao  				               ณUsuario(Filial+Matricula+Nome)    ณSetor        บฑฑ
ฑฑบฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤบฑฑ
ฑฑบ          ณ          ณ                               				   ณ                                  ณ   	        บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑบ          ณ          ณ                    							   ณ                                  ณ 			บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑศออออออออออฯออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออออออออออออออออออออออออออออออฯอออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function MGLT003

	Local _cTexto := ""
	Local _nRet := 0
	Private cPerg   := "MGLT003"
	Private cAnaPro := " " //Codigo Analise do Protheus
	Private cAnoMes := ""
	Private aLog   := {}
	Private nAnal   := 0
	Private exist := .F.
	Private oLeTxt

	_cTexto := " Este programa importa os dados da Analise de Qualidade "+_ENTER
	_cTexto += " do Leite realizado pela Clํnica do Leite!"

	Pergunte(cPerg,.T.)

	_nRet := AVISO("Importa็ใo Anแlise da Qualidade", _cTexto, {"Executar","Fechar" }, 2)
	If _nRet == 1
		Processa({|| LeArq() },"Aguarde processando...")
	EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ LeArq    บ Autor ณ TOTVS              บ Data ณ  26/02/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao responsavel por ler arquito texto e retornar uma    บฑฑ
ฑฑบ          ณ matriz.                                                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa Principal.                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function LeArq()

	Local cLinha := ""
	Local aRet   := {}
	Local _lArqInvalido := .t.
	Private cArqTxt :=SubStr(MV_PAR01,1,At('.',MV_PAR01))+"log"
	Private nHdl    := fCreate(cArqTxt)
	Private cEOL    := "CHR(13)+CHR(10)"

	aLog   := {}

	If Empty(cEOL)
		cEOL := CHR(13)+CHR(10)
	Else
		cEOL := Trim(cEOL)
		cEOL := &cEOL
	Endif

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Abre o arquivo para leitura. ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

	nHandle := FT_FUSE(MV_PAR01)

	_cArqImp := AllTrim(MV_PAR01)


	If nHandle = -1
			xMagHelpFis("Arquivo",;
			"O local ou arquivo informado estใo invแlidos!",;
			"Utilize outro arquivo para importa็ใo da Qualidade.")
		Return
	EndIf


	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Valida se o arquivo tem extensao IMP, ou seja, ja foi importado.      ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If UPPER(Substr(MV_PAR01,Len(AllTrim(MV_PAR01))-2,3)) == "IMP"
		xmaghelpfis("Arquivo invอกlido",;
		"O arquivo informado jอก foi importado anteriormente.",;
		"Favor selecionar um arquivo com a extensaoo TXT ")

		Return
	EndIf

	FT_FGOTOP()
	nLast := FT_FLastRec()
	ProcRegua(nLast)
	_nCont := 1
	While !FT_FEOF()

		IncProc("Processando arquivo texto...linha: " + ALLTRIM(STR(Len(aRet))) + " de " + ALLTRIM(STR(nLast)))

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
		//ณ Le a linha do txt. ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
		cLinha := ALLTRIM( FT_FREADLN() )
		AADD(aRet,cLinha)
		FT_FSKIP()
	EndDo


	AADD(aLog,'Importacao de Analises da Clinica do Leite - ' + DTOS(date()) + ' ' + time()+cEOL+cEOL )
	AADD(aLog,'Periodo: Data Inicio -  ' + DTOS(MV_PAR03) + '  Data Final:  ' + DTOS(MV_PAR04)+cEOL+cEOL )


	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
	//ณ Fecha o txt aberto.  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
	//FT_FUSE()
	FT_FUSE()


	Processa({|| RunConta(aRet) },"Processando...")

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Renomeia Arquivo para identificar que o mesmo ja foi importado.  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	//FRENAME(MV_PAR01,SubStr(MV_PAR01,1,Len(ALLTRIM(MV_PAR01))-3)+"XXX")

	If _lArqInvalido
		If FRENAME(_cArqImp,Substr(_cArqImp,1,Len(_cArqImp)-3)+"IMP") == -1
			MsgAlert("Nใo foi possํvel renomear o arquivo: "+chr(13)+_cArqImp)
		EndIf
	EndIf

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ RunConta บ Autor ณ TOTVS              บ Data ณ  26/02/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Essa rotina faz operacao de leitura do arquivo informado   บฑฑ
ฑฑบ          ณ no parametro e chama funcao de gravacao.                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa Principal.                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RunConta(aDados)
	ProcRegua(Len(aDados)) // Numero de registros a processar
	Grava(aDados)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ Grava    บ Autor ณ TOTVS              บ Data ณ  26/02/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Le o array com os dados importados e grava na tabela ZLB.  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa Principal.                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Grava(aData)

	Local nY		:= 0
	Local aUTC    := {}
	Local cCodFaz := " " //Codigo da fazenda do produtor
	Local cAnaArq := " " //Codigo Analise do arquivo
	Local cNomAna := " " //Nome do item de analise
	Local cData   := " "
	Local cSeek   := " " //Indice de busca, exceto a data
	Local nMedia  := 0
	Local nI      := 0
	Local nX      := 0
	Local cRota := "" // Rota Do Produtor
	Local cAtual := .T. //GetMv("LT_ANAUPD")
	Local _nPosCod := 0
	Local _cCodCont :=  ""
	Local nProd := 0
	Local _lTanque := .f.

	ProcRegua(Len(aData))

	Begin Transaction
	For nI := 1 To Len(aData)

		cBuffer := aData[nI]
		_lTanque := .f.

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Tratamento para arquivos que nao devem ser lidos na importacao.         ณ
		//ณ Existem arquivos que na formacao do seu nome tem a sigla xnp, estes nao ณ
		//ณ devem ser lidos na importacao, pois nao tem o codigo da fazenda.        ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If SubStr(cBuffer,3,7) == "0000000"
			Loop
		EndIf


		_nPosCod := AT("S",SubStr(cBuffer,1,10))
		_nPosCod := IIF(_nPosCod==0,AT("N",SubStr(cBuffer,1,10)),_nPosCod)

		If _nPosCod == 1
			cCodFaz := SubStr(cBuffer,_nPosCod,6)+SubStr(cBuffer,8,2)
		ElseIf _nPosCod > 1
			cCodFaz := SubStr(cBuffer,_nPosCod,6)+SubStr(cBuffer,_nPosCod+7,2)
		ElseIf _nPosCod == 5
			cCodFaz := SubStr(cBuffer,_nPosCod,6)+ "01"
		Else
			cCodFaz := SubStr(cBuffer,4,7)
		EndIf

		If SubStr(cBuffer,2,1) = '-' .or. SubStr(cBuffer,6,1) = '-'
			cCodFaz := SubStr(cBuffer,7,4)
			cCodFaz := STRZERO(VAL(cCodFaz),6)
			_lTanque := .t.
		EndIf

		//123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
		//00000264 120131011001000009000Clํnica do Leite - SP         9999           20131007909
		//000100111820150617001001653000Clํnica do Leite - SP         9999           2015061318
		//cData   := SubStr(cBuffer,11,8) //Data Analise
		cData   := SubStr(cBuffer,80,8) //Data Analise
		cAnaArq := SubStr(cBuffer,23,3) //Codigo da Analise
		cRota := Substr(cBuffer,88,4)// Rota Do Produtor

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Armazena o mes e ano para posteriormente fazer verificacao de desclassificacao. ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If Empty(cAnoMes)
			cAnoMes := ALLTRIM(SubStr(cBuffer,15,6))
		EndIf

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Transforma CodAnalise para padrao Protheus e busca valor da analise. ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		DbSelectArea("ZL9")
		DbSetOrder(3) //ZL9_FILIAL, ZL9_CODLAB, R_E_C_N_O_, D_E_L_E_T_
		If MsSeek(xFilial("ZL9")+Alltrim(cAnaArq))
			If ZL9->ZL9_MSBLQL <> "1"
				cAnaPro  := ZL9->ZL9_COD
				nVlrAna  := Val(SubStr(cBuffer,26,9)) /1000
				nMedia   := nVlrAna
				cNomAna  := ZL9->ZL9_DESCRI
			Else
				cAnaPro  := "NOFOUND"
			EndIf
		Else
			cAnaPro  := "NOFOUND"
			nVlrAna  := 0
			nMedia   := nVlrAna
		EndIf

		IncProc("Processando..." + "Tanque: " + cCodFaz )

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Caso seja uma analise que nao deve ser importada, verifica.          ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If cAnaPro <> "NOFOUND"

			// verifica se propriedade rural estแ cadastrada no sistema
			If _lTanque
				dbSelectArea("ZLT")
				dbSetOrder(1) //ZLT_FILIAL+ZLT_COD+ZLT_SA2COD+ZLT_SA2LJ
				If MSSeek(xFILIAL("ZLT")+cCodFaz)
					cCodFaz := ZLT->ZLT_SA2COD+ ZLT->ZLT_SA2LJ
				Else
					cCodFaz := "XXX"
				EndIf
			EndIf


			dbSelectArea("SA2")
			dbSetOrder(1)
			dbSeek(xFILIAL("SA2")+cCodFaz)


			If SA2->(found())
				dtIni := DTOS(MV_PAR03)
				dtFim := DTOS(MV_PAR04)


					dbSelectArea("ZLS")
					dbSetOrder(1)
					dbSeek(xFILIAL("ZLS")+SA2->A2_L_TANQ)

					//Verifica se ้ usuario dono de tanque comunitario
					If ZLS->ZLS_CLASTQ == 'C'
						aUTC  := GetUTC(SA2->A2_L_TANQ, cData)
					Else
						aUTC := {{SA2->A2_COD+SA2->A2_LOJA}}
					EndIf

					For nX:=1 To Len(aUTC)

						//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
						//ณ Grava analise do produtor e de cada usuario de tanque do produtor corrente.      ณ
						//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

						dbSelectArea("SA2")
						dbSetOrder(1)
						dbSeek(xFILIAL("SA2")+SubStr(aUTC[nX][1],1,6)+SubStr(aUTC[nX][1],7,2))

						DbSelectArea("ZL3")
						DbSetOrder(1)
						DbSeek(xFilial("ZL3")+SA2->A2_L_LI_RO)

						//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
						//ณ Verifica se esta analise ja foi importada, caso afirmativo, altera os campos.  ณ
						//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
						dbSelectArea("ZLB")
						dbSetOrder(3)//ZLB_FILIAL+ZLB_SETOR+ZLB_RETIRO+ZLB_RETILJ+ZLB_TIPOFX+ZLB_DATA
						cSeek  := xFILIAL("ZLB")
						cSeek  += ZL3->ZL3_SETOR //"000001"
						cSeek  +=SA2->A2_COD
						cSeek  +=SA2->A2_LOJA
						cSeek  +=cAnaPro
						cSeek  +=cData
						If dbSeek(cSeek)
							If  cAtual
								RecLock("ZLB",.F.)
								ZLB->ZLB_FILIAL := xFILIAL("ZLB")
								ZLB->ZLB_SETOR  := ZL3->ZL3_SETOR //
								ZLB->ZLB_DCRSET := POSICIONE("ZL2",1,xFILIAL("ZL2")+ZL3->ZL3_SETOR,"ZL2_DESCRI")
								ZLB->ZLB_DATA   := STOD(cData)
								ZLB->ZLB_RETIRO := SA2->A2_COD
								ZLB->ZLB_RETILJ := SA2->A2_LOJA
								ZLB->ZLB_DCRRET := SA2->A2_NOME
								ZLB->ZLB_TIPOFX := cAnaPro
								ZLB->ZLB_DCRTPF := POSICIONE("ZL9",1,xFILIAL("ZL9")+cAnaPro,"ZL9_DESCRI")
								ZLB->ZLB_VLRANA := nVlrAna
								ZLB->ZLB_FILENT := "01" //U_GetFilEnt(SA2->A2_COD,SA2->A2_LOJA,STOD(cData))//Filial de entrega da linha do produtor
								ZLB->ZLB_CODLAB := cAnaArq
								ZLB->ZLB_LAUDO := Iif(Empty(MV_PAR05),SubStr(cData,3,6),MV_PAR05)
								ZLB->ZLB_DESQUA := "N"
								ZLB->ZLB_VLRDIN := u_getFaixa(xFILIAL("ZLA"),,cAnaPro,nVlrAna)
								ZLB->(MsUnlock())
								nAnal++

								If SA2->A2_COD <> _cCodCont
									nProd++
									_cCodCont := SA2->A2_COD
								EndIf

							Else
								//AADD(aLog,"Analise de "+cNomAna+" ja existente para esta data na propriedade "+cCodFaz+". Analise nao sera importada!"+"  Rota: "+cRota+cEOL+cEOL)
								AADD(aLog,"Analise de "+cNomAna+" ja existente para esta data na propriedade "+	SubStr(aUTC[nX][1],1,6)+SubStr(aUTC[nX][1],7,2)+". Analise nao sera importada!"+"  Rota: "+cRota+cEOL+cEOL)
							EndIf
						Else
							RecLock("ZLB",.T.)
							ZLB->ZLB_FILIAL := xFILIAL("ZLB")
							ZLB->ZLB_SETOR  := ZL3->ZL3_SETOR
							ZLB->ZLB_DCRSET := POSICIONE("ZL2",1,xFILIAL("ZL2")+ZL3->ZL3_SETOR,"ZL2_DESCRI")
							ZLB->ZLB_DATA   := STOD(cData)
							ZLB->ZLB_RETIRO := SA2->A2_COD
							ZLB->ZLB_RETILJ := SA2->A2_LOJA
							ZLB->ZLB_DCRRET := SA2->A2_NOME
							ZLB->ZLB_TIPOFX := cAnaPro
							ZLB->ZLB_DCRTPF := POSICIONE("ZL9",1,xFILIAL("ZL9")+cAnaPro,"ZL9_DESCRI")
							ZLB->ZLB_VLRANA := nVlrAna
							ZLB->ZLB_FILENT := "01" //U_GetFilEnt(SA2->A2_COD,SA2->A2_LOJA,STOD(cData))//Filial de entrega da linha do produtor
							ZLB->ZLB_CODLAB := cAnaArq
							ZLB->ZLB_LAUDO := Iif(Empty(MV_PAR05),SubStr(cData,3,6),MV_PAR05)
							ZLB->ZLB_DESQUA := "N"
							ZLB->ZLB_VLRDIN := u_getFaixa(xFILIAL("ZLA"),"000001",cAnaPro,nVlrAna)
							ZLB->(MsUnlock())
							nAnal++
							If SA2->A2_COD <> _cCodCont
								nProd++
								_cCodCont := SA2->A2_COD
							EndIf

						EndIf
					Next nX
			Else
				AADD(aLog,"A fazenda "+cCodFaz+" nao foi encontrada, consequentemente a analise deste produtor nao sera importada!"+cEOL+cEOL)
			EndIf
		EndIf
	Next nI

	AADD(aLog,cEOL+cEOL+"--- Fim da Opera็ใo ---"+cEOL)
	AADD(aLog,"Resumo da Importa็ใo: "+cEOL)
	AADD(aLog,"Finalizado em " + DTOC(date()) + ' ' + time() +cEOL)
	AADD(aLog,"Total de produtores no arquivo:" + cvaltochar(nProd)+cEOL )
	AADD(aLog,"Numero de Analises Importadas:" + cvaltochar(nAnal)+cEOL )
	AADD(aLog,"Periodo Importado:" + DTOC(MV_PAR03) + " a " + DTOC(MV_PAR04))

	End Transaction
	cLinha:=""
	For nY:=1 to Len(aLog)
		cLinha+=aLog[nY]
	Next

	If fWrite(nHdl,cLinha,Len(cLinha)) != Len(cLinha)
		If !MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?","Atencao!")
			Return
		Endif
	EndIf

	fClose(nHdl)

	If nHdl == -1
		MsgAlert("O arquivo de nome "+cArqTxt+" nao pode ser executado! Verifique os parametros.","Atencao!")
		Return
	Endif

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Tela de mensagem de confirmacao de registros processados.            ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	DEFINE FONT oFont NAME "Tahoma" BOLD
	DEFINE MSDIALOG oDlgMsn FROM  00,00 To 160,350 TITLE "Concluido" PIXEL
	@005,005 To 62,170
	@010,010 say "Operacao Concluida!" PIXEL OF oDlgMsn FONT oFont
	@022,010 say "Abra o arquivo para consultar o log do processamento: " PIXEL OF oDlgMsn
	@032,010 say Alltrim(cArqTxt) PIXEL OF oDlgMsn
	@040,010 say "Quantidade de produtores com analises: "+transform(nProd,"@E 999,999,999") PIXEL OF oDlgMsn
	@048,010 say "Total de analises importadas: "+transform(nAnal,"@E 999,999,999") PIXEL OF oDlgMsn
	TButton():New(060,030, ' Ok ', oDlgMsn,{|| close(oDlgMsn) },100,10,,,,.T.)
	ACTIVATE MSDIALOG oDlgMsn Centered

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ GetUTC   บ Autor ณ TOTVS              บ Data ณ  26/02/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Obtem produtores usuarios de tanque.                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa Principal.                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetUTC(cpPrd,dtCole)

	Local aRet  := {}
	Local aArea := GetArea()
	Local _cFiltro := "% A2_L_TANQ = '" + cpPrd + "' AND SUBSTRING(ZLD_DTCOLE,1,6) = '" + LEFT(dtCole,6) + "'  %"

	If (TcGetDB() == 'ORACLE')
		_cFiltro := "% A2_L_TANQ = '" + cpPrd + "'   %" //AND SUBSTR(ZLD_DTCOLE,1,6) = '" + LEFT(dtCole,6) + "'
	EndIf

	If Select("TRX") > 0
		dbSelectArea("TRX")
		TRX->(dbCloseArea())
	EndIf

	BeginSql alias "TRX"
		SELECT A2_COD,A2_LOJA
		FROM %Table:SA2% SA2

		WHERE %Exp:_cFiltro%
		AND SA2.%NotDel%
		GROUP BY A2_COD,A2_LOJA
	EndSql

	While TRX->(!Eof())
		AADD(aRet,{TRX->A2_COD+TRX->A2_LOJA})
		TRX->(dbSkip())
	EndDo

	TRX->(dbCloseArea())

	RestArea(aArea)
Return(aRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ Desclass บ Autor ณ TOTVS              บ Data ณ  09/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao usada para desclassificar as analises com problema. บฑฑ
ฑฑบ          ณ Somente as analises de CBT e CCS, tem o campo ZLB_DESQUA   บฑฑ
ฑฑบ          ณ atualizado durante a gravacao, no entanto caso este campo  บฑฑ
ฑฑบ          ณ seja igual a 'S', todas as outras analises tambem devem serบฑฑ
ฑฑบ          ณ atualizadas com 'S' ou seja desclassificadas.              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa Principal.                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Desclass(cAnoMes)

	Local cQuery := ""
	Local cUpdte := ""
	Local lSqlOk := .T.
	Local cDesql := ""
	Local nVLRCBT	:= GetMv("LT_VLRCBT")
	Local nVLRCCS	:= GetMv("LT_VLRCCS")
	Local cANACBT	:= GetMv("LT_ANACBT")
	Local cANACCS	:= GetMv("LT_ANACCS ")

	cQuery := "SELECT ZLB_SETOR, ZLB_RETIRO, ZLB_RETILJ, ZLB_TIPOFX, AVG(ZLB_VLRANA) AS MEDIA "
	cQuery += "FROM "+RetSqlName("ZLB")+" "
	cQuery += "WHERE D_E_L_E_T_ = ' ' "
	cQuery += "AND ZLB_FILIAL = '"+xFILIAL("ZLB")+"' "
	cQuery += "AND SUBSTRING(ZLB_DATA,1,6) = '"+cAnoMes+"' "
	If nVLRCBT > 0 .and. nVLRCCS > 0
		cQuery += "AND ZLB_TIPOFX IN('"+ALLTRIM(cANACBT)+"','"+ALLTRIM(cANACCS)+"') "
	Elseif nVLRCBT > 0
		cQuery += "AND ZLB_TIPOFX IN('"+ALLTRIM(cANACBT)+"') "
	Elseif nVLRCCS > 0
		cQuery += "AND ZLB_TIPOFX IN('"+ALLTRIM(cANACCS)+"') "
	Endif
	cQuery += "GROUP BY ZLB_SETOR, ZLB_RETIRO, ZLB_RETILJ, ZLB_TIPOFX "
	cQuery += "ORDER BY ZLB_SETOR, ZLB_RETIRO, ZLB_RETILJ, ZLB_TIPOFX "

	If Select("TRB") <> 0
		TRB->(dbCloseArea())
	EndIf
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRB", .T., .F. )

	dbSelectArea("TRB")
	dbGoTop()

	While !TRB->(Eof())

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Condicao para determinar a desclassificacao ou nao da analise.        ณ
		//ณ Quando o CBT ou CCS for maior que o valor do parametro desclassifica. ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

		If ALLTRIM(TRB->ZLB_TIPOFX) == ALLTRIM(cANACBT) .And. TRB->MEDIA > nVLRCBT .And. nVLRCBT > 0
			cDesql := 'S'
		ElseIf ALLTRIM(TRB->ZLB_TIPOFX) == ALLTRIM(cANACCS) .And. TRB->MEDIA > nVLRCCS .And. nVLRCCS > 0
			cDesql := 'S'
		Else
			cDesql := 'N'
		EndIf

		cUpdte := " UPDATE " + RetSqlName("ZLB")
		cUpdte += " SET ZLB_DESQUA = '"+cDesql+"' "
		cUpdte += " WHERE D_E_L_E_T_ = ' ' "
		cUpdte += " AND ZLB_FILIAL = '"+xFILIAL("ZLB")+"' "
		cUpdte += " AND SUBSTRING(ZLB_DATA,1,6) = '"+cAnoMes+"' "
		cUpdte += " AND ZLB_SETOR  = '000001'"
		cUpdte += " AND ZLB_TIPOFX  = '" + TRB->ZLB_TIPOFX + "'"
		cUpdte += " AND ZLB_RETIRO = '" + TRB->ZLB_RETIRO + "'"
		cUpdte += " AND ZLB_RETILJ = '" + TRB->ZLB_RETILJ + "'"
		lSqlOk := !(TCSqlExec(cUpdte) < 0)

		If !lSqlOk
			xMagHelpFis("UPDATE",;
			TcSqlError(),;
			"Nใo Conformidade ao executar o Update de atualiza็ใo dos produtores com anแlises desclassificadas "+;
			"Nใo confirme esta mensagem e informe ao Suporte T้cnico.")
		EndIf

		TRB->(dbSkip())
	EndDo
	TRB->(dbCloseArea())

Return
