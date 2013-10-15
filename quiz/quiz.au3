#cs -----------------------------------------------------------------------------

 AutoIt Version: 3.3.8.1
 Author:         MrHudson

 Script Function:
	Basic quiz/survey, whatever.

#ce -----------------------------------------------------------------------------

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <File.au3>

$filename = @ScriptDir & "/info.log"
global $iarr[4]
global $i
$blocker = 0

#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("quiz v1", 252, 262, 238, 142)
$iarr[0] = GUICtrlCreateInput("", 8, 24, 225, 21)
$Label1 = GUICtrlCreateLabel("You like trains?", 8, 8, 76, 17)
$iarr[1] = GUICtrlCreateInput("", 9, 73, 225, 21)
$Label2 = GUICtrlCreateLabel("You sure?", 9, 57, 52, 17)
$iarr[2] = GUICtrlCreateInput("", 8, 122, 225, 21)
$Label3 = GUICtrlCreateLabel("You absolutely sure?", 8, 106, 102, 17)
$iarr[3] = GUICtrlCreateInput("", 9, 168, 225, 21)
$Label4 = GUICtrlCreateLabel("You absolutely sure with marshmallow on top?", 9, 152, 220, 17)
$btn = GUICtrlCreateButton("FIRE LAZERS", 8, 200, 225, 41)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

$msg = 0
while $msg <> $GUI_EVENT_CLOSE
	$msg = GUIGetMsg()
	if $msg = $btn then
		main()
	endif
wend

func main()
	if $blocker <> 0 Then
		MsgBox(0, "Error", "You can't fill the quiz multiple times.")
	Else
		local $hfile = FileOpen($filename, 1)
		$size = UBound($iarr)
		global $rarr[$size]
		do
			$rarr[$i] = GUICtrlRead($iarr[$i])
			$i+=1
		Until $i == $size
		_FileWriteFromArray($hfile, $rarr)
		FileWrite($hfile,"--------" & @CRLF)
		FileClose($hfile)
		$blocker = 1
	EndIf
EndFunc