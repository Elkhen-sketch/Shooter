extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const GRAVITY = 1000
const SPEED = 300 
const Jump = -300
const Jump_horizontal = 100

<<<<<<< HEAD
enum State { Idle, Run, Jump, Shoot }
=======
enum State { Idle, Run, Jump, Shot }
>>>>>>> 530f1b82dbf11fb30956c665d6d65b35706e49be

var current_state : State
var shoot_timer := 0.0  

func _ready():
	current_state = State.Idle

func _physics_process(delta):
<<<<<<< HEAD
	player_shooting(delta)

=======
	player_falling(delta)
	player_Idle(delta)
	player_run(delta)
	player_jump(delta)
	player_shooting(delta)
>>>>>>> 530f1b82dbf11fb30956c665d6d65b35706e49be
	
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
	print("State: ", State.keys()[current_state])

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
<<<<<<< HEAD

func player_shooting(delta):
	if Input.is_action_just_pressed("shoot") and is_on_floor():
		current_state = State.Shoot
		shoot_timer = 0.3  

func player_animations():
	match current_state:
		State.Idle:
			animated_sprite_2d.play("Idle")
		State.Run:
			animated_sprite_2d.play("Run")
		State.Jump:
			animated_sprite_2d.play("Jump")
		State.Shoot:
			animated_sprite_2d.play("Shot1")
=======
	
	
func player_shooting(delta: float):
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction != 0 and Input.is_action_pressed("Shot"):
		current_state = State.Shot

func player_animations():
	if current_state == State.Idle:
		animated_sprite_2d.play("Idle")
	elif current_state == State.Run:
		animated_sprite_2d.play("Run")
	elif current_state == State.Jump:
		animated_sprite_2d.play("Jump")
	elif current_state == State.Shot:
		animated_sprite_2d.play("shot")
	
>>>>>>> 530f1b82dbf11fb30956c665d6d65b35706e49be
