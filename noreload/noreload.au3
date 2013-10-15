#include <Misc.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

HotKeySet("p", "toggle")
$switch = 1
$dll = DllOpen("user32.dll")
$block = 1

#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("FastReload Macro", 139, 96, 759, 487)
$i1 = GUICtrlCreateInput("", 8, 24, 113, 21)
$Label1 = GUICtrlCreateLabel("Delay (in ms):", 8, 8, 67, 17)
$btn = GUICtrlCreateButton("Save", 8, 48, 113, 33)
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
	while 1
		$delay = GuiCtrlRead($i1)
		while $switch = 1
			if _IsPressed("01", $dll) and $switch == 1 and $block == 1 Then
				$block = 0
				MouseUp("secondary")
				sleep($delay)
				Send("q")
				sleep(250)
				Send("e")
				sleep(250)
				MouseDown("secondary")
				$block = 1
			EndIf
		WEnd
	WEnd
EndFunc

func toggle()
	if $switch == 0 then
		$switch = 1
	Else
		$switch = 0
	EndIf
EndFunc