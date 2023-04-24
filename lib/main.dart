import 'package:flutter/material.dart';
import 'package:on_health_app/pages/login/login_usuario.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
      home: const LoginUsuario(),
    );
  }
}
