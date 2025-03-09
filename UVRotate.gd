# This node was created by Foyezes
# x.com/Foyezes
# bsky.app/profile/foyezes.bsky.social

@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeUVRotate

func _get_name():
	return "UVRotate"

func _get_category():
	return "UV"

func _get_description():
	return "Rotate UV, from 0 to 360 degrees"

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
			return "Rotation"
		2:
			return "Pivot"
			
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
		1:
			return 0.0;
		2:
			return Vector2(0.0, 0.0);

func _get_global_code(mode):
	return """
	
	vec2 rotateUV(vec2 uv_in, float angle) {
		float angle_rad = radians(angle);
		mat2 rotate = mat2(
			vec2(cos(angle_rad), -sin(angle_rad)),
			vec2(sin(angle_rad), cos(angle_rad))
		);
		return rotate * uv_in;
	}
	
	vec2 RotatedUV(vec2 uv, float rotation_placeholder, vec2 pivot_placeholder) {
		vec2 pivot_internal = clamp(pivot_placeholder, 0.0, 1.0);
		uv -= pivot_internal;
		uv = rotateUV(uv, rotation_placeholder);
		uv += pivot_internal;
		return uv;
	}
	
	"""

func _get_code(input_vars, output_vars, mode, type):
	return output_vars[0] + "=RotatedUV(%s, %s, %s);" % [input_vars[0], input_vars[1], input_vars[2]]
