import 'dart:async';

import 'package:flutter/material.dart';
import 'package:on_health_app/components/app_bar_component.dart';
import 'package:on_health_app/components/app_drawer.dart';
import 'package:on_health_app/models/agendamentos.dart';
import 'package:on_health_app/models/custom_notification.dart';
import 'package:on_health_app/pages/home/user/agendamentos_user_page.dart';
import 'package:on_health_app/pages/home/user/home_user_page.dart';
import 'package:on_health_app/providers/agendamentos_provider.dart';
import 'package:on_health_app/services/notification_service.dart';
import 'package:on_health_app/utils/app_routes.dart';
import 'package:on_health_app/utils/constants.dart';
import 'package:provider/provider.dart';

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

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ocorreu um Erro'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      callAgendaEndpoint();
      cancelTimer = Timer.periodic(
        Duration(minutes: tempoBuscaAgenda),
        (Timer t) => callAgendaEndpoint(),
      );
    }
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

  callAgendaEndpoint() async {
    Provider.of<AgendamentosProvider>(
      context,
      listen: false,
    ).loadAgendamentosUsuario().then((value) async {
      final response = await Provider.of<AgendamentosProvider>(
        context,
        listen: false,
      ).listaAgendamentosUsuario;

      if (response == null) return;
      print(response.toJson());

      getDate(response);
    });
  }

  getDate(ListaAgendamentos agenda) async {
    for (var i = 0; i < agenda.agendamentos!.length; i++) {
      final element = agenda.agendamentos![i];

      for (var a = 0; a < element.agendamentos!.length; a++) {
        final agdmt = element.agendamentos![a];
        if (agdmt.stNotificacao == 0) {
          convert(element.dtAgenda, agdmt.hrAgenda, agdmt.cpf, agdmt.id);
        }
      }
    }
  }

  convert(dateString, hour, cpf, id) {
    var string = dateString;
    var array = string.split('/');
    var newDate = '${array[2]}-${array[1]}-${array[0]} $hour';

    get24Hours(newDate, dateString, cpf, id);
  }

  get24Hours(dateFormatted, date, cpf, id) async {
    var dateParsed = DateTime.parse('2023-09-27 23:00');
    Duration difference = dateParsed.difference(DateTime.now());

    if (difference.inHours >= 20 && difference.inHours <= 24) {
      AgendamentosProvider agendamentos = Provider.of(context, listen: false);

      agendamentos.changeNotificacaoStatus(id, cpf).then(
            (value) => {
              Provider.of<NotificationService>(context, listen: false)
                  .showNotification(
                CustomNotification(
                  id: 1,
                  title: 'Você tem uma consulta.',
                  body: 'Não esqueça sua consulta no dia $date',
                  payload: AppRoutes.AUTH_OR_HOME,
                ),
              )
            },
            onError: (error) => {
              _showErrorDialog(error.toString()),
            },
          );
    }
    // if (difference.inHours >= 44 && difference.inHours <= 48) {

    //   Provider.of<NotificationService>(context, listen: false).showNotification(
    //     CustomNotification(
    //       id: 2,
    //       title: 'Você tem uma consulta.',
    //       body: 'Não esqueça sua consulta no dia $date',
    //       payload: AppRoutes.AUTH_OR_HOME,
    //     ),
    //   );
    // }
  }
}
