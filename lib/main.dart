import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memory_lane/providers/memory_provider.dart';
import 'package:memory_lane/providers/user_profile_provider.dart';
import 'package:memory_lane/providers/user_provider.dart';
import 'package:memory_lane/screens/authentication/login_screen.dart';
import 'package:memory_lane/screens/authentication/register_screen.dart';
import 'package:memory_lane/screens/home_screen.dart';
import 'package:memory_lane/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'firebase_options_prod.dart' as prod;
import 'firebase_options_dev.dart' as dev;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isProd = bool.fromEnvironment('dart.vm.product');

  await Firebase.initializeApp(
    options: isProd
        ? prod.DefaultFirebaseOptions.currentPlatform
        : dev.DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider(AuthService(), UserProfileProvider()),),
            ChangeNotifierProvider<MemoryProvider>(create: (context) => MemoryProvider(),),
          ],
          child: MemoryLaneApp())
  );
}

class MemoryLaneApp extends StatelessWidget {
  const MemoryLaneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: "/login",
      routes: {
        "/login": (context) => LoginScreen(),
        "/register": (context) => RegisterScreen(),
        "/home": (context) => HomeScreen(),
      },
    );
  }
}