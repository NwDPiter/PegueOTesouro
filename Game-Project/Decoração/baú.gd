extends Node2D

@onready var area = $Area2D
@onready var animation_player = $Sprite2D/AnimationPlayer

var aberto = false


func _ready():
	area.body_entered.connect(_on_body_entered)
	animation_player.animation_finished.connect(_on_animation_finished)

# Quando o jogador entra na área do baú
func _on_body_entered(body):
	if body.name == "Player" and not aberto:
		aberto = true
		animation_player.play("abrir")  # Nome da animação de abrir o baú
		var hud = get_tree().current_scene.get_node("Hud")
		if hud:
			hud.collect_baus()


# Quando a animação de abrir termina
func _on_animation_finished(anim_name):
	if anim_name == "abrir":
		hide()
		# Ou você pode usar: self.visible = false

# Método de reset do baú
func resetar():	
	aberto = false
	show()  # Torna o baú visível novamente
	animation_player.play("idle")  # Ou "fechado" - depende de como você animou o baú
	
