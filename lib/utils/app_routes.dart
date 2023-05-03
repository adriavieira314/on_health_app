// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:on_health_app/components/patient_info.dart';
import 'package:on_health_app/pages/home/admin/menu_admin.dart';
import 'package:on_health_app/pages/home/user/menu_user.dart';
import 'package:on_health_app/pages/login/login.dart';

class AppRoutes {
  static const LOGIN = '/';
  static const HOME_USER = '/home_user';
  static const HOME_ADMIN = '/home_admin';
  static const PATIENT_INFO = '/patient_info';
}

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    AppRoutes.LOGIN: (ctx) => const Login(),
    AppRoutes.HOME_USER: (ctx) => const MenuUser(),
    AppRoutes.HOME_ADMIN: (ctx) => const MenuAdmin(),
    AppRoutes.PATIENT_INFO: (ctx) => const PatientInfo(),
  };

  static String initial = AppRoutes.LOGIN;

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
