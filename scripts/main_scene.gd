extends Node

const ENEMY_TYPE_ENUM = preload("res://scripts/enemy_type_enum.gd").EnemyType

@export var CharacterEnemyBat: PackedScene
@export var CharacterEnemyZombie: PackedScene

@onready var timer_enemy_spawn = $TimerEnemySpawn
@onready var area_barrier = %AreaBarrier
@onready var label_barrier = $HUDInfo/LabelBarrier

@onready var path_follow = $PathSpawn/PathFollow2D
@onready var static_body_spawn_left = $StaticBodySpawnLeft
@onready var static_body_spawn_right = $StaticBodySpawnRight

func _physics_process(delta):
	label_barrier.text = "Barrier: " + str(area_barrier.barrier_health) + "%"

func _on_timer_enemy_spawn_timeout():
	var zombie_or_bat = randi_range(0, 1)
	
	var enemy: EnemyBaseClass
	
	if zombie_or_bat == 0:
		enemy = CharacterEnemyBat.instantiate()
	else:
		enemy = CharacterEnemyZombie.instantiate()

	if enemy.enemy_type == ENEMY_TYPE_ENUM.FLY:
		path_follow.progress_ratio = randf_range(0, 1)
		
		enemy.position.x = path_follow.position.x
		enemy.position.y = path_follow.position.y
		
		enemy.look_at(area_barrier.position)
	elif enemy.enemy_type == ENEMY_TYPE_ENUM.FLOOR:
		var left_or_right = randi_range(0, 1)
		
		if left_or_right == 0:
			enemy.position.x = static_body_spawn_right.position.x
			enemy.position.y = static_body_spawn_right.position.y
		else:
			enemy.position.x = static_body_spawn_left.position.x
			enemy.position.y = static_body_spawn_left.position.y

	enemy.chase_barrier(enemy.enemy_type, area_barrier)
	#enemy.look_at(area_barrier.position)

	add_child(enemy)
