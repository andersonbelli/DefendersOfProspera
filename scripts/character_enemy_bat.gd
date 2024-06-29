extends EnemyBaseClass

@onready var timer_hit_cooldown = $TimerHitCooldown
@onready var ray_cast_enemy_hit = $RayCastEnemyHit

var strengh = 0

func _init():
	enemy_type = ENEMY_TYPE_ENUM.FLOOR
	#enemy_velocity = 70
	enemy_velocity = 140

	strengh = enemy_strengh
	
func _process(delta):
	if enemy_health <= 0:
		queue_free()
	
	if not ray_cast_enemy_hit.is_colliding():
		var barrier: Area2D = get_parent().get_node("AreaBarrier")

		ray_cast_enemy_hit.look_at(barrier.position)

		if enemy_type == ENEMY_TYPE_ENUM.FLOOR:
			position.x -= barrier.position.direction_to(position).x
			velocity = enemy_velocity * position.direction_to(barrier.position)

			move_local_x(delta * velocity.x)
		elif enemy_type == ENEMY_TYPE_ENUM.FLY:
			move_and_collide(velocity * delta)
		
	else:
		enemy_strengh = 0
		if timer_hit_cooldown.is_stopped():
			timer_hit_cooldown.start()

func _on_timer_hit_cooldown_timeout():
	enemy_strengh = strengh
	timer_hit_cooldown.stop()

func _on_area_2d_body_entered(body):
	if body is BulletClass:
		enemy_health -= body.bullet_damage
		body.on_hit(self, position)
