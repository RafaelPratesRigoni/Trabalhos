#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "RwMake.ch"

// Reserva de Fonte
User Function FINAY050()

	Local cQuerySA1 := ""
	Local cQuerySE1 := ""
	Local aItens    := {}
	Local aAreaSA3  := {}
	Local aAreaSA1  := {}
	Local nx        := 0
	Local oProcess
	Local _oHTML
	Local cEmail := "rigoni30@gmail.com;comercial.lacteos@nater.coop.br"

	If IsBlind() .Or. (Select("SM0") == 0)
		RpcSetType(3)
		RpcSetEnv("01", "01")
	EndIf

	cQuerySE1 := GetNextAlias()
	aAreaSA3 := SA3->(GetArea())

	SA3->(DbSetOrder(1))

	BeginSql Alias cQuerySE1
        SELECT
            E1_VEND1
        FROM
            %Table:SE1% SE1
            INNER JOIN %Table:SA3% SA1 ON (
                SA1.A3_COD = SE1.E1_VEND1
                AND SA1.%NotDel%
            )
        WHERE
            SE1.E1_VENCREA <= 'DaySub(DDATABASE, 2)'
            AND SE1.%NotDel%
            AND SE1.E1_SALDO > 0
            AND TRIM(SE1.E1_TIPO) IN ('NF', 'BO', 'DU')
            AND SE1.E1_FILIAL IN ('35', '47', '49')
            AND SA1.A3_YWCREP = 'S'
        GROUP BY
            SE1.E1_VEND1
        ORDER BY
            SE1.E1_VEND1 
	ENDSQL


	Begin Transaction
		Do While (cQuerySE1)->(!Eof())

			cQuerySA1 := GetNextAlias()

			BeginSQL ALIAS cQuerySA1
                    SELECT  A1_COD,A1_LOJA, COMPRA, F2_DOC, F2_SERIE, F2_VALBRUT
                    FROM   (SELECT A1_COD, A1_LOJA, ' 'AS COMPRA
                            FROM   %TABLE:SA1% SA1
                            WHERE  SA1.%NOTDEL%
                                AND SA1.A1_YFILLAC IN( '35', '47', '49' )
                                AND SA1.A1_LC > 1
                                AND NOT EXISTS(SELECT NULL
                                                FROM   %TABLE:SF2% SF2
                                                WHERE  SF2.%NOTDEL%
                                                        AND SF2.F2_CLIENTE = SA1.A1_COD
                                                        AND SF2.F2_LOJA = SA1.A1_LOJA)
                                AND SA1.A1_YVEND1 = %Exp:(cQuerySE1)->E1_VEND1%
                            UNION
                            SELECT F2_CLIENTE, F2_LOJA, MAX(SF2.F2_EMISSAO)
                            FROM   %TABLE:SF2% SF2, %TABLE:SA1% SA1
                            WHERE  SF2.%NOTDEL%
                                AND SF2.F2_FILIAL IN ( '35', '47', '49' )
                                AND SA1.%NOTDEL%
                                AND SA1.A1_COD = SF2.F2_CLIENTE
                                AND SA1.A1_LOJA = SF2.F2_LOJA
                                AND SA1.A1_LC > 1
                                AND SA1.A1_YFILLAC IN( '35', '47', '49' )
                                AND SA1.A1_YVEND1 = %Exp:(cQuerySE1)->E1_VEND1%
                            GROUP  BY F2_CLIENTE, F2_LOJA
                            HAVING TRUNC(SYSDATE) - TO_DATE(MAX(SF2.F2_EMISSAO), 'YYYYMMDD') >= 30
                                AND TRUNC(SYSDATE) - TO_DATE(MAX(SF2.F2_EMISSAO), 'YYYYMMDD') <= 120)
                    INNER JOIN %TABLE:SF2% F2
                            ON ( F2.F2_CLIENTE = A1_COD
                                    AND F2.F2_LOJA = A1_LOJA
                                    AND F2.F2_EMISSAO = COMPRA
                                    AND F2.%NOTDEL% )
			ENDSQL


			aItens   := {}
			aAreaSA1 := SA1->(GetArea())
			DBSelectArea(cQuerySA1)
			SA1->(DbSetOrder(1))

			While (cQuerySA1)->(!Eof())

				If SA1->(DbSeek(xFilial("SA1") + (cQuerySA1)->A1_COD + (cQuerySA1)->A1_LOJA))
					Aadd(aItens,{(cQuerySA1)->A1_COD,(cQuerySA1)->A1_LOJA, ALLTRIM(SA1->A1_NOME), (cQuerySA1)->COMPRA, (cQuerySA1)->F2_DOC, (cQuerySA1)->F2_SERIE, (cQuerySA1)->F2_VALBRUT})
				EndIf
				(cQuerySA1)->(DbSkip())
			EndDo

			If Len(aItens) > 0 .And. SA3->(DbSeek(FwFilial("SA3")+ (cQuerySE1)->E1_VEND1)) .And. !Empty(SA3->A3_EMAIL)
				//Cria o Objeto  de Envio do Workfow
				oProcess := TWFProcess():New('Mail','E-mail de Notificação')

				//Cria a Tarefa
				oProcess:NewTask("Informa dados dos Clientes","\web\wf\WEBCOM_Clientes_n_atendidos.html")

				// Assunto do E-mail
				oProcess:cSubject := "Relação Clientes Não Atendidos"

				// Funcão de Retorno do Worflow
				oProcess:bReturn := ""

				// Cria o Elemento HTML para manipular variáveis na Pagina
				_oHTML:= oProcess:oHTML

				//Alimenta as variaveis do HTML
                _oHTML:ValByName("DescVendedor"	   		, Capital(AllTrim(SA3->A3_NOME)))

				// Linhas Detalhes da Pagina
				_oHTML:ValByName("it.codigo"    ,{})
				_oHTML:ValByName("it.loja"      ,{})
				_oHTML:ValByName("it.nome"      ,{})
				_oHTML:ValByName("it.compra"    ,{})
				_oHTML:ValByName("it.nota"      ,{})
				_oHTML:ValByName("it.serie"     ,{})
				_oHTML:ValByName("it.valor"     ,{})

				//Alimenta a linha detalhe dos Itens da Pagina
				For nx := 1 To Len(aItens)

					aadd(_oHTML:ValByName("it.codigo")   ,aItens[nx,1])
					aadd(_oHTML:ValByName("it.loja")     ,aItens[nx,2])
					aadd(_oHTML:ValByName("it.nome")     ,aItens[nx,3])
					aadd(_oHTML:ValByName("it.compra")   ,sTod(aItens[nx,4]))
					aadd(_oHTML:ValByName("it.nota")     ,aItens[nx,5])
					aadd(_oHTML:ValByName("it.serie")    ,aItens[nx,6])
					aadd(_oHTML:ValByName("it.valor")    ,Transform(aItens[nx,7],"@E 999,999.99"))

				Next nx

				//Destinatário
				oProcess:cTo := Lower(AllTrim(SA3->A3_EMAIL))
				oProcess:cBCC := AllTrim(cEmail)

				//Inicia Workflow
				oProcess:Start()

				//Finaliza Processo do WorkFlow
				oProcess:Finish()
			EndIf
            
			(cQuerySE1)->(DbSkip())
		EndDo


	End Transaction

	(cQuerySE1)->(DbCloseArea())
	RestArea(aAreaSA3)
	RestArea(aAreaSA1)
	RpcClearEnv()

Return Nil
