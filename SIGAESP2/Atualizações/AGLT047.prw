#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE 'FWMVCDEF.CH'
#INCLUDE "TBICONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAGLT047 บAutor  ณCleiton Campos/Guilherme Fran็a บ Data ณ  04/03/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Cแlcula pagamento de frete.                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
user function AGLT047(xOpc)

	Local _aArea := GetArea()
	Local bProcess
	Local oTProces
	Local _cTexto   := ""
	Local _cPerg    := "PAGLT047"
	Private _cEveQuebra := Alltrim(GetMv("LT_EVEQUEB"))

	If xOpc == "A"
		_cTexto := "O objetivo desta rotina ้ gerar os dados de fechamento dos carreteiros "
		_cTexto += "com base nos parโmetros informados."
		bProcess  := {|oSelf| AGL047Z(oSelf)}
	Else
		_cTexto := "O objetivo desta rotina ้ gerar os tํtulos de quebra de leite no financeiro, "
		_cTexto += "gerar custo para o produto leite no SD3 e efetivar o cแlculo realizado para pagamento ao carreteiro."
		bProcess  := {|oSelf| AGL047B(oSelf)}
	EndIf

	If xOpc == "A"

		If Pergunte(_cPerg, .T.)
			// Posiciona na tabela ZLE (Mix do leite)
			dbSelectArea("ZLE")
			ZLE->(dbSetOrder(1))
			If ZLE->(dbSeek(xFilial("ZLE") + MV_PAR01))
				ATUPRECO(_cEveQuebra)

				oTProces := tNewProcess():New("AGLT047","Fechamento Carreteiro",bProcess,_cTexto,_cPerg)
			Else
				xMagHelpFis("AGLT047","O c๓digo do mix nใo foi localizado.","Informe um c๓digo de mix existente.")
			EndIf
		EndIf
	Else
		Processa({|| AGL047B() })

	EndIf

	RestArea(_aArea)

return


Static Function AGL047Z(oObj)

Local _cAliasp    := GetNextAlias()
Local _nCont := 1
Local _nReg := 0

CriaTab(_cAliasp,0)
dbSelectArea(_cAliasp)
Count to _nReg
oObj:SetRegua1(_nReg)
oObj:SetRegua2(4)

(_cAliasp)->(dbGoTop())
While !(_cAliasp)->(Eof())
	oObj:IncRegua1("Carreteiro " +AllTrim(Str(_nCont))+" de "+AllTrim(Str(_nReg))+" ("+AllTrim(str( round((_nCont/_nReg)*100,0) ))+"%) -> " + (_cAliasp)->ZLD_FRETIS)

	DbSelectArea("ZM0")
	ZM0->(DbSetOrder(1))
	If ZM0->(DbSeek(xFilial("ZM0")+Alltrim(MV_PAR01)+(_cAliasp)->ZLD_FRETIS+(_cAliasp)->ZLD_LJFRET))

		(_cAliasp)->(dbSkip())
		Loop

	EndIf


	AGL047A(oObj,(_cAliasp)->ZLD_FRETIS,(_cAliasp)->ZLD_LJFRET)

	(_cAliasp)->(dbSkip())
	_nCont++
Enddo

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAGL047A บAutor  ณCleiton Campos        บ Data ณ  04/22/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Calcula pagamento de frete por KM ASFALTO, KM TERRA e por  บฑฑ
ฑฑบ          ณ litro de leite.                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AGL047A(oObj,xcCod,xcLoja)

	Local _cAlias    := GetNextAlias()
	Local _cAliasSE1 := ""
	Local _aCab      := {}
	Local _aItem     := {}
	Local _aItSE1    := {}
	Local _aAux      := {}
	Local _nItem     := 1
	Local _cCodAux	:= ""
	Local _cLojaAux := ""
	Local _nVlrQueb	:= 0
	Local _cRota1	:= ""
	Private _nTotLeite := 0
	Private _nQtdLeite := 0


	CriaTab(_cAlias,1,xcCod,xcLoja)
	dbSelectArea(_cAlias)

	(_cAlias)->(dbGoTop())
	While !(_cAlias)->(Eof())

		//Verifica se jแ existe cแlculo para o transportador.
		If _cRota1 <> (_cAlias)->ZLD_ROTCAB

			_cCodAux   := (_cAlias)->ZLD_FRETIS
			_cLojaAux  := (_cAlias)->ZLD_LJFRET
			_cRota1	:= (_cAlias)->ZLD_ROTCAB
			DbSelectArea("ZLW")
			ZLW->(DbSetOrder(1))
			ZLW->(DbSeek(xFilial("ZLW")+_cRota1))

			oObj:IncRegua2("Pagamento de frete por KM ASFALTO")
			// Pagamento de frete por KM ASFALTO
			_aTotKM := SomaKM((_cAlias)->ZLD_FRETIS,(_cAlias)->ZLD_LJFRET,_cRota1)
			If ZLW->ZLW_FRMPG $ 'K/A' .and. ZLW->ZLW_VLRKM > 0 .AND. _aTotKM[1] > 0
				_aAux := RetOcorr("0001", ZLW->ZLW_VLRKM, _aTotKM[1] , _cRota1, _nItem++)
				aAdd(_aItem, aClone(_aAux))
			EndIf

			oObj:IncRegua2("Pagamento do frete por KM TERRA")
			// Pagamento do frete por KM TERRA
			If ZLW->ZLW_FRMPG $ 'K/A' .and. ZLW->ZLW_VLRKMT > 0 .AND. _aTotKM[2]  > 0
				_aAux := RetOcorr("0002", ZLW->ZLW_VLRKMT, _aTotKM[2]*ZLW->ZLW_KMTERR , ZLW->ZLW_COD, _nItem++)
				aAdd(_aItem, aClone(_aAux))
			EndIf

			SomaTotBom( (_cAlias)->ZLD_FRETIS,(_cAlias)->ZLD_LJFRET )

			If Len(_aItem) < 1
				_aAux := RetOcorr("0003", 0, _nQtdLeite, _cRota1, _nItem++, _nQtdLeite)
				aAdd(_aItem, aClone(_aAux))
			EndIf

		EndIf

		(_cAlias)->(dbSkip())
	EndDo

	aAdd(_aCab, {'ZM0_MIX'   , MV_PAR01 })
	aAdd(_aCab, {'ZM0_CODSA2', _cCodAux})
	aAdd(_aCab, {'ZM0_LOJSA2', _cLojaAux})
	aAdd(_aCab, {'ZM0_TOTTRP', _nTotLeite})
	aAdd(_aCab, {'ZM0_TOTPRD', _nQtdLeite})


	If Len(_aCab) > 0

		oObj:IncRegua2("Seleciona tํtulos a receber")
		//Seleciona tํtulos a receber
		_cAliasSE1 := CriaSE1(_cCodAux, _cLojaAux, ZLE->ZLE_DTFIM)
		dbSelectArea(_cAliasSE1)
		_aAux := RetTit(_cAliasSE1)
		If Len(_aAux)>0
			//aAdd(_aItSE1, _aAux)
			_aItSE1 := _aAux
		EndIf
		// Calcula desconto por quebra de leite.
		// Se a quantidade de leite dos produtores for maior que a quantidade de leite
		// no caminhใo.
		If _nQtdLeite > _nTotLeite
			_nVlrQueb := IncQuebra(_nTotLeite, _nQtdLeite - _nTotLeite, _nItem++)
			If _nVlrQueb > 0
				_aAux := RetTit("",_nVlrQueb,RIGHT(_cCodAux,5)+RIGHT(MV_PAR01,4),ZLE->ZLE_DTFIM) //RIGHT(_cCodAux,5)+RIGHT(MV_PAR01,4) -> equivale ao numero do titulo  ser gerado
				If Len(_aAux)>0
					aAdd(_aItSE1, _aAux)
				EndIf
			EndIf
		EndIf
		xExecAuto(_aCab, _aItem, _aItSE1)
	EndIf

	_aCab	:= {}
	_nItem     := 1
	_aItem     := {}
	_aItSE1    := {}
	_nTotLeite := 0
	_nQtdLeite := 0

	(_cAlias)->(DbCloseArea())

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRetOcorr บAutor  ณCleiton Campos        บ Data ณ            บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Returna Array com ocorr๊ncias para pagamento de frete.     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RetOcorr(_pcOcorrencia, _pnVlr, _pnQtd, _pcLinha, _pnItem, _pnTorPrd)

	Local _aRetorno := {}

	Default _pnTorPrd := 0

	aAdd( _aRetorno, {'ZM1_ITEM'  , StrZero(_pnItem, 3)      })
	aAdd( _aRetorno, {'ZM1_OCORRE', _pcOcorrencia })
	aAdd( _aRetorno, {'ZM1_QTDADE', _pnQtd       })
	aAdd( _aRetorno, {'ZM1_VALOR' , _pnVlr       })
	aAdd( _aRetorno, {'ZM1_LINHA' , _pcLinha     })

Return(_aRetorno)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRetTit   บAutor  ณCleiton Campos        บ Data ณ            บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna tํtulos a receber.                                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RetTit(_pcAliasSE1,xnVlr,xcNum,xdDataFim)

	Local _aRetorno := {}
	Local _dDtVenc
	Local _aAux := {}

	If !Empty(_pcAliasSE1)
		(_pcAliasSE1)->(dbGoTop())
		While !(_pcAliasSE1)->(Eof())

			aAdd( _aAux, {'ZM2_EVENTO'  , (_pcAliasSE1)->E1_L_EVENT  })
			aAdd( _aAux, {'ZM2_PREFIX'  , (_pcAliasSE1)->E1_PREFIXO  })
			aAdd( _aAux, {'ZM2_NUMERO'  , (_pcAliasSE1)->E1_NUM      })
			aAdd( _aAux, {'ZM2_PARCEL'  , (_pcAliasSE1)->E1_PARCELA  })
			aAdd( _aAux, {'ZM2_TIPTIT'  , (_pcAliasSE1)->E1_TIPO     })
			aAdd( _aAux, {'ZM2_EMISSA'  , StoD((_pcAliasSE1)->E1_EMISSAO) })
			aAdd( _aAux, {'ZM2_DTVENC'  , StoD((_pcAliasSE1)->E1_VENCREA) })
			aAdd( _aAux, {'ZM2_VALOR'   , (_pcAliasSE1)->VALOR })

			(_pcAliasSE1)->(dbSkip())
			aAdd(_aRetorno, _aAux)

			_aAux := {}
		EndDo

		(_pcAliasSE1)->(dbCloseArea())
	Else

		_dDtVenc  := DaySum(xdDataFim, GetMv("LT_VNCCAR"))
		//Preenche grid com dados do tํtulo que serแ gerado no fechamento do frete
		DbSelectArea("ZL8")
		DbSetOrder(1)
		If DbSeek(xFilial("ZL8")+_cEveQuebra)
			aAdd( _aAux, {'ZM2_EVENTO'  , _cEveQuebra  })
			aAdd( _aAux, {'ZM2_PREFIX'  , ZL8->ZL8_PREFIX  })
			aAdd( _aAux, {'ZM2_NUMERO'  , xcNum      })
			aAdd( _aAux, {'ZM2_PARCEL'  , TamSX3("E1_PARCELA")[1]})
			aAdd( _aAux, {'ZM2_TIPTIT'  , "DP "     })
			aAdd( _aAux, {'ZM2_EMISSA'  , xdDataFim })
			aAdd( _aAux, {'ZM2_DTVENC'  , _dDtVenc })
			aAdd( _aAux, {'ZM2_VALOR'   , xnVlr })
			_aRetorno :=  _aAux
		EndIf
	EndIf

Return(_aRetorno)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaTab บAutor  ณCleiton Campos        บ Data ณ             บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Cria tabela temporแria para cแlculo do pagamento do frete. บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaTab(_cAlias,xnOpc,xcCod,xcLoja)


	If xnOpc == 0
			BeginSql Alias _cAlias

			SELECT ZLD_FILIAL,
			ZLD_FRETIS,
			ZLD_LJFRET
			FROM   (SELECT ZLD_FILIAL,
			ZLD_FRETIS,
			ZLD_LJFRET,
			ZLD_LINROT,
			ZLD_DTCOLE,
			ZLD_CODREC,
			ZLD_ROTCAB,
			Sum(ZLD_QTDBOM) AS ZLD_QTDBOM
			FROM   %Table:ZLD% ZLD
			WHERE  ZLD_FILIAL = %xFilial:ZLD%
			AND   ZLD_DTCOLE BETWEEN %Exp:DtoS(ZLE->ZLE_DTINI)% AND %Exp:DtoS(ZLE->ZLE_DTFIM)%
			AND   ZLD_FRETIS BETWEEN %Exp:MV_PAR02%         AND %Exp:MV_PAR04%
			AND   ZLD_LJFRET BETWEEN %Exp:MV_PAR03%         AND %Exp:MV_PAR05%
			AND ZLD.%NotDel%
			GROUP  BY ZLD_FILIAL,
			ZLD_FRETIS,
			ZLD_LJFRET,
			ZLD_LINROT,
			ZLD_DTCOLE,
			ZLD_ROTCAB,
			ZLD_CODREC
			) A
			GROUP  BY ZLD_FILIAL,
			ZLD_FRETIS,
			ZLD_LJFRET
			ORDER BY ZLD_FRETIS, ZLD_LJFRET

		EndSql


	ElseIf xnOpc == 1
		BeginSql Alias _cAlias

			SELECT ZLD_FILIAL,
			ZLD_FRETIS,
			ZLD_LJFRET,
			ZLD_ROTCAB,
			Sum(ZLD_QTDBOM) ZLD_QTDBOM
			FROM   (SELECT ZLD_FILIAL,
			ZLD_FRETIS,
			ZLD_LJFRET,
			ZLD_ROTCAB,
			ZLD_DTCOLE,
			ZLD_CODREC,
			Sum(ZLD_QTDBOM) AS ZLD_QTDBOM
			FROM   %Table:ZLD% ZLD
			WHERE  ZLD_FILIAL = %xFilial:ZLD%
			AND   ZLD_DTCOLE BETWEEN %Exp:DtoS(ZLE->ZLE_DTINI)% AND %Exp:DtoS(ZLE->ZLE_DTFIM)%
			AND   ZLD_FRETIS = %Exp:xcCod%
			AND   ZLD_LJFRET = %Exp:xcLoja%
			AND ZLD.%NotDel%
			GROUP  BY ZLD_FILIAL,
			ZLD_FRETIS,
			ZLD_LJFRET,
			ZLD_ROTCAB,
			ZLD_DTCOLE,
			ZLD_CODREC
			) A
			GROUP  BY ZLD_FILIAL,
			ZLD_FRETIS,
			ZLD_LJFRET,
			ZLD_ROTCAB
			ORDER BY  ZLD_QTDBOM DESC, ZLD_ROTCAB, ZLD_FRETIS,
			ZLD_LJFRET

		EndSql
	Else
		BeginSql alias _cAlias
			SELECT * FROM %Table:ZM2% M2
			WHERE ZM2_FILIAL = %xFilial:ZM2%
			AND ZM2_MIX = %Exp:MV_PAR01%
			AND ZM2_CODSA2 = %Exp:MV_PAR02%
			AND ZM2_LOJSA2 = %Exp:MV_PAR03%
			AND ZM2_EVENTO = %Exp:_cEveQuebra%
			AND M2.%NotDel%
		EndSql

	EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณSomaKM บAutor  ณGuilherme Fran็a        บ Data ณ             บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Soma km apontado nos tickets do transportador บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function SomaKM(xcCodigo,xcLoja,xcRota)

	Local _aRet := {}
	Local _nCont := 0

	If Select("TOTKM") <> 0
		TOTKM->(DbCloseArea())
	EndIf

	BeginSql alias "TOTKM"
		SELECT	DISTINCT ZLD_TICKET, ZLD_KM
		FROM   %Table:ZLD% ZLD
		WHERE  ZLD_FILIAL = %xFilial:ZLD%
		AND   ZLD_DTCOLE BETWEEN %Exp:DtoS(ZLE->ZLE_DTINI)% AND %Exp:DtoS(ZLE->ZLE_DTFIM)%
		AND   ZLD_FRETIS = %Exp:xcCodigo%
		AND   ZLD_LJFRET = %Exp:xcLoja%
		AND   ZLD_ROTCAB = %Exp:xcRota%
		AND ZLD.%NotDel%
	EndSql

	DbSelectArea("TOTKM")
	While !TOTKM->(Eof())
		_nCont += TOTKM->ZLD_KM
		TOTKM->(DbSkip())
	EndDo

	TOTKM->(DbCloseArea())

	AADD(_aRet,_nCont)
	AADD(_aRet,0)

Return _aRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณSomaTotBom บAutor  ณGuilherme Fran็a        บ Data ณ             บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Soma km apontado nos tickets do transportador บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function SomaTotBom(xcCodigo,xcLoja)

	_nTotLeite := 0
	_nQtdLeite := 0


	If Select("TOTBOM") <> 0
		TOTBOM->(DbCloseArea())
	EndIf

	BeginSql alias "TOTBOM"
		SELECT SUM(ZLD_TOTBOM) AS QTDBOM, SUM(QTDPRD) AS QTDPRD FROM (
		SELECT	ZLD_FILIAL,
		ZLD_FRETIS,
		ZLD_LJFRET,
		ZLD_CODREC,
		ZLD_TOTBOM,
		SUM(ZLD_QTDBOM) AS QTDPRD
		FROM   %Table:ZLD% ZLD
		WHERE  ZLD_FILIAL = %xFilial:ZLD%
		AND   ZLD_DTCOLE BETWEEN %Exp:DtoS(ZLE->ZLE_DTINI)% AND %Exp:DtoS(ZLE->ZLE_DTFIM)%
		AND   ZLD_FRETIS = %Exp:xcCodigo%
		AND   ZLD_LJFRET = %Exp:xcLoja%
		AND ZLD.%NotDel%
		GROUP BY ZLD_FILIAL, ZLD_FRETIS, ZLD_LJFRET,ZLD_CODREC, ZLD_TOTBOM) A
	EndSql

	If !TOTBOM->(Eof())
		_nTotLeite := TOTBOM->QTDBOM
		_nQtdLeite := TOTBOM->QTDPRD

	EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณxExecAutoบAutor  ณCleiton Campos       บ Data ณ             บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Cria tabela temporแria para cแlculo do pagamento do frete. บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function xExecAuto(_paCabecalho, _paOcorr, _paSE1)

	Local oModel  := FwLoadModel("AGLT046")
	Local _iCab   := 0
	Local _iOcorr := 0
	Local _iSE1   := 0
	Local _i      := 0

	oModel:SetOperation(3) // inclusใo.

	oModel:Activate() // Ativa o modelo.

	//Preenche cabe็alho do modelo.
	For _iCab := 1 to Len(_paCabecalho)
		oModel:GetModel('ID_M_FLD_ZM0'):SetValue(_paCabecalho[_iCab][1]	, _paCabecalho[_iCab][2] )
	Next _iCab

	//Preenche grid de ocorrencias.
	For _iOcorr := 1 to Len(_paOcorr)

		If _iOcorr > 1
			oModel:GetModel('ID_M_GRD_ZM1'):AddLine()
		EndIf

		For _i := 1 to Len(_paOcorr[_iOcorr])

			oModel:SetValue('ID_M_GRD_ZM1', _paOcorr[_iOcorr][_i][1]	, _paOcorr[_iOcorr][_i][2]  )

		Next _i

	Next _iOcorr

	//Preenche grid de titulos a receber
	For _iSE1 := 1 to Len(_paSE1)

		If _iSE1 > 1
			oModel:GetModel('ID_M_GRD_ZM2'):AddLine()
		EndIf

		For _i := 1 to Len(_paSE1[_iSE1])

			If !Empty(_paSE1[_iSE1][_i][1])
				oModel:SetValue('ID_M_GRD_ZM2', _paSE1[_iSE1][_i][1]	, _paSE1[_iSE1][_i][2]  )
			EndIf
		Next _i

	Next _iSE1

	If Len(_paOcorr) > 0 .or. Len(_paSE1) > 0
		If oModel:VldData()

			oModel:CommitData()

		Else

			_lExecAuto := .F.

			aErro := oModel:GetErrorMessage()

			AutoGrLog( "Id do formulแrio de origem:"	+ ' [' + AllToChar( aErro[1] ) + ']' )
			AutoGrLog( "Id do campo de origem: " 		+ ' [' + AllToChar( aErro[2] ) + ']' )
			AutoGrLog( "Id do formulแrio de erro: " 	+ ' [' + AllToChar( aErro[3] ) + ']' )
			AutoGrLog( "Id do campo de erro:  " 		+ ' [' + AllToChar( aErro[4] ) + ']' )
			AutoGrLog( "Id do erro: " 					+ ' [' + AllToChar( aErro[5] ) + ']' )
			AutoGrLog( "Mensagem do erro: " 			+ ' [' + AllToChar( aErro[6] ) + ']' )
			AutoGrLog( "Mensagem da solu็ใo: " 			+ ' [' + AllToChar( aErro[7] ) + ']' )
			AutoGrLog( "Valor atribuํdo: " 				+ ' [' + AllToChar( aErro[8] ) + ']' )
			AutoGrLog( "Valor anterior: " 				+ ' [' + AllToChar( aErro[9] ) + ']' )

			MostraErro()

		EndIf

	EndIf

	oModel:DeActivate()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณxTesteบAutor  ณCleiton Campos       บ Data ณ             บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Cria tabela temporแria para cแlculo do pagamento do frete. บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function xTeste()

	Local _aCab  := {}
	Local _aItem := {}
	Local _aAux  := {}

	aAdd(_aCab, {'ZM0_MIX'   , "000005" })
	aAdd(_aCab, {'ZM0_CODSA2', "T00001" })
	aAdd(_aCab, {'ZM0_LOJSA2', "01"})

	aAdd( _aAux, {'ZM1_ITEM'  , StrZero(1, 3)      })
	aAdd( _aAux, {'ZM1_OCORRE', "0001" })
	aAdd( _aAux, {'ZM1_QTDADE', 200       })
	aAdd( _aAux, {'ZM1_VALOR' , 1.3       })

	aAdd(_aItem, aClone(_aAux))

	_aAux := {}
	aAdd( _aAux, {'ZM1_ITEM'  , StrZero(2, 3)      })
	aAdd( _aAux, {'ZM1_OCORRE', "0002" })
	aAdd( _aAux, {'ZM1_QTDADE', 100       })
	aAdd( _aAux, {'ZM1_VALOR' , 1.3       })

	aAdd(_aItem, aClone(_aAux))

	xExecAuto(_aCab, _aItem)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณIncQuebraบAutor  ณCleiton Campos       บ Data ณ             บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Inclui cobran็a por quebra de leite.                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function IncQuebra(_pnQtdLt, _pnQuebra, _pnItem)

	Local _nPercTl  := SuperGetMv("LT_PERCQB", .F. , 0.3)  // Percentual de tolerโncia.
	Local _cEveQuebra := Alltrim(GetMv("LT_EVEQUEB"))
	Local _nPerQb   := 0
	Local _nQtdCob  := 0
	Local _nQtdTol  := 0   // Quantidade da tolerโncia.
	Local _nVlrMed  := Posicione("ZL8",1,xFilial("ZL8") + _cEveQuebra,"ZL8_VALOR") // Valor m้dio do litro de leite. (criar fun็ใo para retornar essa informa็ใo.)
	Local _nRet := 0

	// Calcula o percentual da quebra
	_nPerQb := Round(( _pnQuebra / _pnQtdLt )*100 , 2)

	//Se o percnetual de quebra for maior que o percentual de tolerโncia
	If _nPerQb > _nPercTl

		//Calcula a quantidade tolerada para a quebra de leite
		//multiplicando a quantidade de leite transporatda pelo percentual
		//de tolerโncia de quebra.
		_nQtdTol := Int(_pnQtdLt * (_nPercTl/100) )

		//Calcula a quantidade de litros de leite que serแ cobrada do carreteiro.
		//Serแ cobrado do carreteiro somente a quantidade que exceder o limite de tolerโncia.
		//Aqui a quantidade tolerada ้ subtraida da quantidade total da quebra.
		If _pnQuebra > _nQtdTol
			_nQtdCob := Int(_pnQuebra - _nQtdTol)
			_nRet := _nQtdCob * _nVlrMed
			//_aRetorno := RetOcorr("0004", _nVlrMed, _nQtdCob, "999999", _pnItem)
		EndIf

	EndIf

Return _nRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaSE1บAutor  ณCleiton Campos       บ Data ณ               บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Seleciona os tํtulos a receber em aberto para o carreteiro.บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaSE1(_pcCliente, _pcLoja, _pdDtFim)

	Local _cAliasSE1 := GetNextAlias()
	Local _dDataFim  := DaySum(_pdDtFim, GetMv("LT_VNCCAR"))

	_dDataFim := DtoS(_dDataFim)

	BeginSql Alias _cAliasSE1

		SELECT E1_FILIAL,  E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO , E1_CLIENTE, E1_LOJA,
		E1_L_EVENT, E1_EMISSAO, E1_VENCREA,
		(E1_SALDO + E1_SDACRES - E1_SDDECRE) AS VALOR

		FROM %Table:SE1% SE1

		JOIN %Table:SA1% SA1
		ON   A1_FILIAL  = %xFilial:SA1%
		AND  A1_COD     = E1_CLIENTE
		AND  A1_LOJA    = E1_LOJA
		AND SA1.%NotDel%

		WHERE E1_FILIAL  =  %xFilial:SE1%
		AND   E1_CLIENTE =  %Exp:_pcCliente%
		AND   E1_LOJA    =  %Exp:_pcLoja%
		AND   E1_VENCREA <= %Exp:_dDataFim%
		AND   E1_VENCREA > '20171101'
		AND   E1_SALDO > 0
		AND   SE1.%NotDel%

	EndSql


Return(_cAliasSE1)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAGL047B บAutor  ณGuilherme Fran็a      บ Data ณ  19/10/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gera titulos financeiros de desconto da quebra do leite.   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AGL047B(oObj)

	Local _cEveQuebra := Alltrim(GetMv("LT_EVEQUEB"))
	Local _lRet := .t.
	Local _nQtdtit := 0

	If Empty(ZM0->ZM0_CTE)
		Alert("Obrigat๓rio informar o n๚mero do CTE antes da efetivaro cแlculo!","CTE nใo informado")
		Return
	EndIf

	Begin Transaction


		DbSelectArea("ZM2")
		DbSetOrder(1)
		If ZM2->(DbSeek(xFilial("ZM2")+ZM0->ZM0_MIX+ZM0->ZM0_CODSA2+ZM0->ZM0_LOJSA2))

			While !ZM2->(Eof()) .and. ZM2->ZM2_MIX == ZM0->ZM0_MIX .and. ZM2->ZM2_CODSA2 == ZM0->ZM0_CODSA2 .and. ZM2->ZM2_LOJSA2 == ZM0->ZM0_LOJSA2
				If ZM2->ZM2_EVENTO == _cEveQuebra
					DbSelectArea("SE1")
					DbSetOrder(1)
					If !SE1->(dbSeek(xFILIAL("SE1")+ZM2->ZM2_PREFIX+ZM2->ZM2_NUMERO+ZM2->ZM2_PARCEL+ZM2->ZM2_TIPTIT))

						DbSelectArea("ZL8")
						DbSetOrder(1)
						DbSeek(xFilial("ZL8")+_cEveQuebra)

						_lRet := U_IncluSE1(ZM2->ZM2_PREFIX,ZM2->ZM2_NUMERO,ZM2->ZM2_PARCEL,ZM2->ZM2_TIPTIT,ZM2->ZM2_CODSA2,ZM2->ZM2_LOJSA2,;
						ZL8->ZL8_NATPRD,ZM2->ZM2_EMISSA,ZM2->ZM2_DTVENC,ZM2->ZM2_VALOR,0,0,"",ZM2->ZM2_DESCRI,0,_cEveQuebra,"AGLT046","")
					EndIf
				EndIf
				_nQtdtit++
				ZM2->(DbSkip())
			EndDo
		EndIf

		If _lRet
			_lRet := GeraCusto()

		EndIf

		If _lRet
			DbSelectArea("ZM0")
			RecLock("ZM0",.F.)
			ZM0->ZM0_STATUS := "F"
			ZM0->(MsUnLock())
		Else
			DisarmTransaction()
			Alert("Ocorreram erros que impediram a efetiva็ใo do frete, comunique o suporte","Falha na efetiva็ใo")
		EndIf

	End Transaction
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณgerMi        บ Autor ณ Abrahao P. Santos     บ Data da Criacao  ณ 05/01/2009             						บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Gera Movi.Interno do Ticket                                                             						บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                                   											บฑฑ
ฑฑบ          ณ 	 							                                                                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                                                                                        						บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ Nenhum					                                                                                  	บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUsuario   ณ															                             						บฑฑ
ฑฑฬออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบSetor     ณ Gestao do Leite	                                                                       						บฑฑ
ฑฑฬออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ            						ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL                   						บฑฑ
ฑฑฬออออออออออัออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออัออออออออออออออออออออออออออออออออออัอออออออออออออนฑฑ
ฑฑบAutor     ณ Data     ณ Motivo da Alteracao  				               ณUsuario(Filial+Matricula+Nome)    ณSetor        บฑฑ
ฑฑฬฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤนฑฑ
ฑฑบ          ณ          ณ                    							   ณ                                  ณ 			บฑฑ
ฑฑศออออออออออฯออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออออออออออออออออออออออออออออออฯอออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GeraCusto()

	Local _aAutoSD3 := {}
	Local cTm := getmv("LT_FRETETM")
	Local cProduto := getmv("LT_PRTRIBU")
	Local cSetor := SuperGetMv("LT_CODSETO",.f.,"000001")
	Local _cArmaz	:=	POSICIONE("ZL2",1,XFILIAL("ZL2")+cSetor,"ZL2_LOCAL")
	Local _nVlrCusto :=	0
	Local _lRet := .t.
	Local _cCTE := GetNextAlias()


	BeginSql alias _cCTE
		SELECT D1_CUSTO FROM %Table:SD1% SD1
		WHERE D1_FILIAL = %xFilial:SD1%
		AND D1_COD = '55010157'
		AND D1_DOC = %Exp:ZM0->ZM0_CTE%
		AND D1_FORNECE = %Exp:ZM0->ZM0_CODSA2%
		AND D1_LOJA = %Exp:ZM0->ZM0_LOJSA2%
		AND D1_EMISSAO >= %Exp:DTOS(dDataBase)%
		AND SD1.%NotDel%
	EndSql

	If !(_cCTE)->(Eof())
		_nVlrCusto	:= (_cCTE)->D1_CUSTO
	EndIf
	(_cCTE)->(DbCloseArea())

	//Posiciona no cadastro de Produtos
	dbSelectArea("SB1")
	SB1->(dbSetOrder(1))
	If !SB1->(dbSeek(xFilial("SB1") + cProduto ))

		xMagHelpFis("INFORMAวรO",;
		"O produto: " + _cCodProd + " nใo consta na tabela de produtos.",;
		"Favor comunicar ao departamento de informแtica do problema encontrada, pois desta forma nใo serแ possํvel concluir a opera็ใo")
		Return .F.

	EndIf

	If _nVlrCusto > 0
		//Posiciona na tabela de Saldos em Estoque
		//Se nao encontrar o produto na tabela de saldos,
		//inclui saldo inicial para o produto.
		dbSelectArea("SB2")
		SB2->(dbSetOrder(1))
		If !SB2->(dbSeek(xFILIAL("SB2") + SB1->B1_COD + _cArmaz))
			CriaSB2(SB1->B1_COD,_cArmaz)
		EndIf


		AAdd( _aAutoSD3,{"D3_FILIAL"    , XFILIAL("SD3")	, nil } )	// Alterado para definir a filial do movimento	: Obrigatorio
		AAdd( _aAutoSD3,{"D3_TM"		, cTm 				, nil } )	// Tipo do Movimento Interno	: Obrigatorio
		AAdd( _aAutoSD3,{"D3_COD"		, SB1->B1_COD			, nil } )	// Codigo do Produto			: Obrigatorio
		AAdd( _aAutoSD3,{"D3_UM"		, SB1->B1_UM				, nil } )	// Unidade de Medida			: Obrigatorio
		AAdd( _aAutoSD3,{"D3_QUANT"	    , 0      	, nil } )	// Quantidade de Leite
		AAdd( _aAutoSD3,{"D3_LOCAL"	    , _cArmaz, nil } )	// Almoxarifado					: Obrigatorio
		AAdd( _aAutoSD3,{"D3_EMISSAO"	, ZM0->ZM0_DATFIM	, nil } )	// Data de Emissao				: Obrigatorio
		AAdd( _aAutoSD3,{"D3_DOC"	    , ZM0->ZM0_CTE, nil } )	// Documento
		AAdd( _aAutoSD3,{"D3_CUSTO1"	, _nVlrCusto	, nil } )	// Custo (na Moeda 1)
		AAdd( _aAutoSD3,{"D3_L_ORIG"	, ZM0->ZM0_MIX+ZM0->ZM0_CODSA2		, nil } )	// Origem do documento - ticket
		AAdd( _aAutoSD3,{"D3_L_SETOR"	, cSetor		, nil } )	// Setor

		lMsErroAuto := .F.
		Pergunte("MTA240",.F.) // Chama perguntas da rotina para evitar erros no Sigaauto
		MSExecAuto({|x,y| Mata240(x,y)},_aAutoSD3,3)
		If lMsErroAuto
			mostraerro()
			xmaghelpfis("Erro","Erro ao gerar movimento de custo SD3!","Tente novamente, se o erro persistir comunique urgentemente ao Suporte!")
			_lRet := .f.
		Endif
	Else
		_lRet := .f.
		xmaghelpfis("Erro","Erro ao gerar movimento de custo SD3!","O CTE do transportador pode nใo ter sido localizado, confirme o n๚mero!")
	EndIf

return _lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณ ATUPRECOบ Autor ณ Microsiga          บ Data ณ  00/00/00   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Atualiza็ใo do pre็o cobrado na quebra do transportador.   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ATUPRECO(xcEvento)

	Local oGetVlr
	Local oFont1 := TFont():New("MS Sans Serif",,016,,.T.,,,,,.F.,.F.)
	Local oSay1
	Local oSButton1
	Local _cEvento := xcEvento
	Local nVlr := 0
	Static oDlg

	DbSelectArea("ZL8")
	DbSetOrder(1)
	DbSeek(xFilial("ZL8")+_cEvento)

	nVlr := ZL8->ZL8_VALOR


	DEFINE MSDIALOG oDlg TITLE "Pre็o quebra transportador" FROM 000, 000  TO 150, 500 COLORS 0, 16777215 PIXEL
	@ 009, 005 SAY oSay1 PROMPT "Confirma pre็o m้dio da quebra de leite?" SIZE 200, 009 OF oDlg FONT oFont1 COLORS 0, 16777215 PIXEL
	@ 024, 013 SAY oSay1 PROMPT "Valor: " SIZE 041, 009 OF oDlg FONT oFont1 COLORS 0, 16777215 PIXEL
	@ 024, 060 MSGET oGetVlr VAR nVlr SIZE 050, 010 OF oDlg PICTURE "@E 999,999.9999" COLORS 0, 16777215 PIXEL

	//DEFINE SBUTTON oSButton1 FROM 35, 080 TYPE 01 OF oDlg ENABLE ACTION {|| ConfirmZL8(_cEvento,nVlr), oDlg:End()}
	@ 43,65 BUTTON oSButton1 PROMPT "Confirmar" SIZE 048, 014 OF oDlg  ACTION {|| ConfirmZL8(_cEvento,nVlr), oDlg:End()} PIXEL
	ACTIVATE MSDIALOG oDlg CENTERED

Return nVlr


Static Function ConfirmZL8(_xcCod,xnVlr)

	DbSelectArea("ZL8")
	DbSetOrder(1)
	If DbSeek(xFilial("ZL8")+_xcCod)

		RecLock("ZL8",.F.)
		ZL8->ZL8_VALOR := xnVlr
		MsUnlock()

	EndIf

Return
