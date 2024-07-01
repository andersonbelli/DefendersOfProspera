extends CharacterBody2D

class_name MageClass

enum SPEELS { HEAL, CURE }

var barrier: BarrierClass

var selected_speel := SPEELS.HEAL
var heal_spell_strengh := 15

@onready var timer_heal_spell_cooldown: Timer = $TimerHealSpellCooldown

func _process(delta):
	var controller = get_parent() as CharacterController
	
	if controller.selected_character == CharactersEnum.Characters.MAGE:
		if timer_heal_spell_cooldown.is_stopped() and Input.is_action_just_pressed("cast_spell"):
				timer_heal_spell_cooldown.start()
				cast_spell()

func cast_spell():
	if barrier != null:
		match selected_speel:
			SPEELS.HEAL:
				if barrier.barrier_health < 100:
					if barrier.barrier_health + heal_spell_strengh > 100:
						barrier.barrier_health = 100
					else:
						barrier.heal_barrier = true
						barrier.barrier_health += heal_spell_strengh
			SPEELS.CURE:
				print("cure")


func _on_timer_health_cooldown_timeout():
	timer_heal_spell_cooldown.stop()
