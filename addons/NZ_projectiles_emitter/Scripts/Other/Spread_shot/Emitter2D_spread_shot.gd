@icon("res://addons/NZ_projectiles_emitter/Icons/Other/Emitter2D_spread_shot.svg")
class_name Emitter2D_spread_shot
extends Emitter_spread_shot_base

@export var change_angle : bool = true
@export_range(-360,360,0.001,"suffix:°") var min_angle : float = -15.0
@export_range(-360,360,0.001,"suffix:°") var max_angle : float = 15.0
@export var change_pos : bool = false
@export var min_add_pos : Vector2
@export var max_add_pos : Vector2

func _change_projectile_variables(projectile:Node) -> void:
	if change_angle:
		projectile.rotation_degrees = randf_range(min_angle,max_angle)
	if change_pos:
		projectile.position.x += randf_range(min_add_pos.x,max_add_pos.x)
		projectile.position.y += randf_range(min_add_pos.y,max_add_pos.y)
