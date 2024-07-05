extends CharacterBody2D

class_name EngineerClass

@onready var timer_rope_reach_target = $TimerRopeReachTarget
@onready var timer_pull_rope = $TimerPullRope

@onready var line_2d: Line2D = $AreaRope/Line2D
@onready var collision_rope = $AreaRope/CollisionRope

var initial_collision_position: Vector2

var mouse_position: Vector2
var target: Vector2 = Vector2.ZERO

var is_rope_throwed = false
var throw_points = []
var remove_point_at = 0

var controller: CharacterController

func _ready():
	controller = get_parent() as CharacterController
	initial_collision_position = collision_rope.position

func _physics_process(delta):
	if timer_pull_rope.is_stopped() and line_2d.get_point_count() > 0:
		rope_pull()

func _input(event):
	if controller.selected_character == CharactersEnum.Characters.ENGINEER:
		if Input.is_action_just_pressed("throw_rope"):
			if not is_rope_throwed:
				is_rope_throwed = true
				timer_rope_reach_target.start()
				target = get_local_mouse_position()
				
				rope_throw(line_2d.get_point_position(0), target)

func rope_throw(start_pos: Vector2, end_pos: Vector2):
	line_2d.clear_points()
	throw_points.clear()

	var direction = (end_pos - start_pos).normalized()
	var distance = start_pos.distance_to(end_pos)
	var num_throw_points = int(distance / 10)
	
	for i in range(num_throw_points + 1):
		var point = start_pos + direction * (i * 10)
		
		throw_points.append(point)
	
	throw_points.append(end_pos)  # Ensure the final point is exactly at the click position
	
	timer_rope_reach_target.start()

func _on_timer_rope_reach_target_timeout():
	if throw_points.size() > 0:
		if throw_points.size() > 3:
			collision_rope.position = throw_points.pop_front()
		else:
			collision_rope.position = target
			
		if is_rope_throwed:
			line_2d.add_point(throw_points.pop_front())
	else:
		if is_rope_throwed:
			rope_pull()
		timer_rope_reach_target.stop()

func rope_pull():
	timer_pull_rope.start()
	
	for i in range(line_2d.get_point_count()):
		remove_point_at = i

func _on_timer_pull_rope_timeout():
	timer_pull_rope.stop()
	
	if line_2d.get_point_count() == 1:
		is_rope_throwed = false
		collision_rope.position = initial_collision_position
	else:
		if remove_point_at - 1 >= 0:
			collision_rope.position = line_2d.get_point_position(remove_point_at)
			line_2d.remove_point(remove_point_at)
