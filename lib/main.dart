import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoominghome/home.dart';
import 'package:zoominghome/signin.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // MediaQueryData windowData = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  // windowData = windowData.copyWith(textScaleFactor: 1.0,);
  SharedPreferences sp = await SharedPreferences.getInstance();
  bool isLogin = sp.getBool('login') ?? false;
  // sp.getBool('is_login') != null ? sp.getBool("is_login")! : false;
  // bool isID = sp.getString('user_id') != null ? true : false;

  await Future.delayed(const Duration(seconds: 3));
  runApp(
    MaterialApp(
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      home: isLogin ? HomePage() : SingIn(),
    ),);
}
