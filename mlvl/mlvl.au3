; Magic Level Macro Delta by MrHudson (IGN: Five Star)
; Kovloria OTS, kovloria.pl
; First cmp date: Aug 6th, 2013

#include <Misc.au3>

$foodVariable = 0									; don't change this
$manaPotionVariable = 0								; and this
$i = 0												; neither this

$iniPath = @ScriptDir & "/cfg.ini"					; this is the path for cfg.ini file

;USER VARIABLES:
$foodManaRegen = iniRead($iniPath, "UserVariables", "foodManaRegen", 0)
$manaPotionManaRegen = iniRead($iniPath, "UserVariables", "manaPotionManaRegen", 0)
$spellManaRequired = iniRead($iniPath, "UserVariables", "spellManaRequired", 0)
$spellIncantationEmpty = iniRead($iniPath, "UserVariables", "spellIncantationEmpty", "utevo lux")
$foodHotkey = iniRead($iniPath, "UserVariables", "foodHotkey", "^{F12}")
$manaPotionHotkey = iniRead($iniPath, "UserVariables", "manaPotionHotkey", "^{F11}")

$manaPotionUses = ceiling($spellManaRequired/$manaPotionManaRegen)
$foodTicksWait = ceiling($spellManaRequired/$foodManaRegen) * 2000
$spellIncantation = $spellIncantationEmpty & "{enter}"

HotKeySet(iniRead($iniPath, "HotkeyFunctions", "foodSpell", "^{F10}"), "foodSpell")					; activates macro with food (slower and can't be done in PZ)
HotKeySet(iniRead($iniPath, "HotkeyFunctions", "manaPotionSpell", "^{F9}"), "manaPotionSpell")			; activates macro with mana potions (faster but requires mana potions)
HotKeySet(iniRead($iniPath, "HotkeyFunctions", "stopMacro", "^{F5}"), "stopMacro")					; stops the macro

while true
	sleep(10)
	while $foodVariable = 1
		sleep($foodTicksWait)
		send($spellIncantation)
		sleep(2100)
		send($foodHotkey)
	wEnd
	while $manaPotionVariable = 1
		send($spellIncantation)
		sleep(2100)
		do
			send($manaPotionHotkey)
			sleep(2100)
			$i = $i + 1
		until $i == $manaPotionUses
		$i = 0
	wEnd
wEnd

func foodSpell()
	$foodVariable = 1
	$manaPotionVariable = 0
endFunc

func manaPotionSpell()
   $foodVariable = 0
   $manaPotionVariable = 1
endFunc

func stopMacro()
	$foodVariable = 0
	$manaPotionVariable = 0
endFunc
