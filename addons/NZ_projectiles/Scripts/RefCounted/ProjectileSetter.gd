@icon("res://addons/NZ_projectiles/Icons/Projectile_setter.svg")
class_name ProjectileSetter
extends RefCounted

## USE ONLY FOR 2D PROJECTILE
static func set_node_to_which_projectile_moves_to(projectile:Projectile_extended,to_this_node:Node2D,set_resource:bool=false,look_at_this_node:bool=true) -> void:
	if !is_instance_valid(to_this_node):
		push_error("to_this_node isn't valid")
		return
	if projectile.r_move_extended != null or set_resource:
		if set_resource:
			projectile.r_move_extended = Move_to_node2D_projectile.new()
		if projectile.r_move_extended is Move_to_node2D_projectile:
			projectile.r_move_extended.move_to_this_node2D = to_this_node
			projectile.r_move_extended.look_at_this_node = look_at_this_node
		return
	push_error("Problem with setting r_move_extended")

## USE ONLY FOR 3D PROJECTILE. basis axis = 0 (X), 1(Y), 2(Z)
static func set_node_to_which_projectile3D_moves_to(projectile:Projectile3D_extended,to_this_node:Node3D,set_resource:bool=false,look_at_this_node:bool=true,basis_axis:int=0) -> void:
	if !is_instance_valid(to_this_node):
		push_error("to_this_node isn't valid")
		return
	if projectile.r_move_extended != null or set_resource:
		if set_resource:
			projectile.r_move_extended = Move_to_node3D_projectile.new()
		if projectile.r_move_extended is Move_to_node3D_projectile:
			projectile.r_move_extended.move_to_this_node3D = to_this_node
			projectile.r_move_extended.look_at_this_node = look_at_this_node
			projectile.r_move_extended.cur_basis_axis = basis_axis
		return
	push_error("Problem with setting r_move_extended")

## USE ONLY FOR 2D PROJECTILE
static func set_direction(projectile:Projectile_extended,this_direction:Vector2,set_resource:bool=false) -> void:
	if projectile.r_move_extended != null or set_resource:
		if set_resource:
			projectile.r_move_extended = Move_direction_projectile.new()
		if projectile.r_move_extended is Move_direction_projectile:
			projectile.r_move_extended.direction = this_direction
		return
	push_error("Problem with setting r_move_extended")

static func set_direction3D(projectile:Projectile3D_extended,this_direction:Vector3,set_resource:bool=false) -> void:
	if projectile.r_move_extended != null or set_resource:
		if set_resource:
			projectile.r_move_extended = Move_direction_projectile3D.new()
		if projectile.r_move_extended is Move_direction_projectile3D:
			projectile.r_move_extended.direction = this_direction
		return
	push_error("Problem with setting r_move_extended")
