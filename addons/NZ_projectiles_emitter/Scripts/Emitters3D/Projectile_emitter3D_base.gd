@icon("res://addons/NZ_projectiles_emitter/Icons/Projectile_emitter3D_base.svg")
class_name Projectile_emitter3D_base
extends Marker3D

@export var add_child_to_this_node : Node
@export var instantly_emit : bool = false
@export var error_if_above_node_is_null : bool = true

func _ready() -> void:
	if error_if_above_node_is_null and !is_instance_valid(add_child_to_this_node):
		push_error("add_child_to_this_node isn't valid")
	if instantly_emit:
		emit()

func emit(_type:int=0) -> void:
	pass

func _add_projectile_instance_to_the_scene(projectile_instance:Projectile3D,type:int=0) -> void:
	_set_variables_for_projectile(projectile_instance,type)
	if is_instance_valid(add_child_to_this_node):
		projectile_instance.position = global_position
		add_child_to_this_node.call_deferred("add_child",projectile_instance)
	else:
		add_child(projectile_instance)

func _set_variables_for_projectile(projectile_instance:Projectile3D,type:int=0) -> void:
	projectile_instance.type = type
	projectile_instance.rotation = rotation
