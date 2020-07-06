extends KinematicBody2D

const UP = Vector2(0, -1)					##kosntansok, állandó értékűek a futás alatt
const GRAVITY = 20							##például a gravitáció értéke
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -550

var motion = Vector2()

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right"):				##ha jobbra nyomod
		motion.x += ACCELERATION						## régi- változott-a motion, mozgás SPEED értékkel változik- SPEED rögzítve a konstansban
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false					##get_node("Sprite").flip_h = false ugyan ezt csinálja-ha simán jobbra fut nem fordul a spritja
		$Sprite.play("Run")						##ha simán jobbra fut, fut a play animation
	elif Input.is_action_pressed("ui_left"):   
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true					##ha simán balra fut arra fordul a képe a karakternek
		$Sprite.play("Run")						##és le is fut az animáció
	else:										##különben, ha nem fut, és nem ugrál, akkor
		$Sprite.play("Idle")					##Idle animáció indul el
		friction = true
		
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
			if motion.y < 0:
				$Sprite.play("Jump")
			else:
				$Sprite.play("Fall")
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.05)
			
	
			
		
		
	motion = move_and_slide(motion, UP)
	pass
	
	
	
	
	
	