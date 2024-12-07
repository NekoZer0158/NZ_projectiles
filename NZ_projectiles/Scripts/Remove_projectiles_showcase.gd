extends Button

@export var markers_projectiles : Array[Marker2D]
@export var markers_characters : Array[Marker2D]

@onready var parent_parent_node := get_parent().get_parent()

var characters : Array[CharacterBody2D]

func create_projectiles() -> void:
	var cur_projectile : int = 0
	for i in markers_projectiles:
		cur_projectile += 1
		var new_projectile : Projectile_extended = parent_parent_node.PROJECTILE_EXTENDED.instantiate()
		new_projectile.atk = 15
		match cur_projectile:
			1:
				new_projectile.r_remove_projectile = RP_lives.new()
			2:
				new_projectile.r_remove_projectile = RP_dont.new()
			3:
				new_projectile.r_remove_projectile = RP_spawn_projectile.new()
				new_projectile.r_remove_projectile.spawn_this_projectile = load("res://NZ_projectiles/Projectiles/Projectile.tscn")
		i.add_child(new_projectile)

func _on_pressed() -> void:
	create_projectiles()
	for i in characters:
		i.queue_free()
	for i in markers_characters:
		var new_character : CharacterBody2D= parent_parent_node.TEST_CHARACTER.instantiate()
		new_character.dont_print = true
		i.add_child(new_character)
