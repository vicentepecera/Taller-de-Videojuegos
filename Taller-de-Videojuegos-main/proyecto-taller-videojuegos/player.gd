extends CharacterBody3D
class_name Playerclass
# Establecemos un timer
var timer = 0
# Definimos velocidad personaje
@export var SPEED = 10
# Definimos velocidad salto
@export var jump = 20
# Definimos camara
@onready var camera = $SpringArmPivot/Camera3D
var lastdirection = Vector3(0,0,-1)
@onready var skin = $skin
# Definimos el animador
#@onready var anim_player = $skeleton_mage/AnimationPlayer
#@onready var audioplayer = $AudioStreamPlayer3D
#@onready var audioplayer2 = $AudioStreamPlayer3D2
# Establecemos un switch para bloquear animacion
var anim_bloq = false
# Definimos gravedad
var g = (ProjectSettings.get_setting("physics/3d/default_gravity"))*10
# Sensibilidad del mouse
@export var sens = 0.5
# Definimos la vida del personaje
@export var health = 100
# Definimos al enemigo

func takedamage(cantidad):
	health -= cantidad
#	audioplayer2.play()
	
func _ready():
#	anim_player.play("Idle")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func jumping():
	#anim_bloq = true
	#audioplayer.play()
	# Aca tienes que hacer una funcion que haga la animacion de salto
	#anim_player.speed_scale = 2.0  # 2x más rápid
	#anim_player.play("Jump_Start")
	velocity.y = jump
	#await anim_player.animation_finished
	#anim_player.speed_scale = 1.0
	#anim_player.play("Jump_Idle")
	#while not is_on_floor():
	#	await get_tree().process_frame
	#anim_bloq = false

func _physics_process(delta):
	# Actualizamos timer
	timer += delta
	if not is_on_floor():
		velocity.y -= delta*g
	if (Input.is_action_just_pressed("ui_accept") and is_on_floor()) :
		jumping()
	# Manejamos el movimiento
	var input_dir = Input.get_vector("left","right","forward","backward")
	var direction = (transform.basis*Vector3(input_dir.x,0,input_dir.y)).normalized()
	direction = direction.rotated(Vector3.UP,camera.global_rotation.y)
	var walking = ["left","right","forward","backward"]
	var moving = false
	if is_on_floor() and not anim_bloq:
		for i in walking:
			if Input.is_action_pressed(i):
				#anim_player.play("Running_A")
				moving = true
		#if moving == false:
			#anim_player.play("Idle")
	if direction:
		lastdirection = direction
		var target_angle = atan2(direction.x, direction.z) + PI
		skin.rotation.y = lerp_angle(skin.rotation.y, target_angle, 0.2)
		velocity.x = direction.x*SPEED
		velocity.z = direction.z*SPEED
	else:
		velocity.x = move_toward(velocity.x,0,SPEED)
		velocity.z = move_toward(velocity.z,0,SPEED)
	move_and_slide()
