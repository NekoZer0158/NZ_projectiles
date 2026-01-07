@icon("res://addons/NZ_projectiles_custom/Icons/Projectile_custom.svg")
class_name Projectile_custom
extends Area2D

## @experimental
## Don't use 'self' as a key in other_hit_arg_key_and_variable_names and other_remove_arg_key_and_variable_names, because it is used to acces a variable here, not from dictionary

@export_placeholder("There is no ID") var id : String
@export var type : Variant
@export var check_if_body_has_type : bool = true
@export var atk_key : String
@export var atk_variable_name : StringName
@export var variable_and_function_resources : Dictionary[String,Projectile_custom_resource] = {}
@export var ready_resources : Array[PCR_usable] = []
@export var phyisics_process_resources : Array[PCR_usable] = []
@export_group("Hit")
@export var hit_resource : PCR_hit
@export var other_hit_arg_key_and_variable_names : Dictionary[String,String]
@export var add_hit_args_back : bool = true
@export var hit_body_classes : Array[String] = ["CharacterBody2D"]
@export var hit_body_custom_classes : Array[String] = []
@export_group("Remove")
@export var remove_resource : PCR_remove
@export var other_remove_arg_key_and_variable_names : Dictionary[String,String]
@export var add_remove_args_back : bool = true
@export var remove_body_classes : Array[String] = ["TileMapLayer","StaticBody2D"]
@export var remove_body_custom_classes : Array[String] = []
@export_group("Variables and functions names","name_")
@export var name_type : StringName = "type" ## Only hit if projectile type and body type isn't the same
@export var name_hit : StringName = "hit" ## Name of the function that deals damage in body

var _type_type : Variant

func _ready() -> void:
	if hit_resource == null:
		push_error("No hit_resource")
	if remove_resource == null:
		push_error("No remove_resource")
	_type_type = typeof(type)
	for i in ready_resources:
		i.use(self)

func _physics_process(delta: float) -> void:
	for i in phyisics_process_resources:
		i.use(self,delta)

func _hit_body(body:Node2D,args) -> void:
	if add_hit_args_back:
		for i in other_hit_arg_key_and_variable_names.keys():
			if i == "self":
				args.push_back(get(other_hit_arg_key_and_variable_names[i]))
			else:
				args.push_back(variable_and_function_resources[i].get(other_hit_arg_key_and_variable_names[i]))
	else:
		var new_args : Array = []
		for i in other_hit_arg_key_and_variable_names.keys():
			if i == "self":
				args.append(get(other_hit_arg_key_and_variable_names[i]))
			else:
				new_args.append(variable_and_function_resources[i].get(other_hit_arg_key_and_variable_names[i]))
		new_args.append_array(args)
		args = new_args
	hit_resource.hit(variable_and_function_resources[atk_key].get(atk_variable_name),body,self,name_hit,args)
	_remove_projectile(args)

func _remove_projectile(args) -> void:
	if add_remove_args_back:
		for i in other_remove_arg_key_and_variable_names.keys():
			if i == "self":
				args.push_back(get_indexed(other_remove_arg_key_and_variable_names[i]))
			else:
				args.push_back(variable_and_function_resources[i].get_indexed(other_remove_arg_key_and_variable_names[i]))
	else: # Adds arguments from other_hit_arg_key_and_variable_names before signal arguments
		var new_args : Array = []
		for i in other_remove_arg_key_and_variable_names.keys():
			if i == "self":
				new_args.append(get_indexed(other_remove_arg_key_and_variable_names[i]))
			else:
				new_args.append(variable_and_function_resources[i].get_indexed(other_remove_arg_key_and_variable_names[i]))
		new_args.append_array(args)
		args = new_args
	remove_resource.remove_projectile(self,args)

func get_variable_in_resource(resource_key:String,variable_name:String) -> Variant:
	return variable_and_function_resources[resource_key].get_indexed(variable_name)

func set_variable_in_resource(resource_key:String,variable_name:String,new_value:Variant) -> void:
	variable_and_function_resources[resource_key].set_indexed(variable_name,new_value)

func call_function_by_id_in_resource(resource_key:String,function_name:String) -> Variant:
	return variable_and_function_resources[resource_key].call(function_name)

func call_function_by_id_in_resource_no_return(resource_key:String,function_name:String) -> void:
	variable_and_function_resources[resource_key].call(function_name)

func _on_body_entered(body: Node2D,...args) -> void:
	var body_class_name := body.get_class()
	var body_script := body.get_script()
	var body_custom_class_name
	if body_script != null:
		body_custom_class_name = body.get_script().get_global_name()
	if body_class_name in hit_body_classes or body_custom_class_name in hit_body_custom_classes:
		if !check_if_body_has_type or (check_if_body_has_type and "type" in body):
			if _type_type != body.type:
				_hit_body(body,args)
	elif body_class_name in remove_body_classes or body_custom_class_name in remove_body_custom_classes:
		_remove_projectile(args)
