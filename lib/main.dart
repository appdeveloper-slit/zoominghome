import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoominghome/home.dart';
import 'package:zoominghome/notifications.dart';
import 'package:zoominghome/signin.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // MediaQueryData windowData = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  // windowData = windowData.copyWith(textScaleFactor: 1.0,);
  SharedPreferences sp = await SharedPreferences.getInstance();
  bool isLogin = sp.getBool('login') ?? false;
  // sp.getBool('is_login') != null ? sp.getBool("is_login")! : false;
  // bool isID = sp.getString('user_id') != null ? true : false;
  OneSignal.shared.setAppId('cae3483f-464a-4ef9-b9e1-a772c3968ba9');
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  OneSignal.shared.setNotificationOpenedHandler((value) {
    navigatorKey.currentState!.push(
      MaterialPageRoute(
        builder: (context) => NotificationPage(),
      ),
    );
  });
  await Future.delayed(const Duration(seconds: 3));
  runApp(
    MaterialApp(
      navigatorKey: navigatorKey,
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      home: isLogin ? HomePage() : SingIn(),
    ),);
}
