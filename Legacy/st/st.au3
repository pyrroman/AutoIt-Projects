;Name 			ST.exe
;Authors	 	Coestar and MrHudson
;Version		1.0b
;Cmp date		10.07.13
;1st cmp date		10.07.13
;
;Creative Commons - Attribution - Share-Alike (CC-BY-SA) duelmasters.com.pl 2013
;Some rights reserved.

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$f1 = GUICreate("Form1", 577, 112, 865, 345)
$i1  = GUICtrlCreateInput("", 16, 25, 73, 21)
$i2 = GUICtrlCreateInput("", 103, 25, 73, 21)
$i3 = GUICtrlCreateInput("", 193, 25, 73, 21)
$i4 = GUICtrlCreateInput("", 279, 25, 113, 21)
$i5 = GUICtrlCreateInput("", 400, 25, 73, 21)
$i6 = GUICtrlCreateInput("", 489, 25, 73, 21)
$l1 = GUICtrlCreateLabel("Karty w talii", 16, 8, 57, 17)
$l2 = GUICtrlCreateLabel("Karty na grave", 103, 8, 73, 17)
$l3 = GUICtrlCreateLabel("Karty na rece", 193, 8, 67, 17)
$l4 = GUICtrlCreateLabel("ST na rece i grave", 279, 8, 92, 17)
$l5 = GUICtrlCreateLabel("ST ogolnie", 400, 8, 55, 17)
$l6 = GUICtrlCreateLabel("Ilosc tarcz", 489, 8, 55, 17)
$btn = GUICtrlCreateButton("Przelicz", 24, 56, 449, 33)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

$msg = 0
While $msg <> $GUI_EVENT_CLOSE
	$msg = GUIGetMsg()
	If $msg = $btn Then
         $oa = GuiCtrlRead($i1)
		 $g = GuiCtrlRead($i2)
		 $h = GuiCtrlRead($i3)
		 $sth = GuiCtrlRead($i4)
		 $stoa = GuiCtrlRead($i5)
		 $sn = GuiCtrlRead($i6)

		 $hg = $h + $g
		 $b = $oa - $hg

		 $a = $stoa - $sth

		 $1s = $a / $b
		 $return = $1s * $sn

		 MsgBox (0, "Wynik", "Prawdopodobienstwo ST pod twoimi tarczami wynosi: " & $return)
	Exit
	EndIf
WEnd

; GuiCtrlRead($input)
