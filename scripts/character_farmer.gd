extends CharacterBody2D

@onready var rigid_body_rope = $RigidBodyRope
@onready var timer_rope_cooldown = $RigidBodyRope/TimerRopeCooldown

@onready var line_2d: Line2D = $Line2D

var is_throwing_rope = false

var mouse_position: Vector2
var target: Vector2 = Vector2.ZERO

var points = []

func _input(event):
	if not is_throwing_rope and Input.is_action_just_pressed("throw_rope"):
		timer_rope_cooldown.start()
		
		target = get_local_mouse_position()
		
		start_rope_throw(line_2d.get_point_position(0), target)

func start_rope_throw(start_pos: Vector2, end_pos: Vector2):
	line_2d.clear_points()
	points.clear()

	var direction = (end_pos - start_pos).normalized()
	var distance = start_pos.distance_to(end_pos)
	var num_points = int(distance / 10)
	
	for i in range(num_points + 1):
		var point = start_pos + direction * (i * 10)
		points.append(point)
	
	points.append(end_pos)  # Ensure the final point is exactly at the click position
	timer_rope_cooldown.start()

func _on_timer_rope_cooldown_timeout():
	if points.size() > 0:
		line_2d.add_point(points.pop_front())
	else:
		timer_rope_cooldown.stop()
