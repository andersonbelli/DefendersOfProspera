extends RigidBody2D

class_name ShardEssence

@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer

var shard_value = 1

func _process(delta):
	if timer.time_left < 2:
		animation_player.play("timer_running_out")

func _on_timer_timeout():
	#queue_free()
	pass

func _on_area_2d_area_entered(area):
	print("shard area = ", area.name)
	
	if area.name == "AreaRope":
		var colission_rope = area.get_node("CollisionRope")
		print("Rope: ", colission_rope.position)
		print("Shard: ", position)
		#position = colission_rope.position
		reparent(colission_rope)
