#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#include "rwmake.ch"

#DEFINE _ENTER CHR(13)+CHR(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ MGLT031  บ Autor ณ Guilherme Fran็a      บ Data da Criacao  ณ 05/01/2015                						บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina de atualiza็ใo do valor de cota do leite. Realiza calculo conforme regras  e preenche        บฑฑ
ฑฑบ          ณ                        									                               				        บฑฑ
ฑฑบ          ณ o campo A2_L_VCOTA no cadastro dos produtores.                                                               บฑฑ
ฑฑบ          ณ                        									                               				        บฑฑ
ฑฑบ          ณ                        									                               				        บฑฑ
ฑฑบ          ณ                        									                               				        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Fechamento do Leite.            						                                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ Nenhum						   							                               						บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ Nenhum						  							                               						บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUsuario   ณ Microsiga                                                                                					บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบSetor     ณ Gestao do Leite.                                                                        						บฑฑ
ฑฑฬออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ            			          	ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                   						บฑฑ
ฑฑฬออออออออออัออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออัออออออออออออออออออออออออออออออออออัอออออออออออออนฑฑ
ฑฑบAutor     ณ Data     ณ Motivo da Alteracao  				               ณUsuario(Filial+Matricula+Nome)    ณSetor        บฑฑ
ฑฑบฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤบฑฑ
ฑฑบ          ณ          ณ                                                  ณ                                  ณ   	        บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑบ          ณ          ณ                    							   ณ                                  ณ 			บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑศออออออออออฯออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออออออออออออออออออออออออออออออฯอออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function MGLT031

Local oSay
Private _cPerg     := PADR("MGLT031",10)
Private _cProdDe   := ""
Private _cProdAte  := ""

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Chama a tela para preenchimento dos parametros.                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If !Pergunte(_cPerg,.T.)
	Return()
EndIf


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verifica se os parametros estao em branco.                          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If Empty(MV_PAR01) .or. Empty(MV_PAR02) .or. (MV_PAR01 > MV_PAR02)
	xMagHelpFis("PARAMETRO INVALIDO",;
	"Os parametros nใo foram preenchidos corretamente.",;
	"Confira o preenchimento das datas.")
	Return()
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verifica se o usuario tem permissao para executar a rotina de Acerto.ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู


dbSelectArea("ZLU")
dbSetOrder(1)
If dbSeek(xFilial("ZLU")+U_UCFG001(2))

	If ZLU->ZLU_ACERTO != "S"
		xMagHelpFis("USUARIO SEM PERMISSAO",;
		"Usuario sem permissao para executar esta rotina.",;
		"Acesse o m๓dulo Configurador e altere o usuแrio para ter acesso a esta rotina. Campo Acerto Leite.")
		Return()
	EndIf

Else

	xMagHelpFis("USUARIO LEITE",;
	"Usuario nใo encontrado no cadastro de Acessos GLT.",;
	"Acesse o m๓dulo Configurador e cadastre o usuแrio na rotina Acessos GLT.")
	Return()

EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Inicializa a tela de processamento.                          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cTexto := "Esta rotina tem o objetivo de efetuar o cแlculo da cota de leite dos produtores "+_ENTER
cTexto += " "+_ENTER
cTexto += "de acordo com o perํodo parametrizado pelo usuแrio."+_ENTER
cTexto += " "+_ENTER
cTexto += "O valor apurado serแ gravado no campo Cota Leite(A2_L_VCOTA) no cadastro "+_ENTER
cTexto += " "+_ENTER
cTexto += "dos produtores, e utilizado para calcular o evento  LEITE PLUS."+_ENTER


_nOpc := AVISO("Cota do Leite", cTexto, { "Continuar","Fechar"}, 2)

If _nOpc == 2
	Return
EndIf

FWMsgRun(, {|oSay| MGLT031Exec(oSay) },'Aguarde', 'Processando arquivo...')

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMGLT031   บAutor  ณMicrosiga           บ Data ณ  01/05/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MGLT031Exec(oSay)

Local _cfProdutor	:= "% '"+MV_PAR03+"' AND '"+MV_PAR04+"' %"
Local _nReg := 0
Local _nCont := 1
Local _nVolCota := 0
Local _cAlias := GetNextAlias()


BeginSql alias _cAlias
	SELECT A2_COD AS PRODUTOR, A2_LOJA AS LOJA, A2_NOME AS NOME FROM %Table:SA2% A2
	WHERE A2.A2_COD BETWEEN %Exp:_cfProdutor%
	AND A2.A2_L_TPFOR = 'P'
	AND A2.A2_MSBLQL <> '1'
	AND A2.%NOTDEL%
	GROUP BY A2_COD,A2_LOJA, A2_NOME
EndSql

DbSelectArea(_cAlias)
Count to _nReg

DbSelectArea(_cAlias)
(_cAlias)->(DbGoTop())


While !(_cAlias)->(Eof())

	oSay:cCaption := "Produtor "+AllTrim(Str(_nCont))+" de "+AllTrim(Str(_nReg))+" ("+AllTrim(str( round((_nCont/_nReg)*100,0) ))+"%) -> "+ (_cAlias)->PRODUTOR +(_cAlias)->LOJA +" - "+(_cAlias)->NOME
	ProcessMessages()


	_nVolCota := VLeiteCot((_cAlias)->PRODUTOR,(_cAlias)->LOJA)
	If _nVolCota > 0
		DbSelectArea("SA2")
		DBSetOrder(1)
		SA2->(MsSeek(xFilial("SA2")+(_cAlias)->PRODUTOR+(_cAlias)->LOJA))
		RecLock("SA2",.F.)
		SA2->A2_L_BKCOT := SA2->A2_L_VCOTA
		SA2->A2_L_VCOTA := _nVolCota
		SA2->A2_L_DTCOT := dDataBase
		SA2->(MsUnLock())
	EndIf
	_nCont++
	(_cAlias)->(DbSkip())
EndDo
(_cAlias)->(dbCloseArea())

If _nCont > 1
	MsgInfo("Processo finalizado!!! "+cValToChar(_nCont-1)+" cadastros atualizados!","Calculados")
Else
	MsgInfo("Nenhum cadastro foi atualizado!","Parโmetros")
EndIf

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMGLT031   บAutor  ณMicrosiga           บ Data ณ  01/05/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VLeiteCot(cProd,cLoja)

Local _aArea := GetArea()
Local nMes	  := 0
Local nSumLei := 0
Local nDias   := 0
Local _cfPerido	:= "% '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"' %"
Local _sDtIni := DTOS(MV_PAR01)
Local _sDtFim := DTOS(LastDay(MV_PAR02)) //_cAno+cDFCota
Local _dAuxI  := _dAuxF   := StoD(_sDtIni)
Local _aMes   := {}
Local _cAliZLD := GetNextAlias()
Local _iX		:= 0

// monta array com os meses do periodo da cota
_lOk := .T.
nX := 1
While _lOk
	_dAuxF := LastDay(_dAuxI)
	nDias := (_dAuxF - _dAuxI ) + 1
	aAdd(_aMes,{Left(DtoS(_dAuxI),6), nDias, 0 })

	_lOk := If(_dAuxF == StoD(_sDtFim),.F.,.T.)

	_dAuxI := _dAuxF + 1
EndDo

If (TcGetDB() == 'ORACLE')
	BeginSql alias _cAliZLD
		SELECT  SUBSTR(ZLD_DTCOLE,1,6) AS MES, SUM(ZLD_QTDBOM) AS QTDLEITE
		FROM %Table:ZLD% ZLD
		WHERE ZLD_FILIAL =  %xFilial:ZLD%
		AND ZLD_DTCOLE BETWEEN %Exp:_cfPerido%
		AND ZLD_RETIRO = %Exp:cProd%
		AND ZLD_RETILJ = %Exp:cLoja%
		AND ZLD.%NotDel%
		GROUP BY SUBSTR(ZLD_DTCOLE,1,6)
		ORDER BY 2
	EndSql
Else
	BeginSql alias _cAliZLD
		SELECT  SUBSTRING(ZLD_DTCOLE,1,6) AS MES, SUM(ZLD_QTDBOM) AS QTDLEITE
		FROM %Table:ZLD% ZLD
		WHERE ZLD_FILIAL =  %xFilial:ZLD%
		AND ZLD_DTCOLE BETWEEN %Exp:_cfPerido%
		AND ZLD_RETIRO = %Exp:cProd%
		AND ZLD_RETILJ = %Exp:cLoja%
		AND ZLD.%NotDel%
		GROUP BY SUBSTRING(ZLD_DTCOLE,1,6)
		ORDER BY 2
	EndSql
EndIf

dbSelectArea(_cAliZLD)
(_cAliZLD)->(dbGotop())

While !(_cAliZLD)->(Eof())
	_nPos := ASCAN(_aMes,{|x| ALLTRIM(x[1]) == (_cAliZLD)->MES })
    If _nPos > 0
    	_aMes[_nPos][3] := (_cAliZLD)->QTDLEITE
    EndIf

	(_cAliZLD)->(dbSkip())
EndDo

(_cAliZLD)->(dbCloseArea())

ASort(_aMes,,,{|x,y| x[3] < y[3] })
nDias := 0
For _iX := 1 to Len(_aMes)
	If _aMes[_iX][3] <> 0
		nSumLei += _aMes[_iX][3]
		nMes++
		nDias += _aMes[_iX][2]
	EndIf
Next _iX
//O sistema deve utilizar 153 dias quando o cooperado nao tiver coleta em 5 meses
_nRet := nSumLei/nDias
RestArea(_aArea)

Return Round(_nRet,2)