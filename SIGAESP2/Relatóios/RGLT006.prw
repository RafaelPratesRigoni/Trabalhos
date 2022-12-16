#INCLUDE "rwmake.ch"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ RGLT006  บ Autor ณ TOTVS                 บ Data da Criacao  ณ 18/02/2009                						บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina desenvolvida para imprimir nota fiscal do leite - Produtor                                            บฑฑ
ฑฑบ          ณ                     												                               				บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Leite                 						                                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 	mv_par01 = Da Nota							             													บฑฑ
ฑฑบ			 ณ	mv_par02 = Ate Nota       					  					                       						บฑฑ
ฑฑบ			 ณ	mv_par03 = Serie 					        																บฑฑ
ฑฑบ			 ณ	mv_par04 = Tipo de NF: Entrada/Saida  										                                บฑฑ
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
ฑฑบ          ณ00/00/0000ณ                               				   ณ00-000000 -                       ณ TI	        บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑบ          ณ          ณ                    							   ณ                                  ณ 			บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑศออออออออออฯออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออออออออออออออออออออออออออออออฯอออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function RGLT006()


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
SetPrvt("XNUM_NF,XSERIE,XEMISSAO,XTOT_FAT,XLOJA,XVENDEDOR,xDESCONTO,xDESCCONV")
SetPrvt("XSEGURO,XBASE_ICMS,XBASE_IPI,XVALOR_ICMS,XICMS_RET,XEVENTOS,XVALOR_IPI,xDESPESA")
SetPrvt("XVALOR_MERC,xTRANSP,XNUM_DUPLIC,XCOND_PAG,XTIPO")
SetPrvt("XESPECIE,XNFESPECIE,XVOLUME,XPED_VEND,XITEM_PED")
SetPrvt("XNUM_NFDV,XPREF_DV,XICMS,XCOD_PRO,XQTD_PRO,XPRE_UNI,XITENS")
SetPrvt("XPRE_TAB,XIPI,XVAL_IPI,XDESC,XVAL_DESC,XVAL_MERC")
SetPrvt("XTES,XCF,XICMSOL,XICM_PROD,xAUXTES,aCodFormul,xMENRECE,xMENLOTE")
SetPrvt("XDESCRICAO,XUNID_PRO,X2UNID_PRO,XCONV,XTIPOCONV,XCOD_TRIB,XMEN_TRIB,XCOD_FIS,XCLAS_FIS")
SetPrvt("XMEN_POS,XISS,XTIPO_PRO,XLUCRO,XCLFISCAL")
SetPrvt("XCLIENTE,XTIPO_CLI,XMENSAGEM,XMSG_EXTRA,XMSGTES")
SetPrvt("XTPFRETE,XCONDPAG,XCOD_VEND,XDESCTO,XPED_CLI")
SetPrvt("XCOD_CLI,XNOME_CLI,XEND_CLI,XBAIRRO,XDATA,XHORA")
SetPrvt("XCEP_CLI,XCOB_CLI,XREC_CLI,XMUN_CLI,XEST_CLI,XCGC_CLI")
SetPrvt("XINSC_CLI,XTRAN_CLI,XTEL_CLI,XFAX_CLI,XDDD_CLI")
SetPrvt("XBSICMRET,XNATUREZA,XNOME_TRANSP,XEND_TRANSP,XMUN_TRANSP,xIE_TRANSP,XFRETE")
SetPrvt("XEST_TRANSP,XCGC_TRANSP,XTEL_TRANSP,XPARC_DUP,XVENC_DUP,XVALOR_DUP,XDUPLICATAS,XFORNECE,XNFORI,XPEDIDO,XGLTTP")
SetPrvt("XLOTE,XSUBLOTE,XDTVALID,xLOCAL")
SetPrvt("XVALIRRF,XVALISS,xTOT_ITENS,xSIT_TRIB")
SetPrvt("xC5_PBRUTO,xC5_PESOL,xPESO_ITEM,xPESOBRUTO,XPLACA,xMARCA,XUFPLC")
SetPrvt("I,J,NAJUSTE,BB,NCOL,NTAMDET,NPELEM,NTAMOBS,_CLASFIS,NPTESTE,XPED")

Private Titulo	  := PADC("Nota Fiscal - RGLT006",74)
Private cDesc1	  := PADR("Este programa ira emitir Notas Fiscais de Entrada/Saida",74)
Private cDesc2	  := PADR("conforme parametros informados.",74)
Private cDesc3	  := ""
Private wnrel	  := "RGLT006"
Private nomeprog  := "RGLT006"
Private cPerg	  := "RGLT006   "
Private cString	  := "SF2"
Private tamanho	  := "P"
Private Limite	  := 80
Private nLastKey  := 0
Private nLin	  := 0
Private _nImprime := 0
Private _nPag     := 1
Private lContinua := .T.
Private aOrd	  := {}
Private aReturn	  := { "Especial", 1,"Administracao", 2, 3, 1,"",1 }
Private cSeekD1
Private cGrpImp := "000007" // Grupo de evento dos impostos
Private cEvtVol := "000001/" // Eventos que contam o volume

private m_pag

xDESCONTO := 0
xDESCCONV := 0

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verifica as perguntas selecionadas.                          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Pergunte(cPerg,.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Altera padroes de impressao via funcao SETPRINT              ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

wnrel := SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Habilita os padroes definidos pela funcao SetPrint.          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verifica Posicao do Formulario na Impressora                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
VerImp()

If lContinua
	nTipo		:= If(aReturn[4]==1,15,18)

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Processamento. RPTSTATUS monta janela com a regua de processamento. ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	RptStatus({|| RptDetail()}, Titulo)
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ RptDetail  บ Autor ณ Jeovane               บ Data da Criacao  ณ 18/02/2009             						บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS                                                   บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.                                                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Leite                 						                                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                  							             													บฑฑ
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
ฑฑบ          ณ00/00/0000ณ                               				   ณ00-000000 -                       ณ TI	        บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑบ          ณ          ณ                    							   ณ                                  ณ 			บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑศออออออออออฯออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออออออออออออออออออออออออออออออฯอออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function RptDetail()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Zera o formulario.                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
SetPrc(0,0)
dbCommitAll()

If mv_par04 == 1
	@ nLin, 000 PSAY AvalImp(Limite)
	@ nLin, 005 PSAY Chr(27)+Chr(120)+"0"       // Fonte: DRAFT
	@ nLin, 002 PSAY Chr(27)+Chr(18)		     // Descompacta Impressao
	@ nLin, 001 PSAY CHR(27)+"0"                  //Espacamento 1/8
Endif

If mv_par04 == 2
	GerNfSai()
Else
	GerNfEnt()
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Fechamento do Programa da Nota Fiscal. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Set Device To Screen

SetPgEject(.F.)

If aReturn[5] == 1
	Set Printer TO
	dbcommitAll()
	ourspool(wnrel)
Endif

MS_FLUSH()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ VerImp    บ Autor ณ Jeovane               บ Data da Criacao  ณ 18/02/2009              						บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Verifica posicionamento de papel na Impressora                                                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Leite                 						                                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                  							             													บฑฑ
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
ฑฑบ          ณ00/00/0000ณ                               				   ณ00-000000 -                       ณ TI	        บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑบ          ณ          ณ                    							   ณ                                  ณ 			บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑศออออออออออฯออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออออออออออออออออออออออออออออออฯอออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/


Static Function VerImp()

If aReturn[5] == 2 .OR. aReturn[5] == 3

	While .T.
		IF MsgYesNo("Fomulario esta posicionado ? ")
			lContinua := .T.
			Exit
		ElseIf MsgYesNo("Tenta Novamente ? ")
			Loop
		Else
			lContinua := .F.
			Return
		Endif
	EndDo

Endif

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ GerNfSai    บ Autor ณ Jeovane               บ Data da Criacao  ณ 18/02/2009             						บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Faz a leitura dos dados da Nota de Saida, atualiza os  valores das variaveis e chama a impressao.            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Leite                 						                                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                  							             													บฑฑ
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
ฑฑบ          ณ00/00/0000ณ                               				   ณ00-000000 -                       ณ TI	        บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑบ          ณ          ณ                    							   ณ                                  ณ 			บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑศออออออออออฯออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออออออออออออออออออออออออออออออฯอออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function GerNFSai()
local nAux := 0
Local I    := 0
Local K	   := 0
Local nPos := 0

//Se Rotina que chamar a impressao da NF for diferente de RGLT006 entao sistema considera nf atual
if alltrim(upper(funname())) != "RGLT006" .and. alltrim(upper(funname())) != "ATTG006"  .and. alltrim(upper(funname())) != "ATTG004"
	mv_par01 := SF2->F2_DOC
	mv_par02 := SF2->F2_DOC
	mv_par03 := SF2->F2_SERIE
endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Cabecalho da Nota de Saida.                                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
dbSelectArea("SF2")
dbSetOrder(1)
dbSeek(xFilial("SF2")+mv_par01+mv_par03,.T.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Inicializa Regua de Impressao                                ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
SetRegua(RecCount())

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Item da Nota de Saida.                                       ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
dbSelectArea("SD2")
dbSetOrder(3)
dbSeek(xFilial("SD2")+mv_par01+mv_par03)

DbSelectArea("SF2")
While SF2->(!Eof()) .And. SF2->F2_DOC >= mv_par01 .And. SF2->F2_DOC <= mv_par02 .And. lContinua

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Se a Serie do Arquivo for Diferente do Parametro Informado, passa pro proximo !!! ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If SF2->F2_SERIE # mv_par03
		DbSkip()
		Loop
	Endif

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Cancela a impressao caso pressionado o bota Cancelar.        ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	IF lAbortPrint
		@ 00,01 PSAY "** CANCELADO PELO OPERADOR **"
		lContinua := .F.
		Exit
	Endif

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Dados do Cabacalho da Nota                                   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	xNUM_NF     := SF2->F2_DOC             // Numero
	xSERIE      := SF2->F2_SERIE           // Serie
	xEMISSAO    := SF2->F2_EMISSAO         // Data de Emissao
	xCLIENTE	:= SF2->F2_CLIENTE
	xLOJA       := SF2->F2_LOJA            // Loja do Cliente
	xFRETE      := SF2->F2_FRETE           // Frete
	xDESPESA	:= SF2->F2_DESPESA			// Despesas Acessorias
	xDESCONTO	:= SF2->F2_DESCONT
	xSEGURO     := SF2->F2_SEGURO          // Seguro
	xBASE_ICMS  := SF2->F2_BASEICM         // Base   do ICMS
	xBASE_IPI   := SF2->F2_BASEIPI         // Base   do IPI
	xVALOR_ICMS := SF2->F2_VALICM          // Valor  do ICMS
	xICMS_RET   := SF2->F2_ICMSRET         // Valor  do ICMS Retido
	xVALOR_IPI  := SF2->F2_VALIPI          // Valor  do IPI
	xVALOR_MERC := SF2->F2_VALMERC         // Valor  da Mercadoria
	xNUM_DUPLIC := SF2->F2_DUPL            // Numero da Duplicata
	xCOND_PAG   := SF2->F2_COND            // Condicao de Pagamento
	xTIPO       := SF2->F2_TIPO            // Tipo da nota
	xESPECIE    := SF2->F2_ESPECI1         // Especie 1 no Pedido
	xVOLUME     := SF2->F2_VOLUME1         // Volume 1 no Pedido
	XVALIRRF    := SF2->F2_VALIRRF         // Valor do Imposto de Renda
	XVALISS     := SF2->F2_VALISS          // Valor do ISS
	xTOT_FAT    := iif(SF2->F2_VALFAT>0,SF2->F2_VALFAT,SF2->F2_VALBRUT)  // Valor Total da Fatura //+SF2->F2_SEGURO+SF2->F2_FRETE
	xDATA		:= dDatabase
	xHORA		:= time()
	xPLACA		:= SF2->F2_VEICUL1         //Placa Veiculo
	XUFPLC		:= " "
	xMARCA		:= "Marca"  //SF2->F2_MARCA           //Marca

	// nao estavam armazenando historico, por exemplo os embarcos de cafe.


	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Dados dos Itens da Nota                                      ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	dbSelectArea("SD2")
	dbSetOrder(3)
	dbSeek(xFilial("SD2")+xNUM_NF+xSERIE)

	xPED_VEND	:= {}			// Numero do Pedido de Venda
	xITEM_PED	:= {}			// Numero do Item do Pedido de Venda
	xNUM_NFDV	:= {}			// nUMERO QUANDO HOUVER DEVOLUCAO
	xPREF_DV	:= {}			// Serie  quando houver devolucao
	xICMS		:= {}			// Porcentagem do ICMS
	xCOD_PRO	:= {}			// Codigo  do Produto
	xQTD_PRO	:= {}			// Quantidade do Produto
	xPRE_UNI	:= {}			// Preco Unitario de Venda
	xPRE_TAB	:= {}			// Preco Unitario de Tabela
	xIPI		:= {}			// Porcentagem do IPI
	xVAL_IPI	:= {}			// Valor do IPI
	xDESC		:= {}			// Desconto por Item
	xVAL_DESC	:= {}			// Valor do Desconto
	xVAL_MERC	:= {}			// Valor da Mercadoria
	xTES		:= {}			// TES
	xCF			:= {}			// Classificacao quanto natureza da Operacao
	xICMSOL		:= {}			// Base do ICMS Solidario
	xICM_PROD	:= {}			// ICMS do Produto
	xLOTE		:= {}			// Lote do produto
	xSUBLOTE	:= {}			// Sub Lote
	xDTVALID	:= {}			// Data de Validade
	xLOCAL		:= {}			// Armazem
	xAUXTES     := {}           // TES auxiliar, este array nao repete o codigo da TES
	aCodFormul  := {}			//Vetor que armazena o codigo das formulas para impressao das mensagens
	XEVENTOS 	:= {}
	xMENLOTE	:= ""
	xDESCCONV   := 0

	While SD2->(!Eof()) .And. SD2->D2_DOC == xNUM_NF .And. SD2->D2_SERIE == xSERIE

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Se a Serie do Arquivo for Diferente do Parametro Informado, passa pro proximo !!! ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If SD2->D2_SERIE # mv_par03
			DbSkip()
			Loop
		Endif

		xDESCCONV += 0//SD2->D2_CONVENI

		if nAux == 0
			AADD(xPED_VEND ,SD2->D2_PEDIDO)
			AADD(xITEM_PED ,SD2->D2_ITEMPV)
			AADD(xCOD_PRO  ,SD2->D2_COD)
			AADD(xQTD_PRO  ,SD2->D2_QUANT)
			AADD(xPRE_UNI  ,SD2->D2_PRCVEN)
			AADD(xPRE_TAB  ,SD2->D2_PRUNIT)
			AADD(xVAL_IPI  ,SD2->D2_VALIPI)
			AADD(xDESC     ,SD2->D2_DESC)
			AADD(xVAL_MERC ,SD2->D2_TOTAL)
			AADD(xTES      ,SD2->D2_TES)
			AADD(xCF       ,SD2->D2_CF)
			AADD(xLOTE	   ,SD2->D2_LOTECTL)
			AADD(xSUBLOTE  ,SD2->D2_NUMLOTE)
			AADD(xDTVALID  ,SD2->D2_DTVALID)
			AADD(xLOCAL	   ,SD2->D2_LOCAL)
			AADD(xICMS     ,IIf(Empty(SD2->D2_PICM),0,SD2->D2_PICM))
			AADD(xIPI      ,IIF(Empty(SD2->D2_IPI),0,SD2->D2_IPI))
			AADD(xICM_PROD ,IIf(Empty(SD2->D2_PICM),0,SD2->D2_PICM))
		else
			xQTD_PRO[nAux] += SD2->D2_QUANT
			iif(SD2->D2_PRCVEN > xPRE_UNI[nAux],xPRE_UNI[nAux] := SD2->D2_PRCVEN,xPRE_UNI[nAux] := xPRE_UNI[nAux] )
			xVAL_MERC[nAux] += SD2->D2_TOTAL
		endif

		if !empty(SD2->D2_LOTECTL)
			xMENLOTE := xMENLOTE + " Lote: " + alltrim(SD2->D2_LOTECTL) + ": " + alltrim(transform(SD2->D2_QTSEGUM,"@E 999,999,999.99"))
		endif


		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Armazena o codigo da TES sem repetir o mesmo codigo.        ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

		If ASCAN(xAUXTES,SD2->D2_TES)==0
			AADD(xAUXTES,SD2->D2_TES)
		EndIF

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Armazena o Numero e serie da Nota Original(Nota Devolvida). ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If ASCAN(xNUM_NFDV, {|x| x[1] == SD2->D2_NFORI})==0
			AADD(xNUM_NFDV,{SD2->D2_NFORI,nil})
			AADD(xPREF_DV ,SD2->D2_SERIORI)
		EndIF

		dbSelectArea("SD2")
		dbskip()
	EndDo

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Cadastro de produtos. ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	dbSelectArea("SB1")
	dbSetOrder(1)

	xDESCRICAO		:= {}		// Descricao do Produto

	xUNID_PRO		:= {}		// Unidade do Produto
	X2UNID_PRO		:= {}
	xCONV			:= {}
	xTIPOCONV		:= {}
	xCOD_TRIB		:= {}		// Codigo de Tributacao
	xMEN_TRIB		:= {}		// Mensagens de Tributacao
	xCOD_FIS		:= {}		// Cogigo Fiscal
	xCLAS_FIS		:= {}		// Classificacao Fiscal
	xMEN_POS		:= {}		// Mensagem da Posicao IPI - Codigo NCM
	xISS			:= {}		// Aliquota de ISS
	xTIPO_PRO		:= {}		// Tipo do Produto
	xLUCRO			:= {}		// Margem de Lucro p/ ICMS Solidario
	xCLFISCAL		:= {}    // Classificacao Fiscal
	xGRUPO_PRO 		:= {}    // Grupo do Produto
	xSIT_TRIB       := {}    // Situacao Tributaria da TES
	xPESO_ITEM		:= {}		// Peso do Item (Qtd X Peso)
	xPESOBRUTO		:= {}      //Peso Bruto
	xEventos		:= {}
	xTRANSP			:= ""


	For I := 1 to Len(xCOD_PRO)

		DbSeek(xFilial("SB1")+xCOD_PRO[I])

		AADD(xPESO_ITEM, SB1->B1_PESO * xQTD_PRO[I])
		AADD(xPESOBRUTO, SB1->B1_PESBRU * xQTD_PRO[I])

		AADD(xUNID_PRO	, SB1->B1_UM)
		AADD(x2UNID_PRO	, SB1->B1_SEGUM)
		AADD(xDESCRICAO, SB1->B1_DESC)

		AADD(xMEN_POS	, SB1->B1_POSIPI)
		AADD(xGRUPO_PRO, SB1->B1_GRUPO)
		AADD(xTIPO_PRO	, SB1->B1_TIPO)
		AADD(xLUCRO		, SB1->B1_PICMRET)
		AADD(xCOD_TRIB	, SB1->B1_ORIGEM)
		AADD(xCONV,SB1->B1_CONV)
		AADD(xTIPOCONV,SB1->B1_TIPCONV)
		If SB1->B1_ALIQISS > 0
			AADD(xISS	, SB1->B1_ALIQISS)
		Endif

	Next


	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Cabecalho do Pedido de Venda                                 ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	dbSelectArea("SC5")
	dbSetOrder(1)

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Numero de Pedido. ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	xPED     := {}
	xPED_CLI	:= {}


	For I := 1 to Len(xPED_VEND)

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Posiciona no Cabecalho do Pedido.                            ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		DbSeek(xFilial("SC5")+xPED_VEND[I])

		If ASCAN(xPED,xPED_VEND[I])==0
			xCLIENTE	 := SC5->C5_CLIENTE	   // Codigo do Cliente
			xTIPO_CLI	 := SC5->C5_TIPOCLI	   // Tipo de Cliente
			xCOD_MENS	 := SC5->C5_MENPAD	   // Codigo da Mensagem Padrao
			xMENSAGEM	 := ALLTRIM(SC5->C5_MENNOTA)	   // Mensagem para a Nota Fiscal
			xTPFRETE	 := SC5->C5_TPFRETE	   // Tipo de Entrega
			xCONDPAG	 := SC5->C5_CONDPAG	   // Condicao de Pagamento
			xTPFRETE     := SC5->C5_TPFRETE	   // Tipo do Frete
			iif(SC5->C5_PBRUTO > 0,xC5_PBRUTO:= SC5->C5_PBRUTO,xC5_PBRUTO:= SF2->F2_PBRUTO) // Peso Bruto
			iif(SC5->C5_PESOL > 0,xC5_PESOL:=SC5->C5_PESOL,xC5_PESOL:=SF2->F2_PLIQUI)   // Peso Liquido

			xMENRECE	 :=   " " //SC5->C5_RECEITA		//Codigo do Receituario
			xCOD_VEND	 := {SC5->C5_VEND1,;	// Codigo do Vendedor 1
			SC5->C5_VEND2,;							// Codigo do Vendedor 2
			SC5->C5_VEND3,;							// Codigo do Vendedor 3
			SC5->C5_VEND4,;							// Codigo do Vendedor 4
			SC5->C5_VEND5}							// Codigo do Vendedor 5

			XDESCTO := {SC5->C5_DESC1,;			// Desconto Global 1
			SC5->C5_DESC2,;							// Desconto Global 2
			SC5->C5_DESC3,;							// Desconto Global 3
			SC5->C5_DESC4}								// Desconto Global 4

			AADD(xPED,xPED_VEND[I])             // Numero do Pedido


		endif

	Next

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Itens do Pedido de Venda.                                    ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	dbSelectArea("SC6")
	dbSetOrder(1)

	For I := 1 to Len(xPED_VEND)

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Posiciona no Item do Pedido.                         ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		dbSeek(xFilial("SC6")+xPED_VEND[I]+xITEM_PED[I])

		AADD(xPED_CLI	, SC6->C6_PEDCLI)
		AADD(xVAL_DESC	, SC6->C6_VALDESC)
	Next

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Dados da TES - Situacao Tribuataria                          ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	dbSelectArea("SF4")
	dbSetOrder(1)
	For K := 1 to Len(xTES)
		dbSeek(xFilial("SF4")+xTES[K])
		AADD(xSIT_TRIB, SF4->F4_SITTRIB)
	Next

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Mensagem da TES - Finalidade - Impresso nos Dados Adicionais na Nota.  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	dbSelectArea("SF4")
	dbSetOrder(1)
	XMSGTES := ""
	For K := 1 to Len(aCodFormul)
		XMSGTES += alltrim(formula(aCodFormul[k]))
	Next

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Dados do Destinatario/Rementente                             ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If xTIPO=='N' .OR. xTIPO=='C' .OR. xTIPO=='P' .OR. xTIPO=='I' .OR. xTIPO=='S' .OR. xTIPO=='T' .OR. xTIPO=='O'

		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek(xFilial("SA1")+xCLIENTE+xLOJA)

		xCOD_CLI		:= SA1->A1_COD			// Codigo do Cliente
		xNOME_CLI	    := SA1->A1_NOME		// Nome
		xEND_CLI		:= SA1->A1_END			// Endereco
		xBAIRRO 		:= SA1->A1_BAIRRO		// Bairro
		xCEP_CLI		:= SA1->A1_CEP			// CEP
		xCOB_CLI		:= SA1->A1_ENDCOB		// Endereco de Cobranca
		xREC_CLI		:= SA1->A1_ENDENT		// Endereco de Entrega
		xMUN_CLI		:= SA1->A1_MUN			// Municipio
		xEST_CLI		:= SA1->A1_EST			// Estado
		xCGC_CLI		:= SA1->A1_CGC			// CGC Cliente
		if !empty(SA1->A1_INSCRUR)
			xINSC_CLI	    := SA1->A1_INSCRUR		// Inscricao estadual
		else
			xINSC_CLI	    := SA1->A1_INSCR		// Inscricao estadual
		endif
		xTRAN_CLI	    := SA1->A1_TRANSP		// Transportadora
		xTEL_CLI		:= SA1->A1_TEL			// Telefone
		xDDD_CLI        := SA1->A1_DDD          // DDD
		xFAX_CLI		:= SA1->A1_FAX			// Fax
	Else
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Quando Nota de Devolucao, busca os dados do Fornecedor.      ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		dbSelectArea("SA2")
		dbSetOrder(1)
		dbSeek(xFilial("SA2")+xCLIENTE+xLOJA)

		xCOD_CLI		:= SA2->A2_COD		 // Codigo do Fornecedor
		xNOME_CLI	    := SA2->A2_NOME 	 // Nome Fornecedor
		xEND_CLI		:= SA2->A2_END		 // Endereco
		xBAIRRO		    := SA2->A2_BAIRRO	 // Bairro
		xCEP_CLI		:= SA2->A2_CEP		 // CEP
		xCOB_CLI		:= ""				 // Endereco de Cobranca
		xREC_CLI		:= ""				 // Endereco de Entrega
		xMUN_CLI		:= SA2->A2_MUN		 // Municipio
		xEST_CLI		:= SA2->A2_EST		 // Estado
		xCGC_CLI        := SA2->A2_CGC       // CPF/CGC
		xINSC_CLI       := SA2->A2_INSCR	 // Inscricao estadual
		xTRAN_CLI       := SA2->A2_TRANSP	 // Transportadora
		xTEL_CLI        := SA2->A2_TEL		 // Telefone
		xDDD_CLI        := SA1->A1_DDD          // DDD
		xFAX_CLI        := SA2->A2_FAX		 // Fax
	Endif

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Dados do(s) Vendedor(es)                                     ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	dbSelectArea("SA3")
	dbSetOrder(1)

	xVENDEDOR := {}

	For I := 1 to Len(xCOD_VEND)

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Posiciona no Vendedor.                                     ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		DbSeek(xFilial("SA3")+xCOD_VEND[I])

		Aadd(xVENDEDOR	, SA3->A3_NOME)
	Next

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Base do ICMS Retido                                          ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If xICMS_RET >0					// Apenas se ICMS Retido > 0
		dbSelectArea("SF3")			// Cadastro de Livros Fiscais
		dbSetOrder(4)
		dbSeek(xFilial("SF3")+SA1->A1_COD+SA1->A1_LOJA+SF2->F2_DOC+SF2->F2_SERIE)

		If Found()
			xBSICMRET := F3_VALOBSE
		Else
			xBSICMRET := 0
		Endif
	Else
		xBSICMRET	 := 0
	Endif

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Dados da Transportadora                                      ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	dbSelectArea("SA4")
	dbSetOrder(1)
	dbSeek(xFilial("SA4")+xTRANSP)

	xNOME_TRANSP	:= SA4->A4_NOME		// Nome Transportadora
	xEND_TRANSP		:= SA4->A4_END		// Endereco
	xMUN_TRANSP		:= SA4->A4_MUN		// Municipio
	xEST_TRANSP		:= SA4->A4_EST		// Estado
	xCGC_TRANSP		:= SA4->A4_CGC		// CGC
	xIE_TRANSP		:= SA4->A4_INSEST	// Inscricao Estadual
	xTEL_TRANSP		:= SA4->A4_TEL		// Fone

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Dados da Duplicata                                           ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	dbSelectArea("SE1")
	dbSetOrder(1)
	cPrefixo := SF2->F2_SERIE //padr(U_fPrefixo(),3)
	xDUPLICATAS := dbSeek(xFilial("SE1")+cPrefixo+SF2->F2_DOC)

	xPARC_DUP	:= {}	 // Parcela
	xVENC_DUP	:= {}	 // Vencimento
	xVALOR_DUP	:= {}	 // Valor

	While SE1->(!Eof()) .And. SE1->E1_NUM == SF2->F2_DOC .And. xDUPLICATAS
		If !("NF" $ SE1->E1_TIPO)
			dbSkip()
			Loop
		Endif
		AADD(xPARC_DUP	, SE1->E1_PARCELA)
		AADD(xVENC_DUP	, SE1->E1_VENCTO)
		AADD(xVALOR_DUP, SE1->E1_VALOR)
		SE1->(DbSkip())
	EndDo

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Natureza da Operacao                                         ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	xNATUREZA :=Posicione("SX5",1,XFILIAL("SX5")+"13"+xCF[1],"X5_DESCRI")

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Mensagens para Nota de Devolucao.                            ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If xTIPO == "D"
		xMENSAGEM += "Devolucao conf. NF " + xNUM_NFDV[1,1] + "-" + xPREF_DV[1]
	EndIf

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Mensagens para Nota de Complemento.                          ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If xTipo$"C/I/P"
		xMENSAGEM += "Nota Fiscal de Complemento ref. a NF "+ ALLTRIM(xNUM_NFDV[1,1]) + "-"  + ALLTRIM(xPREF_DV[1])
	EndIf

	if ((xTipo == "N") .and. (len(xNUM_NFDV) > 0))
		xMensagem += "NF Original:"
		for nPos := 1 to len(xNUM_NFDV)
			xMensagem += " " + ALLTRIM(xNUM_NFDV[nPos,1]) + "-"  + ALLTRIM(xPREF_DV[nPos])
		next nPos
	endif

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Chama o programa de impressao da Nota de Saida.              ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	Imprime()

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Atualiza Regura de Impressao                                 ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	IncRegua()

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Zera a linha de impressao para posicionar corretamente na proxima nota. ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	nLin := 0

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Passa para a proxima Nota Fiscal. ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	SF2->(dbSkip())

EndDo

dbSelectArea("SF2")
Retindex("SF2")
dbSelectArea("SD2")
Retindex("SD2")

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ GerNfEnt    บ Autor ณ Jeovane               บ Data da Criacao  ณ 18/02/2009             						บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Faz a leitura dos dados da Nota de Entrada, atualiza os  valores das variaveis e chama a impressao.          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Leite                 						                                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                  							             													บฑฑ
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
ฑฑบ          ณ00/00/0000ณ                               				   ณ00-000000 -                       ณ TI	        บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑบ          ณ          ณ                    							   ณ                                  ณ 			บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑศออออออออออฯออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออออออออออออออออออออออออออออออฯอออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function GerNfEnt()

Local I           := 0
Local K           := 0
Private cAliasSF1 := {}


//Se Rotina que chamar a impressao da NF for diferente de RGLT006 entao sistema considera nf atual
if alltrim(upper(funname())) != "RGLT006"
	mv_par01 := SF1->F1_DOC
	mv_par02 := SF1->F1_DOC
	mv_par03 := SF1->F1_SERIE
endif


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Cabecalho da Nota Fiscal Entrada.                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
dbSelectArea("SF1")
dbSetOrder(1)
dbSeek(xFilial("SF1")+mv_par01+mv_par03,.T.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Inicializa Regua de Impressao                                ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
SetRegua(RecCount())

While SF1->(!Eof()) .And. SF1->F1_DOC >= mv_par01 .AND. SF1->F1_DOC <= mv_par02 ;
	.And. SF1->F1_SERIE == mv_par03 .And. lContinua

	aAliasSF1 := SF1->(GetArea())

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Se a Serie do Arquivo for Diferente do Parametro Informado, passa pro proximo !!! ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If SF1->F1_SERIE # mv_par03
		DbSkip()
		Loop
	Endif

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Cancela a impressa caso pressionado o bota Cancelar.         ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	IF lAbortPrint
		@ 00,01 PSAY "** CANCELADO PELO OPERADOR **"
		lContinua		:= .F.
		Exit
	Endif

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Dados do Cabacalho da Nota                                   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	xNUM_NF		 := SF1->F1_DOC		    // Numero
	xSERIE		 := SF1->F1_SERIE		// Serie
	xFORNECE	 := SF1->F1_FORNECE	    // Cliente/Fornecedor
	xLOJA		 := SF1->F1_LOJA		// Loja do Cliente
	xEMISSAO	 := SF1->F1_EMISSAO	    // Data de Emissao
	xTOT_FAT	 := SF1->F1_VALBRUT	    // Valor Bruto da Compra
	xBASE_ICMS	 := SF1->F1_BASEICM	    // Base   do ICMS
	xBSICMRET	 := SF1->F1_BRICMS	    // Base do ICMS Retido
	xBASE_IPI	 := SF1->F1_BASEIPI	    // Base   do IPI
	xVALOR_ICMS	 := SF1->F1_VALICM	    // Valor  do ICMS
	xICMS_RET	 := SF1->F1_ICMSRET	    // Valor  do ICMS Retido
	xVALOR_IPI	 := SF1->F1_VALIPI	    // Valor  do IPI
	xFRETE		 := SF1->F1_FRETE		// Frete
	xDESPESA	 := SF1->F1_DESPESA	    // Despesas Acessorias
	xSEGURO		 := SF1->F1_SEGURO	    // Seguro
	xVALOR_MERC	 := SF1->F1_VALMERC	    // Valor  da Mercadoria
	xNUM_DUPLIC	 := SF1->F1_DUPL		// Numero da Duplicata
	xCOND_PAG	 := SF1->F1_COND		// Condicao de Pagamento
	xTIPO		 := SF1->F1_TIPO		// Tipo da Nota Fiscal
	xNFESPECIE	 := SF1->F1_ESPECIE		// Especie da Nota Fiscal
	xVOLUME		 := SF1->F1_PESOL		//Volume transportado
	xC5_PBRUTO	 := SF1->F1_PESOL       // Peso Bruto
	xC5_PESOL    := SF1->F1_PESOL       // Peso Liquido
	xGLTTP    	 := SF1->F1_L_TPNF     // Tipo de NF do leite P=Produtor M=Municipio
	XPLACA		 := " "       //Placa
	XUFPLC		 := Posicione("DA3",3,xFilial("DA3")+xPLACA,"DA3_ESTPLA")
	xDATA 		 := dDatabase
	xHORA		 := time()
	xMARCA		 := " "

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Dados dos Itens da Nota                                      ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	DbSelectArea("SD1")
	dbSetOrder(1)
	dbGotop()
	dbSeek(xFilial("SD1")+xNUM_NF+xSERIE+xFORNECE+xLOJA)

	xPEDIDO		:= {}				// Numero do Pedido de Compra
	xITEM_PED	:= {}				// Numero do Item do Pedido de Compra
	xNUM_NFDV	:= {}				// Numero quando houver devolucao
	xPREF_DV	:= {}				// Serie  quando houver devolucao
	xICMS		:= {}				// Porcentagem do ICMS
	xCOD_PRO	:= {}				// Codigo  do Produto
	xQTD_PRO	:= {}				// Quantidade do Produto
	xPRE_UNI	:= {}				// Preco Unitario de Compra
	xIPI		:= {}				// Porcentagem do IPI
	xVAL_IPI	:= {}				// Valor do IPI
	xDESC		:= {}				// Desconto por Item
	xVAL_DESC	:= {}				// Valor do Desconto
	xVAL_MERC	:= {}				// Valor da Mercadoria
	xTES		:= {}				// TES
	xCF			:= {}				// Classificacao quanto natureza da Operacao
	xICMSOL		:= {}				// Base do ICMS Solidario
	xICM_PROD	:= {}	            // ICMS do Produto
	xLOTE		:= {}	            // Loto do produto
	xSUBLOTE	:= {}	            // Sub Lote
	xDTVALID	:= {}	            // Data de Validade
	xLOCAL		:= {}	            // Armazem
	xCOD_MENS   := {}               // Cod mensagem da nota
	xAUXTES     := {}               // TES auxiliar, este array nao repete o codigo da TES
	xDESCRICAO	:= {}					// Descricao do Produto
	aCodFormul  := {}
	xEventos	:= {}

	While !Eof() .And. ; //SD1->D1_DOC==xNUM_NF
		xNUM_NF+xSERIE+xFORNECE+xLoja == SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Se a Serie do Arquivo for Diferente do Parametro Informado, passa pro proximo !!! ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		cSeekD1 := SD1->D1_L_SEEK
		AADD(xPEDIDO	, SD1->D1_PEDIDO)	 // Ordem de Compra
		AADD(xITEM_PED	, SD1->D1_ITEMPC)	 // Item da O.C.
		AADD(xCOD_PRO	, SD1->D1_COD)		 // Produto
		AADD(xDESCRICAO , SD1->D1_L_DESCR)	 // Descricao do Evento - by abrahao em 06/03/09
		AADD(xQTD_PRO	, SD1->D1_QUANT)	 // Guarda as quant. da NF
		AADD(xPRE_UNI	, SD1->D1_VUNIT)	 // Valor Unitario
		AADD(xIPI		, SD1->D1_IPI)		 // % IPI
		AADD(xVAL_IPI	, SD1->D1_VALIPI)	 // Valor do IPI
		AADD(xDESC		, SD1->D1_DESC)	     // % Desconto
		AADD(xVAL_MERC	, SD1->D1_TOTAL)	 // Valor Total
		AADD(xLOCAL	    , SD1->D1_LOCAL)     // Local ou Armazem
		AADD(xSUBLOTE   , SD1->D1_NUMLOTE)   // Numero do Lote
		AADD(xDTVALID   , SD1->D1_DTVALID)   // Validade do Lote
		AADD(xTES       ,SD1->D1_TES)
		AADD(xCF		, SD1->D1_CF)		 // Codigo Fiscal
		AADD(xICM_PROD	, IIf(Empty(SD1->D1_PICM),0,SD1->D1_PICM))
		AADD(xICMS		, IIf(Empty(SD1->D1_PICM),0,SD1->D1_PICM))
		AADD(xEVENTOS   , SD1->D1_L_EVENT)	 // Codigo do Evento

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Armazena o codigo da TES sem repetir o mesmo codigo.        ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If ASCAN(xAUXTES,SD1->D1_TES)==0
			AADD(xAUXTES,SD1->D1_TES)
		EndIF

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Armazena o Numero e serie da Nota Original(Nota Devolvida). ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If ASCAN(xNUM_NFDV, {|x| x[1] == SD1->D1_NFORI})==0
			AADD(xNUM_NFDV,{SD1->D1_NFORI,NIL})  // Nota Original
			AADD(xPREF_DV , SD1->D1_SERIORI)	 // Serie Original
		EndIF

		DbSelectArea("SD1")
		DbSetOrder(1)
		dbSkip()
	EndDo

	if len(xPEDIDO)==0
		xmaghelpfis("Falha ITENS","Nao foram encontrados itens nesta NF.","Comunique ao Suporte")
	Endif

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Cadastro de Produtos.                                    ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	dbSelectArea("SB1")
	dbSetOrder(1)


	xUNID_PRO	:= {}					// Unidade do Produto
	X2UNID_PRO	:= {}
	xCONV		:= {}					//Quantidade na segunda unidade de medida
	xTIPOCONV	:= {}					//tipo de conversao multiplicador ou divisor
	xMEN_POS	:= {}					// Mensagem da Posicao IPI - Codigo NCM
	xCOD_TRIB	:= {}					// Codigo de Tributacao
	xMEN_TRIB	:= {}					// Mensagens de Tributacao
	xCOD_FIS	:= {}					// Cogigo Fiscal
	xCLAS_FIS	:= {}					// Classificacao Fiscal
	xISS		:= {}					// Aliquota de ISS
	xTIPO_PRO	:= {}					// Tipo do Produto
	xLUCRO		:= {}					// Margem de Lucro p/ ICMS Solidario
	xCLFISCAL	:= {}                   // Classificacao Fiscal
	xGRUPO_PRO	:= {}                   // Grupo do Produto
	xSIT_TRIB   := {}                   // Situacao Tributaria da TES
	xPESO_ITEM	:= {}		            // Peso do Item (Qtd X Peso)
	xPESOBRUTO	:= {}
	xTRANSP		:= " "


	For I := 1 to Len(xCOD_PRO)

		dbSeek(xFilial()+xCOD_PRO[I])

		AADD(xUNID_PRO	, SB1->B1_UM)
		AADD(x2UNID_PRO	, SB1->B1_SEGUM)
		AADD(xGRUPO_PRO , SB1->B1_GRUPO)
		AADD(xCONV,SB1->B1_CONV)
		AADD(xTIPOCONV,SB1->B1_TIPCONV)
		AADD(xMEN_POS	, SB1->B1_POSIPI)
		AADD(xTIPO_PRO	, SB1->B1_TIPO)
		AADD(xLUCRO		, SB1->B1_PICMRET)
		AADD(xCOD_TRIB	, SB1->B1_ORIGEM)
		AADD(xPESO_ITEM, SB1->B1_PESO * xQTD_PRO[I])
		AADD(xPESOBRUTO, SB1->B1_PESBRU * xQTD_PRO[I])

		If SB1->B1_ALIQISS > 0
			AADD(xISS		, SB1->B1_ALIQISS)
		Endif


		npElem := Ascan(xCLAS_FIS,SB1->B1_POSIPI)

		if npElem == 0
			AADD(xCLAS_FIS  ,SB1->B1_POSIPI)
		endif
		npElem := ascan(xCLAS_FIS,SB1->B1_POSIPI)

		DO CASE
			CASE npElem == 1
				_CLASFIS := "A"
			CASE npElem == 2
				_CLASFIS := "B"
			CASE npElem == 3
				_CLASFIS := "C"
			CASE npElem == 4
				_CLASFIS := "D"
			CASE npElem == 5
				_CLASFIS := "E"
			CASE npElem == 6
				_CLASFIS := "F"
		EndCase
		nPteste		:= Ascan(xCLFISCAL,_CLASFIS)
		If nPteste == 0
			AADD(xCLFISCAL,_CLASFIS)
		Endif
		AADD(xCOD_FIS ,_CLASFIS)


	Next

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Dados de TES - Situacao Tributaria                           ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	dbSelectArea("SF4")
	dbSetOrder(1)

	For K := 1 to Len(xTES)
		dbSeek(xFilial("SF4")+xTES[K])
		AADD(xSIT_TRIB, SF4->F4_SITTRIB)
	Next

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Mensagem da TES - Finalidade - Impresso nos Dados Adicionais na Nota.  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	XMSGTES := ""
	For K := 1 to Len(aCodFormul)
		XMSGTES += alltrim(formula(aCodFormul[k]))
	Next

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Dados do Destinatario/Rementente                             ณ
	//ณ Se nota de Devolucao ou Beneficiamento, imprime dados do     ณ
	//ณ cliente.                                                     ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If xTIPO == "D"	 .OR. xTIPO == "B"
		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek(xFilial()+xFORNECE+xLoja)

		xCOD_CLI	:= SA1->A1_COD		// Codigo do Cliente
		xNOME_CLI	:= SA1->A1_NOME	    // Nome
		xEND_CLI	:= SA1->A1_END		// Endereco
		xBAIRRO		:= SA1->A1_BAIRRO	// Bairro
		xCEP_CLI	:= SA1->A1_CEP		// CEP
		xCOB_CLI	:= SA1->A1_ENDCOB	// Endereco de Cobranca
		xREC_CLI	:= SA1->A1_ENDENT	// Endereco de Entrega
		xMUN_CLI	:= SA1->A1_MUN		// Municipio
		xEST_CLI	:= SA1->A1_EST		// Estado
		xCGC_CLI	:= SA1->A1_CGC		// CGC Cliente
		if !empty(SA1->A1_INSCRUR)
			xINSC_CLI	:= SA1->A1_INSCRUR	//Inscricao produto rural
		else
			xINSC_CLI	:= SA1->A1_INSCR	// Inscricao estadual
		endif
		xTRAN_CLI	:= SA1->A1_TRANSP	// Transportadora
		xTEL_CLI	:= SA1->A1_TEL		// Telefone
		xDDD_CLI    := SA1->A1_DDD          // DDD
		xFAX_CLI	:= SA1->A1_FAX		// Fax
	Else

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Dados do Fornecedor                                          ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		dbSelectArea("SA2")
		dbSetOrder(1)
		dbSeek(xFilial("SA2")+xFORNECE+xLOJA)

		xCOD_CLI		:= SA2->A2_COD		// Codigo do Cliente
		xNOME_CLI	    := SA2->A2_NOME	    // Nome
		xEND_CLI		:= SA2->A2_END		// Endereco
		xBAIRRO		    := SA2->A2_BAIRRO	// Bairro
		xCEP_CLI		:= SA2->A2_CEP		// CEP
		xCOB_CLI		:= ""				// Endereco de Cobranca
		xREC_CLI		:= ""				// Endereco de Entrega
		xMUN_CLI		:= SA2->A2_MUN		// Municipio
		xEST_CLI		:= SA2->A2_EST		// Estado
		xCGC_CLI		:= SA2->A2_CGC		// CGC Cliente
		xINSC_CLI	    := SA2->A2_INSCR	// Inscricao estadual
		xTRAN_CLI	    := SA2->A2_TRANSP	// Transportadora
		xTEL_CLI		:= SA2->A2_TEL		// Telefone
		xDDD_CLI        := SA1->A1_DDD          // DDD
		xFAX_CLI		:= SA2->A2_FAX		// Fax
	EndIf

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Natureza da Operacao                                         ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	xNATUREZA :=Posicione("SX5",1,XFILIAL("SX5")+"13"+xCF[1],"X5_DESCRI")

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Dados da Transportadora                                      ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

	dbSelectArea("SA4")
	dbSetOrder(1)
	dbSeek(xFilial("SA4")+xTRANSP)

	xNOME_TRANSP	:= SA4->A4_NOME		    // Nome Transportadora
	xEND_TRANSP		:= SA4->A4_END			// Endereco
	xMUN_TRANSP		:= SA4->A4_MUN			// Municipio
	xEST_TRANSP		:= SA4->A4_EST			// Estado
	xCGC_TRANSP		:= SA4->A4_CGC			// CGC
	xIE_TRANSP		:= SA4->A4_INSEST		// Inscricao Estadual
	xTEL_TRANSP		:= SA4->A4_TEL			// Fone
	xTPFRETE		:= "C"					// Tipo de Frete

	if xGLTTP!="M" .and. left(xCOD_CLI,1) $ "C/G/T" // Se NAO for NF de Municipio e for p/ produtor
		obtemFretis()
	endif

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Mensagens para Nota de Devolucao.                            ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If xTIPO == "D"
		xMENSAGEM := "Devolucao conf. nossa(s) nota(s) " + xPREF_DV[1] + "-" + xNUM_NFDV[1,1]
	EndIf

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Mensagens para Nota de Complemento.                          ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If xTipo$"C/I/P"
		xMENSAGEM := "Nota Fiscal de Complemento ref. a NF "+ ALLTRIM(xPREF_DV[1]) + "-" + ALLTRIM(xNUM_NFDV[1])+". " + ALLTRIM(xMENSAGEM)
	EndIf

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Chama o programa de impressao da Nota de Entrada.            ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	Imprime()

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Atualiza Regura de Impressao                                 ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	IncRegua()

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Zera a linha de impressao para posicionar corretamente na proxima nota. ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	nLin := 0

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Passa para a proxima Nota Fiscal. ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	RestArea(aAliasSF1)
	DbSelectArea("SF1")
	SF1->(dbSkip())

EndDo

dbSelectArea("SF1")
Retindex("SF1")
dbSelectArea("SD1")
Retindex("SD1")

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ GerNfEnt    บ Autor ณ Jeovane               บ Data da Criacao  ณ 18/02/2009             						บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Impressao de uma Nota Fiscal a partir de dados gerados em GerNFSai e GeraNFEnt                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Leite                 						                                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                  							             													บฑฑ
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
ฑฑบ          ณ00/00/0000ณ                               				   ณ00-000000 -                       ณ TI	        บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑบ          ณ          ณ                    							   ณ                                  ณ 			บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑศออออออออออฯออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออออออออออออออออออออออออออออออฯอออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function Imprime()

Local i    := 0
Local aAux := {}
XITENS     := 0
xTOT_ITENS := 0
I          := 1
_nPag      := 1
nTamDet    := 24 // Quantidade maxima de itens impressos na Nota
_nImprime  := Len(xCOD_PRO)/nTamDet


If (_nImprime-Int(_nImprime))*100 <> 0
	_nImprime := Int(_nImprime)+1
Endif

While _nPag <= _nImprime

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Iniciando a contagem da linha de impressao. ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	nLin := 2
	nLin += 1

	If mv_par04 == 2
		@ nLin, 55 PSAY "X"
	Else
		@ nLin, 61 PSAY "X"
	Endif
	@ nLin, 73 PSAY xNUM_NF


	nLin += 7

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Impressao do Dados do Destinatario/Remetente                 ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	// Se for Nf de Municipio muda dados do Cabec
	if xGLTTP=="M"
		xNOME_CLI	:= "PRODUTORES DE LEITE DIVERSOS"
		xCGC_CLI 	:= ""
		xEND_CLI	:= "DIVERSOS"
		xBAIRRO		:= " "
		xCEP_CLI	:= " "
		xDDD_CLI	:= " "
		xTEL_CLI	:= " "
		xINSC_CLI	:= "DIVERSOS"
		aAux:=getEstMun(xfilial("SF1")+xNUM_NF+xSERIE+xFORNECE+xLOJA+xNFESPECIE)
		xMUN_CLI 	:= left( aAux[1] , 30 )
		xEST_CLI	:= aAux[2]
	endif
	nLin += 3
	@ nLin, 001 PSAY Alltrim(xNOME_CLI)+" - "+Alltrim(XCOD_CLI) // Nome do Cliente
	If Empty(xCGC_CLI)							 // CGC do Cliente
		@ nLin, 53 PSAY "DIVERSOS"
	ElseIf Len(AllTrim(xCGC_CLI))==14
		@ nLin, 53 PSAY xCGC_CLI		Picture "@R 99.999.999/9999-99"
	Else
		@ nLin, 53 PSAY xCGC_CLI		Picture "@R 999.999.999-99"
	EndIf
	@ nLin, 74 PSAY xEMISSAO					// Data da Emissao do Documento

	nLin += 3
	@ nLin, 001 PSAY xEND_CLI					// Endereco
	@ nLin, 042 PSAY xBAIRRO					// Bairro
	@ nLin, 062 PSAY xCEP_CLI		Picture "@R 99999-999"			// CEP
	if mv_par04 == 2
		@ nLin, 074 PSAY DtoC(xData)				// Data da Emissao do Documento
	else
		@ nLin, 074 PSAY xEMISSAO					// Data da Emissao do Documento
	endif

	nLin	+= 3
	@ nLin, 001 PSAY xMUN_CLI					// Municipio
	@ nLin, 033 PSAY xDDD_CLI	     			// DDD
	@ nLin, 036 PSAY xTEL_CLI	Picture "@R 9999-9999"				// Telefone/FAX
	@ nLin, 050 PSAY xEST_CLI					// U.F.
	@ nLin, 055 PSAY xINSC_CLI					// Insc. Estadual
	@ nLin, 074 PSAY xHora//Time()  			// Hora

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Impressao dos Dados de Fatura/Duplicata                      ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If mv_par04 == 2  //Se Nota de Saida
		nLin		+= 4
		BB			:= 1
		nCol	   := 01
		DUPLIC()
	Endif

	nLin := 24
	ImpDet()

	nLin := 41
	if xDESCCONV > 0
		@ nLin, 012  PSAY Iif(_nPag == _nImprime,"DESCONTO REF. RED. BASE DE CALC. ICMS....: " + alltrim(Transform(xDESCCONV	,"@E 999,999,999.99")),"XXXXXX,XX")	// Desconto referente ao convenio 100/97
	endif

	nLin := 42

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Impressao de Dados dos Impostos                              ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	@ nLin, 000  PSAY Iif(_nPag == _nImprime,Transform(xBASE_ICMS	,"@E 999,999,999.99"),"XXXXXX,XX")	// Base do ICMS
	@ nLin, 017  PSAY Iif(_nPag == _nImprime,Transform(xVALOR_ICMS	,"@E 999,999,999.99"),"XXXXXX,XX")	// Valor do ICMS
	@ nLin, 032  PSAY Iif(_nPag == _nImprime,Transform(xBSICMRET	,"@E 999,999,999.99"),"XXXXXX,XX")	// Base ICMS Ret.
	@ nLin, 048  PSAY Iif(_nPag == _nImprime,Transform(xICMS_RET	,"@E 999,999,999.99"),"XXXXXX,XX")	// Valor  ICMS Ret.
	@ nLin, 065  PSAY Iif(_nPag == _nImprime,Transform(Iif(xTipo == "I",0,xTOT_ITENS)	,"@E 999,999,999.99"),"XXXXXX,XX")	// Valor Total dos Itens

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Impressao de Dados do Frete                                  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	nLin += 3
	@ nLin, 000  PSAY Iif(_nPag == _nImprime,Transform(xFRETE		,"@E 999,999,999.99"),"XXXXXX,XX")	// Valor do Frete
	@ nLin, 017  PSAY Iif(_nPag == _nImprime,Transform(xSEGURO		,"@E 999,999,999.99"),"XXXXXX,XX")	// Valor Seguro
	@ nLin, 032  PSAY Iif(_nPag == _nImprime,Transform(xDESPESA		,"@E 999,999,999.99"),"XXXXXX,XX")	// Despesas Acessorias
	@ nLin, 048  PSAY Iif(_nPag == _nImprime,Transform(xVALOR_IPI	,"@E 999,999,999.99"),"XXXXXX,XX")	// Valor do IPI
	@ nLin, 065  PSAY Iif(_nPag == _nImprime,Transform(Iif(xTipo == "I",0,xTOT_FAT-xDESCCONV)	,"@E 999,999,999.99"),"XXXXXX,XX")	// Valor Total NF


	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Impressao do Transportador / Volumes Transportados.             ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	nLin += 4
	If !Empty(Alltrim(xNOME_TRANSP))
		@ nLin, 001 PSAY Iif(_nPag == _nImprime,Substr(xNOME_TRANSP,1,40),"XXXXXXXXXXXXXXXXXXXX")	// Nome Transp.
	Else
		@ nLin, 001 PSAY "O PROPRIO"
	EndIf

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณFrete por conta do Emitente (1-CIF) ou Destinatario(2-FOB) ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

	If xTPFRETE=='C'
		@ nLin, 047 PSAY Iif(_nPag == _nImprime,"1","X")
	Else
		@ nLin, 047 PSAY Iif(_nPag == _nImprime,"2","X")
	Endif

	If Empty(xCGC_TRANSP)
		@ nLin, 065 PSAY " "
	Else
		If Len(AllTrim(xCGC_TRANSP))==14
			@ nLin, 065 PSAY Iif(_nPag == _nImprime,alltrim(Transform(xCGC_TRANSP,"@R 99.999.999/9999-99")),"XX.XXX.XXX/XXXX-XX")
		Else
			@ nLin, 065 PSAY Iif(_nPag == _nImprime,alltrim(Transform(xCGC_TRANSP,"@R 999.999.999-99")),"XXX.XXX.XXX-XX")
		EndIf
	endif

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Endereco da Transportadora. ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	nLin += 2


	@ nLin, 001 PSAY Iif(_nPag == _nImprime,xEND_TRANSP,"XXXXXXXXX")	// Endereco Transp.
	@ nLin, 045 PSAY Iif(_nPag == _nImprime,xMUN_TRANSP,"XXXXXXXXX")	// Municipio
	@ nLin, 061 PSAY Iif(_nPag == _nImprime,xEST_TRANSP,"XXXXXXXXX")	// U.F.
	@ nLin, 065 PSAY Iif(_nPag == _nImprime,xIE_TRANSP	,"XXXXXXXXX")	// Reservado p/Insc. Estad.

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Quantidade transportada.    ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	nLin += 3
	if xVOLUME > 0
		@ nLin, 001 PSAY Iif(_nPag == _nImprime,Transform(xVOLUME,"@E@Z 99999999.99"),"XXXX")    // Quant. Volumes\
	endif
	if !empty(xESPECIE)
		@ nLin, 030 PSAY Iif(_nPag == _nImprime,Transform(xESPECIE	,"@!") 			,"XXXX")    // Especie
	endif
	@ nLin, 056 PSAY xMarca                                         // Res para Marca
	@ nLin, 054 PSAY " "                                           // Res para Numero

	if xC5_PBRUTO == 0
		for i := 1 to len(xPESOBRUTO)
			xC5_PBRUTO += xPESOBRUTO[i]
		next i
	endif


	@ nLin, 117 PSAY Iif(_nPag == _nImprime,Transform(xC5_PBRUTO,"@E@Z 999,999.9999"),"XXXXXX")      // Res para Peso Bruto

	if xC5_PESOL == 0
		for i := 1 to len(xPESO_ITEM)
			xC5_PESOL += xPESO_ITEM[i]
		next i
	endif


	@ nLin, 070 PSAY Iif(_nPag == _nImprime,Transform(xC5_PESOL,"@E@Z 999,999.9999"),"XXXXXX")      // Res para Peso Liquido



	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Impressao dos Dados Adicionais / Informacoes complementares.    ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	nLin := 57
	ImpQtdDias() // Imprime eventos de descontos

	MENSOBS() //Imprime texto contido no SC5->C5_MENNOTA
	IMPMENP() //Imprime mensagem padrao - consulta ao cadastro de formulas
	MSGTES() //Imprime mensagens amarradas a TES pelo campo Formula




	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Numero da Nota Fiscal ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	nLin := 80
	@ nLin, 070 PSAY xNUM_NF

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Controle do Salto de pagina. ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	nLin := 88
	@ nLin, 000 PSAY ""

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Zera o Formulario   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	SetPrc(0,0)
	_nPag++

Enddo

Return .t.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ IMPDET     บ Autor ณ Jeovane               บ Data da Criacao  ณ 18/02/2009             						บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Impressao dos Itens de uma Nota Fiscal.                                                                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Leite                 						                                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                  							             													บฑฑ
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
ฑฑบ          ณ00/00/0000ณ                               				   ณ00-000000 -                       ณ TI	        บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑบ          ณ          ณ                    							   ณ                                  ณ 			บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑศออออออออออฯออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออออออออออออออออออออออออออออออฯอออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function IMPDET()
Local _ZI := 0

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Agrupa itens do array                   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
///aAgrupa

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Soma a quantidade de itens a processar. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
XITENS += nTamDet


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Imprime os itens da Nota.               ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
XVOLUME:=0
For _ZI := 1 to XITENS
	If _ZI <= Len(xCOD_PRO) .AND. !xTIPO_PRO[_ZI]$ "MO/SW"
		@ nLin, 000  PSAY right(ALLTRIM(xCOD_PRO[_ZI]),6)     //Codigo
		@ nLin, 008  PSAY ALLTRIM(xDESCRICAO[_ZI])   //Descricao
		@ nLin, 039  PSAY ALLTRIM(xCOD_TRIB[_ZI]+xSIT_TRIB[_ZI]) //ST
		@ nLin, 042  PSAY ALLTRIM(xUNID_PRO[_ZI]) //Unidade
		@ nLin, 045  PSAY xQTD_PRO[_ZI]               Picture"@E 9,999,999"
		@ nLin, 054  PSAY xPRE_UNI[_ZI]               Picture"@E 9999.9999"
		@ nLin, 064  PSAY xVAL_MERC[_ZI]              Picture"@E 999,999,999.99"
		@ nLin, 079  PSAY xICM_PROD[_ZI]              Picture"@E 99"
		nLin       += 1
		xTOT_ITENS += xVAL_MERC[_ZI]
		if xEventos[_ZI] $ cEvtVol
			xVOLUME    += xQTD_PRO[_ZI]
		endif
	Endif
Next

if xVOLUME == 0 .AND. len(xQTD_PRO) > 0
	If xQTD_PRO[1] > 0
		xVOLUME := xQTD_PRO[1]
	endif
endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Atribui a quantidade de itens processados. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
XITENS := _ZI

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Imprime mensagem no corpo da Nota.         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If _nPag == _nImprime
	nLin := 56
	MSGEXTRA()
EndIF

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ GerNfEnt    บ Autor ณ Jeovane               บ Data da Criacao  ณ 18/02/2009             						บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Imprime Mensagem do Campo C5_MENPAD                                                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Leite                 						                                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                  							             													บฑฑ
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
ฑฑบ          ณ00/00/0000ณ                               				   ณ00-000000 -                       ณ TI	        บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑบ          ณ          ณ                    							   ณ                                  ณ 			บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑศออออออออออฯออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออออออออออออออออออออออออออออออฯอออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function IMPMENP()

nTamObs := 80 // Informe aqui a quantidade de caracteres que serao impressos por linha.
nCol    := 001  // Informe aqui a coluna de impressao.
nAux    := 1   // Nao alterar.

If !Empty(xCOD_MENS)

	@ nLin, nCol PSAY ALLTRIM(UPPER(SUBSTR(FORMULA(xCOD_MENS),nAux,nTamObs)))
	nLin += 1
	nAux += nTamObs

	If !EMPTY(SUBSTR(FORMULA(xCOD_MENS),nAux,nTamObs))
		@ nLin, nCol PSAY ALLTRIM(UPPER(SUBSTR(FORMULA(xCOD_MENS),nAux,nTamObs)))
		nLin += 1
		nAux += nTamObs
	EndIf

	If !EMPTY(SUBSTR(FORMULA(xCOD_MENS),nAux,nTamObs))
		@ nLin, nCol PSAY ALLTRIM(UPPER(SUBSTR(FORMULA(xCOD_MENS),nAux,nTamObs)))
		nLin += 1
		nAux += nTamObs
	EndIf

	If !EMPTY(SUBSTR(FORMULA(xCOD_MENS),nAux,nTamObs))
		@ nLin, nCol PSAY ALLTRIM(UPPER(SUBSTR(FORMULA(xCOD_MENS),nAux,nTamObs)))
		nLin += 1
		nAux += nTamObs
	EndIf

	If !EMPTY(SUBSTR(FORMULA(xCOD_MENS),nAux,nTamObs))
		@ nLin, nCol PSAY ALLTRIM(UPPER(SUBSTR(FORMULA(xCOD_MENS),nAux,nTamObs)))
		nLin += 1
		nAux += nTamObs
	EndIf
Endif

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ GerNfEnt    บ Autor ณ Jeovane               บ Data da Criacao  ณ 18/02/2009             						บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Imprime Mensagem do Campo C5_MENOBS                                                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Leite                 						                                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                  							             													บฑฑ
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
ฑฑบ          ณ00/00/0000ณ                               				   ณ00-000000 -                       ณ TI	        บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑบ          ณ          ณ                    							   ณ                                  ณ 			บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑศออออออออออฯออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออออออออออออออออออออออออออออออฯอออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function MENSOBS()

Local nTamObs := 80 	// Informe aqui a quantidade de caracteres que serao impressos por linha.
Local nCol    := 001  	// Informe aqui a coluna de impressao.
Local nAux    := 1   	// Nao alterar.

If !Empty(xMENSAGEM)

	@ nLin, nCol PSAY ALLTRIM(UPPER(SUBSTR(xMENSAGEM,nAux,nTamObs)))
	nLin += 1
	nAux += nTamObs

	IF !EMPTY(SUBSTR(xMENSAGEM,nAux,nTamObs))
		@ nLin, nCol PSAY ALLTRIM(UPPER(SUBSTR(xMENSAGEM,nAux,nTamObs)))
		nLin += 1
		nAux += nTamObs
	EndIf

	IF !EMPTY(SUBSTR(xMENSAGEM,nAux,nTamObs))
		@ nLin, nCol PSAY ALLTRIM(UPPER(SUBSTR(xMENSAGEM,nAux,nTamObs)))
		nLin += 1
		nAux += nTamObs
	EndIf

	IF !EMPTY(SUBSTR(xMENSAGEM,nAux,nTamObs))
		@ nLin, nCol PSAY ALLTRIM(UPPER(SUBSTR(xMENSAGEM,nAux,nTamObs)))
		nLin += 1
		nAux += nTamObs
	EndIf

EndIf

//Caso codigo de receituario tenha sido preenchido imprime o mesmo
if !empty(xMENRECE)
	xMENRECE := "CONFORME RECEITUARIO NR.: " + xMENRECE
	@ nLin, nCol PSAY ALLTRIM(UPPER(xMENRECE))
	nLin ++
endif

//Caso tenha informacao sobre lotes
if !empty(xMENLOTE)
	cAux := alltrim(xMENLOTE)
	nAux := 1
	while nAux <= len(cAux)
		@ nLin, nCol PSAY ALLTRIM(UPPER(SUBSTR(cAux,nAux,80)))
		nLin ++
		nAux += 80
	enddo

endif

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ GerNfEnt    บ Autor ณ Jeovane               บ Data da Criacao  ณ 18/02/2009             						บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Imprime Mensagem do Campo C5_MENEXTR                                                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Leite                 						                                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                  							             													บฑฑ
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
ฑฑบ          ณ00/00/0000ณ                               				   ณ00-000000 -                       ณ TI	        บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑบ          ณ          ณ                    							   ณ                                  ณ 			บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑศออออออออออฯออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออออออออออออออออออออออออออออออฯอออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function MSGEXTRA()

Local nTamObs := 80 // Informe aqui a quantidade de caracteres que serao impressos por linha.
Local nCol    := 001  // Informe aqui a coluna de impressao.
Local nAux    := 1   // Nao alterar.

If !Empty(XMSG_EXTRA)

	@ nLin, nCol PSAY ALLTRIM(UPPER(SUBSTR(XMSG_EXTRA,nAux,nTamObs)))
	nLin += 1
	nAux += nTamObs

	IF !EMPTY(SUBSTR(XMSG_EXTRA,nAux,nTamObs))
		@ nLin, nCol PSAY ALLTRIM(UPPER(SUBSTR(XMSG_EXTRA,nAux,nTamObs)))
		nLin += 1
		nAux += nTamObs
	EndIf
EndIf

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ GerNfEnt    บ Autor ณ Jeovane               บ Data da Criacao  ณ 18/02/2009             						บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Imprime Mensagem do Campo SM4->M4FORMULA                                                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Leite                 						                                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                  							             													บฑฑ
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
ฑฑบ          ณ00/00/0000ณ                               				   ณ00-000000 -                       ณ TI	        บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑบ          ณ          ณ                    							   ณ                                  ณ 			บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑศออออออออออฯออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออออออออออออออออออออออออออออออฯอออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function MSGTES()
Local nCol    := 001  // Informe aqui a coluna de impressao.
Local nAux    := 1   // Nao alterar.
local cAux 	  := alltrim(XMSGTES)

If !Empty(cAux)

	while nAux <= len(cAux)
		@ nLin, nCol PSAY ALLTRIM(UPPER(SUBSTR(cAux,nAux,80)))
		nLin ++
		nAux += 80
	enddo


EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออออออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Duplic    บ Autor ณ Jeovane               บ Data da Criacao  ณ 18/02/2009             						บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDescricao ณ Imprime parcelas da NF                                                                                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Leite                 						                                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                  							             													บฑฑ
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
ฑฑบ          ณ00/00/0000ณ                               				   ณ00-000000 -                       ณ TI	        บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑบ          ณ          ณ                    							   ณ                                  ณ 			บฑฑ
ฑฑบ----------ณ----------ณ--------------------------------------------------ณ----------------------------------ณ-------------บฑฑ
ฑฑศออออออออออฯออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออออออออออออออออออออออออออออออฯอออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function DUPLIC()

_nCont  := 1
nCol    := 0
nAjuste := 1
_nTam   := 1

BB := 1
nAux := 0
while BB + nAux <= Len(xVALOR_DUP)
	If (xDUPLICATAS == .T.) .And. BB <= 4     //Len(xVALOR_DUP)
		nCol    := 01
		@ nLin, nCol      PSAY Iif(_nPag == _nImprime,xNUM_DUPLIC + "-" + xPARC_DUP[BB],"XXXXXXX")
		@ nLin, nCol + 40 PSAY Iif(_nPag == _nImprime,Transform(xVALOR_DUP[BB],"@E 9,999,999.99"),"XXXXXX,XX")
		@ nLin, nCol + 65 PSAY Iif(_nPag == _nImprime,xVENC_DUP[BB],CtoD(""))

		//verifica se existe parcelas a imprimir na segunda coluna - parcelas a partir da 4
		if (len(xVALOR_DUP) >= (_nCont + 4))
			nAux ++
			nCol    := 82
			@ nLin, nCol      PSAY Iif(_nPag == _nImprime,xNUM_DUPLIC + "-" + xPARC_DUP[BB+4],"XXXXXXX")
			@ nLin, nCol + 40 PSAY Iif(_nPag == _nImprime,Transform(xVALOR_DUP[BB+4],"@E 9,999,999.99"),"XXXXXX,XX")
			@ nLin, nCol + 65 PSAY Iif(_nPag == _nImprime,xVENC_DUP[BB+4],CtoD(""))
		endif
		_nCont  ++
		nLin ++
		BB ++
	Endif
enddo

Return


static function ImpQtdDias()
local aDescontos := {}
local nPosDesc := 1
local nTotDes := 0
Local nTotFun := 0

cFil := substr(cSeekD1,1,2)
cMix := substr(cSeekD1,3,6)
cVersao := substr(cSeekD1,9,1)
cCodProd := substr(cSeekD1,10,6)
cLoja := substr(cSeekD1,16,4)

aDescontos:={}
if xGLTTP=="M" // Se for NF de Municipio
	aDescontos := getDescMun(xfilial("SF1")+xNUM_NF+xSERIE+xFORNECE+xLOJA+xNFESPECIE)
else
	aDescontos := getDescontos(cFil,cMix,cVersao,cCodProd,cLoja) //Busca Descontos na ZLF
endif

nLin++

//Imprime Descontos
if len(aDescontos) > 0

	for nPosDesc:=1 to len(aDescontos)
		@ nLin, 000  PSAY aDescontos[nPosDesc,1]
		@ nLin, 007  PSAY left( aDescontos[nPosDesc,2] , 27 )
		@ nLin, 034  PSAY transform(aDescontos[nPosDesc,3],"@E 999,999.99")
		nTotDes += aDescontos[nPosDesc,3]
		if "FUNRURAL" $ aDescontos[nPosDesc,2] .OR. "INSS" $ aDescontos[nPosDesc,2]
			nTotFun += aDescontos[nPosDesc,3]
		endif
		nLin++
	next nPosDesc
	// Total dos Descontos
	nLin:=70
	@ nLin, 005  PSAY xNUM_NF
	@ nLin, 023  PSAY transform(nTotFun,"@E 999,999.99") //FUNRURAL
	@ nLin, 034  PSAY transform(nTotDes,"@E 999,999.99") // TOTAL DE DESCONTOS
	nLin+=2
	@ nLin, 034  PSAY transform(xTOT_ITENS-nTotDes,"@E 999,999.99") // LIQ.RECEBER
endif

nLin += 1 //
return



//user function get12(cFilial,cMix,cVersao,cCodProd,cLoja)
Static function getDescontos(cFil,cMix,cVersao,cCodProd,cLoja)
Local aDescNF := {}
Local aArea := GetArea()
Local cQuery := ""

cQuery := " SELECT ZLF.ZLF_EVENTO,ZLF.ZLF_TOTAL,ZL8.ZL8_DESCRI "
cQuery += " FROM "+RetSqlName("ZLF")+" ZLF  "
cQuery += " JOIN " +RetSqlName("ZL8")+" ZL8 ON ZLF.ZLF_EVENTO = ZL8.ZL8_COD "
cQuery += " WHERE ZLF.D_E_L_E_T_ = ' ' AND ZL8.D_E_L_E_T_ = ' '"
cQuery += " AND ZLF.ZLF_FILIAL = '"+xfilial("ZLF")+"' "
cQuery += " AND ZL8.ZL8_FILIAL = '"+xfilial("ZL8")+"' "
cQuery += " AND ZLF_FILIAL = '"+cFil+"' "
cQuery += " AND ZLF_CODZLE = '"+cMix+"' "
cQuery += " AND ZLF_VERSAO = '"+cVersao+"' "
cQuery += " AND ZLF_A2COD = '"+cCodProd+"' "
cQuery += " AND ZLF_A2LOJA = '"+cLoja+"' "
cQuery += " AND ZLF_DEBCRE = 'D' "

if Select("TRD") <> 0
	TRD->(dbclosearea())
endif

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRD", .T., .F. )

while !TRD->(eof())
	aadd(aDescNF,{TRD->ZLF_EVENTO,TRD->ZL8_DESCRI,TRD->ZLF_TOTAL})
	TRD->(dbskip())
enddo
TRD->(dbclosearea())

RestArea(aArea)

return aDescNF

Static function getDescMun(cSeek)
Local aDescMun := {}
Local aArea := GetArea()
Local cQuery := ""

cQuery := " SELECT SUM(ZLF.ZLF_TOTAL) AS TOTAL "
cQuery += " FROM "+RetSqlName("ZLF")+" ZLF  "
cQuery += " JOIN " +RetSqlName("ZL8")+" ZL8 ON ZLF.ZLF_EVENTO = ZL8.ZL8_COD "
cQuery += " WHERE ZLF.D_E_L_E_T_ = ' ' AND ZL8.D_E_L_E_T_ = ' '"
cQuery += " AND ZLF.ZLF_FILIAL = '"+xfilial("ZLF")+"' "
cQuery += " AND ZL8.ZL8_FILIAL = '"+xfilial("ZL8")+"' "
cQuery += " AND ZLF_F1SEEK = '"+cSeek+"' "
cQuery += " AND ZLF_DEBCRE = 'D' "
cQuery += " AND ZL8_GRUPO  != '"+cGrpImp+"' "

if Select("TRD") <> 0
	TRD->(dbclosearea())
endif

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRD", .T., .F. )

if !TRD->(eof())
	if TRD->TOTAL > 0
		aadd(aDescMun,{"999999","DESCONTOS EM FOLHA",TRD->TOTAL})
	endif
endif
TRD->(dbclosearea())


cQuery := " SELECT ZLF.ZLF_EVENTO AS EVENTO, SUM(ZLF.ZLF_TOTAL) AS TOTAL "
cQuery += " FROM "+RetSqlName("ZLF")+" ZLF  "
cQuery += " JOIN " +RetSqlName("ZL8")+" ZL8 ON ZLF.ZLF_EVENTO = ZL8.ZL8_COD "
cQuery += " WHERE ZLF.D_E_L_E_T_ = ' ' AND ZL8.D_E_L_E_T_ = ' '"
cQuery += " AND ZLF.ZLF_FILIAL = '"+xfilial("ZLF")+"' "
cQuery += " AND ZL8.ZL8_FILIAL = '"+xfilial("ZL8")+"' "
cQuery += " AND ZLF_F1SEEK = '"+cSeek+"' "
cQuery += " AND ZLF_DEBCRE = 'D' "
cQuery += " AND ZL8_GRUPO  = '"+cGrpImp+"' "
cQuery += " GROUP BY ZLF_EVENTO "

if Select("TRD") <> 0
	TRD->(dbclosearea())
endif

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRD", .T., .F. )

while !TRD->(eof())
	if TRD->TOTAL > 0
		aadd(aDescMun,{TRD->EVENTO,POSICIONE("ZL8",1,XFILIAL("ZL8")+TRD->EVENTO,"ZL8_DESCRI"),TRD->TOTAL})
	endif
	TRD->(dbskip())
enddo
TRD->(dbclosearea())

RestArea(aArea)

return aDescMun

Static Function getEstMun(cSeek)
Local aRet:={"",""}
Local aAreA:=GetArea()
cQuery := " SELECT ZLF_EST,ZLF_MUN "
cQuery += " FROM "+RetSqlName("ZLF")+" ZLF  "
cQuery += " WHERE ZLF.D_E_L_E_T_ = ' ' "
cQuery += " AND ZLF.ZLF_FILIAL = '"+xfilial("ZLF")+"' "
cQuery += " AND ZLF_F1SEEK = '"+cSeek+"' "
cQuery += " AND ZLF_EST != ' ' "
cQuery += " AND ZLF_MUN != ' ' "
dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRD", .T., .F. )

if !TRD->(eof())
	DbSelectArea("CC2")
	DbSetOrder(1)
	if DbSeek(xfilial("CC2")+TRD->ZLF_EST+TRD->ZLF_MUN)
		aRet:={CC2->CC2_MUN,CC2->CC2_EST}
	endif
endif
TRD->(DbcloseArea())

RestArea(aArea)
return aRet


Static Function obtemFretis()
	Local aArea:=GetArea()

	cLinha:=POSICIONE("SA2",1,XFILIAL("SA2")+xCOD_CLI,"A2_L_LI_RO")

	DbSelectArea("ZL3")
	DbSetOrder(1)
	DbSeek(XFILIAL("ZL3")+cLinha)

	DbSelectArea("SA2")
	DbSetorder(1)
	If dbSeek(xfilial("SA2")+ZL3->ZL3_FRETIS+ZL3->ZL3_FRETLJ)
		xNOME_TRANSP	:= SA2->A2_NOME		    // Nome Transportadora
		xEND_TRANSP		:= SA2->A2_END			// Endereco
		xMUN_TRANSP		:= SA2->A2_MUN			// Municipio
		xEST_TRANSP		:= SA2->A2_EST			// Estado
		xCGC_TRANSP		:= SA2->A2_CGC			// CGC
		xIE_TRANSP		:= SA2->A2_INSCR		// Inscricao Estadual
		xTEL_TRANSP		:= SA2->A2_TEL			// Fone
		xTPFRETE		:= "C"					// Tipo de Frete
	endif

	RestArea(aArea)
return
