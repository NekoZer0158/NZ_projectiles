@icon("res://addons/NZ_projectiles/Icons/Other/Extra/Projectile_resource_extra.svg")
@abstract
class_name Projectile_resource_extra
extends Projectile_resource

##This resource is to be used by other [Projectile_resource]

##[Projectile], [Projectile_extended], [Projectile3D] or [Projectile3D_extended]
## @deprecated
var projectile : Node

## This function should be called when you want to use this resource from another resource
func use_extra(cur_projectile:Node) -> void:
	pass
