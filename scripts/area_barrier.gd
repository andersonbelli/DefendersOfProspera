extends Area2D

signal on_hit

var barrier_health = 100

var enemy_damaging_barrier: EnemyBaseClass

func _physics_process(delta):
	if enemy_damaging_barrier != null and barrier_health > 0:
		barrier_health -= enemy_damaging_barrier.enemy_strengh

func _on_body_entered(body):
	if body is EnemyBaseClass:
		enemy_damaging_barrier = body
