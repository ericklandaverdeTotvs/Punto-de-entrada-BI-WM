//********************************************************************************************************************************************
User Function BIEXTGRV
//********************************************************************************************************************************************

Local cAlias   := PARAMIXB[1] // Alias da Fato ou Dimensão em gravação no momento
Local aRet     := PARAMIXB[2] // Array contendo os dados do registro para manipulação
Local lIsDim   := PARAMIXB[3] // Variável que indica quando está gravando em uma Dimensão (.T.) ou Fato (.F.)

Local nPLivre0 := aScan(aRet, {|x| AllTrim(x[1]) == cAlias + "_LIVRE0"})
Local nPLivre1 := aScan(aRet, {|x| AllTrim(x[1]) == cAlias + "_LIVRE1"})
Local nPLivre2 := aScan(aRet, {|x| AllTrim(x[1]) == cAlias + "_LIVRE2"})
Local nPLivre3 := aScan(aRet, {|x| AllTrim(x[1]) == cAlias + "_LIVRE3"})
Local nPLivre4 := aScan(aRet, {|x| AllTrim(x[1]) == cAlias + "_LIVRE4"})
Local nPLivre5 := aScan(aRet, {|x| AllTrim(x[1]) == cAlias + "_LIVRE5"})
Local nPLivre6 := aScan(aRet, {|x| AllTrim(x[1]) == cAlias + "_LIVRE6"})
Local nPLivre7 := aScan(aRet, {|x| AllTrim(x[1]) == cAlias + "_LIVRE7"})
Local nPLivre8 := aScan(aRet, {|x| AllTrim(x[1]) == cAlias + "_LIVRE8"})
Local nPLivre9 := aScan(aRet, {|x| AllTrim(x[1]) == cAlias + "_LIVRE9"})
Local nPVRLMes := aScan(aRet, {|x| AllTrim(x[1]) == cAlias + "_VRLMES"})
Local nPIndica := aScan(aRet, {|x| AllTrim(x[1]) == cAlias + "_INDICA"})

Local nTamCli    := TamSX3("F2_CLIENTE")[1]
Local nTamLoja   := TamSX3("F2_LOJA")[1]
Local nTamDoc    := TamSX3("F2_DOC")[1] 
Local nTamSerie  := TamSX3("F2_SERIE")[1]
Local nTamTipo   := TamSX3("F2_TIPO")[1]

Local nTamMarca  := TamSX3("B1_MARCA")[1]
Local nTamTipoP  := TamSX3("B1_TIPO")[1]

Local nTamChave  := TamSX3("X5_CHAVE")[1]

Local cMarca    := ""
Local cTipo     := ""
Local cNaturez  := ""

Local nPCod     := ""

local nPClien   := 0
local nPLoja    := 0
local nPDoc     := 0
local nPSerie   := ""
Local nPTipo    := ""
Local nPEspecie := ""

If lIsDim
	/* Dimensión*/
		//ConOut("Entro a BIEXTGRV Dimensión.")

	If  cAlias $ "HJ8"
		/*Tabla SB1 Productos
		Indice 1 /* B1_FILIAL + F1_COD */

		/*Tabla SX5
		Indice 1 /* X5_FILIAL+X5_TABELA+X5_CHAVE */

		nPCod:= aScan(aRet, {|x| AllTrim(x[1]) == "HJ8_CODIGO"})
		//ConOut("nPCod: " + Alltrim(aRet[nPCod][2]))
		
		cMarca := POSICIONE("SB1", 1, XFILIAL("SB1") + Padr( aRet[nPCod][2], nTamMarca), "B1_MARCA")
		//ConOut("cMarca: " + Alltrim(cMarca))
		cMarca := POSICIONE("SX5", 1, XFILIAL("SX5") + "KL" + Padr( cMarca, nTamChave), "X5_DESCRI")
		//ConOut("cMarca: " + Alltrim(cMarca))

		cTipo := POSICIONE("SB1", 1, XFILIAL("SB1") + Padr( aRet[nPCod][2], nTamTipoP), "B1_TIPO")
		//ConOut("cTipo: " + Alltrim(cTipo))
		cTipo := POSICIONE("SX5", 1, XFILIAL("SX5") + "02"+ Padr( cTipo, nTamChave), "X5_DESCRI")
		//ConOut("cTipo: " + Alltrim(cTipo))
		//ConOut("Entro a " + Alltrim(cAlias) + ", cMarca: " + Alltrim(cMarca) + ", cTipo: " + Alltrim(cTipo))
		
	EndIf

		aRet[nPLivre0][2] := Alltrim(cValToChar(cMarca))
		aRet[nPLivre1][2] := Alltrim(cValToChar(cTipo))
Else
	/* Hecho */
		//ConOut("Entro a BIEXTGRV Hecho.")

	//If  cAlias $ "HL0|HL1|HL2|HL3|HL4|HL5|HL6|HL7|HQ2|HQ3|HHA|HHB"
	//If  cAlias $ "HL2|HL4" 
	If  cAlias $ "HL2"

		/*Tabla SF2 Facturacion
		Indice 1 /* F2_FILIAL + F2_DOC + F2_SERIE + F2_CLIENTE + F2_LOJA + F2_FORMUL + F2_TIPO 
		Indice 2 /* F2_FILIAL + F2_CLIENTE + F2_LOJA + F2_DOC + F2_SERIE + F2_TIPO + F2_ESPECIE */
		*/
		//Datos a obtener de la SD2

		IF cAlias == "HL2"
		
			nPClien := aScan(aRet, {|x| AllTrim(x[1]) == "A1_COD"}) 
			nPLoja  := aScan(aRet, {|x| AllTrim(x[1]) == "A1_LOJA"})
			nPDoc   := aScan(aRet, {|x| AllTrim(x[1]) == "HL2_NUMNF"})
			nPSerie := aScan(aRet, {|x| AllTrim(x[1]) == "HL2_SERNF"})
			nPTipo  := aScan(aRet, {|x| AllTrim(x[1]) == "HL2_TPNOTA"})
			
			cNaturez := POSICIONE("SF2", 2, XFILIAL("SF2") + Padr( aRet[nPClien][2], nTamCli) + Padr( aRet[nPLoja][2], nTamLoja) + ;
			Padr( aRet[nPDoc][2], nTamDoc) + Padr(aRet[nPSerie][2], nTamSerie) + Padr( aRet[nPTipo][2], nTamTipo ), "F2_NATUREZ")
			//ConOut("cNaturez: " + Alltrim(cNaturez))
		
			cNaturez := POSICIONE("SED", 1, XFILIAL("SED") + cNaturez, "ED_DESCRIC")
			//ConOut("cNaturez: " + Alltrim(cNaturez))
			//ConOut("Entro a " + Alltrim(cAlias) + ", cNaturez: " + Alltrim(cNaturez))

		/*
		ElseIF cAlias == "HL4"

			varinfo( "aRet", aRet)
			
			nPClien := aScan(aRet, {|x| AllTrim(x[1]) == "A1_COD"}) 
			nPLoja  := aScan(aRet, {|x| AllTrim(x[1]) == "A1_LOJA"})
			nPDoc   := aScan(aRet, {|x| AllTrim(x[1]) == "HL2_NUMNF"})
			nPSerie := aScan(aRet, {|x| AllTrim(x[1]) == "HL2_SERNF"})
			nPTipo  := aScan(aRet, {|x| AllTrim(x[1]) == "HL2_TPNOTA"})

			cNaturez := POSICIONE("SF2", 2, XFILIAL("SF2") + Padr( aRet[nPClien][2], nTamCli) + Padr( aRet[nPLoja][2], nTamLoja) + ;
			Padr( aRet[nPDoc][2], nTamDoc) + Padr(aRet[nPSerie][2], nTamSerie) + Padr( aRet[nPTipo][2], nTamTipo ), "F2_NATUREZ")
			ConOut("cNaturez: " + Alltrim(cNaturez))
		
			cNaturez := POSICIONE("SED", 1, XFILIAL("SED") + cNaturez, "ED_DESCRIC")
			ConOut("cNaturez: " + Alltrim(cNaturez))

			ConOut("Entro a " + Alltrim(cAlias) + ", cNaturez: " + Alltrim(cNaturez))
		*/
		EndIf

		// Tabla SED para acceder a la Naturaleza
	EndIf
		aRet[nPLivre8][2] := Alltrim(cNaturez)
EndIf

Return aRet

//********************************************************************************************************************************************
User Function BIUSRTAB
//********************************************************************************************************************************************
Local aRet   := {}
Local cAlias := PARAMIXB[1] // Alias da tabela Fato / Dimensão que está sendo executada

//If  cAlias $ "HJ8|HL0|HL1|HL2|HL3|HL4|HL5|HL6|HL7|HQ2|HQ3|HHA|HHB"
If  cAlias $ "HJ8|HL2|HL4"

	aRet := {"SA1","SF2","SED","SB1","SC5","SC6"}
	//ConOut("Pasó el punto BIUSRTAB")
EndIf

Return aRet