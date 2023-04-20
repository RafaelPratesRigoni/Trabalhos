#include "Protheus.ch"
#include "Topconn.ch"


/*/{Protheus.doc} LJDEPSE1
Este Ponto de Entrada é acionado na finalização do Venda Assistida após a gravação 
do título a receber na tabela SE1, possibilitando que sejam realizadas gravações 
@author Rafael.Rigoni
@since 19/04/2023
@return 
/*/

User Function LJDEPSE1()


	DbSelectArea("SA2")
	DbSetOrder(1)

	IF DbSeek(xFilial("SA2") + SE1->E1_CLIENTE + SE1->E1_LOJA)

		If SA2->A2_L_TPFOR == "P"
		U_M460FIMA(SE1->E1_FILIAL,SE1->E1_NUM,SE1->E1_PREFIXO,SE1->E1_CLIENTE,SE1->E1_LOJA)
		
        ENDIF

	ENDIF
Return
