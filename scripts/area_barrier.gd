extends Area2D

class_name BarrierClass

@onready var animation_player = $Barrier/AnimationPlayer

var barrier_health := 10.0

var is_healing_barrier := false

var barrier_curse_damage := 10.0
var is_barrier_cursed : = false

var enemy_damaging_barrier: EnemyBaseClass

func _on_body_entered(body):
	if body is EnemyBaseClass:
		enemy_damaging_barrier = body
		
func heal_barrier(heal_spell_strengh: float):
	is_healing_barrier = true
	animation_player.play("barrier_heal")
	barrier_health = clamp(barrier_health + heal_spell_strengh, 0.0, 100.0)
	
func damage_barrier(damage_strengh):
	animation_player.play("barrier_hit")
	
	barrier_health = clamp(barrier_health - damage_strengh, 0.0, 100.0)
