#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.8.1
 Author:         MrHudson

 Script Function:
	This counts proportions.

#ce ----------------------------------------------------------------------------

#NoTrayIcon
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

;Arrays
global $input[4]
global $read[4]

;GUI START @@@@@@@@@@@@@@@@@@@@@@@@@
$Form1 = GUICreate("Acrux", 197, 152, 192, 124)
$btn = GUICtrlCreateButton("FIRE LAZERS!", 8, 104, 177, 41)
$Label1 = GUICtrlCreateLabel("-", 88, 8, 14, 39)
GUICtrlSetFont(-1, 24, 400, 0, "MS Serif")
$Label2 = GUICtrlCreateLabel("-", 88, 41, 14, 39)
GUICtrlSetFont(-1, 24, 400, 0, "MS Serif")
$Label3 = GUICtrlCreateLabel("Input 'x' for the variable.", 8, 80, 116, 17)
$input[0] = GUICtrlCreateInput("", 8, 16, 73, 21)
$input[1] = GUICtrlCreateInput("", 105, 16, 73, 21)
$input[2] = GUICtrlCreateInput("", 8, 49, 73, 21)
$input[3] = GUICtrlCreateInput("", 105, 49, 73, 21)
GUISetState(@SW_SHOW)
;GUI END @@@@@@@@@@@@@@@@@@@@@@@@@@

$msg = 0
while $msg <> $GUI_EVENT_CLOSE
	$msg = GUIGetMsg()
	if $msg = $btn then
		dim $return
		$x = read()
		if $x == 0 Then
			$return = $read[1]*$read[2]/$read[3]
		elseif $x == 1 Then
			$return = $read[0]*$read[3]/$read[2]
		elseif $x == 2 Then
			$return = $read[0]*$read[3]/$read[1]
		elseif $x == 3 Then
			$return = $read[1]*$read[2]/$read[0]
		Else
			$return = "Something went wrong... Try again later."
		EndIf
		MsgBox(0, "Result", $return)
	endif
wend

func main()
	MsgBox(0, "penis", read())
EndFunc

func read()
	for $i = 0 to 3 step +1
		$read[$i] = GUICtrlRead($input[$i])
	Next
EndFunc
