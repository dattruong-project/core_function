import 'package:flutter/foundation.dart';

class PlatformDetails {
  PlatformDetails._();

  static final PlatformDetails _instance = PlatformDetails._();

  static PlatformDetails get instance => _instance;

  bool get isDesktop =>
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.windows;

  bool get isMobile =>
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android;
}
