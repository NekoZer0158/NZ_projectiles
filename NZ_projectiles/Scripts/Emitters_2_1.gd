extends Node

@export var emit_PE2D_ID : bool = true
@onready var pe_2d_id: PE2D_ID = $PE2D_ID
@export var projectiles : Dictionary[String,PackedScene]

func _ready() -> void:
	if emit_PE2D_ID:
		pe_2d_id.emit()
