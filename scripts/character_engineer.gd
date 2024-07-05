extends CharacterBody2D

@export var Bullet: PackedScene

func _process(delta):
	var controller = get_parent() as CharacterController
	
	if controller.selected_character == CharactersEnum.Characters.ENGINEER:
		var mouse_position = get_viewport().get_mouse_position()
	
		if Input.is_action_just_pressed("attack"):
			attack(mouse_position)

func attack(mouse_position):
	var bullet: RigidBody2D = Bullet.instantiate()
	
	bullet.position = position
	bullet.rotation_degrees = global_rotation
	bullet.look_at(mouse_position)
	
	var direction = global_position.direction_to(mouse_position)
	var impulse = direction * 100

	bullet.linear_velocity = impulse * 25
	bullet.add_constant_central_force(impulse)
	
	get_parent().add_child(bullet)
