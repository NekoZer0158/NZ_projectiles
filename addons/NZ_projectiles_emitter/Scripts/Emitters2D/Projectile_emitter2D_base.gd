@icon("res://addons/NZ_projectiles_emitter/Icons/Projectile_emitter2D_base.svg")
@abstract
class_name Projectile_emitter2D_base
extends Node2D

@export var add_child_to_this_node : Node
@export var instantly_emit : bool = false
@export var error_if_above_node_is_null : bool = true
@export var debug : bool = false
@export_group("Replacers","rep_")
@export var rep_atk_change : Atk_change_projectile
@export var rep_speed_change : Speed_change_projectile
@export var rep_move_extended : Move_extended_projectile
@export var rep_hit_extended : Hit_extended_projectile
@export var rep_remove_projectile : Remove_projectile

# If all resources are null, then it will ignore checking them at all, remember that if you want to add module at a runtime
var _check_replacers : bool = true

func _ready() -> void:
	if error_if_above_node_is_null and !is_instance_valid(add_child_to_this_node):
		push_error("add_child_to_this_node isn't valid")
	if instantly_emit:
		emit()

func _check_and_if_needed_replace_modules_in_projectiles(projectile_instance:Projectile_extended) -> void:
	if rep_atk_change != null:
		projectile_instance.r_atk_change = rep_atk_change
	if rep_speed_change != null:
		projectile_instance.r_speed_change = rep_speed_change
	if rep_move_extended != null:
		projectile_instance.r_move_extended = rep_move_extended
	if rep_hit_extended != null:
		projectile_instance.r_hit_extended = rep_hit_extended
	if rep_remove_projectile != null:
		projectile_instance.r_remove_projectile = rep_remove_projectile

func emit(_type:int=0) -> void:
	pass

func _add_projectile_instance_to_the_scene(projectile_instance:Projectile,type:int=0) -> void:
	_set_variables_for_projectile(projectile_instance,type)
	if is_instance_valid(add_child_to_this_node):
		projectile_instance.position = global_position
		add_child_to_this_node.call_deferred("add_child",projectile_instance)
	else:
		add_child(projectile_instance)

func _set_variables_for_projectile(projectile_instance:Projectile,type:int=0) -> void:
	projectile_instance.type = type
	projectile_instance.rotation = rotation
	if _check_replacers and projectile_instance is Projectile_extended:
		_check_and_if_needed_replace_modules_in_projectiles(projectile_instance)
