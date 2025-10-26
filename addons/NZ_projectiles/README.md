# NZ projectiles
Plugin for Godot that adds a projectile system in 2D&3D. There are two projectile classes, base one and extended, to which you can add more stuff, like changing speed every second or making it disappear only after interacting with 3 objects.

## Changelog

### 2.0
	Added 3D support
	Changed ID from int to String.
	Moved ID from Projectile_extended to Projectile
	Changed some functions names to include _ in them, also removed deprecated function
	Removed clamp functions from SC_random_range
	
## Extended projectile
You can set a resource to change projectiles speed, atk, movement, hit arguments and removal logic.
