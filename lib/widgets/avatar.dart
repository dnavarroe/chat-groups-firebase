import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvatarButton extends StatelessWidget {
  final double imageSize;
  final String imageurl;
  final void Function()? onPressed;
  final bool boton;
  const AvatarButton({super.key, this.imageSize = 100, this.onPressed, required this.imageurl, this.boton = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
     children: [
       Container(
         margin: const EdgeInsets.all(10),
         decoration: const BoxDecoration(
           color: Colors.white,
           shape: BoxShape.circle,
           boxShadow: [
             BoxShadow(
               blurRadius: 20,
               color: Colors.black26,
               offset: Offset(0, 20)
             ),
           ]
         ),
         child: ClipOval(
           child: imageurl == ''
           ? Image.network(
             'https://i.pinimg.com/564x/1b/aa/51/1baa516470fc278145718dd2048bdf6d.jpg',
             width: imageSize,
             height: imageSize,
           )
           :  Image.network(
             imageurl,
             width: imageSize,
             height: imageSize,
           )
         ),
       ),
       if(boton)
       Positioned(
         bottom: 5,
         right: 0,
         child: CupertinoButton(
           padding: const EdgeInsets.all(0),
           borderRadius: BorderRadius.circular(30),
           onPressed: onPressed,
           child: Container(
             padding: const EdgeInsets.all(3),
             decoration: BoxDecoration(
               border: Border.all(
                 color: Colors.white,
                 width: 2
               ),
               color: const Color(0xff222643),
               shape: BoxShape.circle
             ),
             child: const Icon(
               Icons.add,
               color: Colors.white,
             ),
           )
         ),
       ),
     ]);
  }
}