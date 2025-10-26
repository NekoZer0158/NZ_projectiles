extends Button

@export var scene : String
@export var main_node : Node

func _ready() -> void:
	pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	var new_scene = load(scene).instantiate()
	main_node.get_parent().add_child(new_scene)
	main_node.queue_free()
