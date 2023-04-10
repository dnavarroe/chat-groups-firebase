import 'dart:math';

import 'package:flutter/material.dart';

class Responsive {
  late double _width, _height, _diagonal;
  late bool _isTable;

  double get width => _width;
  double get height => _height;
  double get diagonal => _diagonal;
  bool get isTable => _isTable;

  static Responsive of(BuildContext context) => Responsive(context);

  Responsive(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    _width=size.width;
    _height=size.height;
    _diagonal=sqrt(pow(_width,2) + pow(_height,2));

    _isTable = size.shortestSide>=600;

  }

  double wp(double percent) => _width*percent/100;
  double hp(double percent) => _height*percent/100;
  double dp(double percent) => _diagonal*percent/100;

}