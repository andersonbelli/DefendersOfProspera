extends Node

const CHARACTERS_ENUM = preload("res://scripts/character_enum.gd").Characters

@export var selected_character: CHARACTERS_ENUM

@onready var character_engineer = $CharacterEngineer
@onready var character_farmer = $CharacterFarmer
@onready var character_mage = $CharacterMage

func _ready():
	selected_character = CHARACTERS_ENUM.ENGINEER
	select_new_character()

func _physics_process(delta):
	if Input.is_action_just_pressed("change_to_mage"):
		selected_character = CHARACTERS_ENUM.MAGE
	elif Input.is_action_just_pressed("change_to_farmer"):
		selected_character = CHARACTERS_ENUM.FARMER
	elif Input.is_action_just_pressed("change_to_engineer"):
		selected_character = CHARACTERS_ENUM.ENGINEER
	select_new_character()

func select_new_character():
	match selected_character:
		CHARACTERS_ENUM.ENGINEER:
			character_engineer.modulate = Color("ffffff")
			character_mage.modulate = Color("000000")
			character_farmer.modulate = Color("000000")
		CHARACTERS_ENUM.MAGE:
			character_mage.modulate = Color("ffffff")
			character_engineer.modulate = Color("000000")
			character_farmer.modulate = Color("000000")
		CHARACTERS_ENUM.FARMER:
			character_farmer.modulate = Color("ffffff")
			character_engineer.modulate = Color("000000")
			character_mage.modulate = Color("000000")
