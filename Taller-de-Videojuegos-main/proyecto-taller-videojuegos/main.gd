extends Node3D

@onready var sword = $CharacterBody3D/Hand/Sword
@onready var player = $CharacterBody3D

var launching = true
func _ready():
	sword.throw.connect(swordlaunch)

func swordlaunch():
	launching = true

func _process(delta):
	if launching == true:
		sword.position.x += 0.01
