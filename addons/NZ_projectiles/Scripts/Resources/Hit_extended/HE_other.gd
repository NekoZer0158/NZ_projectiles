@icon("res://addons/NZ_projectiles/Icons/Hit_extended/Other.svg")
class_name HE_other
extends Hit_extended_projectile

@export var other_function_name : String
@export var projectile_resource : Projectile_resource

func call_hit_extended_function(atk:int,body:Node2D,projectile:Node) -> void:
	super(atk,body,projectile)
	projectile_resource.call(other_function_name,projectile)
