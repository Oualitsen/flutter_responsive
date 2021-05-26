import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_responsive_tools/device_screen_type.dart';
import 'package:flutter_responsive_tools/sizing_info.dart';

DeviceScreenType getDeviceScreenType(MediaQueryData data) {
  var width = data.size.shortestSide;
  if (kIsWeb) {
    width = data.size.width;
  }
  if (width > 950) {
    return DeviceScreenType.desktop;
  }
  if (width > 600) {
    return DeviceScreenType.tablet;
  }
  return DeviceScreenType.mobile;
}

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, SizingInfo info) builder;

  ResponsiveBuilder(this.builder);

  @override
  Widget build(BuildContext context) {
    MediaQueryData query = MediaQuery.of(context);

    return LayoutBuilder(
      builder: (context, BoxConstraints constraints) {
        SizingInfo info = SizingInfo(
            type: getDeviceScreenType(query),
            screenSize: query.size,
            widgetSize: Size(constraints.maxWidth, constraints.maxHeight));

        return builder(context, info);
      },
    );
  }
}
