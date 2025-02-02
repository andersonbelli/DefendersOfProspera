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
		var area_rope: Area2D = area
		var colission_rope = area.get_node("CollisionRope")
		var engineer: CharacterBody2D = area_rope.get_parent()
		
		reparent(colission_rope)
