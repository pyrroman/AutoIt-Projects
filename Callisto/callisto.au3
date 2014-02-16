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
;===================== VARIABLES =======================================================================================================================================================================
Global $cardArray[50][4] ;0 -> number, 1-> name, 2->remarks, 3-> civ
Global $listArray[50][4]

Global $arrayIndex = 0
;===================== GUI START =======================================================================================================================================================================
$stdForm = GUICreate("Callisto Deck Builder by Coestar | duelmasters.com.pl", 623, 309, 601, 257)

$addCardsGroup = GUICtrlCreateGroup("Add cards", 10, 10, 211, 201)
$numLabel = GUICtrlCreateLabel("#", 20, 30, 11, 17)
$nameLabel = GUICtrlCreateLabel("Name:", 60, 30, 35, 17)
$remLabel = GUICtrlCreateLabel("Remarks:", 20, 80, 49, 17)

$remInput = GUICtrlCreateEdit("", 20, 100, 191, 71)
$numInput = GUICtrlCreateInput("", 20, 50, 31, 21)
$nameInput = GUICtrlCreateInput("", 60, 50, 151, 21)

$civCombo = GUICtrlCreateCombo("Select a civilization", 20, 180, 191, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData($civCombo, "Nature|Fire|Light|Darkness|Water|Rainbow|Zero", "Select a civilization")

$deckGroup = GUICtrlCreateGroup("Deck", 240, 10, 371, 291)

$deckList = GUICtrlCreateListView("# | Name | Remarks | Civ", 250, 30, 351, 261)

$generateButton = GUICtrlCreateButton("Generate BBCode", 10, 260, 211, 21)
$advButton = GUICtrlCreateButton("Switch to advanced...", 10, 280, 211, 21)
$addButton = GUICtrlCreateButton("Add card...", 10, 220, 101, 41)
$delButton = GUICtrlCreateButton("Delete card...", 120, 220, 101, 41)

GUISetState(@SW_SHOW)
;===================== GUI END =========================================================================================================================================================================
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $advButton
			advanced()
		Case $generateButton
			generate()
		Case $addButton
			add()
		Case $delButton
			del()
	EndSwitch
WEnd
;=======================================================================================================================================================================================================
Func advanced()
	MsgBox(0, "Error", "Will be implemented soon (tm).")
EndFunc

Func generate()
	Dim $total = 0
	_FileCreate(@ScriptDir & "\result.txt")
	$hFile = FileOpen(@ScriptDir & "\result.txt", 1)
	FileWrite($hFile, "[table]" & @CRLF)
	FileWrite($hFile, "[tr][td][b]#[/b][/td][td][b]Name[/b][/td][td][b]Remarks[/b][/td][td][b]Civ[/b][/td][/tr]" & @CRLF)
	For $i = 0 To $arrayIndex-1 Step +1
		$string = "[tr][td]" & $cardArray[$i][0] & "[/td][td][d]" & $cardArray[$i][1] & "[/d][/td][td][i]" & $cardArray[$i][2] & "[/i][/td]"
		Switch $cardArray[$i][3]
			Case "Fire"
				$string = $string & "[td][color=red][b]R[/b][/color][/td]"
			Case "Water"
				$string = $string & "[td][color=#1E90FF][b]U[/b][/color][/td]"
			Case "Darkness"
				$string = $string & "[td][color=#C71585][b]B[/b][/color][/td]"
			Case "Light"
				$string = $string & "[td][color=#FFD700][b]Y[/b][/color][/td]"
			Case "Nature"
				$string = $string & "[td][color=#32CD32][b]G[/b][/color][/td]"
			Case "Rainbow"
				$string = $string & "[td][color=#DDA0DD][b]M[/b][/color][/td]"
			Case "Zero"
				$string = $string & "[td][color=#A9A9A9][b]Z[/b][/color][/td]"
			EndSwitch
		$string = $string & "[/tr]" & @CRLF
		FileWrite($hFile, $string)
	Next
	For $i = 0 To $arrayIndex Step +1
		$total += $cardArray[$i][0]
	Next
	FileWrite($hFile, "[tr][td][b]" & $total & "[/b][/td][td][b]TOTAL[/b][/td][td][/td][td][/td][/tr]" & @CRLF)
	FileWrite($hFile, "[/table]" & @CRLF)
	FileWrite($hFile, "[size=x-small]Generated with [url=http://duelmasters.com.pl/topic-Callisto-Deck-Builder]Callisto[/url][/size]")
	FileClose($hFile)
	MsgBox(0, "Note", "BB-Code saved to /result.txt")
EndFunc

Func add()
	addToList()
	$arrayIndex += 1
	clearInput($remInput)
	clearInput($nameInput)
EndFunc

Func del()
	Local $index
	$index = InputBox("Note", "Which item do you want to delete?")
	_GUICtrlListView_DeleteItem(GUICtrlGetHandle($deckList), $index-1)
	_ArrayDelete($cardArray, $index-1)
	$arrayIndex-=1
EndFunc

Func readInputs()
	$cardArray[$arrayIndex][0] = GUICtrlRead($numInput)
	$cardArray[$arrayIndex][1] = GUICtrlRead($nameInput)
	$cardArray[$arrayIndex][2] = GUICtrlRead($remInput)
	If GUICtrlRead($civCombo) <> "Select a civilization" Then
		$cardArray[$arrayIndex][3] = GUICtrlRead($civCombo)
	Else
		$cardArray[$arrayIndex][3] = ""
	EndIf
EndFunc

Func addToList()
	readInputs()
	$listArray[$arrayIndex][0] = GUICtrlCreateListViewItem($cardArray[$arrayIndex][0] & "|" & $cardArray[$arrayIndex][1] & "|" & $cardArray[$arrayIndex][2] & "|" & $cardArray[$arrayIndex][3], $deckList)
EndFunc

Func clearInput($hCtrl)
	GUICtrlSetData($hCtrl, "")
EndFunc













