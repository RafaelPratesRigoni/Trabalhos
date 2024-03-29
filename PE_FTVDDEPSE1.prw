#include "Protheus.ch"
#include "Topconn.ch"


/*/{Protheus.doc}  FTVDDEPSE1
Este Ponto de Entrada � acionado na finaliza��o do Venda Assistida ap�s a grava��o 
do t�tulo a receber na tabela SE1, possibilitando que sejam realizadas grava��es 
@author Rafael.Rigoni
@since 19/04/2023
@return 
/*/

User Function  FTVDDEPSE1()


	DbSelectArea("SA2")
	DbSetOrder(1)

	IF DbSeek(xFilial("SA2") + SE1->E1_CLIENTE + SE1->E1_LOJA)

		If SA2->A2_L_TPFOR == "P"
		U_M460FIMA(SE1->E1_FILIAL,SE1->E1_NUM,SE1->E1_PREFIXO,SE1->E1_CLIENTE,SE1->E1_LOJA)
		
        ENDIF

	ENDIF
Return
