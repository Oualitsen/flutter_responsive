import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive_tools/device_screen_type.dart';
import 'package:flutter_responsive_tools/responsive_builder.dart';
import 'package:flutter_responsive_tools/sizing_info.dart';

const double WIDTH_DESKTOP = 800;
const double WIDTH_TABLET = 600;

class ScreenTypeLayout extends StatelessWidget {
  final Widget Function(BuildContext context) mobileBuilder;
  final Widget Function(BuildContext context)? tabletBuilder;
  final Widget Function(BuildContext context)? desktopBuilder;

  ScreenTypeLayout({Key? key, required this.mobileBuilder, this.tabletBuilder, this.desktopBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder((BuildContext context, SizingInfo info) {
      switch (info.type) {
        case DeviceScreenType.desktop:
          return (desktopBuilder ?? tabletBuilder ?? mobileBuilder)(context);
        case DeviceScreenType.tablet:
          return (tabletBuilder ?? mobileBuilder)(context);
        default:
          return mobileBuilder(context);
      }
    });
  }
}

class DeviceTypeLayout extends StatelessWidget {
  final Widget Function() mobile;
  final Widget Function() web;

  const DeviceTypeLayout({
    Key? key,
    required this.mobile,
    required this.web,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? web() : mobile();
  }
}

class AutoScreenTypeLayout extends StatelessWidget {
  final Widget child;
  final bool useCenter;
  final double? tabletWidth;
  final double? desktopWidth;
  AutoScreenTypeLayout({
    required this.child,
    this.useCenter = true,
    this.tabletWidth,
    this.desktopWidth,
  });

  @override
  Widget build(BuildContext context) => ScreenTypeLayout(
        mobileBuilder: (context) => child,
        tabletBuilder: (context) {
          return useCenter
              ? Center(
                  child: Container(
                    width: tabletWidth ?? WIDTH_TABLET,
                    child: child,
                  ),
                )
              : Container(
                  width: tabletWidth ?? WIDTH_TABLET,
                  child: child,
                );
        },
        desktopBuilder: (context) {
          return useCenter
              ? Center(
                  child: Container(
                    width: desktopWidth ?? WIDTH_DESKTOP,
                    child: child,
                  ),
                )
              : Container(
                  width: desktopWidth ?? WIDTH_DESKTOP,
                  child: child,
                );
        },
      );
}
