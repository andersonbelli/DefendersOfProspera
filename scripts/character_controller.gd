extends Node

class_name CharacterController

const CHARACTERS_ENUM = preload("res://scripts/character_enum.gd").Characters

@export var selected_character: CHARACTERS_ENUM

@onready var character_engineer = $CharacterEngineer
@onready var character_farmer: FarmerClass = $CharacterFarmer
@onready var character_mage: MageClass = $CharacterMage

@onready var heal_spell = $HealSpell
@onready var label_heal_spell_value = $HealSpell/LabelHealSpellValue

@onready var throw_rope = $ThrowRope

const selected_character_color = Color("ffffff")
const unselected_character_color = Color("404040")

func _ready():
	selected_character = CHARACTERS_ENUM.ENGINEER
	select_new_character()

func _physics_process(delta):
	select_new_character()
	
	if selected_character == CHARACTERS_ENUM.MAGE:
		var barrier: BarrierClass = get_parent().get_node("AreaBarrier")
		
		var heal_spell_timer: Timer = character_mage.timer_heal_spell_cooldown
		
		label_heal_spell_value.text = make_pretty_numbers(heal_spell_timer.time_left)
		character_mage.barrier = barrier
	elif selected_character == CHARACTERS_ENUM.FARMER:
		if character_farmer.is_rope_throwed:
			throw_rope.modulate = Color.BROWN
		else:
			throw_rope.modulate = Color.YELLOW

func reset_abilities_visibility():
	heal_spell.visible = false
	throw_rope.visible = false

func select_new_character():
	reset_abilities_visibility()
	
	if Input.is_action_just_pressed("change_to_mage"):
		selected_character = CHARACTERS_ENUM.MAGE
	elif Input.is_action_just_pressed("change_to_farmer"):
		selected_character = CHARACTERS_ENUM.FARMER
	elif Input.is_action_just_pressed("change_to_engineer"):
		selected_character = CHARACTERS_ENUM.ENGINEER
	
	match selected_character:
		CHARACTERS_ENUM.ENGINEER:
			character_engineer.modulate = selected_character_color
			
			character_mage.modulate = unselected_character_color
			character_farmer.modulate = unselected_character_color
		CHARACTERS_ENUM.MAGE:
			heal_spell.visible = true
			
			character_mage.modulate = selected_character_color
			
			character_engineer.modulate = unselected_character_color
			character_farmer.modulate = unselected_character_color
		CHARACTERS_ENUM.FARMER:
			throw_rope.visible = true
			
			character_farmer.modulate =selected_character_color
			
			character_engineer.modulate = unselected_character_color
			character_mage.modulate = unselected_character_color

func make_pretty_numbers( num:float, precission:int = 1  ) -> String:
	if num == 0.0:
		return "ready"
	return str("%."+str(precission)+"f ") % [num]
