import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget paddingAll(double value) {
    return Padding(padding: EdgeInsets.all(value), child: this);
  }

  Widget paddingSymmetric({double h = 0, double v = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: h, vertical: v),
      child: this,
    );
  }

  Widget paddingOnly({
    double l = 0,
    double t = 0,
    double r = 0,
    double b = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: l, top: t, right: r, bottom: b),
      child: this,
    );
  }

  SliverToBoxAdapter get sliverBox => SliverToBoxAdapter(child: this);
}
