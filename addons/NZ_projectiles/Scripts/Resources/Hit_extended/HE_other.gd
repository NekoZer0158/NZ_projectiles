@icon("res://addons/NZ_projectiles/Icons/Hit_extended/Other.svg")
class_name HE_other
extends Hit_extended_projectile

## Calls other_function_name in a projectile_resource when hitting something

@export var other_function_name : String
@export var projectile_resource : Projectile_resource
@export var use_projectile_as_arg : bool = true
@export var hit_first : bool = true
@export var update_atk : bool = false

func call_hit_extended_function(atk:int,body:Node2D,projectile:Node) -> void:
	if hit_first:
		super(atk,body,projectile)
	if use_projectile_as_arg:
		projectile_resource.call(other_function_name,projectile)
	else:
		projectile_resource.call(other_function_name)
	if update_atk:
		atk = projectile.atk
	if !hit_first:
		super(atk,body,projectile)
