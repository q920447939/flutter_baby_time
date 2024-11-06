import 'package:json_annotation/json_annotation.dart';

part 'app_navigator_config_model.g.dart';

@JsonSerializable()
class NavigationConfigVo {
  NavigationConfigVo({
    required this.navigatorName,
    required this.svgConfigVo,
    required this.displayIndex,
    required this.targetUri,
    required this.uriParams,
  });

  final String? navigatorName;

  @JsonKey(name: 'svgConfigVO')
  final SvgConfigVo? svgConfigVo;
  final int? displayIndex;
  final String? targetUri;
  final String? uriParams;

  factory NavigationConfigVo.fromJson(Map<String, dynamic> json) =>
      _$NavigationConfigVoFromJson(json);

  Map<String, dynamic> toJson() => _$NavigationConfigVoToJson(this);
}

@JsonSerializable()
class SvgConfigVo {
  SvgConfigVo({
    required this.svgName,
    required this.svgUrl,
  });

  final String? svgName;
  final String? svgUrl;

  factory SvgConfigVo.fromJson(Map<String, dynamic> json) =>
      _$SvgConfigVoFromJson(json);

  Map<String, dynamic> toJson() => _$SvgConfigVoToJson(this);
}
