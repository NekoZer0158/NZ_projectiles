@icon("res://addons/NZ_projectiles/Icons/Move_extended/Move_to_node2D.svg")
class_name Move_to_node2D_projectile
extends Move_extended_projectile

#@export var node_path : String
@export var look_at_this_node : bool = false
@export_range(-360,360,0.5,"suffix:°") var add_those_degrees : float = 0

var move_to_this_node2D : Node2D ## Set this through ProjectileSetter
var added_degrees : bool = false

const CREATE_DUPLICATE :int = 1

# if this doesn't work properly, change get_tree().current_scene to the new one, if you changing main scene to another one
#func _ready(parent_node:Projectile) -> void:
	#if !node_path.is_empty():
		#var scene_main_node := parent_node.get_tree().current_scene
		#scene_main_node.get_node(node_path)

func move_extended(projectile:Projectile,delta:float) -> void:
	if !added_degrees:
		if add_those_degrees > 0:
			projectile.rotation_degrees += add_those_degrees
		added_degrees = true
	if is_instance_valid(move_to_this_node2D):
		if look_at_this_node:
			projectile.position += projectile.transform.x*projectile.speed*delta
			projectile.look_at(move_to_this_node2D.global_position)
		else:
			projectile.position += projectile.speed*delta*projectile.global_position.direction_to(move_to_this_node2D.global_position)
