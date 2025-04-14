extends Node2D

@onready var sprite = $Sprite2D 

var speed := 800
var direction := 1

func _ready():
	if sprite:
		sprite.flip_h = direction < 0
	else:
		print("shot")

func _physics_process(delta):
	position.x += direction * speed * delta


func _on_hitbox_area_entered(area: Area2D) -> void:
	print("bullet area entered")
	


func _on_hitbox_body_entered(body: Node2D) -> void:
	print ("bullet body entered")
