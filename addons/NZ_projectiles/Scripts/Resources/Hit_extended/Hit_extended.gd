@tool
@icon("res://addons/NZ_projectiles/Icons/Hit_extended/Default.svg")
class_name Hit_extended_projectile
extends Resource 

@export_group("Variables and functions names","name_")
@export var name_hit_extended : StringName = "hit_extended" ## Look projectile class

func hit_extended(atk:int,body:Node2D,projectile:Projectile) -> bool: ## DON'T EDIT THIS FUNCTION
	if ProjectileChecks.check_if_body_has_this_and_its_type(body,name_hit_extended,TYPE_CALLABLE,true):
		call_hit_extended_function(atk,body,projectile)
		return true
	return false

func call_hit_extended_function(atk:int,body:Node2D,projectile:Projectile) -> void: ## EDIT THIS
	body.call(name_hit_extended,atk)
	push_warning("Don't use this class, use subclasses")
