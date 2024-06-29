extends CharacterBody2D

class_name EnemyBaseClass

const ENEMY_TYPE_ENUM = preload("res://scripts/enemy_type_enum.gd").EnemyType

@export var enemy_type: ENEMY_TYPE_ENUM = ENEMY_TYPE_ENUM.FLY

var is_hitting_barrier = false

var enemy_velocity := 10
var enemy_strengh := 8
var enemy_health := 5

func chase_barrier(_enemy_type: ENEMY_TYPE_ENUM):
	var barrier: Area2D = get_parent().get_node("AreaBarrier")
	#ray_cast_enemy_hit.look_at(barrier.position)

	if enemy_type == ENEMY_TYPE_ENUM.FLOOR:
		position.x -= barrier.position.direction_to(position).x
		velocity.x = enemy_velocity * position.direction_to(barrier.position).x

		#move_local_x(delta * velocity.x)
		
	elif enemy_type == ENEMY_TYPE_ENUM.FLY:
		position -= barrier.position.direction_to(position)
		velocity = enemy_velocity * position.direction_to(barrier.position)
		
	#move_and_collide(velocity * delta)
