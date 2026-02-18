@icon("res://addons/NZ_projectiles/Icons/3D/Move_extended3D/Direction.svg")
class_name Move_direction_projectile3D
extends Move_extended_projectile3D

## Moves projectile in the direction

@export var direction : Vector3: ## If you need to set this through code, use Porjectile3DSetter
	set(value):
		direction = Vector3(clamp(value.x,-1,1),clamp(value.y,-1,1),clamp(value.z,-1,1))
@export var look_at_this_direction : bool = false
@export_custom(PROPERTY_HINT_NONE,"suffix:°") var add_those_degrees : Vector3

var added_degrees : bool = false

func move_extended(projectile:Projectile3D,delta:float) -> void:
	if look_at_this_direction:
		projectile.look_at(projectile.global_position+direction)
		look_at_this_direction = false
	if !added_degrees:
		if add_those_degrees != Vector3.ZERO:
			projectile.rotation_degrees += add_those_degrees
		added_degrees = true
	projectile.position += direction*projectile.speed*delta
