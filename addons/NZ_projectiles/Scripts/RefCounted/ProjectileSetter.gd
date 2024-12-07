@icon("res://addons/NZ_projectiles/Icons/Projectile_setter.svg")
class_name ProjectileSetter
extends RefCounted

static func set_node_to_which_projectile_moves_to(projectile:Projectile_extended,to_this_node:Node2D,set_resource:bool=false) -> void:
	if projectile.r_move_extended != null or set_resource:
		if set_resource:
			projectile.r_move_extended = Move_to_node2D_projectile.new()
		if projectile.r_move_extended is Move_to_node2D_projectile:
			projectile.r_move_extended.move_to_this_node2D = to_this_node
		return
	push_error("Problem with setting r_move_extended")

static func set_direction(projectile:Projectile_extended,this_direction:Vector2,set_resource:bool=false) -> void:
	if projectile.r_move_extended != null or set_resource:
		if set_resource:
			projectile.r_move_extended = Move_direction_projectile.new()
		if projectile.r_move_extended is Move_direction_projectile:
			projectile.r_move_extended.direction = this_direction
	push_error("Problem with setting r_move_extended")
