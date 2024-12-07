extends Button

@export var markers_projectiles : Array[Marker2D]
@export var markers_characters : Array[Marker2D]

@onready var parent_parent_node := get_parent().get_parent()

var character_1 : CharacterBody2D
var character_2 : CharacterBody2D

func create_projectiles() -> void:
	var cur_projectile : int = 0
	for i in markers_projectiles:
		cur_projectile += 1
		var new_projectile : Projectile_extended= parent_parent_node.PROJECTILE_EXTENDED.instantiate()
		match cur_projectile:
			1:
				new_projectile.r_atk_change = AC_random_range.new()
				new_projectile.r_atk_change.min_value = -15
				new_projectile.r_atk_change.max_value = 15
			2:
				new_projectile.r_atk_change = AC_time.new()
				new_projectile.r_atk_change.increase_atk_to_this = 100
				new_projectile.r_atk_change.atk_step = 10
				new_projectile.r_atk_change.time = 0.5
		i.add_child(new_projectile)

func _on_pressed() -> void:
	create_projectiles()
	parent_parent_node.check_and_free_character(character_1)
	parent_parent_node.check_and_free_character(character_2)
	character_1 = parent_parent_node.TEST_CHARACTER.instantiate()
	character_1.name = "Character_top"
	markers_characters[0].add_child(character_1)
	character_2 = parent_parent_node.TEST_CHARACTER.instantiate()
	character_2.name = "Character_bottom"
	markers_characters[1].add_child(character_2)
