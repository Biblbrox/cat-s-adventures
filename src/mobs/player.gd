extends CharacterBody2D

signal hit

@export var speed = 400
var screen_size

var run_speed = 350
var jump_speed = -700
var gravity = 2500


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()


func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('ui_select')

	if is_on_floor() and jump:
		velocity.y = jump_speed
	if right:
		velocity.x += run_speed
	if left:
		velocity.x -= run_speed

func _physics_process(delta):
	velocity.y += gravity * delta
	get_input()
	move_and_slide()
	
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x > 0
		if velocity.y == 0:
			$AnimatedSprite2D.animation = "walk"
		else:
			$AnimatedSprite2D.stop()
		$AnimatedSprite2D.play()
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		

func start(pos):
	position = pos
	show()
	#$CollisionShape2D.disabled = false


func _on_body_entered(body: Node2D) -> void:
	pass
	#hide()
	#hit.emit()
	#$CollisionShape2D.set_deferred("disabled", true)
