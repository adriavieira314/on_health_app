import 'package:flutter/material.dart';
import 'package:on_health_app/components/home/text_info.dart';
import 'package:on_health_app/data/dumb_data.dart';

class HomeUser extends StatelessWidget {
  const HomeUser({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final Map<String, String> user_info = userInfo;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextInfo(
                  label: 'Nascimento: ',
                  info: user_info['birthdate']!,
                ),
                const Divider(),
                TextInfo(
                  label: 'IMC: ',
                  info: user_info['imc']!,
                ),
                const Divider(),
                TextInfo(
                  label: 'Mãe: ',
                  info: user_info['parent']!,
                ),
                const Divider(),
                TextInfo(
                  label: 'Endereço: ',
                  info: user_info['street']!,
                ),
                const Divider(),
                TextInfo(
                  label: 'Bairro: ',
                  info: user_info['address']!,
                ),
              ],
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
                              child: Icon(Icons.bloodtype),
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
                              child: Icon(Icons.bloodtype),
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
                  height: 400, //height of TabBarView
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
                              info: user_info['address']!,
                            ),
                            const Divider(),
                            TextInfo(
                              label: 'Médico: ',
                              info: user_info['address']!,
                            ),
                            const Divider(),
                            TextInfo(
                              label: 'Último atendimento: ',
                              info: user_info['address']!,
                            ),
                            const Divider(),
                            TextInfo(
                              label: 'Valor da glicemia: ',
                              info: user_info['address']!,
                            ),
                            const Divider(),
                            TextInfo(
                              label: 'Medicação recebida: ',
                              info: user_info['address']!,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextInfo(
                              label: 'Unidade de Saúde: ',
                              info: user_info['address']!,
                            ),
                            const Divider(),
                            TextInfo(
                              label: 'Médico: ',
                              info: user_info['address']!,
                            ),
                            const Divider(),
                            TextInfo(
                              label: 'Último atendimento: ',
                              info: user_info['address']!,
                            ),
                            const Divider(),
                            TextInfo(
                              label: 'Valor da glicemia: ',
                              info: user_info['address']!,
                            ),
                            const Divider(),
                            TextInfo(
                              label: 'Medicação recebida: ',
                              info: user_info['address']!,
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
    );
  }
}
