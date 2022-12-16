#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ MGLT022  บ Autor ณ TOTVS                 บ Data da Criacao  ณ 16/06/2010                						บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Realiza integra็ใo com Coletor de Daodos. Esta rotina lerah os dados gravados nas tabelas criadas e          บฑฑ
ฑฑบ          ณ alimentadas pelos coletores(rotina dos coletores)                                    				        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Integracao com coletores de dados                                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                                                                                      						บฑฑ
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
ฑฑบ          ณ          ณ                                                  ณ                                  ณ   	        บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑบ          ณ          ณ                    							   ณ                                  ณ 			บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑศออออออออออฯออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออออออออออออออออออออออออออออออฯอออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
user function MGLT022()
Private cPerg := "MGLT022"

if !Pergunte(cPerg,.T.)
	return
endif

//Chama funcao para gerar txt
Processa( {|lEnd| ImpDados(@lEnd)},"Aguarde","Importando dados...",.T.)

return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImpDados  บAutor  ณMicrosiga           บ Data ณ  03/04/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao responsavel por gerar arquivo txt com informacoes daบฑฑ
ฑฑบ          ณ notas fiscais emitidas para produtores                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Envio de arquivo para AF                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function ImpDados(lEnd)
local aAreaZL2 := ZL2->(getArea())
local aAreaZL3 := ZL3->(getArea())
local aAreaSA2 := SA2->(getArea())
local lErro := .F.
local aMovInternos := {} //Armazena os valores para gerar movimentacao interna {cFilial,cTicket,nTotBom}
Local i		:= 0

//Verifica parametros para criar filtros
cFiltro := "%"
//Filtra Data Recebimento
if !empty(mv_par01) .and. !empty(mv_par02)
	cFiltro += " AND ZX1.ZX1_DATA BETWEEN '" + dtos(mv_par01) + "' AND '" + dtos(mv_par02) + "' "
endif


cFiltro += "%"


cAlias := "TRBCOL"

if Select(cAlias) > 0
	dbSelectArea(cAlias)
	cAlias->(dbCloseArea())
endif

//Busca Notas Fiscais
BeginSql alias cAlias
	SELECT
		ZX1.ZX1_DATA,ZX1.ZX1_HORA,ZX1.ZX1_FAZEND,ZX1.ZX1_CAMINH,ZX1.ZX1_VIAGEM,SA2.A2_L_LI_RO,
		SUM(ZX1.ZX1_QUANT) AS ZX1_QUANT
	FROM
		%table:ZX1% ZX1
		JOIN %table:SA2% SA2 ON SA2.A2_L_IDFAZ = ZX1.ZX1_FAZEND
	WHERE
		ZX1.%notDel% AND ZX1.ZX1_FILIAL  = %xFilial:ZX1%
		AND SA2.%notDel% AND SA2.A2_FILIAL  = %xFilial:SA2%
		AND ZX1_IMPZLD <> 'S'
		%Exp:cFiltro%
	GROUP BY
		ZX1.ZX1_DATA,ZX1.ZX1_HORA,ZX1.ZX1_FAZEND,ZX1.ZX1_CAMINH,SA2.A2_L_LI_RO,ZX1.ZX1_VIAGEM
	ORDER BY
		ZX1.ZX1_DATA,ZX1.ZX1_CAMINH,ZX1.ZX1_VIAGEM,SA2.A2_L_LI_RO
EndSql

dbSelectArea("TRBCOL")
nReg := 0
Count To nReg
ProcRegua(nReg)
dbGoTop()

BEGIN TRANSACTION
//Grava Recepcao na ZLD

cAux := " "
cLinhaAux := " "


while TRBCOL->(!eof())

	incProc()

	//Posiciona no Cadastro de Fazenda
	dbSelectArea("SZ0")
	dbSetOrder(1)//Filial + Cod. Fazenda
	dbSeek(xFILIAL("SZ0")+TRBCOL->ZX1_FAZEND)

	//Posiciona no Cadastro de Fornecedor/Produtor
	dbSelectArea("SA2")
	dbOrderNickName("GLT_SA2002")//Busca Produtor pelo codigo da fazenda
	//dbOrderNickName("GLT_SA2001")//Busca Produtor pelo codigo antigo


	if empty(TRBCOL->ZX1_FAZEND)
			xMagHelpFis("Fazenda","Encontrado registro nos dados do coletor com fazenda em branco.","Favor verificar com administrador do sistema")

		//loop
		msgAlert("O processo serแ abortado.", "Aten็ใo!")

		lErro := .T.
		exit
	endif

	//Se caso nao encontrar produtor amarrado retorna msg de help e passa pro proximo no loop
	If !dbSeek(xFILIAL("SA2")+TRBCOL->ZX1_FAZEND)
		//If !dbSeek(xFILIAL("SA2")+SZ0->Z0_FORNECE+SZ0->Z0_LOJA)
		xMagHelpFis("Produtor",;
		"O produtor "+SZ0->Z0_FORNECE+"-"+SZ0->Z0_LOJA+" nao foi encontrado, consequentemente seus lancamentos nao serao importados!",;
		"Verifique se o codigo desse produtor existe no cadastro de produtores, no campo Codigo Antigo.")

		//loop
		msgAlert("O processo serแ abortado. Favor cadastrar fornecedor vinculado เ fazenda: " + TRBCOL->ZX1_FAZEND + ".", "Aten็ใo!")

		lErro := .T.
		exit

	EndIf

	if !SA2->A2_L_TPFOR $ "P/G/T"  //#LETRAS
	xMagHelpFis("Produtor",;
		"O produtor "+SZ0->Z0_FORNECE+"-"+SZ0->Z0_LOJA+" nao foi encontrado, consequentemente seus lancamentos nao serao importados!",;
		"Verifique se o codigo desse produtor existe no cadastro de produtores, no campo Codigo Antigo.")

		//loop
		msgAlert("O processo serแ abortado. Favor cadastrar fornecedor vinculado เ fazenda: " + TRBCOL->ZX1_FAZEND + ".", "Aten็ใo!")

		lErro := .T.
		exit

	endif

	//Posiciona na ZL3 - Linha Rota para buscar fretista
	dbSelectArea("ZL3")
	dbSetOrder(1)
	dbSeek(xFilial("ZL3")+SA2->A2_L_LI_RO + SA2->A2_L_TP_LR)


	//Tenta posicionar no Veiculo atraves do codigo antigo do veiculo
	dbSelectArea("ZL4")
	dbSetOrder(4)
	if dbSeek(xFilial("ZL4")+TRBCOL->ZX1_CAMINH)
	else
		//Posiciona na ZL4 - Veiculo
		dbSelectArea("ZL4")
		dbSetOrder(1)
		dbSeek(xFilial("ZL4")+ZL3->ZL3_VEICUL)
	endif



	//Alimenta Variaveis
	cRetiro 	:= SA2->A2_COD
	cRetLj		:= SA2->A2_LOJA
	cFilEntr	:= U_GetFilEnt(cRetiro,cRetLj,Stod(TRBCOL->ZX1_DATA)) //Filial de entrega do leite --- serve para gerar movimentacao interna do estoque na filial apontada neste campo
	if empty(cFilEntr)
			xMagHelpFis("Produtor",;
		"O produtor "+SA2->A2_COD+"-"+SA2->A2_LOJA+" nao tem uma filial de entrega relacionada!",;
		"Por favor Verifique esta pendencia antes de prosseguir.")

		//loop
		msgAlert("O processo serแ abortado.", "Aten็ใo!")

		lErro := .T.
		exit
	endif

	dDtColeta	:= Stod(TRBCOL->ZX1_DATA)
	cSetor		:= "000001"
	cLinRot		:= SA2->A2_L_LI_RO
	cTipLR   	:= SA2->A2_L_TP_LR
	cFretist	:= ZL3->ZL3_FRETIS
	cLjFret 	:= ZL3->ZL3_FRETLJ
	cVeicul		:= ZL4->ZL4_COD //ZL3->ZL3_VEICUL
	cMotor		:= ZL4->ZL4_MOTORI
	nTotKm  	:= 0
	cUser		:= CriaVar("ZLD_USER")
	nQtdBom		:= TRBCOL->ZX1_QUANT
	cNomeA2		:= SA2->A2_NOME


	//Verifica para saber se eh nova viagem ou dia para gerar novo ticket
	if cAux != TRBCOL->ZX1_DATA + TRBCOL->ZX1_CAMINH + Alltrim(str(TRBCOL->ZX1_VIAGEM))
		cAux := TRBCOL->ZX1_DATA + TRBCOL->ZX1_CAMINH + Alltrim(str(TRBCOL->ZX1_VIAGEM))
		cLinhaAux := TRBCOL->A2_L_LI_RO
		//Gera Codigo de Recebimento
		//ZX7_FILIAL+ZX7_CAMINH+ZX7_VIAGEM+ZX7_DATA
		nTotBom := int(getTotLte(sToD(TRBCOL->ZX1_DATA),TRBCOL->ZX1_CAMINH,TRBCOL->ZX1_VIAGEM))
		if nTotBom == 0
			msgAlert("Favor cadastrar peso do dia " + ALLTRIM(DTOC(sToD(TRBCOL->ZX1_DATA))) + " para caminhใo " + TRBCOL->ZX1_CAMINH + " Viagem: " + Str(TRBCOL->ZX1_VIAGEM)  , "Aten็ใo!")
			lErro := .T.
			msgAlert("O processo serแ abortado.", "Aten็ใo!")
			exit
		endif

		cTicket := getNwTicket(cSetor)
		cCodRec := cTicket // getNumRec()

		nPosFil := ascan(aMovInternos,{|x| x[1] == cFilEntr .AND. x[2] == cTicket})
		//aMovInternos {cFilial,cTicket,nTotBom,DataColeta}
		if nPosFil == 0
			aadd(aMovInternos,{cFilEntr,cTicket,nTotBom,dDtColeta})
		else
			aMovInternos[nPosFil][3] += nTotBom
		endif


		//Verifica se eh linha diferente, para gerar novo codigo de recepcao
	elseif cLinhaAux != TRBCOL->A2_L_LI_RO
		cLinhaAux := TRBCOL->A2_L_LI_RO
		cCodRec := getNumRec()
	endif

	grvZLD(cRetiro,cRetLj,dDatabase,dDtColeta,cSetor,cLinRot,cTipLR,cFretist,cLjFret,cVeicul,cMotor,nTotKm,cUser,nTotBom,cNomeA2,cTicket,cCodRec,nQtdBom)

	TRBCOL->(dbSkip())
enddo

//Gera Movimentos Interno
for i := 1 to len(aMovInternos)
	if ! (gerMI(aMovInternos[i][2],3,aMovInternos[i][3],aMovInternos[i][4],"000001",aMovInternos[i][1]) )//Incluir
		lErro := .T.
	endif
next i

pergunte(cPerg,.F.)

if !lErro
	cQueryUpd := "UPDATE "  + retSqlName("ZX1") + " SET ZX1_IMPZLD = 'S' WHERE ZX1_DATA BETWEEN '" +  dtos(mv_par01) + "' AND '" + dtos(mv_par02) + "' "

	TCSQLExec(cQueryUpd)

	MSGInfo("Processo concluido com sucesso.", "Informa็ใo!")
else
	DisarmTransaction()
endif

END TRANSACTION


//Restaura Areas
ZL2->(restArea(aAreaZL2))
ZL3->(restArea(aAreaZL3))
SA2->(restArea(aAreaSA2))

return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMGLT022   บAutor  ณMicrosiga           บ Data ณ  06/16/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Grava informacoes na ZLD - Recpcao de Leite                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

static function grvZLD(cRetiro,cRetLj,dData,dDtColeta,cSetor,cLinRot,cTipLR,cFretist,cLjFret,cVeicul,cMotor,nTotKm,cUser,nTotBom,cNomeA2,cTicket,cCodRec,nQtdBom)


dbSelectArea("ZLD")
RecLock("ZLD",.T.)
ZLD->ZLD_FILIAL		:= xFilial("ZLD")
//ZLD->ZLD_CODREC		:= cCodRec
ZLD->ZLD_TICKET		:= cTicket
ZLD->ZLD_DTLANC		:= dData
ZLD->ZLD_DTCOLE		:= dDtColeta
ZLD->ZLD_SETOR 		:= cSetor
ZLD->ZLD_LINROT		:= cLinRot
ZLD->ZLD_TP_RL		:= cTipLR
ZLD->ZLD_RETIRO		:= cRetiro
ZLD->ZLD_RETILJ		:= cRetLj
ZLD->ZLD_FRETIS		:= cFretist
ZLD->ZLD_LJFRET		:= cLjFret
ZLD->ZLD_VEICUL		:= cVeicul
ZLD->ZLD_DCRRET		:= cNomeA2
ZLD->ZLD_MOTOR		:= cMotor
ZLD->ZLD_KM			:= nTotKm
ZLD->ZLD_STATUS		:= " "
ZLD->ZLD_USER 		:= cUser
ZLD->ZLD_TOTBOM		:= nTotBom
ZLD->ZLD_QTDBOM		:= nQtdBom
ZLD->ZLD_IMPORT		:= "I" //Importado
ZLD->ZLD_FILENT		:= U_GetFilEnt(cRetiro,cRetLj,dDtColeta)
ZLD->(MsUnlock())

return



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณgetNumRec บ Autor ณ Totvs                 บ Data da Criacao  ณ 16/06/2010                						บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao usada para pegar numero maximo de recebimento                                                         บฑฑ
ฑฑบ          ณ                  												                               				บฑฑ
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

Static Function getNumRec()
Local cRet 	  := ""
Local cQuery  := ""
Local aArea   := GetArea()


cQuery := "SELECT MAX(ZLD_CODREC) AS ULTIMO FROM "
cQuery += RetSqlName("ZLD") + " WHERE D_E_L_E_T_ = ' ' "
cQuery += "  AND ZLD_FILIAL = '" + xFilial("ZLD") + "'"

If Select("TRB") > 0
	dbSelectArea("TRB")
	("TRB")->(dbCloseArea())
EndIf

dbUseArea(.T.,"TOPCONN",TCGenQry(,,ALLTRIM(Upper(cQuery))),'TRB',.F.,.T.)

If TRB->(!Eof())
	cRet := soma1(TRB->ULTIMO)
EndIf

dbSelectArea("TRB")
("TRB")->(dbCloseArea())

RestArea(aArea)

Return cRet




/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณgetNwTicket Autor ณ Totvs                 บ Data da Criacao  ณ 16/06/2010                						บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao usada para pegar numero maximo do Ticket                                                              บฑฑ
ฑฑบ          ณ                  												                               				บฑฑ
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
Static Function getNwTicket(cSetor)
Local cRet := ""
Local aArea   := GetArea()


dbSelectArea("ZL2")
dbSetOrder(1)
dbSeek(xfilial("ZL2")+cSetor)
If Found() .AND. xfilial("ZL2")+cSetor == ZL2->ZL2_FILIAL+ZL2->ZL2_COD
	cRet:=ZL2->ZL2_TICKET
	If Empty(alltrim(cRet))
		cRet:=StrZero(1,6)
	EndIf
	RecLock("ZL2",.f.)
	ZL2->ZL2_TICKET:=soma1(cRet)
	MsUnLock()
	cTicket := cRet
Else
	xmaghelpfis("Setor","Setor nao encontrado!","Selecione um Setor vแlido!")
EndIf

("ZL2")->(dbCloseArea())
RestArea(aArea)
Return cRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณGERMI     บ Autor ณ TOTVS                 บ Data da Criacao  ณ 07/10/2008                						บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao usada para gravar o movimento interno no estoque                                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Implantacao das rotinas referente a Gestao do Leite.                						                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ Nenhum                                                                               						บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ Nenhum                                                                                						บฑฑ
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
Static Function gerMI(cCod,noption,nTotBom,dDtColeta,cSetor,cFilEntr)
Local _aAutoSD3 := {}
Local cTm := getmv("LT_ENTTM")//Cod.do TM do Mov.Interno do Recto de Leite
Local cProduto := getmv("LT_ENTPRO")//Cod. do Produto do Mov.Interno do Recto de Leite
Local cLocal:=""
Local nVlrMix := POSICIONE("ZL2",1,XFILIAL("ZL2")+cSetor,"ZL2_ULTMIX")
Local bret:=.t.
Local _cLote	:=	""
Local _cArmaz	:=	""
local cFilAux := cFilAnt

cFilAnt := cFilEntr //Atualiza Filial com filial de entrega

If nVlrMix <= 0
	xmaghelpfix("Erro","O valor do custo nao foi preenchido no Cadastro de Setores!","Preencha o valor do custo de entrada no estoque no Cadastro de Setores!")
	Return .f.
EndIf

_cArmaz	:=	POSICIONE("ZL2",1,XFILIAL("ZL2")+cSetor,"ZL2_LOCAL")
_cLote	:=	SUBSTR(POSICIONE("ZG0",1,xFILIAL("ZG0")+_cArmaz,"ZG0_DESCR"),1,9)
cProduto:=POSICIONE("SB1",1,XFILIAL("SB1")+cProduto,"B1_COD")

nModulo := 4
cModulo := "EST"

// Se nao existir amazem, entao cria.
cLocal:=POSICIONE("ZL2",1,XFILIAL("ZL2")+cSetor,"ZL2_LOCAL")
dbSelectArea("SB2")
dbSetOrder(1)
If !dbSeek(xfilial("SB2")+cProduto+cLocal)
	CriaSB2(cProduto,cLocal)
EndIf

If !Empty(cTm) .and. !Empty(cProduto) .and. nOption == 3 // incluir

	AAdd( _aAutoSD3,{"D3_FILIAL"   , xFilial("SD3")		, nil } )	// Tipo do Movimento Interno	: Obrigatorio
	AAdd( _aAutoSD3,{"D3_TM"		, cTm 				, nil } )	// Tipo do Movimento Interno	: Obrigatorio
	AAdd( _aAutoSD3,{"D3_COD"		, cProduto			, nil } )	// Codigo do Produto			: Obrigatorio
	AAdd( _aAutoSD3,{"D3_UM"		, "LT"				, nil } )	// Unidade de Medida			: Obrigatorio
	AAdd( _aAutoSD3,{"D3_QUANT"	    , nTotBom       	, nil } )	// Quantidade de Leite
	AAdd( _aAutoSD3,{"D3_LOCAL"	    , POSICIONE("ZL2",1,XFILIAL("ZL2")+cSetor,"ZL2_LOCAL"), nil } )	// Almoxarifado					: Obrigatorio
	AAdd( _aAutoSD3,{"D3_EMISSAO"	, dDtcoleta			, nil } )	// Data de Emissao				: Obrigatorio
	AAdd( _aAutoSD3,{"D3_DOC"	    , GetSxeNum("SD3","D3_DOC"), nil } )	// Documento
	AAdd( _aAutoSD3,{"D3_CUSTO1"	, (nVlrMix*ntotbom)	, nil } )	// Custo (na Moeda 1)
	If getMv("MV_RASTRO") == "S"
		AAdd( _aAutoSD3,{"D3_LOTECTL"	, _cLote			, nil } )	// Lote
	EndIf
	AAdd( _aAutoSD3,{"D3_L_ORIG"	, cCod + "-" + cFilEntr  			, nil } )	// Origem do documento - ticket   + filial do produtor
	AAdd( _aAutoSD3,{"D3_L_SETOR"	, cSetor  			, nil } )	// Origem do documento - ticket
	lMsErroAuto := .F.
	If !existMi(cCod+ "-" + cFilEntr,cSetor)
		MSExecAuto({|x,y| Mata240(x,y)},_aAutoSD3,3)
	EndIf
	If lMsErroAuto .OR. !existMi(cCod+ "-" + cFilEntr,cSetor)
		mostraerro()
		xmaghelpfis("Erro","Erro ao gravar Recepcao de Leite devido a um erro ocorrido ao gerar Estoque!","Tente novamente, se o erro persistir comunique urgentemente ao Suporte!")
		bret:=.f.
	EndIf

Else
	If !Empty(cTm) .and. !Empty(cProduto) .and. noption == 3
		xmaghelpfis("Erro","Parametros LT_ENTPRO e LT_ENTTM nao foram preenchidos ou ja existe esse Ticket de Recepcao de Leite! Nao foi possivel gerar estoque!","Comunique urgentemente ao Suporte!")
		bret:=.f.
	EndIf
EndIf

nModulo := 2
cModulo := "COM"
cFilAnt := cFilAux


Return bret

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณEXISTMI   บ Autor ณ TOTVS                 บ Data da Criacao  ณ 09/10/2008                						บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao usada verificar se existe um movimento interno relativo a entrada                                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Implantacao das rotinas referente a Gestao do Leite.                						                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ Nenhum                                                                               						บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ Nenhum                                                                                						บฑฑ
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
Static Function existMi(cCod,cpSetor)
Local retorno := .f.

_cQuery := " SELECT"
_cQuery += "  * "
_cQuery += " FROM "+RetSqlName("SD3")+" SD3 "
_cQuery += " WHERE "
_cQuery += " D_E_L_E_T_ = ' '"
_cQuery += " AND D3_ESTORNO != 'S'"
_cQuery += " AND D3_L_ORIG  = '"+cCod+"'"
_cQuery += " AND D3_L_SETOR = '"+cpSetor+"'"

dbUseArea(.T.,"TOPCONN",TCGenQry(,,ALLTRIM(Upper(_cQuery))),'TRB',.F.,.T.)

While TRB->(!Eof())
	retorno := .t.
	TRB->(dbSkip())
EndDo
TRB->(dbCloseArea())
("TRB")->(dbCloseArea())
Return retorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMGLT022   บAutor  ณMicrosiga           บ Data ณ  07/13/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina responsavel por buscar total de leite de determinadoบฑฑ
ฑฑบ          ณ perido/caminhao/viagem                                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

static function getTotLte(dData,cCaminhao,nViagem)
//ZX7_FILIAL+ZX7_CAMINH+ZX7_VIAGEM+ZX7_DATA
local nRet := 0
local cAlias := "TRBTOTLTE"
local aAreaZX7 := ZX7->(GetArea())

if Select(cAlias) > 0
	dbSelectArea(cAlias)
	cAlias->(dbCloseArea())
endif

//Tenta localizar na ZX7 - Tabela Conferencia de Peso
dbSelectArea("ZX7")
dbSetOrder(1)
if dbSeek(xFilial("ZX7") + cCaminhao + str(nViagem,2,0) + dTos(dData))
	nRet := (ZX7->ZX7_PCHEIO - ZX7->ZX7_PVAZIO) / 1.03
else
	nRet := 0
endif

ZX7->(restArea(aAreaZX7))
return nRet



