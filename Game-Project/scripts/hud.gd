extends CanvasLayer

var count_baus := 0
#@onready var baus = $Label
@onready var baus: Label = $Baus

func collect_baus():
	count_baus += 1
	print("🏷️ collect_baus chamado! count_baus agora é %d" % count_baus)
	baus.text = "Baús: %d/4" % count_baus


func reset():
	count_baus = 0
	baus.text = "Baús: 0/4"
