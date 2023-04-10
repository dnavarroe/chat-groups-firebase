import 'package:chat_firebase/utils/responsive.dart';
import 'package:flutter/material.dart';

class FormasR extends StatelessWidget {
  const FormasR({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _Forma(
          clipper: _MyClipperTop3(),
          height: 100,
          colors: const [Color(0xff10c6b1),Color(0xff2bd692)],
        ),
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
    path.lineTo(0, size.height * 0.40);
    path.quadraticBezierTo(size.width * 0.30, size.height * 0.60,size.width * 0.50, size.height * 0.35);
    path.quadraticBezierTo(size.width * 0.65, size.height * 0.15, size.width, size.height * 0.20);
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
    path.moveTo(size.width*0.1, 0);
    path.quadraticBezierTo(size.width * 0.30, size.height * 0.20,size.width * 0.60, 0);
    path.lineTo(size.width*0.80, 0);
    path.quadraticBezierTo(size.width * 0.82, size.height * 0.25, size.width, size.height * 0.20);
    path.lineTo(size.width, 0);
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
    path.lineTo(0, size.height * 0.90);
    path.quadraticBezierTo(size.width * 0.40, size.height+size.height*0.10 ,size.width, size.height * 0.65);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}