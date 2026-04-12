@icon("res://addons/NZ_projectiles_emitter/Icons/Projectile_emitter2D_base.svg")
@abstract
class_name Projectile_emitter2D_base
extends Node2D

@export var add_child_to_this_node : Node
@export var error_if_above_node_is_null : bool = true
@export var instantly_emit : bool = false
@export var new_life_time : float = -1.0
@export var debug : bool = false
@export_group("Replacers","rep_")
@export var rep_atk_change : Atk_change_projectile
@export var rep_speed_change : Speed_change_projectile
@export var rep_move_extended : Move_extended_projectile
@export var rep_hit_extended : Hit_extended_projectile
@export var rep_remove_projectile : Remove_projectile
#@export_group("Object pool","object_pool_")
#@export var object_pool_node : Node ## If it's not set then projectiles will queue_free(). Only works for [Projectile_extended] and [Projectile3D_extended]
#@export var object_pool_add_func_name : String

var can_emit : bool = true
var related_nodes : Dictionary ## This is for nodes, that have some connections to the emitter, like [Emitter_ammo], that adds ammo system and reloading.[br]All related nodes should be manually added through the nodes themselves. 
# If all resources are null, then it will ignore checking them at all, remember that if you want to add module at a runtime
var _check_replacers : bool = true
var _spawned_projectiles : int = 0 #Only counts projectiles if object_pool_node != null

signal projectile_was_emitted(projectile:Projectile)

func _ready() -> void:
	if error_if_above_node_is_null and !is_instance_valid(add_child_to_this_node):
		push_error("add_child_to_this_node isn't valid")
	if rep_atk_change == null and rep_speed_change == null and rep_move_extended == null and rep_hit_extended == null and rep_remove_projectile == null:
		_check_replacers = false
	#if object_pool_node != null:
		#if object_pool_add_func_name.is_empty():
			#push_error("object_pool_func_name is empty")
		#if object_pool_get_func_name.is_empty():
			#push_error("object_pool_get_func_name is empty")
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

func use_related_node(node_key:String,func_name:String) -> void:
	if node_key in related_nodes:
		related_nodes[node_key].call(func_name)

func _add_projectile_instance_to_the_scene(projectile_instance:Projectile,type:int=0) -> void:
	_set_variables_for_projectile(projectile_instance,type)
	if is_instance_valid(add_child_to_this_node):
		projectile_instance.position = global_position
		if new_life_time > -1.0:
			projectile_instance.life_time = new_life_time
		add_child_to_this_node.call_deferred("add_child",projectile_instance)
	else:
		add_child(projectile_instance)
	projectile_was_emitted.emit(projectile_instance)

func _set_variables_for_projectile(projectile_instance:Projectile,type:int=0,change_rotation:bool=true) -> void:
	projectile_instance.type = type
	if change_rotation:
		projectile_instance.rotation = rotation
	if new_life_time > -1.0:
		projectile_instance.life_time = new_life_time
	if _check_replacers and projectile_instance is Projectile_extended:
		_check_and_if_needed_replace_modules_in_projectiles(projectile_instance)
	if debug:
		print("--------------",projectile_instance.name,"--------------")
		print("type: ",projectile_instance.type)
		print("rotation: ",projectile_instance.rotation)
		print("rotation_degrees: ",projectile_instance.rotation_degrees)
