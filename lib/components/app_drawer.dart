import 'package:flutter/material.dart';
import 'package:on_health_app/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Bem Vindo(a)'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.logout, size: 30.0),
            title: const Text(
              'Logout',
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.LOGIN);
            },
          ),
        ],
      ),
    );
  }
}
