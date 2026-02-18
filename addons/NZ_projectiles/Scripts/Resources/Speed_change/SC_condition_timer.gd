@tool
@icon("res://addons/NZ_projectiles/Icons/Speed_change/SC_condition_timer.svg")
class_name SC_condition_timer
extends SC_condition

## Uses one Speed_change_projectile resource and after the timer is over it's uses the other Speed_change_projectile resource

@export var time : float = 0.0:
	set(value):
		time = clampf(value,0,abs(value))

var timer : Timer

func _ready(parent_node:Node) -> void:
	if ProjectileChecks.check_if_this_a_projectile(parent_node):
		super(parent_node)
		if time == 0.0:
			push_error(resource_name,": time is 0")
			return
		timer = Timer.new()
		timer.timeout.connect(_on_timer_timeout)
		timer.one_shot = true
		parent_node.add_child(timer)

func reset() -> void:
	super()
	stop_timer()

func activate() -> void:
	if is_instance_valid(timer):
		if timer.is_stopped() and !condition_is_true:
			timer.start(time)
			if debug:
				print(resource_name,": timer has started | Time: ",Time.get_time_dict_from_system())

func stop_timer() -> void:
	if is_instance_valid(timer):
		timer.stop()
		if debug:
			print(resource_name,": timer has stopped | Time: ",Time.get_time_dict_from_system())

func _on_timer_timeout() -> void:
	condition_is_true = true
	#if speed_change is SC_increase:
		#if is_instance_valid(speed_change.timer):
			#speed_change.timer.queue_free()
	#if is_instance_valid(timer):
		#timer.queue_free()
