@icon("res://addons/NZ_projectiles/Icons/3D/Move_extended3D/Move_on_path3D.svg")
class_name Move_projectile_on_path3D
extends Move_extended_projectile3D

## Moves projectile on [Path3D]. Supports changing [Path3D] position and scale.

@export_node_path("Path3D") var path3d_path : NodePath
@export var cur_basis_axis : ProjectileEnum.BasisAxis = ProjectileEnum.BasisAxis.Z
@export var find_cur_point_in_points : bool = true
@export var point_zone : Vector3 = Vector3(0.5,0.5,0.5) ## When reaching that zone around the point, the projectile will go to the next point
@export var teleport_projectile_to_default_point : bool = false ## Works only once when spawning projectile
@export var default_point_index : int = 0
@export var cycle_movement : bool = false: ## If set to false then the projectile will stop at the last point of the [Curve3D] (doesn't matter if it's closed or not)[br]If set to true then it will go to the first point and then through all points again if the [Curve3D] is closed. If not closed then the projectile will go back and forward between the first and the last points going through all points
	set(value):
		if cycle_movement != value and value:
			if _cur_path3d != null:
				if _cur_point_id == _all_points.size()-1:
					_get_next_point_id(_cur_path3d.curve.closed)
					_stop_moving = false
		cycle_movement = value
@export var instant_look : bool = true ## If set to true then the projectile will instantly look at the new point, if false then it's angle will be changed by look_speed until it's looking at the point
@export_range(0,360,0.001,"suffix:°") var look_speed : float = 0.0
@export var debug : bool = false

var _stop_moving : bool = false
var _cur_path3d : Path3D
var _cur_point : Vector3
var _cur_point_id : int
var _moving_backwards : bool = false
var _all_points : PackedVector3Array

const CREATE_DUPLICATE : bool = true

func _ready(parent_node:Node) -> void:
	if parent_node.has_node(path3d_path):
		set_path3d(parent_node.get_node(path3d_path))
	if teleport_projectile_to_default_point:
		parent_node.position = _cur_path3d.curve.get_point_position(default_point_index)*_cur_path3d.scale+_cur_path3d.global_position
		_set_new_point()

func set_path3d(new_path3d:Path3D) -> void:
	_cur_path3d = new_path3d
	_cur_path3d.tree_exited.connect(_set_cur_path3d_to_null)
	for i in range(0,_cur_path3d.curve.point_count):
		_all_points.append(_cur_path3d.curve.get_point_position(i))
	if debug:
		print("_all_points: ",_all_points)
	_cur_point = _all_points[default_point_index]
	if debug:
		print("new path3D was set: ",_cur_path3d.name)

func start_moving() -> void:
	_stop_moving = false

func stop_moving() -> void:
	_stop_moving = true

func _set_cur_path3d_to_null() -> void:
	_cur_path3d = null

func _get_next_point_id(curve_closed:bool=true) -> int:
	if find_cur_point_in_points:
		_cur_point_id = _all_points.find(_cur_point)
	if cycle_movement:
		if _cur_point_id == _all_points.size()-1:
			_cur_point_id = _all_points.size()-1
			_moving_backwards = true
		elif _cur_point_id == 0:
			_moving_backwards = false
	if _cur_point_id == -1:
		return -1
	return _clamp_or_wrap_cur_point_id(curve_closed)

func _clamp_or_wrap_cur_point_id(curve_closed:bool=true) -> int:
	if !curve_closed:
		if _moving_backwards:
			return clampi(_cur_point_id-1,0,_all_points.size()-1)
		return clampi(_cur_point_id+1,0,_all_points.size()-1)
	if cycle_movement:
		return wrapi(_cur_point_id+1,0,_all_points.size())
	return clampi(_cur_point_id+1,0,_all_points.size()-1)

func _set_new_point() -> void:
	if _cur_path3d != null:
		var _next_point_id := _get_next_point_id(_cur_path3d.curve.closed)
		if _next_point_id == -1 or _next_point_id == _cur_point_id:
			_stop_moving = true
		else:
			_cur_point = _all_points[_next_point_id]
			_cur_point_id = _next_point_id
	else:
		_stop_moving = true

func move_extended(projectile:Projectile3D,delta:float) -> void:
	if _stop_moving:
		return
	var _cur_point_global_position := _cur_point*_cur_path3d.scale+_cur_path3d.global_position
	if instant_look:
		projectile.look_at(_cur_point_global_position,Vector3.UP,true)
	else:
		var _quaternion_to_cur_point : Quaternion = projectile.basis.looking_at(_cur_point_global_position-projectile.position,Vector3.UP,true).get_rotation_quaternion()
		var _euler_to_cur_point : Vector3 = _quaternion_to_cur_point.get_euler(projectile.rotation_order)
		projectile.rotation = projectile.rotation.move_toward(find_shortest_way_to_angle3D(projectile,_euler_to_cur_point),deg_to_rad(look_speed))
		if abs(projectile.rotation.x-PI_2)<0.07:
			projectile.rotation.x = 0
		if abs(projectile.rotation.y-PI_2)<0.07:
			projectile.rotation.y = 0
		if abs(projectile.rotation.z-PI_2)<0.07:
			projectile.rotation.z = 0
	projectile.position += ProjectileGetter.get_cur_basis_axis(cur_basis_axis,projectile)*projectile.speed*delta
	if debug:
		print(_cur_point_id,": ",abs(projectile.global_position-_cur_point_global_position)," ",point_zone)
	var distance_to_another_point := abs(projectile.global_position-_cur_point_global_position)
	if distance_to_another_point.x < point_zone.x and distance_to_another_point.y < point_zone.y and distance_to_another_point.z < point_zone.z:
		_set_new_point()
