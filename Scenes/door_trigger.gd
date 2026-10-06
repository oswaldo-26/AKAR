extends Area2D

@export var video_path: String = "videos/banaan.mp4"
@export_file("*.tscn") var interior_scene: String = ""

@onready var interact_button = $CanvasLayer/interactBtn
@onready var video_placeholder = $CanvasLayer/ColorRect
@onready var video_label = $CanvasLayer/ColorRect/Label

var player_near := false
var video_playing := false
var _done_cb: JavaScriptObject

func _ready():
	interact_button.visible = false
	video_placeholder.visible = false

	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	interact_button.pressed.connect(_on_interact_pressed)


func _on_body_entered(body):
	if body is CharacterBody2D:
		player_near = true
		interact_button.visible = true


func _on_body_exited(body):
	if body is CharacterBody2D:
		player_near = false
		if not video_playing:
			interact_button.visible = false


func _on_interact_pressed():
	if player_near and not video_playing:
		start_walkthrough()


func start_walkthrough():
	video_playing = true
	interact_button.visible = false

	if OS.has_feature("web"):
		play_web_video(video_path)
	else:
		# Editor / kiosk placeholder until the VideoStreamPlayer is added
		video_placeholder.visible = true
		video_label.text = "WALKTHROUGH VIDEO\n\nPlaying..."
		await get_tree().create_timer(3.0).timeout
		_on_video_finished()


func play_web_video(path: String) -> void:
	_done_cb = JavaScriptBridge.create_callback(_on_web_video_done)
	JavaScriptBridge.get_interface("window").akarDone = _done_cb
	var js := """
	(function(){
	  var v = document.createElement('video');
	  v.src = '%s';
	  v.controls = true;
	  v.autoplay = true;
	  v.playsInline = true;
	  v.style.cssText = 'position:fixed;inset:0;width:100%%;height:100%%;background:#000;z-index:9999';
	  var b = document.createElement('button');
	  b.textContent = 'Skip';
	  b.style.cssText = 'position:fixed;top:12px;right:12px;z-index:10000;padding:10px 18px;font-size:18px';
	  function close(){ v.pause(); v.remove(); b.remove(); window.akarDone(); }
	  v.onended = close;
	  b.onclick = close;
	  document.body.appendChild(v);
	  document.body.appendChild(b);
	})();
	""" % path
	JavaScriptBridge.eval(js)


func _on_web_video_done(_args) -> void:
	_on_video_finished()


func _on_video_finished():
	video_playing = false
	video_placeholder.visible = false

	if interior_scene != "":
		get_tree().change_scene_to_file(interior_scene)
	else:
		# No interior yet: let the player use the door again
		if player_near:
			interact_button.visible = true
