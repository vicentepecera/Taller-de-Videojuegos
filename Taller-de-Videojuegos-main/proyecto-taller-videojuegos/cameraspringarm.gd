extends Node3D

@export var mouse_sensibility: float = 0.005
@onready var spring_arm :=$SpringArm3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotation.y -= event.relative.x * mouse_sensibility
		rotation.y = wrapf(rotation.y,0.0,TAU)
		rotation.x -= event.relative.y * mouse_sensibility
		rotation.x = clamp(rotation.x, -PI/2,PI/4)
	if event.is_action_pressed("zoom") and spring_arm.spring_length>=2:
		spring_arm.spring_length -= 1
	if event.is_action_pressed("zoomout") and spring_arm.spring_length <=6:
		spring_arm.spring_length += 1
	if event.is_action_pressed("tab"):
		get_tree().quit()
