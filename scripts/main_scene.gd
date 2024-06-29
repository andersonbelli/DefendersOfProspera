extends CanvasLayer

const ENEMY_TYPE_ENUM = preload("res://scripts/enemy_type_enum.gd").EnemyType

@export var CharacterEnemyBat: PackedScene

@onready var timer_enemy_spawn = $TimerEnemySpawn
@onready var area_barrier = %AreaBarrier
@onready var label = $Label

@onready var path_follow = $PathSpawn/PathFollow2D
@onready var static_body_spawn_left = $StaticBodySpawnLeft
@onready var static_body_spawn_right = $StaticBodySpawnRight

func _physics_process(delta):
	label.text = "Barrier: " + str(area_barrier.barrier_health)
	pass

func _on_timer_enemy_spawn_timeout():
	if CharacterEnemyBat.can_instantiate():
		var enemyBat: EnemyBaseClass = CharacterEnemyBat.instantiate()

		if enemyBat.enemy_type == ENEMY_TYPE_ENUM.FLY:
			path_follow.progress_ratio = randf_range(0, 1)
			
			enemyBat.position.x = path_follow.position.x
			enemyBat.position.y = path_follow.position.y
		elif enemyBat.enemy_type == ENEMY_TYPE_ENUM.FLOOR:
			#enemyBat.position.x = static_body_spawn_left.position.x
			#enemyBat.position = static_body_spawn_left.position
			enemyBat.position.x = static_body_spawn_right.position.x
			enemyBat.position.y = 680
		
		print(ENEMY_TYPE_ENUM.FLOOR)
		print(enemyBat.position)
		
		add_child(enemyBat)
