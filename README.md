# NZ projectiles
Plugin for Godot that adds a projectile system in 2D&3D. There are four projectile classes (2 each for 2D & 3D), base one and extended, to which you can add more stuff, like changing speed every second or making it disappear only after interacting with 3 objects.
Also includes two more plugins NZ_projectiles_custom (adds a new projectile class, that is much more customizible, but harder to work with) and NZ_projectiles_emiiter (adds nodes with which you can emmit projectiles). Both plugins require the main one - NZ_projectiles.

## Changelog

### 2.5
	Move Projectile_custom and its resources to the separate plugin - NZ_projectiles_custom
	Add icon for Projectile_resource
	Add ACT_func - change atk by calling a function in a resource
	Check README in NZ_projectiles_custom
	NZ_projectiles_custom set version to Experimental 0.2 (the previous version in 2.4 consider as Experimental 0.1)
### 2.4
	Added Projectile_custom - a new projectile class (this is not a subclass for Projectile), it has much more customization than Projectile_extended. The idea is to give you an ability to make what you want without coding. EXPERIMENTAL
	Added Projectile_custom_resource - a resource for Projectile_custom. EXPERIMENTAL
	Added Update_2_4 scene
### 2.3
	Added Update_2_3 scene
	Added 3D emitters
	Added RP_multiple - activate multiple Remove_projectile resources at once
	Added RP_other and HE_other - activate a function in a different Projectile_resource
	All projectile resoucres are a subclass of Projectile_resource instead of Resource
	NZ_projectiles_emitter updated to 1.2
### 2.2
	Added Update_2_2 scene
	NZ_projectiles_emitter updated to 1.1
	Some fixes in Update_2_1 scene
### 2.1
	Added RP_group (Remove every projectile in the group)
	Added PaPr_random (Random particle on every call of the function)
	Added new plugin - NZ_projectiles_emiitter
### 2.0
	Added 3D support
	Changed ID from int to String.
	Moved ID from Projectile_extended to Projectile
	Changed some functions names to include _ in them, also removed deprecated function
	Removed clamp functions from SC_random_range

## Projectile
![Gif_1](/NZ_projectiles/gifs/gif_1.gif)

## Extended projectile
You can set a resource to change projectiles speed, atk, movement, hit arguments and removal logic.

### Speed
![Gif_2](/NZ_projectiles/gifs/gif_2.gif)

### Movement
![Gif_3](/NZ_projectiles/gifs/gif_3.gif)

### Removal
![Gif_4](/NZ_projectiles/gifs/gif_4.gif)

### Combined
![Gif_5](/NZ_projectiles/gifs/gif_5.gif)

## 3D movement
![Gif_6](/NZ_projectiles/gifs/gif_6.gif)

## 3D extended
![Gif_7](/NZ_projectiles/gifs/gif_7.gif)

## Emitters example
![Gif_8](/NZ_projectiles/gifs/gif_8.gif)
