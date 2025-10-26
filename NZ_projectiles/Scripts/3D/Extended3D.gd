extends Node

@export var projectile3D_extended : Projectile3D_extended
@export var follow_this_thing : CharacterBody3D

func _ready() -> void:
	ProjectileSetter.set_node_to_which_projectile3D_moves_to(projectile3D_extended,follow_this_thing,true,true,ProjectileEnum.BasisAxis.Z)
