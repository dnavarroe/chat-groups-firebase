
import 'package:chat_firebase/helpers/helper_function.dart';
import 'package:chat_firebase/pages/pages.dart';
import 'package:chat_firebase/services/services.dart';
import 'package:chat_firebase/utils/responsive.dart';
import 'package:chat_firebase/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  String username = "";
  String email = "";
  String password = "";
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
          padding: EdgeInsets.symmetric(vertical: responsive.hp(25), horizontal: responsive.wp(1.5)),
          child: SingleCard(
              tras: true,
              color: const Color.fromARGB(177, 208, 245, 231),
              h: 50,
              child: Container(
              constraints: BoxConstraints(
                maxWidth: responsive.isTable ? 430 : responsive.wp(90),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputField(
                      icon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      label: 'USERNAME',
                      onChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                      validator: (text) {
                        if (text != null && text.trim().length < 5) {
                          return 'Invalid username';
                        }
                      },
                    ),
                    SizedBox(height: responsive.dp(3)),
                    InputField(
                      icon: const Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      label: 'EMAIL',
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      validator: (text) {
                        String pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regExp = RegExp(pattern);

                        return regExp.hasMatch(text ?? '')
                            ? null
                            : 'Invalid email';
                      },
                    ),
                    SizedBox(height: responsive.dp(3)),
                    InputField(
                      icon: const Icon(
                        Icons.key_outlined,
                        color: Colors.white,
                      ),
                      obscureText: true,
                      label: 'PASSWORD',
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      validator: (text) {
                        if (text != null && text.length >= 6) return null;
                        return 'La contraseña debe ser de 6 caracteres';
                      },
                    ),
                    SizedBox(
                      height: responsive.dp(5),
                    ),
                    //Buttom signin
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: responsive.wp(5)),
                      child: MaterialButton(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          register();
                        },
                        color: const Color(0xff10c6b1),
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              color: Colors.white, fontSize: responsive.dp(1.5)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
        );
  }

  register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailAndPassword(username, email, password)
          .then((value) async {
        if(value==true){
          // saving the shared preference state
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(username); 
          // ignore: use_build_context_synchronously
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


