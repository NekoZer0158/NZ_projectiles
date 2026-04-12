@icon("res://addons/NZ_projectiles_emitter/Icons/Other/Emitter_ammo.svg")
class_name Emitter_ammo
extends Node

## Parent node should be Projectile_emitter2D_base or Projectile_emitter3D_base.

@export_range(-1,99999) var cur_ammo_in_magazine : int = 5: ## if -1 then no ammo will be spent
	set(value):
		cur_ammo_in_magazine = value
		if _emitter != null:
			if cur_ammo_in_magazine >= ammo_per_shot:
				_emitter.can_emit = true
			else:
				_emitter.can_emit = false
@export_range(-1,99999) var max_ammo_in_magazine : int = 10 ## if -1 then max_ammo will be set the same as cur_ammo
@export_range(-1,99999) var all_ammo : int = 100 ## if -1 then all_ammo is infinite
@export_range(0,99999) var ammo_per_shot : int = 1
@export var debug : bool = false
@export_group("Settings")
@export var use_variable_as_key : bool = true
@export var custom_key_name : String = "name" ## The value of that variable will be used as a key if use_variable_as_key is set to true, otherwise custom_key_name itself will be used 
@export var lose_ammo_in_magazine_when_reloading : bool = false ## If set to true then every reload, ammo that is left in the magazine will be lost

var can_reload : bool = true
var _emitter : Node

func _ready() -> void:
	if max_ammo_in_magazine == -1:
		max_ammo_in_magazine = cur_ammo_in_magazine
	_emitter = get_parent()
	if _emitter is not Projectile_emitter2D_base and _emitter is not Projectile_emitter3D_base:
		push_error("parent nod is not Projectile_emitter2D_base or Projectile_emitter3D_base")
		queue_free()
	else:
		_emitter.projectile_was_emitted.connect(_emitter_projectile_was_emitted)
		_emitter.tree_exited.connect(_emitter_exited_tree)
		if use_variable_as_key:
			_emitter.related_nodes[get(custom_key_name)] = self
		else:
			_emitter.related_nodes[custom_key_name] = self
		if debug:
			print("_emitter.related_nodes: ",_emitter.related_nodes)

func spend_ammo() -> void:
	cur_ammo_in_magazine -= ammo_per_shot

func reload() -> bool:
	if can_reload:
		if cur_ammo_in_magazine == -1:
			return true
		if all_ammo == -1 or all_ammo > 0:
			if all_ammo == -1:
				cur_ammo_in_magazine = max_ammo_in_magazine
			elif lose_ammo_in_magazine_when_reloading:
				if all_ammo > max_ammo_in_magazine:
					cur_ammo_in_magazine = max_ammo_in_magazine
					all_ammo -= max_ammo_in_magazine
				else:
					cur_ammo_in_magazine = all_ammo
					all_ammo = 0
			else:
				if all_ammo > 0:
					var needed_ammo = max_ammo_in_magazine-cur_ammo_in_magazine
					if all_ammo >= needed_ammo:
						cur_ammo_in_magazine += needed_ammo
						all_ammo -= needed_ammo
					else:
						cur_ammo_in_magazine += all_ammo
						all_ammo = 0
			if debug:
				print("cur_ammo_in_magazine: ",cur_ammo_in_magazine)
				print("max_ammo_in_magazine: ",max_ammo_in_magazine)
				print("all_ammo: ",all_ammo)
			return true
	return false

func _emitter_exited_tree() -> void:
	_emitter = null

func _emitter_projectile_was_emitted(_projectile) -> void:
	cur_ammo_in_magazine -= ammo_per_shot
	if debug:
		print("cur_ammo_in_magazine: ",cur_ammo_in_magazine)
