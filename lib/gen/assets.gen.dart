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
  static const AssetGenImage arrowDownIcPng = AssetGenImage(
    'assets/arrow_down_ic.png',
  );
  static const String arrowDownIcSvg = 'assets/arrow_down_ic.svg';
  static const AssetGenImage arrowRight = AssetGenImage(
    'assets/arrow_right.png',
  );
  static const AssetGenImage arrowRight2IcPng = AssetGenImage(
    'assets/arrow_right_2_ic.png',
  );
  static const String arrowRight2IcSvg = 'assets/arrow_right_2_ic.svg';
  static const AssetGenImage arrowRightIcPng = AssetGenImage(
    'assets/arrow_right_ic.png',
  );
  static const String arrowRightIcSvg = 'assets/arrow_right_ic.svg';
  static const AssetGenImage bellIcPng = AssetGenImage('assets/bell_ic.png');
  static const String bellIcSvg = 'assets/bell_ic.svg';
  static const AssetGenImage bgImgJpg = AssetGenImage('assets/bg_img.jpg');
  static const AssetGenImage bgImgPng = AssetGenImage('assets/bg_img.png');
  static const AssetGenImage bidIcPng = AssetGenImage('assets/bid_ic.png');
  static const String bidIcSvg = 'assets/bid_ic.svg';
  static const AssetGenImage bookingIcPng = AssetGenImage(
    'assets/booking_ic.png',
  );
  static const String bookingIcSvg = 'assets/booking_ic.svg';
  static const AssetGenImage bookmarkIcPng = AssetGenImage(
    'assets/bookmark_ic.png',
  );
  static const String bookmarkIcSvg = 'assets/bookmark_ic.svg';
  static const AssetGenImage checkIcPng = AssetGenImage('assets/check_ic.png');
  static const String checkIcSvg = 'assets/check_ic.svg';
  static const AssetGenImage commentIcPng = AssetGenImage(
    'assets/comment_ic.png',
  );
  static const String commentIcSvg = 'assets/comment_ic.svg';
  static const AssetGenImage dimondIcPng = AssetGenImage(
    'assets/dimond_ic.png',
  );
  static const String dimondIcSvg = 'assets/dimond_ic.svg';
  static const AssetGenImage drinksIc = AssetGenImage('assets/drinks_ic.png');
  static const AssetGenImage followerIcPng = AssetGenImage(
    'assets/follower_ic.png',
  );
  static const String followerIcSvg = 'assets/follower_ic.svg';
  static const AssetGenImage homeIcPng = AssetGenImage('assets/home_ic.png');
  static const String homeIcSvg = 'assets/home_ic.svg';
  static const AssetGenImage homePlayIc = AssetGenImage(
    'assets/home_play_ic.png',
  );
  static const AssetGenImage likeIcPng = AssetGenImage('assets/like_ic.png');
  static const String likeIcSvg = 'assets/like_ic.svg';
  static const AssetGenImage locationIcPng = AssetGenImage(
    'assets/location_ic.png',
  );
  static const String locationIcSvg = 'assets/location_ic.svg';
  static const AssetGenImage moreIcPng = AssetGenImage('assets/more_ic.png');
  static const String moreIcSvg = 'assets/more_ic.svg';
  static const AssetGenImage offersIc = AssetGenImage('assets/offers_ic.png');
  static const AssetGenImage playIc = AssetGenImage('assets/play_ic.png');
  static const AssetGenImage searchIcPng = AssetGenImage(
    'assets/search_ic.png',
  );
  static const String searchIcSvg = 'assets/search_ic.svg';
  static const AssetGenImage starIcPng = AssetGenImage('assets/star_ic.png');
  static const String starIcSvg = 'assets/star_ic.svg';
  static const AssetGenImage volumeIc = AssetGenImage('assets/volume_ic.png');

  /// List of all assets
  static List<dynamic> get values => [
    appLogo,
    arrorLeft,
    arrowDownIcPng,
    arrowDownIcSvg,
    arrowRight,
    arrowRight2IcPng,
    arrowRight2IcSvg,
    arrowRightIcPng,
    arrowRightIcSvg,
    bellIcPng,
    bellIcSvg,
    bgImgJpg,
    bgImgPng,
    bidIcPng,
    bidIcSvg,
    bookingIcPng,
    bookingIcSvg,
    bookmarkIcPng,
    bookmarkIcSvg,
    checkIcPng,
    checkIcSvg,
    commentIcPng,
    commentIcSvg,
    dimondIcPng,
    dimondIcSvg,
    drinksIc,
    followerIcPng,
    followerIcSvg,
    homeIcPng,
    homeIcSvg,
    homePlayIc,
    likeIcPng,
    likeIcSvg,
    locationIcPng,
    locationIcSvg,
    moreIcPng,
    moreIcSvg,
    offersIc,
    playIc,
    searchIcPng,
    searchIcSvg,
    starIcPng,
    starIcSvg,
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
