;Name 			Planechase alpha
;Authors	 	Coestar and MrHudson
;Version		0.3 alpha
;Cmp date		10.07.13
;1st cmp date	10.07.13
;
;Creative Commons - Attribution - Share-Alike (CC-BY-SA) duelmasters.com.pl 2013
;All rights reserved.

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Array.au3>

global $pc[40]

$pc[0] = "The Academy"
$pc[1] = "Aerial Sanctuary"
$pc[2] = "Afterlife"
$pc[3] = "Altar of the Ashen Idol"
$pc[4] = "Aquatic Temple"
$pc[5] = "Ascension and Rebirth"
$pc[6] = "Astral Arena"
$pc[7] = "Blue Tide"
$pc[8] = "Chaotic Aether"
$pc[9] = "Crystal Sea"
$pc[10] = "Day of Judgment"
$pc[11] = "Dragonbreath"
$pc[12] = "Dwacatra"
$pc[13] = "Faeries' Forest"
$pc[14] = "Fields of Summer"
$pc[15] = "Figurehead"
$pc[16] = "Fog of War"
$pc[17] = "Gift of Epiphany"
$pc[18] = "Goldmeadows"
$pc[19] = "Horizon Boughs"
$pc[20] = "Interplanar Tunnel"
$pc[21] = "Mana Leak"
$pc[22] = "Panopticon"
$pc[23] = "Phyrexian Garrison"
$pc[24] = "Plains of Havoc"
$pc[25] = "Planar Split"
$pc[26] = "Planewide Disaster"
$pc[27] = "Pools of Becoming"
$pc[28] = "Raven's Run"
$pc[29] = "Replica's Revolt"
$pc[30] = "Sea of Sand"
$pc[31] = "Shandalar Hives"
$pc[32] = "Skybreen"
$pc[33] = "Spellbound Caves"
$pc[34] = "Stairs to Infinity"
$pc[35] = "Stronghold Furnace"
$pc[36] = "Takenuma"
$pc[37] = "Time Shift"
$pc[38] = "Turri Island"
$pc[39] = "Victory Monument"

$n_array = _ArrayShuffle($pc)
$index = 0

$form1 = GUICreate("Planechase 0.3 alpha", 538, 438, 274, 134)
$obrazek = GUICtrlCreatePic(@ScriptDir & "/img/Sea of Sand.jpg", 8, 8, 523, 375)
$btn1 = GUICtrlCreateButton("<<", 8, 392, 81, 41)
$btn2 = GUICtrlCreateButton(">>", 448, 392, 81, 41)
$btn3 = GUICtrlCreateButton("Shuffle", 96, 392, 345, 41)
GUISetState(@SW_SHOW)

$msg = 0
While $msg <> $GUI_EVENT_CLOSE
	$msg = GUIGetMsg()
	Select
		Case $msg = $btn1
			a_minus()
			GUICtrlSetImage($obrazek, @ScriptDir & "/img/" & $n_array[$index] & ".jpg")
		case $msg = $btn2
			a_plus()
			GUICtrlSetImage($obrazek, @ScriptDir & "/img/" & $n_array[$index] & ".jpg")
		case $msg = $btn3
			$n_array = _ArrayShuffle($pc)
			GUICtrlSetImage($obrazek, @ScriptDir & "/img/" & $n_array[$index] & ".jpg")
	EndSelect
WEnd

Func _ArrayShuffle($a_array,$s_start=0,$e_end=-1)
	$t_array = $a_array
    $t_start = $s_start
    If ($e_end<>-1) Then
		$t_end = $e_end
	Else
		$t_end = UBound($t_array)
    EndIf
	For $ii = $t_start to $t_end
		_ArraySwap($t_array[Random($t_start,$t_end)],$t_array[Random($t_start,$t_end)])
    Next
    Return $t_array
EndFunc

func a_plus()
	if $index == 39 Then
		$index = 0
	Else
	$index = $index + 1
	EndIf
EndFunc

func a_minus()
	if $index == 0 Then
		$index = 39
	Else
	$index = $index - 1
	EndIf
EndFunc