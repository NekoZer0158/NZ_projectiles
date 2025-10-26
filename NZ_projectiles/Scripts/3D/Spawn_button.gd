extends Button

@export var markers : Array[Marker3D]
@export var scenes : Array[PackedScene]
@export var add_to_this_node : Node

var remove_those_instances_after_button_pressed_again : Array[Node]

const FRIEND : int = 1

func _ready() -> void:
	if markers.size() != scenes.size():
		push_error("Not enough markers or scenes")
	pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	for i in remove_those_instances_after_button_pressed_again:
		if is_instance_valid(i):
			i.queue_free()
	remove_those_instances_after_button_pressed_again.clear()
	await get_tree().create_timer(0.05,true).timeout
	for i in range(0,scenes.size()):
		var scene = scenes[i].instantiate()
		if scene is CharacterBody3D:
			scene.type = FRIEND
		scene.name += "0"+str(i+1)
		remove_those_instances_after_button_pressed_again.append(scene)
		scene.position = markers[i].position
		add_to_this_node.add_child(scene)
