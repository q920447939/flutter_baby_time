import 'dart:convert';

String objToJsonStr(dynamic object) {
  return jsonEncode(object.toJson());
}

T jsonStrToObj<T>(String jsonStr, T Function(Map<String, dynamic>) fromJson) {
  return fromJson(jsonDecode(jsonStr) as Map<String, dynamic>);
}
