@tool
@icon("res://addons/NZ_projectiles/Icons/Speed_change/SC_condition_timer.svg")
class_name SC_condition_timer
extends SC_condition

@export var time : float = 0.0:
	set(value):
		time = clampf(value,0,abs(value))

var timer : Timer

func _ready(parent_node:Projectile) -> void:
	super(parent_node)
	if time == 0.0:
		push_error("No time")
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

func stop_timer() -> void:
	if is_instance_valid(timer):
		timer.stop()

func _on_timer_timeout() -> void:
	condition_is_true = true
	#if speed_change is SC_increase:
		#if is_instance_valid(speed_change.timer):
			#speed_change.timer.queue_free()
	#if is_instance_valid(timer):
		#timer.queue_free()
