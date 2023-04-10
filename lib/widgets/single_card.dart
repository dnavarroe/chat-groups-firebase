import 'dart:ui';

import 'package:chat_firebase/utils/responsive.dart';
import 'package:flutter/material.dart';

class SingleCard extends StatelessWidget {

  final Widget child;
  final double h;
  final Color color;
  final bool tras;

  const SingleCard({super.key, required this.child, required this.h, required this.color, required this.tras});

  @override
  Widget build(BuildContext context) {
    
    final responsive = Responsive(context);

    

    final boxDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color
       );

    return Container(
      height: responsive.hp(h),
      margin: const EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: tras ? ImageFilter.blur(sigmaX: 5, sigmaY: 5):ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: Container(
            decoration:  boxDecoration,
            child: child
          ),
        ),
      ),
    );
  }
}