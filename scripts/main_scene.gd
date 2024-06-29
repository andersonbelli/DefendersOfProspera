extends CanvasLayer

const ENEMY_TYPE_ENUM = preload("res://scripts/enemy_type_enum.gd").EnemyType

@export var CharacterEnemyBat: PackedScene

@onready var timer_enemy_spawn = $TimerEnemySpawn
@onready var area_barrier = %AreaBarrier
@onready var label = $Label

func _physics_process(delta):
	label.text = "Barrier: " + str(area_barrier.barrier_health)
	pass

func _on_timer_enemy_spawn_timeout():
	if CharacterEnemyBat.can_instantiate():
		var enemyBat: EnemyBaseClass = CharacterEnemyBat.instantiate()

		if enemyBat.enemy_type == ENEMY_TYPE_ENUM.FLOOR:
			enemyBat.position.x = 10
			enemyBat.position.y = 680
		
		add_child(enemyBat)
