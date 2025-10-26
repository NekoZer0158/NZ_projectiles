@icon("res://addons/NZ_projectiles/Icons/Projectile3D.svg")
class_name Projectile3D
extends Area3D

## Base class for every projectile

@export_placeholder("There is no ID") var id : String
@export var atk : int
@export var speed : int
@export var life_time : float:
	set(value):
		life_time = abs(value)
@export var activated : bool = true:
	set(value):
		activated = value
		if life_time > 0 and is_instance_valid(life_timer):
			if activated:
				if life_timer.paused:
					life_timer.paused = false
				else:
					life_timer.start(life_time)
			else:
				life_timer.paused = true
@export_group("Remove when colliding with","remove_when_")
## Ignores two variables below and just tries to hit anything
@export var remove_when_ignore_and_try_to_hit_anything : bool = false
## Removes projectile when it's touching GridMap
@export var remove_when_gridmap : bool = true
## Removes projectile when it's touching StaticBody2D
@export var remove_when_static_body : bool = true
@export_group("Variables and functions names","name_")
@export var name_type : StringName = "type" ## Only hit if projectile type and body type isn't the same
@export var name_hit : StringName = "hit" ## Name of the function that deals damage in body

var life_timer : Timer
var type : int ## projectile will hit bodies, only with a different type

func _ready() -> void:
	_set_everything()

func _physics_process(delta:float):
	if activated:
		_move(delta)

func _move(delta:float) -> void:
	position += transform.basis.x*speed*delta

func _set_everything() -> void:
	_set_life_timer()
	# Area3D
	body_entered.connect(_on_area_3d_body_entered)

func _set_life_timer() -> void:
	if life_time > 0:
		life_timer = Timer.new()
		life_timer.timeout.connect(_on_life_timer_timeout)
		life_timer.one_shot = true
		add_child(life_timer)
		if activated:
			life_timer.start(life_time)

func remove_projectile(_colliding_with_remove_when_collide:bool=false) -> void:
	queue_free()

func _on_life_timer_timeout() -> void:
	queue_free()

func hit_body(body:Node3D) -> void:
	if ProjectileChecks.check_if_body_has_this_and_its_type(body,name_hit,TYPE_CALLABLE,true):
		body.call(name_hit,atk)
		remove_projectile()

func _check_if_is_it_a_gridmap(remove_if_it_is:bool,body:Node3D) -> bool:
	if remove_if_it_is and body is GridMap:
		return true
	return false

func _check_if_is_it_a_static_body(remove_if_it_is:bool,body:Node3D) -> bool:
	if remove_if_it_is and body is StaticBody3D:
		return true
	return false

func _on_area_3d_body_entered(body:Node3D):
	if remove_when_ignore_and_try_to_hit_anything or (!_check_if_is_it_a_gridmap(remove_when_gridmap,body) and !_check_if_is_it_a_static_body(remove_when_static_body,body)):
		if ProjectileChecks.check_if_body_has_this_and_its_type(body,name_type,TYPE_INT):
			if body.get(name_type) != type:
				hit_body(body)
	else:
		remove_projectile(true)
