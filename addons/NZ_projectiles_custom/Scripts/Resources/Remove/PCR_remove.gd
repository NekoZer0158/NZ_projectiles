@icon("res://addons/NZ_projectiles_custom/Icons/Remove/PCR_remove.svg")
class_name PCR_remove
extends Projectile_custom_resource

## @experimental

func remove_projectile(projectile:Projectile_custom,_args) -> void:
	projectile.queue_free()
