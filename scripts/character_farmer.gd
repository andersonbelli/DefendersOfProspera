extends CharacterBody2D

@onready var rigid_body_rope = $RigidBodyRope
@onready var timer_rope_cooldown = $RigidBodyRope/TimerRopeCooldown

@onready var line_2d: Line2D = $Line2D

var is_throwing_rope = false

var mouse_position: Vector2
var target: Vector2 = Vector2.ZERO

func _input(event):
	if not is_throwing_rope and Input.is_action_just_pressed("throw_rope"):
		#throw_rope()
		move_towards_target()

func _physics_process(delta):
	pass
	#line_2d.add_point(get_local_mouse_position())

	#if target != Vector2.ZERO:
		#line_2d.add_point(target.direction_to(position))
		#target -= position
		#print("target " + str(target))
		
		#if target - mouse_position > Vector2.ZERO:
			##target = target + Vector2(1,1)
			#line_2d.add_point(target)
			#line_2d.move_local_x(mouse_position.x)
			#line_2d.move_local_y(mouse_position.y)
#
		##print("target " + str(target.distance_to(position)) + str(position) + str(target))
		#print("target " + str(target.direction_to(mouse_position)) + str(mouse_position) + str(target))

func throw_rope():
	timer_rope_cooldown.start()
	
	is_throwing_rope = true
	
	mouse_position = get_local_mouse_position()
	
	#target = mouse_position
	target = position
	
	var direction = global_position.direction_to(mouse_position)
	var impulse = direction * 30
	
	pass
	

func move_towards_target():
	var current_position: Vector2 = mouse_position
	while current_position.distance_to(position) > 10.0:
		#line_2d.add_point(current_position)
		# Calculate direction
		var direction: Vector2 = (position - current_position).normalized()
		# Move 10 pixels in the direction
		current_position += direction * 10.0
		line_2d.add_point(current_position)
		print("Moving to: ", current_position)
		print("direction: ", direction)
		#line_2d.add_point(current_position)
		# Optionally, you can add a delay here for a visible step-by-step movement
		await get_tree().create_timer(1.3)
	# Move the remaining distance
	current_position = mouse_position
	print("Final position: ", current_position)
