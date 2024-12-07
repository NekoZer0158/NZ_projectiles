extends Node

@export var projectile : Projectile_extended
@export var moving_node2D : Node2D

const PROJECTILE_EXTENDED = preload("res://NZ_projectiles/Projectiles/Projectile_extended.tscn")
const TEST_CHARACTER = preload("res://NZ_projectiles/Characters/TestCharacter.tscn")

func _ready() -> void:
	ProjectileSetter.set_node_to_which_projectile_moves_to(projectile,moving_node2D)

func check_and_free_character(character) -> void:
	if is_instance_valid(character):
		character.free()
