#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GUIListView.au3>
#include <File.au3>
#include <array.au3>
#include "ArrayMultiColSort.au3"
;===================== VARIABLES | ARRAYS ==============================================================================================================================================================
Global $arrayIndex = 0
Global $r = 1
Global $firstUse = False

Global $cardArray[$r][4] ;0 -> number, 1-> civ, 2->name, 3-> remarks
Global $listArray[$r][4]
;===================== SORTING TEMPLATE ================================================================================================================================================================
Global $sortingTemplate[3][2] = [ _
        [1, "Fire,Nature,Water,Darkness,Light,Rainbow,Zero"], _
        [0, 1], _
        [2, 0]]
;===================== GUI START =======================================================================================================================================================================
$stdForm = GUICreate("Callisto Deck Builder by Coestar | duelmasters.com.pl", 623, 309, 601, 257)

$addCardsGroup = GUICtrlCreateGroup("Add cards", 10, 10, 211, 201)
$numLabel = GUICtrlCreateLabel("#", 20, 30, 11, 17)
$nameLabel = GUICtrlCreateLabel("Name:", 60, 30, 35, 17)
$remLabel = GUICtrlCreateLabel("Remarks:", 20, 80, 49, 17)

$numInput = GUICtrlCreateInput("", 20, 50, 31, 21)
$nameInput = GUICtrlCreateInput("", 60, 50, 151, 21)
$remInput = GUICtrlCreateEdit("", 20, 100, 191, 71)

$civCombo = GUICtrlCreateCombo("Select a civilization", 20, 180, 191, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData($civCombo, "Nature|Fire|Light|Darkness|Water|Rainbow|Zero", "Select a civilization")

$addButton = GUICtrlCreateButton("Add card...", 10, 220, 101, 41)
$delButton = GUICtrlCreateButton("Delete card...", 120, 220, 101, 41)
$generateButton = GUICtrlCreateButton("Generate BBCode", 10, 260, 211, 21)
$hzButton = GUICtrlCreateButton("Hyperspatial Zone", 10, 280, 211, 21)

$deckGroup = GUICtrlCreateGroup("Deck", 240, 10, 371, 291)

$deckList = GUICtrlCreateListView("# | C | Name | Remarks", 250, 30, 351, 261)

GUISetState(@SW_SHOW)
;===================== GUI END =========================================================================================================================================================================
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit
		Case $hzButton
			hz()
		Case $generateButton
			generate()
		Case $addButton
			add()
		Case $delButton
			del()
	EndSwitch
WEnd
;=======================================================================================================================================================================================================
Func debug()
	sortBoth()
	_ArrayDisplay($cardArray)
EndFunc

Func generate()
	sortBoth()

	Dim $total = 0

	$iRem = MsgBox(4, "Remarks", "Do you want to enable remarks? (If you select ''No'', the Remarks column will be ignored entirely).")

	_FileCreate(@ScriptDir & "\result.txt")
	$hFile = FileOpen(@ScriptDir & "\result.txt", 1)

	FileWrite($hFile, "[table]" & @CRLF)

	$header = "[tr][td][b]#[/b][/td][td][b]C[/b][/td][td][b]Name[/b][/td]"
	If $iRem <> 7 Then
		$header = $header & "[td][b]Remarks[/b][/td]"
	EndIf
	$header = $header & "[/tr]"
	FileWrite($hFile, $header & @CRLF)

	For $i = 0 To $arrayIndex-1 Step +1
		$string = "[tr][td]" & $cardArray[$i][0] & "[/td]"

		Switch $cardArray[$i][1]
			Case "Fire"
				$string = $string & "[td][color=red]R[/color][/td]"
			Case "Water"
				$string = $string & "[td][color=#1E90FF]U[/color][/td]"
			Case "Darkness"
				$string = $string & "[td][color=#C71585]B[/color][/td]"
			Case "Light"
				$string = $string & "[td][color=#FFD700]Y[/color][/td]"
			Case "Nature"
				$string = $string & "[td][color=#32CD32]G[/color][/td]"
			Case "Rainbow"
				$string = $string & "[td][color=#DDA0DD]M[/color][/td]"
			Case "Zero"
				$string = $string & "[td][color=#A9A9A9]Z[/color][/td]"
		EndSwitch

		$string = $string & "[td][d]" & $cardArray[$i][2] & "[/d][/td]"

		If $iRem <> 7 Then
			$string = $string & "[td][i]" & $cardArray[$i][3] & "[/i][/td]"
		EndIf

		$string = $string & "[/tr]"
		FileWrite($hFile, $string & @CRLF)
	Next

	For $i = 0 To $arrayIndex-1 Step +1
		$total += $cardArray[$i][0]
	Next

	$footer = "[tr][td][b]" & $total & "[/b][/td][td][/td][td][b]TOTAL[/b][/td]"
	If $iRem <> 7 Then
		$footer = $footer & "[td][/td]"
	EndIf
	$footer = $footer & "[/tr]"
	FileWrite($hFile, $footer & @CRLF)

	FileWrite($hFile, "[/table]" & @CRLF)
	FileWrite($hFile, "[size=x-small]Generated with [url=http://duelmasters.com.pl/topic-Callisto-Deck-Builder]Callisto[/url][/size]")

	FileClose($hFile)

	MsgBox(0, "Note", "BB-Code saved to /result.txt")
EndFunc

Func add()
	If $firstUse == False Then
		$firstUse = True
	Else
		enlargeArrays()
	EndIf
	addToList()
	$arrayIndex += 1
	clearInput($remInput)
	clearInput($nameInput)
EndFunc

Func del()
	If UBound($cardArray, 1) == 1 Then
		MsgBox(0, "Error", "You can't delete the last item! You need to add at least one more.")
	Else
		Local $index
		$index = InputBox("Note", "Which item do you want to delete?")
		If UBound($cardArray, 1) < $index Then
			MsgBox(0, "Error", "There's no such item!")
		Else
			_GUICtrlListView_DeleteItem(GUICtrlGetHandle($deckList), $index-1)
			_ArrayDelete($cardArray, $index-1)
			$arrayIndex-=1
			shrinkArrays()
		EndIf
	EndIf
EndFunc

Func enlargeArrays()
	$r+=1
	ReDim $listArray[$r][4]
	ReDim $cardArray[$r][4]
EndFunc

Func shrinkArrays()
	$r-=1
	ReDim $listArray[$r][4]
	ReDim $cardArray[$r][4]
EndFunc

Func readInputs()
	$cardArray[$arrayIndex][0] = GUICtrlRead($numInput)
	If GUICtrlRead($civCombo) <> "Select a civilization" Then
		$cardArray[$arrayIndex][1] = GUICtrlRead($civCombo)
	Else
		$cardArray[$arrayIndex][3] = ""
	EndIf
	$cardArray[$arrayIndex][2] = GUICtrlRead($nameInput)
	$cardArray[$arrayIndex][3] = GUICtrlRead($remInput)
EndFunc

Func addToList()
	readInputs()
	$listArray[$arrayIndex][0] = GUICtrlCreateListViewItem($cardArray[$arrayIndex][0] & "|" & $cardArray[$arrayIndex][1] & "|" & $cardArray[$arrayIndex][2] & "|" & $cardArray[$arrayIndex][3], $deckList)
EndFunc

Func clearInput($hCtrl)
	GUICtrlSetData($hCtrl, "")
EndFunc

Func sortBoth()
	_ArrayMultiColSort($cardArray, $sortingTemplate)
EndFunc

Func hz()
	$flag = MsgBox(4, "Note", "Remember to generate your code now or it will be overwritten later. Have you done that?")
	If $flag == 6 Then
		GUISetState(@SW_DISABLE, $stdForm)
		hzGui()
		GUISetState(@SW_ENABLE, $stdForm)
	EndIf
EndFunc

;=======================================================================================================================================================================================================

Func hzGui()
	Global $temporalInputArray[8]
	Global $awakenedInputArray[8]

	Global $temporalArray[8]
	Global $awakenedArray[8]

	Dim $top=30

	$hzForm = GUICreate("Callisto Deck Builder by Coestar | Hyperspatial Zone | duelmasters.com.pl", 510, 341, 599, 255)

	$groupTemporal = GUICtrlCreateGroup("Temporal Side", 10, 10, 241, 261)
	For $i=0 To 7 Step +1
		$temporalInputArray[$i] = GUICtrlCreateInput("", 20, $top, 221, 21)
		$top+=30
	Next
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$top = 30

	$groupAwakened = GUICtrlCreateGroup("Awakened Side", 260, 10, 241, 261)
	For $i=0 To 7 Step +1
		$awakenedInputArray[$i] = GUICtrlCreateInput("", 270, $top, 221, 21)
		$top+=30
	Next
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$appendButton = GUICtrlCreateButton("Append code.", 10, 280, 491, 51)
	GUISetState(@SW_SHOW)

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				GUIDelete($hzForm)
				ExitLoop
			Case $appendButton
				append()
				GUIDelete($hzForm)
				ExitLoop
		EndSwitch
	WEnd
EndFunc

Func append()
	$flag = MsgBox(4, "Note", "Are you sure? This is one-take operation. If something goes wrong, you'll need to re-create the file.")
	If $flag == 6 Then
		hzRead()
		$hFile = FileOpen(@ScriptDir & "\result.txt", 1)

		FileWrite($hFile, @CRLF & @CRLF & @CRLF)
		FileWrite($hFile, "[table]" & @CRLF)
		FileWrite($hFile, "[tr][td][b][u]Hyperspatial Zone:[/u][/b][/td][td][/td][/tr]" & @CRLF)

		For $i=0 To 7 Step +1
			If $temporalArray[$i] <> "" Or $awakenedArray[$i] <> "" Then
				FileWrite($hFile, "[tr][td][d]" & $temporalArray[$i] & "[/d][/td][td][d]" & $awakenedArray[$i] & "[/d][/td][/tr]" & @CRLF)
			Else
				ExitLoop
			EndIf
		Next

		FileWrite($hFile, "[/table]")

		MsgBox(0, "Note", "Code appended.")
	EndIf
EndFunc

Func hzRead()
	For $i=0 To 7 Step +1
		 $temporalArray[$i] = GUICtrlRead($temporalInputArray[$i])
		$awakenedArray[$i] = GUICtrlRead($awakenedInputArray[$i])
	Next
EndFunc





