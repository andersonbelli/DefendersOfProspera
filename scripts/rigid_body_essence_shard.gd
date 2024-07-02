extends RigidBody2D

class_name ShardEssence

@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer

var shard_value = 1

func _process(delta):
	print(timer.time_left)
	
	if timer.time_left < 2:
		animation_player.play("timer_running_out")

func _on_timer_timeout():
	queue_free()
