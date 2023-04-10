
import 'package:chat_firebase/helpers/helper_function.dart';
import 'package:chat_firebase/pages/pages.dart';
import 'package:chat_firebase/services/services.dart';
import 'package:chat_firebase/utils/responsive.dart';
import 'package:chat_firebase/widgets/widgets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String email = "";
  String password = "";
  bool _isLoading = false;
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return _isLoading
      ? Padding(
        padding: EdgeInsets.symmetric(vertical: responsive.hp(5), horizontal: responsive.wp(1.5)),
        child: SingleCard(
          tras: false,
          color: Colors.white,
          h: 90,
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(color: Color(0xff10c6b1)),
                  Text('Cogela Suave...', style: TextStyle(color: Colors.black),)
                ],
              ),
            ),
        ),
      )
      : Padding(
        padding: EdgeInsets.symmetric(vertical: responsive.hp(30), horizontal: responsive.wp(1.5)),
        child: SingleCard(
        tras: true,
        color: const Color.fromARGB(177, 208, 245, 231),
        h: 40,
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
                SizedBox(height: responsive.dp(3)),
                InputField(
                  icon: const Icon(Icons.key_outlined, color: Colors.white,),
                  obscureText: true,
                  label: 'PASSWORD',
                  onChanged: (value){
                    setState(() {
                      password = value;
                    });
                  },
                  validator: (text) {
                    if( text != null && text.length>= 6) return null;
                    return 'La contraseña debe ser de 6 caracteres';
                  } ,

                ),
                SizedBox(height: responsive.dp(5),),
                  //Buttom signin
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: responsive.wp(5)),
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    onPressed: (){
                      FocusScope.of(context).unfocus();
                      login();
                    },
                    color: const Color(0xff10c6b1),
                    child: Text(
                      'Sign in',
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
      );
  }

  login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .loginUserWithEmailAndPassword(email, password)
          .then((value) async {
        if(value==true){
          QuerySnapshot snapshot = await DatabaseService(FirebaseAuth.instance.currentUser!.uid).gettingUserData(email);

          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(snapshot.docs[0]['username']); 


          Navigator.pushReplacementNamed(context, HomeChat.routeName);
        }else{
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}




