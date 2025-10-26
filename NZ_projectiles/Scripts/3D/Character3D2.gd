extends CharacterBody3D

@export var hp : int = 100:
	set(value):
		hp = value
		if hp <= 0:
			queue_free()
@export var character_class : CLASS = CLASS.WARRIOR
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

enum CLASS{WARRIOR=3,ARCHER,MAGE}

func _ready() -> void:
	match character_class:
		CLASS.WARRIOR:
			mesh_instance_3d.material_override.albedo_color = Color.BLUE
		CLASS.ARCHER:
			mesh_instance_3d.material_override.albedo_color = Color.SEA_GREEN
		CLASS.MAGE:
			mesh_instance_3d.material_override.albedo_color = Color.REBECCA_PURPLE

func got_damage(atk:int) -> void:
	hp -= atk*20
	print(name,"\nhp: ",hp)
	print("atk: ",atk)
	print("------------------")
