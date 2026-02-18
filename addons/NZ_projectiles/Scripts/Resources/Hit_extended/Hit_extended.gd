@tool
@abstract
@icon("res://addons/NZ_projectiles/Icons/Hit_extended/Default.svg")
class_name Hit_extended_projectile
extends Projectile_resource 

## Changes how hit_extended fucntion is called

@export_group("Variables and functions names","name_")
@export var name_hit_extended : StringName = "hit_extended" ## Look projectile class
@export var ignore_if_there_is_no_needed_extended_function : bool = false

func hit_extended(atk:int,body:Node,projectile:Node) -> bool: ## DON'T EDIT THIS FUNCTION
	if ProjectileChecks.check_if_body_has_this_and_its_type(body,name_hit_extended,TYPE_CALLABLE,!ignore_if_there_is_no_needed_extended_function) and ProjectileChecks.check_if_this_a_projectile(projectile):
		call_hit_extended_function(atk,body,projectile)
		return true
	return false

func call_hit_extended_function(atk:int,body:Node2D,projectile:Node) -> void: ## EDIT THIS
	body.call(name_hit_extended,atk)
