import 'package:flutter/material.dart';
import 'package:untitled/help/constants/constant.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileWidget;
  final Widget tabletWidget;
  final Widget websiteWidget;

  ResponsiveLayout(
      {@required this.mobileWidget,
        this.tabletWidget,
        this.websiteWidget
      });
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth >= kWebWidth) {
        //?? if not widget for web using ??
        return websiteWidget ?? mobileWidget;
      } else if (constraints.maxWidth >= kTabWidth) {
        return tabletWidget ?? mobileWidget;
      } else {
        return mobileWidget;
      }
    });
  }
}
