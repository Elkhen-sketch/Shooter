extends Node2D

@onready var sprite = $Sprite2D 

var bullet_impact_effect = preload("res://Player/bulletimpacteffect.tscn")

var speed := 800
var direction := 1
var damage_amount : int = 1

func _ready():
	if sprite:
		sprite.flip_h = direction < 0
	else:
		print("shot")

func _physics_process(delta):
	position.x += direction * speed * delta

func _on_timer_timeout():
	queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	print("bullet area entered")
	bullet_impact()
	

func _on_hitbox_body_entered(body: Node2D) -> void:
	print ("bullet body entered")
	bullet_impact()
	

func get_damage_amount() -> int:
	return damage_amount

func bullet_impact():
	var bullet_impact_effect_instance = bullet_impact_effect.instantiate() as Node2D
	bullet_impact_effect_instance.global_position = global_position
	get_parent().add_child(bullet_impact_effect_instance)
	queue_free()
