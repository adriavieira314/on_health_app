import 'package:flutter/material.dart';
import 'package:on_health_app/pages/home/admin/menu_admin_page.dart';
import 'package:on_health_app/pages/home/user/menu_user_page.dart';
import 'package:on_health_app/pages/login/login_page.dart';
import 'package:on_health_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of(context);

    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.error != null) {
          return const Center(
            child: Text('Ocorreu um erro!'),
          );
        } else {
          return auth.hasToken
              ? auth.isAdmin
                  ? MenuAdminPage()
                  : MenuUserPage()
              : const LoginPage();
        }
      },
    );
  }
}
