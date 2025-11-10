extends Node

@export var emit_PE2D_simple2 : bool = true
@onready var pe_2d_simple_2: PE2D_ID = $PE2D_ID
@export var projectiles : Dictionary[String,PackedScene]

func _ready() -> void:
	if emit_PE2D_simple2:
		pe_2d_simple_2.emit()
