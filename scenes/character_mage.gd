extends CharacterBody2D

enum SPEELS { HEAL, CURE }

var selected_speel := SPEELS.HEAL
var heal_spell_strengh := 15

@onready var timer_health_cooldown = $TimerHealthCooldown

func _process(delta):
	var controller = get_parent() as CharacterController
	
	if controller.selected_character == CharactersEnum.Characters.MAGE:
		if timer_health_cooldown.is_stopped() and Input.is_action_just_pressed("cast_spell"):
				timer_health_cooldown.start()
				cast_spell()

func cast_spell():
	match selected_speel:
		SPEELS.HEAL:
			var barrier: BarrierClass = get_parent().get_parent().get_node("AreaBarrier")

			if barrier.barrier_health < 100:
				if barrier.barrier_health + heal_spell_strengh > 100:
					barrier.barrier_health = 100
				else:
					barrier.barrier_health += heal_spell_strengh
		SPEELS.CURE:
			print("cure")


func _on_timer_health_cooldown_timeout():
	timer_health_cooldown.stop()
