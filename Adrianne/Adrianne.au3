#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.8.1
 Author:         MrHudson

 Script Function:
	This has been created for a project.

#ce ----------------------------------------------------------------------------

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <File.au3>

#NoTrayIcon

; Arrays
Global $labelHandles[30]
Global $inputHandles[30]
Global $inputRead[30]
Global $labelRead[30]

; Temporary variables
$i = 0
$span = 41
$inputLength = 235
$blocker = 0

; Globals
global $left = 8
global $topLabel = 96
global $topInput = 112

; Reference
global const $INIPATH = @ScriptDir & "\queries.ini"
global const $INISECT = "Queries"
global const $IMGPATH = @ScriptDir & "\img.jpg"
global const $LOGPATH = @ScriptDir & "\info.log"

#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Adrianne v3 by MrHudson", 778, 558, 379, 176)
$Pic1 = GUICtrlCreatePic($IMGPATH, 8, 8, 761, 81)

for $i = 0 to 9 step +1
	$labelHandles[$i] = GUICtrlCreateLabel(IniRead($INIPATH, $INISECT, $i, "404 Not Found"), $left, $topLabel)
	$inputHandles[$i] = GUICtrlCreateInput("", $left, $topInput, $inputLength)
	$topLabel += $span
	$topInput += $span
Next

$left = 265
$topLabel = 96
$topInput = 112

for $i = 10 to 19 step +1
	$labelHandles[$i] = GUICtrlCreateLabel(IniRead($INIPATH, $INISECT, $i, "404 Not Found"), $left, $topLabel)
	$inputHandles[$i] = GUICtrlCreateInput("", $left, $topInput, $inputLength)
	$topLabel += $span
	$topInput += $span
Next

$left = 520
$topLabel = 96
$topInput = 112

for $i = 20 to 29 step +1
	$labelHandles[$i] = GUICtrlCreateLabel(IniRead($INIPATH, $INISECT, $i, "404 Not Found"), $left, $topLabel)
	$inputHandles[$i] = GUICtrlCreateInput("", $left, $topInput, $inputLength)
	$topLabel += $span
	$topInput += $span
Next

$btn = GUICtrlCreateButton("FIRE LAZERS", 8, 504, 753, 41)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

$startHour = @HOUR
$startMinute = @MIN

$msg = 0
while $msg <> $GUI_EVENT_CLOSE
	$msg = GUIGetMsg()
	if $msg = $btn Then
		main()
	EndIf
	if @HOUR == $startHour + 1 and @MIN == $startMinute then
		$blocker = 2
		save()
		MsgBox(0, "Czas min¹³!", "Rezultat twojej pracy zosta³ zapisany.")
	endif
wend

func main()
	if $blocker == 0 then
		save()
		MsgBox(0, "Dziêkujemy!", "Zapisano!")
		$blocker = 1
	elseif $blocker == 1 then
		MsgBox(0, "B³¹d!", "Nie mozesz wype³niæ quizu kilka razy.")
	Elseif $blocker == 2 then
		MsgBox(0, "B³¹d!", "Czas min¹³!")
	Else
		MsgBox(0, "B³¹d!", "404")
	endif
EndFunc

func save()
	for $i = 0 to 29 step +1
		$inputRead[$i] = GuiCtrlRead($inputHandles[$i])
		if $inputRead[$i] == "" Then
			$inputRead[$i] = "n/a"
		EndIf
	Next
	local $logHandle = FileOpen($LOGPATH, 1)
	for $i = 0 to 29 step +1
		FileWrite($logHandle, $i+1 & ") " & $inputRead[$i] & @CRLF)
	Next
	FileWrite($logHandle,"--------------" & @CRLF)
	FileClose($logHandle)
endfunc