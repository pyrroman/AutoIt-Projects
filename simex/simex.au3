; ###################################################
; This stuff counts simultaneous equations.
; First you have to make it as such:
; { ax + by + c
; { px + qy + z
; And then it counts!
;
; Author: MrHudson
; ###################################################

; GUI STUFF #############################################################
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("SimEx v1", 293, 186, 192, 124)
$Label1 = GUICtrlCreateLabel("Enter the coefficients:", 8, 8, 107, 17)
$Label2 = GUICtrlCreateLabel("{", 8, 32, 26, 79)
GUICtrlSetFont(-1, 50, 400, 0, "Arial")
$ia = GUICtrlCreateInput("a", 40, 40, 65, 21)
$Label3 = GUICtrlCreateLabel("x+", 104, 40, 22, 24)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$ib = GUICtrlCreateInput("b", 128, 41, 65, 21)
$Label4 = GUICtrlCreateLabel("y=", 192, 41, 22, 24)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$ic = GUICtrlCreateInput("c", 215, 41, 65, 21)
$ip = GUICtrlCreateInput("p", 40, 81, 65, 21)
$Label5 = GUICtrlCreateLabel("x+", 104, 81, 22, 24)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$iq = GUICtrlCreateInput("q", 128, 82, 65, 21)
$Label6 = GUICtrlCreateLabel("y=", 192, 82, 22, 24)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$iz = GUICtrlCreateInput("z", 215, 82, 65, 21)
$btn = GUICtrlCreateButton("IMMA FIRIN' MAH LAZOR", 8, 120, 273, 49)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


$msg = 0
while $msg <> $GUI_EVENT_CLOSE
	$msg = GUIGetMsg()
	if $msg = $btn then
		main()
	endif
wend
; GUI STUFF END ################################################################

; This is for realz.
func main()
	$a = GuiCtrlRead($ia)
	$b = GuiCtrlRead($ib)
	$c = GuiCtrlRead($ic)
	$p = GuiCtrlRead($ip)
	$q = GuiCtrlRead($iq)
	$z = GuiCtrlRead($iz)

	if $a*$q-$p*$b <> 0 AND $b*$p-$q*$a <> 0 Then ;IF THERE'S AN UNIQUE SOLUTION
		$x = ($c*$q-$z*$b) / ($a*$q-$p*$b)
		$y = ($c*$p-$z*$a) / ($b*$p-$q*$a)
		MsgBox(0, "Solution", "UNIQUE SOLUTION!" & @CRLF & " |   x = " & $x & @CRLF & " |   y = " & $y)
	elseif $a*$q-$p*$b == 0 AND $b*$p-$q*$a == 0 AND $c*$q-$z*$b == 0 AND $c*$p-$z*$a == 0 then ;IF THERE'S INFINITELY MANY SOLUTIONS
		MsgBox(0, "Solution", "INFINITELY MANY SOLUTIONS! - You've reached end of the world, it's best to turn back now.")
	else ;IF THERE'S NO SOLUTIONS
		MsgBox(0, "Solution", "NO SOLUTIONS - Try again later.")
	endif
EndFunc
