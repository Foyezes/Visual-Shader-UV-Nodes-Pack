# This node was created by Foyezes
# x.com/Foyezes
# bsky.app/profile/foyezes.bsky.social

@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVTwirl

func _get_name():
	return "UVTwirl"

func _get_category():
	return "UV"

func _get_description():
	return "Twirl UV"

func _get_output_port_count():
	return 1
	
func _get_input_port_count():
	return 4

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
			return "Center"
		2:
			return "Strength"
		3:
			return "Offset"
			
func _get_input_port_type(port):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_2D
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR_2D
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_VECTOR_2D
			
func _get_input_port_default_value(port):
	match port:
		1:
			return Vector2(0.0, 0.0);
		2:
			return 0.0;
		3:
			return Vector2(0.0, 0.0);

func _get_global_code(mode):
	return """
	
	vec2 UVTwirl(vec2 uv, vec2 center_placeholder, float strength_placeholder, vec2 offset_placeholder){
		
	vec2 delta = uv - center_placeholder;
	float angle = strength_placeholder * length(delta);
	float x = cos(angle) * delta.x - sin(angle) * delta.y;
	float y = sin(angle) * delta.x + cos(angle) * delta.y;
	return vec2(x + center_placeholder.x + offset_placeholder.x, y + center_placeholder.y + offset_placeholder.y);
	}
	
	"""

func _get_code(input_vars, output_vars, mode, type):
	return output_vars[0] + "=UVTwirl(%s, %s, %s, %s);" % [input_vars[0], input_vars[1], input_vars[2], input_vars[3]]
