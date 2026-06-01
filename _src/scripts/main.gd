extends Node2D
@onready var user_deck_pos: Marker2D = $UserDeckPos
@onready var dealer_deck_pos: Marker2D = $DealerDeckPos

@onready var user_score_label: Label = $UI/MarginContainer/VBoxContainer/UserScoreLabel
@onready var dealer_score_label: Label = $UI/MarginContainer/VBoxContainer/DealerScoreLabel

@export var card_offset := Vector2(95, 0)

var user_hits = false

const CARDS = preload("uid://bsk2x8xhstr2q")
var user_card = PackedScene

var user_hand: Array[Node] = []
var dealer_hand: Array[Node] = []

var user_score = []
var user_total_score = 0
var dealer_total_score = 0


func _ready() -> void:
	# Asign two cards to the user and dealer 
	user_hand = deal_cards(user_deck_pos.global_position)
	dealer_hand = deal_cards(dealer_deck_pos.global_position, 2, true)
	update_score()


	
func _process(delta: float) -> void:
	pass
	
func update_score() -> void:
	# Calcutes the total score for both user and dealer
	user_total_score = calaculate_hand_score(user_hand)
	dealer_total_score = calaculate_hand_score(dealer_hand)
	
	# Displays user and dealer score through thier labels
	user_score_label.text = str(user_total_score)
	dealer_score_label.text = str(dealer_total_score)


## Instantiates a specific number of cards at the starting position. 
## Handles offsetting and optionally hiding first card
func deal_cards(start_pos: Vector2, count: int = 2, hide_first:bool = false) -> Array[Node]:
	var hand: Array[Node] = []
	for i in range(count):
		var card = CARDS.instantiate()
		card.global_position = start_pos + (card_offset * i)
		add_child(card)
		if hide_first and i == 0:
			card.card_hidden()	
		hand.append(card)
	return hand
	
func compare_cards(user_score: int, dealer_score: int) -> String:
	if user_score == dealer_score:
		return "Draw"
	elif dealer_score == 0:
		return "Dealer Wins"
	elif user_score > 21:
		return "Dealer Wins"
	elif dealer_score > 21:
		return "You Win"
	elif user_score > dealer_score:
		return "You Win"
	else:
		return "Dealer Wins"
		
	
func draw_card(hand: Array[Node], start_pos: Vector2, hide_card: bool = false) -> void:
	var card = CARDS.instantiate()
	var current_card_count = hand.size()
	card.global_position = start_pos + (card_offset * current_card_count)
	add_child(card)
	hand.append(card)
	
## Reads the score of all cards in a given hand array
func calaculate_hand_score(hand: Array[Node]) -> int:
	var score = 0
	var ace_count: int = 0 
	for card in hand:
		if card.is_hidden:
			continue
		score += card.card_score
		if card.is_ace:
			ace_count += 1
		
			
	for i in range(ace_count):
		if score + 10 <= 21:
			score += 10
	return score


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_hit_button_pressed() -> void:
	user_hits = true
	draw_card(user_hand, user_deck_pos.global_position)
	update_score()


func _on_hold_button_pressed() -> void:
	dealer_hand[0].card_unhidden()
	update_score()
	print(compare_cards(user_total_score, dealer_total_score))
