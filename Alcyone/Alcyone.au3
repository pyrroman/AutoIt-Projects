#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.8.1
 Author:         MrHudson

 Script Function:
	Similarly to Adrianne, that's another quiz utility.

#ce ----------------------------------------------------------------------------

#NoTrayIcon

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

;Arrays
global $edithandle[30]
global $editread[30]
global $btn[3]

;Temporary variables
$i = 0
$sec = 59
$min = 59

;General variables
global $blocker = 0

;Coordinates
$hzspan = 198
$vtspan = 73
$width = 188
$height = 65
$top = 96
$left = 8

;Reference
global const $LOGPATH = @ScriptDir & "\info.log"
global const $HTMLPATH = @ScriptDir & "\queries.html"
global const $IMGPATH = @ScriptDir & "\img.jpg"

;Adlib
AdlibRegister("Timer", 1000)

#Region ### START Koda GUI section ### Form=
$form = GUICreate("Alcyone v1 by MrHudson", 999, 615, 351, 233)
$img = GUICtrlCreatePic($IMGPATH, 8, 8, 729, 81)
$timer = GUICtrlCreateLabel("MM:SS", 816, 8, 107, 41)
GUICtrlSetFont(-1, 24, 400, 0, "MS Sans Serif")
$nsinput = GUICtrlCreateInput("", 752, 64, 233, 21)
$nslabel = GUICtrlCreateLabel("Imie i nazwisko:", 752, 48, 150, 16)
$btn[0] = GUICtrlCreateButton("WYSLIJ", 8, 528, 337, 73)
$btn[1] = GUICtrlCreateButton("WYCZYSC", 352, 528, 337, 73)
$btn[2] = GUICtrlCreateButton("Pytania", 696, 528, 289, 73)

GenerateEdit(0, 4)
GenerateEdit(5, 9)
GenerateEdit(10, 14)
GenerateEdit(15, 19)
GenerateEdit(20,24)
GenerateEdit(25, 29)
ClearEdits()


GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

$msg = 0
while $msg <> $GUI_EVENT_CLOSE
$msg = GUIGetMsg()
	if $msg = $btn[0] Then
		f0()
	EndIf
	if $msg = $btn[1] Then
		f1()
	EndIf
	if $msg = $btn[2] Then
		f2()
	EndIf
wend

func f0()
	Save()
EndFunc

func f1()
	ClearEdits()
EndFunc

func f2()
	OpenQueries()
EndFunc

Func GenerateEdit($for, $to)
	for $i = $for to $to step +1
		$edithandle[$i] = GUICtrlCreateEdit("", $left, $top, $width, $height)
		$left += $hzspan
	next
	$top += $vtspan
	$left = 8
endfunc

func ClearEdits()
	for $i = 0 to 29 step +1
		GUICtrlSetData($edithandle[$i], "Pytanie " & $i+1)
	Next
endfunc

func Save()
	if $blocker == 0 Then
		for $i = 0 to 29 step +1
			$editread[$i] = GuiCtrlRead($edithandle[$i])
			$nsread = GuiCtrlRead($nsinput)
		Next
		local $logHandle = FileOpen($LOGPATH, 1)
		FileWrite($logHandle, @CRLF & $nsread & @CRLF)
		for $i = 0 to 29 step +1
			FileWrite($logHandle, $i+1 & ") " & $editread[$i] & @CRLF)
		Next
		FileWrite($logHandle,"--------------" & @CRLF)
		FileClose($logHandle)
		$blocker = 1
	elseif $blocker = 1 Then
		MsgBox(0, "B31d!", "Nie mozesz wyslac testu kilka razy.")
	elseif $blocker = 2 Then
		MsgBox(0, "B31d!", "Po czasie!")
	Else
		MsgBox(0, "B31d!", "404")
	EndIf
endfunc

func OpenQueries()
	ShellExecute($HTMLPATH)
EndFunc

func Timer()
	$sec -= 1
	if $sec == 0 Then
		$sec = 59
		$min -= 1
	EndIf
	if $sec == 0 and $min == 0 Then
		Save()
		$blocker = 2
		MsgBox(0, "Koniec czasu!", "Wyniki twojej pracy zostaly zapisane.")
	EndIf
	if $blocker <> 2 Then
		GUiCtrlSetData($timer, $min & ";" & $sec)
	EndIf
EndFunc
