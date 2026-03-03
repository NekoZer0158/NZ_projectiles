@icon("res://addons/NZ_projectiles/Icons/Move_extended/Move_to_node2D.svg")
class_name Move_to_node2D_projectile
extends Move_extended_projectile

## Moves the projectile to [Node2D]

@export var node2D_path : NodePath
@export var look_at_this_node : bool = false
@export var multiply_scale_when_dont_look : bool = false
@export var move_away : bool = false ## If true, the projecitle will move in the opposite way from the [Node2D]
@export var default_movement_if_no_node2D : bool = false
@export_range(-360,360,0.5,"suffix:°") var add_those_degrees : float = 0

var move_to_this_node2D : Node2D ## Set this through [ProjectileSetter] or node2D_path
var added_degrees : bool = false

const CREATE_DUPLICATE : bool = true

func _ready(parent_node:Node) -> void:
	if parent_node.has_node(node2D_path):
		ProjectileSetter.set_node_to_which_projectile_moves_to(parent_node,parent_node.get_node(node2D_path),false,look_at_this_node)

func move_extended(projectile:Projectile,delta:float) -> void:
	if !added_degrees:
		if add_those_degrees != 0:
			projectile.rotation_degrees += add_those_degrees
		added_degrees = true
	if is_instance_valid(move_to_this_node2D):
		if look_at_this_node:
			if !move_away:
				projectile.position += projectile.transform.x*projectile.speed*delta
			else:
				projectile.position -= projectile.transform.x*projectile.speed*delta
			projectile.look_at(move_to_this_node2D.global_position)
		else:
			if !move_away:
				if multiply_scale_when_dont_look:
					projectile.position += projectile.speed*delta*projectile.global_position.direction_to(move_to_this_node2D.global_position)*projectile.scale
				else:
					projectile.position += projectile.speed*delta*projectile.global_position.direction_to(move_to_this_node2D.global_position)
			else:
				if multiply_scale_when_dont_look:
					projectile.position -= projectile.speed*delta*projectile.global_position.direction_to(move_to_this_node2D.global_position)*projectile.scale
				else:
					projectile.position -= projectile.speed*delta*projectile.global_position.direction_to(move_to_this_node2D.global_position)
	elif default_movement_if_no_node2D:
		projectile.position += projectile.transform.x*projectile.speed*delta
