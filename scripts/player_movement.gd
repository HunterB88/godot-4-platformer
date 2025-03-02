extends CharacterBody2D


@export var speed = 300
@export var gravity = 30
@export var jump_force = 300

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D


func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = -jump_force
	
	var horizontal_direction = Input.get_axis("left", "right")
	
	if horizontal_direction != 0:
		sprite.flip_h = (horizontal_direction == -1)
	
	velocity.x = speed * horizontal_direction
	
	move_and_slide()
	
	print(velocity)
	
	update_animation(horizontal_direction)
	
func update_animation(horizontal_direction):
	if is_on_floor():
		if horizontal_direction == 0:
			ap.play("idle")
		else:
			ap.play("run")
	else:
		if velocity.y < 0:
			ap.play("fall")
		elif velocity.y > 0:
			ap.play("jump")
	
