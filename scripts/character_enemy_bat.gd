extends EnemyBaseClass

@onready var timer_hit_cooldown = $TimerHitCooldown
@onready var label_health = $LabelHealth

@onready var animated_sprite = $AnimatedSprite2D

var strengh = 0

func _init():
	enemy_type = ENEMY_TYPE_ENUM.FLY
	enemy_velocity = 140

	strengh = enemy_strengh
	
func _ready():
	if position.x > 640:
		animated_sprite.flip_v = true

func _physics_process(delta):
	var barrier = get_parent().get_node("AreaBarrier")
	
	enemy_move(delta)

func _process(delta):
	label_health.text = "h: " + str(enemy_health)
	
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
