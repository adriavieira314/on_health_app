import 'package:flutter/material.dart';
import 'package:on_health_app/data/dumb_data.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const AppBarComponent({super.key, required this.scaffoldKey});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> info = userInfo;

    return AppBar(
      toolbarHeight: 80,
      leading: IconButton(
        icon: const Icon(Icons.menu, size: 30),
        onPressed: () => scaffoldKey.currentState!.openDrawer(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            info['nome']!,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              'CPF: ${info['cpf']!}',
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            radius: 25,
            child: const Text('AH'),
          ),
        )
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
      ),
      elevation: 0,
    );
  }
}
