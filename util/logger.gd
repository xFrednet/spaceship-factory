extends Node

const LOG_MESSAGE_PREFIX = "[%s] %8s: <%-15s>: "
const LOG_TIMESTEMP = "%02d:%02d:%02d"

const LOG_LEVEL_NAMES = ["FATAL", "ERROR", "WARN ", "INFO ", "DEBUG"];
const LOG_LEVEL_MIN   = 0
const LOG_LEVEL_FATAL = 0
const LOG_LEVEL_ERROR = 1
const LOG_LEVEL_WARN  = 2
const LOG_LEVEL_INFO  = 3
const LOG_LEVEL_DEBUG = 4
const LOG_LEVEL_MAX   = 4

const DEFAULT_LOG_LEVEL = LOG_LEVEL_DEBUG

export var _log_level : int = DEFAULT_LOG_LEVEL setget set_log_level, get_log_level

func _init():
	_log_message(
		LOG_LEVEL_INFO, 
		"Init with max logging level: %s" % LOG_LEVEL_NAMES[_log_level], 
		"Logger")

func fatal(message : String, source) -> void:
	_log_message_test_source(LOG_LEVEL_FATAL, message, source);

func error(message : String, source) -> void:
	_log_message_test_source(LOG_LEVEL_ERROR, message, source);

func warn(message : String, source) -> void:
	_log_message_test_source(LOG_LEVEL_WARN, message, source);

func info(message : String, source) -> void:
	_log_message_test_source(LOG_LEVEL_INFO, message, source);

func debug(message : String, source) -> void:
	_log_message_test_source(LOG_LEVEL_DEBUG, message, source);

func _log_message_test_source(level : int, message : String, source) -> void:
	# The log_level
	var log_level = LOG_LEVEL_MAX
	if (source.has_method("get_logger_level")):
		log_level = source.get_logger_level()
	log_level = min(log_level, _log_level)
	
	# testing the level
	if (level > log_level):
		return
	
	# Source name
	var source_name = null
	if (source is String):
		source_name = source
	elif (source.has_method("get_logger_name")):
		source_name = source.get_logger_name()
	else:
		source_name = "null"
	
	# writing the message
	_log_message(level, message, source_name)

func _log_message(level : int, message : String, source_name : String) -> void:
	var message_head = _get_message_head(level, source_name)
	if (level <= LOG_LEVEL_ERROR):
		printerr(message_head, message)
	else:
		print(message_head, message)

func _get_message_head(level : int, source_name : String) -> String:
	var timestamp = _get_timestamp()
	return LOG_MESSAGE_PREFIX % [get_log_level_name(level), timestamp, source_name]

func _get_timestamp() -> String:
	var time = OS.get_time()
	return LOG_TIMESTEMP % [time["hour"], time["minute"], time["second"]]
	
###################
# log level
###################
func get_log_level() -> int:
	return _log_level
	
func set_log_level(log_level : int) -> void:
	_log_level = log_level

func get_log_level_name(log_level : int) -> String:
	return LOG_LEVEL_NAMES[log_level]
