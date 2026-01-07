# NZ projectiles emitter
Emit projectiles from plugin NZ_projectiles (For now emits only 2D projectiles)
REQUIRES: NZ_projectiles

## Emitters
Projectile_emitter2D_base - base for every 2D emitter
PE2D_simple - the simplest projectile emitter, just put the scene with a projectile and emit or set instantly_emit to true
PE2D_ID - get projectile by ID from the dictionary in the specific node and emit it
PE2DID_line - emit projectile from any point on the line

## Changelog

### 1.2
	Added 3D emitters
### 1.1
	Added PE2DID_line, with it you can emit projectile from any point on the line
	Added new argument to emit function - type, with which you can set type to the projectile when emitting it
	Projectiles will have the same rotation as the emitter, except PE2DID_line
	Added icons
### 1.0
	Release
