extends EnemyBaseClass

class_name SkeletonEnemyFlipped

@onready var ray_cast = $RayCast2D
@onready var timer_hit_cooldown = $TimerHitCooldown

var strengh = 0

func _init():
	enemy_type = ENEMY_TYPE_ENUM.FLOOR
	enemy_velocity = 70

	strengh = enemy_strengh

func _physics_process(delta):
	if ray_cast.is_colliding() and ray_cast.get_collider() is BarrierClass:
		velocity = Vector2.ZERO
		
		enemy_strengh = 0
		if timer_hit_cooldown.is_stopped():
			timer_hit_cooldown.start()
	
	enemy_move(delta)

func _process(delta):
	if enemy_health <= 0:
		queue_free()

func _on_timer_hit_cooldown_timeout():
	enemy_strengh = strengh
	
	barrier.damage_barrier(enemy_strengh)
	
	timer_hit_cooldown.stop()

func _on_area_2d_body_entered(body):
	if body is BulletClass:
		enemy_health -= body.bullet_damage
		body.on_hit(self, position)
