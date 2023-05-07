import 'package:flutter/material.dart';
import 'package:on_health_app/components/home/text_info.dart';
import 'package:on_health_app/data/dumb_data.dart';
import 'package:on_health_app/models/custom_notification.dart';
import 'package:on_health_app/services/notification_service.dart';
import 'package:on_health_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

class HomeUserPage extends StatefulWidget {
  const HomeUserPage({super.key});

  @override
  State<HomeUserPage> createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  bool valor = false;

  showNotification() {
    valor = !valor;
    if (valor) {
      Provider.of<NotificationService>(context, listen: false)
          .showNotificationScheduled(
        CustomNotification(
          id: 1,
          title: 'Teste',
          body: 'Acesse o app!',
          payload: AppRoutes.PATIENT_INFO,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> info = userInfo;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextInfo(
                    label: 'Nascimento: ',
                    info: info['birthdate']!,
                  ),
                  const Divider(),
                  TextInfo(
                    label: 'IMC: ',
                    info: info['imc']!,
                  ),
                  const Divider(),
                  TextInfo(
                    label: 'Mãe: ',
                    info: info['parent']!,
                  ),
                  const Divider(),
                  TextInfo(
                    label: 'Endereço: ',
                    info: info['street']!,
                  ),
                  const Divider(),
                  TextInfo(
                    label: 'Bairro: ',
                    info: info['address']!,
                  ),
                ],
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Lembrar-me mais tarde'),
                trailing: valor
                    ? Icon(Icons.check_box, color: Colors.amber.shade600)
                    : const Icon(Icons.check_box_outline_blank),
                onTap: showNotification,
              ),
            ),
            DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: Colors.blue.shade50,
                    child: const TabBar(
                      labelColor: Colors.green,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.bloodtype_outlined),
                              ),
                              Text(
                                'Diabetes',
                                style: TextStyle(fontSize: 22.0),
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.monitor_heart_outlined),
                              ),
                              Text(
                                'Hipertensão',
                                style: TextStyle(fontSize: 22.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 300, //height of TabBarView
                    decoration: const BoxDecoration(
                      // color: Colors.red,
                      border: Border(
                        top: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TabBarView(
                        children: [
                          Column(
                            children: [
                              TextInfo(
                                label: 'Unidade de Saúde: ',
                                info: info['lastAppointment']!['ubs']!,
                              ),
                              const Divider(),
                              TextInfo(
                                label: 'Médico: ',
                                info: info['lastAppointment']!['doctor']!,
                              ),
                              const Divider(),
                              TextInfo(
                                label: 'Último atendimento: ',
                                info: info['lastAppointment']!['date']!,
                              ),
                              const Divider(),
                              TextInfo(
                                label: 'Valor da glicemia: ',
                                info: info['glicemia']!,
                              ),
                              const Divider(),
                              TextInfo(
                                label: 'Medicação recebida: ',
                                info: info['medication']!,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              TextInfo(
                                label: 'Unidade de Saúde: ',
                                info: info['lastAppointment']!['ubs']!,
                              ),
                              const Divider(),
                              TextInfo(
                                label: 'Médico: ',
                                info: info['lastAppointment']!['doctor']!,
                              ),
                              const Divider(),
                              TextInfo(
                                label: 'Último atendimento: ',
                                info: info['lastAppointment']!['date']!,
                              ),
                              const Divider(),
                              TextInfo(
                                label: 'Valor da glicemia: ',
                                info: info['glicemia']!,
                              ),
                              const Divider(),
                              TextInfo(
                                label: 'Medicação recebida: ',
                                info: info['medication']!,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
