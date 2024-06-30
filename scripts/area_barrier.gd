extends Area2D

class_name BarrierClass

@onready var animation_player = $Barrier/AnimationPlayer

var barrier_health := 10

var heal_barrier := false

var barrier_curse_damage := 10
var is_barrier_cursed : = false

var enemy_damaging_barrier: EnemyBaseClass

func _physics_process(delta):
	if heal_barrier:
		animation_player.play("barrier_heal")
		heal_barrier = false
	
	if enemy_damaging_barrier != null and barrier_health > 0:
		animation_player.play("barrier_hit")
		barrier_health -= enemy_damaging_barrier.enemy_strengh

func _on_body_entered(body):
	if body is EnemyBaseClass:
		enemy_damaging_barrier = body
		enemy_damaging_barrier.is_hitting_barrier = true
