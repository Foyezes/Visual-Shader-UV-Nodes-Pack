# This node was created by Foyezes
# x.com/Foyezes
# bsky.app/profile/foyezes.bsky.social

@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVPanner

func _get_name():
	return "UVPanner"

func _get_category():
	return "UV"

func _get_description():
	return "Offset UV with time"

func _get_output_port_count():
	return 1
	
func _get_input_port_count():
	return 3

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR_2D

func _get_output_port_name(port):
	match port:
		0:
			return "uv"
			
func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR_2D

func _get_input_port_name(port):
	match port:
		0:
			return "UV"
		1:
			return "Time"
		2:
			return "Speed"
			
func _get_input_port_type(port):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_2D
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR_2D
			
func _get_input_port_default_value(port):
	match port:
		2:
			return Vector2(0.0, 0.0);

func _get_global_code(mode):
	return """
	
	vec2 UVPanner(vec2 uv_in, float time_placeholder, vec2 speed_placeholder) {
		return uv_in + (time_placeholder * speed_placeholder);
	}
	
	"""

func _get_code(input_vars, output_vars, mode, type):
	return output_vars[0] + "=UVPanner(%s, %s, %s);" % [input_vars[0], input_vars[1], input_vars[2]]
