import 'package:chat_firebase/utils/responsive.dart';
import 'package:flutter/material.dart';

class FormasL extends StatelessWidget {
  const FormasL({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _Forma(
          clipper: _MyClipperTop1(),
          height: 100,
          colors: const [Color(0xff222643),Color(0xff051960)],
        ),
        _Forma(
          clipper: _MyClipperTop2(),
          height: 50,
          colors: const [Color(0xff10c6b1),Color(0xff2bd692)],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: _Forma(
            clipper: _MyClipperTop3(),
            height: 35,
            colors: const [Color(0xff10c6b1),Color(0xff2bd692)],
          ),  
        )
      ],
    );
  }
}

class _Forma extends StatelessWidget {

  final CustomClipper<Path> clipper;
  final List<Color> colors;
  final double height;
  const _Forma({Key? key, required this.clipper, required this.colors, required this.height,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context); 
    return ClipPath(
        clipper: clipper,
        child: Container(
          height: responsive.hp(height),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight
            ),
            
          ),
        ),
      );
  }
}


class _MyClipperTop1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.30, size.height * 0.60,size.width * 0.48, size.height * 0.35);
    path.quadraticBezierTo(size.width * 0.65, size.height * 0.10, size.width, size.height * 0.30);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class _MyClipperTop2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.25);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.10,size.width * 0.17, size.height * 0.23);
    path.quadraticBezierTo(size.width * 0.23, size.height * 0.35, size.width*0.30, size.height * 0.20);
    path.quadraticBezierTo(size.width * 0.35, size.height * 0.06, size.width*0.40, size.height * 0.10);
    path.quadraticBezierTo(size.width * 0.55, size.height * 0.20, size.width*0.70, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class _MyClipperTop3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.30, size.height * 0.63,size.width * 0.48, size.height * 0.47);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.25, size.width, size.height * 0.40);
    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}