extends CanvasLayer


func _process(delta):
	var score = calc_score()
	$Score.text = "Score: " + str(score)
	
func calc_score():
	var cam = get_parent().get_node("Schaf")
	return int(cam.position.x / 10)

# Send a highscore to the server.
# Returns the position on the scoreboard (1-based).
func send_highscore(game: String, player: String, score: int):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	
	var url = ("https://scores.tmbe.me/score?game=" + game.percent_encode() +
		"&player=" + player.percent_encode() +
		"&score=" + str(score).percent_encode())
	
	if http_request.request(url, [], true, HTTPClient.METHOD_POST) != OK:
		print("Sending highscore failed")
		return -1
	var response = yield(http_request, "request_completed")
	if response[1] != 200:
		print("Sending highscore returned " + str(response[1]))
		return -1
	remove_child(http_request)
	
	var position = JSON.parse(response[3].get_string_from_utf8()).result["position"]
	print("Highscore submitted! - You scored position " + str(position))
	return position

func _ready():
	send_highscore('foo', 'tom', 0)
