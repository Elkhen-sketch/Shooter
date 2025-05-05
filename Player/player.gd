extends CharacterBody2D
"res://bullet/bullet.tscn"
var bullet = preload("res://bullet/bullet.tscn")

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var muzzle: Marker2D = $Muzzle
var muzzle_offset := Vector2.ZERO

const GRAVITY = 1000
const SPEED = 300 
const Jump = -300
const Jump_horizontal = 100

enum State { Idle, Run, Jump, Shoot }

var current_state : State
var muzzle_position
var shoot_timer := 0.0  

func _ready():
	current_state = State.Idle
	muzzle_offset = muzzle.position


func _physics_process(delta):
	player_shooting(delta)
	player_muzzle_position()

	if Input.is_action_just_pressed("shoot"):
		if $Shooting.playing:
			$Shooting.stop()
		else:
			$Shooting.play()
	queue_redraw()
	
	if shoot_timer <= 0:
		player_falling(delta)
		player_Idle(delta)
		player_run(delta)
		player_jump(delta)
	else:
		shoot_timer -= delta
		if shoot_timer <= 0:
			current_state = State.Idle

	move_and_slide()
	player_animations()
	#print("State: ", State.keys()[current_state])

func player_falling(delta):
	if !is_on_floor():
		velocity.y += GRAVITY * delta 

func player_Idle(delta):
	if is_on_floor():
		current_state = State.Idle

func player_run(delta):
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction != 0:
		current_state = State.Run
		animated_sprite_2d.flip_h = false if direction > 0 else true

func player_jump(delta):
	if Input.is_action_just_pressed("Jump"):
		velocity.y = Jump
		current_state = State.Jump
		
	if !is_on_floor() and current_state == State.Jump:
		var direction = Input.get_axis("move_left", "move_right")
		velocity.x += direction * Jump_horizontal * delta 

func player_shooting(delta):
	if Input.is_action_just_pressed("shoot") and is_on_floor():
		var bullet_instance = bullet.instantiate() as Node2D
		
		var shoot_direction = -1 if animated_sprite_2d.flip_h else 1
		bullet_instance.direction = shoot_direction

		bullet_instance.global_position = muzzle.global_position
		get_parent().add_child(bullet_instance)

		current_state = State.Shoot
		shoot_timer = 0.3
		
func player_muzzle_position():
	if animated_sprite_2d.flip_h:
		muzzle.position.x = -muzzle_offset.x
	else:
		muzzle.position.x = muzzle_offset.x

func player_animations():
	if current_state == State.Idle:
		animated_sprite_2d.play("Idle")
	elif current_state == State.Run and animated_sprite_2d.animation != "Shot1":
		animated_sprite_2d.play("Run")
	elif current_state == State.Jump:
		animated_sprite_2d.play("Jump")
	elif current_state == State.Shoot:
		animated_sprite_2d.play("Shot1")

	#match current_state:
		#State.Idle:
		#	animated_sprite_2d.play("Idle")
		#State.Run:
			#animated_sprite_2d.play("Run")
		#State.Jump:
			#animated_sprite_2d.play("Jump")
		#State.Shoot:
			#animated_sprite_2d.play("Shot1")
