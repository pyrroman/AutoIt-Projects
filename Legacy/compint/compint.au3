#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.8.1
 Author:         MrHudson

 Script Function:
	Skrypt licz¹cy procent sk³adany.

#ce ----------------------------------------------------------------------------

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

; Pocz¹tek GUI
$Form1 = GUICreate("compint v1", 311, 123, 544, 228)
$Input1 = GUICtrlCreateInput("a", 48, 10, 97, 21)
$Input2 = GUICtrlCreateInput("b", 178, 10, 25, 21)
$Label2 = GUICtrlCreateLabel("* 1,", 151, 8, 31, 28)
GUICtrlSetFont(-1, 15, 400, 0, "MS Sans Serif")
$Label1 = GUICtrlCreateLabel("K = ", 8, 8, 37, 28)
GUICtrlSetFont(-1, 15, 400, 0, "MS Sans Serif")
$Label3 = GUICtrlCreateLabel("^", 206, 8, 13, 28)
GUICtrlSetFont(-1, 15, 400, 0, "MS Sans Serif")
$Input3 = GUICtrlCreateInput("c", 222, 10, 49, 21)
$Label4 = GUICtrlCreateLabel("Kapita³ pocz¹tkowy", 48, 32, 98, 17)
$Label5 = GUICtrlCreateLabel("Oprocentowanie", 150, 32, 82, 17)
$Label6 = GUICtrlCreateLabel("Okresy kap.", 242, 32, 61, 17)
$btn = GUICtrlCreateButton("Przelicz", 8, 56, 289, 49)
GUISetState(@SW_SHOW)
; Koniec GUI

; Pêtla programu
$msg = 0
while $msg <> $GUI_EVENT_CLOSE
	$msg = GUIGetMsg()
	if $msg = $btn then
		main()
	endif
wend

; Koniec pêtli programu

func main()
	$kapitalPoczatkowy = GuiCtrlRead($Input1)
	$oprocentowanie = GuiCtrlRead($Input2)
	$okresyKapitalizacyjne = GuiCtrlRead($Input3) ;zapisanie do zmiennych danych z kontrolek
	$tmp = 0 ;zmienna tymczasowa
	$return = 0 ;wynik

	$oprocentowanie = $oprocentowanie / 100
	$oprocentowanie = $oprocentowanie + 1 ;zamiana procentów na liczbê 1,xxx

	$tmp = $oprocentowanie ^ $okresyKapitalizacyjne ; "nawias"

	$return = $kapitalPoczatkowy * $tmp ;tmp = oprocentowanie ^ ilosc okresow kapitalizacyjnych

	$return = round($return, 2) ;zaokragla wynik do groszy

	MsgBox(0, "Wynik", $return & "z³")
endFunc
