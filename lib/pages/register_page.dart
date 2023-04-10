

import 'package:chat_firebase/pages/pages.dart';
import 'package:chat_firebase/utils/responsive.dart';
import 'package:chat_firebase/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {

  static String routeName = 'registerPage';
   
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children:  [
            const FormasR(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: responsive.hp(10), horizontal: responsive.wp(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Creat', 
                    style: TextStyle(
                      fontSize: responsive.dp(5),
                      color: Colors.white,
                      ),
                    ),
                  Text(
                    'Account', 
                    style: TextStyle(
                      fontSize: responsive.dp(5),
                      color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
            const RegisterForm(),
            Positioned(
              left: responsive.wp(5),
              bottom: responsive.hp(10),
              child: TextButton(
                onPressed: (){
                  Navigator.pushNamed(context, LoginPage.routeName);
                }, 
                child: Row(
                  children: [
                    Text(
                      'Sign in',
                      style: TextStyle(
                        
                        color: Colors.white,
                        fontSize: responsive.wp(4),
                      ),
                      
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,)
                  ],
                )
              )
            )
          ],
        ),
      )
    );
  }
}

