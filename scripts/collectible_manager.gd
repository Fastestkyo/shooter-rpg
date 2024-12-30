extends Node

static var total_award_amt : int

signal on_collectible_award_received

func award_on_pick(collectible_award:int):
	total_award_amt += collectible_award
	
	on_collectible_award_received.emit(total_award_amt)
