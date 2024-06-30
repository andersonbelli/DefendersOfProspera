extends CharacterBody2D

class_name EnemyBaseClass

const ENEMY_TYPE_ENUM = preload("res://scripts/enemy_type_enum.gd").EnemyType

@export var enemy_type: ENEMY_TYPE_ENUM = ENEMY_TYPE_ENUM.FLY

var is_hitting_barrier = false

var enemy_velocity := 10
var enemy_strengh := 8
var enemy_health := 5

func chase_barrier(_enemy_type: ENEMY_TYPE_ENUM):
	var barrier: BarrierClass = get_parent().get_node("AreaBarrier")
	
	if enemy_type == ENEMY_TYPE_ENUM.FLOOR:
		position.x -= barrier.position.direction_to(position).x
		velocity.x = enemy_velocity * position.direction_to(barrier.position).x
		
	elif enemy_type == ENEMY_TYPE_ENUM.FLY:
		position -= barrier.position.direction_to(position)
		velocity = enemy_velocity * position.direction_to(barrier.position)

func enemy_move(delta):
	if not is_hitting_barrier:
		if enemy_type == ENEMY_TYPE_ENUM.FLOOR:
			move_local_x(delta * velocity.x)
		elif enemy_type == ENEMY_TYPE_ENUM.FLY:
			move_and_collide(velocity * delta)
