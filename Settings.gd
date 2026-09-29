extends Node

const SAVE_PATH := "user://settings.cfg"
const DYSLEXIC_FONT: Font = preload("res://resources/fonts/OpenDyslexic-Regular.otf")

var music_volume := 0.8
var sfx_volume := 0.8
var muted := false
var dyslexic_mode := false
var text_size_index := 1  # 0 small, 1 medium, 2 large
var fullscreen := false

const TEXT_SIZES := [14, 16, 20]
var _original_font: Font

func _ready() -> void:
	var theme := ThemeDB.get_project_theme()
	if theme:
		_original_font = theme.default_font
	load_settings()
	apply_all()

func apply_all() -> void:
	_set_bus("Music", music_volume, muted)
	_set_bus("SFX", sfx_volume, muted)
	var theme := ThemeDB.get_project_theme()
	if theme:
		theme.default_font = DYSLEXIC_FONT if dyslexic_mode else _original_font
		theme.default_font_size = TEXT_SIZES[text_size_index]
	DisplayServer.window_set_mode(
		DisplayServer.WINDOW_MODE_FULLSCREEN if fullscreen else DisplayServer.WINDOW_MODE_WINDOWED)

func _set_bus(bus_name: String, linear: float, mute: bool) -> void:
	var idx := AudioServer.get_bus_index(bus_name)
	if idx == -1: return
	AudioServer.set_bus_volume_db(idx, linear_to_db(maxf(linear, 0.0001)))
	AudioServer.set_bus_mute(idx, mute)

func save_settings() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("audio", "music", music_volume)
	cfg.set_value("audio", "sfx", sfx_volume)
	cfg.set_value("audio", "muted", muted)
	cfg.set_value("access", "dyslexic", dyslexic_mode)
	cfg.set_value("access", "text_size", text_size_index)
	cfg.set_value("display", "fullscreen", fullscreen)
	cfg.save(SAVE_PATH)

func load_settings() -> void:
	var cfg := ConfigFile.new()
	if cfg.load(SAVE_PATH) != OK: return
	music_volume = cfg.get_value("audio", "music", 0.8)
	sfx_volume = cfg.get_value("audio", "sfx", 0.8)
	muted = cfg.get_value("audio", "muted", false)
	dyslexic_mode = cfg.get_value("access", "dyslexic", false)
	text_size_index = cfg.get_value("access", "text_size", 1)
	fullscreen = cfg.get_value("display", "fullscreen", false)
