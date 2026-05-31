extends Node2D
class_name Cards
@onready var cards_back: Sprite2D = $CardsBackSprite2D
@onready var cards_clubs: Sprite2D = $CardsClubsFrontSprite2D
var card_number: int = 1
var card_score: int = 0


func _ready() -> void:
	random_card()
	calc_card_score()
	cards_clubs.frame = card_number
	
	
func random_card() -> void:
	card_number = randi_range(0, 12)

func calc_card_score() -> void:
	if card_number == 9:
		card_score = 10
	elif card_number == 10:
		card_score = 10
	elif card_number == 11:
		card_score = 10
	elif card_number == 12:
		card_score = 10
	else:
		card_score = (card_number + 1)  
		
	

func card_hidden() -> void:
	cards_clubs.visible = false
	cards_back.visible = true
	
func card_unhidden() -> void:
	cards_back.visible = false
	cards_clubs.visible = true

func _on_hide_cards_pressed() -> void:
	card_hidden()


func _on_un_hide_cards_pressed() -> void:
	card_unhidden()
