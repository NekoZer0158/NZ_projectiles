@icon("res://addons/NZ_projectiles/Icons/3D/Move_extended3D/Move_extended3D.svg")
@abstract
class_name Move_extended_projectile3D
extends Projectile_resource

## Changes how a projectile moves

const PI_2 : float = PI*2

func move_extended(_projectile:Projectile3D,_delta:float) -> void:
	pass

func find_shortest_way_to_angle3D(projectile:Projectile3D,angle_to_cur_point:Vector3) -> Vector3:
	var _new_angle_to_cur_point : Vector3 = angle_to_cur_point
	var _fix_rotation := func _fix_rotation(rotation:float,_angle_sign:float) -> float:
		if _angle_sign == 1:
			return rotation-PI_2
		return rotation+PI_2
	var projectile_rotation_minus_angle_to_cur_point := projectile.rotation-angle_to_cur_point
	if abs(angle_to_cur_point.x-projectile.rotation.x) > PI:
		var _angle_sign := signi(projectile.rotation.x)
		if _angle_sign == signi(projectile.rotation.x):
			projectile.rotation.x = _fix_rotation.call(projectile.rotation.x,_angle_sign)
		if abs(projectile_rotation_minus_angle_to_cur_point.x+PI)<abs(projectile_rotation_minus_angle_to_cur_point.x):
			_new_angle_to_cur_point.x = _new_angle_to_cur_point.x-PI_2
		else:
			_new_angle_to_cur_point.x = _new_angle_to_cur_point.x+PI_2
	if abs(angle_to_cur_point.y-projectile.rotation.y) > PI:
		var _angle_sign := signi(projectile.rotation.y)
		if _angle_sign == signi(projectile.rotation.y):
			projectile.rotation.y = _fix_rotation.call(projectile.rotation.y,_angle_sign)
		if abs(projectile_rotation_minus_angle_to_cur_point.y+PI)<abs(projectile_rotation_minus_angle_to_cur_point.y):
			_new_angle_to_cur_point.y = _new_angle_to_cur_point.y-PI_2
		else:
			_new_angle_to_cur_point.y = _new_angle_to_cur_point.y+PI_2
	if abs(angle_to_cur_point.z-projectile.rotation.z) > PI:
		var _angle_sign := signi(projectile.rotation.z)
		if _angle_sign == signi(projectile.rotation.z):
			projectile.rotation.z = _fix_rotation.call(projectile.rotation.z,_angle_sign)
		if abs(projectile_rotation_minus_angle_to_cur_point.z+PI)<abs(projectile_rotation_minus_angle_to_cur_point.z):
			_new_angle_to_cur_point.z = _new_angle_to_cur_point.z-PI_2
		else:
			_new_angle_to_cur_point.z = _new_angle_to_cur_point.z+PI_2
	return _new_angle_to_cur_point
