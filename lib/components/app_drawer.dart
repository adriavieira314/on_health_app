import 'package:flutter/material.dart';

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
          const Divider(),
          const ListTile(
            leading: Icon(Icons.person, size: 30.0),
            title: Text(
              'Perfil',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.settings, size: 30.0),
            title: Text(
              'Conta',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
