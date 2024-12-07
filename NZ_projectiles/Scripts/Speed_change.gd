extends Button

@export var markers_projectiles : Array[Marker2D]
@export var markers_characters : Array[Marker2D]

@onready var parent_parent_node := get_parent().get_parent()

var character_1 : CharacterBody2D
var character_2 : CharacterBody2D
var character_3 : CharacterBody2D

func create_projectiles() -> void:
	var cur_projectile : int = 0
	for i in markers_projectiles:
		cur_projectile += 1
		var new_projectile : Projectile_extended = parent_parent_node.PROJECTILE_EXTENDED.instantiate()
		new_projectile.atk = 50
		match cur_projectile:
			1:
				new_projectile.r_speed_change = SC_increase.new()
				new_projectile.speed = 50
				new_projectile.r_speed_change.increase_to_this_amount = 500
			2:
				new_projectile.speed = 520
				new_projectile.r_speed_change = SC_condition_timer.new()
				new_projectile.r_speed_change.time = 2.03
				new_projectile.r_speed_change.speed_change = SC_increase.new()
				new_projectile.r_speed_change.speed_change.step = 10
				new_projectile.r_speed_change.speed_change.increase_to_this_amount = -250
				new_projectile.r_speed_change.after_condition_speed_change = SC_increase.new()
				new_projectile.r_speed_change.after_condition_speed_change.step = 15
				new_projectile.r_speed_change.after_condition_speed_change.increase_to_this_amount = 450
			3:
				new_projectile.r_speed_change = SC_random_range.new()
				new_projectile.r_speed_change.min_value = -150
				new_projectile.r_speed_change.max_value = 350
		i.add_child(new_projectile)

func _on_pressed() -> void:
	create_projectiles()
	parent_parent_node.check_and_free_character(character_1)
	parent_parent_node.check_and_free_character(character_2)
	parent_parent_node.check_and_free_character(character_3)
	character_1 = parent_parent_node.TEST_CHARACTER.instantiate()
	character_1.name = "Character_top"
	markers_characters[0].add_child(character_1)
	character_2 = parent_parent_node.TEST_CHARACTER.instantiate()
	character_2.name = "Character_middle"
	markers_characters[1].add_child(character_2)
	character_3 = parent_parent_node.TEST_CHARACTER.instantiate()
	character_3.name = "Character_bottom"
	markers_characters[2].add_child(character_3)
