/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImgGen {
  const $AssetsImgGen();

  /// File path: assets/img/baby_avator.jpeg
  AssetGenImage get babyAvator =>
      const AssetGenImage('assets/img/baby_avator.jpeg');

  /// File path: assets/img/baby_photo.jpg
  AssetGenImage get babyPhoto =>
      const AssetGenImage('assets/img/baby_photo.jpg');

  /// File path: assets/img/empty.png
  AssetGenImage get empty => const AssetGenImage('assets/img/empty.png');

  /// File path: assets/img/illustration.png
  AssetGenImage get illustration =>
      const AssetGenImage('assets/img/illustration.png');

  /// File path: assets/img/image.png
  AssetGenImage get image => const AssetGenImage('assets/img/image.png');

  /// File path: assets/img/td_avatar_1.png
  AssetGenImage get tdAvatar1 =>
      const AssetGenImage('assets/img/td_avatar_1.png');

  /// File path: assets/img/td_avatar_2.png
  AssetGenImage get tdAvatar2 =>
      const AssetGenImage('assets/img/td_avatar_2.png');

  /// File path: assets/img/td_brand.png
  AssetGenImage get tdBrand => const AssetGenImage('assets/img/td_brand.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        babyAvator,
        babyPhoto,
        empty,
        illustration,
        image,
        tdAvatar1,
        tdAvatar2,
        tdBrand
      ];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/add.svg
  String get add => 'assets/svg/add.svg';

  /// File path: assets/svg/like.svg
  String get like => 'assets/svg/like.svg';

  /// List of all assets
  List<String> get values => [add, like];
}

class Assets {
  Assets._();

  static const String aEnv = '.env';
  static const $AssetsImgGen img = $AssetsImgGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
  static const String theme = 'assets/theme.json';

  /// List of all assets
  static List<String> get values => [aEnv, theme];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
