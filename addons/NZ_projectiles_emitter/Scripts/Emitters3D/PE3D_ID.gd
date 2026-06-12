@icon("res://addons/NZ_projectiles_emitter/Icons/PE3D_ID.svg")
class_name PE3D_ID
extends Projectile_emitter3D_base

@export var node_with_projectiles : Node
@export var getting_method : GettingMethod
@export_placeholder("No name") var dictionary_name_with_projectiles_and_ids : String ## Will be used only if getting_method is set to Variable
@export_placeholder("No function name") var function_name : String ## Will be used only if getting_method is set to Functiion
@export_placeholder("No ID") var default_projectile_id : String
@export var error_if_there_is_no_id : bool = true

enum GettingMethod{VARIABLE,FUNCTION}

func _ready() -> void:
	if !is_instance_valid(node_with_projectiles):
		push_error("node_with_projectiles isn't valid")
	if dictionary_name_with_projectiles_and_ids.is_empty() and getting_method == GettingMethod.VARIABLE:
		push_error("dictionary_name_with_projectiles_and_ids is empty")
	super()

func emit(type:int=0) -> void:
	if can_emit:
		var projectile_instance : Projectile3D = node_with_projectiles.get(dictionary_name_with_projectiles_and_ids)[default_projectile_id].instantiate()
		_add_projectile_instance_to_the_scene(projectile_instance,type)

func get_projectile_by_method(id:String) -> Projectile3D:
	match getting_method:
		GettingMethod.VARIABLE:
			var dictionary_with_projectiles_and_ids : Dictionary[String,PackedScene] = node_with_projectiles.get(dictionary_name_with_projectiles_and_ids)
			if dictionary_with_projectiles_and_ids.has(id):
				return dictionary_with_projectiles_and_ids[id].instantiate()
			else:
				if error_if_there_is_no_id:
					push_error("There is no id: ",id," in dictionary with projectiles")
				emit()
		GettingMethod.FUNCTION:
			var projectile_instance = node_with_projectiles.call(function_name,id)
			if projectile_instance == null:
				return node_with_projectiles.call(function_name,default_projectile_id)
			return projectile_instance
	return null

func emit_by_id(id:String,type:int=0) -> void:
	if can_emit:
		var projectile_instance : Projectile3D = get_projectile_by_method(id)
		if debug:
			print("ID: ",id)
		if projectile_instance != null:
			_add_projectile_instance_to_the_scene(projectile_instance,type)
