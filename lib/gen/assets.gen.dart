// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class Assets {
  const Assets._();

  static const AssetGenImage appLogo = AssetGenImage('assets/app_logo.png');
  static const AssetGenImage arrorLeft = AssetGenImage('assets/arror_left.png');
  static const AssetGenImage arrowDownIc = AssetGenImage(
    'assets/arrow_down_ic.png',
  );
  static const AssetGenImage arrowRight = AssetGenImage(
    'assets/arrow_right.png',
  );
  static const AssetGenImage arrowRight2Ic = AssetGenImage(
    'assets/arrow_right_2_ic.png',
  );
  static const AssetGenImage arrowRightIc = AssetGenImage(
    'assets/arrow_right_ic.png',
  );
  static const AssetGenImage bellIc = AssetGenImage('assets/bell_ic.png');
  static const AssetGenImage bgImg = AssetGenImage('assets/bg_img.jpg');
  static const AssetGenImage bidIc = AssetGenImage('assets/bid_ic.png');
  static const AssetGenImage bookingIc = AssetGenImage('assets/booking_ic.png');
  static const AssetGenImage bookmarkIc = AssetGenImage(
    'assets/bookmark_ic.png',
  );
  static const AssetGenImage checkIc = AssetGenImage('assets/check_ic.png');
  static const AssetGenImage commentIc = AssetGenImage('assets/comment_ic.png');
  static const AssetGenImage dimondIc = AssetGenImage('assets/dimond_ic.png');
  static const AssetGenImage drinksIc = AssetGenImage('assets/drinks_ic.png');
  static const AssetGenImage followerIc = AssetGenImage(
    'assets/follower_ic.png',
  );
  static const AssetGenImage homeIc = AssetGenImage('assets/home_ic.png');
  static const AssetGenImage homePlayIc = AssetGenImage(
    'assets/home_play_ic.png',
  );
  static const AssetGenImage likeIc = AssetGenImage('assets/like_ic.png');
  static const AssetGenImage locationIc = AssetGenImage(
    'assets/location_ic.png',
  );
  static const AssetGenImage moreIc = AssetGenImage('assets/more_ic.png');
  static const AssetGenImage offersIc = AssetGenImage('assets/offers_ic.png');
  static const AssetGenImage playIc = AssetGenImage('assets/play_ic.png');
  static const AssetGenImage searchIc = AssetGenImage('assets/search_ic.png');
  static const AssetGenImage starIc = AssetGenImage('assets/star_ic.png');
  static const AssetGenImage volumeIc = AssetGenImage('assets/volume_ic.png');

  /// List of all assets
  static List<AssetGenImage> get values => [
    appLogo,
    arrorLeft,
    arrowDownIc,
    arrowRight,
    arrowRight2Ic,
    arrowRightIc,
    bellIc,
    bgImg,
    bidIc,
    bookingIc,
    bookmarkIc,
    checkIc,
    commentIc,
    dimondIc,
    drinksIc,
    followerIc,
    homeIc,
    homePlayIc,
    likeIc,
    locationIc,
    moreIc,
    offersIc,
    playIc,
    searchIc,
    starIc,
    volumeIc,
  ];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

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
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return  Image.asset(
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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
