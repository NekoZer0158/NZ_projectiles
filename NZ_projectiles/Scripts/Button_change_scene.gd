extends Button

@export_file() var change_to_this_scene : String

func _on_pressed() -> void:
	if change_to_this_scene.length() > 0:
		var new_scene = load(change_to_this_scene).instantiate()
		get_parent().get_parent().get_parent().add_child(new_scene)
		get_parent().get_parent().queue_free()
