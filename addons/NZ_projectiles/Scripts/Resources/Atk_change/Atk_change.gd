@tool
@abstract
@icon("res://addons/NZ_projectiles/Icons/Atk_change/Atk_change.svg")
class_name Atk_change_projectile
extends Projectile_resource

## A resource to change atk

## This function will be called at the same time as the projectile _ready function (DON'T EDIT THIS)
func _ready(parent_node:Node) -> void: 
	if ProjectileChecks.check_if_this_a_projectile(parent_node):
		_ready_step_2(parent_node)

## EDIT THIS INSTEAD
func _ready_step_2(parent_node:Node) -> void:
	pass
