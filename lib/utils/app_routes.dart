// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:on_health_app/components/patient_info.dart';
import 'package:on_health_app/pages/auth_or_home_page.dart';
import 'package:on_health_app/pages/home/admin/menu_admin_page.dart';
import 'package:on_health_app/pages/home/user/menu_user_page.dart';

class AppRoutes {
  static const AUTH_OR_HOME = '/';
  static const HOME_USER = '/home_user';
  static const HOME_ADMIN = '/home_admin';
  static const PATIENT_INFO = '/patient_info';
}

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    AppRoutes.AUTH_OR_HOME: (ctx) => const AuthOrHomePage(),
    AppRoutes.HOME_USER: (ctx) => const MenuUserPage(),
    AppRoutes.HOME_ADMIN: (ctx) => const MenuAdminPage(),
    AppRoutes.PATIENT_INFO: (ctx) => const PatientInfo(),
  };

  static String initial = AppRoutes.AUTH_OR_HOME;

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
