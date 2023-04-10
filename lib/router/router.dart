
import 'package:chat_firebase/pages/pages.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  LoginPage.routeName:(_) => const LoginPage(),
  RegisterPage.routeName:(_) => const RegisterPage(),
  HomeChat.routeName :(_) => const HomeChat(),
  SearchPage.routeName :(_) => const SearchPage(),
};