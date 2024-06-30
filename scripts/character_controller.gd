extends Node

class_name CharacterController

const CHARACTERS_ENUM = preload("res://scripts/character_enum.gd").Characters

@export var selected_character: CHARACTERS_ENUM

@onready var character_engineer = $CharacterEngineer
@onready var character_farmer = $CharacterFarmer
@onready var character_mage = $CharacterMage

const selected_character_color = Color("ffffff")
const unselected_character_color = Color("404040")

func _ready():
	selected_character = CHARACTERS_ENUM.ENGINEER
	select_new_character()

func _physics_process(delta):
	select_new_character()

func select_new_character():
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
			character_mage.modulate = selected_character_color
			character_engineer.modulate = unselected_character_color
			character_farmer.modulate = unselected_character_color
		CHARACTERS_ENUM.FARMER:
			character_farmer.modulate =selected_character_color
			character_engineer.modulate = unselected_character_color
			character_mage.modulate = unselected_character_color
