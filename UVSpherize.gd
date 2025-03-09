# This node was created by Foyezes
# x.com/Foyezes
# bsky.app/profile/foyezes.bsky.social

@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVSpherize

func _get_name():
	return "UVSpherize"

func _get_category():
	return "UV"

func _get_description():
	return "Applies a spherical warping effect to UV"

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
	
	vec2 UVSpherize(vec2 uv_in, vec2 center_placeholder, float strength_placeholder, vec2 offset_placeholder){
		
	vec2 delta = uv_in - center_placeholder;
	float delta2 = dot(delta.xy, delta.xy);
	float delta4 = delta2 * delta2;
	vec2 delta_offset = vec2(delta4 * strength_placeholder);
	return vec2(uv_in + delta * delta_offset + offset_placeholder);
	}
	
	"""

func _get_code(input_vars, output_vars, mode, type):
	return output_vars[0] + "=UVSpherize(%s, %s, %s, %s);" % [input_vars[0], input_vars[1], input_vars[2], input_vars[3]]
