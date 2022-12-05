#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

/*/{Protheus.doc} SFCCOM01
Gatilho para para validar se texto já foi utilizado em outro cadastro
@author Dôglas
@since 28.09.2022
/*/
User Function SFCCOM01()
	Local aArea 	:= GetArea()
	Local cAliasA	:= GetNextAlias()
	Local _cTexto 	:= ""
	Local cQry 		:= ""

	cQry := " SELECT B1_XCODIME FROM "+RetSqlName("SB1")
	cQry += " WHERE D_E_L_E_T_ = '' "
	cQry += " AND B1_XCODIME = '"+AllTrim(M->B1_XCODIME)+"' "
	cQry += " AND B1_COD <> '"+AllTrim(M->B1_COD)+"' "
	cQry := ChangeQuery(cQry)
	DbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), cAliasA, .F., .T.)

	(cAliasA)->(DbGoTop())
	If Empty((cAliasA)->B1_XCODIME)
		_cTexto := M->B1_XCODIME
	Else
		M->B1_XCODIME := ""
	EndIf
	(cAliasA)->(DbCloseArea())

	RestArea(aArea)
Return _cTexto
