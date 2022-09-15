import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pos_system/auth_controller.dart';
import 'package:pos_system/login_page.dart';
import 'package:pos_system/signup_page.dart';
import 'package:pos_system/wellcome_page.dart';
import 'package:get/get.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LoginPage(),
    );
  }
}

