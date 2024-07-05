extends CharacterBody2D

class_name MageClass

enum SPEELS { HEAL, CURE }

var barrier: BarrierClass

var selected_speel := SPEELS.HEAL
var heal_spell_strengh := 15.0

@onready var timer_heal_spell_cooldown: Timer = $TimerHealSpellCooldown
@onready var animation_player = $AnimationPlayer

var controller: CharacterController
func _ready():
	controller = get_parent() as CharacterController

func _process(delta):
	if controller.selected_character == CharactersEnum.Characters.MAGE:
		if timer_heal_spell_cooldown.is_stopped() and Input.is_action_just_pressed("cast_spell"):
				timer_heal_spell_cooldown.start()
				cast_spell()
	pass

func cast_spell():
	if barrier != null:
		animation_player.play("casting_spell")
		animation_player.queue("casting_spell_mouth")
		
		match selected_speel:
			SPEELS.HEAL:
				barrier.heal_barrier(heal_spell_strengh)
				
				#if barrier.barrier_health < 100:
					#if barrier.barrier_health + heal_spell_strengh > 100:
						#barrier.barrier_health = 100
					#else:
						#barrier.heal_barrier = true
						#barrier.barrier_health += heal_spell_strengh
			SPEELS.CURE:
				print("cure")


func _on_timer_health_cooldown_timeout():
	animation_player.play("RESET")
	timer_heal_spell_cooldown.stop()
