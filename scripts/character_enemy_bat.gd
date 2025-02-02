extends EnemyBaseClass

@export var EssenceShard: PackedScene

@onready var timer_hit_cooldown = $TimerHitCooldown

@onready var animated_sprite = $AnimatedSprite2D

@onready var ray_cast = $RayCast2D

func _init():
	enemy_type = ENEMY_TYPE_ENUM.FLY
	enemy_velocity = 140
	
func _ready():
	if position.x > 640:
		animated_sprite.flip_v = true

func _physics_process(delta):
	if ray_cast.is_colliding() and ray_cast.get_collider() is BarrierClass:
		velocity = Vector2.ZERO
		
		if timer_hit_cooldown.is_stopped():
			timer_hit_cooldown.start()
	
	var barrier = get_parent().get_node("AreaBarrier")
	enemy_move(delta)

func _process(delta):
	if enemy_health <= 0:
		var item_drop: RigidBody2D = EssenceShard.instantiate()
		item_drop.position = position
		
		get_parent().add_child(item_drop)
		queue_free()

func _on_timer_hit_cooldown_timeout():
	barrier.damage_barrier(enemy_strength)

func _on_area_2d_body_entered(body):
	if body is BulletClass:
		enemy_health -= body.bullet_damage
		body.on_hit(self, position)
