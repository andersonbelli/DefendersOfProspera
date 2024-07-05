extends EnemyBaseClass

class_name SkeletonEnemy

@onready var timer_hit_cooldown = $TimerHitCooldown

@onready var parts = $Parts
@onready var parts_fliped = $PartsFliped

@onready var animation_player = $AnimationPlayer

@onready var ray_cast = $RayCast2D

func _init():
	enemy_type = ENEMY_TYPE_ENUM.FLOOR
	enemy_velocity = 70

func _physics_process(delta):
	if ray_cast.is_colliding() and ray_cast.get_collider() is BarrierClass:
		velocity = Vector2.ZERO
		
		if timer_hit_cooldown.is_stopped():
			timer_hit_cooldown.start()
	
	enemy_move(delta)

func _process(delta):
	if enemy_health <= 0:
		queue_free()

func _on_timer_hit_cooldown_timeout():
	barrier.damage_barrier(enemy_strength)
	
	timer_hit_cooldown.stop()

func _on_area_2d_body_entered(body):
	if body is BulletClass:
		enemy_health -= body.bullet_damage
		body.on_hit(self, position)
