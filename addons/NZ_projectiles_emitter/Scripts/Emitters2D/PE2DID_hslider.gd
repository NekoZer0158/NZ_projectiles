@icon("res://addons/NZ_projectiles_emitter/Icons/PE2DID_hslider.svg")
class_name PE2DID_Hslider
extends PE2DID_slider

## @experimental
## Recommend to not change position or rotation during runtime

@export var hslider : HSlider

func _ready() -> void:
	super()
	if !is_instance_valid(hslider):
		push_error("hslider isn't valid")
	if autoconnect_drag_ended:
		hslider.drag_ended.connect(_on_slider_drag_ended)
	_calculate_all_needed_slider_values(hslider)

func _get_random_position_from_slider() -> Vector2:
	var random_pos : Vector2
	random_pos.x = hslider.global_position.x+randf_range(0,hslider.value*_one_step_pixel_size)
	random_pos.y = hslider.global_position.y+hslider.size.y/2
	if hslider.rotation_degrees != 0:
		random_pos = (random_pos-hslider.global_position).rotated(hslider.rotation)+hslider.global_position
	if debug:
		print("random_pos: ",random_pos)
	return random_pos

func _on_slider_drag_ended(value_changed:bool) -> void:
	if value_changed:
		_calculate_dragger_pos(hslider,true)
		if debug:
			queue_redraw()

func _get_cur_slider() -> Slider:
	return hslider

func _get_rotation_to_front() -> float:
	return 90
