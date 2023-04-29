import 'package:flutter/material.dart';
import 'package:on_health_app/pages/home/admin/menu_admin.dart';
import 'package:on_health_app/pages/home/admin/patient_info.dart';
import 'package:on_health_app/pages/home/user/menu_user.dart';
import 'package:on_health_app/pages/login/login.dart';
import 'package:on_health_app/utils/app_routes.dart';

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
          secondary: Colors.blue.shade50,
        ),
        useMaterial3: false,
      ),
      routes: {
        AppRoutes.LOGIN: (ctx) => const Login(),
        AppRoutes.HOME_USER: (ctx) => const MenuUser(),
        AppRoutes.HOME_ADMIN: (ctx) => const MenuAdmin(),
        AppRoutes.PATIENT_INFO: (ctx) => const PatientInfo(),
      },
      // home: const MainComponent(),
    );
  }
}
