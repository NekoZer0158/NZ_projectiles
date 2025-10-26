extends Node

@export var types : Dictionary[Projectile3D,TYPES]

enum TYPES{NOTHING,FRIEND,ENEMY,WARRIOR,ARCHER,MAGE}

func _ready() -> void:
	for i in types.keys():
		i.type = types[i]
