import 'dart:convert';
import 'dart:ui';

List<T>? toObjList<T>(
  dynamic data,
  T Function(Map<String, dynamic>) fromJson, {
  VoidCallback? voidCallback,
}) {
  if (null == data) {
    return [];
  }
  var list = data as List<dynamic>;
  if (list.isEmpty) {
    return [];
  }
  var resultList =
      list.map((json) => fromJson(json as Map<String, dynamic>)).toList();
  voidCallback?.call();
  return resultList;
}

List<T> parseJsonList<T>(
    String jsonString, T Function(Map<String, dynamic>) fromJson) {
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList
      .map((json) => fromJson(json as Map<String, dynamic>))
      .toList();
}

List<T>? pageResToObjList<T>(
  dynamic data,
  T Function(Map<String, dynamic>) fromJson,
) {
  if (null == data) {
    return [];
  }
  var list = data['list'];
  if (null == list) {
    return [];
  }
  return toObjList(list, fromJson);
}
