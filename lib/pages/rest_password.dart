
import 'dart:ui';

import 'package:chat_firebase/pages/pages.dart';
import 'package:chat_firebase/services/services.dart';
import 'package:chat_firebase/utils/responsive.dart';
import 'package:chat_firebase/widgets/widgets.dart';

import 'package:flutter/material.dart';

class RestPage extends StatefulWidget {

  static String routeName = 'loginPage';
  
  const RestPage({Key? key}) : super(key: key);

  @override
  State<RestPage> createState() => _RestPageState();
}

class _RestPageState extends State<RestPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String email = "";
  AuthService authService = AuthService();
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
                      'Recover your', 
                      style: TextStyle(
                        fontSize: responsive.dp(5),
                        color: Colors.white,
                        ),
                      ),
                    Text(
                      'Password', 
                      style: TextStyle(
                        fontSize: responsive.dp(5),
                        color: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: responsive.hp(30), horizontal: responsive.wp(1.5)),
                child: _SingleCard(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: responsive.isTable?430:responsive.wp(90),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InputField( 
                            icon: const Icon(Icons.email, color: Colors.white,),
                            keyboardType: TextInputType.emailAddress,
                            label: 'EMAIL',
                            onChanged: (text){
                              setState(() {
                                email = text;
                              });
                            },
                            validator: (text) {
                              String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regExp  = RegExp(pattern);

                              return regExp.hasMatch(text ?? '')
                                ? null
                                : 'Invalid email';
                            } ,
                          ),
                          SizedBox(height: responsive.dp(5)),
                          //Buttom signin
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: responsive.wp(5)),
                            child: MaterialButton(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              onPressed: (){
                                rest();
                              },
                              color: const Color(0xff10c6b1),
                              child: Text(
                                'Rest password',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: responsive.dp(1.5)
                                ), 
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  )
                ),
              ),
              Positioned(
                left: responsive.wp(5),
                bottom: responsive.hp(7),
                child: Row(
                  children: [
                    TextButton(
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
                    ),

                    SizedBox(width: responsive.wp(40)),
                    
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
                  ],
                ),
              )
          ],
        ),
      )
    );
  }
  rest() async{
    if (_formKey.currentState!.validate()) {
      await authService.restPass(email).then((value) async {
        if (value==true) {
          showSnackbar(
            context, 
            const Color(0xff222643), 
            'Link para reestablecer enviado'
          );
          Navigator.pushReplacementNamed(context, LoginPage.routeName);
        } else {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Email invalid'),
                content: const Text('Write email correct'),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Text('Ok')),
                ],
              );
            },
          );
        }
      });
    }
  }
}

class _SingleCard extends StatelessWidget {

  final Widget child;

  const _SingleCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    

    final boxDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(177, 208, 245, 231)
       );

    return Container(
      height: responsive.hp(40),
      margin: const EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            decoration:  boxDecoration,
            child: child
          ),
        ),
      ),
    );
  }
}