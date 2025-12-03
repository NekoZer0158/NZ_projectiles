extends Node

@export var projectiles3D : Dictionary[String,PackedScene]
@export var emitter_ID : PE3D_ID
@export var timer_time : float = 0.5

var cur_type : int:
	set(value):
		cur_type = wrapi(value,0,3)

func _ready() -> void:
	var timer := Timer.new()
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	timer.start(timer_time)

func _on_timer_timeout() -> void:
	emitter_ID.emit_by_id("extended",cur_type)
	cur_type += 1


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area is Projectile3D:
		area.queue_free()
