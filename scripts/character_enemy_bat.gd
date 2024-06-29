extends EnemyBaseClass

@onready var timer_hit_cooldown = $TimerHitCooldown
#@onready var ray_cast_enemy_hit = $RayCastEnemyHit
@onready var label_health = $LabelHealth

var strengh = 0

func _init():
	#enemy_type = ENEMY_TYPE_ENUM.FLOOR
	enemy_type = ENEMY_TYPE_ENUM.FLY
	#enemy_velocity = 70
	enemy_velocity = 140

	strengh = enemy_strengh
	
func _ready():
	chase_barrier(enemy_type)
	
func _process(delta):
	label_health.text = "h: " + str(enemy_health)
	
	if enemy_health <= 0:
		queue_free()
	
	#if not ray_cast_enemy_hit.is_colliding():
	if not is_hitting_barrier:
		if enemy_type == ENEMY_TYPE_ENUM.FLOOR:
			move_local_x(delta * velocity.x)
		elif enemy_type == ENEMY_TYPE_ENUM.FLY:
			move_and_collide(velocity * delta)
	else:
		velocity = Vector2.ZERO
		
		enemy_strengh = 0
		if timer_hit_cooldown.is_stopped():
			timer_hit_cooldown.start()

func _on_timer_hit_cooldown_timeout():
	enemy_strengh = strengh
	timer_hit_cooldown.stop()

func _on_area_2d_body_entered(body):
	if body is BulletClass:
		#print("bullet " + str(body.name) + " - " + str(enemy_health))
		enemy_health -= body.bullet_damage
		body.on_hit(self, position)
