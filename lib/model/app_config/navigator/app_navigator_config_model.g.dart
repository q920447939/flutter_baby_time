// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_navigator_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavigationConfigVo _$NavigationConfigVoFromJson(Map<String, dynamic> json) =>
    NavigationConfigVo(
      navigatorName: json['navigatorName'] as String?,
      svgConfigVo: json['svgConfigVO'] == null
          ? null
          : SvgConfigVo.fromJson(json['svgConfigVO'] as Map<String, dynamic>),
      displayIndex: (json['displayIndex'] as num?)?.toInt(),
      targetUri: json['targetUri'] as String?,
      uriParams: json['uriParams'] as String?,
    );

Map<String, dynamic> _$NavigationConfigVoToJson(NavigationConfigVo instance) =>
    <String, dynamic>{
      'navigatorName': instance.navigatorName,
      'svgConfigVO': instance.svgConfigVo,
      'displayIndex': instance.displayIndex,
      'targetUri': instance.targetUri,
      'uriParams': instance.uriParams,
    };

SvgConfigVo _$SvgConfigVoFromJson(Map<String, dynamic> json) => SvgConfigVo(
      svgName: json['svgName'] as String?,
      svgUrl: json['svgUrl'] as String?,
    );

Map<String, dynamic> _$SvgConfigVoToJson(SvgConfigVo instance) =>
    <String, dynamic>{
      'svgName': instance.svgName,
      'svgUrl': instance.svgUrl,
    };
