extends Node2D

@onready var area = $Area2D

func _ready():
	area.body_entered.connect(_on_body_entered)

func _on_body_entered(body):  # Corrigido de 'Body' para 'body'
	if body.name == "Player":
		var hud = get_tree().current_scene.get_node("Hud")
		if hud:
			if hud.count_baus >= 4:
				print("🏁 Fase concluída!")
				# Ex: get_tree().change_scene_to_file("res://proxima_fase.tscn")
			else:
				print("🚫 Você precisa coletar 4 baús antes!")
