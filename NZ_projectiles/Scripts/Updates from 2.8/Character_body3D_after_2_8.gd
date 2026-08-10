extends CharacterBody3D

@export var hp : int = 10:
	set(value):
		hp = value
		if hp <= 0:
			queue_free()
@export var speed : Vector3
@export var change_color : bool = true
@export_enum("Nothing","Friend","Enemy") var type : int
@export_group("Debug","debug_")
@export var debug_pring_atk : bool = false
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

enum {NOTHING,FRIEND,ENEMY}

func _ready() -> void:
	if change_color:
		match type:
			FRIEND:
				mesh_instance_3d.material_override.albedo_color = Color.GREEN
			ENEMY:
				mesh_instance_3d.material_override.albedo_color = Color.RED

func _physics_process(delta: float) -> void:
	position += speed*delta

func _reverse_speed() -> void:
	speed = -speed

func hit(atk:int) -> void:
	if debug_pring_atk:
		print(name,atk)
	hp -= atk

func hit_extended(atk:int) -> void:
	if debug_pring_atk:
		print(name,atk)
	hp -= atk

func hit_extended_speed(atk:int,_speed:int) -> void:
	hit(atk)
