extends CharacterBody2D

class_name EnemyBaseClass

const ENEMY_TYPE_ENUM = preload("res://scripts/enemy_type_enum.gd").EnemyType

@export var enemy_type: ENEMY_TYPE_ENUM = ENEMY_TYPE_ENUM.FLY

var enemy_velocity := 10
var enemy_strengh := 8
var enemy_health := 5
