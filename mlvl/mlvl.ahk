; Magic Level Macro Alpha by MrHudson (IGN: Five Star)
; Kovloria OTS, kovloria.pl
; First cmp date: Aug 6th, 2013

#include <Misc.au3>

HotKeySet("{NUMPAD1}", "foodSpell")					; activates macro with food (slower and can't be done in PZ)
HotKeySet("{NUMPAD2}", "manaPotionSpell")			; activates macro with mana potions (faster but requires mana potions)
HotKeySet("{NUMPAD0}", "stopMacro")					; stops the macro

$foodVariable = 0									; don't change this
$manaPotionVariable = 0								; and this
$i = 0												; and this too

;USER VARIABLES:
$foodManaRegen = 23									; how much mana is regenerated per tick (2s), should be constant, but if not, lowest possible
$manaPotionManaRegen = 150 							; how much mana is regenerated with one mana potion, lowest possible (150 for strong mana potion)
$spellManaRequired = 400							; how much mana is required to cast your spell (400 for Swift Foot)
$spellIncantation = "utamo tempo san{enter}"		; the incantation if your spell, leave {enter} or it won't work, if experienced, you can use hotkeys (reference below)
$foodHotkey = "^{F12}" 								; hotkey for using your food, ^ = ctrl, + = shift
$manaPotionHotkey = "^{F11}"						; hotkey for using your mana potions/mana stones, ^ = ctrl, + = shift

$manaPotionUses = ceiling($spellManaRequired/$manaPotionManaRegen) 	; returns how many mana potions have to be used to regenerate mana to cast a spell rounded up
$foodTicksWait = ceiling(400/23) * 2000								; returns how much time you have to wait to cast a spell

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
