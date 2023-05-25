import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:on_health_app/components/app_bar_component.dart';
import 'package:on_health_app/components/app_drawer.dart';
import 'package:on_health_app/models/custom_notification.dart';
import 'package:on_health_app/pages/home/user/agendamentos_user_page.dart';
import 'package:on_health_app/pages/home/user/home_user_page.dart';
import 'package:on_health_app/providers/agendamentos_provider.dart';
import 'package:on_health_app/services/notification_service.dart';
import 'package:on_health_app/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(minutes: 1), (Timer t) => callAgendaEndpoint());
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
    print('hola, estoy aqui');
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // await prefs.remove('agendamentos');
    Provider.of<AgendamentosProvider>(
      context,
      listen: false,
    ).loadFake().then((value) async {
      final response = await Provider.of<AgendamentosProvider>(
        context,
        listen: false,
      ).listaFake;

      final String? agendamentos = await prefs.getString('agendamentos');

      if (agendamentos == null) {
        print('opa');
        final arrayAgendamento = [];
        for (var i = 0; i < response!.agendamentos!.length; i++) {
          final agendamentoGeral = response.agendamentos![i];

          for (var j = 0; j < agendamentoGeral.agendamentos!.length; j++) {
            final agendamento = agendamentoGeral.agendamentos![j];
            agendamento.pushSent = false;

            arrayAgendamento.add(agendamentoGeral.toJson());
          }
        }
        await prefs.setString('agendamentos', jsonEncode(arrayAgendamento));
        // final getAgenda = jsonDecode(getString!);
        getDate(arrayAgendamento);
        print(arrayAgendamento);
      } else {
        final novoArrayAgendamentos = [];

        final String? getString = await prefs.getString('agendamentos');
        final getAgenda = jsonDecode(getString!);

        for (var r = 0; r < response!.agendamentos!.length; r++) {
          final res = response.agendamentos![r];

          //! essa data existe? Sim? Ta aqui a array com todos os agendamentos dessa data
          //! data nao existe? adiciona o agendamento inteiro dessa data no novo array
          final dataExisteArray = getAgenda.firstWhere(
            (item) => item['dtAgenda'] == res.dtAgenda,
            orElse: () {
              for (var j = 0; j < res.agendamentos!.length; j++) {
                final agendamento = res.agendamentos![j];
                agendamento.pushSent = false;

                novoArrayAgendamentos.add(res.toJson());
              }
            },
          );

          if (dataExisteArray != null) {
            for (var a = 0; a < res.agendamentos!.length; a++) {
              final agenda = res.agendamentos![a];

              //! agendamento existe? Okay, passa reto
              //! agendamento nao existe? Adiciona a data
              dataExisteArray['agendamentos'].firstWhere(
                (item) => item['id'] == agenda.id,
                orElse: () {
                  agenda.pushSent = false;

                  dataExisteArray['agendamentos'].add(agenda.toJson());
                },
              );
            }
          }
          if (dataExisteArray != null) {
            novoArrayAgendamentos.add(dataExisteArray);
          }
        }
        await prefs.setString(
          'agendamentos',
          jsonEncode(novoArrayAgendamentos),
        );

        getDate(novoArrayAgendamentos);
      }

      // se prefs vazio, salvar objeto intiero com novo campo de checado como falso
      // se existe, percorer lista, verificar qual objeto nao existe e adicionar
      //12 min depois, o background chama novamente e verifica quem ja foi checado
    });
  }

  getDate(agenda) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final agendamento = agenda;

    for (var i = 0; i < agendamento.length; i++) {
      final element = agendamento[i];

      if (element['agendamentos'].length == 1) {
        //! se valor for false, mando a notificação e configuro para true
        //! para assim nao enviar mais notificações
        if (element['agendamentos'][0]['pushSent'] == false) {
          convert(element['dtAgenda'], element['agendamentos'][0]['hrAgenda']);
          element['agendamentos'][0]['pushSent'] = true;
        }
      } else {
        var count = 0;

        // ! setando cada objeto para true
        for (var a = 0; a < element['agendamentos'].length; a++) {
          if (element['agendamentos'][a]['pushSent'] == false) {
            count++;
            element['agendamentos'][a]['pushSent'] = true;
          }
        }

        //! se tiver mais de um como false, envio a notificação
        if (count > 0) {
          convert(element['dtAgenda'], '21:00');
        }
      }
    }

    // ! depois salvo essas mudanças no storage
    await prefs.setString(
      'agendamentos',
      jsonEncode(agendamento),
    );
  }

  convert(dateString, hour) {
    var string = dateString;
    var array = string.split('/');
    var newDate = '${array[2]}-${array[1]}-${array[0]} $hour';

    get24Hours(newDate, dateString);
  }

  get24Hours(dateFormatted, date) async {
    var dateParsed = DateTime.parse(dateFormatted);
    Duration difference = dateParsed.difference(DateTime.now());

    if (difference.inHours >= 20 && difference.inHours <= 24) {
      Provider.of<NotificationService>(context, listen: false).showNotification(
        CustomNotification(
          id: 1,
          title: 'Você tem uma consulta.',
          body: 'Não esqueça sua consulta no dia $date',
          payload: AppRoutes.AUTH_OR_HOME,
        ),
      );
    } else if (difference.inHours >= 44 && difference.inHours <= 48) {
      Provider.of<NotificationService>(context, listen: false).showNotification(
        CustomNotification(
          id: 2,
          title: 'Você tem uma consulta.',
          body: 'Não esqueça sua consulta no dia $date',
          payload: AppRoutes.AUTH_OR_HOME,
        ),
      );
    }
  }
}
