@icon("res://addons/NZ_projectiles_emitter/Icons/Other/Emitter3D_spread_shot.svg")
class_name Emitter3D_spread_shot
extends Emitter_spread_shot_base

@export var change_pos : bool = false
@export var min_add_pos : Vector3
@export var max_add_pos : Vector3
@export_group("X","x_")
@export var x_change_angle : bool = true
@export_range(-360,360,0.001,"suffix:°") var x_min_angle : float = -15.0
@export_range(-360,360,0.001,"suffix:°") var x_max_angle : float = 15.0
@export_group("Y","y_")
@export var y_change_angle : bool = true
@export_range(-360,360,0.001,"suffix:°") var y_min_angle : float = -15.0
@export_range(-360,360,0.001,"suffix:°") var y_max_angle : float = 15.0
@export_group("Z","z_")
@export var z_change_angle : bool = true
@export_range(-360,360,0.001,"suffix:°") var z_min_angle : float = -15.0
@export_range(-360,360,0.001,"suffix:°") var z_max_angle : float = 15.0

func _change_projectile_variables(projectile:Node) -> void:
	if x_change_angle:
		projectile.rotation_degrees.x = randf_range(x_min_angle,x_max_angle)
	if y_change_angle:
		projectile.rotation_degrees.y = randf_range(y_min_angle,y_max_angle)
	if z_change_angle:
		projectile.rotation_degrees.z = randf_range(z_min_angle,z_max_angle)
	if change_pos:
		projectile.position.x += randf_range(min_add_pos.x,max_add_pos.x)
		projectile.position.y += randf_range(min_add_pos.y,max_add_pos.y)
		projectile.position.z += randf_range(min_add_pos.z,max_add_pos.z)
