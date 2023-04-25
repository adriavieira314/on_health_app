import 'package:flutter/material.dart';
import 'package:on_health_app/pages/home/home_user.dart';
import 'package:on_health_app/pages/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'On Health',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green.shade900,
          secondary: Colors.white,
        ),
        useMaterial3: false,
      ),
      home: const HomeUser(),
    );
  }
}
