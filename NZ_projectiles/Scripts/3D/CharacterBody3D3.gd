extends CharacterBody3D

@export var hp : int = 10:
	set(value):
		hp = value
		if hp <= 0:
			queue_free()
@export_enum("Nothing","Friend","Enemy") var type : int
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

enum {NOTHING,FRIEND,ENEMY}

func _ready() -> void:
	match type:
		FRIEND:
			mesh_instance_3d.material_override.albedo_color = Color.GREEN
		ENEMY:
			mesh_instance_3d.material_override.albedo_color = Color.ORANGE

func hit(atk:int) -> void:
	print(name,"\nhp (before): ",hp)
	hp -= atk
	print("hp (after): ",hp)
	print("atk: ",atk)
	print("------------------3")
