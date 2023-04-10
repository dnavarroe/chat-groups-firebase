
import 'package:chat_firebase/pages/pages.dart';
import 'package:chat_firebase/utils/responsive.dart';
import 'package:chat_firebase/widgets/widgets.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  static String routeName = 'loginPage';
  
  const LoginPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            const FormasL(),
            Padding(
                padding: EdgeInsets.symmetric(vertical: responsive.hp(15), horizontal: responsive.wp(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome', 
                      style: TextStyle(
                        fontSize: responsive.dp(5),
                        color: Colors.white,
                        ),
                      ),
                    Text(
                      'Back', 
                      style: TextStyle(
                        fontSize: responsive.dp(5),
                        color: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),
              const LoginForm(),
              Positioned(
                left: responsive.wp(5),
                bottom: responsive.hp(7),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, RegisterPage.routeName);
                      }, 
                      child: Row(
                        children: [
                          Text(
                            'Sign up',
                            style: TextStyle(
      
                              color: Colors.white,
                              fontSize: responsive.wp(4),
                            ),
      
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,)
                        ],
                      )
                    ),
                    SizedBox(width: responsive.wp(30)),
                    TextButton(
                      onPressed: (){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => const RestPage(),
                          )
                        );
                      }, 
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: responsive.wp(4),
                        ),
                      )
                    ),
                  ],
                ),
              )
          ],
        ),
      )
    );
  }
}

