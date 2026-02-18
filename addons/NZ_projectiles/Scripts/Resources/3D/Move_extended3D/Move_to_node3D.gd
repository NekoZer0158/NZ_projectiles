@icon("res://addons/NZ_projectiles/Icons/3D/Move_extended3D/Move_to_node3D.svg")
class_name Move_to_node3D_projectile
extends Move_extended_projectile3D

## Moves projectile to the node3D

@export var node3D_path : NodePath
@export var cur_basis_axis : ProjectileEnum.BasisAxis = ProjectileEnum.BasisAxis.Z
@export var look_at_this_node : bool = false
@export_custom(PROPERTY_HINT_NONE,"suffix:°") var add_those_degrees : Vector3

var move_to_this_node3D : Node3D ## Set this through ProjectileSetter
var added_degrees : bool = false

const CREATE_DUPLICATE : bool = true

func _ready(parent_node:Node) -> void:
	if parent_node.has_node(node3D_path):
		ProjectileSetter.set_node_to_which_projectile3D_moves_to(parent_node,parent_node.get_node(node3D_path),false,look_at_this_node,cur_basis_axis)

func move_extended(projectile3D:Projectile3D,delta:float) -> void:
	if !added_degrees:
		if add_those_degrees != Vector3.ZERO:
			projectile3D.rotation_degrees += add_those_degrees
		added_degrees = true
	if is_instance_valid(move_to_this_node3D):
		if look_at_this_node:
			projectile3D.position += ProjectileGetter.get_cur_basis_axis(cur_basis_axis,projectile3D)*projectile3D.speed*delta
			projectile3D.look_at(move_to_this_node3D.global_position,Vector3.UP,true)
		else:
			projectile3D.position += projectile3D.speed*delta*projectile3D.global_position.direction_to(move_to_this_node3D.global_position)
