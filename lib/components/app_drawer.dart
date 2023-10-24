import 'package:flutter/material.dart';
import 'package:on_health_app/providers/auth_provider.dart';
import 'package:on_health_app/utils/app_routes.dart';
import 'package:on_health_app/utils/constants.dart';
import 'package:provider/provider.dart';

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
          // const Divider(),
          // const ListTile(
          //   leading: Icon(Icons.person, size: 30.0),
          //   title: Text(
          //     'Perfil',
          //     style: TextStyle(fontSize: 18.0),
          //   ),
          // ),
          // const Divider(),
          ListTile(
            leading: Icon(Icons.description_outlined, size: 30.0),
            title: Text(
              'Sobre',
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(
                AppRoutes.SOBRE,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, size: 30.0),
            title: const Text(
              'Logout',
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              cancelTimer != null ? cancelTimer.cancel() : '';
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.AUTH_OR_HOME,
              );
            },
          ),
        ],
      ),
    );
  }
}
