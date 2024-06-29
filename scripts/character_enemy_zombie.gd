extends EnemyBaseClass

@onready var timer_hit_cooldown = $TimerHitCooldown
@onready var label_zombie = $LabelZombie

var strengh = 0

func _init():
	enemy_type = ENEMY_TYPE_ENUM.FLOOR
	enemy_velocity = 70

	strengh = enemy_strengh
	
func _ready():
	chase_barrier(enemy_type)

func _physics_process(delta):
	enemy_move(delta)

func _process(delta):
	label_zombie.text = "h: " + str(enemy_health)
	
	if enemy_health <= 0:
		queue_free()
	
	if is_hitting_barrier:
		velocity = Vector2.ZERO
		
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
