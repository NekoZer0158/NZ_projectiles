@icon("res://addons/NZ_projectiles_emitter/Icons/PE2D_ID.svg")
class_name PE2D_ID
extends Projectile_emitter2D_base

@export var node_with_projectiles : Node
@export_placeholder("No name") var dictionary_name_with_projectiles_and_ids : String
@export_placeholder("No ID") var default_projectile_id : String
@export var error_if_there_is_no_id : bool = true

func _ready() -> void:
	if !is_instance_valid(node_with_projectiles):
		push_error("node_with_projectiles isn't valid")
	super()

func emit(type:int=0) -> void:
	var projectile_instance : Projectile = node_with_projectiles.get(dictionary_name_with_projectiles_and_ids)[default_projectile_id].instantiate()
	_add_projectile_instance_to_the_scene(projectile_instance,type)

func emit_by_id(id:String,type:int=0) -> void:
	var dictionary_with_projectiles_and_ids : Dictionary[String,PackedScene] = node_with_projectiles.get(dictionary_name_with_projectiles_and_ids)
	var projectile_instance : Projectile
	if dictionary_with_projectiles_and_ids.has(id):
		projectile_instance  = dictionary_with_projectiles_and_ids[id].instantiate()
		_add_projectile_instance_to_the_scene(projectile_instance,type)
	else:
		if error_if_there_is_no_id:
			push_error("There is no ID: ",id," in dictionary_name_with_projectiles_and_ids")
		emit()
