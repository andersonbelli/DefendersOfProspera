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
	#if timer_hit_cooldown.is_stopped():
		#print("strengh " + str(enemy_strengh))
		#enemy_strengh = 0
		#timer_hit_cooldown.start()
	
	if not ray_cast_enemy_hit.is_colliding():
		velocity.x = enemy_velocity
		move_and_slide()
	else:
		enemy_strengh = 0
		if timer_hit_cooldown.is_stopped():
			timer_hit_cooldown.start()

func _on_timer_hit_cooldown_timeout():
	enemy_strengh = strengh
	print("HIT")
	timer_hit_cooldown.stop()
