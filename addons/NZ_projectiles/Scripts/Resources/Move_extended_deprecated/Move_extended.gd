@icon("res://addons/NZ_projectiles/Icons/Move_extended/Move_extended.svg")
@abstract
class_name Move_extended_projectile
extends Projectile_resource

## @deprecated
## Changes how a projectile moves

const PI_2 : float = PI*2

func move_extended(_projectile:Projectile,_delta:float) -> void:
	pass

func find_shortest_way_to_angle(projectile:Projectile,angle_to_cur_point:float) -> float:
	if abs(angle_to_cur_point-projectile.rotation) <= PI:
		return angle_to_cur_point
	var _angle_sign := signi(angle_to_cur_point)
	var _projectile_sign := signi(projectile.rotation)
	if _angle_sign == _projectile_sign:
		if _angle_sign == 1:
			projectile.rotation = projectile.rotation-PI_2
		else:
			projectile.rotation = projectile.rotation+PI_2
	var projectile_rotation_minus_angle_to_cur_point := projectile.rotation-angle_to_cur_point
	if abs(projectile_rotation_minus_angle_to_cur_point+PI)<abs(projectile_rotation_minus_angle_to_cur_point):
		return angle_to_cur_point-PI_2
	return angle_to_cur_point+PI_2
