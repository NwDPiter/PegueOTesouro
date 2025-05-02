extends CharacterBody2D

@export var speed := 100
@onready var sprite = $Sprite2D
@onready var ray_chao: RayCast2D = $RayChao

@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer

var direction := -1  # começa andando para a esquerda

func _physics_process(delta):
	# Verifica se há chão à frente com o RayCast2D
	if not ray_chao.is_colliding():
		direction *= -1  # inverte a direção
		sprite.flip_h = direction > 0  # vira o sprite
		ray_chao.position.x *= -1  # move o raycast junto

	# Move o personagem
	velocity.x = direction * speed
	move_and_slide()

	# Animação de movimento
	if animation_player.current_animation != "run":
		animation_player.play("run")
