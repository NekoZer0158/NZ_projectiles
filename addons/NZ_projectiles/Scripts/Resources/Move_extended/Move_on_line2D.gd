@icon("res://addons/NZ_projectiles/Icons/Move_extended/Move_projectile_on_line.svg")
class_name Move_projectile_on_line2D
extends Move_extended_projectile

## Moves projectile on [color=mediumturquoise]Line2D[/color]. Supports changing line position and scale.

@export_node_path("Line2D") var line_path : NodePath
@export var find_cur_point_in_points : bool = true
@export var point_zone : Vector2 = Vector2(5,5)
@export var teleport_projectile_to_default_point : bool = false ## works only once when spawning projectile
@export var default_point_index : int = 0
@export var cycle_movement : bool = false:
	set(value):
		if cycle_movement != value and value:
			if _cur_line != null:
				if _cur_point_id == _cur_line.points.size()-1:
					_get_next_point_id(_cur_line.closed)
					_stop_moving = false
		cycle_movement = value
@export var debug : bool = false

var _stop_moving : bool = false
var _cur_line : Line2D
var _cur_point : Vector2
var _cur_point_id : int
var _moving_backwards : bool = false

func _ready(parent_node:Node) -> void:
	if parent_node.has_node(line_path):
		set_line(parent_node.get_node(line_path))
	if teleport_projectile_to_default_point:
		parent_node.position = _cur_line.points[default_point_index]*_cur_line.scale+_cur_line.global_position
		_set_new_point()

func set_line(new_line:Line2D) -> void:
	_cur_line = new_line
	_cur_line.tree_exited.connect(_set_cur_line_to_null)
	_cur_point = _cur_line.points[default_point_index]
	if debug:
		print("new line was set: ",_cur_line.name)

func _set_cur_line_to_null() -> void:
	_cur_line = null

func start_moving() -> void:
	_stop_moving = false

func stop_moving() -> void:
	_stop_moving = true

func _set_new_point() -> void:
	if _cur_line != null:
		var _next_point_id := _get_next_point_id(_cur_line.closed)
		if _next_point_id == -1 or _next_point_id == _cur_point_id:
			_stop_moving = true
		else:
			_cur_point = _cur_line.points[_next_point_id]
			_cur_point_id = _next_point_id
	else:
		_stop_moving = true

func _get_next_point_id(line_closed:bool=true) -> int:
	if find_cur_point_in_points:
		_cur_point_id = _cur_line.points.find(_cur_point)
	if cycle_movement:
		if _cur_point_id == _cur_line.points.size()-1:
			_cur_point_id = _cur_line.points.size()-1
			_moving_backwards = true
		elif _cur_point_id == 0:
			_moving_backwards = false
	if _cur_point_id == -1:
		return -1
	return _clamp_or_wrap_cur_point_id(line_closed)

func _clamp_or_wrap_cur_point_id(line_closed:bool=true) -> int:
	if !line_closed:
		if _moving_backwards:
			return clamp(_cur_point_id-1,0,_cur_line.points.size()-1)
		return clamp(_cur_point_id+1,0,_cur_line.points.size()-1)
	if cycle_movement:
		return wrap(_cur_point_id+1,0,_cur_line.points.size())
	return clamp(_cur_point_id+1,0,_cur_line.points.size()-1)

func move_extended(projectile:Projectile,delta:float) -> void:
	if _stop_moving:
		return
	var _cur_point_global_position := _cur_point*_cur_line.scale+_cur_line.global_position
	projectile.look_at(_cur_point_global_position)
	projectile.position += projectile.transform.x*projectile.speed*delta
	if debug:
		print(_cur_point_id,": ",abs(projectile.global_position-_cur_point_global_position)," ",point_zone)
	var distance_to_another_point := abs(projectile.global_position-_cur_point_global_position)
	if distance_to_another_point.x < point_zone.x and distance_to_another_point.y < point_zone.y:
		_set_new_point()
