extends Node2D
@onready var user_deck_pos: Marker2D = $UserDeckPos

const CARDS = preload("uid://bsk2x8xhstr2q")
var user_card = PackedScene

var user_hand: Array[Node] = []

var user_score = []
var user_total_score = 0
func _ready() -> void:
	user_hand = spawn_user_init_cards(user_deck_pos.global_position)
	for num in user_score:
		user_total_score += num
	print(user_total_score)
		
func _process(delta: float) -> void:
	pass
	


func spawn_user_init_cards(spawn_point: Vector2) -> Array[Node]:
	var spawn_position = spawn_point
	var user_hand: Array[Node] = []
	
	for card in range(2):
		user_card = CARDS.instantiate()
		user_card.global_position = spawn_position + Vector2(card * 64, 0)
		
		add_child(user_card)
		user_score.append(user_card.card_score)
		user_hand.append(user_card)
		
	print(user_score)
	return user_hand
	
