import 'package:flutter/material.dart';
import 'package:on_health_app/components/app_bar_component.dart';
import 'package:on_health_app/components/app_drawer.dart';
import 'package:on_health_app/data/dumb_data.dart';
import 'package:on_health_app/pages/home/user/agendamentos_user.dart';
import 'package:on_health_app/pages/home/user/home_user.dart';

class MenuUser extends StatefulWidget {
  const MenuUser({super.key});

  @override
  State<MenuUser> createState() => _MenuUserState();
}

class _MenuUserState extends State<MenuUser> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeUser(),
    AgendamentosUser(),
  ];

  final Map<String, String> info = userInfo;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarComponent(scaffoldKey: _scaffoldKey),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      drawer: const AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Agendamentos',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        iconSize: 35,
        unselectedFontSize: 16.0,
        selectedFontSize: 16.0,
        onTap: _onItemTapped,
      ),
    );
  }
}
