class_name Projectile_emitter2D_base
extends Node2D

@export var add_child_to_this_node : Node
@export var instantly_emit : bool = false
@export var error_if_above_node_is_null : bool = true

func _ready() -> void:
	if error_if_above_node_is_null and !is_instance_valid(add_child_to_this_node):
		push_error("add_child_to_this_node isn't valid")
	if instantly_emit:
		emit()

func emit() -> void:
	pass

func _add_projectile_instance_to_the_scene(projectile_instance:Projectile) -> void:
	if is_instance_valid(add_child_to_this_node):
		projectile_instance.position = global_position
		add_child_to_this_node.call_deferred("add_child",projectile_instance)
	else:
		add_child(projectile_instance)
