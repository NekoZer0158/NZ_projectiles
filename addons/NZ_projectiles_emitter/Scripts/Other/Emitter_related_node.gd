@icon("res://addons/NZ_projectiles_emitter/Icons/Other/Emitter_related_node.svg")
@abstract
class_name Emitter_related_node
extends Node

@export_group("Settings")
@export var use_variable_as_key : bool = true ## If set to true then the value of the variable with a name custom_key_name will be used
@export var custom_key_name : String = "name" ## The value of that variable will be used as a key if use_variable_as_key is set to true, otherwise custom_key_name itself will be used (e.g. if the value is "name" then the name of the node will be used as a key)

var _emitter : Node

func _ready() -> void:
	_emitter = get_parent()
	if _emitter is not Projectile_emitter2D_base and _emitter is not Projectile_emitter3D_base:
		push_error("parent nod is not Projectile_emitter2D_base or Projectile_emitter3D_base")
		queue_free()
	_emitter.tree_exited.connect(_emitter_exited_tree)
	if use_variable_as_key:
		_emitter.related_nodes[get(custom_key_name)] = self
	else:
		_emitter.related_nodes[custom_key_name] = self
	
func _emitter_exited_tree() -> void:
	_emitter = null
