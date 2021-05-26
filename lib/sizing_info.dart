import 'package:flutter/material.dart';
import 'package:flutter_responsive_tools/device_screen_type.dart';

class SizingInfo {
  final DeviceScreenType type;
  final Size screenSize;
  final Size widgetSize;

  SizingInfo({required this.type, required this.screenSize, required this.widgetSize});

  @override
  String toString() {
    return "type: $type, screenSize = $screenSize, widgetSize = $widgetSize";
  }
}
