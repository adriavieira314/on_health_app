import 'package:flutter/material.dart';
import 'package:on_health_app/pages/home/admin/menu_admin_page.dart';
import 'package:on_health_app/pages/home/user/menu_user_page.dart';
import 'package:on_health_app/pages/login/login_page.dart';
import 'package:on_health_app/pages/select_municipio_page.dart';
import 'package:on_health_app/pages/server_page.dart';
import 'package:on_health_app/providers/auth_provider.dart';
import 'package:on_health_app/utils/constants.dart';
import 'package:provider/provider.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of(context);

    return serverURL == ''
        ? const ServerPage()
        : idIBGE == ''
            ? const SelectMunicipioPage()
            : FutureBuilder(
                future: auth.tryAutoLogout(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Scaffold(
                      body: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.error != null) {
                    return Scaffold(
                      body: Center(
                        child: Text('Ocorreu um erro!, ${snapshot.error}'),
                      ),
                    );
                  } else if (snapshot.data == true) {
                    return auth.isAdmin ? MenuAdminPage() : MenuUserPage();
                  } else {
                    return const LoginPage();
                  }
                },
              );
  }
}
