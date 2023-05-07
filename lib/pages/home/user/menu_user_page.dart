import 'package:flutter/material.dart';
import 'package:on_health_app/components/app_bar_component.dart';
import 'package:on_health_app/components/app_drawer.dart';
import 'package:on_health_app/data/dumb_data.dart';
import 'package:on_health_app/pages/home/user/agendamentos_user_page.dart';
import 'package:on_health_app/pages/home/user/home_user_page.dart';

class MenuUserPage extends StatefulWidget {
  const MenuUserPage({super.key});

  @override
  State<MenuUserPage> createState() => _MenuUserPageState();
}

class _MenuUserPageState extends State<MenuUserPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeUserPage(),
    AgendamentosUserPage(),
  ];

  final Map<String, dynamic> info = userInfo;
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
